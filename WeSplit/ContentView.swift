//
//  ContentView.swift
//  WeSplit
//
//  Created by Vinicius Ledis on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var valorTotal = 0.0
    @State private var numeroDePessoas = 2
    @State private var gorjeta = 20
    @FocusState private var emFoco: Bool
    
    let gorjetas = [0, 10, 15, 20, 25]
    
    var totalPorPessoa: Double {
        let pessoasDouble = Double(numeroDePessoas + 2)
        let gorjetaDouble = Double(gorjeta)
        
        let valorGorjeta = valorTotal / 100 * gorjetaDouble
        let totalFinal = valorTotal + valorGorjeta
        let valorPorPessoa = totalFinal / pessoasDouble
        
        return valorPorPessoa
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Valor da Conta", value: $valorTotal, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        .keyboardType(.decimalPad)
                        .focused($emFoco)
                    
                    Picker("Quantidade de Pessoas", selection: $numeroDePessoas) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }
                }
                Section("Porcentagem da Gorjeta") {
                    Picker("Gorjeta", selection: $gorjeta) {
                        ForEach(gorjetas, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total por Pessoa") {
                    Text(totalPorPessoa, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        .foregroundStyle(gorjeta == 0 ? .red : .black)
                        
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if emFoco {
                    Button("Pronto") {
                        emFoco = false
                    }
                }
            }
            }
        }
}

#Preview {
    ContentView()
}
