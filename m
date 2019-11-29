Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D77C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132AA21774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfK2Q5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:57:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:46526 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726909AbfK2Q5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:57:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-ncsrQBlpNwCNYiFsL1Oucg-1; Fri, 29 Nov 2019 16:57:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 29 Nov 2019 16:57:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 29 Nov 2019 16:57:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        Barret Rhoden <brho@google.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "ian@airs.com" <ian@airs.com>,
        Austin Clements <austin@google.com>,
        David Chase <drchase@golang.org>
Subject: RE: [PATCH v2] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Thread-Topic: [PATCH v2] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Thread-Index: AQHVpclHU3X60X8HPEmYZCr4nqmH8KeiYC6A
Date:   Fri, 29 Nov 2019 16:57:42 +0000
Message-ID: <d99a4a85441d48b1b34a7fb648d12379@AcuMS.aculab.com>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
 <20191127124243.u74osvlkhcmsskng@linutronix.de>
 <20191127140754.GB3812@zn.tnic>
 <f4d5ca28-a388-c382-4b1a-4b65c9f9e6e7@google.com>
 <20191128085306.hxfa2o3knqtu4wfn@linutronix.de>
In-Reply-To: <20191128085306.hxfa2o3knqtu4wfn@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ncsrQBlpNwCNYiFsL1Oucg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+IFNlbnQ6IDI4IE5vdmVtYmVyIDIwMTkg
MDg6NTMNCj4gVGhlIHN0YXRlL293bmVyIG9mIEZQVSBpcyBzYXZlZCBmcHVfZnByZWdzX293bmVy
X2N0eCBieSBwb2ludGluZyB0byB0aGUNCj4gY29udGV4dCB0aGF0IGlzIGN1cnJlbnRseSBsb2Fk
ZWQuIEl0IG5ldmVyIGNoYW5nZWQgZHVyaW5nIHRoZSBsaWZlIHRpbWUNCj4gb2YgYSB0YXNrIGFu
ZCByZW1haW5lZCBzdGFibGUvY29uc3RhbnQuDQo+IA0KPiBTaW5jZSBkZWZlcnJlZCBsb2FkaW5n
IHRoZSBGUFUgcmVnaXN0ZXJzIG9uIHJldHVybiB0byB1c2VybGFuZCwgdGhlDQo+IGNvbnRlbnQg
b2YgZnB1X2ZwcmVnc19vd25lcl9jdHggbWF5IGNoYW5nZSBkdXJpbmcgcHJlZW1wdGlvbiBhbmQg
bXVzdA0KPiBub3QgYmUgY2FjaGVkLg0KPiBUaGlzIHdlbnQgdW5ub3RpY2VkIGZvciBzb21lIHRp
bWUgYW5kIHdhcyBub3cgbm90aWNlZCwgaW4gcGFydGljdWxhcg0KPiBnY2MtOSBpcyBhYmxlIHRv
IGNhY2hlIHRoYXQgbG9hZCBpbiBjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUoKSBhbmQgcmV1c2UN
Cj4gaXQgaW4gdGhlIHJldHJ5IGxvb3A6DQo+IA0KPiAgIGNvcHlfZnBzdGF0ZV90b19zaWdmcmFt
ZSgpDQo+ICAgICBsb2FkIGZwdV9mcHJlZ3Nfb3duZXJfY3R4IGFuZCBzYXZlIG9uIHN0YWNrDQo+
ICAgICBmcHJlZ3NfbG9jaygpDQo+ICAgICBjb3B5X2ZwcmVnc190b19zaWdmcmFtZSgpIC8qIGZh
aWxlZCAqLw0KPiAgICAgZnByZWdzX3VubG9jaygpDQo+ICAgICAgICAgICoqKiBQUkVFTVBUSU9O
LCBhbm90aGVyIHVzZXMgRlBVLCBjaGFuZ2VzIGZwdV9mcHJlZ3Nfb3duZXJfY3R4ICoqKg0KPiAN
Cj4gICAgIGZhdWx0X2luX3BhZ2VzX3dyaXRlYWJsZSgpIC8qIHN1Y2NlZWQsIHJldHJ5ICovDQo+
IA0KPiAgICAgZnByZWdzX2xvY2soKQ0KPiAJX19mcHJlZ3NfbG9hZF9hY3RpdmF0ZSgpDQo+IAkg
IGZwcmVnc19zdGF0ZV92YWxpZCgpIC8qIHVzZXMgZnB1X2ZwcmVnc19vd25lcl9jdHggZnJvbSBz
dGFjayAqLw0KPiAgICAgY29weV9mcHJlZ3NfdG9fc2lnZnJhbWUoKSAvKiBzdWNjZWVkcywgcmFu
ZG9tIEZQVSBjb250ZW50ICovDQoNClNob3VsZCBib3RoIGZwcmVnc19sb2NrKCkgYW5kIGZwcmVn
c191bmxvY2soKSBjb250YWluIGEgYmFycmllcigpIChvciAibWVtb3J5IiBjbG9iYmVyKQ0KZG8g
c3RvcCB0aGUgY29tcGlsZXIgbW92aW5nIGFueXRoaW5nIGFjcm9zcyB0aGVtPw0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

