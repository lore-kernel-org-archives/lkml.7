Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4374DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfJ2SwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:52:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:12648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfJ2SwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:52:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 11:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="399895973"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2019 11:52:04 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 11:52:04 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 11:52:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.63]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 02:52:02 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Topic: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Index: AQHViqRXy9Yx+C3oUEClzLBbVKfxc6dq9GqwgAC9yACAAEk4gIADmobwgAAjMYCAAkPcIA==
Date:   Tue, 29 Oct 2019 18:52:01 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DF155@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
        <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
        <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
 <20191028091049.04f2d83f@jacob-builder>
In-Reply-To: <20191028091049.04f2d83f@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTJlOGFkYjYtNzFkZi00MzEwLWIyNWItZDlkMmRmMTJkYWYyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVUtDSFRFc25XdUpISkVMQlNwUkFZQWltOStjXC83ZWVMU2UrUldHVHhNMGlKdzRvbjNrN3RmZjc5T3pBc2NrbFIifQ==
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

PiBGcm9tOiBKYWNvYiBQYW4gW21haWx0bzpqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbV0N
Cj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyOSwgMjAxOSAxMjoxMSBBTQ0KPiANCj4gT24gTW9u
LCAyOCBPY3QgMjAxOSAwNjowNjozMyArMDAwMA0KPiAiVGlhbiwgS2V2aW4iIDxrZXZpbi50aWFu
QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gPj4+ICvCoMKgwqAgLyogUEFTSUQgYmFzZWQg
ZGV2IFRMQnMsIG9ubHkgc3VwcG9ydCBhbGwgUEFTSURzIG9yIHNpbmdsZQ0KPiA+ID4gPj4+IFBB
U0lEICovDQo+ID4gPiA+Pj4gK8KgwqDCoCB7MSwgMSwgMH0sDQo+ID4gPiA+Pg0KPiA+ID4gPj4g
SSBmb3Jnb3QgcHJldmlvdXMgZGlzY3Vzc2lvbi4gaXMgaXQgbmVjZXNzYXJ5IHRvIHBhc3MgZG93
biBkZXYNCj4gPiA+ID4+IFRMQiBpbnZhbGlkYXRpb24NCj4gPiA+ID4+IHJlcXVlc3RzPyBDYW4g
aXQgYmUgaGFuZGxlZCBieSBob3N0IGlPTU1VIGRyaXZlciBhdXRvbWF0aWNhbGx5Pw0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBob3N0IFNWQSwgd2hlbiBhIG1lbW9yeSBpcyB1bm1hcHBlZCwgZHJpdmVy
IGNhbGxiYWNrIHdpbGwNCj4gPiA+ID4gaW52YWxpZGF0ZSBkZXYgSU9UTEIgZXhwbGljaXRseS4g
U28gSSBndWVzcyB3ZSBuZWVkIHRvIHBhc3MgZG93bg0KPiA+ID4gPiBpdCBmb3IgZ3Vlc3QgY2Fz
ZS4gVGhpcyBpcyBhbHNvIHJlcXVpcmVkIGZvciBndWVzdCBpb3ZhIG92ZXIgMXN0DQo+ID4gPiA+
IGxldmVsIHVzYWdlIGFzIGZhciBhcyBjYW4gc2VlLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFNv
cnJ5LCBJIGNvbmZ1c2VkIGd1ZXN0IHZJT1ZBIGFuZCBndWVzdCB2U1ZBLiBGb3IgZ3Vlc3QgdklP
VkEsIG5vDQo+ID4gPiBkZXZpY2UgVExCIGludmFsaWRhdGlvbiBwYXNzIGRvd24uIEJ1dCBjdXJy
ZW50bHkgZm9yIGd1ZXN0IHZTVkEsDQo+ID4gPiBkZXZpY2UgVExCIGludmFsaWRhdGlvbiBpcyBw
YXNzZWQgZG93bi4gUGVyaGFwcyB3ZSBjYW4gYXZvaWQNCj4gPiA+IHBhc3NpbmcgZG93biBkZXYg
VExCIGZsdXNoIGp1c3QgbGlrZSB3aGF0IHdlIGFyZSBkb2luZyBmb3IgZ3Vlc3QNCj4gPiA+IElP
VkEuDQo+ID4NCj4gPiBJIHRoaW5rIGRldiBUTEIgaXMgZnVsbHkgaGFuZGxlZCB3aXRoaW4gSU9N
TVUgZHJpdmVyIHRvZGF5LiBJdCBkb2Vzbid0DQo+ID4gcmVxdWlyZSBkZXZpY2UgZHJpdmVyIHRv
IGV4cGxpY2l0IHRvZ2dsZS4gV2l0aCB0aGlzIHRoZW4gd2UgY2FuIGZ1bGx5DQo+ID4gdmlydHVh
bGl6ZSBndWVzdCBkZXYgVExCIGludmFsaWRhdGlvbiByZXF1ZXN0IHRvIHNhdmUgb25lIHN5c2Nh
bGwsDQo+ID4gc2luY2UgdGhlIGhvc3QgaXMgc3VwcG9zZWQgdG8gZmx1c2ggZGV2IFRMQiB3aGVu
IHNlcnZpbmcgdGhlIGVhcmxpZXINCj4gPiBJT1RMQiBpbnZhbGlkYXRpb24gcGFzcy1kb3duLg0K
PiANCj4gSW4gdGhlIHByZXZpb3VzIGRpc2N1c3Npb25zLCB3ZSB0aG91Z2h0IGFib3V0IG1ha2lu
ZyBJT1RMQiBmbHVzaA0KPiBpbmNsdXNpdmUsIHdoZXJlIElPVExCIGZsdXNoIHdvdWxkIGFsd2F5
cyBpbmNsdWRlIGRldmljZSBUTEIgZmx1c2guIEJ1dA0KPiB3ZSB0aG91Z2h0IHN1Y2ggYmVoYXZp
b3IgY2Fubm90IGJlIGFzc3VtZWQgZm9yIGFsbCBWTU1zLCBzb21lIG1heSBzdGlsbA0KPiBkbyBl
eHBsaWNpdCBkZXYgVExCIGZsdXNoLiBTbyBmb3IgY29tcGxldGVuZXNzLCB3ZSBpbmNsdWRlZCBk
ZXYgVExCDQo+IGhlcmUuDQoNCmlzIHRoZXJlIHN1Y2ggZXhhbXBsZSBvciBhIGxpbmsgdG8gcHJl
dmlvdXMgZGlzY3Vzc2lvbj8gSGVyZSB3ZSBhcmUNCnRhbGtpbmcgYWJvdXQgaG9zdCBJT01NVSBk
cml2ZXIgYmVoYXZpb3IsIGluc3RlYWQgb2YgVk1NLiBCdXQgSSdtDQpub3Qgc3Ryb25nIG9uIHRo
aXMsIHNpbmNlIGl0J3MgbW9yZSBhbiBvcHRpbWl6YXRpb24uIEJ1dCB0aGVyZSByZW1haW5zDQpv
bmUgdW5jbGVhciBhcmVhLiBJZiB3ZSBkbyB3YW50IHRvIHN1cHBvcnQgc3VjaCB1c2FnZSB3aXRo
IGV4cGxpY2l0DQpkZXYgVExCIGZsdXNoLCBob3cgZG9lcyBob3N0IElPTU1VIGRyaXZlciBhdm9p
ZCBkb2luZyBpbXBsaWNpdA0KZGV2IFRMQiBmbHVzaCB3aGVuIHNlcnZpbmcgaW90bGIgaW52YWxp
ZGF0aW9uIHJlcXVlc3Q/IElzIGl0IGFscmVhZHkNCmRlc2lnbmVkIHN1Y2ggd2F5IHRoYXQgdXNl
ci1wYXNzZWQtZG93biBpb3RsYiBpbnZhbGlkYXRpb24gcmVxdWVzdA0Kb25seSBpbnZhbGlkYXRl
cyBpb3RsYiB3aGlsZSBrZXJuZWwtdHJpZ2dlcmVkIGlvdGxiIGludmFsaWRhdGlvbiBzdGlsbA0K
ZG9lcyBpbXBsaWNpdCBkZXYgVExCIGZsdXNoPw0KDQpUaGFua3MNCktldmluDQoNCg==
