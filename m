Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B1C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfC1BgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:36:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:41881 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfC1BgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:36:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 18:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="129284917"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2019 18:36:15 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Mar 2019 18:36:15 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Mar 2019 18:36:14 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.134]) with mapi id 14.03.0415.000;
 Thu, 28 Mar 2019 09:36:12 +0800
From:   "Zhang, Jun" <jun.zhang@intel.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     "He, Bo" <bo.he@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: RE: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Topic: [PATCH 3.18 132/134] rcu: Do RCU GP kthread self-wakeup from
 softirq and interrupt
Thread-Index: AQHU4KqYqvmIcV2TkUOhSnG4am5KzqYXST2AgADz6ICAA8MXgIABGF2AgAB4qoCAASo2QIAAW24AgAEwk0A=
Date:   Thu, 28 Mar 2019 01:36:12 +0000
Message-ID: <88DC34334CA3444C85D647DBFA962C2735B0510F@SHSMSX104.ccr.corp.intel.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111220.102008032@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A646D1@SHSMSX104.ccr.corp.intel.com>
 <20190323063315.GB31361@kroah.com> <20190325160017.GD4102@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A6526B@SHSMSX104.ccr.corp.intel.com>
 <20190326155537.GO4102@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735B04EB8@SHSMSX104.ccr.corp.intel.com>
 <20190327151012.GY4102@linux.ibm.com>
