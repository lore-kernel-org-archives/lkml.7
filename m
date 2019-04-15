Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B7FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75911206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vt7wwIPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfDOGZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:25:49 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:45062
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfDOGZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsKfwvPsKfGvRfoeHounTts2DPM07zgWkP+fBBADs50=;
 b=vt7wwIPLajicitHqHoxn/+5GNt6PiE63MjlDZSKjC5MknAaqzXglUheFUxbfp8E8MTLIMTukHk/gikQhy4G3ek/Dd3JRPH4YSxNc8aADZlJKYQOjS69ek14HPf5KYF5hh8w3tyahvhCKwc59aauVS/AdUe+Jtu9SPpLOcqjNmsk=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1276.namprd12.prod.outlook.com (10.168.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 06:25:44 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1792.018; Mon, 15 Apr
 2019 06:25:44 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Brian Yip <itsbriany@gmail.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/ttm: Reset num_zones on ttm_mem_global cleanup
Thread-Topic: [PATCH 1/3] drm/ttm: Reset num_zones on ttm_mem_global cleanup
Thread-Index: AQHU8xsVkppUOh5tgkmztN8e236zqqY8wdaA
Date:   Mon, 15 Apr 2019 06:25:44 +0000
Message-ID: <0de8d12a-06b8-c4f7-e22e-77a00905ae5f@amd.com>
References: <20190414233729.17956-1-itsbriany@gmail.com>
 <20190414233729.17956-2-itsbriany@gmail.com>
In-Reply-To: <20190414233729.17956-2-itsbriany@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P193CA0074.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::15) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5306c4c6-ef07-4380-11f9-08d6c16b3086
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1276;
x-ms-traffictypediagnostic: DM5PR12MB1276:
x-microsoft-antispam-prvs: <DM5PR12MB12769B4EDB90FC959493A9C3832B0@DM5PR12MB1276.namprd12.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(199004)(189003)(43544003)(46003)(81156014)(71190400001)(6486002)(31696002)(36756003)(99286004)(71200400001)(6436002)(86362001)(186003)(1411001)(97736004)(14454004)(316002)(54906003)(2616005)(476003)(58126008)(486006)(11346002)(446003)(229853002)(106356001)(6916009)(65806001)(65956001)(5660300002)(105586002)(8676002)(81166006)(31686004)(305945005)(7736002)(76176011)(8936002)(386003)(2906002)(4326008)(53936002)(102836004)(256004)(6506007)(25786009)(6246003)(68736007)(52116002)(64126003)(65826007)(478600001)(72206003)(6512007)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1276;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HtY0J9op9BlQm9lHxhLp4ik4sWmcY+aNN9OxEdMV2iO77VMYzplwsef69BycNGVmv3dx+OZCGyR9cxDV6oBBDcJjYwkGvMiTKtkhEigUqVC1vSBsnxdpocAZbYU6wprNBE8QlzzcZQL7b2EQSlDxHE34uhJ7m50UlcbUoxxUOxNtc2IZuPHqFVuXtUuotfIgL/bzckpHW9zrNX0KDmr7/9c9grf3Rq8bSYnNpqMCi3PFwtxROPE4/saNpPLPPi0OTH9Q/BbjsIGrSdaWBPXOFsNWGcg5t1vgU+O29Fwv/d61ZJuSsNDLCkl1r/BE+frBBswF3hchEbVUiA8PLIbi9tSBq2irOlb6/GDCbFII0w1dwIM11EiRaGT8+eZbiIsN3DtUy7tXhLpUsic1USTDCnOJmEizMTW8dS2s0e7v8MA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E37D89E3EF23C24DBB848DCCD5F9ECE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5306c4c6-ef07-4380-11f9-08d6c16b3086
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 06:25:44.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTUuMDQuMTkgdW0gMDE6Mzcgc2NocmllYiBCcmlhbiBZaXA6DQo+IG51bV96b25lcyBpbiB0
aGUgdHRtX21lbV9nbG9iYWwgc3RydWN0dXJlIHdhcyBuZXZlciByZXNldCBhZnRlciBjYWxsaW5n
DQo+IHR0bV9tZW1fZ2xvYmFsX3JlbGVhc2UoKS4gQ29uc2VxdWVudGx5LCB3aGVuIG11bHRpcGxl
IEdQVSBkcml2ZXJzDQo+IGFyZSBsb2FkZWQsIGFuZCB0aGUgZmlyc3Qgb25lIGZhaWxzIHRvIGxv
YWQgaXRzIGZpcm13YXJlLCB0aGUgc2Vjb25kDQo+IGRyaXZlciB3aWxsIGF0dGVtcHQgdG8gbG9h
ZCBpdHMgb3duIGZpcm13YXJlLiBJbml0aWFsaXppbmcgdGhlDQo+IHNlY29uZCBkcml2ZXIgaW52
b2tlcyB0dG1fbWVtX2dsb2JhbF9pbml0IHdoZXJlIHR0bV9tZW1fZ2xvYmFsLm51bV96b25lcw0K
PiBpcyBldmVudHVhbGx5IGluY3JlbWVudGVkIGJleW9uZCBUVE1fTUVNX01BWF9aT05FUy4NCj4g
dHRtX21lbV9nbG9iYWwubnVtX3pvbmVzIGlzIHRoZW4gdXNlZCB0byBkZXJlZmVyZW5jZSBhIHR0
bV9tZW1fem9uZSBiZXlvbmQNCj4gdGhlIGFtb3VudCBvZiB0dG1fbWVtX3pvbmVzIGFsbG9jYXRl
ZCwgcmVzdWx0aW5nIGluIGEgY3Jhc2guDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJyaWFuIFlpcCA8
aXRzYnJpYW55QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
bWVtb3J5LmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21lbW9yeS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fbWVtb3J5LmMNCj4gaW5kZXggNjk5ZmVkOWUwOGVlLi41NWNjYjk4
MDA4OTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21lbW9yeS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21lbW9yeS5jDQo+IEBAIC00NzgsNiArNDc4
LDkgQEAgdm9pZCB0dG1fbWVtX2dsb2JhbF9yZWxlYXNlKHN0cnVjdCB0dG1fbWVtX2dsb2JhbCAq
Z2xvYikNCj4gICAJCQl9DQo+ICAgCWtvYmplY3RfZGVsKCZnbG9iLT5rb2JqKTsNCj4gICAJa29i
amVjdF9wdXQoJmdsb2ItPmtvYmopOw0KPiArDQo+ICsJaWYgKCFrcmVmX3JlYWQoJmdsb2ItPmtv
Ymoua3JlZikpDQo+ICsJCWdsb2ItPm51bV96b25lcyA9IDA7DQoNCk5BSy4gSXQncyBuaWNlIHRv
IHNlZSB0aGF0IHNvbWVib2R5IHRyaWVzIHRvIHRha2UgY2FyZSBvZiB0aGlzIHByb2JsZW0sIA0K
YnV0IHRoaXMgaXMgY2VydGFpbmx5IG5vdCB0aGUgcmlnaHQgZml4Lg0KDQpJbnN0ZWFkIG9mIGFs
bCBvZiB0aGlzIHRoZSBwcm9ibGVtIGlzIHNpbXBseSB0aGF0IHRoZSBnbG9iIHN0cnVjdHVyZSBp
cyANCm5vdCB6ZXJvIGluaXRpYWxpemVkIGluIHR0bV9tZW1fZ2xvYmFsX2luaXQoKSwgYSBzaW1w
bGUgbWVtc2V0IHNob3VsZCBkbyANCnRoZSB0cmljay4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4N
Cg0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCB0dG1fY2hlY2tfc3dhcHBpbmcoc3RydWN0
IHR0bV9tZW1fZ2xvYmFsICpnbG9iKQ0KDQo=
