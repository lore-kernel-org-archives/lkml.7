Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C366C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F3204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="qiXvZbYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436848AbfHIPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:51:23 -0400
Received: from mail-eopbgr130111.outbound.protection.outlook.com ([40.107.13.111]:35199
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436723AbfHIPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:51:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkjKRwgVVxbBSxe3HkJzIMwOo79hh5BJBh7Zf0WERYKj+/6vnJptS+fOCbHUg5MDJKQyAy0r72VGqkd4jmYxBJv+pLDz4PfV464HYlaXh1+V2gbycAOEAJsKLHSKae/Am7hdCvCvysssqoNtPt2YyPKeXAtf6qXznZrQ4OoQgt8vZH5c4BpaapUp+6sRCw2GjYuBkFX0r4ZfizbjEeiXr++2pYeY7EEkGcuSDGLUO1TQPFQwr2aLiCyIkzNx4rPZbKFJ8j200wIhFZ4FRuG3OH7N9K92Sri1fTEV9dYV8Q/wHdcskh5KJJNw7WNZj3JTR8wNwhhj88oy946MhsHO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQn7mq8toMqEP/+PSd/VhC717E+adFw9fT3aj8Ik0Ko=;
 b=NTPTZHhdhloJfHP2me7rcQzQ6YxZpC6Zf6QyOfB1R/KT1t5TXX1KhQBDjvy6HRJUhPX4+Om5Hi9P02cLjIIwGzTeORrkFCUb2nGFtgddYh68nLJMgUoHGp1EhU14TsHTy7mkHxtX/LsF9mElLOm9Xs0swKM5hVmRPSMiT2LlJwddrKlavQy0NixSpWTqeKzizDUejp78NRkJAPk89rQsLnEz0U1ToirJ2qvZwXZKR21PZbJAeLyxGmBS9J07vR6nQbelQWB8r+5ZLxbjwT4PpFKDKDMEBHDolJ0AUUO2DOC7SXHULGfpYuO5SBzzGzw1glv7/oSwM7lebxEeVKauyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQn7mq8toMqEP/+PSd/VhC717E+adFw9fT3aj8Ik0Ko=;
 b=qiXvZbYEB8hAzouB2rrnEZpHWu0OMjnN/ePFZmNUK+dGgrUR1EkenZiGpp1H/4kK690EfZIGS8OOXCrUEZZs1XzXfn2ietqVXkW4S+Q5K4QCHGW9tMFSFJuAWDU2mhtGlpgViohdeV1nSoS0kjo1POYoook5xkJ/7CloqIIsxgY=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6752.eurprd05.prod.outlook.com (10.186.160.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 9 Aug 2019 15:50:39 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 15:50:39 +0000
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
Subject: Re: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Topic: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Index: AQHVTPnaMq+cBhrhOESMmkEjvAhy56by+m0A
Date:   Fri, 9 Aug 2019 15:50:38 +0000
Message-ID: <6fdbd56b71c1192c67b2e28accd611ced92de555.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-20-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-20-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff4c43d-d14c-46fc-987b-08d71ce1538e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6752;
x-ms-traffictypediagnostic: VI1PR05MB6752:
x-microsoft-antispam-prvs: <VI1PR05MB67526F7488A4D06DE354A459FBD60@VI1PR05MB6752.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(366004)(39850400004)(376002)(199004)(189003)(86362001)(4326008)(102836004)(186003)(76176011)(2501003)(6506007)(446003)(486006)(476003)(2616005)(11346002)(44832011)(7416002)(46003)(81156014)(8676002)(8936002)(81166006)(6116002)(25786009)(14454004)(6246003)(118296001)(54906003)(110136005)(7736002)(99286004)(316002)(478600001)(2906002)(2201001)(5660300002)(71190400001)(305945005)(71200400001)(14444005)(256004)(76116006)(91956017)(229853002)(6512007)(66556008)(66946007)(64756008)(66446008)(36756003)(6436002)(6486002)(66476007)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6752;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t8vUtCw3QfQ+Ie9PFrZNTdIEKStjlJ7FbrwdBYFBp1zbqPpnqybe6ETmlOfrBP2M6RCC3AB9DqXF7/uLwKLYj5qr9OHfZEvQxG5VedvjGCHUNvH4JaEcJedjLKJ0V2yGor3b9ZJytN0X5VElCabvdWczBJcLhNJUeE571oK8WcSI9sE3doq4cwXNnyKM4x+tm+R5E+pZ2vp2QT+apceIPPMtAN7jv0M+rGrCtxvoUYbX7le0I1AMWMx3HuoN9MzkRttEoanpXMShJdhSUKZnOOEWKGRowzDVD2tr8u+BcrTdxT4bGyXG8JuQ6wRrPADutWaUs1bhf5wzue5yME92ABesJPtiMUp3BAok5Im4u9uTuAi9q97xRI07wqtr3DQt1f0j9CvZgu7NLHAmZ0bZGNh/DBZ9gH74WWE3yGdGkgE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D139DAE6FC76ED4083AA45298C565149@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff4c43d-d14c-46fc-987b-08d71ce1538e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 15:50:38.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sw1CZJCxdd08u5mUkofBaEskKYyzMJQ3cnJ7OMwnox/01JBf3Z6vUVxLY1m1nHqhyBV+tj/oL3bPM6r16Cw/ncJFK8CvdhZ50Mwa5be6l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcGUNCg0KT24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBw
ZSBTY2hlbmtlciB3cm90ZToNCj4gSW4gb3JkZXIgZm9yIHRoZSBvdGcgcG9ydHMsIHRoYXQgdGhl
c2UgbW9kdWxlcyBzdXBwb3J0LCBpdCBpcyBuZWVkZWQNCj4gdGhhdCBkcl9tb2RlIGlzIG9uIG90
Zy4gU3dpdGNoIHRvIHVzZSB0aGF0IGZlYXR1cmUuDQoNCklzbid0IGZ1cnRoZXIgZXh0Y29uIGlu
dGVncmF0aW9uIHJlcXVpcmVkIGZvciB0aGlzIHRvIHRydWx5IHdvcms/DQoNCj4gU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0K
PiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0K
PiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgMiArLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kgICAgfCAyICstDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0KPiBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpDQo+IGluZGV4IDlhNjNkZWJhYjBiNS4uNjY3
NDE5ODM0NmQyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGli
cmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWNvbGlicmkuZHRzaQ0K
PiBAQCAtMzg4LDcgKzM4OCw3IEBADQo+ICAmdXNib3RnIHsNCj4gIAlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiAgCWRpc2FibGUtb3Zlci1jdXJyZW50Ow0KPiAtCWRyX21vZGUgPSAicGVy
aXBoZXJhbCI7DQo+ICsJZHJfbW9kZSA9ICJvdGciOw0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQo+ICB9Ow0KPiAgDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGli
cmkuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+IGluZGV4
IDY3ZjVlMGM4N2ZkYy4uNDI0NzhmMWFhMTQ2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNv
bGlicmkuZHRzaQ0KPiBAQCAtMzIwLDcgKzMyMCw3IEBADQo+ICB9Ow0KPiAgDQo+ICAmdXNib3Rn
MSB7DQo+IC0JZHJfbW9kZSA9ICJob3N0IjsNCj4gKwlkcl9tb2RlID0gIm90ZyI7DQo+ICB9Ow0K
PiAgDQo+ICAmdXNkaGMxIHsNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K
