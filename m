Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95200C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC2121D56
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfI0MiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:38:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:63036 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0MiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:38:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 05:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="391148068"
Received: from kmsmsx155.gar.corp.intel.com ([172.21.73.106])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2019 05:38:06 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.138]) by
 KMSMSX155.gar.corp.intel.com ([169.254.15.100]) with mapi id 14.03.0439.000;
 Fri, 27 Sep 2019 20:34:33 +0800
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
Thread-Index: AQHVZFJP8PyrEMjcjUeZpcb0xW/mNqceLbmAgASxdDCAAEEEgIABJDyggAAwUICAAuppgIAAJ+iAgBgJ7jA=
Date:   Fri, 27 Sep 2019 12:34:32 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7402EABB2@PGSMSX108.gar.corp.intel.com>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
 <29b9fd4e-3d78-b4a3-e61a-c066bf24995a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402CB9AC@PGSMSX108.gar.corp.intel.com>
 <99769525-779a-59aa-96da-da96f8f09a8a@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402DBB9B@PGSMSX108.gar.corp.intel.com>
 <34604b9a-f479-3f92-7917-84f295a82fd8@linux.intel.com>
In-Reply-To: <34604b9a-f479-3f92-7917-84f295a82fd8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2I2MGNkZDAtNGE0ZC00MTkwLTlkMGMtNjEwNmUyZTA2NjEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidzBOK0ZiUmJcL3A3QWtVOHptV2ZMbGdRcnViU0pvSXVsdEdWR0ltS1diaDhlUU9uZWVoN2ZGWm9QU2d3RHBhZjEifQ==
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

PiA+DQo+ID4gSXQncyBub3Qgb25seSB0aGUgbWlzbWF0Y2ggYnV0IGFsc28gdGhlIGRlc2lnbiBs
aW1pdGF0aW9uLiBBY2NvcmRpbmcNCj4gPiB0byB0aGUgaW5mb3JtYXRpb24gZnJvbSBnb29nbGUs
IHRoZSBib2FyZCAoc2FtdXMpIG9ubHkgdXNlcyB0d28NCj4gPiBtaWNyb3Bob25lIHNvDQo+ID4g
MyBvciA0IGNoYW5uZWwgcmVjb3JkaW5nIGFyZSBub3Qgc3VwcG9ydGVkLiBUaGF0J3MgdGhlIHJl
YXNvbiB3ZQ0KPiA+IGxldmVyYWdlIHRoZSBjb25zdHJhaW50IGZyb20gb3RoZXIgbWFjaGluZSBk
cml2ZXIgKGxpa2UNCj4gPiBrYmxfZGE3MjE5X21heDk4MzU3YS5jKSB0byByZW1vdmUgdGhlIDMg
YW5kIDQgY2hhbm5lbCByZWNvcmRpbmcgb3B0aW9uLg0KPiANCj4gVGhlIGRlc2lnbiBsaW1pdGF0
aW9uIGlzIGFscmVhZHkgaGFuZGxlZCBieSB0aGUgZmFjdCB0aGF0IHRoZSBTU1Agb3BlcmF0ZXMg
aW4NCj4gMmNoIG1vZGUsIHNvIGl0J3MgYSBkaWZmZXJlbnQgY2FzZSBmcm9tIEtCTCB3aGVyZSBp
bmRlZWQgdGhlIERNSUMtYmFzZWQNCj4gYmFjay1lbmQgY2FuIHN1cHBvcnQgNCBjaGFubmVscy4N
Cj4gDQo+ID4NCj4gPiBUaGUgZGlmZmVyZW5jZSBhZnRlciB0aGUgY29uc3RyYWludCBpcyBpbXBs
ZW1lbnRlZCBpcyB0aGF0IHRoZQ0KPiA+IHNuZF9wY21faHdfcGFyYW1zX3NldF9jaGFubmVscygp
IGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGVycm9yIChJbnZhbGlkDQo+ID4gYXJndW1lbnQpIHdoZW4g
Y2hhbm5lbCBudW1iZXIgaXMgMyBvciA0IHNvIHRoZSBhcHBsaWNhdGlvbiBrbm93cyB0aGUNCj4g
PiBjb25maWd1cmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiBJIGdldCB0aGUgZXJyb3Is
IEkgYW0ganVzdCB3b25kZXJpbmcgaWYgdGhlIGZpeCBpcyBhdCB0aGUgcmlnaHQgbG9jYXRpb24u
IEknbGwgbG9vaw0KPiBpbnRvIGl0LCBnaXZlIG1lIHVudGlsIHRvbW9ycm93Lg0KDQpJIHRoaW5r
IEkgZ290IHlvdXIgcG9pbnQuIEkgY2hlcnJ5LXBpY2sgdGhlc2UgY29tbWl0cyBiYWNrIHRvIHYz
LjE0IGJyYW5jaCB0byBmaXgNCnRoZSBGRS9CRSBtaXNtYXRjaCB3aXRob3V0IGFkZGluZyBjb25z
dHJhaW50IGluIG1hY2hpbmUgZHJpdmVyLiBUaGFua3MuDQoNCmIwNzNlZDRlIEFTb0M6IHNvYy1w
Y206IERQQ00gY2FyZXMgQkUgZm9ybWF0DQpmNGMyNzdiOCBBU29DOiBzb2MtcGNtOiBEUENNIGNh
cmVzIEJFIGNoYW5uZWwgY29uc3RyYWludA0KNGYyYmQxOGIgQVNvQzogZHBjbTogZXh0ZW5kIGNo
YW5uZWwgbWVyZ2luZyB0byB0aGUgYmFja2VuZCBjcHUgZGFpDQo0MzVmZmI3NiBBU29DOiBkcGNt
OiByZXdvcmsgcnVudGltZSBzdHJlYW0gbWVyZ2UNCmJhYWNkOGQxIEFTb0M6IGRwY206IGFkZCBy
YXRlIG1lcmdlIHRvIHRoZSBCRSBzdHJlYW0gbWVyZ2UNCg0K
