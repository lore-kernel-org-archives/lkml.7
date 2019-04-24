Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54089C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FBB21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hRHQZ0uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfDXOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:10:24 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:58550
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfDXOKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uHqWlyYC21IOkFXGaSfz3ThDpyz4wC9uTSn/zV7NFU=;
 b=hRHQZ0uZsQCx2SLguukX4oK06UupSbM64mUJnaB5d2g+Br/WFpyw/7UdZkqsWZYIS6F6PjQBQL85WLVl4NBR6k7dBDX3+r5yWNPmo48n3J9fkY4oHDbyU6dsllW808o2ZR6Vmsldc/vKvM62V4LUnO4LSMIKajqdYC3b/kHOcYs=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1291.namprd12.prod.outlook.com (10.168.237.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:10:21 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1813.017; Wed, 24 Apr
 2019 14:10:20 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Topic: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Index: AQHU+pVTTgMRqibX4kGI183G5JrS/6ZLWbQA
Date:   Wed, 24 Apr 2019 14:10:20 +0000
Message-ID: <d1c9c6c9-2cb0-d75f-03fa-805907991ed1@amd.com>
References: <20190424115918.3380-1-thellstrom@vmware.com>
 <20190424115918.3380-5-thellstrom@vmware.com>
In-Reply-To: <20190424115918.3380-5-thellstrom@vmware.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5PR0701CA0020.eurprd07.prod.outlook.com
 (2603:10a6:203:51::30) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5122d291-306d-478e-35b9-08d6c8be95df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1291;
x-ms-traffictypediagnostic: DM5PR12MB1291:
x-microsoft-antispam-prvs: <DM5PR12MB12915EDAF6F54AF605AEA340833C0@DM5PR12MB1291.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(6436002)(6246003)(478600001)(81166006)(8676002)(81156014)(31686004)(68736007)(71190400001)(25786009)(71200400001)(6116002)(4326008)(72206003)(65956001)(65806001)(8936002)(14454004)(305945005)(97736004)(7736002)(65826007)(2616005)(54906003)(58126008)(110136005)(446003)(5660300002)(99286004)(46003)(316002)(486006)(476003)(256004)(11346002)(14444005)(64126003)(6512007)(53936002)(2501003)(102836004)(76176011)(6506007)(36756003)(31696002)(2906002)(66476007)(66556008)(66946007)(229853002)(386003)(66446008)(6486002)(86362001)(52116002)(186003)(73956011)(66574012)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1291;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WXJ7K092YbPhAxl3ZYjvpqr+viic31HyVHM5Cjlay99lD66Kw2F2tKKoLRJQFdHhxqFiAVqB5l44MLH/0VPFR96A3S/esbNuImbkIQ4jGF+f38Caa+oBNsza6RCdE7BuXbImxLHZGlV8vmR3E3apJtOl1DxmxG/Lc2Ge6O5q6jv3pwIDQGd893secrZlIjb1KX9JyyfsvHikJiX39ABxfWGRu3Lgu4CZUZoVTAqVhhX+vda/9bX1bT7XmtOiSbzyFIuyEaDZQ5nVyb+j2jqIK5bLvxSx5BzLZNV3pH/NoFN9BL2166Q82onGt3/8cmzy7mCqpPkmLmY14uuH+FBUVyUIM3KIUJGFYafzbgUihECRGdGmRBoWg92KJfh+L0KqFUnsv4RFKnJyrPyH9nwL0aDsLuVsgLfL9siURGI2CtE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DECD60A4A41A1D4F8E4BBB4CB1D25CA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5122d291-306d-478e-35b9-08d6c8be95df
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:10:20.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDQuMTkgdW0gMTQ6MDAgc2NocmllYiBUaG9tYXMgSGVsbHN0cm9tOg0KPiBBZGQgYSBw
b2ludGVyIHRvIHRoZSBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgaW4gdGhlIGJvX2Rldmlj
ZSwgYW5kDQo+IGFzc2lnbiB0aGF0IHBvaW50ZXIgdG8gdGhlIGRlZmF1bHQgdmFsdWUgY3VycmVu
dGx5IHVzZWQuDQo+DQo+IFRoZSBkcml2ZXIgY2FuIHRoZW4gb3B0aW9uYWxseSBtb2RpZnkgdGhh
dCBwb2ludGVyIGFuZCB0aGUgbmV3IHZhbHVlDQo+IGNhbiBiZSB1c2VkIGZvciBlYWNoIG5ldyB2
bWEgY3JlYXRlZC4NCj4NCj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0
cm9tQHZtd2FyZS5jb20+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQoNCkdvaW5nIHRvIHBpY2sgdGhvc2UgdHdvIFRUTSBwYXRjaGVz
IHVwIGZvciBhbWQtc3RhZ2luZy1kcm0tbmV4dC4NCg0KQ2hyaXN0aWFuLg0KDQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgICAgfCAxICsNCj4gICBkcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9ib192bS5jIHwgNiArKystLS0NCj4gICBpbmNsdWRlL2RybS90dG0vdHRtX2Jv
X2RyaXZlci5oIHwgNiArKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiBpbmRleCAzZjU2NjQ3
Y2RiMzUuLjFjODViZWMwMDQ3MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQo+IEBAIC0xNjU2
LDYgKzE2NTYsNyBAQCBpbnQgdHRtX2JvX2RldmljZV9pbml0KHN0cnVjdCB0dG1fYm9fZGV2aWNl
ICpiZGV2LA0KPiAgIAltdXRleF9sb2NrKCZ0dG1fZ2xvYmFsX211dGV4KTsNCj4gICAJbGlzdF9h
ZGRfdGFpbCgmYmRldi0+ZGV2aWNlX2xpc3QsICZnbG9iLT5kZXZpY2VfbGlzdCk7DQo+ICAgCW11
dGV4X3VubG9jaygmdHRtX2dsb2JhbF9tdXRleCk7DQo+ICsJYmRldi0+dm1fb3BzID0gJnR0bV9i
b192bV9vcHM7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiAgIG91dF9ub19zeXM6DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fYm9fdm0uYw0KPiBpbmRleCBlODZhMjlhMWU1MWYuLmJmYjI1YjgxZmVkNyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jDQo+IEBAIC0zOTUsNyArMzk1LDcgQEAgc3RhdGlj
IGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25l
ZCBsb25nIGFkZHIsDQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGNv
bnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3BzID0gew0KPiArY29u
c3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHMgPSB7DQo+ICAgCS5m
YXVsdCA9IHR0bV9ib192bV9mYXVsdCwNCj4gICAJLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwNCj4g
ICAJLmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLA0KPiBAQCAtNDQ1LDcgKzQ0NSw3IEBAIGludCB0
dG1fYm9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
DQo+ICAgCWlmICh1bmxpa2VseShyZXQgIT0gMCkpDQo+ICAgCQlnb3RvIG91dF91bnJlZjsNCj4g
ICANCj4gLQl2bWEtPnZtX29wcyA9ICZ0dG1fYm9fdm1fb3BzOw0KPiArCXZtYS0+dm1fb3BzID0g
YmRldi0+dm1fb3BzOw0KPiAgIA0KPiAgIAkvKg0KPiAgIAkgKiBOb3RlOiBXZSdyZSB0cmFuc2Zl
cnJpbmcgdGhlIGJvIHJlZmVyZW5jZSB0bw0KPiBAQCAtNDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1f
ZmJkZXZfbW1hcChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3RydWN0IHR0bV9idWZmZXJf
b2JqZWN0ICpibykNCj4gICANCj4gICAJdHRtX2JvX2dldChibyk7DQo+ICAgDQo+IC0Jdm1hLT52
bV9vcHMgPSAmdHRtX2JvX3ZtX29wczsNCj4gKwl2bWEtPnZtX29wcyA9IGJvLT5iZGV2LT52bV9v
cHM7DQo+ICAgCXZtYS0+dm1fcHJpdmF0ZV9kYXRhID0gYm87DQo+ICAgCXZtYS0+dm1fZmxhZ3Mg
fD0gVk1fTUlYRURNQVA7DQo+ICAgCXZtYS0+dm1fZmxhZ3MgfD0gVk1fSU8gfCBWTV9ET05URVhQ
QU5EOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaCBiL2lu
Y2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4gaW5kZXggY2JmMzE4MGNiNjEyLi5jZmVh
ZmY1ZDk3MDYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgN
Cj4gKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KPiBAQCAtNDQzLDYgKzQ0
Myw5IEBAIGV4dGVybiBzdHJ1Y3QgdHRtX2JvX2dsb2JhbCB7DQo+ICAgICogQGRyaXZlcjogUG9p
bnRlciB0byBhIHN0cnVjdCB0dG1fYm9fZHJpdmVyIHN0cnVjdCBzZXR1cCBieSB0aGUgZHJpdmVy
Lg0KPiAgICAqIEBtYW46IEFuIGFycmF5IG9mIG1lbV90eXBlX21hbmFnZXJzLg0KPiAgICAqIEB2
bWFfbWFuYWdlcjogQWRkcmVzcyBzcGFjZSBtYW5hZ2VyDQo+ICsgKiBAdm1fb3BzOiBQb2ludGVy
IHRvIHRoZSBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgdXNlZCBmb3IgdGhpcw0KPiArICog
ZGV2aWNlJ3MgVk0gb3BlcmF0aW9ucy4gVGhlIGRyaXZlciBtYXkgb3ZlcnJpZGUgdGhpcyBiZWZv
cmUgdGhlIGZpcnN0DQo+ICsgKiBtbWFwKCkgY2FsbC4NCj4gICAgKiBscnVfbG9jazogU3Bpbmxv
Y2sgdGhhdCBwcm90ZWN0cyB0aGUgYnVmZmVyK2RldmljZSBscnUgbGlzdHMgYW5kDQo+ICAgICog
ZGRlc3Ryb3kgbGlzdHMuDQo+ICAgICogQGRldl9tYXBwaW5nOiBBIHBvaW50ZXIgdG8gdGhlIHN0
cnVjdCBhZGRyZXNzX3NwYWNlIHJlcHJlc2VudGluZyB0aGUNCj4gQEAgLTQ2MSw2ICs0NjQsNyBA
QCBzdHJ1Y3QgdHRtX2JvX2RldmljZSB7DQo+ICAgCXN0cnVjdCB0dG1fYm9fZ2xvYmFsICpnbG9i
Ow0KPiAgIAlzdHJ1Y3QgdHRtX2JvX2RyaXZlciAqZHJpdmVyOw0KPiAgIAlzdHJ1Y3QgdHRtX21l
bV90eXBlX21hbmFnZXIgbWFuW1RUTV9OVU1fTUVNX1RZUEVTXTsNCj4gKwljb25zdCBzdHJ1Y3Qg
dm1fb3BlcmF0aW9uc19zdHJ1Y3QgKnZtX29wczsNCj4gICANCj4gICAJLyoNCj4gICAJICogUHJv
dGVjdGVkIGJ5IGludGVybmFsIGxvY2tzLg0KPiBAQCAtNDg5LDYgKzQ5Myw4IEBAIHN0cnVjdCB0
dG1fYm9fZGV2aWNlIHsNCj4gICAJYm9vbCBub19yZXRyeTsNCj4gICB9Ow0KPiAgIA0KPiArZXh0
ZXJuIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3BzOw0KPiAr
DQo+ICAgLyoqDQo+ICAgICogc3RydWN0IHR0bV9scnVfYnVsa19tb3ZlX3Bvcw0KPiAgICAqDQoN
Cg==
