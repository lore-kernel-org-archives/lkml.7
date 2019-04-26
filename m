Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142ACC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E1C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfDZRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:37:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:42687 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfDZRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:37:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 10:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; 
   d="scan'208";a="165207168"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2019 10:37:35 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.109]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.76]) with mapi id 14.03.0415.000;
 Fri, 26 Apr 2019 10:37:34 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "ebiggers@google.com" <ebiggers@google.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "ebiggers3@gmail.com" <ebiggers3@gmail.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "Perla, Enrico" <enrico.perla@intel.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgADe7YA=
Date:   Fri, 26 Apr 2019 17:37:34 +0000
Message-ID: <56e694bfbe2993389a9662b1477b74eaaca3c171.camel@intel.com>
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
         <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B107D6D6F5339418448E2194AF9B946@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA0LTI2IGF0IDEyOjMzICswMTAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3Rl
Og0KPiAxKSByZHRzYyBvciB2YXJpYXRpb25zIGJhc2VkIG9uIGl0IChEYXZpZCBwcm9wb3NlZCBz
b21lIENSQy1iYXNlZCB2YXJpYW50cyBmb3INCj4gPiBleGFtcGxlKQ0KSGksDQoNCkNvdWxkIHdl
IHJlcGVhdGVkbHkgbWVhc3VyZSB0aGUgdGltZSBmb3IgYSBzaG9ydCBzeXNjYWxsIG9uIGEgcXVp
ZXQgc3lzdGVtIGFuZA0KZXN0aW1hdGUgdGhlIGVudHJvcHkgd2UgZ2V0IGZyb20gdGhpcz8gSW4g
c29tZSBzY2VuYXJpb3MgdGhlIGF0dGFja2VyIG1pZ2h0IGhhdmUNCmxlc3MgY29udHJvbCBvZiB0
aGUgdGltaW5nIGFzIHdlbGwuDQoNClNpbmNlIHRoaXMgaXMgYSBzdGF0aXN0aWNhbCBkZWZlbnNl
LCBhc3N1bWluZyB0aGUgYXJndW1lbnQgY2FuIGJlIG1hZGUgdGhhdA0KdGhlcmUgaXMgYXQgbGVh
c3Qgc29tZSByYW5kb21uZXNzIGluIHRoZSB0aW1lciwgYW5kIGNvdWxkIGF0IGxlYXN0IGJlIG91
dCBvZiB0aGUNCmNvbnRyb2wgb2YgYW4gYXR0YWNrZXIgc29tZXRpbWVzLCBJIHdvbmRlciBpZiB0
aGlzIGZlYXR1cmUgY291bGQgYmUgdmFsdWFibGUNCmJlZm9yZSB0aGUgc2VhcmNoIGZvciBhIGZh
c3RlciBzdHJvbmdlciByYW5kb20gbnVtYmVyIGdlbmVyYXRvciBjb21wbGV0ZXMuDQoNCkNvdWxk
IHRoYXQgYmUgYSB3YXkgZm9yd2FyZCBmb3Igbm93Pw0KDQpUaGFua3MsDQoNClJpY2sNCg==
