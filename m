Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17241C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5121743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEAIX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 04:23:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44926 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfEAIX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 04:23:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-90-UtjMldtBMJ2BFBYilzx3xA-1; Wed, 01 May 2019 09:23:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 1 May 2019 09:23:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 1 May 2019 09:23:51 +0100
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
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA9Cpg
Date:   Wed, 1 May 2019 08:23:51 +0000
Message-ID: <737d5027067b405298167a8d463a3f0b@AcuMS.aculab.com>
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
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UtjMldtBMJ2BFBYilzx3xA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmVzaGV0b3ZhLCBFbGVuYQ0KPiBTZW50OiAzMCBBcHJpbCAyMDE5IDE4OjUxDQouLi4N
Cj4gSSBndWVzcyB0aGlzIGlzIHRydWUsIHNvIEkgZGlkIGEgcXVpY2sgaW1wbGVtZW50YXRpb24g
bm93IHRvIGVzdGltYXRlIHRoZQ0KPiBwZXJmb3JtYW5jZSBoaXRzLg0KPiBIZXJlIGFyZSB0aGUg
cHJlbGltaW5hcnkgbnVtYmVycyAocHJvcGVyIG9uZXMgd2lsbCB0YWtlIGEgYml0IG1vcmUgdGlt
ZSk6DQo+IA0KPiBiYXNlOiBTaW1wbGUgc3lzY2FsbDogMC4xNzYxIG1pY3Jvc2Vjb25kcw0KPiBn
ZXRfcmFuZG9tX2J5dGVzICg0MDk2IGJ5dGVzIHBlci1jcHUgYnVmZmVyKTogMC4xNzkzIG1pY3Jv
c2Vjb25zDQo+IGdldF9yYW5kb21fYnl0ZXMgKDY0IGJ5dGVzIHBlci1jcHUgYnVmZmVyKTogMC4x
ODY2IG1pY3Jvc2Vjb25zDQo+IA0KPiBJdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIGdvIGxlc3Mg
dGhhbiA2NCBieXRlcyBzaW5jZSB0aGlzIHNlZW1zIHRvIGJlDQo+IENoYWNoYTIwIGJsb2NrIHNp
emUsIHNvIGlmIHdlIGdvIGxvd2VyLCB3ZSB3aWxsIHRyYXNoIHVzZWZ1bCBiaXRzLg0KPiBZb3Ug
Y2FuIGdvIGV2ZW4gaGlnaGVyIHRoYW4gNDA5NiBieXRlcywgYnV0IGV2ZW4gdGhpcyBsb29rcyBs
aWtlDQo+IG9raXNoIHBlcmZvcm1hbmNlIHRvIG1lLg0KPiANCj4gQmVsb3cgaXMgYSBzbmlwIG9m
IHdoYXQgSSBxdWlja2x5IGRpZCAocmVsZXZhbnQgcGFydHMpIHRvIGdldCB0aGVzZSBudW1iZXJz
Lg0KPiBJIGRvIGluaXRpYWwgcG9wdWxhdGlvbiBvZiBwZXItY3B1IGJ1ZmZlcnMgaW4gbGF0ZV9p
bml0Y2FsbCwgYnV0DQo+IHByYWN0aWNlIHNob3dzIHRoYXQgcm5nIG1pZ2h0IG5vdCBhbHdheXMg
YmUgaW4gZ29vZCBzdGF0ZSBieSB0aGVuLg0KPiBTbywgd2UgbWlnaHQgbm90IGhhdmUgcmVhbGx5
IGdvb2QgcmFuZG9tbmVzcyB0aGVuLCBidXQgSSBhbSBub3Qgc3VyZQ0KPiBpZiB0aGlzIGlzIGEg
cHJhY3RpY2FsIHByb2JsZW0gc2luY2UgaXQgb25seSBhcHBsaWVzIHRvIHN5c3RlbSBib290IGFu
ZCBieQ0KPiB0aGUgdGltZSBpdCBib290ZWQsIGl0IGFscmVhZHkgaXNzdWVkIGVub3VnaCBzeXNj
YWxscyB0aGF0IGJ1ZmZlciBnZXRzIHJlZmlsbGVkDQo+IHdpdGggcmVhbGx5IGdvb2QgbnVtYmVy
cy4NCj4gQWx0ZXJuYXRpdmVseSB3ZSBjYW4gYWxzbyBkbyBpdCBvbiB0aGUgZmlyc3Qgc3lzY2Fs
bCB0aGF0IGVhY2ggY3B1IGdldHMsIGJ1dCBJDQo+IGFtIG5vdCBzdXJlIGlmIHRoYXQgaXMgYWx3
YXlzIGd1YXJhbnRlZWQgdG8gaGF2ZSBhIGdvb2QgcmFuZG9tbmVzcy4NCi4uLg0KPiArdW5zaWdu
ZWQgY2hhciByYW5kb21fZ2V0X2J5dGUodm9pZCkNCj4gK3sNCj4gKyAgICBzdHJ1Y3Qgcm5kX2J1
ZmZlciAqYnVmZmVyID0gJmdldF9jcHVfdmFyKHN0YWNrX3JhbmRfb2Zmc2V0KTsNCj4gKyAgICB1
bnNpZ25lZCBjaGFyIHJlczsNCj4gKw0KPiArICAgIGlmIChidWZmZXItPmJ5dGVfY291bnRlciA+
PSBSQU5ET01fQlVGRkVSX1NJWkUpIHsNCj4gKyAgICAgICAgZ2V0X3JhbmRvbV9ieXRlcygmKGJ1
ZmZlci0+YnVmZmVyKSwgc2l6ZW9mKGJ1ZmZlci0+YnVmZmVyKSk7DQo+ICsgICAgICAgIGJ1ZmZl
ci0+Ynl0ZV9jb3VudGVyID0gMDsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICByZXMgPSBidWZmZXIt
PmJ1ZmZlcltidWZmZXItPmJ5dGVfY291bnRlcl07DQo+ICsgICAgYnVmZmVyLT5idWZmZXJbYnVm
ZmVyLT5ieXRlX2NvdW50ZXJdID0gMDsNCj4gKyAgICBidWZmZXItPmJ5dGVfY291bnRlciArKzsN
Cj4gKyAgICAgcHV0X2NwdV92YXIoc3RhY2tfcmFuZF9vZmZzZXQpOw0KPiArICAgIHJldHVybiBy
ZXM7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKHJhbmRvbV9nZXRfYnl0ZSk7DQoNCllvdSdsbCBh
bG1vc3QgY2VydGFpbmx5IGdldCBiZXR0ZXIgY29kZSBpZiB5b3UgY29weSBidWZmZXItPmJ5dGVf
Y291bnRlcg0KdG8gYSBsb2NhbCAndW5zaWduZWQgbG9uZycgdmFyaWFibGUuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

