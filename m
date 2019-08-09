Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C69C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6A320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oO6Uf+91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436663AbfHIPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:36:27 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:51167
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436647AbfHIPg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cosUpkA5XUaks1bZaB+Ct5O9BlDd0uPceUdPJQT/iyoXFfY7O2piHyI4vR/KeSI0/1gWBLTEF2y4d2i3+1/ckiwC1+zVwVp2HrgyAlsyMrEC6dH2M7iK2IZAWmafjF7MCpRaiKJ/18UKvxPcvyRlruExlGC/KFbLoNpegNF4bY36rX62FvnV8wE/1DWkGfYy9buwR/yfAhKOnzDEU6Sn8uuaunKNF4x1OpUHEwafG2G6tUJiZZP3zjWHg5BwdHRS47VooFHuPhdvrhtM1o6JcJLOlESHIm/jBJ9iWsVhekQV19WiSojOjwIltqwtoMr0CPOfL+ucpZgVSuuL0gPYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftYVBfTn48LJEHq0oFZdrW7pRJZck54rV3Jt4E2DgVU=;
 b=baxKcfrbPSFx5/gJof/iwIpnYOWIw0h7CUr5nkfTclNDMwc6laV1S3+1InwjOyL+XkXLNE3SKJEvsH3zyMJoxYCgmgRllh8TdB096ODVxXo8kwMyQy9l/fpZVLk45SwqTLd9fUL5zxfPNU0Cmb2vi65pCjOJes078AAOTboc+S3cgEr4BcAogLSZ1CsLHNjFoczZeLSJayaih+e0nW2fN+ZY0ZwhVo0c63C44Fd+W0z7Scj9HxxD2yEjoQvE+ilc5QWJKlfKgeQlg1dUIuoo8Z3HwEdp0+fML8NO9RIaa8SS+o0cE1pI2MFhmA5Qmaw9ZAiQaeLj82Ufb7XXoQRDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftYVBfTn48LJEHq0oFZdrW7pRJZck54rV3Jt4E2DgVU=;
 b=oO6Uf+91amGTpzyANWJps8+tcwog/D0JT80I898v+hirZs8iPrpIKlYpfDMfluG+YtHQkDmI1xpZImpF3fnjYCoZCzuNEt/p4wMkN+8LGsRSPtMSfqg66nshS2+mLJKlFUYjEowkt9ngCBREuKz0Wb2NznR+FzImP5/acnLlER0=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB4909.eurprd05.prod.outlook.com (20.177.51.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 15:36:22 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:36:22 +0000
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
Subject: Re: [PATCH v3 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing to
 Toradex eval board
Thread-Topic: [PATCH v3 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing
 to Toradex eval board
Thread-Index: AQHVTPnS33I5w2Yy6025DybA7v+Vgqby9m+A
Date:   Fri, 9 Aug 2019 15:36:22 +0000
Message-ID: <5d73b3ebb81f1245dbc70ff0b81c9f724605df67.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-14-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-14-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e1a4e8a-1735-4e7a-bd3a-08d71cdf54f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB4909;
x-ms-traffictypediagnostic: VI1PR05MB4909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4909B3C8E138E6F97CDEA7BFFBD60@VI1PR05MB4909.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(186003)(256004)(6506007)(446003)(11346002)(102836004)(6116002)(46003)(76176011)(2616005)(118296001)(478600001)(476003)(44832011)(71200400001)(71190400001)(66446008)(8936002)(66476007)(66556008)(486006)(66946007)(64756008)(2906002)(91956017)(76116006)(2501003)(25786009)(4326008)(53936002)(6512007)(86362001)(2201001)(305945005)(99286004)(7736002)(14454004)(7416002)(6436002)(36756003)(6486002)(5660300002)(110136005)(316002)(6246003)(54906003)(229853002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4909;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N8wHnQ0MaBYVOVt9xdX1OvTCk4KQu/jZywODrwDYFHx6e4zMrvukUaSpRROlDvaAXgm+qm6ciUUBNwbwMtPzHuhX0X6SKsaSxGykdvp3rY+9T8iDphXqjkENGKSDXEu+kY2v0763eG+ALWYc5ho5V3v8zjV9csP3SVBLkjDLWrlvQh6gHXXB4C+2FvxdUmSQTIUP12Z+1CwaSUG8Fh0QvhIiFzXciWjn/LfWnmE1q9DxIOZ7ggTfM0cNUcBFuToxi0wX8ezPIfNVqtMsMpTKJXRbvIqcERgch4QgL14ZpJd6Qq+fpseCiUbMn3R/FjN48rGgyH5o7ekjK3mmiZVmHidWiPUL3Nx9kRgZ8ZboZHy18QYIppJnlKZ50z3dek3I+OpKHH6u+lwGMBW7096WzBqWgq7AjutGTczyP7QGu2w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D47342D1EA724FB392960A66DA4C3D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1a4e8a-1735-4e7a-bd3a-08d71cdf54f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:36:22.2833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ElbfHBPn4+dD82lO5ibimKmWa60K/GFeZKuS4yxLKwtaZL+GRhMQgRxM8NaskHeA6C/KzpVQrtHu0zLcfwowVg1DvGIur9U8SDMXzuir+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBwYXRjaCBhZGRzIHNvbWUgbWlzc2luZyBwaW5tdXhpbmcgdGhhdCBpcyBpbiB0
aGUgY29saWJyaQ0KPiBzdGFuZGFyZCB0byB0aGUgZHRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQpBY2tl
ZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4g
LS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gQ29t
bWl0IHRpdGxlDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12
My5kdHMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12
My5kdHMNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtY29saWJyaS1ldmFsLXYzLmR0cw0K
PiBpbmRleCA3NjNmYjVlOTBiZDMuLmU3YTJkOGMzYjJkNCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMNCj4gQEAgLTE5MSw2ICsxOTEsMTQg
QEANCj4gIH07DQo+ICANCj4gICZpb211eGMgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ICsJcGluY3RybC0wID0gPA0KPiArCQkmcGluY3RybF93ZWltX2dwaW9fMSAmcGluY3Ry
bF93ZWltX2dwaW9fMg0KPiArCQkmcGluY3RybF93ZWltX2dwaW9fMyAmcGluY3RybF93ZWltX2dw
aW9fNA0KPiArCQkmcGluY3RybF93ZWltX2dwaW9fNSAmcGluY3RybF93ZWltX2dwaW9fNg0KPiAr
CQkmcGluY3RybF91c2JoX29jXzEgJnBpbmN0cmxfdXNiY19pZF8xDQo+ICsJPjsNCj4gKw0KPiAg
CXBpbmN0cmxfcGNhcF8xOiBwY2FwLTEgew0KPiAgCQlmc2wscGlucyA9IDwNCj4gIAkJCU1YNlFE
TF9QQURfR1BJT185X19HUElPMV9JTzA5CTB4MWIwYjAgLyoNCj4gU09ESU1NIDI4ICovDQo=
