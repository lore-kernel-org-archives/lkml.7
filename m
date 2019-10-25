Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A22D21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408683AbfJYJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:08:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:37215 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408378AbfJYJIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="197377501"
Received: from kmsmsx152.gar.corp.intel.com ([172.21.73.87])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2019 02:07:58 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 KMSMSX152.gar.corp.intel.com ([169.254.11.51]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 17:07:57 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        "M, Naveen" <naveen.m@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: RE: [alsa-devel] [PATCH] ASoC: Intel: eve: Enable mclk and ssp sclk
 early for rt5514
Thread-Topic: [alsa-devel] [PATCH] ASoC: Intel: eve: Enable mclk and ssp
 sclk early for rt5514
Thread-Index: AQHVibVeihUHG65lMUel8ewyaYl6D6dn2HEAgAM3GCA=
Date:   Fri, 25 Oct 2019 09:07:56 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C740320031@PGSMSX108.gar.corp.intel.com>
References: <1571843796-5021-1-git-send-email-brent.lu@intel.com>
 <b68e5cb8-6d03-def0-646d-c68bd2604ecd@linux.intel.com>
In-Reply-To: <b68e5cb8-6d03-def0-646d-c68bd2604ecd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDYwNWRiZDYtYzc4MC00ZGJlLWJiYjQtYjM3NjZjZjFlZjcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmtGSldXOGFmUlNYNWpIbEhhK1hndE5NanVtXC8zRFhCRFhQeUhxYjVzSlJsU3Y4UGtKSGF2RkRsYXU2TDY0VTMifQ==
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

PiBUaGUgcGF0Y2ggbG9va3MgZmluZSwgYnV0IEknZCBsaWtlIHRvIGNsZWFyIGEgZG91YnQgSSBo
YXZlIG9uIGhvdyBNQ0xLcyBhcmUNCj4gaGFuZGxlZC4NCj4gDQo+IElJUkMsIHRoZSBoYXJkd2Fy
ZSBleHBvc2VzIDIgTUNMSyBvdXRwdXRzLCBhbmQgaXQncyBub3QgdW5jb21tb24gdG8gc2hhcmUN
Cj4gdGhlIHNhbWUgTUNMSyBiZXR3ZWVuIFNTUHMsIG9yIHVzZSBhIGRpZmZlcmVudCBNQ0xLIGlk
IGZvciB0aGUgc2FtZSBTU1ANCj4gb24gZGlmZmVyZW50IHBsYXRmb3JtcyAoaXQncyBvbmUgb2Yg
dGhlIGRpZmZlcmVuY2VzIGJldHdlZW4NCj4gYXBsLWRhNzIxOSBhbmQgZ2xrLWRhNzIxOSkuDQo+
IA0KPiBDYW4geW91IGRvdWJsZS1jaGVjayB0aGF0IGF0IHRoZSBib2FyZCBsZXZlbCB0aGUgTUNM
SyBwaW5zIGFyZSBhY3R1YWxseQ0KPiBkaWZmZXJlbnQ/IElmIHRoZXkgYXJlIG5vdCwgdGhlbiB3
ZSBzaG91bGQgbm90IGJlIGVuYWJsaW5nL2Rpc2FibGluZyB0aGVtDQo+IHNlcGFyYXRlbHksIG9y
IHlvdSdsbCBoYXZlIHNpZGUgZWZmZWN0cyBiZXR3ZWVuIGhlYWRzZXQgYW5kIERNSUNzLg0KPiAN
Cj4gSSBhbHNvIGRvbid0IGtub3cgd2hhdCB0aGUgU0tMIGRyaXZlciBkb2VzIHdpdGggJ3NzcDBf
bWNsaycgYW5kICdzc3AxX21jbGsnPw0KPiBDZXphcnksIHdvdWxkIHlvdSBoYXBwZW4gdG8ga25v
dyBob3cgdGhlIG1hcHBpbmcgYmV0d2VlbiBNQ0xLIGFuZA0KPiBTU1BzIGlzIGhhbmRsZWQ/DQo+
IA0KDQpPbiB0aGUgYm9hcmQgSSBvbmx5IHNlZSBvbmUgbWNsayBvdXRwdXQgd2hpY2ggbmFtZSBp
cyAiR1BQRDIzL0kyU19NQ0xLIi4gSSB3aWxsDQp1c2Ugc3NwMV9tY2xrIGluc3RlYWQgc2luY2Ug
cnQ1NTE0IGlzIGFsc28gdXNlIGl0IHdoZW4gZW5hYmxpbmcgRFNQIHZvaWNlIHdha2UgdXANCmZ1
bmN0aW9uLg0KDQpJJ3ZlIHRhbGtlZCB0byBSZWFsdGVrIHBlb3BsZSBhYm91dCB0aGlzIGlzc3Vl
LiBUaGV5IHNhaWQgcnQ1NTE0IHJlcXVpcmVzIGV4cGxpY2l0DQpjbG9jayBjb250cm9sIG92ZXIg
bWNsayBpbiBpdHMgcnQ1NTE0X3NldF9iaWFzX2xldmVsKCkgZnVuY3Rpb24gd2hpY2ggZXhwbGFp
bnMNCndoeSB0aGlzIHBhdGNoIGNvdWxkIGZpeCB0aGUgaXNzdWUgYnV0IHRoZSBwYXRjaCBzZWVt
cyB0byBiZSBhbiBvdmVya2lsbC4gSSB3aWxsIHVwbG9hZA0KYW5vdGhlciBwYXRjaCB3aGljaCB0
b3VjaGVzIG1jbGsgb25seSBpbiBjYXJkJ3Mgc2V0X2JpYXNfbGV2ZWwoKSBmdW5jdGlvbiAuIFRo
YW5rcw0KZm9yIHRoZSByZXZpZXcuDQoNClJlZ2FyZHMsDQpCcmVudA0K
