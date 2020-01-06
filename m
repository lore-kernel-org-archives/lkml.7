Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A621C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361582072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:10:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:10149 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFKKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:10:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 02:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="245537325"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 02:10:14 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 02:10:14 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 02:10:13 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.30]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.55]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 18:10:12 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Boris Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Topic: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Index: AQHVxFzlxQRcQtSYTE6XKuL77zdvEafcsTeAgACpkyD//4bigIAAh4jg
Date:   Mon, 6 Jan 2020 10:10:11 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A615FC376@SHSMSX101.ccr.corp.intel.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
 <20200106070759.GB12238@zn.tnic>
 <27240C0AC20F114CBF8149A2696CBE4A615FC2FF@SHSMSX101.ccr.corp.intel.com>
 <130561C3-5E52-4693-B15F-B89C8B8366B0@alien8.de>
In-Reply-To: <130561C3-5E52-4693-B15F-B89C8B8366B0@alien8.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgUGV0a292IDxi
cEBhbGllbjguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA2LCAyMDIwIDY6MDEgUE0NCj4g
VG86IExpdSwgQ2h1YW5zaGVuZyA8Y2h1YW5zaGVuZy5saXVAaW50ZWwuY29tPg0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVsLmNv
bT47DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9yLmNv
bQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSB4ODYvbWNlL3RoZXJtX3Rocm90OiBGaXggdGhlIGFj
Y2VzcyBvZiB1bmluaXRpYWxpemVkDQo+IHRoZXJtX3dvcmsNCj4gDQo+IE9uIEphbnVhcnkgNiwg
MjAyMCAxMDoyMjowNiBBTSBHTVQrMDE6MDAsICJMaXUsIENodWFuc2hlbmciDQo+IDxjaHVhbnNo
ZW5nLmxpdUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+SSB0cmFjZWQgdGhlcmUgaXMgYWJvdXQgMnMg
Z2FwIGJldHdlZW4gdW5tYXNrIGludGVycnVwdCBhbmQgd29ya3F1ZXVlDQo+ID5Jbml0aWFsaXph
dGlvbi4NCj4gDQo+IEFuZCB0aGF0IGlzIGEgcHJvYmxlbSBiZWNhdXNlPw0KPiANCj4gWW91IHNl
dHVwIHdvcmtxdWV1ZSBldGMgYW5kICp0aGVuKiB1bm1hc2sgdGhlIGlycS4NCj4gDQpTb21lIHBy
ZXZpb3VzIGV4cGVyaWVuY2Ugc2hvd3M6DQpJZiB0aGVyZSBpcyBjcml0aWNhbCB0aGVybWFsIGFs
ZXJ0LCB3ZSBzdGlsbCBjYW4gdGFrZSBhY3Rpb24gaW4ga2VybmVsIHNpZGUgaW4gdGhpcw0KMnMs
IGV2ZW4gdGhvdWdoIHRoZSB3b3JrcXVldWUgaXMgbm90IHJlYWR5LCBidXQgaW50ZXJydXB0IGhh
bmRsZXIgY2FuIHdvcmsNCndlbGwuDQoNCg0K
