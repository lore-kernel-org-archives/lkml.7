Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9647C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92AE20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfD3RvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:51:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:33275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3RvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:51:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 10:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="342221361"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga006.fm.intel.com with ESMTP; 30 Apr 2019 10:51:19 -0700
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 IRSMSX107.ger.corp.intel.com (163.33.3.99) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Apr 2019 18:51:18 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0415.000;
 Tue, 30 Apr 2019 18:51:18 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@aculab.com>,
        "Ingo Molnar" <mingo@kernel.org>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8A==
Date:   Tue, 30 Apr 2019 17:51:17 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
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
In-Reply-To: <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTUwNzgyNTAtYzYyOC00ZmUxLWE3MDMtMmE2MjYwNzIxODg1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV0NsQ2FLcHZqN3laYXlKb09lN3l0UXpqQzhZNXFuek1wV0txQ0h6YiswNkg5MWNZUmRkcjBwbmZ4NEplQTcwKyJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiBPbiBBcHIgMjksIDIwMTksIGF0IDEyOjQ2IEFNLCBSZXNoZXRvdmEsIEVsZW5hIDxl
bGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4+Pj4gT24g
QXByIDI2LCAyMDE5LCBhdCA3OjAxIEFNLCBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1PiB3
cm90ZToNCj4gPj4+DQo+ID4NCj4gPj4gSXQgc2VlbXMgdG8gbWUNCj4gPj4gdGhhdCB3ZSBzaG91
bGQgYmUgdXNpbmcgdGhlIOKAnGZhc3QtZXJhc3VyZeKAnSBjb25zdHJ1Y3Rpb24gZm9yIGFsbA0K
PiBnZXRfcmFuZG9tX2J5dGVzKCkNCj4gPj4gaW52b2NhdGlvbnMuIFNwZWNpZmljYWxseSwgd2Ug
c2hvdWxkIGhhdmUgYSBwZXIgY3B1IGJ1ZmZlciB0aGF0IHN0b3JlcyBzb21lDQo+IHJhbmRvbQ0K
PiA+PiBieXRlcyBhbmQgYSBjb3VudCBvZiBob3cgbWFueSByYW5kb20gYnl0ZXMgdGhlcmUgYXJl
LiBnZXRfcmFuZG9tX2J5dGVzKCkNCj4gc2hvdWxkDQo+ID4+IHRha2UgYnl0ZXMgZnJvbSB0aGF0
IGJ1ZmZlciBhbmQgKmltbWVkaWF0ZWx5KiB6ZXJvIHRob3NlIGJ5dGVzIGluIG1lbW9yeS4NCj4g
V2hlbg0KPiA+PiB0aGUgYnVmZmVyIGlzIGVtcHR5LCBpdCBnZXRzIHJlZmlsbGVkIHdpdGggdGhl
IGZ1bGwgc3RyZW5ndGggQ1JORy4NCj4gPg0KPiA+IElkZWFsbHkgaXQgd291bGQgYmUgZ3JlYXQg
dG8gY2FsbCBzbXRoIGZhc3QgYW5kIHNlY3VyZSBvbiBlYWNoIHN5c2NhbGwgd2l0aG91dCBhIHBl
ci0NCj4gY3B1DQo+ID4gYnVmZmVyLA0KPiANCj4gV2h5PyAgWW91IG9ubHkgbmVlZCBhIGZldyBi
aXRzLCBhbmQgYW55IHNlbnNpYmxlIGNyeXB0byBwcmltaXRpdmUgaXMgZ29pbmcgdG8gYmUNCj4g
bXVjaCBiZXR0ZXIgYXQgcHJvZHVjaW5nIGxvdHMgb2YgYml0cyB0aGFuIHByb2R1Y2luZyBqdXN0
IGEgZmV3IGJpdHMuICBFdmVuIGlnbm9yaW5nDQo+IHRoYXQsIGF2b2lkaW5nIHRoZSBJLWNhY2hl
IGhpdCBvbiBldmVyeSBzeXNjYWxsIGhhcyB2YWx1ZS4gIEFuZCBJIHN0aWxsIGRvbuKAmXQgc2Vl
IHdoYXTigJlzDQo+IHdyb25nIHdpdGggYSBwZXJjcHUgYnVmZmVyLg0KDQpJIGd1ZXNzIHRoaXMg
aXMgdHJ1ZSwgc28gSSBkaWQgYSBxdWljayBpbXBsZW1lbnRhdGlvbiBub3cgdG8gZXN0aW1hdGUg
dGhlDQpwZXJmb3JtYW5jZSBoaXRzLg0KSGVyZSBhcmUgdGhlIHByZWxpbWluYXJ5IG51bWJlcnMg
KHByb3BlciBvbmVzIHdpbGwgdGFrZSBhIGJpdCBtb3JlIHRpbWUpOg0KDQpiYXNlOiBTaW1wbGUg
c3lzY2FsbDogMC4xNzYxIG1pY3Jvc2Vjb25kcw0KZ2V0X3JhbmRvbV9ieXRlcyAoNDA5NiBieXRl
cyBwZXItY3B1IGJ1ZmZlcik6IDAuMTc5MyBtaWNyb3NlY29ucw0KZ2V0X3JhbmRvbV9ieXRlcyAo
NjQgYnl0ZXMgcGVyLWNwdSBidWZmZXIpOiAwLjE4NjYgbWljcm9zZWNvbnMNCg0KSXQgZG9lcyBu
b3QgbWFrZSBzZW5zZSB0byBnbyBsZXNzIHRoYW4gNjQgYnl0ZXMgc2luY2UgdGhpcyBzZWVtcyB0
byBiZSANCkNoYWNoYTIwIGJsb2NrIHNpemUsIHNvIGlmIHdlIGdvIGxvd2VyLCB3ZSB3aWxsIHRy
YXNoIHVzZWZ1bCBiaXRzLiANCllvdSBjYW4gZ28gZXZlbiBoaWdoZXIgdGhhbiA0MDk2IGJ5dGVz
LCBidXQgZXZlbiB0aGlzIGxvb2tzIGxpa2UgDQpva2lzaCBwZXJmb3JtYW5jZSB0byBtZS4gDQoN
CkJlbG93IGlzIGEgc25pcCBvZiB3aGF0IEkgcXVpY2tseSBkaWQgKHJlbGV2YW50IHBhcnRzKSB0
byBnZXQgdGhlc2UgbnVtYmVycy4NCkkgZG8gaW5pdGlhbCBwb3B1bGF0aW9uIG9mIHBlci1jcHUg
YnVmZmVycyBpbiBsYXRlX2luaXRjYWxsLCBidXQgDQpwcmFjdGljZSBzaG93cyB0aGF0IHJuZyBt
aWdodCBub3QgYWx3YXlzIGJlIGluIGdvb2Qgc3RhdGUgYnkgdGhlbi4gDQpTbywgd2UgbWlnaHQg
bm90IGhhdmUgcmVhbGx5IGdvb2QgcmFuZG9tbmVzcyB0aGVuLCBidXQgSSBhbSBub3Qgc3VyZQ0K
aWYgdGhpcyBpcyBhIHByYWN0aWNhbCBwcm9ibGVtIHNpbmNlIGl0IG9ubHkgYXBwbGllcyB0byBz
eXN0ZW0gYm9vdCBhbmQgYnkNCnRoZSB0aW1lIGl0IGJvb3RlZCwgaXQgYWxyZWFkeSBpc3N1ZWQg
ZW5vdWdoIHN5c2NhbGxzIHRoYXQgYnVmZmVyIGdldHMgcmVmaWxsZWQNCndpdGggcmVhbGx5IGdv
b2QgbnVtYmVycy4gDQpBbHRlcm5hdGl2ZWx5IHdlIGNhbiBhbHNvIGRvIGl0IG9uIHRoZSBmaXJz
dCBzeXNjYWxsIHRoYXQgZWFjaCBjcHUgZ2V0cywgYnV0IEkgDQphbSBub3Qgc3VyZSBpZiB0aGF0
IGlzIGFsd2F5cyBndWFyYW50ZWVkIHRvIGhhdmUgYSBnb29kIHJhbmRvbW5lc3MuIA0KDQorI2lm
ZGVmIENPTkZJR19SQU5ET01JWkVfS1NUQUNLX09GRlNFVA0KKyNpbmNsdWRlIDxsaW51eC9yYW5k
b20uaD4NCisNCit2b2lkICpfX2J1aWx0aW5fYWxsb2NhKHNpemVfdCBzaXplKTsNCisNCisjZGVm
aW5lIGFkZF9yYW5kb21fc3RhY2tfb2Zmc2V0KCkgZG8geyAgICAgICAgICAgICAgIFwNCisgICAg
c2l6ZV90IG9mZnNldCA9IHJhbmRvbV9nZXRfYnl0ZSgpOyAgIFwNCisgICAgY2hhciAqcHRyID0g
X19idWlsdGluX2FsbG9jYShvZmZzZXQpOyAgICAgICAgICAgIFwNCisgICAgYXNtIHZvbGF0aWxl
KCIiOiI9bSIoKnB0cikpOyAgICAgICAgICAgICAgICAgICAgIFwNCit9IHdoaWxlICgwKQ0KKyNl
bHNlDQorI2RlZmluZSBhZGRfcmFuZG9tX3N0YWNrX29mZnNldCgpIGRvIHt9IHdoaWxlICgwKQ0K
KyNlbmRpZg0KDQouLi4NCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcmFuZG9tLmggYi9p
bmNsdWRlL2xpbnV4L3JhbmRvbS5oDQppbmRleCA0NDVhMGVhNGZmNDkuLjlmYmNlOWQ2ZWU3MCAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcmFuZG9tLmgNCisrKyBiL2luY2x1ZGUvbGludXgv
cmFuZG9tLmgNCkBAIC0xMTUsNiArMTE1LDE1IEBAIHN0cnVjdCBybmRfc3RhdGUgew0KICAgICBf
X3UzMiBzMSwgczIsIHMzLCBzNDsNCiB9Ow0KIA0KKyNkZWZpbmUgUkFORE9NX0JVRkZFUl9TSVpF
IDY0DQorLyogc3RydWN0dXJlIHRvIGhvbGQgcmFuZG9tIGJpdHMgKi8NCitzdHJ1Y3Qgcm5kX2J1
ZmZlciB7DQorICAgIHVuc2lnbmVkIGNoYXIgYnVmZmVyW1JBTkRPTV9CVUZGRVJfU0laRV07DQor
ICAgIF9fdTY0IGJ5dGVfY291bnRlcjsNCit9Ow0KK3Vuc2lnbmVkIGNoYXIgcmFuZG9tX2dldF9i
eXRlKHZvaWQpOw0KKw0KKw0KIA0KLi4uLg0KDQpkaWZmIC0tZ2l0IGEvbGliL3BlcmNwdS1yYW5k
b20uYyBiL2xpYi9wZXJjcHUtcmFuZG9tLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwMDAwMDAuLjNmOTJjNDRmYmMxYQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvbGliL3BlcmNw
dS1yYW5kb20uYw0KQEAgLTAsMCArMSw0OSBAQA0KKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
KyNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4NCisjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+DQor
DQorc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBybmRfYnVmZmVyLCBzdGFja19yYW5kX29m
ZnNldCkgX19sYXRlbnRfZW50cm9weTsNCisNCisNCisvKg0KKyAqICAgIEdlbmVyYXRlIHNvbWUg
aW5pdGlhbGx5IHdlYWsgc2VlZGluZyB2YWx1ZXMgdG8gYWxsb3cNCisgKiAgICB0byBzdGFydCB0
aGUgcHJhbmRvbV91MzIoKSBlbmdpbmUuDQorICovDQorc3RhdGljIGludCBfX2luaXQgc3RhY2tf
cmFuZF9vZmZzZXRfaW5pdCh2b2lkKQ0KK3sNCisgICAgaW50IGk7DQorDQorICAgIC8qIGV4Y3Ry
YWN0IGJpdHMgdG8gb3V0IHBlci1jcHUgcmFuZCBidWZmZXJzICovDQorICAgIGZvcl9lYWNoX3Bv
c3NpYmxlX2NwdShpKSB7DQorICAgICAgICBzdHJ1Y3Qgcm5kX2J1ZmZlciAqYnVmZmVyID0gJnBl
cl9jcHUoc3RhY2tfcmFuZF9vZmZzZXQsIGkpOw0KKyAgICAgICAgYnVmZmVyLT5ieXRlX2NvdW50
ZXIgPSAwOw0KKyAgICAgICAgLyogaWYgcm5nIGlzIG5vdCBpbml0aWFsaXplZCwgdGhpcyB3b24n
dCBleHRyYWN0IHVzIGdvb2Qgc3R1ZmYNCisgICAgICAgICAqIGJ1dCB3ZSBjYW5ub3Qgd2FpdCBm
b3Igcm5nIHRvIGluaXRpYWxpemUgZWl0aGVyICovDQorICAgICAgICBnZXRfcmFuZG9tX2J5dGVz
KCYoYnVmZmVyLT5idWZmZXIpLCBzaXplb2YoYnVmZmVyLT5idWZmZXIpKTsNCisNCisgICAgfQ0K
Kw0KKyAgICByZXR1cm4gMDsNCit9DQorbGF0ZV9pbml0Y2FsbChzdGFja19yYW5kX29mZnNldF9p
bml0KTsNCisNCit1bnNpZ25lZCBjaGFyIHJhbmRvbV9nZXRfYnl0ZSh2b2lkKQ0KK3sNCisgICAg
c3RydWN0IHJuZF9idWZmZXIgKmJ1ZmZlciA9ICZnZXRfY3B1X3ZhcihzdGFja19yYW5kX29mZnNl
dCk7DQorICAgIHVuc2lnbmVkIGNoYXIgcmVzOw0KKw0KKyAgICBpZiAoYnVmZmVyLT5ieXRlX2Nv
dW50ZXIgPj0gUkFORE9NX0JVRkZFUl9TSVpFKSB7DQorICAgICAgICBnZXRfcmFuZG9tX2J5dGVz
KCYoYnVmZmVyLT5idWZmZXIpLCBzaXplb2YoYnVmZmVyLT5idWZmZXIpKTsNCisgICAgICAgIGJ1
ZmZlci0+Ynl0ZV9jb3VudGVyID0gMDsNCisgICAgfQ0KKw0KKyAgICByZXMgPSBidWZmZXItPmJ1
ZmZlcltidWZmZXItPmJ5dGVfY291bnRlcl07DQorICAgIGJ1ZmZlci0+YnVmZmVyW2J1ZmZlci0+
Ynl0ZV9jb3VudGVyXSA9IDA7DQorICAgIGJ1ZmZlci0+Ynl0ZV9jb3VudGVyICsrOw0KKyAgICAg
cHV0X2NwdV92YXIoc3RhY2tfcmFuZF9vZmZzZXQpOw0KKyAgICByZXR1cm4gcmVzOw0KK30NCitF
WFBPUlRfU1lNQk9MKHJhbmRvbV9nZXRfYnl0ZSk7DQo=
