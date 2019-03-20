Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0910421841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCTRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:36:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:50821 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbfCTRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:36:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-31-ruRAd5A1NByCp1uMn0ApbQ-1; Wed, 20 Mar 2019 17:36:46 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 20 Mar 2019 17:37:48 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Mar 2019 17:37:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH 02/25] tracing: Improve "if" macro code generation
Thread-Topic: [PATCH 02/25] tracing: Improve "if" macro code generation
Thread-Index: AQHU3aLdi3oEk4fc9kGJYBZloKomkaYUYYEggABnRoCAAAG5kA==
Date:   Wed, 20 Mar 2019 17:37:48 +0000
Message-ID: <d6baf892a063449f9d69164cc52c6d8e@AcuMS.aculab.com>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
 <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ruRAd5A1NByCp1uMn0ApbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMgDQo+IFNlbnQ6IDIwIE1hcmNoIDIwMTkgMTc6MjYNCj4gVG86
IERhdmlkIExhaWdodA0KPiBPbiBXZWQsIE1hciAyMCwgMjAxOSBhdCA0OjE3IEFNIERhdmlkIExh
aWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAgICAgICAg
ICAgICAgIF9fX19fX3IgPSAhIShjb25kKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiA+DQo+ID4gICAgICAgICBJcyB0aGF0IChvciBtYXliZSBqdXN0IHRoZSAhISkg
bmVlZGVkIGFueSBtb3JlPz8NCj4gDQo+IEl0IGlzLCBiZWNhdXNlIHRoZSAnY29uZCcgZXhwcmVz
c2lvbiBtaWdodCBub3QgYmUgYW4gaW50LCBpdCBjb3VsZCBiZQ0KPiBhIHRlc3QgZm9yIGEgcG9p
bnRlciBiZWluZyBub24tTlVMTCwgb3IgYW4gdTY0IGJlaW5nIG5vbi16ZXJvLCBhbmQgbm90DQo+
IGhhdmluZyB0aGUgIiEhIiB3b3VsZCBtZWFuIHRoYXQgeW91J2QgZ2V0IGEgd2FybmluZyBvciBk
cm9wIGJpdHMgd2hlbg0KPiBhc3NpZ25pbmcgdG8gJ2ludCcuDQo+IA0KPiBBbmQgeW91IGRvIG5l
ZWQgdGhlIG5ldyB0ZW1wb3JhcnkgdmFyaWFibGUgdG8gYXZvaWQgZG91YmxlIGV2YWx1YXRpb24N
Cj4gdGhlIHdheSB0aGF0IGNvZGUgaXMgd3JpdHRlbi4NCg0KQXMgdXN1YWwgSSdkIG9wZW5lZCBt
eSBtb3V0aCBiZWZvcmUgY2hlY2tpbmcgdGhlIGZ1bGwgY29udGV4dCA6LSkNCg0KPiAgICAgICAg
ICAgX19fX19fciA9ICEhKGNvbmQpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCj4gLQkJX19fX19fZi5taXNzX2hpdFtfX19fX19yXSsrOwkJCQkJXA0KPiArCQlfX19fX19y
ID8gX19fX19fZi5taXNzX2hpdFsxXSsrIDogX19fX19fZi5taXNzX2hpdFswXSsrO1wNCj4gIAkJ
X19fX19fcjsJCQkJCQlcDQoNCkFjdHVhbGx5IHlvdSBjYW4gYXZvaWQgZG91YmxlIGV2YWx1YXRp
b24gYnkgZG9pbmc6DQoNCgkJKGNvbmQpID8gKF9fX19fX2YubWlzc19oaXRbMV0rKywgMSkgOiAo
X19fX19fZi5taXNzX2hpdFswXSsrLCAwKQ0KDQpXaXRoIGx1Y2sgdGhlIGNvbXBpbGVyIHdpbGwg
bW92ZSB0aGUgaW5jcmVtZW50IHRvIGFmdGVyIHRoZSBicmFuY2ggdGFyZ2V0Lg0KDQpmb3IgKF9f
X19fID0gX19fXzsgX19fX18gPCBfX19fX187IF9fX19fKyspIDotKQ0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

