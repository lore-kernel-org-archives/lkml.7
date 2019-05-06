Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C18C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAFB206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfEFHBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:01:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:31788 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEFHBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:01:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 00:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="140379799"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2019 00:01:05 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 08:01:05 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Ingo Molnar <mingo@kernel.org>
CC:     Andy Lutomirski <luto@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "Eric Biggers" <ebiggers3@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAEI1ng
Date:   Mon, 6 May 2019 07:01:04 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C7125F@IRSMSX102.ger.corp.intel.com>
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
In-Reply-To: <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDkwNzNhZTgtMTVmZi00NmVmLThmNzAtN2VhNjNkZDY3OWViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnVQcFlEbXZGaU9iYUlqU3dUQ2JydWNzS1ZZblZhNVJ5dGtXZTRRU3pzTnZsRHB4dkdyTTI5NjBVeWVmWmhKcyJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSZXNoZXRvdmEsIEVsZW5hDQo+ID4gU2VudDogMDMgTWF5IDIwMTkgMTc6MTcNCj4g
Li4uDQo+ID4gcmRyYW5kIChjYWxsaW5nIGV2ZXJ5IDggc3lzY2FsbHMpOiBTaW1wbGUgc3lzY2Fs
bDogMC4wNzk1IG1pY3Jvc2Vjb25kcw0KPiANCj4gWW91IGNvdWxkIHRyeSBzb21ldGhpbmcgbGlr
ZToNCj4gCXU2NCByYW5kX3ZhbCA9IGNwdV92YXItPnN5c2NhbGxfcmFuZA0KPiANCj4gCXdoaWxl
ICh1bmxpa2VseShyYW5kX3ZhbCA9PSAwKSkNCj4gCQlyYW5kX3ZhbCA9IHJkcmFuZDY0KCk7DQo+
IA0KPiAJc3RhY2tfb2Zmc2V0ID0gcmFuZF92YWwgJiAweGZmOw0KPiAJcmFuZF92YWwgPj49IDY7
DQo+IAlpZiAobGlrZWx5KHJhbmRfdmFsID49IDQpKQ0KPiAJCWNwdV92YXItPnN5c2NhbGxfcmFu
ZCA9IHJhbmRfdmFsOw0KPiAJZWxzZQ0KPiAJCWNwdV92YXItPnN5c2NhbGxfcmFuZCA9IHJkcmFu
ZDY0KCk7DQo+IA0KPiAJcmV0dXJuIHN0YWNrX29mZnNldDsNCj4gDQo+IFRoYXQgZ2l2ZXMgeW91
IDEwIHN5c3RlbSBjYWxscyBwZXIgcmRyYW5kIGluc3RydWN0aW9uDQo+IGFuZCBtb3N0bHkgdGFr
ZXMgdGhlIGxhdGVuY3kgb3V0IG9mIGxpbmUuDQoNCkkgYW0gbm90IHJlYWxseSBoYXBweSBnb2lu
ZyB0aGUgcmRyYW5kIHBhdGggZm9yIGEgY291cGxlIG9mIHJlYXNvbnM6DQotIGl0IGlzIG5vdCBh
dmFpbGFibGUgb24gb2xkZXIgUENzDQotIGl0cyBwZXJmb3JtYW5jZSB2YXJpZXMgYWNyb3NzIENQ
VXMgdGhhdCBzdXBwb3J0IGl0IChhbmQgYXMgSSB1bmRlcnN0b29kIHZhcmllcyBxdWl0ZSBzb21l
KQ0KLSBpdCBpcyB4ODYgY2VudHJpYyBhbmQgbm90IGdlbmVyaWMNCg0KU28sIGlmIHdlIGNhbiB1
c2UgZ2V0X3JhbmRvbV9ieXRlcygpIGludGVyZmFjZSB3aXRob3V0IHRpZ2h0ZW5pbmcgb3Vyc2Vs
dmVzIHRvDQphIHBhcnRpY3VsYXIgaW5zdHJ1Y3Rpb24sIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0
dGVyLiANClRoZSBudW1iZXJzIEkgaGF2ZSBtZWFzdXJlZCBzbyBmYXIgZm9yIGJ1ZmZlciBzaXpl
IG9mIDQwOTYgaXMgU1cgb25seSwgDQpJIHdpbGwgdHJ5IHRvIG1lYXN1cmUgdG9kYXkgd2hhdCBi
b29zdCAoaWYgYW55KSB3ZSBjYW4gaGF2ZSBpZiB3ZSB1c2UgU0lNRCANCmNvZGUgZm9yIGl0LiAN
Cg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=
