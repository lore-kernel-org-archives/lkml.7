Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D321520651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBIQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:16:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:47649 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfEBIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:16:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 01:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="139225922"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga008.jf.intel.com with ESMTP; 02 May 2019 01:16:00 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.173]) with mapi id 14.03.0415.000;
 Thu, 2 May 2019 09:15:59 +0100
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXA=
Date:   Thu, 2 May 2019 08:15:59 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
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
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
In-Reply-To: <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjg3Y2U0MmItMTgxYS00NmUyLWI4YzItM2U1YzdhY2NlYjQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidzVrV3BYd29rczJSUE9FNFRZbXJtM0hVN28wWlV3Y2tZNXNCXC9DTFhRd1FZU1JZdjZpU2VvMHkydGNCNmJEcnAifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IEZyb206IFJlc2hldG92YSwgRWxlbmENCj4gPiBTZW50OiAzMCBBcHJpbCAyMDE5IDE4OjUxDQo+
IC4uLg0KPiA+ICt1bnNpZ25lZCBjaGFyIHJhbmRvbV9nZXRfYnl0ZSh2b2lkKQ0KPiA+ICt7DQo+
ID4gKyAgICBzdHJ1Y3Qgcm5kX2J1ZmZlciAqYnVmZmVyID0gJmdldF9jcHVfdmFyKHN0YWNrX3Jh
bmRfb2Zmc2V0KTsNCj4gPiArICAgIHVuc2lnbmVkIGNoYXIgcmVzOw0KPiA+ICsNCj4gPiArICAg
IGlmIChidWZmZXItPmJ5dGVfY291bnRlciA+PSBSQU5ET01fQlVGRkVSX1NJWkUpIHsNCj4gPiAr
ICAgICAgICBnZXRfcmFuZG9tX2J5dGVzKCYoYnVmZmVyLT5idWZmZXIpLCBzaXplb2YoYnVmZmVy
LT5idWZmZXIpKTsNCj4gPiArICAgICAgICBidWZmZXItPmJ5dGVfY291bnRlciA9IDA7DQo+ID4g
KyAgICB9DQo+ID4gKw0KPiA+ICsgICAgcmVzID0gYnVmZmVyLT5idWZmZXJbYnVmZmVyLT5ieXRl
X2NvdW50ZXJdOw0KPiA+ICsgICAgYnVmZmVyLT5idWZmZXJbYnVmZmVyLT5ieXRlX2NvdW50ZXJd
ID0gMDsNCj4gDQo+IElmIGlzIHJlYWxseSB3b3J0aCBkaXJ0eWluZyBhIGNhY2hlIGxpbmUgdG8g
emVybyBkYXRhIHdlJ3ZlIHVzZWQ/DQo+IFRoZSB1bnVzZWQgYnl0ZXMgZm9sbG93aW5nIGFyZSBt
dWNoIG1vcmUgaW50ZXJlc3RpbmcuDQo+IA0KPiBBY3R1YWxseSBpZiB5b3UgZ290ICdieXRlX2Nv
dW50ZXInIGludG8gYSBjb21wbGV0ZWx5IGRpZmZlcmVudA0KPiBhcmVhIG9mIG1lbW9yeSAoaW4g
ZGF0YSB0aGF0IGlzIGNoYW5nZWQgbW9yZSBvZnRlbiB0byBhdm9pZA0KPiBkaXJ0eWluZyBhbiBl
eHRyYSBjYWNoZSBsaW5lKSB0aGVuIG5vdCB6ZXJvaW5nIHRoZSB1c2VkIGRhdGENCj4gd291bGQg
bWFrZSBpdCBoYXJkZXIgdG8gZGV0ZXJtaW5lIHdoaWNoIGJ5dGUgd2lsbCBiZSB1c2VkIG5leHQu
DQoNCkludGVyZXN0aW5nIGlkZWEsIGJ1dCB3aGF0IHdvdWxkIHRoaXMgYXJlYSBiZT8NCkkgYW0g
bm90IHRoYXQgZmFtaWxpYXIgd2l0aCBkaWZmZXJlbnQgZGF0YSB1c2FnZSBwYXR0ZXJucy4NCg0K
PiANCj4gSSdtIGFsc28gZ3Vlc3NpbmcgdGhhdCBnZXRfY3B1X3ZhcigpIGRpc2FibGVzIHByZS1l
bXB0aW9uPw0KDQpZZXMsIGluIG15IHVuZGVyc3RhbmRpbmc6DQoNCiNkZWZpbmUgZ2V0X2NwdV92
YXIodmFyKQkJCQkJCVwNCigqKHsJCQkJCQkJCQlcDQoJcHJlZW1wdF9kaXNhYmxlKCk7CQkJCQkJ
XA0KCXRoaXNfY3B1X3B0cigmdmFyKTsJCQkJCQlcDQp9KSkNCg0KPiBUaGlzIGNvZGUgY291bGQg
cHJvYmFibHkgcnVuICdmYXN0IGFuZCBsb29zZScgYW5kIGp1c3QgaWdub3JlDQo+IHRoZSBmYWN0
IHRoYXQgcHJlLWVtcHRpb24gd291bGQgaGF2ZSBvZGQgZWZmZWN0cy4NCj4gQWxsIGl0IHdvdWxk
IGRvIGlzIHBlcnR1cmIgdGhlIHJhbmRvbW5lc3MhDQoNCkhtLi4gSSBzZWUgeW91ciBwb2ludCwg
YnV0IEkgYW0gd29uZGVyaW5nIHdoYXQgdGhlIG9kZCBlZmZlY3RzIG1pZ2h0DQpiZS4uIGkuZS4g
Y2FuIHdlIGVuZCB1cCB1c2luZyB0aGUgc2FtZSByYW5kb20gYml0cyB0d2ljZSBmb3IgdHdvIG9y
IG1vcmUNCmRpZmZlcmVudCBzeXNjYWxscyBhbmQgYXR0YWNrZXJzIGNhbiB0cnkgdG8gdHJpZ2dl
ciB0aGlzIHNpdHVhdGlvbj8gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0K
