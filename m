Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C598C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2642D2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfLTKKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:10:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58149 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfLTKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:10:15 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-133-yPtZzMMDPiugfTa6rRJszw-1; Fri, 20 Dec 2019 10:10:11 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Dec 2019 10:10:10 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Dec 2019 10:10:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Brian Gerst' <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH] x86: Remove force_iret()
Thread-Topic: [PATCH] x86: Remove force_iret()
Thread-Index: AQHVtuhWtS7aVpT6VkyrDyqz06b2R6fCyteg
Date:   Fri, 20 Dec 2019 10:10:10 +0000
Message-ID: <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
References: <20191219115812.102620-1-brgerst@gmail.com>
 <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
 <CAMzpN2if2m4McWpL49U4QAEM1MJ+qgTe-emN8vKcjVc1H+84vA@mail.gmail.com>
In-Reply-To: <CAMzpN2if2m4McWpL49U4QAEM1MJ+qgTe-emN8vKcjVc1H+84vA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: yPtZzMMDPiugfTa6rRJszw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQnJpYW4gR2Vyc3QNCj4gU2VudDogMjAgRGVjZW1iZXIgMjAxOSAwMzo0OA0KPiBPbiBU
aHUsIERlYyAxOSwgMjAxOSBhdCA4OjUwIFBNIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgRGVjIDE5LCAyMDE5IGF0IDM6NTggQU0gQnJp
YW4gR2Vyc3QgPGJyZ2Vyc3RAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBmb3JjZV9p
cmV0KCkgd2FzIG9yaWdpbmFsbHkgaW50ZW5kZWQgdG8gcHJldmVudCB0aGUgcmV0dXJuIHRvIHVz
ZXIgbW9kZSB3aXRoDQo+ID4gPiB0aGUgU1lTUkVUIG9yIFNZU0VYSVQgaW5zdHJ1Y3Rpb25zLCBp
biBjYXNlcyB3aGVyZSB0aGUgcmVnaXN0ZXIgc3RhdGUgY291bGQNCj4gPiA+IGhhdmUgYmVlbiBj
aGFuZ2VkIHRvIGJlIGluY29tcGF0aWJsZSB3aXRoIHRob3NlIGluc3RydWN0aW9ucy4NCj4gPg0K
PiA+IEl0J3MgbW9yZSB0aGFuIHRoYXQuICBCZWZvcmUgdGhlIGJpZyBzeXNjYWxsIHJld29yaywg
d2UgZGlkbid0IHJlc3RvcmUNCj4gPiB0aGUgY2FsbGVyLXNhdmVkIHJlZ3MuICBTZWU6DQo+ID4N
Cj4gPiBjb21taXQgMjFkMzc1YjZiMzRmZjUxMWE1MDdkZTI3YmYzMTZiM2RkZTY5MzhkOQ0KPiA+
IEF1dGhvcjogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+ID4gRGF0ZTogICBT
dW4gSmFuIDI4IDEwOjM4OjQ5IDIwMTggLTA4MDANCj4gPg0KPiA+ICAgICB4ODYvZW50cnkvNjQ6
IFJlbW92ZSB0aGUgU1lTQ0FMTDY0IGZhc3QgcGF0aA0KPiA+DQo+ID4gU28gaWYgeW91IGNoYW5n
ZWQgcjEyLCBmb3IgZXhhbXBsZSwgdGhlIGNoYW5nZSB3b3VsZCBnZXQgbG9zdC4NCj4gDQo+IGZv
cmNlX2lyZXQoKSBzcGVjaWZpY2FsbHkgZGVhbHQgd2l0aCBjaGFuZ2VzIHRvIENTLCBTUyBhbmQg
RUZMQUdTLg0KPiBTYXZpbmcgYW5kIHJlc3RvcmluZyB0aGUgZXh0cmEgcmVnaXN0ZXJzIHdhcyBh
IGRpZmZlcmVudCBwcm9ibGVtDQo+IGFsdGhvdWdoIGl0IGFmZmVjdGVkIHRoZSBzYW1lIGZ1bmN0
aW9ucyBsaWtlIHB0cmFjZSwgc2lnbmFscywgYW5kDQo+IGV4ZWMuDQoNCklzIGl0IGV2ZXIgcG9z
c2libGUgZm9yIGFueSBvZiB0aGUgc2VnbWVudCByZWdpc3RlcnMgdG8gcmVmZXIgdG8gdGhlIExE
VA0KYW5kIGZvciBhbm90aGVyIHRocmVhZCB0byBpbnZhbGlkYXRlIHRoZSBlbnRyaWVzICd2ZXJ5
IGxhdGUnID8NCg0KU28gZXZlbiB0aG91Z2ggdGhlIHZhbHVlcyB3ZXJlIHZhbGlkIHdoZW4gY2hh
bmdlZCwgdGhleSBhcmUNCmludmFsaWQgZHVyaW5nIHRoZSAncmV0dXJuIHRvIHVzZXInIHNlcXVl
bmNlLg0KDQpJIHJlbWVtYmVyIHdyaXRpbmcgYSBzaWduYWwgaGFuZGxlciB0aGF0ICdjb3JydXB0
ZWQnIGFsbCB0aGUNCnNlZ21lbnQgcmVnaXN0ZXJzIChldGMpIGFuZCBmaXhpbmcgdGhlIE5ldEJT
RCBrZXJuZWwgdG8gaGFuZGxlDQphbGwgdGhlIGZhdWx0cyByZXN0b3JpbmcgdGhlIHNlZ21lbnQg
cmVnaXN0ZXJzIGFuZCBJUkVUIGZhdWx0aW5nDQppbiBrZXJuZWwgKElJUkMgaW52YWxpZCB1c2Vy
ICVTUyBvciAlQ1MpLg0KKElSRVQgY2FuIGFsc28gZmF1bHQgaW4gdXNlciBzcGFjZSwgYnV0IHRo
YXQgaXMgYSBub3JtYWwgZmF1bHQuKQ0KDQpJcyBpdCBhY3R1YWxseSBjaGVhcGVyIHRvIHByb3Bl
cmx5IHZhbGlkYXRlIHRoZSBzZWdtZW50IHJlZ2lzdGVycywNCm9yIHRha2UgdGhlICdoaXQnIG9m
IHRoZSBzbGlnaHRseSBzbG93ZXIgSVJFVCBwYXRoIGFuZCBnZXQgdGhlIGNwdQ0KdG8gZG8gaXQg
Zm9yIHlvdT8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

