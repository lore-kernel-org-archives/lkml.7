Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C29C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8553521734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEAImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 04:42:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28714 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfEAImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 04:42:13 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-CW7NFOPjM2SPadXKTPuDJQ-1; Wed, 01 May 2019 09:41:58 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 1 May 2019 09:41:57 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 1 May 2019 09:41:57 +0100
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
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA9yhg
Date:   Wed, 1 May 2019 08:41:57 +0000
Message-ID: <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
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
X-MC-Unique: CW7NFOPjM2SPadXKTPuDJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmVzaGV0b3ZhLCBFbGVuYQ0KPiBTZW50OiAzMCBBcHJpbCAyMDE5IDE4OjUxDQouLi4N
Cj4gK3Vuc2lnbmVkIGNoYXIgcmFuZG9tX2dldF9ieXRlKHZvaWQpDQo+ICt7DQo+ICsgICAgc3Ry
dWN0IHJuZF9idWZmZXIgKmJ1ZmZlciA9ICZnZXRfY3B1X3ZhcihzdGFja19yYW5kX29mZnNldCk7
DQo+ICsgICAgdW5zaWduZWQgY2hhciByZXM7DQo+ICsNCj4gKyAgICBpZiAoYnVmZmVyLT5ieXRl
X2NvdW50ZXIgPj0gUkFORE9NX0JVRkZFUl9TSVpFKSB7DQo+ICsgICAgICAgIGdldF9yYW5kb21f
Ynl0ZXMoJihidWZmZXItPmJ1ZmZlciksIHNpemVvZihidWZmZXItPmJ1ZmZlcikpOw0KPiArICAg
ICAgICBidWZmZXItPmJ5dGVfY291bnRlciA9IDA7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmVz
ID0gYnVmZmVyLT5idWZmZXJbYnVmZmVyLT5ieXRlX2NvdW50ZXJdOw0KPiArICAgIGJ1ZmZlci0+
YnVmZmVyW2J1ZmZlci0+Ynl0ZV9jb3VudGVyXSA9IDA7DQoNCklmIGlzIHJlYWxseSB3b3J0aCBk
aXJ0eWluZyBhIGNhY2hlIGxpbmUgdG8gemVybyBkYXRhIHdlJ3ZlIHVzZWQ/DQpUaGUgdW51c2Vk
IGJ5dGVzIGZvbGxvd2luZyBhcmUgbXVjaCBtb3JlIGludGVyZXN0aW5nLg0KDQpBY3R1YWxseSBp
ZiB5b3UgZ290ICdieXRlX2NvdW50ZXInIGludG8gYSBjb21wbGV0ZWx5IGRpZmZlcmVudA0KYXJl
YSBvZiBtZW1vcnkgKGluIGRhdGEgdGhhdCBpcyBjaGFuZ2VkIG1vcmUgb2Z0ZW4gdG8gYXZvaWQN
CmRpcnR5aW5nIGFuIGV4dHJhIGNhY2hlIGxpbmUpIHRoZW4gbm90IHplcm9pbmcgdGhlIHVzZWQg
ZGF0YQ0Kd291bGQgbWFrZSBpdCBoYXJkZXIgdG8gZGV0ZXJtaW5lIHdoaWNoIGJ5dGUgd2lsbCBi
ZSB1c2VkIG5leHQuDQoNCkknbSBhbHNvIGd1ZXNzaW5nIHRoYXQgZ2V0X2NwdV92YXIoKSBkaXNh
YmxlcyBwcmUtZW1wdGlvbj8NClRoaXMgY29kZSBjb3VsZCBwcm9iYWJseSBydW4gJ2Zhc3QgYW5k
IGxvb3NlJyBhbmQganVzdCBpZ25vcmUNCnRoZSBmYWN0IHRoYXQgcHJlLWVtcHRpb24gd291bGQg
aGF2ZSBvZGQgZWZmZWN0cy4NCkFsbCBpdCB3b3VsZCBkbyBpcyBwZXJ0dXJiIHRoZSByYW5kb21u
ZXNzIQ0KDQoJRGF2aWQNCg0KDQo+ICsgICAgYnVmZmVyLT5ieXRlX2NvdW50ZXIgKys7DQo+ICsg
ICAgIHB1dF9jcHVfdmFyKHN0YWNrX3JhbmRfb2Zmc2V0KTsNCj4gKyAgICByZXR1cm4gcmVzOw0K
PiArfQ0KPiArRVhQT1JUX1NZTUJPTChyYW5kb21fZ2V0X2J5dGUpOw0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

