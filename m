Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BE1208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FJKHAKtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfDYIf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:35:59 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:7730
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfDYIf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXJz44PtOSt6G4EGot2G8IJON1PCQjWT+NvjE1CSNAc=;
 b=FJKHAKtPh/y3MGTpycl13FqEJ8tlLVOIP7IA9UgLrWinHSAkiudsUb5NZssvcZIkBj+x3h4dSYnLim2S840yNhTjHoLgJ0/6tKp2Y112HesF3kch/uliNkUqdDYWywq3kMPXZQhbOVaroKdW2/Bqtw2kBKGWxJrW2P1+ircisyA=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6575.namprd05.prod.outlook.com (20.178.248.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.7; Thu, 25 Apr 2019 08:35:50 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 08:35:50 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Topic: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Index: AQHU+pVKHjTn6xj4L0+rY3D5lHMzK6ZLWbsAgAACzYCAATIOAA==
Date:   Thu, 25 Apr 2019 08:35:50 +0000
Message-ID: <1dc89cb4bea186ced4cc11ce49586cf651564d88.camel@vmware.com>
References: <20190424115918.3380-1-thellstrom@vmware.com>
         <20190424115918.3380-5-thellstrom@vmware.com>
         <d1c9c6c9-2cb0-d75f-03fa-805907991ed1@amd.com>
         <3c7b57fe1d576cd8fa10714c0103528978bee1dd.camel@vmware.com>
In-Reply-To: <3c7b57fe1d576cd8fa10714c0103528978bee1dd.camel@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b830047b-60c9-4023-02d1-08d6c95905cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6575;
x-ms-traffictypediagnostic: MN2PR05MB6575:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB65751F7A9BDD0EC38EECE0EAA13D0@MN2PR05MB6575.namprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(71190400001)(71200400001)(66946007)(97736004)(6486002)(5660300002)(53936002)(6512007)(229853002)(2501003)(25786009)(8676002)(6246003)(305945005)(8936002)(2906002)(81166006)(3846002)(7736002)(68736007)(256004)(14444005)(6436002)(81156014)(478600001)(6116002)(118296001)(93886005)(86362001)(4326008)(110136005)(64756008)(54906003)(6506007)(91956017)(66556008)(66446008)(76176011)(36756003)(14454004)(107886003)(66476007)(99286004)(66574012)(486006)(186003)(66066001)(316002)(2616005)(476003)(11346002)(446003)(26005)(73956011)(76116006)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6575;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IsmTGmrGczmGnzqXd9MUhNcb2a2vq88fNVegnBMlh8JW0+o+zNS0Oo1YPSZ6NCaRPNLZMWXlSTOz5sdHslov+mwoyIkCZPJs4xN1sQfQ/d2wfWHimW9aM4l3/KMZFt1zUWmTOfPJAmcQst/zxme5IMQi22/QRg7CSr+iTkZQc1VM/Ugd2cROAH0QpVIWjHQLABFj9RM3RI7qMPqAQ1SbbjAcQ9yCAFOzjH/7yFrizPNPHCuY5pVnqYc6qJgl/OaMxOlFShaQtKvdo5udwIcEKwuXUB0pp8F/azTIQFoqv5Lo4PiA64uklrn2aV0UlLfhws5b48oxIZ90CV6Atkz2ml2AjnhTqlQrlFSLI8WiTI6IzMxnSdiWcUrQBxuSEO1qgsWZn1Q/MSJiOTFondrR8NdjhKVlRiBy6gqPbY+QIeM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <477B949CB112594689DDA95F0654213B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b830047b-60c9-4023-02d1-08d6c95905cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:35:50.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENocmlzdGlhbiwNCg0KT24gV2VkLCAyMDE5LTA0LTI0IGF0IDE2OjIwICswMjAwLCBUaG9t
YXMgSGVsbHN0csO2bSB3cm90ZToNCj4gT24gV2VkLCAyMDE5LTA0LTI0IGF0IDE0OjEwICswMDAw
LCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4gPiBBbSAyNC4wNC4xOSB1bSAxNDowMCBzY2hy
aWViIFRob21hcyBIZWxsc3Ryb206DQo+ID4gPiBBZGQgYSBwb2ludGVyIHRvIHRoZSBzdHJ1Y3Qg
dm1fb3BlcmF0aW9uc19zdHJ1Y3QgaW4gdGhlDQo+ID4gPiBib19kZXZpY2UsDQo+ID4gPiBhbmQN
Cj4gPiA+IGFzc2lnbiB0aGF0IHBvaW50ZXIgdG8gdGhlIGRlZmF1bHQgdmFsdWUgY3VycmVudGx5
IHVzZWQuDQo+ID4gPiANCj4gPiA+IFRoZSBkcml2ZXIgY2FuIHRoZW4gb3B0aW9uYWxseSBtb2Rp
ZnkgdGhhdCBwb2ludGVyIGFuZCB0aGUgbmV3DQo+ID4gPiB2YWx1ZQ0KPiA+ID4gY2FuIGJlIHVz
ZWQgZm9yIGVhY2ggbmV3IHZtYSBjcmVhdGVkLg0KPiA+ID4gDQo+ID4gPiBDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gPiANCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFRob21hcyBIZWxsc3Ryb20gPHRoZWxsc3Ryb21Adm13YXJlLmNvbT4NCj4gPiA+
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+ID4gDQo+ID4gR29pbmcgdG8gcGljayB0aG9zZSB0d28gVFRNIHBhdGNoZXMgdXAgZm9yIGFt
ZC1zdGFnaW5nLWRybS1uZXh0Lg0KPiANCj4gV2lsbCB5b3UgYmUgcmVseWluZyBvbiBlaXRoZXIg
cGF0Y2ggZm9yIHJlbGF0ZWQgd29yaz8gT3RoZXJ3aXNlIGl0DQo+IHdvdWxkIGJlIHNpbXBsZXIg
Zm9yIHVzIHRvIHVzZSB2bXdnZngtbmV4dCBmb3IgdGhlIHdob2xlIHNlcmllcywNCj4gdGFyZ2V0
aW5nIDUuMy4NCj4gDQo+IFRob21hcw0KDQpJcyB0aGlzIE9LIHdpdGggeW91Pw0KDQpUaGFua3Ms
DQpUaG9tYXMNCg0KDQoNCj4gDQo+ID4gQ2hyaXN0aWFuLg0KPiA+IA0KPiA+ID4gLS0tDQo+ID4g
PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgICAgfCAxICsNCj4gPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYyB8IDYgKysrLS0tDQo+ID4gPiAgIGluY2x1ZGUvZHJt
L3R0bS90dG1fYm9fZHJpdmVyLmggfCA2ICsrKysrKw0KPiA+ID4gICAzIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX2JvLmMNCj4gPiA+IGluZGV4IDNmNTY2NDdjZGIzNS4uMWM4NWJlYzAwNDcyIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiA+ID4gQEAgLTE2NTYsNiArMTY1Niw3
IEBAIGludCB0dG1fYm9fZGV2aWNlX2luaXQoc3RydWN0IHR0bV9ib19kZXZpY2UNCj4gPiA+ICpi
ZGV2LA0KPiA+ID4gICAJbXV0ZXhfbG9jaygmdHRtX2dsb2JhbF9tdXRleCk7DQo+ID4gPiAgIAls
aXN0X2FkZF90YWlsKCZiZGV2LT5kZXZpY2VfbGlzdCwgJmdsb2ItPmRldmljZV9saXN0KTsNCj4g
PiA+ICAgCW11dGV4X3VubG9jaygmdHRtX2dsb2JhbF9tdXRleCk7DQo+ID4gPiArCWJkZXYtPnZt
X29wcyA9ICZ0dG1fYm9fdm1fb3BzOw0KPiA+ID4gICANCj4gPiA+ICAgCXJldHVybiAwOw0KPiA+
ID4gICBvdXRfbm9fc3lzOg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX2JvX3ZtLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYw0KPiA+
ID4gaW5kZXggZTg2YTI5YTFlNTFmLi5iZmIyNWI4MWZlZDcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9ib192bS5jDQo+ID4gPiBAQCAtMzk1LDcgKzM5NSw3IEBAIHN0YXRpYyBpbnQg
dHRtX2JvX3ZtX2FjY2VzcyhzdHJ1Y3QNCj4gPiA+IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2ln
bmVkIGxvbmcgYWRkciwNCj4gPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gPiAgIH0NCj4gPiA+ICAg
DQo+ID4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9f
dm1fb3BzID0gew0KPiA+ID4gK2NvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1f
Ym9fdm1fb3BzID0gew0KPiA+ID4gICAJLmZhdWx0ID0gdHRtX2JvX3ZtX2ZhdWx0LA0KPiA+ID4g
ICAJLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwNCj4gPiA+ICAgCS5jbG9zZSA9IHR0bV9ib192bV9j
bG9zZSwNCj4gPiA+IEBAIC00NDUsNyArNDQ1LDcgQEAgaW50IHR0bV9ib19tbWFwKHN0cnVjdCBm
aWxlICpmaWxwLCBzdHJ1Y3QNCj4gPiA+IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gPiAgIAlp
ZiAodW5saWtlbHkocmV0ICE9IDApKQ0KPiA+ID4gICAJCWdvdG8gb3V0X3VucmVmOw0KPiA+ID4g
ICANCj4gPiA+IC0Jdm1hLT52bV9vcHMgPSAmdHRtX2JvX3ZtX29wczsNCj4gPiA+ICsJdm1hLT52
bV9vcHMgPSBiZGV2LT52bV9vcHM7DQo+ID4gPiAgIA0KPiA+ID4gICAJLyoNCj4gPiA+ICAgCSAq
IE5vdGU6IFdlJ3JlIHRyYW5zZmVycmluZyB0aGUgYm8gcmVmZXJlbmNlIHRvDQo+ID4gPiBAQCAt
NDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1fZmJkZXZfbW1hcChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QN
Cj4gPiA+ICp2bWEsDQo+ID4gPiBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+ID4g
ICANCj4gPiA+ICAgCXR0bV9ib19nZXQoYm8pOw0KPiA+ID4gICANCj4gPiA+IC0Jdm1hLT52bV9v
cHMgPSAmdHRtX2JvX3ZtX29wczsNCj4gPiA+ICsJdm1hLT52bV9vcHMgPSBiby0+YmRldi0+dm1f
b3BzOw0KPiA+ID4gICAJdm1hLT52bV9wcml2YXRlX2RhdGEgPSBibzsNCj4gPiA+ICAgCXZtYS0+
dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7DQo+ID4gPiAgIAl2bWEtPnZtX2ZsYWdzIHw9IFZNX0lP
IHwgVk1fRE9OVEVYUEFORDsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRt
X2JvX2RyaXZlci5oDQo+ID4gPiBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4g
PiA+IGluZGV4IGNiZjMxODBjYjYxMi4uY2ZlYWZmNWQ5NzA2IDEwMDY0NA0KPiA+ID4gLS0tIGEv
aW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9kcm0v
dHRtL3R0bV9ib19kcml2ZXIuaA0KPiA+ID4gQEAgLTQ0Myw2ICs0NDMsOSBAQCBleHRlcm4gc3Ry
dWN0IHR0bV9ib19nbG9iYWwgew0KPiA+ID4gICAgKiBAZHJpdmVyOiBQb2ludGVyIHRvIGEgc3Ry
dWN0IHR0bV9ib19kcml2ZXIgc3RydWN0IHNldHVwIGJ5DQo+ID4gPiB0aGUNCj4gPiA+IGRyaXZl
ci4NCj4gPiA+ICAgICogQG1hbjogQW4gYXJyYXkgb2YgbWVtX3R5cGVfbWFuYWdlcnMuDQo+ID4g
PiAgICAqIEB2bWFfbWFuYWdlcjogQWRkcmVzcyBzcGFjZSBtYW5hZ2VyDQo+ID4gPiArICogQHZt
X29wczogUG9pbnRlciB0byB0aGUgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHVzZWQgZm9y
DQo+ID4gPiB0aGlzDQo+ID4gPiArICogZGV2aWNlJ3MgVk0gb3BlcmF0aW9ucy4gVGhlIGRyaXZl
ciBtYXkgb3ZlcnJpZGUgdGhpcyBiZWZvcmUNCj4gPiA+IHRoZQ0KPiA+ID4gZmlyc3QNCj4gPiA+
ICsgKiBtbWFwKCkgY2FsbC4NCj4gPiA+ICAgICogbHJ1X2xvY2s6IFNwaW5sb2NrIHRoYXQgcHJv
dGVjdHMgdGhlIGJ1ZmZlcitkZXZpY2UgbHJ1IGxpc3RzDQo+ID4gPiBhbmQNCj4gPiA+ICAgICog
ZGRlc3Ryb3kgbGlzdHMuDQo+ID4gPiAgICAqIEBkZXZfbWFwcGluZzogQSBwb2ludGVyIHRvIHRo
ZSBzdHJ1Y3QgYWRkcmVzc19zcGFjZQ0KPiA+ID4gcmVwcmVzZW50aW5nIHRoZQ0KPiA+ID4gQEAg
LTQ2MSw2ICs0NjQsNyBAQCBzdHJ1Y3QgdHRtX2JvX2RldmljZSB7DQo+ID4gPiAgIAlzdHJ1Y3Qg
dHRtX2JvX2dsb2JhbCAqZ2xvYjsNCj4gPiA+ICAgCXN0cnVjdCB0dG1fYm9fZHJpdmVyICpkcml2
ZXI7DQo+ID4gPiAgIAlzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgbWFuW1RUTV9OVU1fTUVN
X1RZUEVTXTsNCj4gPiA+ICsJY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0ICp2bV9v
cHM7DQo+ID4gPiAgIA0KPiA+ID4gICAJLyoNCj4gPiA+ICAgCSAqIFByb3RlY3RlZCBieSBpbnRl
cm5hbCBsb2Nrcy4NCj4gPiA+IEBAIC00ODksNiArNDkzLDggQEAgc3RydWN0IHR0bV9ib19kZXZp
Y2Ugew0KPiA+ID4gICAJYm9vbCBub19yZXRyeTsNCj4gPiA+ICAgfTsNCj4gPiA+ICAgDQo+ID4g
PiArZXh0ZXJuIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3Bz
Ow0KPiA+ID4gKw0KPiA+ID4gICAvKioNCj4gPiA+ICAgICogc3RydWN0IHR0bV9scnVfYnVsa19t
b3ZlX3Bvcw0KPiA+ID4gICAgKg0K
