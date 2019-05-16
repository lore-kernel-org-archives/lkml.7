Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E97C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF73204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cyo2TtYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfEPLMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:12:21 -0400
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:38149
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfEPLMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgcY2xSbIvh4TkVUwwOe1HCrM2EGMqs4QHHYgTvcM3k=;
 b=Cyo2TtYMT7rRElnmkbm8e+mmqyvV0Z50p+u9uCCIS/fNNVHyj8wcFWA++GZQ6litktObVrpgHIFBzTH6E1OZhuduSWHaHqQADU+Gomq11kxNKfGQPkJ5/NESUlDLHp6NNVBdyt+GyA5iY120txna0lXq39l3K1R48KmwF6yNRBg=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6446.eurprd04.prod.outlook.com (20.179.232.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:12:16 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:12:16 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] ASoC: cs42xx8: Add reset gpio handling
Thread-Topic: [PATCH V3] ASoC: cs42xx8: Add reset gpio handling
Thread-Index: AQHVC9g4NI4lM/q29kOkqW7xk8swjQ==
Date:   Thu, 16 May 2019 11:12:15 +0000
Message-ID: <ae2e50f838ad1990b1ae20a75cfc573d29369cff.1558004881.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c5f2ac8-3f19-4000-91fa-08d6d9ef5a6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6446;
x-ms-traffictypediagnostic: VE1PR04MB6446:
x-microsoft-antispam-prvs: <VE1PR04MB6446C29F6A773A8C87A5FEAAE30A0@VE1PR04MB6446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(66556008)(64756008)(66446008)(68736007)(66476007)(305945005)(7736002)(81166006)(102836004)(8676002)(81156014)(2616005)(36756003)(66066001)(476003)(6116002)(3846002)(66946007)(4326008)(256004)(186003)(25786009)(6506007)(386003)(14444005)(26005)(486006)(71200400001)(71190400001)(52116002)(110136005)(14454004)(2501003)(73956011)(316002)(99286004)(118296001)(2201001)(6436002)(53936002)(2906002)(86362001)(478600001)(5660300002)(8936002)(50226002)(6512007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6446;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7qIVbRYiu6Ru2+MQIbadY2FnFp7XMkJC7VduGS5U+R2e3tz+I0xOHJEfbQ4pkqX83e+EN3B1PRLPN2W+8BbXKTM279NsKQmZF1uM/ENPXK4eDU4tCuKWueepznLocER6byvFYQBzKcdhsX60kxJTHYFuvnB614sOhaj/2/oHDTGPI7IDeFbIYTxFTTYg9nd9ZxE/rBFhIG+nxUGczPpwtgqhGDpaowAyRH4+JZgIerWkmfptDqF12kOQdsj4mcSAeEHTkHM0yLvFK9yIaiEdVtU2k4J0KmjNko6qkSvPRiTotxm3NVkHaX7mF4dKwOouv+Bzh8Th9tKbnOCuPLFCQya8DGcbtNpzR10jViTEiZ5D7MKwQSsPJ/W9hwC1Vw9xkwa1YT2Vodq1eIW5Kx0xmH/bnPvz/5Ro3oBv9R4+aIQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <77F5604BA7571D4DB7E6178C79B79A9F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5f2ac8-3f19-4000-91fa-08d6d9ef5a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:12:15.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the reset GPIO and reset the device every time we
start it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v3
- update binding document.

Changes in v2
- use devm_gpiod_get_optional instead of of_get_named_gpio

 Documentation/devicetree/bindings/sound/cs42xx8.txt |  6 ++++++
 sound/soc/codecs/cs42xx8.c                          | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Document=
ation/devicetree/bindings/sound/cs42xx8.txt
index 8619a156d038..ab8f54095269 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -14,6 +14,11 @@ Required properties:
   - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the d=
evice,
     as covered in Documentation/devicetree/bindings/regulator/regulator.tx=
t
=20
+Optional properties:
+
+  - reset-gpio : a GPIO spec to define which pin is connected to the chip'=
s
+    !RESET pin
+
 Example:
=20
 cs42888: codec@48 {
@@ -25,4 +30,5 @@ cs42888: codec@48 {
 	VD-supply =3D <&reg_audio>;
 	VLS-supply =3D <&reg_audio>;
 	VLC-supply =3D <&reg_audio>;
+	reset-gpio =3D <&pca9557_b 1 1>;
 };
diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 28a4ac36c4f8..b377cddaf2e6 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
@@ -45,6 +46,7 @@ struct cs42xx8_priv {
 	bool slave_mode;
 	unsigned long sysclk;
 	u32 tx_channels;
+	struct gpio_desc *gpiod_reset;
 };
=20
 /* -127.5dB to 0dB with step of 0.5dB */
@@ -467,6 +469,13 @@ int cs42xx8_probe(struct device *dev, struct regmap *r=
egmap)
 		return -EINVAL;
 	}
=20
+	cs42xx8->gpiod_reset =3D devm_gpiod_get_optional(dev, "reset",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(cs42xx8->gpiod_reset))
+		return PTR_ERR(cs42xx8->gpiod_reset);
+
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	cs42xx8->clk =3D devm_clk_get(dev, "mclk");
 	if (IS_ERR(cs42xx8->clk)) {
 		dev_err(dev, "failed to get the clock: %ld\n",
@@ -547,6 +556,8 @@ static int cs42xx8_runtime_resume(struct device *dev)
 		return ret;
 	}
=20
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	ret =3D regulator_bulk_enable(ARRAY_SIZE(cs42xx8->supplies),
 				    cs42xx8->supplies);
 	if (ret) {
@@ -586,6 +597,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(cs42xx8->supplies),
 			       cs42xx8->supplies);
=20
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 1);
+
 	clk_disable_unprepare(cs42xx8->clk);
=20
 	return 0;
--=20
2.21.0

