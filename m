Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE6DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA77F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:23:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27276 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbfEBJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:23:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-61-pyNgKG8xNWSOj78Z1oKZAg-1; Thu, 02 May 2019 10:23:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 2 May 2019 10:23:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 May 2019 10:23:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Reshetova, Elena'" <elena.reshetova@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA9yhggAF9YoCAABkBsA==
Date:   Thu, 2 May 2019 09:23:21 +0000
Message-ID: <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
 <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: pyNgKG8xNWSOj78Z1oKZAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmVzaGV0b3ZhLCBFbGVuYQ0KPiBTZW50OiAwMiBNYXkgMjAxOSAwOToxNg0KLi4uDQo+
ID4gSSdtIGFsc28gZ3Vlc3NpbmcgdGhhdCBnZXRfY3B1X3ZhcigpIGRpc2FibGVzIHByZS1lbXB0
aW9uPw0KPiANCj4gWWVzLCBpbiBteSB1bmRlcnN0YW5kaW5nOg0KPiANCj4gI2RlZmluZSBnZXRf
Y3B1X3Zhcih2YXIpCQkJCQkJXA0KPiAoKih7CQkJCQkJCQkJXA0KPiAJcHJlZW1wdF9kaXNhYmxl
KCk7CQkJCQkJXA0KPiAJdGhpc19jcHVfcHRyKCZ2YXIpOwkJCQkJCVwNCj4gfSkpDQo+IA0KPiA+
IFRoaXMgY29kZSBjb3VsZCBwcm9iYWJseSBydW4gJ2Zhc3QgYW5kIGxvb3NlJyBhbmQganVzdCBp
Z25vcmUNCj4gPiB0aGUgZmFjdCB0aGF0IHByZS1lbXB0aW9uIHdvdWxkIGhhdmUgb2RkIGVmZmVj
dHMuDQo+ID4gQWxsIGl0IHdvdWxkIGRvIGlzIHBlcnR1cmIgdGhlIHJhbmRvbW5lc3MhDQo+IA0K
PiBIbS4uIEkgc2VlIHlvdXIgcG9pbnQsIGJ1dCBJIGFtIHdvbmRlcmluZyB3aGF0IHRoZSBvZGQg
ZWZmZWN0cyBtaWdodA0KPiBiZS4uIGkuZS4gY2FuIHdlIGVuZCB1cCB1c2luZyB0aGUgc2FtZSBy
YW5kb20gYml0cyB0d2ljZSBmb3IgdHdvIG9yIG1vcmUNCj4gZGlmZmVyZW50IHN5c2NhbGxzIGFu
ZCBhdHRhY2tlcnMgY2FuIHRyeSB0byB0cmlnZ2VyIHRoaXMgc2l0dWF0aW9uPw0KDQpUbyB0cmln
Z2VyIGl0IHlvdSdkIG5lZWQgdG8gYXJyYW5nZSBmb3IgYW4gaW50ZXJydXB0IGluIHRoZSByaWdo
dA0KdGltaW5nIHdpbmRvdyB0byBjYXVzZSBhbm90aGVyIHByb2Nlc3MgdG8gcnVuLg0KVGhlcmUg
YXJlIGFsbW9zdCBjZXJ0YWlubHkgZWFzaWVyIHdheXMgdG8gYnJlYWsgdGhpbmdzLg0KDQpJIHRo
aW5rIHRoZSBtYWluIGVmZmVjdHMgd291bGQgYmUgdGhlIGluY3JlbWVudCB3cml0aW5nIHRvIGEg
ZGlmZmVyZW50DQpjcHUgbG9jYWwgZGF0YSAoY2F1c2luZyB0aGUgc2FtZSBkYXRhIHRvIGJlIHVz
ZWQgYWdhaW4gYW5kL29yIHNraXBwZWQpDQphbmQgdGhlIHBvdGVudGlhbCBmb3IgdXBkYXRpbmcg
dGhlIHJhbmRvbSBidWZmZXIgb24gdGhlICd3cm9uZyBjcHUnLg0KDQpTbyBzb21ldGhpbmcgbGlr
ZToNCgkvKiBXZSBkb24ndCByZWFsbHkgY2FyZSBpZiB0aGUgdXBkYXRlIGlzIHdyaXR0ZW4gdG8g
dGhlICd3cm9uZycNCgkgKiBjcHUgb3IgaWYgdGhlIHZhbGUgY29tZXMgZnJvbSB0aGUgd3Jvbmcg
YnVmZmVyLiAqLw0KCW9mZnNldCA9ICp0aGlzX2NwdV9wdHIoJmNwdV9zeXNjYWxsX3JhbmRfb2Zm
c2V0KTsNCgkqdGhpc19jcHVfcHRyKCZjcHVfc3lzY2FsbF9yYW5kX29mZnNldCkgPSBvZmZzZXQg
KyAxOw0KCQ0KCWlmICgob2Zmc2V0ICY9IDQwOTUpKSByZXR1cm4gdGhpc19jcHVfcHRyKCZjcHVf
c3lzY2FsbF9yYW5kX2J1ZmZlcilbb2Zmc2V0XTsNCg0KCWJ1ZmZlciA9IGdldF9jcHVfdmFyKCgm
Y3B1X3N5c2NhbGxfcmFuZF9idWZmZXIpOw0KCWdldF9yYW5kb21fYnl0ZXMoKTsNCgl2YWwgPSBi
dWZmZXJbMF07DQoJLyogbWF5YmUgc2V0IGNwdV9zeXNjYWxsX3JhbmRfb2Zmc2V0IHRvIDEgKi8N
CglwdXRfY3B1X3ZhcigpOw0KCXJldHVybiB2YWw7DQoNClRoZSB3aG9sZSB0aGluZyBtaWdodCBl
dmVuIHdvcmsgd2l0aCBhIGdsb2JhbCBidWZmZXIhDQoNCglEYXZpZA0KDQoNCgkNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