In-Reply-To: <20190327151012.GY4102@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGZhNzZlOTYtZTI1OC00ZjBhLThmZGMtM2Q2Zjg2MDA4NzNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjV4N3J3MnNieFZqd2lFRzRYUlVES2tvc2dYdW5QNitRNlFDOE03cVBidWh1c0xHWWJ2Rm5KTXZPcWU2TzNXMyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIFBhdWwNCg0KWWVzLCBJIG9ubHkgdXNlIG9yaWdpbmFsIFYzLjE4LjEzNiB0byB0ZXN0
LiBCZWNhdXNlIHN5c3RlbSBydW4gdmVyeSBzbG93bHksIEkgZ2l2ZSB1cC4NCg0KRGV2aWNlOiBO
VUMgKG1hZGUgaW4gMjAxNykNCk9TOiAgICAgICAgdWJ1bnR1IDE2LjA0DQpLZXJuZWw6IFYzLjE4
LjEzNiAoY29tZSBmcm9tIGh0dHBzOi8va2VybmVsLnVidW50dS5jb20vfmtlcm5lbC1wcGEvbWFp
bmxpbmUvdjMuMTguMTM2LykgDQpTeXN0ZW0gY2FuIGJvb3QsIGJ1dCBydW4gdmVyeSBzbG93bHks
IGFuZCBjb3VsZG4ndCBjb25uZWN0IHRoZSBuZXR3b3JrLg0KVGhpcyBtYWtlIG1lIG5vdCB0byB3
b3JrIHdpdGggdGVybWluYWwsIGJlY2F1c2Ugc3lzdGVtIHZlcnkgc2xvd2x5LiANClNvIEkgZG9u
4oCZdCB1c2UgVjMuMTguMTM2K3BhdGNoIHRvIHRlc3QuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFBhdWwgRS4gTWNLZW5uZXkgW21haWx0bzpwYXVsbWNrQGxpbnV4Lmli
bS5jb21dIA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyNywgMjAxOSAyMzoxMA0KVG86IFpoYW5n
LCBKdW4gPGp1bi56aGFuZ0BpbnRlbC5jb20+DQpDYzogSGUsIEJvIDxiby5oZUBpbnRlbC5jb20+
OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgWGlhbywgSmlu
IDxqaW4ueGlhb0BpbnRlbC5jb20+OyBCYWksIEppZSBBIDxqaWUuYS5iYWlAaW50ZWwuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAzLjE4IDEzMi8xMzRdIHJjdTogRG8gUkNVIEdQIGt0aHJlYWQg
c2VsZi13YWtldXAgZnJvbSBzb2Z0aXJxIGFuZCBpbnRlcnJ1cHQNCg0KSGVsbG8sIEp1biwNCg0K
RG8geW91IHNlZSB0aGUgc2FtZSBoYW5nIHdpdGhvdXQgdGhlIHBhdGNoPw0KDQoJCQkJCQkJVGhh
bngsIFBhdWwNCg0KT24gV2VkLCBNYXIgMjcsIDIwMTkgYXQgMDE6NTA6NTdBTSArMDAwMCwgWmhh
bmcsIEp1biB3cm90ZToNCj4gSGVsbG/vvIxQYXVsDQo+IA0KPiBJIHVzZSBhIG5ldyBOVUMgKG1h
ZGUgaW4gMjAxNykgdG8gdGVzdCwgbWVldCB0aGUgc2FtZSBoYW5nLiBTeXN0ZW0gcnVuIHZlcnkg
c2xvd2x5Lg0KPiANCj4gQnV0IEkgdXNlIG15IFBDIChtYWRlIGJlZm9yZSAyMDE1KSwgdGVzdCBW
My4xOC4xMzYrIHBhdGNoIGZvciAxMiBob3Vycywgc3RpbGwgd2VsbC4NCj4gDQo+IE1heWJlIFYz
LjE4LnkgZG9uJ3Qgc3VwcG9ydCBzb21lIG5ldyBkZXZpY2VzLg0KPiANCj4gDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgRS4gTWNLZW5uZXkgW21haWx0bzpwYXVs
bWNrQGxpbnV4LmlibS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI2LCAyMDE5IDIzOjU2
DQo+IFRvOiBIZSwgQm8gPGJvLmhlQGludGVsLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyANCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIEp1biANCj4gPGp1bi56aGFu
Z0BpbnRlbC5jb20+OyBYaWFvLCBKaW4gPGppbi54aWFvQGludGVsLmNvbT47IEJhaSwgSmllIEEg
DQo+IDxqaWUuYS5iYWlAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMuMTggMTMy
LzEzNF0gcmN1OiBEbyBSQ1UgR1Aga3RocmVhZCBzZWxmLXdha2V1cCANCj4gZnJvbSBzb2Z0aXJx
IGFuZCBpbnRlcnJ1cHQNCj4gDQo+IE9uIFR1ZSwgTWFyIDI2LCAyMDE5IGF0IDA4OjQzOjQ1QU0g
KzAwMDAsIEhlLCBCbyB3cm90ZToNCj4gPiBIaSwgUGF1bDoNCj4gPiAJSSBoYXZlIHRyaWVkIG9u
IG15IFBDIGFuZCBub3QgaGl0IGFueSBoYW5nIGlzc3VlIHdpdGggUkNVIHRvcnR1cmUgdGVzdCBm
b3Igb25lIGhvdXIsIHRoZSBjb25maWd1cmF0aW9ucyBhcmUgbGlrZToNCj4gPiBPUzogdWJ1bnR1
IDE2LjA0DQo+ID4ga2VucmVsOiAzLjE4LjEzNiArIDMuMTggcmN1IHBhdGNoDQo+ID4gQ1BVOiAg
SW50ZWwoUikgWGVvbihSKSBDUFUgRTMtMTIyNSBWMiBAIDMuMjBHSHoNCj4gDQo+IFNvdW5kcyBn
b29kLCBwbGVhc2UgcHJvY2VlZCENCj4gDQo+IAkJCQkJCQlUaGFueCwgUGF1bA0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAbGludXguaWJtLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyNiwgMjAxOSAx
MjowMCBBTQ0KPiA+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPg0KPiA+IENjOiBIZSwgQm8gPGJvLmhlQGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IA0KPiA+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nLCBKdW4g
PGp1bi56aGFuZ0BpbnRlbC5jb20+OyBYaWFvLCBKaW4gDQo+ID4gPGppbi54aWFvQGludGVsLmNv
bT47IEJhaSwgSmllIEEgPGppZS5hLmJhaUBpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCAzLjE4IDEzMi8xMzRdIHJjdTogRG8gUkNVIEdQIGt0aHJlYWQgc2VsZi13YWtldXAgDQo+
ID4gZnJvbSBzb2Z0aXJxIGFuZCBpbnRlcnJ1cHQNCj4gPiANCj4gPiBPbiBTYXQsIE1hciAyMywg
MjAxOSBhdCAwNzozMzoxNUFNICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4g
PiBPbiBGcmksIE1hciAyMiwgMjAxOSBhdCAwNDowMDoxN1BNICswMDAwLCBIZSwgQm8gd3JvdGU6
DQo+ID4gPiA+IEhpLCBHcmVnOg0KPiA+ID4gPiAJQ2FuIHlvdSBob2xkIG9uIHRoZSAzLjE4LXN0
YWJsZSBicmFuY2gsIGl0IHNlZW1zIHRoZXJlIGFyZSBzb21lIGlzc3VlLCBwbGVhc2Ugc2VlIHRo
ZSBjb21tZW50cyBmcm9tIFBhdWw6DQo+ID4gPiA+IA0KPiA+ID4gPiBDb21tZW50cyBmcm9tIFBh
dWw6DQo+ID4gPiA+IEkgc3ViamVjdGVkIGFsbCBvZiB0aGUgb3RoZXJzIHRvIGxpZ2h0IHJjdXRv
cnR1cmUgdGVzdGluZywgd2hpY2ggDQo+ID4gPiA+IHRoZXkgcGFzc2VkLiAgVGhpcyB2My4xOCBw
YXRjaCBodW5nLCBob3dldmVyLiAgVHJ5aW5nIGl0IGFnYWluIA0KPiA+ID4gPiB3aXRoIHN0b2Nr
DQo+ID4gPiA+IHYzLjE4IGdvdCB0aGUgc2FtZSBoYW5nLCBzbyBJIGJlbGlldmUgd2UgY2FuIGV4
b25lcmF0ZSB0aGUgcGF0Y2ggYW5kIGdpdmUgaXQgYSBnb29kIGZpcm0gIm1heWJlIiBvbiAzLjE4
Lg0KPiA+ID4gPiANCj4gPiA+ID4gV29ydGggcGF5aW5nIHNwZWNpYWwgYXR0ZW50aW9uIHRvIGZ1
cnRoZXIgdGVzdCByZXN1bHRzIGZyb20gMy4xOC54LCB0aG91Z2ghDQo+ID4gPiANCj4gPiA+IE9r
LCBJJ3ZlIGRyb3BwZWQgdGhpcyBmcm9tIHRoZSAzLjE4LnkgcXVldWUgbm93LCB0aGFua3MuDQo+
ID4gDQo+ID4gQm8sIGlmIHlvdSBrbm93IG9mIGEgInkiIGZvciAzLjE4LnkgdGhhdCB3b3VsZCBs
aWtlbHkgcGFzcyByY3V0b3J0dXJlIHRlc3RpbmcsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPiAN
Cj4gPiAJCQkJCQkJVGhhbngsIFBhdWwNCj4gPiANCj4gDQoNCg==
