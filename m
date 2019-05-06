Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE265C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C520830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEFGsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:48:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:64911 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfEFGsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:48:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 May 2019 23:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="141672937"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2019 23:47:55 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.30]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 07:47:55 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
CC:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAAKeMAgAPw2NA=
Date:   Mon, 6 May 2019 06:47:54 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C71202@IRSMSX102.ger.corp.intel.com>
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <CAHk-=wjb9c4JV5xOWp5VMGTzgCmpFCegf2MydVwbvjr5gnBV9A@mail.gmail.com>
In-Reply-To: <CAHk-=wjb9c4JV5xOWp5VMGTzgCmpFCegf2MydVwbvjr5gnBV9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWQzMmVlOGQtZWYyYy00NzllLTlmNGItMDNhMTRmYjc3N2QxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMGczT0xObzFmdENESlNtXC9cL0EzZ3lBUnBYK01BcE1keEZIYUphcDlueU8zUDI2NHJLbmVZYzF2ZGpUdEx4ejJ3In0=
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gT24gRnJpLCBNYXkgMywgMjAxOSBhdCA5OjQwIEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhhdCBnaXZlcyB5b3UgMTAgc3lzdGVt
IGNhbGxzIHBlciByZHJhbmQgaW5zdHJ1Y3Rpb24NCj4gPiBhbmQgbW9zdGx5IHRha2VzIHRoZSBs
YXRlbmN5IG91dCBvZiBsaW5lLg0KPiANCj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gZG8gdGhpcz8g
V2hhdCBpcyB0aGUgYXR0YWNrIHNjZW5hcmlvPw0KPiANCj4gV2l0aCBubyBWTEEncywgYW5kIHRo
ZSBzdGFja2xlYWsgcGx1Z2luLCB3aGF0J3MgdGhlIHVwc2lkZT8gQXJlIHdlDQo+IGFkZGluZyBy
YW5kb20gY29kZSAobGl0ZXJhbGx5KSAianVzdCBiZWNhdXNlIj8NCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICBMaW51cw0KDQpIaSBMaW51cywgDQoNClNvLCBpZiB5b3VyIHF1ZXN0aW9uIGlzICJk
byB3ZSBrbm93IGEgdGhyZWFkIHN0YWNrLWJhc2VkDQphdHRhY2sgdGhhdCB3b3VsZCBzdWNjZWVk
IGdpdmVuIHRoYXQgYWxsIGNvdW50ZXJtZWFzdXJlcyBhcmUgYWN0aXZlDQooc3RhY2tsZWFrLCBD
T05GSUdfR0NDX1BMVUdJTl9TVFJVQ1RMRUFLX0JZUkVGX0FMTD15LA0KYXNzdW1lIG5vIFZMQXMg
bGVmdCwgZXRjLikgPyIgVGhlbiB0aGUgYW5zd2VyIGlzICJubyIsIEkgZG9uJ3Qga25vdw0KYW5k
IHBlb3BsZSBJIGhhdmUgYXNrZWQgYWxzbyAodGhpcyBvZiBjb3Vyc2UgYnkgaXRzZWxmIGRvZXMg
bm90IHByb3ZpZGUgYW55IA0KZ3VhcmFudGVlcyBvZiBhbnkga2luZCBpbiBzZWN1cml0eSB3b3Js
ZCkuDQoNCkhvd2V2ZXIsIHRoZSB3aG9sZSBuYXR1cmUgb2YgdGhlIHRocmVhZCBzdGFjayBpcyBp
dHMgcHJlZGljdGFibGUgYW5kIGRldGVybWluaXN0aWMNCnN0cnVjdHVyZSB0aGF0IGF0dHJhY3Rl
ZCBhdHRhY2tlcnMgb3ZlciBkZWNhZGVzIHRvIG1vdW50IHZhcmlvdXMgYXR0YWNrcw0KKGFiKXVz
aW5nIGl0LiBTbywgd2hpbGUgc3RhY2tsZWFrIGFuZCBvdGhlcnMgYWRkcmVzcyBjb25jcmV0ZSBh
dHRhY2sgcGF0aHMsDQpzdWNoIGFzIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGVzIG9uIHRoZSBzdGFj
aywgYXJiaXRyYXJ5IHN0YWNrIGp1bXAgcHJpbWl0aXZlcyAoVkxBcyksDQpldGMuIFdlIGRvbid0
IHJlYWxseSBoYXZlIGFueXRoaW5nIGluIHBsYWNlIHRoYXQgYWRkcmVzc2VzIHRoZSBjb3JlIGZl
YXR1cmU6DQoic2ltcGxlIGFuZCBkZXRlcm1pbmlzdGljIHN0cnVjdHVyZSB0aGF0IGlzIHBlcnNp
c3RlbnQgYWNyb3NzIHN5c2NhbGxzIi4gDQoNClNvLCB0aGlzIGZlYXR1cmUgaXMgYW4gYXR0ZW1w
dCB0byBiZSBtb3JlIHByb2FjdGl2ZSAodnMuIHJlYWN0aW5nIHRvIGFscmVhZHkgcHVibGlzaGVk
DQphdHRhY2spIGFuZCBhZGQgcmFuZG9taXphdGlvbiBpbiBhIHBsYWNlIHdoZXJlIGl0IHdvdWxk
IGxpa2VseSBtYWtlIG1vc3Qgb2YgdGhyZWFkLWJhc2VkDQphdHRhY2tzIGhhcmRlciBmb3IgYXR0
YWNrZXJzLiBJZiB3ZSBjYW4gbWFrZSB0aGUgbWVhc3VyZSBjaGVhcCBlbm91Z2ggbm90IHRvIGFm
ZmVjdA0KcGVyZm9ybWFuY2UgY29uc2lkZXJhYmx5IGFuZCBnZXQgYSBzZWN1cml0eSBiZW5lZml0
LCB3aHkgbm90PyANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=
