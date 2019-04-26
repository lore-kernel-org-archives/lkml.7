Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF29C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFDD2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fKVkmHP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDZIFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:42 -0400
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:56549
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfDZIFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw/x2HN7ImxqLRuC3p1OZcZhq1qB7qzhOrOcIc5AsiE=;
 b=fKVkmHP0+8FtF+rKxGhl2K+cPX81ZkrL5XdcGr924Sazpa7WC7TZ1/UnzOCkm1bjPMuCrJ29CG0JeHR99qrLFV32RYcu5xLDJuYJ7gptCWdxcelbm1ZyKXGEocLNUj/mnQ1lPCL6RcPun5kvmrcJqEVnwMnRVzeD0u1ETgLya/M=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4830.eurprd04.prod.outlook.com (20.177.49.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:34 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 05/15] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Topic: [PATCH v2 05/15] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Index: AQHU/AbTAR7zaUA6G0e6Hu2ByPAlDQ==
Date:   Fri, 26 Apr 2019 08:05:34 +0000
Message-ID: <1556265512-9130-6-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 019c6480-6b5f-4873-321c-08d6ca1df55d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4830;
x-ms-traffictypediagnostic: VI1PR04MB4830:
x-microsoft-antispam-prvs: <VI1PR04MB48308D55942A437F3960CA85893E0@VI1PR04MB4830.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(36756003)(54906003)(81156014)(50226002)(8676002)(81166006)(8936002)(386003)(26005)(97736004)(2501003)(6506007)(4326008)(316002)(86362001)(3846002)(110136005)(6116002)(11346002)(6436002)(446003)(256004)(66066001)(2906002)(99286004)(52116002)(476003)(5660300002)(186003)(71190400001)(2616005)(25786009)(14454004)(7416002)(53936002)(71200400001)(486006)(305945005)(64756008)(66556008)(6512007)(73956011)(66446008)(478600001)(66476007)(2201001)(102836004)(68736007)(66946007)(76176011)(6486002)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4830;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zn1UWQJpIOM17M0rs0vBHhYbLw17y++GVb3kBbBygH4NVEB1/UGLUOhQtUlObotO17+aHuAazQypsYAzNpHL2ucjetBQGoBHLbxFKXFiRP0lj1BiWUaNmpd2ncW8qw+0uS3O0pYCbpxBbS/jsCn1TBWXQV2r6u7OlTpqj0gO+Ov9pE96QCQdOyxB6ej8L3T/WIxu3VwHmz8ihJ28T2sCrivb/NxY2uaqWR+IS8gsmeDFffTIsI1NQr5JUZ0goq+g8H+89NrpqxeFAupaJZ0bSlnZQk+6Dih1DSVq6gaVGstNVqY/6tW7JSN2s9lnNkOhC5QRiAldl5DogjPiIb5aAm2MHryPQ0NeZXkYMs12CYlYDcQ1Y022zBoogvdE/zZgQ/vJlfIAh6nOlrCYeql0rQEfRJT6yiVg4x5mGSNV4Ng=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c6480-6b5f-4873-321c-08d6ca1df55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:34.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogZHJp
dmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgIHwgMyArKysNCiBpbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmggfCAxICsNCiAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDg2YTMxYjQuLjM1MmIwZDUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQpAQCAtOTI0LDYgKzkyNCw5IEBAIHN0YXRpYyB2b2lkIHNkbWFfZ2V0X3BjKHN0cnVjdCBz
ZG1hX2NoYW5uZWwgKnNkbWFjLA0KIAkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5t
Y3VfMl9hdGFfYWRkcjsNCiAJCWJyZWFrOw0KIAljYXNlIElNWF9ETUFUWVBFX0NTUEk6DQorCQlw
ZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPmFwcF8yX21jdV9hZGRyOw0KKwkJZW1pXzJf
cGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5tY3VfMl9lY3NwaV9hZGRyOw0KKwkJYnJlYWs7DQog
CWNhc2UgSU1YX0RNQVRZUEVfRVhUOg0KIAljYXNlIElNWF9ETUFUWVBFX1NTSToNCiAJY2FzZSBJ
TVhfRE1BVFlQRV9TQUk6DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRh
L2RtYS1pbXgtc2RtYS5oIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2Rt
YS5oDQppbmRleCA2ZWFhNTNjLi5mNzk0ZmVlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3Jt
X2RhdGEvZG1hLWlteC1zZG1hLmgNCkBAIC01MSw2ICs1MSw3IEBAIHN0cnVjdCBzZG1hX3Njcmlw
dF9zdGFydF9hZGRycyB7DQogCS8qIEVuZCBvZiB2MiBhcnJheSAqLw0KIAlzMzIgemNhbmZkXzJf
bWN1X2FkZHI7DQogCXMzMiB6cXNwaV8yX21jdV9hZGRyOw0KKwlzMzIgbWN1XzJfZWNzcGlfYWRk
cjsNCiAJLyogRW5kIG9mIHYzIGFycmF5ICovDQogfTsNCiANCi0tIA0KMi43LjQNCg0K
