Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B930C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B62084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfDYLYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:24:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:2250 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbfDYLYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:24:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 04:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="340697912"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 04:23:59 -0700
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 12:23:58 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.85]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 12:23:58 +0100
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IAAFTEAgAF9VBA=
Date:   Thu, 25 Apr 2019 11:23:57 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C61E91@IRSMSX102.ger.corp.intel.com>
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
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <bf7cb17c44224fe29daf5ba66d908b2b@AcuMS.aculab.com>
In-Reply-To: <bf7cb17c44224fe29daf5ba66d908b2b@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2UwMjc5ZDQtMjI4Zi00YjlmLWJiMDctM2MyNzExODY4MDVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOHBjVVlpOGZcL1RCMHgrQ2lxc2xUMm56VGJtMXBWTStWRFRNeWFyQVh4czVHaXJJTGQ1YmFaZnhxSGNQaThoUXUifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSZXNoZXRvdmEsIEVsZW5hDQo+ID4gU2VudDogMjQgQXByaWwgMjAxOSAxMjo0Mw0K
PiA+DQo+ID4gU29ycnkgZm9yIHRoZSBkZWxheSAtIEVhc3RlciBob2xpZGF5cyArIEkgd2FzIHRy
eWluZyB0byBhcnJhbmdlIG15IGJyYWluIGFyb3VuZA0KPiBwcm9wb3NlZCBvcHRpb25zLg0KPiA+
IEhlcmUgd2hhdCBJIHRoaW5rIG91ciBvcHRpb25zIGFyZSB3aXRoIHJlZ2FyZHMgdG8gdGhlIHNv
dXJjZSBvZiByYW5kb21uZXNzOg0KPiA+DQo+ID4gMSkgcmR0c2Mgb3IgdmFyaWF0aW9ucyBiYXNl
ZCBvbiBpdCAoRGF2aWQgcHJvcG9zZWQgc29tZSBDUkMtYmFzZWQgdmFyaWFudHMgZm9yDQo+IGV4
YW1wbGUpDQo+IA0KPiBEbyBJIHJlbWVtYmVyIHNvbWV0aGluZyBhYm91dCByZHRzYyBiZWluZyBt
YWRlIGxlc3MgYWNjdXJhdGUgaW4gb3JkZXIgdG8NCj4gbWFrZSBpdCAoc2xpZ2h0bHkpIG1vcmUg
ZGlmZmljdWx0IHRvIHVzZSBpdCB0byBtZWFzdXJlIHRpbWluZyBhdHRhY2tzPw0KDQpEbyB5b3Ug
aGF2ZSBhbnkgcG9pbnRlcnMgb24gdGhpcz8gSSBkaWQgYW4gb25saW5lIHNlYXJjaCwgYnV0IGNv
dWxkIG5vdCBmaW5kIGFueXRoaW5nDQpjb25jcmV0ZS4gVGhlIEludGVsIG1hbnVhbCBkb2Vzbid0
IHRhbGsgYWJvdXQgcHJlY2lzaW9uIGF0IGFsbCwgb25seSBhYm91dCBwcm90ZWN0ZWQNCm1vZGUu
DQoNCj4gDQo+IElmIHRydWUsIGFuZCBpdCBhcHBsaWVzIHRvIHRoZSBrZXJuZWwgKGVnIGluIGEg
Vk0pIHRoZW4gdGhpcyBpcyBwcm9iYWJseQ0KPiBhbGwgcG9pbnRsZXNzIQ0KDQpZb3UgbWVhbiBh
ZGRpdGlvbmFsIGNvbnN0cnVjdGlvbnMgb24gdG9wIG9mIFRTQyBpcyBwb2ludGxlc3M/IA0KDQpC
ZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
