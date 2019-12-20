Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FB624680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTMfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:35:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:51326 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727269AbfLTMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:35:31 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-53-mHZeSO_DN06nS6FxGvPlkg-1; Fri, 20 Dec 2019 12:35:28 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Dec 2019 12:35:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Dec 2019 12:35:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Brian Gerst' <brgerst@gmail.com>
CC:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Oleg Nesterov" <oleg@redhat.com>
Subject: RE: [PATCH] x86: Remove force_iret()
Thread-Topic: [PATCH] x86: Remove force_iret()
Thread-Index: AQHVtuhWtS7aVpT6VkyrDyqz06b2R6fCyteggAAmZACAAAPDAA==
Date:   Fri, 20 Dec 2019 12:35:27 +0000
Message-ID: <e7ad139dcf5b4025b516eb147cba79fa@AcuMS.aculab.com>
References: <20191219115812.102620-1-brgerst@gmail.com>
 <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
 <CAMzpN2if2m4McWpL49U4QAEM1MJ+qgTe-emN8vKcjVc1H+84vA@mail.gmail.com>
 <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
 <CAMzpN2i+DrKkzDyiS6Cj61LmCu+--e5puQpKrNxYVMDRPMvvBw@mail.gmail.com>
In-Reply-To: <CAMzpN2i+DrKkzDyiS6Cj61LmCu+--e5puQpKrNxYVMDRPMvvBw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: mHZeSO_DN06nS6FxGvPlkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQnJpYW4gR2Vyc3QNCj4gU2VudDogMjAgRGVjZW1iZXIgMjAxOSAxMjoxOA0KLi4uDQo+
ID4gSXMgaXQgZXZlciBwb3NzaWJsZSBmb3IgYW55IG9mIHRoZSBzZWdtZW50IHJlZ2lzdGVycyB0
byByZWZlciB0byB0aGUgTERUDQo+ID4gYW5kIGZvciBhbm90aGVyIHRocmVhZCB0byBpbnZhbGlk
YXRlIHRoZSBlbnRyaWVzICd2ZXJ5IGxhdGUnID8NCj4gPiBTbyBldmVuIHRob3VnaCB0aGUgdmFs
dWVzIHdlcmUgdmFsaWQgd2hlbiBjaGFuZ2VkLCB0aGV5IGFyZQ0KPiA+IGludmFsaWQgZHVyaW5n
IHRoZSAncmV0dXJuIHRvIHVzZXInIHNlcXVlbmNlLg0KPiANCj4gTm90IGluIHRoZSBTWVNSRVQg
Y2FzZSwgd2hlcmUgdGhlIGtlcm5lbCByZXF1aXJlcyB0aGF0IENTIGFuZCBTUyBhcmUNCj4gc3Rh
dGljIHNlZ21lbnRzIGluIHRoZSBHRFQuICBBbnkgdXNlcnNwYWNlIGNvbnRleHQgdGhhdCB1c2Vz
IExEVA0KPiBzZWdtZW50cyBmb3IgQ1MvU1MgbXVzdCByZXR1cm4gd2l0aCBJUkVULiAgVGhlcmUg
aXMgZmF1bHQgaGFuZGxpbmcgZm9yDQo+IElSRVQgKGZpeHVwX2JhZF9pcmV0KCkpIGZvciB0aGlz
IGNhc2UuDQoNCk9rIC0gSXQgaXMgYSBsb25nIHRpbWUgc2luY2UgaSBsb29rZWQgYXQgdGhlc2Ug
J3N5c2NhbGwnIGluc3RydWN0aW9ucy4NCg0KLi4uDQo+ID4gSXMgaXQgYWN0dWFsbHkgY2hlYXBl
ciB0byBwcm9wZXJseSB2YWxpZGF0ZSB0aGUgc2VnbWVudCByZWdpc3RlcnMsDQo+ID4gb3IgdGFr
ZSB0aGUgJ2hpdCcgb2YgdGhlIHNsaWdodGx5IHNsb3dlciBJUkVUIHBhdGggYW5kIGdldCB0aGUg
Y3B1DQo+ID4gdG8gZG8gaXQgZm9yIHlvdT8NCj4gDQo+IFNZU1JFVCBpcyBmYXN0ZXIgYmVjYXVz
ZSBpdCBhdm9pZHMgc2VnbWVudCB0YWJsZSBsb29rdXBzIGFuZA0KPiBwZXJtaXNzaW9uIGNoZWNr
cyBmb3IgQ1MgYW5kIFNTLiAgSXQgc2ltcGx5IHNldHMgdGhlIHNlbGVjdG9ycyB0bw0KPiB2YWx1
ZXMgc2V0IGluIGFuIE1TUiBhbmQgdGhlIGF0dHJpYnV0ZXMgKGJhc2UsIGxpbWl0LCBldGMuKSB0
byBmaXhlZA0KPiB2YWx1ZXMuICBJdCBpcyB1cCB0byB0aGUgT1MgdG8gbWFrZSBzdXJlIHRoZSBh
Y3R1YWwgc2VnbWVudA0KPiBkZXNjcmlwdG9ycyBpbiBtZW1vcnkgbWF0Y2ggdGhvc2UgZGVmYXVs
dCBhdHRyaWJ1dGVzLg0KDQpJIHdvbmRlciBob3cgbXVjaCBkaWZmZXJlbmNlIHRoYXQgbWFrZSB3
aGVuICdwYWdlIHRhYmxlIHNlcGFyYXRpb24nDQppcyB1c2VkPw0KDQpJIGd1ZXNzIHRoZSBsb2Fk
aW5nIG9mIGRzL2VzL2ZzL2dzIGNhbiBmYXVsdCAtIGJ1dCB0aGF0IGl0IG5vIGhhcmRlcg0KdG8g
aGFuZGxlIHRoYW4gaW4gdGhlIElSRVQgY2FzZS4NCg0KCURhdmlkDQoNCkFueXdheSwgb2ZmIHVu
dGlsIHRoZSBuZXcgeWVhciBub3cuDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

