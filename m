Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68377C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfDXLmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:42:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:10237 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfDXLmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 04:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="133956941"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by orsmga007.jf.intel.com with ESMTP; 24 Apr 2019 04:42:45 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.30]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 12:42:44 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Theodore Ts'o' <tytso@mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4A==
Date:   Wed, 24 Apr 2019 11:42:44 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
In-Reply-To: <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjI4YmRmMjYtMmZhMS00NGRhLThkMTgtYzQwMTMxMTFmZjdlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnpld0VHbUJkWUJmd0M0OHNqMXVUc0RXbjBjeHJOK2kwZ2lrREtzakhFQ1BBc1FGMHNuSnBUKzNpVGpDeGFLdCJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IC0gRWFzdGVyIGhvbGlkYXlzICsgSSB3YXMgdHJ5
aW5nIHRvIGFycmFuZ2UgbXkgYnJhaW4gYXJvdW5kIHByb3Bvc2VkIG9wdGlvbnMuIA0KSGVyZSB3
aGF0IEkgdGhpbmsgb3VyIG9wdGlvbnMgYXJlIHdpdGggcmVnYXJkcyB0byB0aGUgc291cmNlIG9m
IHJhbmRvbW5lc3M6DQoNCjEpIHJkdHNjIG9yIHZhcmlhdGlvbnMgYmFzZWQgb24gaXQgKERhdmlk
IHByb3Bvc2VkIHNvbWUgQ1JDLWJhc2VkIHZhcmlhbnRzIGZvciBleGFtcGxlKQ0KMikgcHJhbmRv
bS1iYXNlZCBvcHRpb25zIA0KMykgc29tZSBwcm9wZXIgY3J5cHRvIChjaGFjaGE4IGZvciBleGFt
cGxlIHNlZW1zIHRvIGJlIHRoZSBsaWdodGVzdCBvdXQgb2YgZXhpc3Rpbmcgb3B0aW9ucywNCmFu
ZCBwcm9iYWJseSBlbm91Z2ggZm9yIG91ciBwdXJwb3NlLCBidXQgbG9va3MgbGlrZSBrZXJuZWwg
aGFzIG9ubHkgY2hhY2hhMjApDQo0KSByZHJhbmQgb3Igb3RoZXIgSFctYmFzZWQgY3J5cHRvDQoN
Ck9wdGlvbiA0IHdhcyBtZWFzdXJlZCB0byBiZSBoZWF2eSBmb3IgdGhlIHB1cnBvc2U6DQogICBi
YXNlOiAgICAgICAgICAgICAgICAgICAgIFNpbXBsZSBzeXNjYWxsOiAwLjE3NzQgbWljcm9zZWNv
bmRzDQogICByYW5kb21fb2Zmc2V0IChyZHRzYyk6ICAgICBTaW1wbGUgc3lzY2FsbDogMC4xODAz
IG1pY3Jvc2Vjb25kcw0KICAgcmFuZG9tX29mZnNldCAocmRyYW5kKTogU2ltcGxlIHN5c2NhbGw6
IDAuMzcwMiBtaWNyb3NlY29uZHMNCg0KDQpPcHRpb24gMiAoZXZlbiBpZiB3ZSBmb3JrIG91ciBv
d24gc3RhdGUocyksIGRvIGl0IHBlci1jcHUsIHJlc2VlZCwgZXRjLikgc3RhcnRzIHRvIGxvb2sg
Zm9yIG1lIGFzIHRoZSBsZWFzdCBkZXNpcmVkLiANClRoZSBleGlzdGluZyBnZW5lcmF0b3IncyBz
dGF0ZSwgYXMgcGVvcGxlIG1lbnRpb25lZCBiZWZvcmUsIGlzIHRyaXZpYWxseSBzb2x2YWJsZSBn
aXZlbiBhIHZlcnkgbGl0dGxlIGFtb3VudCBvZg0KZXF1YXRpb25zIChzeXNjYWxscyBpbiBvdXIg
Y2FzZSkgeW91IG5lZWQgdG8gaXNzdWUgYW5kIG9mZnNldHMgdG8gbGVhay4gDQpFdmVuIGlmIHdl
IGlzb2xhdGUgdGhlIHN0YXRlL3NlZWQgdG8ganVzdCB0aGlzIHB1cnBvc2Ugb2Ygc3RhY2sgcmFu
ZG9taXphdGlvbiAoYW5kIGRvbid0IGxlYWsgYW55dGhpbmcgYWJvdXQgdGhlIHJlc3QNCm9mIHRo
ZSBzeXN0ZW0gb3IgbmV0IHByYW5kb20gdXNhZ2UpLCBpdCBzdGlsbCBwcm9iYWJseSBtYWtlcyB0
aGUNCnJhbmRvbWl6YXRpb24gbW9yZSBlYXNpbHkgc29sdmFibGUgdGhhbiBzb21lIGNvbnN0cnVj
dHMgYmFzZWQgb24gbG93ZXIgYml0cyBvZiByZHRzYy4gDQpJbiBhZGRpdGlvbiAgYnVpbGRpbmcg
b24gdG9wIG9mIGV4aXN0aW5nIGtlcm5lbCBMRlNSIHdvdWxkIGFkZCBtb3JlIChwcm9iYWJseSBu
b3QgdXNlZnVsIGZvciBhbnkgb3RoZXIgcHVycG9zZSkNCmNvZGUsIGEgcG9zc2libGUgbWlzY29u
Y2VwdGlvbiB0aGF0IGl0IGNhbiBiZSB1c2VkIGZvciAicmVhbCBzZWN1cml0eSIsIGV0Yy4gU28s
IEkgd291bGQgcHJvcG9zZSB0byBhYmFuZG9uIHRoaXMgaWRlYS4gIA0KDQpPcHRpb24gMyB3ZSBo
YXZlIHRvIG1lYXN1cmUgSSBndWVzcywgYnV0IGlmIGl0IGlzIGFzIGhlYXZ5IGFzIHJkcmFuZCwg
dGhlbiB0aGlzIGlzIGFsc28gb3V0LiANCkluIHRoYXQgY2FzZSwgd2UgYXJlIG9ubHkgbGVmdCB3
aXRoIHJkdHNjLWJhc2VkIHZhcmlhbnRzLiANCkkgZ3Vlc3MgZm9yIG1lYXN1cmluZyBJIHdpbGwg
aGF2ZSB0byB1c2UgZXhpc3RpbmcgY2hhY2hhMjAga2VybmVsIGltcGxlbWVudGF0aW9uLCBuZXZl
ciB1c2VkIGl0IGJlZm9yZSwgc28gd2lsbCBjaGVjayBob3cgdG8NCnVzZSBpdC9pbml0aWFsaXpl
LCBldGMuIA0KDQpBbnkgb3RoZXIgb3B0aW9uIEkgbWlzc2VkPw0KDQpCZXN0IFJlZ2FyZHMsDQpF
bGVuYS4NCg0KDQo=
