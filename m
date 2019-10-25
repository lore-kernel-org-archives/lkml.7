Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED86ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC752222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503065AbfJYPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:52:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:40031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502309AbfJYPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:52:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 08:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="282292991"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2019 08:52:41 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 08:52:41 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 08:52:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX153.ccr.corp.intel.com ([10.239.6.53]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 23:52:39 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Topic: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Index: AQHViqRVDFt/7gHf3E+EfuPtxXQ8nKdqHQYAgAAk/YCAAKNMUIAAA0iAgACaPUA=
Date:   Fri, 25 Oct 2019 15:52:39 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0FF0@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
 <20191024214311.43d76a5c@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDC60@SHSMSX104.ccr.corp.intel.com>
 <e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
In-Reply-To: <e950cde8-8cd9-6089-c833-23d2ffb539d1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmFmZjZmYjctOTM0NC00NDg5LWIxMzMtMDRmYjJmZTY1OTA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibTRTM1RTWTlRN20zYmtjSDI0OStFVnFUNnkzNW5ucU83YUxoUGlzM05CbWgwdEtsc0J1UkR1SnJlSkkreXNBRCJ9
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
dDogRnJpZGF5LCBPY3RvYmVyIDI1LCAyMDE5IDEwOjM5IFBNDQo+IA0KPiBIaSwNCj4gDQo+IE9u
IDEwLzI1LzE5IDI6NDAgUE0sIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IGlvYXNpZF9yZWdp
c3Rlcl9hbGxvY2F0b3IoJmlvbW11LT5wYXNpZF9hbGxvY2F0b3IpOw0KPiA+Pj4+ICsJCQlpZiAo
cmV0KSB7DQo+ID4+Pj4gKwkJCQlwcl93YXJuKCJDdXN0b20gUEFTSUQgYWxsb2NhdG9yDQo+ID4+
Pj4gcmVnaXN0ZXJhdGlvbiBmYWlsZWRcbiIpOw0KPiA+Pj4+ICsJCQkJLyoNCj4gPj4+PiArCQkJ
CSAqIERpc2FibGUgc2NhbGFibGUgbW9kZSBvbiB0aGlzDQo+ID4+Pj4gSU9NTVUgaWYgdGhlcmUN
Cj4gPj4+PiArCQkJCSAqIGlzIG5vIGN1c3RvbSBhbGxvY2F0b3IuIE1peGluZw0KPiA+Pj4+IFNN
IGNhcGFibGUgdklPTU1VDQo+ID4+Pj4gKwkJCQkgKiBhbmQgbm9uLVNNIHZJT01NVSBhcmUgbm90
DQo+ID4+Pj4gc3VwcG9ydGVkLg0KPiA+Pj4+ICsJCQkJICovDQo+ID4+Pj4gKwkJCQlpbnRlbF9p
b21tdV9zbSA9IDA7DQo+ID4+PiBJdCdzIGluc3VmZmljaWVudCB0byBkaXNhYmxlIHNjYWxhYmxl
IG1vZGUgYnkgb25seSBjbGVhcmluZw0KPiA+Pj4gaW50ZWxfaW9tbXVfc20uIFRoZSBETUFfUlRB
RERSX1NNVCBiaXQgaW4gcm9vdCBlbnRyeSBoYXMgYWxyZWFkeQ0KPiA+PiBiZWVuDQo+ID4+PiBz
ZXQuIFByb2JhYmx5LCB5b3UgbmVlZCB0bw0KPiA+Pj4NCj4gPj4+IGZvciBlYWNoIGlvbW11DQo+
ID4+PiAJY2xlYXIgRE1BX1JUQUREUl9TTVQgaW4gcm9vdCBlbnRyeQ0KPiA+Pj4NCj4gPj4+IEFs
dGVybmF0aXZlbHksIHNpbmNlIHZTVkEgaXMgdGhlIG9ubHkgY3VzdG9tZXIgb2YgdGhpcyBjdXN0
b20gUEFTSUQNCj4gPj4+IGFsbG9jYXRvciwgaXMgaXQgcG9zc2libGUgdG8gb25seSBkaXNhYmxl
IFNWQSBoZXJlPw0KPiA+Pj4NCj4gPj4gWWVhaCwgSSB0aGluayBkaXNhYmxlIFNWQSBpcyBiZXR0
ZXIuIFdlIGNhbiBzdGlsbCBkbyBnSU9WQSBpbiBTTS4gSQ0KPiA+PiBndWVzcyB3ZSBuZWVkIHRv
IGludHJvZHVjZSBhIGZsYWcgZm9yIHN2YV9lbmFibGVkLg0KPiA+IEknbSBub3Qgc3VyZSB3aGV0
aGVyIHR5aW5nIGFib3ZlIGxvZ2ljIHRvIFNWQSBpcyB0aGUgcmlnaHQgYXBwcm9hY2guDQo+ID4g
SWYgdmNtZCBpbnRlcmZhY2UgZG9lc24ndCB3b3JrLCB0aGUgd2hvbGUgU00gbW9kZSBkb2Vzbid0
IG1ha2UNCj4gPiBzZW5zZSB3aGljaCBpcyBiYXNlZCBvbiBQQVNJRC1ncmFudWxhciBwcm90ZWN0
aW9uIChTVkEgaXMgb25seSBvbmUNCj4gPiB1c2FnZSBhdG9wKS4gSWYgdGhlIG9ubHkgcmVtYWlu
aW5nIHVzYWdlIG9mIFNNIGlzIHRvIG1hcCBnSU9WQSB1c2luZw0KPiA+IHJlc2VydmVkIFBBU0lE
IzAsIHRoZW4gd2h5IG5vdCBkaXNhYmxpbmcgU00gYW5kIGp1c3QgZmFsbGJhY2sgdG8NCj4gPiBs
ZWdhY3kgbW9kZT8NCj4gPg0KPiA+IEJhc2VkIG9uIHRoYXQgSSBwcmVmZXIgdG8gZGlzYWJsaW5n
IHRoZSBTTSBtb2RlIGNvbXBsZXRlbHkgKGJldHRlcg0KPiA+IHRocm91Z2ggYW4gaW50ZXJmYWNl
KSwgYW5kIG1vdmUgdGhlIGxvZ2ljIG91dCBvZiBDT05GSUdfSU5URUxfDQo+ID4gSU9NTVVfU1ZN
DQo+ID4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIGl0IGlzIGRhbmdlcm91cyB0byBkaXNhYmxlIFNN
IGFmdGVyIGJvb3QuIFNNIHVzZXMNCj4gZGlmZmVyZW50IHJvb3QvZGV2aWNlIGNvbnRleHRzIGFu
ZCBwYXNpZCB0YWJsZSBmb3JtYXRzLiBEaXNhYmxpbmcgU00NCj4gYWZ0ZXIgYm9vdCByZXF1aXJl
cyBjaGFuZ2luZyBhYm92ZSBmcm9tIFNNIGZvcm1hdCBpbnRvIGxlZ2FjeSBmb3JtYXQuDQoNCllv
dSBhcmUgY29ycmVjdC4NCg0KPiANCj4gU2luY2UgaW9hc2lkIHJlZ2lzdHJhdGlvbiBmYWlsdXJl
IGlzIGEgcmFyZSBjYXNlLiBIb3cgYWJvdXQgbW92aW5nIHRoaXMNCj4gcGFydCBvZiBjb2RlIHVw
IHRvIHRoZSBlYXJseSBzdGFnZSBvZiBpbnRlbF9pb21tdV9pbml0KCkgYW5kIHJldHVybmluZw0K
PiBlcnJvciBpZiBoYXJkd2FyZSBwcmVzZW50IHZjbWQgY2FwYWJpbGl0eSBidXQgc29mdHdhcmUg
ZmFpbHMgdG8gcmVnaXN0ZXINCj4gYSBjdXN0b20gaW9hc2lkIGFsbG9jYXRvcj8NCj4gDQoNCkl0
IG1ha2VzIHNlbnNlIHRvIG1lLg0KDQpUaGFua3MNCktldmluDQo=
