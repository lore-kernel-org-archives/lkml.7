Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA943C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53C3206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfHBGwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:52:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:39191 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbfHBGwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:52:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 23:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,337,1559545200"; 
   d="scan'208";a="372871607"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2019 23:52:11 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.52]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 23:52:11 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] fork: Improve error message for corrupted page tables
Thread-Topic: [PATCH] fork: Improve error message for corrupted page tables
Thread-Index: AQHVRyU2Tlnukuaks0aiZwfZ/9aV0qbmQJYAgAEtK5A=
Date:   Fri, 2 Aug 2019 06:52:10 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F9D62D6@ORSMSX114.amr.corp.intel.com>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
 <56ad91b8-1ea0-6736-5bc5-eea0ced01054@arm.com>
In-Reply-To: <56ad91b8-1ea0-6736-5bc5-eea0ced01054@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjE3Yzk5NjMtZDc4OC00ODc3LWI4OGEtOWEyMWE1MzM4ZmUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRXVaNFc2KzJWZ0h5dk11WXE1K3NzaVdldmNMeGd5RXlzenJXZXJOM2x3cE1Ncmg3SnJ0Y0VoN1wvWUpWek0wV0gifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiA+IENjOiBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24g
PGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gU3VnZ2VzdGVkLWJ5L0Fja2VkLWJ5OiBE
YXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiANCj4gVGhvdWdoIEkgYW0gbm90
IHN1cmUsIHNob3VsZCB0aGUgYWJvdmUgYmUgdHdvIHNlcGFyYXRlIGxpbmVzIGluc3RlYWQgPw0K
DQpTdXJlISBXaWxsIHNwbGl0IHRoZW0gaW4gVjIuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
U2FpIFByYW5lZXRoIFByYWtoeWEgPHNhaS5wcmFuZWV0aC5wcmFraHlhQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tbV90eXBlc190YXNrLmggfCA3ICsrKysrKysNCj4g
PiAga2VybmVsL2ZvcmsuYyAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tbV90eXBlc190YXNrLmgNCj4gPiBiL2luY2x1ZGUvbGludXgv
bW1fdHlwZXNfdGFzay5oIGluZGV4IGQ3MDE2ZGNiMjQ1ZS4uODgxZjRlYTNhMWI1DQo+ID4gMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbV90eXBlc190YXNrLmgNCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L21tX3R5cGVzX3Rhc2suaA0KPiA+IEBAIC00NCw2ICs0NCwxMyBAQCBlbnVt
IHsNCj4gPiAgCU5SX01NX0NPVU5URVJTDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdCByZXNpZGVudF9wYWdlX3R5cGVzW05SX01NX0NPVU5URVJTXSA9IHsNCj4g
PiArCSJNTV9GSUxFUEFHRVMiLA0KPiA+ICsJIk1NX0FOT05QQUdFUyIsDQo+ID4gKwkiTU1fU1dB
UEVOVFMiLA0KPiA+ICsJIk1NX1NITUVNUEFHRVMiLA0KPiA+ICt9Ow0KPiANCj4gU2hvdWxkIGlu
ZGV4IHRoZW0gdG8gbWF0Y2ggcmVzcGVjdGl2ZSB0eXBvIG1hY3Jvcy4NCj4gDQo+IAlbTU1fRklM
RVBBR0VTXSA9ICJNTV9GSUxFUEFHRVMiLA0KPiAJW01NX0FOT05QQUdFU10gPSAiTU1fQU5PTlBB
R0VTIiwNCj4gCVtNTV9TV0FQRU5UU10gPSAiTU1fU1dBUEVOVFMiLA0KPiAJW01NX1NITUVNUEFH
RVNdID0gIk1NX1NITUVNUEFHRVMiLA0KDQpTdXJlISBXaWxsIGNoYW5nZSBpdC4NCg0KPiA+ICsN
Cj4gPiAgI2lmIFVTRV9TUExJVF9QVEVfUFRMT0NLUyAmJiBkZWZpbmVkKENPTkZJR19NTVUpICAj
ZGVmaW5lDQo+ID4gU1BMSVRfUlNTX0NPVU5USU5HDQo+ID4gIC8qIHBlci10aHJlYWQgY2FjaGVk
IGluZm9ybWF0aW9uLCAqLw0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVs
L2ZvcmsuYyBpbmRleA0KPiA+IDI4NTJkMGU3NmVhMy4uNmFlZjU4NDJkNGUwIDEwMDY0NA0KPiA+
IC0tLSBhL2tlcm5lbC9mb3JrLmMNCj4gPiArKysgYi9rZXJuZWwvZm9yay5jDQo+ID4gQEAgLTY0
OSw4ICs2NDksOCBAQCBzdGF0aWMgdm9pZCBjaGVja19tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkN
Cj4gPiAgCQlsb25nIHggPSBhdG9taWNfbG9uZ19yZWFkKCZtbS0+cnNzX3N0YXQuY291bnRbaV0p
Ow0KPiA+DQo+ID4gIAkJaWYgKHVubGlrZWx5KHgpKQ0KPiA+IC0JCQlwcmludGsoS0VSTl9BTEVS
VCAiQlVHOiBCYWQgcnNzLWNvdW50ZXIgc3RhdGUgIg0KPiA+IC0JCQkJCSAgIm1tOiVwIGlkeDol
ZCB2YWw6JWxkXG4iLCBtbSwgaSwgeCk7DQo+ID4gKwkJCXByX2FsZXJ0KCJCVUc6IEJhZCByc3Mt
Y291bnRlciBzdGF0ZSBtbTolcCB0eXBlOiVzDQo+IHZhbDolbGRcbiIsDQo+ID4gKwkJCQkgbW0s
IHJlc2lkZW50X3BhZ2VfdHlwZXNbaV0sIHgpOw0KPiBJdCBjaGFuZ2VzIHRoZSBwcmludCBmdW5j
dGlvbiBhcyB3ZWxsLCB0aG91Z2ggdmVyeSBtaW5vciBjaGFuZ2UgYnV0IHBlcmhhcHMNCj4gbWVu
dGlvbiB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZSA/DQoNClN1cmUhIFdpbGwgbWVudGlvbiBp
dCBpbiBWMi4NCkkgaGF2ZSBjaGFuZ2VkIHByaW50aygpIHRvIHByX2FsZXJ0KCkgYmVjYXVzZSB0
aGUgb3RoZXIgbWVzc2FnZSBpbiBjaGVja19tbSgpIHVzZXMgcHJfYWxlcnQoKS4NCg0KUmVnYXJk
cywNClNhaQ0K
