Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC890CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974E420873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfJ1GGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:06:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:51015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfJ1GGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:06:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 23:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="399353332"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 27 Oct 2019 23:06:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 27 Oct 2019 23:06:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Oct 2019 23:06:36 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Oct 2019 23:06:35 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.200]) with mapi id 14.03.0439.000;
 Mon, 28 Oct 2019 14:06:34 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Topic: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Index: AQHViqRXy9Yx+C3oUEClzLBbVKfxc6dq9GqwgAC9yACAAEk4gIADmobw
Date:   Mon, 28 Oct 2019 06:06:33 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
 <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
 <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
In-Reply-To: <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTA0ZDcyYTUtM2JjYy00NTU1LTg4ZGQtMGU4ZGE4NWJiNWE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmE3NGdsQzAxeGFcL1BNODhBNnhLQUFEeXp5bXgzM2xhZGxjdWhQdVhJTVM3UUJMdnFZWkRCTDZ0MEJQVXJQalAifQ==
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

PiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gU2Vu
dDogU2F0dXJkYXksIE9jdG9iZXIgMjYsIDIwMTkgMzowMyBQTQ0KPiANCj4gSGkgYWdhaW4sDQo+
IA0KPiBPbiAxMC8yNi8xOSAxMDo0MCBBTSwgTHUgQmFvbHUgd3JvdGU6DQo+ID4gSGksDQo+ID4N
Cj4gPiBPbiAxMC8yNS8xOSAzOjI3IFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+IEZyb206
IEphY29iIFBhbiBbbWFpbHRvOmphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tXQ0KPiA+Pj4g
U2VudDogRnJpZGF5LCBPY3RvYmVyIDI1LCAyMDE5IDM6NTUgQU0NCj4gPj4+DQo+ID4+PiBXaGVu
IFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3MgKFNWQSkgaXMgZW5hYmxlZCBmb3IgYSBndWVzdCBPUyB2
aWENCj4gPj4+IHZJT01NVSwgd2UgbmVlZCB0byBwcm92aWRlIGludmFsaWRhdGlvbiBzdXBwb3J0
IGF0IElPTU1VIEFQSSBhbmQNCj4gPj4+IGRyaXZlcg0KPiA+Pj4gbGV2ZWwuIFRoaXMgcGF0Y2gg
YWRkcyBJbnRlbCBWVC1kIHNwZWNpZmljIGZ1bmN0aW9uIHRvIGltcGxlbWVudA0KPiA+Pj4gaW9t
bXUgcGFzc2Rvd24gaW52YWxpZGF0ZSBBUEkgZm9yIHNoYXJlZCB2aXJ0dWFsIGFkZHJlc3MuDQo+
ID4+Pg0KPiA+Pj4gVGhlIHVzZSBjYXNlIGlzIGZvciBzdXBwb3J0aW5nIGNhY2hpbmcgc3RydWN0
dXJlIGludmFsaWRhdGlvbg0KPiA+Pj4gb2YgYXNzaWduZWQgU1ZNIGNhcGFibGUgZGV2aWNlcy4g
RW11bGF0ZWQgSU9NTVUgZXhwb3NlcyBxdWV1ZQ0KPiA+Pj4gaW52YWxpZGF0aW9uIGNhcGFiaWxp
dHkgYW5kIHBhc3NlcyBkb3duIGFsbCBkZXNjcmlwdG9ycyBmcm9tIHRoZSBndWVzdA0KPiA+Pj4g
dG8gdGhlIHBoeXNpY2FsIElPTU1VLg0KPiA+Pg0KPiA+PiBzcGVjaWZpY2FsbHkgeW91IG1heSBj
bGFyaWZ5IHRoYXQgb25seSBpbnZhbGlkYXRpb25zIHJlbGF0ZWQgdG8NCj4gPj4gZmlyc3QtbGV2
ZWwgcGFnZSB0YWJsZSBpcyBwYXNzZWQgZG93biwgYmVjYXVzZSBpdCdzIGd1ZXN0DQo+ID4+IHN0
cnVjdHVyZSBiZWluZyBib3VuZCB0byB0aGUgZmlyc3QtbGV2ZWwuIG90aGVyIGRlc2NyaXB0b3Jz
DQo+ID4+IGFyZSBlbXVsYXRlZCBvciB0cmFuc2xhdGVkIGludG8gb3RoZXIgbmVjZXNzYXJ5IG9w
ZXJhdGlvbnMuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gVGhlIGFzc3VtcHRpb24gaXMgdGhhdCBndWVz
dCB0byBob3N0IGRldmljZSBJRCBtYXBwaW5nIHNob3VsZCBiZQ0KPiA+Pj4gcmVzb2x2ZWQgcHJp
b3IgdG8gY2FsbGluZyBJT01NVSBkcml2ZXIuIEJhc2VkIG9uIHRoZSBkZXZpY2UgaGFuZGxlLA0K
PiA+Pj4gaG9zdCBJT01NVSBkcml2ZXIgY2FuIHJlcGxhY2UgY2VydGFpbiBmaWVsZHMgYmVmb3Jl
IHN1Ym1pdCB0byB0aGUNCj4gPj4+IGludmFsaWRhdGlvbiBxdWV1ZS4NCj4gPj4NCj4gPj4gd2hh
dCBpcyBkZXZpY2UgSUQ/IGl0J3MgYSBiaXQgY29uZnVzaW5nIHRlcm0gaGVyZS4NCj4gPj4NCj4g
Pj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXgu
aW50ZWwuY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50
ZWwuY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTGl1LCBZaSBMIDx5aS5sLmxpdUBsaW51eC5p
bnRlbC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUu
YyB8IDE3MA0KPiA+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNzAgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgYi9kcml2ZXJzL2lv
bW11L2ludGVsLQ0KPiBpb21tdS5jDQo+ID4+PiBpbmRleCA1ZmFiMzJmYmM0YjQuLmE3M2U3NmQ2
NDU3YSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYw0KPiA+
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4+PiBAQCAtNTQ5MSw2ICs1
NDkxLDE3NSBAQCBzdGF0aWMgdm9pZA0KPiA+Pj4gaW50ZWxfaW9tbXVfYXV4X2RldGFjaF9kZXZp
Y2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiA+Pj4gwqDCoMKgwqDCoCBhdXhfZG9t
YWluX3JlbW92ZV9kZXYodG9fZG1hcl9kb21haW4oZG9tYWluKSwgZGV2KTsNCj4gPj4+IMKgIH0N
Cj4gPj4+DQo+ID4+PiArLyoNCj4gPj4+ICsgKiAyRCBhcnJheSBmb3IgY29udmVydGluZyBhbmQg
c2FuaXRpemluZyBJT01NVSBnZW5lcmljIFRMQg0KPiA+Pj4gZ3JhbnVsYXJpdHkgdG8NCj4gPj4+
ICsgKiBWVC1kIGdyYW51bGFyaXR5LiBJbnZhbGlkYXRpb24gaXMgdHlwaWNhbGx5IGluY2x1ZGVk
IGluIHRoZSB1bm1hcA0KPiA+Pj4gb3BlcmF0aW9uDQo+ID4+PiArICogYXMgYSByZXN1bHQgb2Yg
RE1BIG9yIFZGSU8gdW5tYXAuIEhvd2V2ZXIsIGZvciBhc3NpZ25lZCBkZXZpY2UNCj4gd2hlcmUN
Cj4gPj4+IGd1ZXN0DQo+ID4+PiArICogY291bGQgb3duIHRoZSBmaXJzdCBsZXZlbCBwYWdlIHRh
YmxlcyB3aXRob3V0IGJlaW5nIHNoYWRvd2VkIGJ5DQo+ID4+PiBRRU1VLg0KPiA+Pj4gSW4NCj4g
Pj4+ICsgKiB0aGlzIGNhc2UgdGhlcmUgaXMgbm8gcGFzcyBkb3duIHVubWFwIHRvIHRoZSBob3N0
IElPTU1VIGFzIGENCj4gPj4+IHJlc3VsdCBvZg0KPiA+Pj4gdW5tYXANCj4gPj4+ICsgKiBpbiB0
aGUgZ3Vlc3QuIE9ubHkgaW52YWxpZGF0aW9ucyBhcmUgdHJhcHBlZCBhbmQgcGFzc2VkIGRvd24u
DQo+ID4+PiArICogSW4gYWxsIGNhc2VzLCBvbmx5IGZpcnN0IGxldmVsIFRMQiBpbnZhbGlkYXRp
b24gKHJlcXVlc3Qgd2l0aA0KPiA+Pj4gUEFTSUQpIGNhbiBiZQ0KPiA+Pj4gKyAqIHBhc3NlZCBk
b3duLCB0aGVyZWZvcmUgd2UgZG8gbm90IGluY2x1ZGUgSU9UTEIgZ3JhbnVsYXJpdHkgZm9yDQo+
ID4+PiByZXF1ZXN0DQo+ID4+PiArICogd2l0aG91dCBQQVNJRCAoc2Vjb25kIGxldmVsKS4NCj4g
Pj4+ICsgKg0KPiA+Pj4gKyAqIEZvciBhbiBleGFtcGxlLCB0byBmaW5kIHRoZSBWVC1kIGdyYW51
bGFyaXR5IGVuY29kaW5nIGZvciBJT1RMQg0KPiA+Pj4gKyAqIHR5cGUgYW5kIHBhZ2Ugc2VsZWN0
aXZlIGdyYW51bGFyaXR5IHdpdGhpbiBQQVNJRDoNCj4gPj4+ICsgKiBYOiBpbmRleGVkIGJ5IGlv
bW11IGNhY2hlIHR5cGUNCj4gPj4+ICsgKiBZOiBpbmRleGVkIGJ5IGVudW0gaW9tbXVfaW52X2dy
YW51bGFyaXR5DQo+ID4+PiArICogW0lPTU1VX0NBQ0hFX0lOVl9UWVBFX0lPVExCXVtJT01NVV9J
TlZfR1JBTlVfQUREUl0NCj4gPj4+ICsgKg0KPiA+Pj4gKyAqIEdyYW51X21hcCBhcnJheSBpbmRp
Y2F0ZXMgdmFsaWRpdHkgb2YgdGhlIHRhYmxlLiAxOiB2YWxpZCwgMDoNCj4gPj4+IGludmFsaWQN
Cj4gPj4+ICsgKg0KPiA+Pj4gKyAqLw0KPiA+Pj4gK2NvbnN0IHN0YXRpYyBpbnQNCj4gPj4+DQo+
IGludl90eXBlX2dyYW51X21hcFtJT01NVV9DQUNIRV9JTlZfVFlQRV9OUl1bSU9NTVVfSU5WX0dS
QU4NCj4gPj4+IFVfTlJdID0gew0KPiA+Pj4gK8KgwqDCoCAvKiBQQVNJRCBiYXNlZCBJT1RMQiwg
c3VwcG9ydCBQQVNJRCBzZWxlY3RpdmUgYW5kIHBhZ2Ugc2VsZWN0aXZlICovDQo+ID4+PiArwqDC
oMKgIHswLCAxLCAxfSwNCj4gPj4+ICvCoMKgwqAgLyogUEFTSUQgYmFzZWQgZGV2IFRMQnMsIG9u
bHkgc3VwcG9ydCBhbGwgUEFTSURzIG9yIHNpbmdsZSBQQVNJRCAqLw0KPiA+Pj4gK8KgwqDCoCB7
MSwgMSwgMH0sDQo+ID4+DQo+ID4+IEkgZm9yZ290IHByZXZpb3VzIGRpc2N1c3Npb24uIGlzIGl0
IG5lY2Vzc2FyeSB0byBwYXNzIGRvd24gZGV2IFRMQg0KPiA+PiBpbnZhbGlkYXRpb24NCj4gPj4g
cmVxdWVzdHM/IENhbiBpdCBiZSBoYW5kbGVkIGJ5IGhvc3QgaU9NTVUgZHJpdmVyIGF1dG9tYXRp
Y2FsbHk/DQo+ID4NCj4gPiBPbiBob3N0IFNWQSwgd2hlbiBhIG1lbW9yeSBpcyB1bm1hcHBlZCwg
ZHJpdmVyIGNhbGxiYWNrIHdpbGwgaW52YWxpZGF0ZQ0KPiA+IGRldiBJT1RMQiBleHBsaWNpdGx5
LiBTbyBJIGd1ZXNzIHdlIG5lZWQgdG8gcGFzcyBkb3duIGl0IGZvciBndWVzdCBjYXNlLg0KPiA+
IFRoaXMgaXMgYWxzbyByZXF1aXJlZCBmb3IgZ3Vlc3QgaW92YSBvdmVyIDFzdCBsZXZlbCB1c2Fn
ZSBhcyBmYXIgYXMgY2FuDQo+ID4gc2VlLg0KPiA+DQo+IA0KPiBTb3JyeSwgSSBjb25mdXNlZCBn
dWVzdCB2SU9WQSBhbmQgZ3Vlc3QgdlNWQS4gRm9yIGd1ZXN0IHZJT1ZBLCBubyBkZXZpY2UNCj4g
VExCIGludmFsaWRhdGlvbiBwYXNzIGRvd24uIEJ1dCBjdXJyZW50bHkgZm9yIGd1ZXN0IHZTVkEs
IGRldmljZSBUTEINCj4gaW52YWxpZGF0aW9uIGlzIHBhc3NlZCBkb3duLiBQZXJoYXBzIHdlIGNh
biBhdm9pZCBwYXNzaW5nIGRvd24gZGV2IFRMQg0KPiBmbHVzaCBqdXN0IGxpa2Ugd2hhdCB3ZSBh
cmUgZG9pbmcgZm9yIGd1ZXN0IElPVkEuDQo+IA0KDQpJIHRoaW5rIGRldiBUTEIgaXMgZnVsbHkg
aGFuZGxlZCB3aXRoaW4gSU9NTVUgZHJpdmVyIHRvZGF5LiBJdCBkb2Vzbid0DQpyZXF1aXJlIGRl
dmljZSBkcml2ZXIgdG8gZXhwbGljaXQgdG9nZ2xlLiBXaXRoIHRoaXMgdGhlbiB3ZSBjYW4gZnVs
bHkNCnZpcnR1YWxpemUgZ3Vlc3QgZGV2IFRMQiBpbnZhbGlkYXRpb24gcmVxdWVzdCB0byBzYXZl
IG9uZSBzeXNjYWxsLCBzaW5jZQ0KdGhlIGhvc3QgaXMgc3VwcG9zZWQgdG8gZmx1c2ggZGV2IFRM
QiB3aGVuIHNlcnZpbmcgdGhlIGVhcmxpZXIgSU9UTEINCmludmFsaWRhdGlvbiBwYXNzLWRvd24u
DQoNClRoYW5rcw0KS2V2aW4NCg==
