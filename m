Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D832C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A7721D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfKHJL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:11:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:7659 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfKHJL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:11:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 01:11:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; 
   d="scan'208";a="193109548"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2019 01:11:27 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 8 Nov 2019 01:11:27 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id 14.03.0439.000;
 Fri, 8 Nov 2019 17:11:24 +0800
From:   "Zeng, Jason" <jason.zeng@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Zeng, Jason" <jason.zeng@intel.com>
Subject: RE: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Topic: [PATCH] intel-iommu: Turn off translations at shutdown
Thread-Index: AQHVlgnIrRA21rplp0+PB/+PXXgW6aeA7hBA//+Ew4CAAInEMA==
Date:   Fri, 8 Nov 2019 09:11:24 +0000
Message-ID: <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
         <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
         <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
In-Reply-To: <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmIxYjA3YjUtNGQ2My00MWM3LTg1NTYtOTE0ZDM3ZmM3YWU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSEZJdnhmXC92QjZJaXBscmdcL3FmMk93SzVkXC85R2tmRlBSTGZneFB0cmY2RGl5SndwSTVNODFMcHRTSXNhYzNXUiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgV29vZGhvdXNl
IDxkd213MkBpbmZyYWRlYWQub3JnPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMTkg
NDo1NyBQTQ0KPiBUbzogWmVuZywgSmFzb24gPGphc29uLnplbmdAaW50ZWwuY29tPjsgRGVlcGEg
RGluYW1hbmkNCj4gPGRlZXBhLmtlcm5lbEBnbWFpbC5jb20+OyBqb3JvQDhieXRlcy5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGludGVsLWlvbW11OiBUdXJuIG9mZiB0cmFuc2xhdGlvbnMgYXQgc2h1dGRv
d24NCj4gDQo+IE9uIEZyaSwgMjAxOS0xMS0wOCBhdCAwODo0NyArMDAwMCwgWmVuZywgSmFzb24g
d3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRGF2
aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPg0KPiA+ID4gU2VudDogRnJpZGF5LCBO
b3ZlbWJlciA4LCAyMDE5IDM6NTQgUE0NCj4gPiA+IFRvOiBEZWVwYSBEaW5hbWFuaSA8ZGVlcGEu
a2VybmVsQGdtYWlsLmNvbT47IGpvcm9AOGJ5dGVzLm9yZzsNCj4gbGludXgtDQo+ID4gPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmc7IFplbmcsIEphc29uDQo+IDxqYXNvbi56ZW5nQGludGVsLmNvbT47DQo+ID4gPiBUaWFu
LCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBpbnRlbC1pb21tdTogVHVybiBvZmYgdHJhbnNsYXRpb25zIGF0IHNodXRkb3duDQo+ID4gPg0K
PiA+ID4gT24gVGh1LCAyMDE5LTExLTA3IGF0IDEyOjU5IC0wODAwLCBEZWVwYSBEaW5hbWFuaSB3
cm90ZToNCj4gPiA+ID4gVGhlIGludGVsLWlvbW11IGRyaXZlciBhc3N1bWVzIHRoYXQgdGhlIGlv
bW11IHN0YXRlIGlzDQo+ID4gPiA+IGNsZWFuZWQgdXAgYXQgdGhlIHN0YXJ0IG9mIHRoZSBuZXcg
a2VybmVsLg0KPiA+ID4gPiBCdXQsIHdoZW4gd2UgdHJ5IHRvIGtleGVjIGJvb3Qgc29tZXRoaW5n
IG90aGVyIHRoYW4gdGhlDQo+ID4gPiA+IExpbnV4IGtlcm5lbCwgdGhlIGNsZWFudXAgY2Fubm90
IGJlIHJlbGllZCB1cG9uLg0KPiA+ID4gPiBIZW5jZSwgY2xlYW51cCBiZWZvcmUgd2UgZ28gZG93
biBmb3IgcmVib290Lg0KPiA+ID4gPg0KPiA+ID4gPiBLZWVwaW5nIHRoZSBjbGVhbnVwIGF0IGlu
aXRpYWxpemF0aW9uIGFsc28sIGluIGNhc2UgQklPUw0KPiA+ID4gPiBsZWF2ZXMgdGhlIElPTU1V
IGVuYWJsZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEkgY29uc2lkZXJlZCB0dXJuaW5nIG9mZiBpb21t
dSBvbmx5IGR1cmluZyBrZXhlYyByZWJvb3QsDQo+ID4gPiA+IGJ1dCBhIGNsZWFuIHNodXRkb3du
IHNlZW1zIGFsd2F5cyBhIGdvb2QgaWRlYS4gQnV0IGlmDQo+ID4gPiA+IHNvbWVvbmUgd2FudHMg
dG8gbWFrZSBpdCBjb25kaXRpb25hbCwgd2UgY2FuIGRvIHRoYXQuDQo+ID4gPg0KPiA+ID4gVGhp
cyBpcyBnb2luZyB0byBicmVhayB0aGluZ3MgZm9yIHRoZSBWTU0gbGl2ZSB1cGRhdGUgc2NoZW1l
IHRoYXQgSmFzb24NCj4gPiA+IHByZXNlbnRlZCBhdCBLVk0gRm9ydW0sIGlzbid0IGl0Pw0KPiA+
ID4NCj4gPiA+IEluIHRoYXQgY2FzZSB3ZSByZWx5IG9uIHRoZSBJT01NVSBzdGlsbCBvcGVyYXRp
bmcgZHVyaW5nIHRoZQ0KPiA+ID4gdHJhbnNpdGlvbi4NCj4gPg0KPiA+IEZvciBWTU0gbGl2ZSB1
cGRhdGUgY2FzZSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gZGV0ZWN0IGFuZCBieXBhc3MNCj4gPiB0
aGUgc2h1dGRvd24gdGhhdCBEZWVwYSBpbnRyb2R1Y2VkIGhlcmUsIHNvIGtlZXAgSU9NTVUgc3Rp
bGwgb3BlcmF0aW5nPw0KPiANCj4gSXMgdGhhdCBhICd5ZXMnIHRvIERlZXBhJ3MgImlmIHNvbWVv
bmUgd2FudHMgdG8gbWFrZSBpdCBjb25kaXRpb25hbCwgd2UNCj4gY2FuIGRvIHRoYXQiID8NCg0K
WWVzLCBJIHRoaW5rIHNvLiBUaGFua3MhDQo=
