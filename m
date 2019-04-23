Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D708C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C8F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQoU/yWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfDWNvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:07 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:15429
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727758AbfDWNvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKD4VXiboKhaZKxfv1eUAsDm9mV6M9jfCxR3J3NLWRc=;
 b=eQoU/yWyqHQI/GgBdKJ5PBHKlgNd3U5ll6CBr2vXq6C9+t00YtsWKBmezRirTdaICwB4htzaEvH7WKcOnY+YQI8Aqm0vWjHvZ9u93PhkQ4+sWpFaKsCl1KmKOZnOFFeupD1BOmfbFQuiNp9MdA+IepJ615za3bsmGBtH1QIKavs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:01 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 05/15] dma: engine: imx-sdma: add mcu_2_ecspi script
Thread-Topic: [PATCH v1 05/15] dma: engine: imx-sdma: add mcu_2_ecspi script
Thread-Index: AQHU+duVaa3xyho7pEWUiTYZI4queA==
Date:   Tue, 23 Apr 2019 13:51:00 +0000
Message-ID: <1556027045-5269-6-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fe6f872-651a-4a5e-334c-08d6c7f2b81c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB5854BF9EC55E7C8C701EA2C289230@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(2201001)(71200400001)(86362001)(54906003)(110136005)(52116002)(6116002)(3846002)(2906002)(71190400001)(76176011)(14454004)(73956011)(2616005)(5660300002)(446003)(476003)(68736007)(6436002)(97736004)(11346002)(99286004)(478600001)(316002)(486006)(2501003)(66446008)(66476007)(102836004)(66066001)(26005)(6486002)(66556008)(386003)(53936002)(6506007)(50226002)(4326008)(186003)(6512007)(7736002)(81166006)(81156014)(305945005)(8676002)(8936002)(256004)(36756003)(66946007)(7416002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvQewfLyLyEkCMbavRKdYYb5h6KDqZczuNCJWwGSbOuO0dSKssfN4NKiv74QwmbZOXkG6Y+VYBk2prsTP5pgqO4DJNcUS0fmHm3orZxs4CIIDzI3+rl6PAJOwLOj1ThREUWxoitL1qJqSXRpcqckpboX+ebLTWefAcxKlZ9KIycukRc99YzeVpjrBiy5/5AHXg3pw3PVBwgGkYlTEqpJdQ5i7yJL6p/HGZbPPr2qpiJ2pa62VmYc0FN2SRZXoynlqRsub98Spqb4HueCzOwmSTZAPSejN4i2+ZW6+OxB4WeuMqooAG+ju5Y3Z9p6diFp9i/EPZSDRW0WWkW2mZRVAUdoRYC6i9UYV2E7/Om6FfbZjNYhBZkJSNvwgMIT5yPT+gA7ZGnt7SoUurkzvu33ZN3K2EkfWGS+VcrHhjxhG2Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6f872-651a-4a5e-334c-08d6c7f2b81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:00.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogZHJp
dmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgIHwgMyArKysNCiBpbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmggfCAxICsNCiAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDhhOGNlOThhLi4xZTIwNDcwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvaW14LXNk
bWEuYw0KQEAgLTkyNCw2ICs5MjQsOSBAQCBzdGF0aWMgdm9pZCBzZG1hX2dldF9wYyhzdHJ1Y3Qg
c2RtYV9jaGFubmVsICpzZG1hYywNCiAJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+
bWN1XzJfYXRhX2FkZHI7DQogCQlicmVhazsNCiAJY2FzZSBJTVhfRE1BVFlQRV9DU1BJOg0KKwkJ
cGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5hcHBfMl9tY3VfYWRkcjsNCisJCWVtaV8y
X3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfZWNzcGlfYWRkcjsNCisJCWJyZWFrOw0K
IAljYXNlIElNWF9ETUFUWVBFX0VYVDoNCiAJY2FzZSBJTVhfRE1BVFlQRV9TU0k6DQogCWNhc2Ug
SU1YX0RNQVRZUEVfU0FJOg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9kbWEtaW14LXNkbWEuaCBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNk
bWEuaA0KaW5kZXggNmVhYTUzYy4uZjc5NGZlZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgv
cGxhdGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9y
bV9kYXRhL2RtYS1pbXgtc2RtYS5oDQpAQCAtNTEsNiArNTEsNyBAQCBzdHJ1Y3Qgc2RtYV9zY3Jp
cHRfc3RhcnRfYWRkcnMgew0KIAkvKiBFbmQgb2YgdjIgYXJyYXkgKi8NCiAJczMyIHpjYW5mZF8y
X21jdV9hZGRyOw0KIAlzMzIgenFzcGlfMl9tY3VfYWRkcjsNCisJczMyIG1jdV8yX2Vjc3BpX2Fk
ZHI7DQogCS8qIEVuZCBvZiB2MyBhcnJheSAqLw0KIH07DQogDQotLSANCjIuNy40DQoNCg==
