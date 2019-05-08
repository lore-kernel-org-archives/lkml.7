Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66086C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4265421530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEHLTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:19:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:2490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfEHLTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:19:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 04:19:00 -0700
X-ExtLoop1: 1
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2019 04:18:57 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.44]) with mapi id 14.03.0415.000;
 Wed, 8 May 2019 12:18:56 +0100
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA
Date:   Wed, 8 May 2019 11:18:55 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
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
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjU2YWM2NjYtMDAxNi00ZDM4LWI3ODUtODcxNWExYTA4OGJhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRUpCN0diR1RzWFU5SGhaUXhcLzAzZUVsbjFFMjBiYXlncmxVVUh0MFJUdHorNkd3VHZOekNidmJLRG4xeTNpREUifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4NCj4gPiByZHJhbmQgKGNhbGxpbmcgZXZlcnkgOCBzeXNjYWxscyk6IFNpbXBsZSBzeXNjYWxs
OiAwLjA3OTUgbWljcm9zZWNvbmRzDQo+IA0KPiBZb3UgY291bGQgdHJ5IHNvbWV0aGluZyBsaWtl
Og0KPiAJdTY0IHJhbmRfdmFsID0gY3B1X3Zhci0+c3lzY2FsbF9yYW5kDQo+IA0KPiAJd2hpbGUg
KHVubGlrZWx5KHJhbmRfdmFsID09IDApKQ0KPiAJCXJhbmRfdmFsID0gcmRyYW5kNjQoKTsNCj4g
DQo+IAlzdGFja19vZmZzZXQgPSByYW5kX3ZhbCAmIDB4ZmY7DQo+IAlyYW5kX3ZhbCA+Pj0gNjsN
Cj4gCWlmIChsaWtlbHkocmFuZF92YWwgPj0gNCkpDQo+IAkJY3B1X3Zhci0+c3lzY2FsbF9yYW5k
ID0gcmFuZF92YWw7DQo+IAllbHNlDQo+IAkJY3B1X3Zhci0+c3lzY2FsbF9yYW5kID0gcmRyYW5k
NjQoKTsNCj4gDQo+IAlyZXR1cm4gc3RhY2tfb2Zmc2V0Ow0KPiANCj4gVGhhdCBnaXZlcyB5b3Ug
MTAgc3lzdGVtIGNhbGxzIHBlciByZHJhbmQgaW5zdHJ1Y3Rpb24NCj4gYW5kIG1vc3RseSB0YWtl
cyB0aGUgbGF0ZW5jeSBvdXQgb2YgbGluZS4NCg0KSSBoYXZlIGV4cGVyaW1lbnRlZCBtb3JlIChp
bmNsdWRpbmcgdGhlIHZlcnNpb24gYWJvdmUpIGFuZCBoZXJlIGFyZQ0KbW9yZSBzdGFibGUgbnVt
YmVyczoNCg0KQ09ORklHX1BBR0VfVEFCTEVfSVNPTEFUSU9OPXk6DQoNCmJhc2U6ICAgICAgICAg
U2ltcGxlIHN5c2NhbGw6IDAuMTc2MSBtaWNyb3NlY29uZHMNCmdldF9yYW5kb21fYnl0ZXMgKDQw
OTYgYnl0ZXMgYnVmZmVyKTogU2ltcGxlIHN5c2NhbGw6IDAuMTc5MyBtaWNyb3NlY29uZHMNCnJk
cmFuZChldmVyeSAxMCBzeXNjYWxscyk6U2ltcGxlIHN5c2NhbGw6IDAuMTkwNSBtaWNyb3NlY29u
ZHMNCnJkcmFuZChldmVyeSA4IHN5c2NhbGxzKTogU2ltcGxlIHN5c2NhbGw6IDAuMTk4MCBtaWNy
b3NlY29uZHMNCg0KQ09ORklHX1BBR0VfVEFCTEVfSVNPTEFUSU9OPW46DQoNCmJhc2U6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTaW1wbGUgc3lzY2FsbDogMC4wNTEwIG1p
Y3Jvc2Vjb25kcw0KZ2V0X3JhbmRvbV9ieXRlcyg0MDk2IGJ5dGVzIGJ1ZmZlcik6ICAgU2ltcGxl
IHN5c2NhbGw6IDAuMDU5NyBtaWNyb3NlY29uZHMNCnJkcmFuZCAoZXZlcnkgMTAgc3lzY2FsbHMp
OiBTaW1wbGUgc3lzY2FsbDogMC4wNzE5IG1pY3Jvc2Vjb25kcw0KcmRyYW5kIChldmVyeSA4IHN5
c2NhbGxzKTogICBTaW1wbGUgc3lzY2FsbDogMC4wNzgzIG1pY3Jvc2Vjb25kcw0KDQpTbywgcHVy
ZSBzcGVlZCB3aXNlIGdldF9yYW5kb21fYnl0ZXMoKSB3aXRoIDEgcGFnZSBwZXItY3B1IGJ1ZmZl
ciB3aW5zLiANCg0KQWxzbywgSSBoYXZlbid0IHlldCBmb3VuZCBhbnkgcGVyc29uIHdpdGggaW4t
ZGVwdGgga25vd2xlZGdlIG9mIGdlbmVyYXRvciANCmJlaGluZCByZHJhbmQsIGJ1dCB3aGVuIHlv
dSByZWFkIHB1YmxpYyBkZXNpZ24gZG9jcywgaXQgZG9lcyBoYXZlIGluZGVlZCBpbnRlcm5hbA0K
YnVmZmVyaW5nIGl0c2VsZiwgc28gbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGFzIHNvb24gYXMg
dGhlcmUgaXMgc3R1ZmYgYXZhaWxhYmxlDQppbiB0aGlzIGludGVybmFsIGJ1ZmZlciAoc2hhcmVk
IGJldHdlZW4gYWxsIENQVXMpLCB0aGUgcmRyYW5kIGluc3RydWN0aW9uIGlzIGZhc3QsDQpidXQg
aWYgYnVmZmVyIG5lZWRzIHJlZmlsbGluZywgdGhlbiBpdCBpcyBzbG93Lg0KSG93ZXZlciwgeW91
IGNhbiBvbmx5IGFzayBhIHJlZ2lzdGVyIHdvcnRoIG9mIHJhbmRvbW5lc3MgZnJvbSBpdCAoY2Fu
J3QgYXNrDQo1IGJpdHMgZm9yIGV4YW1wbGUpLCBzbyBhIHN0cmF0ZWd5IHRvIGFzayBvbmUgZnVs
bCA2NCBiaXRzIHJlZ2lzdGVyIGFuZCBzdG9yZSBvdXRjb21lDQppbiBhIHBlci1jcHUgYnVmZmVy
IHNlZW1zIHJlYXNvbmFibGUuIFRoZSBvbmx5IG90aGVyIHdheSBJIGNhbiB0aGluayB0byBkbyB0
aGlzIGlzIHRvIHJ1bg0KcmRyYW5kIGluIGEgcm93IG11bHRpcGxlIHRpbWVzIGluIG9uZSBzeXNj
YWxsIHRvIGZpbGwgYSBiaWdnZXIgYnVmZmVyIGFuZCB0aGVuIHVzZSBiaXRzIGZyb20gdGhlcmUs
DQpJIGNhbiB0cnkgdG8gbWVhc3VyZSB0aGlzIGluIGNhc2UgdGhpcyBpcyBmYXN0ZXIgKEkgZG91
YnQpLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNCg0KDQo=
