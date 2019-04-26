Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A856C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449AF206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZLdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:33:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:31178 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDZLdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:33:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 04:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="226920032"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2019 04:33:11 -0700
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 irsmsx105.ger.corp.intel.com (163.33.3.28) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 26 Apr 2019 12:33:11 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.85]) with mapi id 14.03.0415.000;
 Fri, 26 Apr 2019 12:33:10 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@ACULAB.COM>,
        'Theodore Ts'o' <tytso@mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
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
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwA
Date:   Fri, 26 Apr 2019 11:33:09 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
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

PiBIaSwNCj4gDQo+IFNvcnJ5IGZvciB0aGUgZGVsYXkgLSBFYXN0ZXIgaG9saWRheXMgKyBJIHdh
cyB0cnlpbmcgdG8gYXJyYW5nZSBteSBicmFpbiBhcm91bmQNCj4gcHJvcG9zZWQgb3B0aW9ucy4N
Cj4gSGVyZSB3aGF0IEkgdGhpbmsgb3VyIG9wdGlvbnMgYXJlIHdpdGggcmVnYXJkcyB0byB0aGUg
c291cmNlIG9mIHJhbmRvbW5lc3M6DQo+IA0KPiAxKSByZHRzYyBvciB2YXJpYXRpb25zIGJhc2Vk
IG9uIGl0IChEYXZpZCBwcm9wb3NlZCBzb21lIENSQy1iYXNlZCB2YXJpYW50cyBmb3INCj4gZXhh
bXBsZSkNCj4gMikgcHJhbmRvbS1iYXNlZCBvcHRpb25zDQo+IDMpIHNvbWUgcHJvcGVyIGNyeXB0
byAoY2hhY2hhOCBmb3IgZXhhbXBsZSBzZWVtcyB0byBiZSB0aGUgbGlnaHRlc3Qgb3V0IG9mIGV4
aXN0aW5nDQo+IG9wdGlvbnMsDQo+IGFuZCBwcm9iYWJseSBlbm91Z2ggZm9yIG91ciBwdXJwb3Nl
LCBidXQgbG9va3MgbGlrZSBrZXJuZWwgaGFzIG9ubHkgY2hhY2hhMjApDQo+IDQpIHJkcmFuZCBv
ciBvdGhlciBIVy1iYXNlZCBjcnlwdG8NCj4gDQo+IE9wdGlvbiA0IHdhcyBtZWFzdXJlZCB0byBi
ZSBoZWF2eSBmb3IgdGhlIHB1cnBvc2U6DQo+ICAgIGJhc2U6ICAgICAgICAgICAgICAgICAgICAg
U2ltcGxlIHN5c2NhbGw6IDAuMTc3NCBtaWNyb3NlY29uZHMNCj4gICAgcmFuZG9tX29mZnNldCAo
cmR0c2MpOiAgICAgU2ltcGxlIHN5c2NhbGw6IDAuMTgwMyBtaWNyb3NlY29uZHMNCj4gICAgcmFu
ZG9tX29mZnNldCAocmRyYW5kKTogU2ltcGxlIHN5c2NhbGw6IDAuMzcwMiBtaWNyb3NlY29uZHMN
Cj4gDQo+IA0KPiBPcHRpb24gMiAoZXZlbiBpZiB3ZSBmb3JrIG91ciBvd24gc3RhdGUocyksIGRv
IGl0IHBlci1jcHUsIHJlc2VlZCwgZXRjLikgc3RhcnRzIHRvIGxvb2sNCj4gZm9yIG1lIGFzIHRo
ZSBsZWFzdCBkZXNpcmVkLg0KPiBUaGUgZXhpc3RpbmcgZ2VuZXJhdG9yJ3Mgc3RhdGUsIGFzIHBl
b3BsZSBtZW50aW9uZWQgYmVmb3JlLCBpcyB0cml2aWFsbHkgc29sdmFibGUgZ2l2ZW4NCj4gYSB2
ZXJ5IGxpdHRsZSBhbW91bnQgb2YNCj4gZXF1YXRpb25zIChzeXNjYWxscyBpbiBvdXIgY2FzZSkg
eW91IG5lZWQgdG8gaXNzdWUgYW5kIG9mZnNldHMgdG8gbGVhay4NCj4gRXZlbiBpZiB3ZSBpc29s
YXRlIHRoZSBzdGF0ZS9zZWVkIHRvIGp1c3QgdGhpcyBwdXJwb3NlIG9mIHN0YWNrIHJhbmRvbWl6
YXRpb24gKGFuZA0KPiBkb24ndCBsZWFrIGFueXRoaW5nIGFib3V0IHRoZSByZXN0DQo+IG9mIHRo
ZSBzeXN0ZW0gb3IgbmV0IHByYW5kb20gdXNhZ2UpLCBpdCBzdGlsbCBwcm9iYWJseSBtYWtlcyB0
aGUNCj4gcmFuZG9taXphdGlvbiBtb3JlIGVhc2lseSBzb2x2YWJsZSB0aGFuIHNvbWUgY29uc3Ry
dWN0cyBiYXNlZCBvbiBsb3dlciBiaXRzIG9mDQo+IHJkdHNjLg0KPiBJbiBhZGRpdGlvbiAgYnVp
bGRpbmcgb24gdG9wIG9mIGV4aXN0aW5nIGtlcm5lbCBMRlNSIHdvdWxkIGFkZCBtb3JlIChwcm9i
YWJseSBub3QNCj4gdXNlZnVsIGZvciBhbnkgb3RoZXIgcHVycG9zZSkNCj4gY29kZSwgYSBwb3Nz
aWJsZSBtaXNjb25jZXB0aW9uIHRoYXQgaXQgY2FuIGJlIHVzZWQgZm9yICJyZWFsIHNlY3VyaXR5
IiwgZXRjLiBTbywgSQ0KPiB3b3VsZCBwcm9wb3NlIHRvIGFiYW5kb24gdGhpcyBpZGVhLg0KPiAN
Cj4gT3B0aW9uIDMgd2UgaGF2ZSB0byBtZWFzdXJlIEkgZ3Vlc3MsIGJ1dCBpZiBpdCBpcyBhcyBo
ZWF2eSBhcyByZHJhbmQsIHRoZW4gdGhpcyBpcyBhbHNvDQo+IG91dC4NCg0KQWRkaW5nIEVyaWMg
YW5kIEhlcmJlcnQgdG8gY29udGludWUgZGlzY3Vzc2lvbiBmb3IgdGhlIGNoYWNoYSBwYXJ0LiAN
ClNvLCBhcyBhIHNob3J0IHN1bW1hcnkgSSBhbSB0cnlpbmcgdG8gZmluZCBvdXQgYSBmYXN0IChm
YXN0IGVub3VnaCB0byBiZSB1c2VkIHBlciBzeXNjYWxsDQppbnZvY2F0aW9uKSBzb3VyY2Ugb2Yg
cmFuZG9tIGJpdHMgd2l0aCBnb29kIGVub3VnaCBzZWN1cml0eSBwcm9wZXJ0aWVzLiANCkkgc3Rh
cnRlZCB0byBsb29rIGludG8gY2hhY2hhIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBhbmQgd2hpbGUg
aXQgc2VlbXMgdGhhdCBpdCBpcyBkZXNpZ25lZCB0byANCndvcmsgd2l0aCBhbnkgbnVtYmVyIG9m
IHJvdW5kcywgaXQgZG9lcyBub3QgZXhwb3NlIGxlc3MgdGhhbiAxMiByb3VuZHMgcHJpbWl0aXZl
LiANCkkgZ3Vlc3MgdGhpcyBpcyBkb25lIGZvciBzZWN1cml0eSBzYWtlLCBzaW5jZSAxMiBpcyBw
cm9iYWJseSB0aGUgbG93ZXN0IGJvdW5kIHdlIHdhbnQgcGVvcGxlDQp0byB1c2UgZm9yIHRoZSBw
dXJwb3NlIG9mIGVuY3J5cHRpb24vZGVjcnlwdGlvbiwgYnV0IGlmIHdlIGFyZSB0byBidWlsZCBh
biBlZmZpY2llbnQgUk5HLA0KY2hhY2hhOCBwcm9iYWJseSBpcyBhIGdvb2QgdHJhZGVvZmYgYmV0
d2VlbiBzZWN1cml0eSBhbmQgc3BlZWQuIA0KDQpXaGF0IGFyZSBwZW9wbGUncyBvcGluaW9ucy9w
ZXJjZXB0aW9ucyBvbiB0aGlzPyBIYXMgaXQgYmVlbiBjb25zaWRlcmVkIGJlZm9yZSB0byBjcmVh
dGUgYQ0Ka2VybmVsIFJORyBiYXNlZCBvbiBjaGFjaGE/IA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVu
YS4NCg0K
