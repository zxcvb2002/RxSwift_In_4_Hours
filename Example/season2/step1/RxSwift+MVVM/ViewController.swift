//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    /*
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)

        let url = URL(string: MEMBER_LIST_URL)!
        let data = try! Data(contentsOf: url)
        let json = String(data: data, encoding: .utf8)
        self.editView.text = json
            
        self.setVisibleWithAnimation(self.activityIndicator, false)
    }
    
    */
    
    /*
    
    // MARK: SYNC -> ASYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        self.setVisibleWithAnimation(self.activityIndicator, true)
        
        DispatchQueue.global().async {
            let url = URL(string: MEMBER_LIST_URL)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)
            
            DispatchQueue.main.async {
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            }
        }
    }
    
    */
    
    /*
    
    // MARK: ASYNC - Closure(completion) (@escaping or Optional)
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        downloadJson(MEMBER_LIST_URL) { json in
            self.editView.text = json
            self.setVisibleWithAnimation(self.activityIndicator, false)
        }
        
            self.downloadJson(MEMBER_LIST_URL) { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            }
    }
    
    func downloadJson(_ url: String, _ completion: /*@escaping*/ ((String?) -> Void)?) {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let data = try! Data(contentsOf: url)
            let json = String(data: data, encoding: .utf8)
            
            DispatchQueue.main.async {
                completion?(json)
            }
        }
    }
    
    */
    
    /*
    
    // MARK: ASYNC - Value(return)
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        let json: laterGeneratedData<String?> = downloadJson(MEMBER_LIST_URL)
        
        json.laterComed { json in
            self.editView.text = json
            self.setVisibleWithAnimation(self.activityIndicator, false)
        }
    }
    
    func downloadJson(_ url: String) -> laterGeneratedData<String?> {
        return laterGeneratedData() { f in
            DispatchQueue.global().async {
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)
                
                DispatchQueue.main.async {
                    f(json)
                }
            }
        }
    }
    
    */
    
    /*
    
    // MARK: ASYNC - Promise(Kit) / Bolt
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        downloadJson(MEMBER_LIST_URL)
            .then { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
        }
    }
    
    func downloadJson(_ url: String) -> laterGeneratedData<String?> {
        return laterGeneratedData() { f in
            DispatchQueue.global().async {
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)
                
                DispatchQueue.main.async {
                    f(json)
                }
            }
        }
    }
    
    */
    
    /*
    
    // MARK: ASYNC - import RxSwift (Reference Cycle)
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        // 2. Observable로 오는 데이터를 받아서 처리하는 방법
        
        /*
        
        let observable = downloadJson(MEMBER_LIST_URL)
        
        /*let disposable = */observable.subscribe { event in
            switch event {
            case .next(let json):
                break
                
            case .completed:
                break
            case .error(let err):
                break
            }
            
            // disposable.dispose()
        }
        
        */
        
        /*
        
        /*_ = */downloadJson(MEMBER_LIST_URL) // let disposable = downloadJson(MEMBER_LIST_URL)
            // .debug()
            .subscribe { /*[weak self]*/ event in
                switch event {
                case .next(let json):
                    self/*?*/.editView.text = json
                    self/*?*/.setVisibleWithAnimation(self/*?*/.activityIndicator, false)
                
                case .completed:
                    break
                case.error:
                    break
                }
            }
        // disposable.dispose()
        
        */
        
    }
    
    func downloadJson(_ url: String) -> Observable<String?> {
     
        // 1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
        
        /*
        
        return Observable.create() { emitter in
            
            /*
             
            emitter.onNext("Hello")
            emitter.onNext("World")
            emitter.onCompleted()
            
            */
            
            /*
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let datum = data, let json = String(data: datum, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposable.create() {
                task.cancel()
            }
            
            */
            
        }
        
        */
        
        /*
        
        return Observable.create() { f in
            DispatchQueue.global().async {
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)
                
                DispatchQueue.main.async {
                    f.onNext(json)
                    // f.onCompleted()
                }
            }
            return Disposables.create()
        }
        
        */
     
    }
    
    */
    
    /*
    
    // MARK: ASYNC - export RxSwift
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        downloadJson(MEMBER_LIST_URL)
            .subscribe { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            }
    }
    
    func downloadJson(_ url: String) -> Observable<String?> {
        return Observable { f in
            DispatchQueue.global().async {
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)
                
                DispatchQueue.main.async {
                    f(json)
                }
            }
        }
    }
    
    */
    
}

// MARK: Observable

class Observable<T> {
    private let task: (@escaping (T) -> Void) -> Void
    
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    func subscribe(_ f: @escaping (T) -> Void) {
        task(f)
    }
}
