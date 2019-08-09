Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB7C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A162085B
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BqUZMJKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407184AbfHIO4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:56:20 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com ([40.107.2.128]:29966
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407024AbfHIO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrZ+xpwJg5l20/cPEWB6goVOPR0ew8y4cvN0wWy9vJA+1OJ7Xcguq4zyJvsVoEZ1SOmTyrO0sbwzyc3Gzw1ZgRBggiatK/tdjgS+J1Nqw2pIpV0/uYMPSNzvGrsIFEioScEY2OAK+h27UxJw/Yfuf6obZMKGReOtJo7lRDKJPAt2q9REZ5lgMw99rqoGRhs6XTNhhf6Ku6byJdC0IXncirup1Ybv515idYK9LWAOZ2DQpWnBWxVu7yoiwqrbOg7G6yW+YieECFbDA0XDGIlZx/c9qDqzHnr67Q+a3irw4eeeF8IrfMPWVPo1aJNOccHWFiA3YL8XwV6NSW1ZNwtCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WogOHEMkg2jyyHRAvUwE8ayB+S20B+d7r3fcyL9tXog=;
 b=iWcq7Xc0khT+ns7RYjAYfmk205x1tIZN7XJs7o3h9RNEguplPAxZWWHAsCRU+NRvVnFHRIvOrdKrLSx7XXGxzUrD5M0HvKrfp72WdUoaWM67sswV85spc0uw/dnYQ/RN0e6QU3+I6TjkN2Qq4kFNLQCVXrRWgGJNbnjLnXo6sm3omUt/3sqKDN37Zx9Lz2fXCu24DbhABvZw52Ile5Ht/4DMviYF1yQp6CLffj1uY8v6o35bdPSMHvm4YMidlg7Nnmm8RfHFJkp141xfn5rmxrloNJLVRubfgGl9xibeADmhhIzD8aJvnbW8Zse//t/n+GPK9gp1eD7dWvbh2fTKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WogOHEMkg2jyyHRAvUwE8ayB+S20B+d7r3fcyL9tXog=;
 b=BqUZMJKInS7q1DvDaErTwSgMu6BAD0CqQPItdSKaJ7qCFgHh0GpXdnxJt+qddiN/XAm6yB7WvXt2Q/3ADbOtheQRV41G3jPyolr7pOo5RQBjeqgm6kKRw4SJfx6nSIupUVJFGcoEm6CjZtS9VgD8qTGcNFxkcRD9kK2YJdQWdtY=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4253.eurprd05.prod.outlook.com (52.133.12.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 14:56:14 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:56:14 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v3 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVTPnLOqa7gLhcA0CJ95ai1QRG/aby6zoA
Date:   Fri, 9 Aug 2019 14:56:14 +0000
Message-ID: <4875e91c34f7206d960ccdf7b499408b6f48364b.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-9-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-9-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 293c8ad4-c443-4930-5d3e-08d71cd9b9db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4253;
x-ms-traffictypediagnostic: VI1PR05MB4253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4253B8CF8DDDD09423667CA1FBD60@VI1PR05MB4253.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:308;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(199004)(189003)(66556008)(64756008)(305945005)(14444005)(25786009)(6506007)(46003)(476003)(91956017)(66946007)(2616005)(11346002)(446003)(86362001)(44832011)(76116006)(256004)(486006)(14454004)(66446008)(186003)(316002)(7736002)(102836004)(110136005)(7416002)(71200400001)(71190400001)(66476007)(54906003)(229853002)(6486002)(6512007)(36756003)(6436002)(53936002)(2906002)(6116002)(5660300002)(2201001)(478600001)(8676002)(99286004)(6246003)(2501003)(76176011)(8936002)(4326008)(81156014)(81166006)(118296001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4253;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H2w+vaSEszh4DxPkWSNVs/ual3VkrE1iSud9QA0W0eSmp3I9PaaR01M78qyqUAo6JVstwURnLvYo0JN9AZMnr99GDAar8n3Cot52Qm1ICiSJan3Hks60f2ZxBOJhFQWNKDt7SHiTIkx6oxblze4rXPzsIWl/MUZIpe/cOt5MyWx1Hdo3/DKWUhjrJVhl5Xh/NsMhenibTyQXzQtRTn4EE98mDkZbXLM6lwMbWzwBEYBLt0QlAhM1+WTa0BOUAWzw9ey8eNp2i/l96T0ltnXtR0fP6ZC8ZEq5a4PjzRBiFUoKsEloik1jY8xXLj34Q6WlIQPGaySovtB//HdQ/08PVt2j8uWoyxAkc4bk+MqPy6IFJKpyw8MbqY3MutBW+jHnWTkG+TbVbrycroKG9Ylo7wEpOwl6oWEDxLtObwESPqw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06F6FF2CD78DF146ADC461BDE4286D40@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c8ad4-c443-4930-5d3e-08d71cd9b9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:56:14.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYOen78V95xwkH2aES09tET8r5SD7t3DYOeOr71YEs+HbMkzycTQQf60rYeBP0Eu0yEa1s6IhI9nbGWkEHY8M1dSnQMMMwCQKdS24dU66oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gQWRkIHRvdWNoIGNvbnRyb2xsZXIgdGhhdCBpcyBjb25uZWN0ZWQgb3ZlciBhbiBJMkMg
YnVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNj
aGVua2VyQHRvcmFkZXguY29tPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAt
IEZpeCBjb21taXQgbWVzc2FnZQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBEZWxldGVkIHRv
dWNocmV2b2x1dGlvbiBkb3duc3RyZWFtIHN0dWZmDQo+IC0gVXNlIGdlbmVyaWMgbm9kZSBuYW1l
DQo+IC0gQmV0dGVyIGNvbW1lbnQNCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGli
cmktZXZhbC12My5kdHNpIHwgMjQNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+IGluZGV4IGQ0ZGJjNGZjMWFkZi4uNTc2ZGVjOWZm
ODFjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12
My5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0
c2kNCj4gQEAgLTE0NSw2ICsxNDUsMjEgQEANCj4gICZpMmM0IHsNCj4gIAlzdGF0dXMgPSAib2th
eSI7DQo+ICANCj4gKwkvKg0KPiArCSAqIFRvdWNoc2NyZWVuIGlzIHVzaW5nIFNPRElNTSAyOC8z
MCwgYWxzbyB1c2VkIGZvciBQV008Qj4sDQo+IFBXTTxDPiwNCj4gKwkgKiBha2EgcHdtMiwgcHdt
My4gc28gaWYgeW91IGVuYWJsZSB0b3VjaHNjcmVlbiwgZGlzYWJsZSB0aGUNCj4gcHdtcw0KPiAr
CSAqLw0KPiArCXRvdWNoc2NyZWVuQDRhIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJhdG1lbCxtYXh0
b3VjaCI7DQo+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJCXBpbmN0cmwtMCA9
IDwmcGluY3RybF9ncGlvdG91Y2g+Ow0KPiArCQlyZWcgPSA8MHg0YT47DQo+ICsJCWludGVycnVw
dC1wYXJlbnQgPSA8JmdwaW8xPjsNCj4gKwkJaW50ZXJydXB0cyA9IDw5IElSUV9UWVBFX0VER0Vf
RkFMTElORz47CQkvKg0KPiBTT0RJTU0gMjggKi8NCj4gKwkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW8x
IDEwIEdQSU9fQUNUSVZFX0hJR0g+OwkvKg0KPiBTT0RJTU0gMzAgKi8NCj4gKwkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKwl9Ow0KPiArDQo+ICAJLyogTTQxVDBNNiByZWFsIHRpbWUgY2xvY2sg
b24gY2FycmllciBib2FyZCAqLw0KPiAgCXJ0YzogbTQxdDBtNkA2OCB7DQo+ICAJCWNvbXBhdGli
bGUgPSAic3QsbTQxdDAiOw0KPiBAQCAtMjAwLDMgKzIxNSwxMiBAQA0KPiAgCXZtbWMtc3VwcGx5
ID0gPCZyZWdfM3YzPjsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiArDQo+ICsmaW9t
dXhjIHsNCj4gKwlwaW5jdHJsX2dwaW90b3VjaDogdG91Y2hncGlvcyB7DQo+ICsJCWZzbCxwaW5z
ID0gPA0KPiArCQkJTVg3RF9QQURfR1BJTzFfSU8wOV9fR1BJTzFfSU85CQkweDc0DQo+ICsJCQlN
WDdEX1BBRF9HUElPMV9JTzEwX19HUElPMV9JTzEwCQkweDE0DQo+ICsJCT47DQo+ICsJfTsNCj4g
K307DQo=
