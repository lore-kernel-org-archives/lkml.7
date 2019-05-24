Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE87C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D5620673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KerU2GyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391370AbfEXL5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:57:13 -0400
Received: from mail-eopbgr820057.outbound.protection.outlook.com ([40.107.82.57]:43520
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391094AbfEXL5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsZiYFRfaMkkI5PFdVM/jscHJZBWevN+jPfXcBQoz8g=;
 b=KerU2GyIJ2JRZObG04XF2LLTbTIHXzsiDn+J+TLePlx6LuWv3uKxKaRYLdbDIA/ZIh+HwhvMnjzZ4B5xPRlwC9Zfm4WgWamwSZZ8nPV4gyGwWh1ardmqX6Fe8g1rGF679opzXxXtJEtKQZLzlDWZVhACH8rkIz/7KjUtJzmMziI=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6511.namprd05.prod.outlook.com (20.178.246.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.10; Fri, 24 May 2019 11:57:05 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::c19e:e8f8:b151:9ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::c19e:e8f8:b151:9ad%6]) with mapi id 15.20.1922.013; Fri, 24 May 2019
 11:57:05 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>, "cai@lca.pw" <cai@lca.pw>
CC:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: fix a warning due to missing dma_parms
Thread-Topic: [PATCH] drm/vmwgfx: fix a warning due to missing dma_parms
Thread-Index: AQHVEdmqliGQeseHrE6b20UPYA1BNqZ5zZ4AgABeSIA=
Date:   Fri, 24 May 2019 11:57:04 +0000
Message-ID: <c0290fd3af63cbbf677871370df29f6983ad1938.camel@vmware.com>
References: <20190524023719.1495-1-cai@lca.pw>   <20190524061936.GA2337@lst.de>
In-Reply-To: <20190524061936.GA2337@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97597714-3dfe-4b88-0cdf-08d6e03ef0b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6511;
x-ms-traffictypediagnostic: MN2PR05MB6511:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB6511B2E8DCD36C011E95FC6CA1020@MN2PR05MB6511.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(86362001)(110136005)(54906003)(14454004)(6246003)(2501003)(256004)(71200400001)(7736002)(5660300002)(71190400001)(26005)(36756003)(81156014)(11346002)(305945005)(8676002)(186003)(81166006)(6116002)(446003)(2616005)(3846002)(476003)(4326008)(99286004)(6506007)(102836004)(76176011)(66066001)(478600001)(25786009)(486006)(316002)(229853002)(6436002)(2906002)(118296001)(66446008)(66476007)(91956017)(66556008)(64756008)(66946007)(76116006)(73956011)(53936002)(6486002)(68736007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6511;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 607ijx43DXXootZkipUmM89tJC7PEuGLzz9Ks+NPiQ2Jt1S4d/72ElAH3niXJkYAu7bxsD2p8kAkblSaFoOBkCOHO9qch2ggFDR8alO6zZOgd6+PDPr70+CUvI6/On1ZlFhSJZK/qEIstU6ReOcz8ngpYU4o0apu2nmo4+VXPWZ83Mqt/PTUSpLwUyqpwNu2Wd1KLsclzS38Q7jh38v2S4ExwEdhTp/wfFT4Gy4kcZH2nfnoNaeh8XBmHriEaXw/zD+nwq3PPtLMpFLjZvzYzhTC0nwu75zZUbZPuATUai/UyDwLqmo06evrps4VQMm0GT91+XTwO3FNIaR/f2PgNE4dxFO8ofeM4IfFjKJDZfjfKGG+kADyEQNlkHpErM2hujHEsk/hFiWm3NEshY6BzDbqYgfVkKKS6Sjqn9n7pp8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51E448A0378E4478EE05BA1901A9243@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97597714-3dfe-4b88-0cdf-08d6e03ef0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 11:57:04.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thellstrom@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTI0IGF0IDA4OjE5ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMjMsIDIwMTkgYXQgMTA6Mzc6MTlQTSAtMDQwMCwgUWlhbiBDYWkg
d3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Ry
di5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiA+IGluZGV4
IGJmNmMzNTAwZDM2My4uNWM1NjdiODExNzRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfZHJ2LmMNCj4gPiBAQCAtNzQ3LDYgKzc0NywxMyBAQCBzdGF0aWMgaW50IHZtd19k
cml2ZXJfbG9hZChzdHJ1Y3QgZHJtX2RldmljZQ0KPiA+ICpkZXYsIHVuc2lnbmVkIGxvbmcgY2hp
cHNldCkNCj4gPiAgCWlmICh1bmxpa2VseShyZXQgIT0gMCkpDQo+ID4gIAkJZ290byBvdXRfZXJy
MDsNCj4gPiAgDQo+ID4gKwlkZXYtPmRldi0+ZG1hX3Bhcm1zID0gIGt6YWxsb2Moc2l6ZW9mKCpk
ZXYtPmRldi0+ZG1hX3Bhcm1zKSwNCj4gPiArCQkJCSAgICAgICBHRlBfS0VSTkVMKTsNCj4gPiAr
CWlmICghZGV2LT5kZXYtPmRtYV9wYXJtcykNCj4gPiArCQlnb3RvIG91dF9lcnIwOw0KPiANCj4g
V2hhdCBidXMgZG9lcyB0aGlzIGRldmljZSBjb21lIGZyb20/ICBJIHRob3VnaCB2bWdmeCB3YXMg
YQ0KPiAodmlydHVhbGl6ZWQpDQo+IFBDSSBkZXZpY2UsIGluIHdoaWNoIGNhc2UgdGhpcyBzaG91
bGQgYmUgcHJvdmlkZWQgYnkgdGhlIFBDSSBjb3JlLg0KPiBPciBhcmUgd2UgY2FsbGluZyBETUEg
bWFwcGluZyByb3V0aW5lcyBvbiBhcmJpdHJhcnkgb3RoZXIgc3RydWN0DQo+IGRldmljZSwNCj4g
aW4gd2hpY2ggY2FzZSB0aGF0IGlzIHRoZSByZWFsIGJ1ZyBhbmQgd2Ugc2hvdWxkIHN3aXRjaCB0
aGUgUENJDQo+IGRldmljZQ0KPiBpbnN0ZWFkLg0KDQpJdCdzIGEgUENJIGRldmljZS4gVGhlIHN0
cnVjdCBkZXZpY2UgKiB1c2VkIGluIGRtYV9tYXBfc2coKSBpcyB0aGUgc2FtZQ0KYXMgdGhlICZw
Y2lfZGV2LT5kZXYgaGFuZGVkIHRvIHRoZSBwcm9iZSgpIGNhbGxiYWNrLiBCdXQgYXQgcHJvYmUg
dGltZSwNCnRoZSBzdHJ1Y3QgZGV2aWNlOjpkbWFfcGFybXMgaXMgbm9uLU5VTEwsIGF0IGxlYXN0
IG9uIG15IHN5c3RlbSBzbw0KdGhlcmUgc2hvdWxkbid0IHJlYWxseSBiZSBhIG5lZWQgdG8ga3ph
bGxvYygpIGl0Lg0KDQo+IA0KPiA+ICsJZG1hX3NldF9tYXhfc2VnX3NpemUoZGV2LT5kZXYsICpk
ZXYtPmRldi0+ZG1hX21hc2spOw0KDQpUaGUgbWF4IGlzIFUzMl9NQVguDQoNCi9UaG9tYXMNCg0K
DQo+IA0KPiBUaGF0IGxvb2tzIG9kZC4gIElmIHlvdSB3YW50IHRvIHN1cHBvcnQgYW4gdW5saW1p
dGVkIHNlZ21lbnQgc2l6ZQ0KPiBqdXN0IHBhc3MgVUlOVF9NQVggaGVyZS4NCg==
