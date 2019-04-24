Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D221901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="axEdVywr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfDXOUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:20:40 -0400
Received: from mail-eopbgr690082.outbound.protection.outlook.com ([40.107.69.82]:15560
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfDXOUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TzKIvP2+2Q/AJIy65VFvvyxwWx5wzGZVgSOI+6KE/4=;
 b=axEdVywrppr+8AuIIrNb9zU5OhLx/kJ5YqsBvVHQxM6uZNoDZvQpptMAS1BCy2EsqJzGsOPpZqUVce1o2M3eozsQ61Bv1zFkHGMOflcp/zuWjqjY5Id/aUv8cVLdHaD0PL3ifh3WNOT/4bgfFebhO5KvfL/va6J9RgPky8NDTeA=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6174.namprd05.prod.outlook.com (20.178.240.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.9; Wed, 24 Apr 2019 14:20:24 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 14:20:24 +0000
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
Thread-Index: AQHU+pVKHjTn6xj4L0+rY3D5lHMzK6ZLWbsAgAACzYA=
Date:   Wed, 24 Apr 2019 14:20:24 +0000
Message-ID: <3c7b57fe1d576cd8fa10714c0103528978bee1dd.camel@vmware.com>
References: <20190424115918.3380-1-thellstrom@vmware.com>
         <20190424115918.3380-5-thellstrom@vmware.com>
         <d1c9c6c9-2cb0-d75f-03fa-805907991ed1@amd.com>
In-Reply-To: <d1c9c6c9-2cb0-d75f-03fa-805907991ed1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a82ecdc6-1c8e-4c99-b26a-08d6c8bffe20
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6174;
x-ms-traffictypediagnostic: MN2PR05MB6174:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB6174A2E9232FE9E29C018D70A13C0@MN2PR05MB6174.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(76176011)(6116002)(3846002)(478600001)(5660300002)(8676002)(110136005)(2906002)(256004)(14454004)(8936002)(81166006)(229853002)(54906003)(6486002)(316002)(6436002)(6512007)(68736007)(81156014)(118296001)(66066001)(25786009)(66446008)(305945005)(53936002)(107886003)(2616005)(36756003)(2501003)(97736004)(64756008)(6246003)(4326008)(186003)(26005)(66574012)(86362001)(476003)(486006)(6506007)(102836004)(11346002)(71190400001)(71200400001)(446003)(73956011)(7736002)(66556008)(66946007)(99286004)(14444005)(66476007)(91956017)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6174;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jNQMTL8qkg7BW4q2dtPlIs9gQAP/GpS4biCNFKqnV7aEiK4sGUplgzVp5fe1/w507zWs+UJKceKRWqFYFUT+RkpHEhQZAFrEZAEtirE/RISHezsixRwvBVg3e0yq6k17Ca9RxUuujF+mjyfIU1dtyG5BFjCX9f+hE2W0KSK6rW2iVHtFuQA7zGOOAKLPWQzFR3/CzKKT+cD7/5uvMdaMyziw61k19Hur5qNYUKcBWWZ71ve+3ls286e1Ctw615LT73S+shtpRENAWb+CDwzbWgtOw1gTTmH2C2VhcE3KQulwPPog8Uvva6bdAVV2WQnOL9jAM+SIigJ69gDztBr9BjkbwRv2w9eCz/75QBOdVq6N9NYoiyjx5fQQ9vzDzuguMlDPcQ5un2OK22sQAGHvjG99qDz8FBYB7BjyWTCu2lU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABBA9B21F9EDE9459BEB232073C494FE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82ecdc6-1c8e-4c99-b26a-08d6c8bffe20
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:20:24.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTI0IGF0IDE0OjEwICswMDAwLCBLb2VuaWcsIENocmlzdGlhbiB3cm90
ZToNCj4gQW0gMjQuMDQuMTkgdW0gMTQ6MDAgc2NocmllYiBUaG9tYXMgSGVsbHN0cm9tOg0KPiA+
IEFkZCBhIHBvaW50ZXIgdG8gdGhlIHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCBpbiB0aGUg
Ym9fZGV2aWNlLA0KPiA+IGFuZA0KPiA+IGFzc2lnbiB0aGF0IHBvaW50ZXIgdG8gdGhlIGRlZmF1
bHQgdmFsdWUgY3VycmVudGx5IHVzZWQuDQo+ID4gDQo+ID4gVGhlIGRyaXZlciBjYW4gdGhlbiBv
cHRpb25hbGx5IG1vZGlmeSB0aGF0IHBvaW50ZXIgYW5kIHRoZSBuZXcNCj4gPiB2YWx1ZQ0KPiA+
IGNhbiBiZSB1c2VkIGZvciBlYWNoIG5ldyB2bWEgY3JlYXRlZC4NCj4gPiANCj4gPiBDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJvbUB2bXdhcmUuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
DQo+IA0KPiBHb2luZyB0byBwaWNrIHRob3NlIHR3byBUVE0gcGF0Y2hlcyB1cCBmb3IgYW1kLXN0
YWdpbmctZHJtLW5leHQuDQoNCldpbGwgeW91IGJlIHJlbHlpbmcgb24gZWl0aGVyIHBhdGNoIGZv
ciByZWxhdGVkIHdvcms/IE90aGVyd2lzZSBpdA0Kd291bGQgYmUgc2ltcGxlciBmb3IgdXMgdG8g
dXNlIHZtd2dmeC1uZXh0IGZvciB0aGUgd2hvbGUgc2VyaWVzLA0KdGFyZ2V0aW5nIDUuMy4NCg0K
VGhvbWFzDQoNCj4gDQo+IENocmlzdGlhbi4NCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9iby5jICAgIHwgMSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9ib192bS5jIHwgNiArKystLS0NCj4gPiAgIGluY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVy
LmggfCA2ICsrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9iby5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQo+ID4gaW5kZXgg
M2Y1NjY0N2NkYjM1Li4xYzg1YmVjMDA0NzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMN
Cj4gPiBAQCAtMTY1Niw2ICsxNjU2LDcgQEAgaW50IHR0bV9ib19kZXZpY2VfaW5pdChzdHJ1Y3Qg
dHRtX2JvX2RldmljZQ0KPiA+ICpiZGV2LA0KPiA+ICAgCW11dGV4X2xvY2soJnR0bV9nbG9iYWxf
bXV0ZXgpOw0KPiA+ICAgCWxpc3RfYWRkX3RhaWwoJmJkZXYtPmRldmljZV9saXN0LCAmZ2xvYi0+
ZGV2aWNlX2xpc3QpOw0KPiA+ICAgCW11dGV4X3VubG9jaygmdHRtX2dsb2JhbF9tdXRleCk7DQo+
ID4gKwliZGV2LT52bV9vcHMgPSAmdHRtX2JvX3ZtX29wczsNCj4gPiAgIA0KPiA+ICAgCXJldHVy
biAwOw0KPiA+ICAgb3V0X25vX3N5czoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm9fdm0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYw0K
PiA+IGluZGV4IGU4NmEyOWExZTUxZi4uYmZiMjViODFmZWQ3IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9ib192bS5jDQo+ID4gQEAgLTM5NSw3ICszOTUsNyBAQCBzdGF0aWMgaW50IHR0bV9i
b192bV9hY2Nlc3Moc3RydWN0DQo+ID4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9u
ZyBhZGRyLA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4gICANCj4gPiAtc3RhdGlj
IGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3BzID0gew0KPiA+
ICtjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29wcyA9IHsNCj4g
PiAgIAkuZmF1bHQgPSB0dG1fYm9fdm1fZmF1bHQsDQo+ID4gICAJLm9wZW4gPSB0dG1fYm9fdm1f
b3BlbiwNCj4gPiAgIAkuY2xvc2UgPSB0dG1fYm9fdm1fY2xvc2UsDQo+ID4gQEAgLTQ0NSw3ICs0
NDUsNyBAQCBpbnQgdHRtX2JvX21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdA0KPiA+IHZt
X2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gICAJaWYgKHVubGlrZWx5KHJldCAhPSAwKSkNCj4gPiAg
IAkJZ290byBvdXRfdW5yZWY7DQo+ID4gICANCj4gPiAtCXZtYS0+dm1fb3BzID0gJnR0bV9ib192
bV9vcHM7DQo+ID4gKwl2bWEtPnZtX29wcyA9IGJkZXYtPnZtX29wczsNCj4gPiAgIA0KPiA+ICAg
CS8qDQo+ID4gICAJICogTm90ZTogV2UncmUgdHJhbnNmZXJyaW5nIHRoZSBibyByZWZlcmVuY2Ug
dG8NCj4gPiBAQCAtNDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1fZmJkZXZfbW1hcChzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSwNCj4gPiBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+
ICAgDQo+ID4gICAJdHRtX2JvX2dldChibyk7DQo+ID4gICANCj4gPiAtCXZtYS0+dm1fb3BzID0g
JnR0bV9ib192bV9vcHM7DQo+ID4gKwl2bWEtPnZtX29wcyA9IGJvLT5iZGV2LT52bV9vcHM7DQo+
ID4gICAJdm1hLT52bV9wcml2YXRlX2RhdGEgPSBibzsNCj4gPiAgIAl2bWEtPnZtX2ZsYWdzIHw9
IFZNX01JWEVETUFQOw0KPiA+ICAgCXZtYS0+dm1fZmxhZ3MgfD0gVk1fSU8gfCBWTV9ET05URVhQ
QU5EOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oDQo+
ID4gYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oDQo+ID4gaW5kZXggY2JmMzE4MGNi
NjEyLi5jZmVhZmY1ZDk3MDYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9i
b19kcml2ZXIuaA0KPiA+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4g
PiBAQCAtNDQzLDYgKzQ0Myw5IEBAIGV4dGVybiBzdHJ1Y3QgdHRtX2JvX2dsb2JhbCB7DQo+ID4g
ICAgKiBAZHJpdmVyOiBQb2ludGVyIHRvIGEgc3RydWN0IHR0bV9ib19kcml2ZXIgc3RydWN0IHNl
dHVwIGJ5IHRoZQ0KPiA+IGRyaXZlci4NCj4gPiAgICAqIEBtYW46IEFuIGFycmF5IG9mIG1lbV90
eXBlX21hbmFnZXJzLg0KPiA+ICAgICogQHZtYV9tYW5hZ2VyOiBBZGRyZXNzIHNwYWNlIG1hbmFn
ZXINCj4gPiArICogQHZtX29wczogUG9pbnRlciB0byB0aGUgc3RydWN0IHZtX29wZXJhdGlvbnNf
c3RydWN0IHVzZWQgZm9yDQo+ID4gdGhpcw0KPiA+ICsgKiBkZXZpY2UncyBWTSBvcGVyYXRpb25z
LiBUaGUgZHJpdmVyIG1heSBvdmVycmlkZSB0aGlzIGJlZm9yZSB0aGUNCj4gPiBmaXJzdA0KPiA+
ICsgKiBtbWFwKCkgY2FsbC4NCj4gPiAgICAqIGxydV9sb2NrOiBTcGlubG9jayB0aGF0IHByb3Rl
Y3RzIHRoZSBidWZmZXIrZGV2aWNlIGxydSBsaXN0cw0KPiA+IGFuZA0KPiA+ICAgICogZGRlc3Ry
b3kgbGlzdHMuDQo+ID4gICAgKiBAZGV2X21hcHBpbmc6IEEgcG9pbnRlciB0byB0aGUgc3RydWN0
IGFkZHJlc3Nfc3BhY2UNCj4gPiByZXByZXNlbnRpbmcgdGhlDQo+ID4gQEAgLTQ2MSw2ICs0NjQs
NyBAQCBzdHJ1Y3QgdHRtX2JvX2RldmljZSB7DQo+ID4gICAJc3RydWN0IHR0bV9ib19nbG9iYWwg
Kmdsb2I7DQo+ID4gICAJc3RydWN0IHR0bV9ib19kcml2ZXIgKmRyaXZlcjsNCj4gPiAgIAlzdHJ1
Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgbWFuW1RUTV9OVU1fTUVNX1RZUEVTXTsNCj4gPiArCWNv
bnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCAqdm1fb3BzOw0KPiA+ICAgDQo+ID4gICAJ
LyoNCj4gPiAgIAkgKiBQcm90ZWN0ZWQgYnkgaW50ZXJuYWwgbG9ja3MuDQo+ID4gQEAgLTQ4OSw2
ICs0OTMsOCBAQCBzdHJ1Y3QgdHRtX2JvX2RldmljZSB7DQo+ID4gICAJYm9vbCBub19yZXRyeTsN
Cj4gPiAgIH07DQo+ID4gICANCj4gPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25z
X3N0cnVjdCB0dG1fYm9fdm1fb3BzOw0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogc3RydWN0
IHR0bV9scnVfYnVsa19tb3ZlX3Bvcw0KPiA+ICAgICoNCg==
