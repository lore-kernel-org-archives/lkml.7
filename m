Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AC8206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfKKAjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:39:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:39067 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKKAjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:39:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 16:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,290,1569308400"; 
   d="scan'208";a="201908382"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 10 Nov 2019 16:39:17 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 10 Nov 2019 16:39:17 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 08:39:16 +0800
From:   "Zeng, Jason" <jason.zeng@intel.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Zeng, Jason" <jason.zeng@intel.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMIAAXpqAgAPI5iA=
Date:   Mon, 11 Nov 2019 00:39:15 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BC0DC@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
 <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
In-Reply-To: <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDk4ZTBhZTYtNWU2NS00MzA1LWFlYWItYmIzYmM2MjlkMjE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmdRN1wvMnpTVWVMTENzR0JGbkI5MzdndWtBVDZFaDV6YkVhWlNkZmIzV25NVm8ya2hIUmVOVEExYkNVWFwvTWQ5In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGb3IgVk1NIGxpdmUgdXBkYXRl
IGNhc2UsIHdlIHNob3VsZCBiZSBhYmxlIHRvIGRldGVjdCBhbmQgYnlwYXNzDQo+ID4gPiA+IHRo
ZSBzaHV0ZG93biB0aGF0IERlZXBhIGludHJvZHVjZWQgaGVyZSwgc28ga2VlcCBJT01NVSBzdGls
bA0KPiBvcGVyYXRpbmc/DQo+ID4gPg0KPiA+ID4gSXMgdGhhdCBhICd5ZXMnIHRvIERlZXBhJ3Mg
ImlmIHNvbWVvbmUgd2FudHMgdG8gbWFrZSBpdCBjb25kaXRpb25hbCwNCj4gPiA+IHdlIGNhbiBk
byB0aGF0IiA/DQo+ID4NCj4gPiBZZXMsIEkgdGhpbmsgc28uIFRoYW5rcyENCj4gDQo+IEFyZSB0
aGVzZSBjaGFuZ2VzIGFscmVhZHkgcGFydCBvZiB0aGUga2VybmVsIGxpa2UgYXZvaWRpbmcgc2h1
dGRvd24gb2YgdGhlDQo+IHBhc3N0aHJvdWdoIGRldmljZXM/IGRldmljZV9zaHV0ZG93bigpIGRv
ZXNuJ3Qgc2VlbSB0byBiZSBkb2luZyBhbnl0aGluZw0KPiBzZWxlY3RpdmVseSBhcyBvZiBub3cu
DQo+IA0KDQpObywgaXQgaXMgbm90IGluIHVwc3RyZWFtIHlldC4gSXQgaXMgYW4gb24tZ29pbmcg
ZWZmb3J0LCB3aGljaCB0cmllcyB0byBrZXhlYyByZWJvb3QNCnRoZSBob3N0IHdoaWxlIGtlZXBp
bmcgSU9NTVUgc3RpbGwgd29ya2luZy4NCg0KVGhhbmtzLA0KSmFzb24NCg0KPiBUaGFua3MsDQo+
IERlZXBhDQo=
