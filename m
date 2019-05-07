Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D13C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3051F20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBl1pQUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEGJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:16:16 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:11694
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726812AbfEGJQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw/x2HN7ImxqLRuC3p1OZcZhq1qB7qzhOrOcIc5AsiE=;
 b=JBl1pQUSNlnYG4qKtjkgs9MPdBde+3BDHM22B9OkZcWXoVvznUTu4sdrkfJqi2hn0r6V8YBogYeesyUqyYOccNyP3sOvVDoE+jTZ3XLiPb64/2NYWbHmSTokP9AZ/lmEPqnoR9QFBc/51KwwycOKuC69sIja7Lujay8PKOvdbAA=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5005.eurprd04.prod.outlook.com (20.177.49.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 09:16:07 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 09:16:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v3 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Topic: [PATCH v3 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Thread-Index: AQHVBLWAIP6+Qg6s5E+FTUE3YFIAMg==
Date:   Tue, 7 May 2019 09:16:07 +0000
Message-ID: <1557249513-4903-6-git-send-email-yibin.gong@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42005fae-7cbf-4136-7d20-08d6d2cca282
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5005;
x-ms-traffictypediagnostic: VI1PR04MB5005:
x-microsoft-antispam-prvs: <VI1PR04MB5005F3848476F268F5C4E96689310@VI1PR04MB5005.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(386003)(6506007)(2501003)(36756003)(102836004)(6486002)(26005)(8676002)(4326008)(5660300002)(25786009)(68736007)(52116002)(76176011)(186003)(2201001)(6512007)(53936002)(3846002)(71200400001)(66556008)(86362001)(66446008)(64756008)(476003)(66476007)(7416002)(305945005)(2906002)(11346002)(7736002)(66066001)(6116002)(99286004)(54906003)(256004)(14454004)(2616005)(73956011)(110136005)(6436002)(50226002)(8936002)(81156014)(81166006)(66946007)(316002)(71190400001)(486006)(478600001)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5005;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WmU2xRbHJ4+1WW/FMY+VqcSuPaXn1kt9Y3lssBhTG8VM6eAw8/WTzwr7anRGXRKlva2QTGbx/V09PIPiy0u2QdNnQQk+sT5magetmAJiuyZxgp8xD8ylZV3MpPyvY0EtZZBkekz6eHtXNjESZk5819Ig7T2Jmb+f5Q8p0qJL49r1bfK8EZ8IH+vflouU7BN3neL0O7KFPsQHDF2sCOqbtA/OrItRmNCwNCteRr68+vgvMmwsRNflEzMH8EUGNnb8wmbhK6IDZ40kaQg3Oc48LJHlPb6WnXsZ5dwNsA6ze3n5BHJqAmZYhCIR0BfHjalddh2pqijanzArtcD7os+p6LC4c7McUDwoWxk+E3KsfGFEIcEcSH8OVtfmbk/iQ23ZJFXgW9qXjovxMV+ZaECMsjDOPbAGQej0c5n77xSaVYg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42005fae-7cbf-4136-7d20-08d6d2cca282
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 09:16:07.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
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
