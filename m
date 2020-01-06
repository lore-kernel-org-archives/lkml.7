Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D0C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927B92072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:22:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:50881 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAFJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:22:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 01:22:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="302827811"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2020 01:22:10 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 01:22:10 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 01:22:09 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.30]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.202]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 17:22:08 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Topic: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Index: AQHVxFzlxQRcQtSYTE6XKuL77zdvEafcsTeAgACpkyA=
Date:   Mon, 6 Jan 2020 09:22:06 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A615FC2FF@SHSMSX101.ccr.corp.intel.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
 <20200106070759.GB12238@zn.tnic>
In-Reply-To: <20200106070759.GB12238@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA2LCAyMDIwIDM6MDggUE0N
Cj4gVG86IExpdSwgQ2h1YW5zaGVuZyA8Y2h1YW5zaGVuZy5saXVAaW50ZWwuY29tPg0KPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVs
LmNvbT47DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9y
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB4ODYvbWNlL3RoZXJtX3Rocm90OiBGaXggdGhl
IGFjY2VzcyBvZiB1bmluaXRpYWxpemVkDQo+IHRoZXJtX3dvcmsNCj4gDQo+IE9uIE1vbiwgSmFu
IDA2LCAyMDIwIGF0IDA2OjQxOjU1QU0gKzAwMDAsIENodWFuc2hlbmcgTGl1IHdyb3RlOg0KPiA+
IEluIElDTCBwbGF0Zm9ybSwgaXQgaXMgZWFzeSB0byBoaXQgYm9vdHVwIGZhaWx1cmUgd2l0aCBw
YW5pYw0KPiA+IGluIHRoZXJtYWwgaW50ZXJydXB0IGhhbmRsZXIgZHVyaW5nIGVhcmx5IGJvb3R1
cCBzdGFnZS4NCj4gPg0KPiA+IFN1Y2ggaXNzdWUgbWFrZXMgbXkgcGxhdGZvcm0gYWxtb3N0IGNh
biBub3QgYm9vdCB1cCB3aXRoDQo+ID4gbGF0ZXN0IGtlcm5lbCBjb2RlLg0KPiA+DQo+ID4gVGhl
IGNhbGwgc3RhY2sgaXMgbGlrZToNCj4gPiBrZXJuZWwgQlVHIGF0IGtlcm5lbC90aW1lci90aW1l
ci5jOjExNTIhDQo+ID4NCj4gPiBDYWxsIFRyYWNlOg0KPiA+IF9fcXVldWVfZGVsYXllZF93b3Jr
DQo+ID4gcXVldWVfZGVsYXllZF93b3JrX29uDQo+ID4gdGhlcm1fdGhyb3RfcHJvY2Vzcw0KPiA+
IGludGVsX3RoZXJtYWxfaW50ZXJydXB0DQo+ID4gLi4uDQo+ID4NCj4gPiBXaGVuIG9uZSBDUFUg
aXMgdXAsIHRoZSBpcnEgaXMgZW5hYmxlZCBwcmlvciB0byBDUFUgVVANCj4gPiBub3RpZmljYXRp
b24gd2hpY2ggd2lsbCB0aGVuIGluaXRpYWxpemUgdGhlcm1fd29ya2VyLg0KPiANCj4gWW91IG1l
YW4gdGhlIHVubWFza2luZyBvZiB0aGUgdGhlcm1hbCB2ZWN0b3IgYXQgdGhlIGVuZCBvZg0KPiBp
bnRlbF9pbml0X3RoZXJtYWwoKT8NCkV4YWN0bHksIGFuZCB0aGVyZSBpcyBvbmUgbG9jYWwgQ1BV
IGlycSBlbmFibGUgbGF0ZXIgdG9vLg0KDQo+IA0KPiBJZiBzbywgd2h5IGRvbid0IHlvdSBtb3Zl
IHRoYXQgdG8gdGhlIGVuZCBvZiB0aGUgbm90aWZpZXIgYW5kIHVubWFzayBpdA0KPiBvbmx5IGFm
dGVyIGFsbCB0aGUgbmVjZXNzYXJ5IHdvcmsgbGlrZSBzZXR0aW5nIHVwIHRoZSB3b3JrcXVldWVz
IGV0YywgaXMNCj4gZG9uZSwgYW5kIHNhdmUgeW91cnNlbGYgYWRkaW5nIHlldCBhbm90aGVyIHNp
bGx5IGJvb2w/DQo+IA0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIEkgYW0ganVzdCB3b3Jy
aWVkIGFib3V0IHRoZSBpbnRlcnJ1cHQgZGVsYXkuDQpJIHRyYWNlZCB0aGVyZSBpcyBhYm91dCAy
cyBnYXAgYmV0d2VlbiB1bm1hc2sgaW50ZXJydXB0IGFuZCB3b3JrcXVldWUNCkluaXRpYWxpemF0
aW9uLiBJZiB5b3UgdGhpbmsgaXQgaXMgT0sgdG8gaWdub3JlIHRoaXMgZGVsYXksIEkgd2lsbCBt
YWtlIGFub3RoZXINCnNpbXBsZSBwYXRjaCBhcyB5b3Ugc3VnZ2VzdGVk8J+Yig0KDQpCZXN0IFJl
Z2FyZHMNCkNodWFuc2hlbmcNCg0KDQo=
