Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F08C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDXNb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:31:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39541 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbfDXNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:31:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-138-_Wh5CtMQPvaSf2MjPGY3wA-1; Wed, 24 Apr 2019 14:31:55 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 24 Apr 2019 14:33:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 24 Apr 2019 14:33:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Reshetova, Elena'" <elena.reshetova@intel.com>,
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
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAARJkYIAAWDaAgAAZlPCACqsuAIAALsDQ
Date:   Wed, 24 Apr 2019 13:33:08 +0000
Message-ID: <bf7cb17c44224fe29daf5ba66d908b2b@AcuMS.aculab.com>
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
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _Wh5CtMQPvaSf2MjPGY3wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmVzaGV0b3ZhLCBFbGVuYQ0KPiBTZW50OiAyNCBBcHJpbCAyMDE5IDEyOjQzDQo+DQo+
IFNvcnJ5IGZvciB0aGUgZGVsYXkgLSBFYXN0ZXIgaG9saWRheXMgKyBJIHdhcyB0cnlpbmcgdG8g
YXJyYW5nZSBteSBicmFpbiBhcm91bmQgcHJvcG9zZWQgb3B0aW9ucy4NCj4gSGVyZSB3aGF0IEkg
dGhpbmsgb3VyIG9wdGlvbnMgYXJlIHdpdGggcmVnYXJkcyB0byB0aGUgc291cmNlIG9mIHJhbmRv
bW5lc3M6DQo+IA0KPiAxKSByZHRzYyBvciB2YXJpYXRpb25zIGJhc2VkIG9uIGl0IChEYXZpZCBw
cm9wb3NlZCBzb21lIENSQy1iYXNlZCB2YXJpYW50cyBmb3IgZXhhbXBsZSkNCg0KRG8gSSByZW1l
bWJlciBzb21ldGhpbmcgYWJvdXQgcmR0c2MgYmVpbmcgbWFkZSBsZXNzIGFjY3VyYXRlIGluIG9y
ZGVyIHRvDQptYWtlIGl0IChzbGlnaHRseSkgbW9yZSBkaWZmaWN1bHQgdG8gdXNlIGl0IHRvIG1l
YXN1cmUgdGltaW5nIGF0dGFja3M/DQoNCklmIHRydWUsIGFuZCBpdCBhcHBsaWVzIHRvIHRoZSBr
ZXJuZWwgKGVnIGluIGEgVk0pIHRoZW4gdGhpcyBpcyBwcm9iYWJseQ0KYWxsIHBvaW50bGVzcyEN
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

