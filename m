Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46936C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146612075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfD2Hqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:46:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:42393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfD2Hqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:46:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 00:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="165832396"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2019 00:46:42 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0415.000;
 Mon, 29 Apr 2019 08:46:41 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Eric Biggers <ebiggers3@gmail.com>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGA
Date:   Mon, 29 Apr 2019 07:46:41 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
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
In-Reply-To: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWNkZWNhMDMtMDlhMy00OGRjLWIxYzMtN2ZjOGUxZTM4MDZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQmdpRHlJXC9FRTBBQzdRYlE4WEJWOVZVdDFNZmJZamttSkV0V0ZkaXlsWFhuUlFOdzRNUlF0d1wvUlpoSkx6cmVnIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gT24gQXByIDI2LCAyMDE5LCBhdCA3OjAxIEFNLCBUaGVvZG9yZSBUcydvIDx0eXRzb0Bt
aXQuZWR1PiB3cm90ZToNCj4gPg0KPiA+PiBPbiBGcmksIEFwciAyNiwgMjAxOSBhdCAxMTozMzow
OUFNICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3RlOg0KPiA+PiBBZGRpbmcgRXJpYyBhbmQg
SGVyYmVydCB0byBjb250aW51ZSBkaXNjdXNzaW9uIGZvciB0aGUgY2hhY2hhIHBhcnQuDQo+ID4+
IFNvLCBhcyBhIHNob3J0IHN1bW1hcnkgSSBhbSB0cnlpbmcgdG8gZmluZCBvdXQgYSBmYXN0IChm
YXN0IGVub3VnaCB0byBiZSB1c2VkIHBlcg0KPiBzeXNjYWxsDQo+ID4+IGludm9jYXRpb24pIHNv
dXJjZSBvZiByYW5kb20gYml0cyB3aXRoIGdvb2QgZW5vdWdoIHNlY3VyaXR5IHByb3BlcnRpZXMu
DQo+ID4+IEkgc3RhcnRlZCB0byBsb29rIGludG8gY2hhY2hhIGtlcm5lbCBpbXBsZW1lbnRhdGlv
biBhbmQgd2hpbGUgaXQgc2VlbXMgdGhhdCBpdCBpcw0KPiBkZXNpZ25lZCB0bw0KPiA+PiB3b3Jr
IHdpdGggYW55IG51bWJlciBvZiByb3VuZHMsIGl0IGRvZXMgbm90IGV4cG9zZSBsZXNzIHRoYW4g
MTIgcm91bmRzIHByaW1pdGl2ZS4NCj4gPj4gSSBndWVzcyB0aGlzIGlzIGRvbmUgZm9yIHNlY3Vy
aXR5IHNha2UsIHNpbmNlIDEyIGlzIHByb2JhYmx5IHRoZSBsb3dlc3QgYm91bmQgd2UNCj4gd2Fu
dCBwZW9wbGUNCj4gPj4gdG8gdXNlIGZvciB0aGUgcHVycG9zZSBvZiBlbmNyeXB0aW9uL2RlY3J5
cHRpb24sIGJ1dCBpZiB3ZSBhcmUgdG8gYnVpbGQgYW4gZWZmaWNpZW50DQo+IFJORywNCj4gPj4g
Y2hhY2hhOCBwcm9iYWJseSBpcyBhIGdvb2QgdHJhZGVvZmYgYmV0d2VlbiBzZWN1cml0eSBhbmQg
c3BlZWQuDQo+ID4+DQo+ID4+IFdoYXQgYXJlIHBlb3BsZSdzIG9waW5pb25zL3BlcmNlcHRpb25z
IG9uIHRoaXM/IEhhcyBpdCBiZWVuIGNvbnNpZGVyZWQgYmVmb3JlIHRvDQo+IGNyZWF0ZSBhDQo+
ID4+IGtlcm5lbCBSTkcgYmFzZWQgb24gY2hhY2hhPw0KPiA+DQo+ID4gV2VsbCwgc3VyZS4gIFRo
ZSBnZXRfcmFuZG9tX2J5dGVzKCkga2VybmVsIGludGVyZmFjZSBhbmQgdGhlDQo+ID4gZ2V0cmFu
ZG9tKDIpIHN5c3RlbSBjYWxsIHVzZXMgYSBDUk5HIGJhc2VkIG9uIGNoYWNoYTIwLiAgU2VlDQo+
ID4gZXh0cmFjdF9jcm5nKCkgYW5kIGNybmdfcmVzZWVkKCkgaW4gZHJpdmVycy9jaGFyL3JhbmRv
bS5jLg0KPiA+DQo+ID4gSXQgKmlzKiBwb3NzaWJsZSB0byB1c2UgYW4gYXJiaXRyYXJ5IG51bWJl
ciBvZiByb3VuZHMgaWYgeW91IHVzZSB0aGUNCj4gPiBsb3cgbGV2ZWwgaW50ZXJmYWNlIGV4cG9z
ZWQgYXMgY2hhY2hhX2Jsb2NrKCksIHdoaWNoIGlzIGFuDQo+ID4gRVhQT1JUX1NZTUJPTCBpbnRl
cmZhY2Ugc28gZXZlbiBtb2R1bGVzIGNhbiB1c2UgaXQuICAiRG9lcyBub3QgZXhwb3NlDQo+ID4g
bGVzcyB0aGFuIDEyIHJvdW5kcyIgYXBwbGllcyBvbmx5IGlmIHlvdSBhcmUgdXNpbmcgdGhlIGhp
Z2gtbGV2ZWwNCj4gPiBjcnlwdG8gaW50ZXJmYWNlLg0KPiA+DQo+ID4gV2UgaGF2ZSB1c2VkIGN1
dCBkb3duIGNyeXB0byBhbGdvcml0aG1zIGZvciBwZXJmb3JtYW5jZSBjcml0aWNhbA0KPiA+IGFw
cGxpY2F0aW9ucyBiZWZvcmU7IGF0IG9uZSBwb2ludCwgd2Ugd2VyZSB1c2luZyBhIGN1dCBkb3du
IE1ENCghKSBmb3INCj4gPiBpbml0aWFsIFRDUCBzZXF1ZW5jZSBudW1iZXIgZ2VuZXJhdGlvbi4g
IEJ1dCB0aGF0IHdhcyBnZXR0aW5nIHJla2V5ZWQNCj4gPiBldmVyeSBmaXZlIG1pbnV0ZXMsIGFu
ZCB0aGUgZ29hbCB3YXMgdG8gbWFrZSBpdCBqdXN0IGhhcmQgZW5vdWdoIHRoYXQNCj4gPiB0aGVy
ZSB3ZXJlIG90aGVyIGVhc2llciB3YXlzIG9mIERPUyBhdHRhY2tpbmcgYSBzZXJ2ZXIuDQo+ID4N
Cj4gPiBJJ20gbm90IGEgY3J5cHRvZ3JhcGhlciwgc28gSSdkIHJlYWxseSB1cyB0byBoZWFyIGZy
b20gbXVsdGlwbGUNCj4gPiBleHBlcnRzIGFib3V0IHRoZSBzZWN1cml0eSBsZXZlbCBvZiwgc2F5
LCBDaGFDaGE4IHNvIHdlIHVuZGVyc3RhbmQNCj4gPiBleGFjdGx5IGtpbmQgb2Ygc2VjdXJpdHkg
d2UnZCBvZmZlcmluZy4gIEFuZCBJJ2Qgd2FudCB0aGF0IGludGVyZmFjZQ0KPiA+IHRvIGJlIG5h
bWVkIHNvIHRoYXQgaXQncyBjbGVhciBpdCdzIG9ubHkgaW50ZW5kZWQgZm9yIGEgdmVyeSBzcGVj
aWZpYw0KPiA+IHVzZSBjYXNlLCBzaW5jZSBpdCB3aWxsIGJlIHRlbXB0aW5nIGZvciBvdGhlciBr
ZXJuZWwgZGV2ZWxvcGVycyB0byB1c2UNCj4gPiBpdCBpbiBvdGhlciBjb250ZXh0cywgd2l0aCB1
bmR1ZSBjb25zaWRlcmF0aW9uLg0KPiA+DQo+ID4NCj4gDQo+IEkgZG9u4oCZdCB1bmRlcnN0YW5k
IHdoeSB3ZeKAmXJlIGV2ZW4gY29uc2lkZXJpbmcgd2Vha2VyIHByaW1pdGl2ZXMuIA0KDQpJIGd1
ZXNzIG9uZSByZWFzb25pbmcgaGVyZSB3YXMgdGhhdCBjcnlwdG9ncmFwaGljIHByaW1pdGl2ZXMg
YXJlIGV4cGVuc2l2ZSBwZXJmb3JtYW5jZS13aXNlDQphbmQgd2UgYXJlIG5vdCByZWFsbHkgaGF2
ZSBhIGZ1bGwgY3J5cHRvIHVzZSBjYXNlIGhlcmUgd2l0aCBhbGwgc3RhbmRhcmQgcmVxdWlyZW1l
bnRzDQpmb3IgQ1JORywgc3VjaCBhcyByZWNvbnN0cnVjdGluZyBlYXJsaWVyIGlucHV0cywgZXRj
LiBTbywgaXQgd2FzIGEgbmF0dXJhbCB3aXNoIHRvIHRyeSB0byBmaW5kIHNtdGgNCmNoZWFwZXIg
dGhhdCBkb2VzIHRoZSBqb2IsIGJ1dCBpZiB3ZSBjYW4gbWFrZSBwZXJmb3JtYW5jZSByZWFzb25h
YmxlLCBJIGFtIGFsbCBmb3IgdGhlDQpwcm9wZXIgcHJpbWl0aXZlcy4gDQoNCj5JdCBzZWVtcyB0
byBtZQ0KPiB0aGF0IHdlIHNob3VsZCBiZSB1c2luZyB0aGUg4oCcZmFzdC1lcmFzdXJl4oCdIGNv
bnN0cnVjdGlvbiBmb3IgYWxsIGdldF9yYW5kb21fYnl0ZXMoKQ0KPiBpbnZvY2F0aW9ucy4gU3Bl
Y2lmaWNhbGx5LCB3ZSBzaG91bGQgaGF2ZSBhIHBlciBjcHUgYnVmZmVyIHRoYXQgc3RvcmVzIHNv
bWUgcmFuZG9tDQo+IGJ5dGVzIGFuZCBhIGNvdW50IG9mIGhvdyBtYW55IHJhbmRvbSBieXRlcyB0
aGVyZSBhcmUuIGdldF9yYW5kb21fYnl0ZXMoKSBzaG91bGQNCj4gdGFrZSBieXRlcyBmcm9tIHRo
YXQgYnVmZmVyIGFuZCAqaW1tZWRpYXRlbHkqIHplcm8gdGhvc2UgYnl0ZXMgaW4gbWVtb3J5LiBX
aGVuDQo+IHRoZSBidWZmZXIgaXMgZW1wdHksIGl0IGdldHMgcmVmaWxsZWQgd2l0aCB0aGUgZnVs
bCBzdHJlbmd0aCBDUk5HLg0KDQpJZGVhbGx5IGl0IHdvdWxkIGJlIGdyZWF0IHRvIGNhbGwgc210
aCBmYXN0IGFuZCBzZWN1cmUgb24gZWFjaCBzeXNjYWxsIHdpdGhvdXQgYSBwZXItY3B1DQpidWZm
ZXIsIHNvIHRoYXQncyB3aHkgSSB3YXMgYXNraW5nIG9uIGNoYWNoYTguIEFzIEVyaWMgcG9pbnRl
ZCBpdCBzaG91bGQgbm90IGJlIHVzZWQgZm9yDQpjcnlwdG9ncmFwaGljIHB1cnBvc2UsIGJ1dCBJ
IHRoaW5rIGl0IGlzIHJlYXNvbmFibHkgc2VjdXJlIGZvciBvdXIgcHVycG9zZSwgZXNwZWNpYWxs
eSBpZg0KdGhlIGdlbmVyYXRvciBpcyBzb21ldGltZXMgcmVzZWVkZWQgd2l0aCBmcmVzaCBlbnRy
b3B5LiANCkhvd2V2ZXIsIGl0IHZlcnkgd2VsbCBtaWdodCBiZSB0aGF0IGlzIHRvbyBzbG93IGFu
eXdheS4gDQoNClNvLCBJIHRoaW5rIHRoZW4gd2UgY2FuIGRvIHRoZSBwZXItY3B1IGFwcHJvYWNo
IGFzIHlvdSBzdWdnZXN0aW5nLiANCkhhdmUgYSBwZXItY3B1IGJ1ZmZlciBiaWcgZW5vdWdoIGFz
IHlvdSBzdWdnZXN0ZWQgKGNvdXBsZSBvZiBwYWdlcykgZnJvbSB3aGVyZQ0Kd2UgcmVndWxhcmx5
IHJlYWQgOCBiaXRzIGF0IHRoZSB0aW1lIGFuZCB6ZXJvIHRoZW0gYXMgd2UgZ28uIA0KDQpJIGFt
IGp1c3Qgbm90IHN1cmUgb24gdGhlIHJpZ2h0IHJlZmlsbCBzdHJhdGVneSBpbiB0aGlzIGNhc2U/
DQpTaG91bGQgd2UgdHJ5IHRvIG1haW50YWluIHRoaXMgcGVyLWNwdSBidWZmZXIgYWx3YXlzIHdp
dGggc29tZSByYW5kb20gYnl0ZXMgYnkNCmhhdmluZyBhIHdvcmsgcXVldWVkIHRoYXQgd291bGQg
cmVmaWxsIGl0IChvciBwYXJ0IG9mIGl0LCBpLmUuIGEgcGFnZSBmcm9tIGEgc2V0IG9mIDQgcGFn
ZXMpIA0KcmVndWxhcmx5IGZyb20gQ1JORyBzb3VyY2U/IA0KSSBndWVzcyBob3cgb2Z0ZW4gd2Ug
bmVlZCB0byByZWZpbGwgd2lsbCBkZXBlbmQgc28gbXVjaCBvbiB0aGUgc3lzY2FsbCByYXRlDQpv
biB0aGF0IGNwdSwgc28gaXQgbWlnaHQgYmUgaGFyZCB0byBmaW5kIGEgcmVhc29uYWJsZSBwZXJp
b2QuDQpJbiBhbnkgY2FzZSB3ZSBuZWVkIHRvIHByZXBhcmUgdG8gZG8gYSByZWZpbGwgc3RyYWln
aHQgZnJvbSBhIHN5c2NhbGwsDQppZiBkZXNwaXRlIG91ciBiZXN0IGVmZm9ydHMgdG8ga2VlcCB0
aGUgYnVmZmVyIHJlZmlsbGVkIHdlIHJ1biBvdXQgb2YgYml0cy4NCklzIGl0IG9rIHRvIGdldCBh
IHZpc2libGUgcGVyZm9ybWFuY2UgaGl0IGF0IHRoaXMgcG9pbnQ/IEluIHdvcnNlIGNhc2Ugd2Ug
d2lsbCBuZWVkIHRvDQpnZW5lcmF0ZSBuIHBhZ2VzIHdvcnRoIG9mIHJhbmRvbSBudW1iZXJzLCB3
aGljaCBpcyBnb2luZyB0byB0YWtlIGENCndoaWxlLiANCg0KSSB3aWxsIHRyeSBkb2luZyB0aGlz
IFBvQyBhbmQgbWVhc3VyZSBpbXBsaWNhdGlvbnMgKHdpdGhvdXQgdGhlIHdvcmtlcg0KcmVmaWxs
IHRvIHN0YXJ0IHdpdGgpLiBMZXQncyBzZWUgaG93IGJhZCAocGVyZm9ybWFuY2Ugd2lzZSBpdCBs
b29rcykuDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQoNCg0KDQogDQo+IFRoZSBvYnZpb3Vz
IG9iamVjdGlvbiBpcyDigJxvaCBubywgYSBzaWRlIGNoYW5uZWwgY291bGQgbGVhayB0aGUgYnVm
ZmVyLOKAnSB0byB3aGljaCBJIHNheQ0KPiBzbyB3aGF0PyAgQSBzaWRlIGNoYW5uZWwgY291bGQg
anVzdCBhcyBlYXNpbHkgbGVhayB0aGUgZW50aXJlIENSTkcgc3RhdGUuDQo+IA0KPiBGb3IgRWxl
bmHigJlzIHNwZWNpZmljIHVzZSBjYXNlLCB3ZSB3b3VsZCBwcm9iYWJseSB3YW50IGENCj4gdHJ5
X2dldF9yYW5kb21fYnl0ZXNfbm90cmFjZSgpIHRoYXQgKm9ubHkqIHRyaWVzIHRoZSBwZXJjcHUg
YnVmZmVyLCBzaW5jZSB0aGlzIGNvZGUNCj4gcnVucyBzbyBlYXJseSBpbiB0aGUgc3lzY2FsbCBw
YXRoIHRoYXQgd2UgY2Fu4oCZdCBydW4gcmVhbCBDIGNvZGUuICBPciBpdCBjb3VsZCBiZSBtb3Zl
ZCBhDQo+IGJpdCBsYXRlciwgSSBzdXBwb3NlIOKAlCB0aGUgcmVhbGx5IGVhcmx5IHBhcnQgaXMg
bm90IHJlYWxseSBhbiBpbnRlcmVzdGluZyBhdHRhY2sgc3VyZmFjZS4NCg==
