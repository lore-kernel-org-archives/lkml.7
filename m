Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFAC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D7208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfILGEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:04:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:25089 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfILGEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:04:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 23:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; 
   d="scan'208";a="186036010"
Received: from kmsmsx152.gar.corp.intel.com ([172.21.73.87])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2019 23:04:17 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.138]) by
 KMSMSX152.gar.corp.intel.com ([169.254.11.65]) with mapi id 14.03.0439.000;
 Thu, 12 Sep 2019 14:00:45 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint
 support
Thread-Topic: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint
 support
Thread-Index: AQHVZFJP8PyrEMjcjUeZpcb0xW/mNqceLbmAgASxdDCAAEEEgIABJDyggAAwUICAAuppgA==
Date:   Thu, 12 Sep 2019 06:00:45 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7402DBB9B@PGSMSX108.gar.corp.intel.com>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
 <29b9fd4e-3d78-b4a3-e61a-c066bf24995a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402CB9AC@PGSMSX108.gar.corp.intel.com>
 <99769525-779a-59aa-96da-da96f8f09a8a@linux.intel.com>
In-Reply-To: <99769525-779a-59aa-96da-da96f8f09a8a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjdlZjY3NDgtNTUxMi00YWYyLTk5OTUtZGE2MWU2MmU1MzMzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYkdvakhBVEpJWFBTT0Z4Vkh6cXRYaHNEajkzQjUxMkZxaEh0STlrMWJtNkxQRVVcL1hDdkQ4ZU1kU29LQXJZWGcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gVGhlIHN0b3J5IGlzIENocm9tZSBoYXMgYSB0b29sIGNhbGxlZCBhbHNhX2NvbmZv
cm1hbmNlX3Rlc3Qgd2hpY2ggcnVucw0KPiA+IGNhcHR1cmUgb3IgcGxheWJhY2sgYWdhaW5zdCBh
IFBDTSBwb3J0IHdpdGggYWxsIHBvc3NpYmxlDQo+ID4gY29uZmlndXJhdGlvbnMgKGNoYW5uZWws
IGZvcm1hdCwgcmF0ZSkgdGhlbiBtZWFzdXJlIGlmIHRoZSBzYW1wbGUgcmF0ZQ0KPiA+IGlzIGNv
cnJlY3QuIFNpbmNlIHRoZSBjaGFubmVsIG1heCBudW1iZXIgcmVwb3J0ZWQgaXMgNCwgaXQgdGVz
dHMgdGhlDQo+ID4gNC1jaGFubmVsIDQ4SyBjYXB0dXJlIGFuZCByZXBvcnRzIHRoZSBhY3R1YWwg
c2FtcGxlIHJhdGUgaXMgMjQwMDANCj4gPiBpbnN0ZWFkIG9mIDQ4MDAwLiBUaGF0J3MgdGhlIHJl
YXNvbiB3ZSB3YW50IHRvIGFkZCBhIGNvbnN0cmFpbnQgaW4NCj4gPiBtYWNoaW5lIGRyaXZlciB0
byBhdm9pZCB1c2VyIHNwYWNlIHByb2dyYW1zIHRyeWluZyB0byBkbyA0IGNoYW5uZWwNCj4gcmVj
b3JkaW5nIHNpbmNlIHRoaXMgbWFjaGluZSBkb2VzIG5vdCBzdXBwb3J0IGl0IGluIHRoZSBiZWdp
bm5pbmcuDQo+IA0KPiBvaywgdGhhdCBoZWxwcyBnZXQgY29udGV4dCwgdGhhbmtzIGZvciB0aGUg
ZGV0YWlscy4NCj4gDQo+IEkgd291bGQgaGF2ZSBleHBlY3RlZCBzb21lIGVycm9yIHRvIGJlIHJl
dHVybmVkIGlmIHRoZXJlJ3MgYSBmcm9udC1lbmQNCj4gb3BlbmVkIHdpdGggNCBjaGFubmVscyBh
bmQgdGhlIGJhY2stZW5kIG9ubHkgc3VwcG9ydHMgdHdvLiBBZGRpbmcgdGhlDQo+IGNvbnN0cmFp
bnQgc2VlbXMgbGlrZSBhIHdvcmstYXJvdW5kIHRvIGF2b2lkIGRlYWxpbmcgd2l0aCB0aGUgbWlz
bWF0Y2gNCj4gYmV0d2VlbiBGRSBhbmQgQkUuIEkgZG9uJ3QgdW5kZXJzdGFuZCBEUENNIGVub3Vn
aCB0byBzdWdnZXN0IGFuDQo+IGFsdGVybmF0aXZlIHRob3VnaC4gUmFuamFuaSwgY2FuIHlvdSBo
ZWxwIG9uIHRoaXMgb25lPw0KPiANCj4gQW5kIGV2ZW4gaWYgd2UgYWdyZWUgd2l0aCB0aGlzIHNv
bHV0aW9uLCBpdCdkIGJlIG5pY2UgdG8gYXBwbHkgaXQgZm9yIHRoZQ0KPiBCcm9hZHdlbGwgbWFj
aGluZSBkcml2ZXIgZm9yIGNvbnNpc3RlbmN5Lg0KDQpJdCdzIG5vdCBvbmx5IHRoZSBtaXNtYXRj
aCBidXQgYWxzbyB0aGUgZGVzaWduIGxpbWl0YXRpb24uIEFjY29yZGluZyB0byB0aGUgDQppbmZv
cm1hdGlvbiBmcm9tIGdvb2dsZSwgdGhlIGJvYXJkIChzYW11cykgb25seSB1c2VzIHR3byBtaWNy
b3Bob25lIHNvIA0KMyBvciA0IGNoYW5uZWwgcmVjb3JkaW5nIGFyZSBub3Qgc3VwcG9ydGVkLiBU
aGF0J3MgdGhlIHJlYXNvbiB3ZSBsZXZlcmFnZSANCnRoZSBjb25zdHJhaW50IGZyb20gb3RoZXIg
bWFjaGluZSBkcml2ZXIgKGxpa2Uga2JsX2RhNzIxOV9tYXg5ODM1N2EuYykgDQp0byByZW1vdmUg
dGhlIDMgYW5kIDQgY2hhbm5lbCByZWNvcmRpbmcgb3B0aW9uLg0KDQpUaGUgZGlmZmVyZW5jZSBh
ZnRlciB0aGUgY29uc3RyYWludCBpcyBpbXBsZW1lbnRlZCBpcyB0aGF0IHRoZSANCnNuZF9wY21f
aHdfcGFyYW1zX3NldF9jaGFubmVscygpIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGVycm9yIChJbnZh
bGlkIA0KYXJndW1lbnQpIHdoZW4gY2hhbm5lbCBudW1iZXIgaXMgMyBvciA0IHNvIHRoZSBhcHBs
aWNhdGlvbiBrbm93cyB0aGUgDQpjb25maWd1cmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQuDQoNCg0K
UmVnYXJkcywNCkJyZW50DQoNCg==
