Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABA215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKCfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:35:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:35111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfKKCfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:35:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 18:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="403673432"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2019 18:35:41 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 10 Nov 2019 18:35:41 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 10 Nov 2019 18:35:41 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.213]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 10:35:39 +0800
From:   "Zeng, Jason" <jason.zeng@intel.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "rminnich@google.com" <rminnich@google.com>,
        "Zeng, Jason" <jason.zeng@intel.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMIAAXpqAgALawYCAACUFgIAAyexg
Date:   Mon, 11 Nov 2019 02:35:38 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BC208@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
 <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
 <CABeXuvqMpXbSNasET4-u16Hrj710fe-V706tsFZhOTJoir8Xjw@mail.gmail.com>
 <CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
In-Reply-To: <CABeXuvrYzLoc7YGtmXDJqEovwyERbndN4cC6UaYAw5+qABRr8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmNhNjc0ODctNjRkOC00YTYxLTk5Y2QtYjc1MjI4OGNjMTM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUZINjZDZ2JtT2szZlowWENvOVlwa1NMTUoyNmZcL0ZYQktVY1BxQ0pQenZYSmlmMHdtMzgyRHZQOXhlMkR4SWcifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IE9uIFN1biwgTm92IDEwLCAyMDE5IGF0
IDEwOjI0IEFNIERlZXBhIERpbmFtYW5pDQo+ID4gSSd2ZSBwb3N0ZWQgdGhlIHYyIHdpdGhvdXQg
dGhlIGNvbmRpdGlvbmFsIGZvciBub3c6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0
Y2h3b3JrL3BhdGNoLzExNTEyMjUvDQo+ID4NCj4gPiBBcyBhIHNpZGUgdG9waWMsIEknbSB0cnlp
bmcgdG8gc3VwcG9ydCBodHRwczovL3d3dy5saW51eGJvb3Qub3JnLy4gSQ0KPiA+IGhhdmUgYSBj
b3VwbGUgb2YgbW9yZSBzdWNoIGNsZWFudXBzIGNvbWluZy4gVGhlIFZNTSBsaXZlIHVwZGF0ZXMg
YW5kDQo+ID4gbGludXhib290IHNlZW0gdG8gaGF2ZSBjb250cmFkaWN0aW5nIHJlcXVpcmVtZW50
cyBhbmQgdGhleSBib3RoIHVzZQ0KPiA+IGtleGVjLiBTbyBrZXhlY19pbl9wcm9ncmVzcyBkb2Vz
bid0IHNlZW0gbGlrZSBhIHN1ZmZpY2llbnQgaW5kaWNhdG9yDQo+ID4gdG8gZGlzdGluZ3Vpc2gg
YmV0d2VlbiB0aGUgdHdvLiBEbyB5b3UgYWxyZWFkeSBoYXZlIGFuIGlkZWEgb24gaG93IHRvDQo+
ID4gZGlzdGlndWlzaCBiZXR3ZWVuIHRoZW0/IERvZXMgYSBzZXBhcmF0ZSBzeXNfcmVib290KCkg
Y29tbWFuZA0KPiA+IHBhcmFtZXRlciBzb3VuZCBvaz8gT3IsIHdlIGNvdWxkIHVzZSB0aGUgZmxh
Z3MgaW4gdGhlIHN5c19rZXhlY19sb2FkKCkNCj4gPiBkZXBlbmRpbmcgb24gaG93IHRoZSBsaXZl
IHVwZGF0ZSBmZWF0dXJlIGlzIGltcGxlbWVudGVkLg0KPiANCj4gQWxzbywgdGhlIEFNRCBkcml2
ZXIgZGlzYWJsZXMgaW9tbXUgYXQgc2h1dGRvd24gYWxyZWFkeS4gU28gdGhlIGxpdmUgdXBkYXRl
DQo+IGZlYXR1cmUgaXMgYWxyZWFkeSBicm9rZW4gb24gQU1ELg0KPiANCg0KSGkgRGVlcGEsDQoN
CkkgdGhpbmsgeW91IG1heSBub3QgbmVlZCB0byBjb25zaWRlciB0b28gbXVjaCBWTU0gbGl2ZSB1
cGRhdGUgaGVyZSAoYWx0aG91Z2ggaXQNCndvdWxkIGJlIGdvb2QgdG8gY29uc2lkZXIgcG9zc2li
bGUgZnV0dXJlIGZlYXR1cmVzKSwgYWZ0ZXIgYWxsIGl0IGlzIGFuIG9uLWdvaW5nIGVmZm9ydCwN
CndlIGFyZSBzdGlsbCBub3QgcXVpdGUgc3VyZSB3aGF0IGV4YWN0IG1vZGlmaWNhdGlvbnMgaXQg
bmVlZHMuIFRoZSBWTU0gbGl2ZSB1cGRhdGUNCml0c2VsZiB3aWxsIGZpZ3VyZSBvdXQgd2hhdCBp
cyB0aGUgYmVzdCB3YXkgdG8gbW9kaWZ5IHRoZSBjb2RlLg0KDQpUaGFua3MsDQpKYXNvbg0KDQo+
IC1EZWVwYQ0K
