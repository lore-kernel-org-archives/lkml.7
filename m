Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EABC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6B208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 18:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VluxhAfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDMSkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:40:16 -0400
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:19392
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfDMSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 14:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGBMXmQ5YJuRTauW1Zx3nDOlugm25mBBQVmy7GBniPI=;
 b=VluxhAfFN8Cxn05xHN3xiPTwbA6W+AbEUqhk/1I02tChEfGlBW+B8IAfoqQVimE59pa/S+3OwHy9mIsqSlslMEy2/G8GbMd66hRAyH+JZxp6V+ZqiQlUR4IaLg+wEE+1WlFT7ubBSUNvuYGPGPpsP9ie68ZGUL+zAmHHwsXwPW0=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1211.namprd12.prod.outlook.com (10.168.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sat, 13 Apr 2019 18:39:59 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1792.018; Sat, 13 Apr
 2019 18:39:59 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Topic: [PATCH 4/9] drm/ttm: Allow the driver to provide the ttm struct
 vm_operations_struct
Thread-Index: AQHU8Ulplzzj2WPY8kOcR/oGGxtH2KY6bfoA
Date:   Sat, 13 Apr 2019 18:39:59 +0000
Message-ID: <f1ddc6a4-7992-2edd-2b2c-de3e8d573e4d@amd.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
 <20190412160338.64994-5-thellstrom@vmware.com>
In-Reply-To: <20190412160338.64994-5-thellstrom@vmware.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5PR0601CA0031.eurprd06.prod.outlook.com
 (2603:10a6:203:68::17) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4382a02-b5f4-4b15-e193-08d6c03f6e52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1211;
x-ms-traffictypediagnostic: DM5PR12MB1211:
x-microsoft-antispam-prvs: <DM5PR12MB12114AE97D80F95FC64FAA0883290@DM5PR12MB1211.namprd12.prod.outlook.com>
x-forefront-prvs: 00064751B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(229853002)(6436002)(446003)(105586002)(66574012)(25786009)(2501003)(2616005)(476003)(11346002)(6486002)(486006)(68736007)(5660300002)(102836004)(71200400001)(31686004)(71190400001)(65826007)(106356001)(72206003)(386003)(14454004)(46003)(478600001)(186003)(6116002)(6506007)(8676002)(6512007)(76176011)(64126003)(8936002)(81156014)(65956001)(65806001)(99286004)(305945005)(110136005)(52116002)(31696002)(7736002)(36756003)(256004)(14444005)(81166006)(2906002)(58126008)(97736004)(316002)(6246003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1211;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yq6uMpOL+WJPSbBpSipLPySnzzZ7NhTK27RtuMnxtIzsakCHin+7mySE6S/qCT5KpE0BEut+nYIT+50HaosK3VuzjWW+CJLhRWehj4BxwP1gfosEO/tdAVhkUPSJ5dQQMz9w9L9gGtGyuZg1njIzHBfsJPQVYLMKE3jb1AV1GYaMGTxl3CqtNAMKmzxhTQ1+CVi7iINPuxfSBC/FM+oO3oM/pw0nK4KTLgsVZzicTz7YL9IfRVfylTOhtpB9BUfFhUOMlCjLoalGlxENJNW2snIoVTC1NjosbI2vSUAQFoZ1JkPmVdmh6NPTK0Tt4mkg5SaFPRHYE/ODvVFxDaatiNPWmx144JlTXGMdRsYHjkOrQyFC1UAElfEvQnDeqi0jUvur3EvBd0Bzoksrt8B0hhqiqHZRtU/f7b1NesXympM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454FECB4DCDA624E87A6F67A312E706C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4382a02-b5f4-4b15-e193-08d6c03f6e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2019 18:39:59.5780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTIuMDQuMTkgdW0gMTg6MDQgc2NocmllYiBUaG9tYXMgSGVsbHN0cm9tOg0KPiBBZGQgYSBw
b2ludGVyIHRvIHRoZSBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgaW4gdGhlIGJvX2Rldmlj
ZSwgYW5kDQo+IGFzc2lnbiB0aGF0IHBvaW50ZXIgdG8gdGhlIGRlZmF1bHQgdmFsdWUgY3VycmVu
dGx5IHVzZWQuDQo+DQo+IFRoZSBkcml2ZXIgY2FuIHRoZW4gb3B0aW9uYWxseSBtb2RpZnkgdGhh
dCBwb2ludGVyIGFuZCB0aGUgbmV3IHZhbHVlDQo+IGNhbiBiZSB1c2VkIGZvciBlYWNoIG5ldyB2
bWEgY3JlYXRlZC4NCj4NCj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0cm9t
QHZtd2FyZS5jb20+DQoNClllcywgcGxlYXNlLiBUaGlzIHdheSB3ZSBjYW4gYWxzbyBmaW5hbGx5
IGNsZWFudXAgdGhlIFZNIG9wZXJhdGlvbnMgaGFjayANCndlIHVzZSBpbiByYWRlb24gYW5kIG1h
eWJlIHN0aWxsIGV2ZW4gYW1kZ3B1Lg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMgICAgfCAxICsNCj4gICBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5j
IHwgNiArKystLS0NCj4gICBpbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oIHwgNiArKysr
KysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiBpbmRleCAzZjU2NjQ3Y2RiMzUuLjFjODViZWMwMDQ3
MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQo+IEBAIC0xNjU2LDYgKzE2NTYsNyBAQCBpbnQg
dHRtX2JvX2RldmljZV9pbml0KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LA0KPiAgIAltdXRl
eF9sb2NrKCZ0dG1fZ2xvYmFsX211dGV4KTsNCj4gICAJbGlzdF9hZGRfdGFpbCgmYmRldi0+ZGV2
aWNlX2xpc3QsICZnbG9iLT5kZXZpY2VfbGlzdCk7DQo+ICAgCW11dGV4X3VubG9jaygmdHRtX2ds
b2JhbF9tdXRleCk7DQo+ICsJYmRldi0+dm1fb3BzID0gJnR0bV9ib192bV9vcHM7DQo+ICAgDQo+
ICAgCXJldHVybiAwOw0KPiAgIG91dF9ub19zeXM6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9ib192bS5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYw0K
PiBpbmRleCBlODZhMjlhMWU1MWYuLmJmYjI1YjgxZmVkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9ib192bS5jDQo+IEBAIC0zOTUsNyArMzk1LDcgQEAgc3RhdGljIGludCB0dG1fYm9fdm1fYWNj
ZXNzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+ICAg
CXJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVy
YXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3BzID0gew0KPiArY29uc3Qgc3RydWN0IHZtX29wZXJh
dGlvbnNfc3RydWN0IHR0bV9ib192bV9vcHMgPSB7DQo+ICAgCS5mYXVsdCA9IHR0bV9ib192bV9m
YXVsdCwNCj4gICAJLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwNCj4gICAJLmNsb3NlID0gdHRtX2Jv
X3ZtX2Nsb3NlLA0KPiBAQCAtNDQ1LDcgKzQ0NSw3IEBAIGludCB0dG1fYm9fbW1hcChzdHJ1Y3Qg
ZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ICAgCWlmICh1bmxpa2Vs
eShyZXQgIT0gMCkpDQo+ICAgCQlnb3RvIG91dF91bnJlZjsNCj4gICANCj4gLQl2bWEtPnZtX29w
cyA9ICZ0dG1fYm9fdm1fb3BzOw0KPiArCXZtYS0+dm1fb3BzID0gYmRldi0+dm1fb3BzOw0KPiAg
IA0KPiAgIAkvKg0KPiAgIAkgKiBOb3RlOiBXZSdyZSB0cmFuc2ZlcnJpbmcgdGhlIGJvIHJlZmVy
ZW5jZSB0bw0KPiBAQCAtNDc3LDcgKzQ3Nyw3IEBAIGludCB0dG1fZmJkZXZfbW1hcChzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykNCj4gICAN
Cj4gICAJdHRtX2JvX2dldChibyk7DQo+ICAgDQo+IC0Jdm1hLT52bV9vcHMgPSAmdHRtX2JvX3Zt
X29wczsNCj4gKwl2bWEtPnZtX29wcyA9IGJvLT5iZGV2LT52bV9vcHM7DQo+ICAgCXZtYS0+dm1f
cHJpdmF0ZV9kYXRhID0gYm87DQo+ICAgCXZtYS0+dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7DQo+
ICAgCXZtYS0+dm1fZmxhZ3MgfD0gVk1fSU8gfCBWTV9ET05URVhQQU5EOw0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaCBiL2luY2x1ZGUvZHJtL3R0bS90dG1f
Ym9fZHJpdmVyLmgNCj4gaW5kZXggY2JmMzE4MGNiNjEyLi5jZmVhZmY1ZDk3MDYgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgNCj4gKysrIGIvaW5jbHVkZS9k
cm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KPiBAQCAtNDQzLDYgKzQ0Myw5IEBAIGV4dGVybiBzdHJ1
Y3QgdHRtX2JvX2dsb2JhbCB7DQo+ICAgICogQGRyaXZlcjogUG9pbnRlciB0byBhIHN0cnVjdCB0
dG1fYm9fZHJpdmVyIHN0cnVjdCBzZXR1cCBieSB0aGUgZHJpdmVyLg0KPiAgICAqIEBtYW46IEFu
IGFycmF5IG9mIG1lbV90eXBlX21hbmFnZXJzLg0KPiAgICAqIEB2bWFfbWFuYWdlcjogQWRkcmVz
cyBzcGFjZSBtYW5hZ2VyDQo+ICsgKiBAdm1fb3BzOiBQb2ludGVyIHRvIHRoZSBzdHJ1Y3Qgdm1f
b3BlcmF0aW9uc19zdHJ1Y3QgdXNlZCBmb3IgdGhpcw0KPiArICogZGV2aWNlJ3MgVk0gb3BlcmF0
aW9ucy4gVGhlIGRyaXZlciBtYXkgb3ZlcnJpZGUgdGhpcyBiZWZvcmUgdGhlIGZpcnN0DQo+ICsg
KiBtbWFwKCkgY2FsbC4NCj4gICAgKiBscnVfbG9jazogU3BpbmxvY2sgdGhhdCBwcm90ZWN0cyB0
aGUgYnVmZmVyK2RldmljZSBscnUgbGlzdHMgYW5kDQo+ICAgICogZGRlc3Ryb3kgbGlzdHMuDQo+
ICAgICogQGRldl9tYXBwaW5nOiBBIHBvaW50ZXIgdG8gdGhlIHN0cnVjdCBhZGRyZXNzX3NwYWNl
IHJlcHJlc2VudGluZyB0aGUNCj4gQEAgLTQ2MSw2ICs0NjQsNyBAQCBzdHJ1Y3QgdHRtX2JvX2Rl
dmljZSB7DQo+ICAgCXN0cnVjdCB0dG1fYm9fZ2xvYmFsICpnbG9iOw0KPiAgIAlzdHJ1Y3QgdHRt
X2JvX2RyaXZlciAqZHJpdmVyOw0KPiAgIAlzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXIgbWFu
W1RUTV9OVU1fTUVNX1RZUEVTXTsNCj4gKwljb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1
Y3QgKnZtX29wczsNCj4gICANCj4gICAJLyoNCj4gICAJICogUHJvdGVjdGVkIGJ5IGludGVybmFs
IGxvY2tzLg0KPiBAQCAtNDg5LDYgKzQ5Myw4IEBAIHN0cnVjdCB0dG1fYm9fZGV2aWNlIHsNCj4g
ICAJYm9vbCBub19yZXRyeTsNCj4gICB9Ow0KPiAgIA0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCB2
bV9vcGVyYXRpb25zX3N0cnVjdCB0dG1fYm9fdm1fb3BzOw0KPiArDQo+ICAgLyoqDQo+ICAgICog
c3RydWN0IHR0bV9scnVfYnVsa19tb3ZlX3Bvcw0KPiAgICAqDQoNCg==
