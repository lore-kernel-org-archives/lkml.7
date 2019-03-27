Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45952075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FbQr5zXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfC0OSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:18:06 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:6628
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfC0OSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b8t/pqaGjhIXHICaj7jn4ctsOzlprPPiO9fNZlGON4=;
 b=FbQr5zXDluylcWvReFLc63ZuAmKEPy1aGUIOjV4ExnQZs8GVZlZy29Ei1O4eA3oJ1P8zOcfiaAioZgwpbuZXyn0AQPHftF+WNFHfO+fhAj/RNJkU80StIF9zFs3odlTddu3FnbipEJqp5VkzZrAELaW1TYujSmqhRzNzZUv6+L8=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2496.eurprd05.prod.outlook.com (10.168.136.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:17:57 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 14:17:57 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "xin.zeng@intel.com" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Neo Jia <cjia@nvidia.com>
Subject: RE: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
Thread-Topic: [PATCH v8 7/9] vfio/mdev: Add iommu related member in
 mdev_device
Thread-Index: AQHU4qtOeptnM02AaE+9bgMdw4SWLqYdqGQAgAHg/PA=
Date:   Wed, 27 Mar 2019 14:17:57 +0000
Message-ID: <VI1PR0501MB2271172964AFA3CDD6F1B02CD1580@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-8-baolu.lu@linux.intel.com>
 <b45dabe5-04ef-0e05-db25-c8edf111e355@nvidia.com>
In-Reply-To: <b45dabe5-04ef-0e05-db25-c8edf111e355@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:dc01:6645:55b9:495a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cae08cb-10a4-4cff-15c1-08d6b2bf02fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2496;
x-ms-traffictypediagnostic: VI1PR0501MB2496:
x-microsoft-antispam-prvs: <VI1PR0501MB24964401D94ABB1890F18F0ED1580@VI1PR0501MB2496.eurprd05.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(13464003)(229853002)(11346002)(305945005)(6436002)(316002)(68736007)(76176011)(6506007)(7736002)(186003)(102836004)(81166006)(8936002)(7416002)(53546011)(7696005)(106356001)(105586002)(2906002)(74316002)(52536014)(33656002)(478600001)(6116002)(81156014)(14454004)(4326008)(6246003)(97736004)(53936002)(55016002)(9686003)(476003)(71190400001)(99286004)(71200400001)(86362001)(256004)(110136005)(54906003)(46003)(446003)(8676002)(5660300002)(486006)(5024004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2496;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kGp3RkxCi35hjhTuJQ40zPIoaoyxdRQUU8fkjNvy3GHlLlLUBclO7o6+aDKlXMDcCnlFey+2Sha8/GQrjwGpvLH//VFGP/wNolk8vMUNd5iA8iE2Qizz+kUSF3rRHjAdZT/vfqxQaNB8q9AvRUD8rde6iXfNW/XBwWznaF5NHYOmnDZO+0k8yU5zzQ/dhzJgRTwmJc668ElSE68CuXeOzAaugiMSc9geanRG3OrxrXn45xuBD3vUY0g2KU1uYwDrJVh1t/V3z6e5n/5rLNvik2EMN5oDFeLtDd5ULrtn4NzJlwfrpv+fh9n+fCvW/Wt5HrVyk2GD76UET/2g+9XNRQ4XLmyPTybR9OPCZkmYA0tpZxytwgFEP+iC6xAzHErjq2sJGB6jq/g9aB7AhxhBz/aL+ABdBoRAr+vCuXoogRg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cae08cb-10a4-4cff-15c1-08d6b2bf02fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:17:57.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBLaXJ0aSBXYW5raGVkZQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAy
NiwgMjAxOSA0OjMzIEFNDQo+IFRvOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
PjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+Ow0KPiBEYXZpZCBXb29kaG91c2UgPGR3
bXcyQGluZnJhZGVhZC5vcmc+OyBBbGV4IFdpbGxpYW1zb24NCj4gPGFsZXgud2lsbGlhbXNvbkBy
ZWRoYXQuY29tPg0KPiBDYzogYXNob2sucmFqQGludGVsLmNvbTsgc2FuamF5Lmsua3VtYXJAaW50
ZWwuY29tOw0KPiBqYWNvYi5qdW4ucGFuQGludGVsLmNvbTsga2V2aW4udGlhbkBpbnRlbC5jb207
IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi0NCj4gcGhpbGlwcGUuYnJ1Y2tlckBhcm0uY29t
PjsgeWkubC5saXVAaW50ZWwuY29tOyB5aS55LnN1bkBpbnRlbC5jb207DQo+IHBldGVyeEByZWRo
YXQuY29tOyB0aXdlaS5iaWVAaW50ZWwuY29tOyB4aW4uemVuZ0BpbnRlbC5jb207DQo+IGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4
LmludGVsLmNvbT47IE5lbyBKaWENCj4gPGNqaWFAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OCA3LzldIHZmaW8vbWRldjogQWRkIGlvbW11IHJlbGF0ZWQgbWVtYmVyIGluDQo+
IG1kZXZfZGV2aWNlDQo+IA0KPiANCj4gDQo+IE9uIDMvMjUvMjAxOSA3OjAwIEFNLCBMdSBCYW9s
dSB3cm90ZToNCj4gPiBBIHBhcmVudCBkZXZpY2UgbWlnaHQgY3JlYXRlIGRpZmZlcmVudCB0eXBl
cyBvZiBtZWRpYXRlZCBkZXZpY2VzLiBGb3INCj4gPiBleGFtcGxlLCBhIG1lZGlhdGVkIGRldmlj
ZSBjb3VsZCBiZSBjcmVhdGVkIGJ5IHRoZSBwYXJlbnQgZGV2aWNlIHdpdGgNCj4gPiBmdWxsIGlz
b2xhdGlvbiBhbmQgcHJvdGVjdGlvbiBwcm92aWRlZCBieSB0aGUgSU9NTVUuIE9uZSB1c2FnZSBj
YXNlDQo+ID4gY291bGQgYmUgZm91bmQgb24gSW50ZWwgcGxhdGZvcm1zIHdoZXJlIGEgbWVkaWF0
ZWQgZGV2aWNlIGlzIGFuDQo+ID4gYXNzaWduYWJsZSBzdWJzZXQgb2YgYSBQQ0ksIHRoZSBETUEg
cmVxdWVzdHMgb24gYmVoYWxmIG9mIGl0IGFyZSBhbGwNCj4gPiB0YWdnZWQgd2l0aCBhIFBBU0lE
LiBTaW5jZSBJT01NVSBzdXBwb3J0cyBQQVNJRC1ncmFudWxhciB0cmFuc2xhdGlvbnMNCj4gPiAo
c2NhbGFibGUgbW9kZSBpbiBWVC1kIDMuMCksIHRoaXMgbWVkaWF0ZWQgZGV2aWNlIGNvdWxkIGJl
DQo+ID4gaW5kaXZpZHVhbGx5IHByb3RlY3RlZCBhbmQgaXNvbGF0ZWQgYnkgYW4gSU9NTVUuDQo+
ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgbWVtYmVyIGluIHRoZSBzdHJ1Y3QgbWRldl9k
ZXZpY2UgdG8gaW5kaWNhdGUNCj4gPiB0aGF0IHRoZSBtZWRpYXRlZCBkZXZpY2UgcmVwcmVzZW50
ZWQgYnkgbWRldiBjb3VsZCBiZSBpc29sYXRlZCBhbmQNCj4gPiBwcm90ZWN0ZWQgYnkgYXR0YWNo
aW5nIGEgZG9tYWluIHRvIGEgZGV2aWNlIHJlcHJlc2VudGVkIGJ5DQo+ID4gbWRldi0+aW9tbXVf
ZGV2aWNlLiBJdCBhbHNvIGFkZHMgYSBoZWxwZXIgdG8gYWRkIG9yIHNldCB0aGUgaW9tbXUNCj4g
PiBkZXZpY2UuDQo+ID4NCj4gPiAqIG1kZXZfZGV2aWNlLT5pb21tdV9kZXZpY2UNCj4gPiAgIC0g
VGhpcywgaWYgc2V0LCBpbmRpY2F0ZXMgdGhhdCB0aGUgbWVkaWF0ZWQgZGV2aWNlIGNvdWxkDQo+
ID4gICAgIGJlIGZ1bGx5IGlzb2xhdGVkIGFuZCBwcm90ZWN0ZWQgYnkgSU9NTVUgdmlhIGF0dGFj
aGluZw0KPiA+ICAgICBhbiBpb21tdSBkb21haW4gdG8gdGhpcyBkZXZpY2UuIElmIGVtcHR5LCBp
dCBpbmRpY2F0ZXMNCj4gPiAgICAgdXNpbmcgdmVuZG9yIGRlZmluZWQgaXNvbGF0aW9uLCBoZW5j
ZSBieXBhc3MgSU9NTVUuDQo+ID4NCj4gPiAqIG1kZXZfc2V0L2dldF9pb21tdV9kZXZpY2UoZGV2
LCBpb21tdV9kZXZpY2UpDQo+ID4gICAtIFNldCBvciBnZXQgdGhlIGlvbW11IGRldmljZSB3aGlj
aCByZXByZXNlbnRzIHRoaXMgbWRldg0KPiA+ICAgICBpbiBJT01NVSdzIGRldmljZSBzY29wZS4g
RHJpdmVycyBkb24ndCBuZWVkIHRvIHNldCB0aGUNCj4gPiAgICAgaW9tbXUgZGV2aWNlIGlmIGl0
IHVzZXMgdmVuZG9yIGRlZmluZWQgaXNvbGF0aW9uLg0KPiA+DQo+ID4gQ2M6IEFzaG9rIFJhaiA8
YXNob2sucmFqQGludGVsLmNvbT4NCj4gPiBDYzogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxp
bnV4LmludGVsLmNvbT4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+
DQo+ID4gQ2M6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5
OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IEFs
ZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlLmJydWNrZXJAYXJtLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy92ZmlvL21kZXYvbWRldl9jb3JlLmMgICAgfCAxOCArKysr
KysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy92ZmlvL21kZXYvbWRldl9wcml2YXRlLmggfCAg
MSArDQo+ID4gIGluY2x1ZGUvbGludXgvbWRldi5oICAgICAgICAgICAgIHwgMTQgKysrKysrKysr
KysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9jb3JlLmMNCj4gPiBiL2RyaXZlcnMv
dmZpby9tZGV2L21kZXZfY29yZS5jIGluZGV4IGI5NmZlZGM3N2VlNS4uMWI2NDM1NTI5MTY2DQo+
ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9jb3JlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X2NvcmUuYw0KPiA+IEBAIC0zOTAsNiArMzkwLDI0
IEBAIGludCBtZGV2X2RldmljZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2LCBib29sDQo+IGZv
cmNlX3JlbW92ZSkNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiAraW50IG1kZXZf
c2V0X2lvbW11X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2UNCj4gPiAr
KmlvbW11X2RldmljZSkgew0KPiA+ICsJc3RydWN0IG1kZXZfZGV2aWNlICptZGV2ID0gdG9fbWRl
dl9kZXZpY2UoZGV2KTsNCj4gPiArDQo+ID4gKwltZGV2LT5pb21tdV9kZXZpY2UgPSBpb21tdV9k
ZXZpY2U7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJP
TChtZGV2X3NldF9pb21tdV9kZXZpY2UpOw0KPiA+ICsNCj4gPiArc3RydWN0IGRldmljZSAqbWRl
dl9nZXRfaW9tbXVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ICsJc3RydWN0IG1k
ZXZfZGV2aWNlICptZGV2ID0gdG9fbWRldl9kZXZpY2UoZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gbWRldi0+aW9tbXVfZGV2aWNlOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0wobWRldl9n
ZXRfaW9tbXVfZGV2aWNlKTsNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgX19pbml0IG1kZXZfaW5p
dCh2b2lkKQ0KPiA+ICB7DQo+ID4gIAlyZXR1cm4gbWRldl9idXNfcmVnaXN0ZXIoKTsNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9wcml2YXRlLmgNCj4gPiBiL2RyaXZl
cnMvdmZpby9tZGV2L21kZXZfcHJpdmF0ZS5oDQo+ID4gaW5kZXggMzc5NzU4YzUyYjFiLi5iZmI3
YjIyYTdjYjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZmlvL21kZXYvbWRldl9wcml2YXRl
LmgNCj4gPiArKysgYi9kcml2ZXJzL3ZmaW8vbWRldi9tZGV2X3ByaXZhdGUuaA0KPiA+IEBAIC0z
NCw2ICszNCw3IEBAIHN0cnVjdCBtZGV2X2RldmljZSB7DQo+ID4gIAlzdHJ1Y3QgbGlzdF9oZWFk
IG5leHQ7DQo+ID4gIAlzdHJ1Y3Qga29iamVjdCAqdHlwZV9rb2JqOw0KPiA+ICAJYm9vbCBhY3Rp
dmU7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICppb21tdV9kZXZpY2U7DQo+ID4gIH07DQo+ID4NClRo
aXMgaXMgbm90IGEgcGVyZm9ybWFuY2UgcGF0aCwgYnV0IGl0IGlzIGEgZ29vZCBwcmFjdGljZSB0
byBjcmVhdGUgbmF0dXJhbGx5IGFsaWduZWQvcGFja2VkIHN0cnVjdHVyZXMuDQpZb3Ugc2hvdWxk
IGRlZmluZSBzdHJ1Y3QgZGV2aWNlICppb21tdV9kZXZpY2U7IGJlZm9yZSBib29sIGFjdGl2ZS4N
Cg==
