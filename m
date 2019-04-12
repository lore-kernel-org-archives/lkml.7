Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9132077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLFgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:36:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:58206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfDLFgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:36:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 22:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="163629984"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2019 22:36:19 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.31]) with mapi id 14.03.0415.000;
 Fri, 12 Apr 2019 06:36:18 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU7dJsIdze6jSaA0qMnvHjeKNle6YyJqcAgALbMACAABmnEIAAFjjggAA73ICAApmxEA==
Date:   Fri, 12 Apr 2019 05:36:18 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C4C052@IRSMSX102.ger.corp.intel.com>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble> <20190410082642.GA35032@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48B15@IRSMSX102.ger.corp.intel.com>
 <CALCETrWA8r6_zbfrYV-E-iykoEj-Fw=HeRQ5mAM4iSPrfU8jKw@mail.gmail.com>
In-Reply-To: <CALCETrWA8r6_zbfrYV-E-iykoEj-Fw=HeRQ5mAM4iSPrfU8jKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2JjMDlmYzUtNTU5OS00YzQ4LWFiY2YtMzNkNWRjY2MxMDVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUzZ6eForVjkxbUpiSVZueHduQ3J6c0JBM1VMcW42TlwvWnFBWm1SelZFTlNuOXJsVWttM3F5c1Y3ME40RVFTMEIifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEFwciAxMCwgMjAxOSBhdCAzOjI0IEFNIFJlc2hldG92YSwgRWxlbmENCj4gPGVs
ZW5hLnJlc2hldG92YUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+ID4gPiBPbiBN
b24sIEFwciAwOCwgMjAxOSBhdCAwOToxMzo1OEFNICswMzAwLCBFbGVuYSBSZXNoZXRvdmEgd3Jv
dGU6DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvY29tbW9uLmMgYi9h
cmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KPiA+ID4gPiA+ID4gaW5kZXggN2JjMTA1ZjQ3ZDIxLi4z
OGRkYzIxM2E1ZTkgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9lbnRyeS9jb21t
b24uYw0KPiA+ID4gPiA+ID4gKysrIGIvYXJjaC94ODYvZW50cnkvY29tbW9uLmMNCj4gPiA+ID4g
PiA+IEBAIC0zNSw2ICszNSwxMiBAQA0KPiA+ID4gPiA+ID4gICNkZWZpbmUgQ1JFQVRFX1RSQUNF
X1BPSU5UUw0KPiA+ID4gPiA+ID4gICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvc3lzY2FsbHMuaD4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArI2lmZGVmIENPTkZJR19SQU5ET01JWkVfS1NUQUNL
X09GRlNFVA0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4NCj4gPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiA+ICt2b2lkICphbGxvY2Eoc2l6ZV90IHNpemUpOw0KPiA+ID4gPiA+
ID4gKyNlbmRpZg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gICNpZmRlZiBDT05GSUdfQ09O
VEVYVF9UUkFDS0lORw0KPiA+ID4gPiA+ID4gIC8qIENhbGxlZCBvbiBlbnRyeSBmcm9tIHVzZXIg
bW9kZSB3aXRoIElSUXMgb2ZmLiAqLw0KPiA+ID4gPiA+ID4gIF9fdmlzaWJsZSBpbmxpbmUgdm9p
ZCBlbnRlcl9mcm9tX3VzZXJfbW9kZSh2b2lkKQ0KPiA+ID4gPiA+ID4gQEAgLTI3Myw2ICsyNzks
MTMgQEAgX192aXNpYmxlIHZvaWQgZG9fc3lzY2FsbF82NCh1bnNpZ25lZCBsb25nIG5yLA0KPiBz
dHJ1Y3QNCj4gPiA+ID4gcHRfcmVncyAqcmVncykNCj4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4g
PiAgICAgICAgIHN0cnVjdCB0aHJlYWRfaW5mbyAqdGk7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gKyNpZmRlZiBDT05GSUdfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQNCj4gPiA+ID4gPiA+ICsg
ICAgICAgc2l6ZV90IG9mZnNldCA9ICgoc2l6ZV90KXByYW5kb21fdTMyKCkpICUgMjU2Ow0KPiA+
ID4gPiA+ID4gKyAgICAgICBjaGFyICpwdHIgPSBhbGxvY2Eob2Zmc2V0KTsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsgICAgICAgYXNtIHZvbGF0aWxlKCIiOiI9bSIoKnB0cikpOw0KPiA+
ID4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gICAgICAgICBlbnRl
cl9mcm9tX3VzZXJfbW9kZSgpOw0KPiA+ID4gPiA+ID4gICAgICAgICBsb2NhbF9pcnFfZW5hYmxl
KCk7DQo+ID4gPiA+ID4gPiAgICAgICAgIHRpID0gY3VycmVudF90aHJlYWRfaW5mbygpOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBhbHNvIGRvIHRoaXMgZm9y
IHRoZSBjb21wYXQgc3lzY2FsbHMNCj4gPiA+ID4gPiAoZG9fZmFzdF9zeXNjYWxsXzMyLCBkb19p
bnQ4MF9zeXNjYWxsXzMyKT8NCj4gPiA+ID4NCj4gPiA+ID4gQ291bGQgc29tZW9uZSBwbGVhc2Ug
aW5jbHVkZSB0aGUgZnVsbCBwYXRjaCwgd2l0aCBqdXN0aWZpY2F0aW9uIGFuZA0KPiA+ID4gPiBw
ZXJmb3JtYW5jZSBpbXBhY3QgYW5hbHlzaXMgZXRjLj8gQ2FuIG9ubHkgZmluZCB0aGUgY29kZSBw
YXJ0IG9mIHRoZQ0KPiA+ID4gPiB0aHJlYWQgb24gbGttbCwgd2hpY2ggbGVhdmVzIG91dCB0aGlz
IGNvbnRleHQuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gU29ycnksIHRoaXMgaXMgdmVyeSB3ZWly
ZCwgSSBjYW5ub3QgZmluZCBpdCBlaXRoZXIgZnJvbSBsa21sLCBidXQgaXQgd2FzIHNlbnQgdGhl
cmUNCj4gPiA+IHRvIGJlZ2luIHdpdGggKGFuZCBhcyB2aXNpYmxlIGZyb20gcmVwbHktdG8gaGVh
ZGVycykuDQo+ID4gPg0KPiA+ID4gRG8geW91IHdhbnQgbWUgdG8gcmVzZW50IG9yaWdpbmFsIHZl
cnNpb24gb3Igd2l0aCAiZG9fZmFzdF9zeXNjYWxsXzMyLA0KPiA+ID4gZG9faW50ODBfc3lzY2Fs
bF8zMiIgYWRkaXRpb25zIChJIGFtIGZpbmlzaGluZyB0ZXN0aW5nIHRoZW0gbm93KS4NCj4gPg0K
PiA+IEkgd2lsbCByZXNlbmQgdGhlIG9yaWdpbmFsIHg4Nl82NCBub3cgc2luY2UgdGhpcyBpcyB0
aGUgb25lIEkgdGVzdGVkIGFuZA0KPiA+IG1lYXN1cmVkIHByb3Blcmx5LiBUaGUgMzIgYml0IGNo
YW5nZXMgc2VlbSB0byB3b3JrIGZpbmUgaW5zaWRlIG15IDMyIGJpdCBWTSwNCj4gPiBidXQgc2lu
Y2UgSSBkb24ndCBoYXZlIGFueSByZWFsIDMyIGJpdCBIVywgSSBhbSBoZXNpdGFudCB0byBzZW5k
IHRoZW0gb3V0IHdpdGhvdXQNCj4gPiByZWFsIEhXIHRlc3RpbmcgYW5kIG1lYXN1cmluZy4NCj4g
Pg0KPiA+IFRoaXMgaXMgdGhlIGFzbSBjb2RlIGZvciAzMiBiaXRzIChub3RlIGl0IHJlcXVpcmVz
IF9fYnVpbHRpbl9hbGxvY2EgZGVmaW5pdGlvbiBhbmQgbm90DQo+IGp1c3QgYWxsb2NhLA0KPiA+
IHNvIEkgd2lsbCBjaGFuZ2UgdGhlIDY0IGJpdCB2ZXJzaW9uIHRvIHVzZSBpdCBhbHNvKToNCj4g
Pg0KPiA+ICNpZmRlZiBDT05GSUdfUkFORE9NSVpFX0tTVEFDS19PRkZTRVQNCj4gPiAgICAgc2l6
ZV90IG9mZnNldCA9ICgoc2l6ZV90KXByYW5kb21fdTMyKCkpICUgMjU2Ow0KPiA+IDB4YzEwMDI1
YjYgY2FsbCAgIDB4YzE0NmY3ZDAgPHByYW5kb21fdTMyPg0KPiA+IDB4YzEwMDI1YmIgbW92emJs
ICVhbCwlZWF4DQo+ID4gICAgIGNoYXIgKnB0ciA9IF9fYnVpbHRpbl9hbGxvY2Eob2Zmc2V0KTsN
Cj4gPiAweGMxMDAyNWJlIGFkZCAgICAkMHgxMiwlZWF4DQo+ID4gMHhjMTAwMjVjMSBhbmQgICAg
JDB4MWZjLCVlYXgNCj4gPiAweGMxMDAyNWM2IHN1YiAgICAlZWF4LCVlc3ANCj4gPiAweGMxMDAy
NWM4IGxlYSAgICAweDI3KCVlc3ApLCVlYXgNCj4gPiAweGMxMDAyNWNjIGFuZCAgICAkMHhmZmZm
ZmZmMCwlZWF4DQo+ID4NCj4gPiBBbHNvLCB0aGUgcmVzdWx0IGlzIDQ3IGRpZmZlcmVudCByYW5k
b20gb2Zmc2V0cyBwcm9kdWNlZCwNCj4gPiB3aGljaCBpcyBzbGlnaHRseSBiZXR0ZXIgdGhhbiAz
MyBvZmZzZXRzIGZvciB4ODZfNjQuDQo+ID4NCj4gDQo+IEkgd291bGQgc3VnZ2VzdCB0aGF0IHlv
dSBtYWNyby1pZnkgdGhpcyB0aGluZzoNCj4gDQo+ICNpZmRlZiBXSEFURVZFUg0KPiAjZGVmaW5l
IGFkZF9yYW5kb21fc3RhY2tfb2Zmc2V0KCkgZG8geyB2b2lkICphZGRyID0gLi4uIH0gd2hpbGUg
KDApDQo+ICNlbHNlDQo+ICNkZWZpbmUgYWRkX3JhbmRvbV9zdGFja19vZmZzZXQoKSBkbyB7fSB3
aGlsZSAoMCkNCj4gI2VuZGlmDQo+IA0KPiBzaW5jZSB5b3UnbGwgZW5kIHVwIHdpdGggbW9yZSB0
aGFuIG9uZSBjYWxsIHNpdGUuDQoNClN1cmUsIHdpbGwgZG8uIFNvLCB5b3UgYXJlIG9rIGZvciB0
aGlzIHRvIGJlIGFsc28gY2FsbGVkIGZyb20gZG9fZmFzdF9zeXNjYWxsXzMyDQphbmQgZG9faW50
ODBfc3lzY2FsbF8zMj8gSSBjYW4gc2VuZCB0aGUgcmVzdWx0aW5nIHBhdGNoLCBqdXN0IGNhbm5v
dCB0ZXN0IG9uIGFueQ0KcmVhbCAzMiBiaXQgSFcsIG9ubHkgVk0uIA0KDQpCZXN0IFJlZ2FyZHMs
DQpFbGVuYS4NCg==
