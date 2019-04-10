Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A83C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288D32133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xa6wAoJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfDJGCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:02:35 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:24419
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfDJGCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeNfV1Emi/EWELGcLbLI0xsrgf88wXvn88bFwfc1egc=;
 b=xa6wAoJJhGFt4yB+Lvm1Yl1O18gDDyji4Mb3QalxY4ARgEoy7o98zIrGQ7l4dXcB0jadrCj5CmJ73jNBM+Cmh89k0l1mvaqNJG2CKJzXXLz22coVMaXQDxJjjF7GV1rQMFZf1ycZ9hB8tOr/h0BbzC2/XZifd56P6WL2al10BSM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3660.eurprd04.prod.outlook.com (52.134.70.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 06:01:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 06:01:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH V11 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHU72LiuM8Qsr2oR0KmyXbs0XKcmQ==
Date:   Wed, 10 Apr 2019 06:01:49 +0000
Message-ID: <1554875779-19727-4-git-send-email-Anson.Huang@nxp.com>
References: <1554875779-19727-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554875779-19727-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c36d9c8e-9fea-41c7-e9b3-08d6bd7a0509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3660;
x-ms-traffictypediagnostic: DB3PR0402MB3660:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3660A3CF15F9C83C78F61425F52E0@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(486006)(66066001)(8676002)(476003)(446003)(36756003)(5660300002)(256004)(81156014)(50226002)(71200400001)(71190400001)(105586002)(2616005)(14444005)(81166006)(8936002)(478600001)(7416002)(106356001)(6512007)(305945005)(7736002)(53936002)(110136005)(2201001)(186003)(86362001)(76176011)(6486002)(99286004)(97736004)(4326008)(14454004)(68736007)(316002)(11346002)(52116002)(26005)(6436002)(6116002)(6506007)(3846002)(25786009)(386003)(2501003)(2906002)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3660;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0V13qOOIwmg0TpgaO+yGoy3lV0hdq9cJ4VVEV0501IfqRRS/wvau+frgOybjkyaeFEbB8hLDpZAwq07j67dzkNQniLiMYPI5AgJEdUe4BJ6jddiOmGY9OlU5UfgmGmeb01QznCrxjePXe2R3e2KB4xELNHFHN7i8DO/cwVfJmVC7ksqYBMWe+6TD68cFf8dgLksSW7gMAvNXF4HosAKjROdKz0C3g+/r5FF+51DdFfwa9PAvDd6zW1bgNKOyOHmksOGrXukGaJ1At5wbF+bt1M10DP02wBPmkBWWMwZlRKIZ4ZtQZ+6s/p5U1bEkuFm5O9WAbxd0zGwBLADBC1CzhALdKmVpE9czBY79gidvuoGw+m60MQ/SZtb9wvjB8zWNFAL2eSASXSpyXAndxp9pIMJGvZj2t+xxkSac8H0G5kg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d9c8e-9fea-41c7-e9b3-08d6bd7a0509
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 06:01:49.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIENQVSB0aGVybWFsIHpvbmUgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgVjEw
Og0KCS0gcmVtb3ZlIHByb3BlcnR5ICJpbXgsc2Vuc29yLXJlc291cmNlLWlkIiBhbmQgcHV0IEhX
IHJlc291cmNlIElEIGluc2lkZSBlYWNoDQoJICB0aGVybWFsLXNlbnNvcnMnIHBoYW5kbGUgYXJn
dW1lbnQuDQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzMg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5k
dHNpDQppbmRleCA3MGVmM2RiLi5jYzFkODc3IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2dwaW8vZ3Bpby5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hcm0tZ2ljLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvcGFkcy1p
bXg4cXhwLmg+DQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC5oPg0KIA0K
IC8gew0KIAlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KQEAgLTE0OSw2ICsxNTAsMTEgQEAN
CiAJCXJ0YzogcnRjIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQog
CQl9Ow0KKw0KKwkJdHNlbnM6IHRoZXJtYWwtc2Vuc29yIHsNCisJCQljb21wYXRpYmxlID0gImZz
bCxpbXg4cXhwLXNjLXRoZXJtYWwiLCAiZnNsLGlteC1zYy10aGVybWFsIjsNCisJCQkjdGhlcm1h
bC1zZW5zb3ItY2VsbHMgPSA8MT47DQorCQl9Ow0KIAl9Ow0KIA0KIAl0aW1lciB7DQpAQCAtNDg0
LDQgKzQ5MCwzMSBAQA0KIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnBkIElNWF9TQ19SX0dQSU9fNz47
DQogCQl9Ow0KIAl9Ow0KKw0KKwl0aGVybWFsX3pvbmVzOiB0aGVybWFsLXpvbmVzIHsNCisJCWNw
dS10aGVybWFsMCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDI1MD47DQorCQkJcG9s
bGluZy1kZWxheSA9IDwyMDAwPjsNCisJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIElNWF9T
Q19SX1NZU1RFTT47DQorCQkJdHJpcHMgew0KKwkJCQljcHVfYWxlcnQwOiB0cmlwMCB7DQorCQkJ
CQl0ZW1wZXJhdHVyZSA9IDwxMDcwMDA+Ow0KKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCisJ
CQkJCXR5cGUgPSAicGFzc2l2ZSI7DQorCQkJCX07DQorCQkJCWNwdV9jcml0MDogdHJpcDEgew0K
KwkJCQkJdGVtcGVyYXR1cmUgPSA8MTI3MDAwPjsNCisJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47
DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCisJCQkJfTsNCisJCQl9Ow0KKwkJCWNvb2xpbmct
bWFwcyB7DQorCQkJCW1hcDAgew0KKwkJCQkJdHJpcCA9IDwmY3B1X2FsZXJ0MD47DQorCQkJCQlj
b29saW5nLWRldmljZSA9DQorCQkJCQkJPCZBMzVfMCBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxf
Tk9fTElNSVQ+Ow0KKwkJCQl9Ow0KKwkJCX07DQorCQl9Ow0KKwl9Ow0KIH07DQotLSANCjIuNy40
DQoNCg==
