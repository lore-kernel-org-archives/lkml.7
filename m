Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C15C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3B5205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xb6HkBWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIBmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:42:04 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:15105
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfEIBmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZeLBwNjvGRH/C3I3l+tYMqUQ1q5JLVVxlvcrVrqyzI=;
 b=Xb6HkBWky18jbtE7rKO9LEEH2v/bv5i4c1b6RLNnYfXT2qa4BWZvUl3en/I9IIZ46/Q/b0p36lGy+TC6ZDAqBV5x1TQCjISbODc/T09tgdqa8fi/NUK46lhj9Qz/zlKoros/aptkWJkx75d418Ct1El7Da9woH1euAXWKYug2rI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Thu, 9 May 2019 01:42:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 01:42:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Enp8Rg1WsmI0EedzzVUaGgENqZRRjxggBD578A=
Date:   Thu, 9 May 2019 01:41:59 +0000
Message-ID: <DB3PR0402MB3916C6AD77304030A3CA5074F5330@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39164C6D8A02B53E1F224232F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164C6D8A02B53E1F224232F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeb056bd-2dcd-469c-cd85-08d6d41f8770
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39295BFB7BC5EF3B22E86582F5330@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(13464003)(5660300002)(316002)(52536014)(7696005)(99286004)(229853002)(478600001)(76176011)(68736007)(8936002)(102836004)(11346002)(53546011)(476003)(446003)(9686003)(81156014)(44832011)(55016002)(81166006)(33656002)(53936002)(73956011)(8676002)(2501003)(486006)(26005)(6436002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(110136005)(14454004)(86362001)(4326008)(66066001)(6246003)(25786009)(186003)(2201001)(6506007)(2906002)(7736002)(305945005)(256004)(71200400001)(15650500001)(71190400001)(3846002)(6116002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kPPQLQkjO5DCy3MKIS1rbnAtqCdNpXO586sKTfYsRHlokppW35a8GKmnb2puWayYnstHQUv1kOdHJsP+bFzZ17A3FQgXlOenp520QxoedeGzff0cmXD0HbXR5u88FoJW6ZME3Tn2hMdR3+4X9VY7pe2ElQJi5/F3SoZ49Ks9NOUpVjD9160RsVqjz/epJFScmNfToYL9op5StzvTmqXkGNx4dAan/zBGmotbHj6ODhWjNJuEtzSlxtP9NKv+asPQy/6a+jlXk8f47xMveGaaiPBC2DC5r7NSb+mKpOQtohd7nYCweWXYPNAdh9o2VabYPh+Rp++6B6k9iCooiddCqkfnfrR8en8pn1tVbW1XYIprXS9IS46p3pI8j4LcYk0KsiBgzSyemlN5L1Cfs8ww3j9cNWcQytfkuS5f0ojKKF8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb056bd-2dcd-469c-cd85-08d6d41f8770
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 01:41:59.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1
YW5nDQo+IFNlbnQ6IFN1bmRheSwgQXByaWwgMjgsIDIwMTkgMjoyNyBQTQ0KPiBUbzogamFzc2lz
aW5naGJyYXJAZ21haWwuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIXSBtYWlsYm94OiBpbXg6IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2UoKQ0KPiB0byBzaW1wbGlmeSBjb2RlDQo+IA0KPiBQaW5nLi4uDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW5zb24gSHVhbmcNCj4gPiBTZW50
OiBNb25kYXksIEFwcmlsIDEsIDIwMTkgMToxNSBQTQ0KPiA+IFRvOiBqYXNzaXNpbmdoYnJhckBn
bWFpbC5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gU3ViamVj
dDogW1BBVENIXSBtYWlsYm94OiBpbXg6IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UoKSB0bw0KPiA+IHNpbXBsaWZ5IGNvZGUNCj4gPg0KPiA+IFVzZSB0aGUgbmV3IGhlbHBlciBk
ZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSB3aGljaCB3cmFwcyB0aGUNCj4gPiBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UoKSBhbmQgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgdG9nZXRoZXIs
IHRvDQo+ID4gc2ltcGxpZnkgdGhlIGNvZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNv
biBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWls
Ym94L2lteC1tYWlsYm94LmMgfCA0ICstLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jDQo+ID4gYi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyBp
bmRleCA4NWZjNWI1Li4yNWJlOGJiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9p
bXgtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4g
PiBAQCAtMjY0LDcgKzI2NCw2IEBAIHN0YXRpYyBpbnQgaW14X211X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0K
PiA+IC0Jc3RydWN0IHJlc291cmNlICppb21lbTsNCj4gPiAgCXN0cnVjdCBpbXhfbXVfcHJpdiAq
cHJpdjsNCj4gPiAgCXVuc2lnbmVkIGludCBpOw0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMjc1
LDggKzI3NCw3IEBAIHN0YXRpYyBpbnQgaW14X211X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gPiAqcGRldikNCj4gPg0KPiA+ICAJcHJpdi0+ZGV2ID0gZGV2Ow0KPiA+DQo+ID4gLQlp
b21lbSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+
ID4gLQlwcml2LT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIGlvbWVt
KTsNCj4gPiArCXByaXYtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRl
diwgMCk7DQo+ID4gIAlpZiAoSVNfRVJSKHByaXYtPmJhc2UpKQ0KPiA+ICAJCXJldHVybiBQVFJf
RVJSKHByaXYtPmJhc2UpOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjcuNA0KDQo=
