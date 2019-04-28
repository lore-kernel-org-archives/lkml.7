Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD66C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0711320881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FzqNaq1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfD1G2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:28:25 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:43214
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfD1G2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfiyVtjfIW2gJk7cswGVPgsY0qVl9cvmx9dmZ0BGK3I=;
 b=FzqNaq1gQO8A6YpYtFZL2M8uzMVcMs1TCgtDCx3raheeKbcy8SeQHOeGVH5OSa524QX9LAzmxP+IsOLQTGgVu01HB1FaagpekeeKzbBOfN/sT6UYmt9HMyOSB4/WqwfwTtZdTrHegd4yaL2VeM1bQNCXYne1g6T0Z++VBwZxnoo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 06:28:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 06:28:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] irqchip/imx-irqsteer: use
 devm_platform_ioremap_resource() to simplify code
Thread-Topic: [PATCH] irqchip/imx-irqsteer: use
 devm_platform_ioremap_resource() to simplify code
Thread-Index: AQHU6FMxMyoSmAudakaHd9hk5kAdZqYm7Z+AgCpY2EA=
Date:   Sun, 28 Apr 2019 06:28:20 +0000
Message-ID: <DB3PR0402MB39165CB08BB94150215DE197F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554099427-5240-1-git-send-email-Anson.Huang@nxp.com>
 <e7f06738-6732-dc08-670d-ab78c985231f@codeaurora.org>
In-Reply-To: <e7f06738-6732-dc08-670d-ab78c985231f@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22a5dd5-2a5d-41f1-73ca-08d6cba2b583
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB38987F29840703E0BA49E21CF5380@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(13464003)(199004)(71190400001)(102836004)(7416002)(6246003)(256004)(110136005)(2201001)(97736004)(2906002)(64756008)(66476007)(66556008)(476003)(5660300002)(71200400001)(478600001)(11346002)(86362001)(446003)(73956011)(76116006)(66066001)(66446008)(66946007)(186003)(7696005)(6436002)(26005)(76176011)(33656002)(55016002)(486006)(7736002)(14454004)(52536014)(8936002)(68736007)(74316002)(99286004)(305945005)(44832011)(6116002)(81156014)(229853002)(3846002)(8676002)(53546011)(53936002)(4326008)(81166006)(2501003)(9686003)(316002)(25786009)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tgc+SoAgaoIWGsCE47Xso9JnUp63uODd2543SXLbRDks5uRUmEJEQsZUyC+SwhKWv5wavTq58NpnpcRbZ1A1fpfIVMtXCN3614qk31IZGE7n1oRWxxG2sCHOtPAhdnwM0UvNUydWTQH8FIunFKlCpqE+ifF3Q4lUa8DoL3EqcjxikVjfnghUpFLPXsim350kFmii7zdFt1I0ZlyABPFUINeAPfZTq9Bo4yUqwHTKg3FBiR+PChPtVdXPXwpqewJERmR7NdBxzzNj46COk8DxX+/mWjOXB888vd/kpUQPyD+h2+P7urMGgxs/KcNg6pbf2Nvb2ZL4nansm7k0VI7bY/i7Pop0wjhWIJdi7BFG8F3xf7JtEr5OG7zlmFBmg9ELvoK/UE5LcQjSynthY1o1ZDpmCHqaMSQxAPVRKy/sc8w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22a5dd5-2a5d-41f1-73ca-08d6cba2b583
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 06:28:20.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE11a2VzaCBP
amhhIFttYWlsdG86bW9qaGFAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MSwgMjAxOSAzOjQ3IFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IHRnbHhAbGludXRyb25peC5kZTsNCj4gamFzb25AbGFrZWRhZW1vbi5uZXQ7IG1hcmMuenluZ2ll
ckBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBpcnFjaGlwL2lteC1pcnFzdGVlcjogdXNlDQo+IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZSgpIHRvIHNpbXBsaWZ5IGNvZGUNCj4gDQo+IA0KPiBPbiA0LzEvMjAxOSAxMTo1
MSBBTSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gVXNlIHRoZSBuZXcgaGVscGVyIGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIHdoaWNoIHdyYXBzIHRoZQ0KPiA+IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZSgpIGFuZCBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSB0b2dldGhlciwgdG8NCj4g
PiBzaW1wbGlmeSB0aGUgY29kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogTXVrZXNoIE9qaGEgPG1vamhh
QGNvZGVhdXJvcmEub3JnPg0KPiANCj4gQ2hlZXJzLA0KPiAtTXVrZXNoDQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jIHwgNCArLS0tDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYw0KPiA+IGIvZHJpdmVy
cy9pcnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYw0KPiA+IGluZGV4IDg4ZGYzZDAwLi4yOTA1MzFl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWlycXN0ZWVyLmMNCj4g
PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jDQo+ID4gQEAgLTE0NCw3
ICsxNDQsNiBAQCBzdGF0aWMgaW50IGlteF9pcnFzdGVlcl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAg
PSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gPiAgIAlzdHJ1Y3QgaXJxc3RlZXJfZGF0YSAqZGF0YTsN
Cj4gPiAtCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICAgCXUzMiBpcnFzX251bTsNCj4gPiAg
IAlpbnQgaSwgcmV0Ow0KPiA+DQo+ID4gQEAgLTE1Miw4ICsxNTEsNyBAQCBzdGF0aWMgaW50IGlt
eF9pcnFzdGVlcl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAg
CWlmICghZGF0YSkNCj4gPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4NCj4gPiAtCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gLQlkYXRh
LT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ID4gKwlk
YXRhLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+
ICAgCWlmIChJU19FUlIoZGF0YS0+cmVncykpIHsNCj4gPiAgIAkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgcmVnXG4iKTsNCj4gPiAgIAkJcmV0dXJuIFBUUl9FUlIo
ZGF0YS0+cmVncyk7DQo=
