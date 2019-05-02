Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1EC04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367CC20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfEBIHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:07:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:14687 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfEBIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:07:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 01:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="169842576"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2019 01:07:24 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX154.ger.corp.intel.com (163.33.192.96) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 2 May 2019 09:07:24 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.186]) with mapi id 14.03.0415.000;
 Thu, 2 May 2019 09:07:23 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
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
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA5l+AgAGeIOA=
Date:   Thu, 2 May 2019 08:07:22 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C6C229@IRSMSX102.ger.corp.intel.com>
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
 <737d5027067b405298167a8d463a3f0b@AcuMS.aculab.com>
In-Reply-To: <737d5027067b405298167a8d463a3f0b@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2QxM2VjZjUtYmVhYi00YjgwLTkwMDEtMGRmYTI0ZDIzNjNkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidmdsYU9EZUdpUFJnQUhSME5PRFBBcDhwYjUrS3hNbHlKRU1XeTJZQUZBRFBHcllvbHRCdUczdEo3WVd0Z3YrXC8ifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSZXNoZXRvdmEsIEVsZW5hDQo+ID4gU2VudDogMzAgQXByaWwgMjAxOSAxODo1MQ0K
PiAuLi4NCj4gPiBJIGd1ZXNzIHRoaXMgaXMgdHJ1ZSwgc28gSSBkaWQgYSBxdWljayBpbXBsZW1l
bnRhdGlvbiBub3cgdG8gZXN0aW1hdGUgdGhlDQo+ID4gcGVyZm9ybWFuY2UgaGl0cy4NCj4gPiBI
ZXJlIGFyZSB0aGUgcHJlbGltaW5hcnkgbnVtYmVycyAocHJvcGVyIG9uZXMgd2lsbCB0YWtlIGEg
Yml0IG1vcmUgdGltZSk6DQo+ID4NCj4gPiBiYXNlOiBTaW1wbGUgc3lzY2FsbDogMC4xNzYxIG1p
Y3Jvc2Vjb25kcw0KPiA+IGdldF9yYW5kb21fYnl0ZXMgKDQwOTYgYnl0ZXMgcGVyLWNwdSBidWZm
ZXIpOiAwLjE3OTMgbWljcm9zZWNvbnMNCj4gPiBnZXRfcmFuZG9tX2J5dGVzICg2NCBieXRlcyBw
ZXItY3B1IGJ1ZmZlcik6IDAuMTg2NiBtaWNyb3NlY29ucw0KPiA+DQo+ID4gSXQgZG9lcyBub3Qg
bWFrZSBzZW5zZSB0byBnbyBsZXNzIHRoYW4gNjQgYnl0ZXMgc2luY2UgdGhpcyBzZWVtcyB0byBi
ZQ0KPiA+IENoYWNoYTIwIGJsb2NrIHNpemUsIHNvIGlmIHdlIGdvIGxvd2VyLCB3ZSB3aWxsIHRy
YXNoIHVzZWZ1bCBiaXRzLg0KPiA+IFlvdSBjYW4gZ28gZXZlbiBoaWdoZXIgdGhhbiA0MDk2IGJ5
dGVzLCBidXQgZXZlbiB0aGlzIGxvb2tzIGxpa2UNCj4gPiBva2lzaCBwZXJmb3JtYW5jZSB0byBt
ZS4NCj4gPg0KPiA+IEJlbG93IGlzIGEgc25pcCBvZiB3aGF0IEkgcXVpY2tseSBkaWQgKHJlbGV2
YW50IHBhcnRzKSB0byBnZXQgdGhlc2UgbnVtYmVycy4NCj4gPiBJIGRvIGluaXRpYWwgcG9wdWxh
dGlvbiBvZiBwZXItY3B1IGJ1ZmZlcnMgaW4gbGF0ZV9pbml0Y2FsbCwgYnV0DQo+ID4gcHJhY3Rp
Y2Ugc2hvd3MgdGhhdCBybmcgbWlnaHQgbm90IGFsd2F5cyBiZSBpbiBnb29kIHN0YXRlIGJ5IHRo
ZW4uDQo+ID4gU28sIHdlIG1pZ2h0IG5vdCBoYXZlIHJlYWxseSBnb29kIHJhbmRvbW5lc3MgdGhl
biwgYnV0IEkgYW0gbm90IHN1cmUNCj4gPiBpZiB0aGlzIGlzIGEgcHJhY3RpY2FsIHByb2JsZW0g
c2luY2UgaXQgb25seSBhcHBsaWVzIHRvIHN5c3RlbSBib290IGFuZCBieQ0KPiA+IHRoZSB0aW1l
IGl0IGJvb3RlZCwgaXQgYWxyZWFkeSBpc3N1ZWQgZW5vdWdoIHN5c2NhbGxzIHRoYXQgYnVmZmVy
IGdldHMgcmVmaWxsZWQNCj4gPiB3aXRoIHJlYWxseSBnb29kIG51bWJlcnMuDQo+ID4gQWx0ZXJu
YXRpdmVseSB3ZSBjYW4gYWxzbyBkbyBpdCBvbiB0aGUgZmlyc3Qgc3lzY2FsbCB0aGF0IGVhY2gg
Y3B1IGdldHMsIGJ1dCBJDQo+ID4gYW0gbm90IHN1cmUgaWYgdGhhdCBpcyBhbHdheXMgZ3VhcmFu
dGVlZCB0byBoYXZlIGEgZ29vZCByYW5kb21uZXNzLg0KPiAuLi4NCj4gPiArdW5zaWduZWQgY2hh
ciByYW5kb21fZ2V0X2J5dGUodm9pZCkNCj4gPiArew0KPiA+ICsgICAgc3RydWN0IHJuZF9idWZm
ZXIgKmJ1ZmZlciA9ICZnZXRfY3B1X3ZhcihzdGFja19yYW5kX29mZnNldCk7DQo+ID4gKyAgICB1
bnNpZ25lZCBjaGFyIHJlczsNCj4gPiArDQo+ID4gKyAgICBpZiAoYnVmZmVyLT5ieXRlX2NvdW50
ZXIgPj0gUkFORE9NX0JVRkZFUl9TSVpFKSB7DQo+ID4gKyAgICAgICAgZ2V0X3JhbmRvbV9ieXRl
cygmKGJ1ZmZlci0+YnVmZmVyKSwgc2l6ZW9mKGJ1ZmZlci0+YnVmZmVyKSk7DQo+ID4gKyAgICAg
ICAgYnVmZmVyLT5ieXRlX2NvdW50ZXIgPSAwOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAg
IHJlcyA9IGJ1ZmZlci0+YnVmZmVyW2J1ZmZlci0+Ynl0ZV9jb3VudGVyXTsNCj4gPiArICAgIGJ1
ZmZlci0+YnVmZmVyW2J1ZmZlci0+Ynl0ZV9jb3VudGVyXSA9IDA7DQo+ID4gKyAgICBidWZmZXIt
PmJ5dGVfY291bnRlciArKzsNCj4gPiArICAgICBwdXRfY3B1X3ZhcihzdGFja19yYW5kX29mZnNl
dCk7DQo+ID4gKyAgICByZXR1cm4gcmVzOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0wocmFu
ZG9tX2dldF9ieXRlKTsNCj4gDQo+IFlvdSdsbCBhbG1vc3QgY2VydGFpbmx5IGdldCBiZXR0ZXIg
Y29kZSBpZiB5b3UgY29weSBidWZmZXItPmJ5dGVfY291bnRlcg0KPiB0byBhIGxvY2FsICd1bnNp
Z25lZCBsb25nJyB2YXJpYWJsZS4NCj4gDQoNCk5vdGVkLCB3aWxsIGZpeCwgdGhhbmsgeW91IGZv
ciB0aGUgc3VnZ2VzdGlvbiENCg0KSSBoYXZlbid0IHlldCB3b3JrZWQgb24gdGhpcyBjb2RlIGZv
ciBhICJwcm9wZXIgdmVyc2lvbiIsIHNvIEkgdGhpbmsgbWFueQ0KdGhpbmdzIHdvdWxkIG5lZWQg
cG9saXNoaW5nIGZvciBib3RoIHNwZWVkIGFuZCBjb2RlIHNpemUuIA0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYS4NCg==
