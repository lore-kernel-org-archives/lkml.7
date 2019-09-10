Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83073C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459A72089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cmGZkYNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404714AbfIJGVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:21:23 -0400
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:55813
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729225AbfIJGVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDuY92EOGwvXa1Wpk1k59MLcdsxUErj45YEdvVbwoDhQf4W/u2teoVNsblZerm5WhhqwBHdpX6oqBVQPqZfiNA669j6+ezoSLzOajfY/s8S6KxBf32TWqHv+kyEBjZphl3PSCdBXBfYRRRh2DKekeqrOPEo73EB12nnUq1aIJw2SZE7nu32HDAbXhKT1KGANiCjm6Egb59clP2dlWs0Yq+Q0SZvmabv3+H4zQAAMgotshJSI3kYgvCDfVh/Y5TtKcgtIECkwtaEkp5aAtOLEnpp3Ap8YBg/EyTnNBgMEZf+5BUPGCBlyYHzz9moxlx1Qfq4ChrmEguE3etwZb1u1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Z+uDCMj4ibAfOW9qb+7mEWrBVHzbO8T03FfJUsCiY=;
 b=Esn0gwUyPWSVtF91GfEfHiFTGy0jHkWKqGW+HP8+boSjzRHcY9PEtedBS6dBIf32k83iWR2K4IRnNWcnPmscogrPJRMwxBzUqnAVhJ/iq50K7PB6LsHm8csQJIqz0835bUGGp6k1btrGbjLhH6WUfWP/hLTBC+0kRJbS+GqAYHSVOJRpD8W9zKoFZbyjMRtr3L+Gf3a04kUZ0iOUhfP2hKN/zp/1MooksyLJBr+kzltljymD+Q1WwYYpaNQCB2+rAfjlKJ2E6s/O3P0fv76e6UEbS24jeWpDu4xO8+FwP5fXRFYaJcXuZIe5BVBUROYcjK/syO+KZXrUSXqv/XQHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Z+uDCMj4ibAfOW9qb+7mEWrBVHzbO8T03FfJUsCiY=;
 b=cmGZkYNPrITow0ETLyeQKHU2/QREQ7gnd5C4j7TZ3FSljbmACGJcNbNrXx9RysRI2L7SoBYuG05BLrwCp5/6BFIvFC5eD/VKMDP9iZntU58sOroeYsjGiBZzSg6ZhvigEDdMJ0dVHHZVt71jxZI5K3v863XL7JDBoXLNMI6uXtw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3054.eurprd05.prod.outlook.com (10.175.21.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 06:21:15 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:21:15 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH v2 1/3] regulator: fixed: add possibility to enable by clock
Thread-Topic: [PATCH v2 1/3] regulator: fixed: add possibility to enable by
 clock
Thread-Index: AQHVZ5/zuxT5EpAnfkinqjRvNsYP1g==
Date:   Tue, 10 Sep 2019 06:21:15 +0000
Message-ID: <20190910062103.39641-2-philippe.schenker@toradex.com>
References: <20190910062103.39641-1-philippe.schenker@toradex.com>
In-Reply-To: <20190910062103.39641-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::16) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b567c8d5-f3bb-4fe1-7354-08d735b71563
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3054;
x-ms-traffictypediagnostic: VI1PR0502MB3054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3054C4105939DABA1950BA25F4B60@VI1PR0502MB3054.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(316002)(25786009)(14454004)(4326008)(256004)(71200400001)(71190400001)(7736002)(305945005)(53936002)(478600001)(50226002)(107886003)(36756003)(8936002)(66476007)(66556008)(81156014)(64756008)(81166006)(66446008)(66946007)(486006)(44832011)(110136005)(99286004)(1076003)(6506007)(386003)(11346002)(446003)(8676002)(2616005)(476003)(2501003)(6512007)(26005)(54906003)(5660300002)(86362001)(6116002)(3846002)(102836004)(186003)(2906002)(52116002)(76176011)(6486002)(6436002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3054;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: buEeV26DPqi174oIdo1k6wddO+Y53DHyVLlCuqt8Zdw+MnKmPvZ+nPuP086wbiCsemtmnvI4jzI6Or9NBZKlTpJJWZtERLI1pHBLMNIao2ybH6ssaDhkOaXM/fo1jBO9T6KHsCyFlHqudfEyhHHKs8nd/4cmeFXK4S1kbFbTYyTq5Ujr+oCd+yWi7LxLZXtG7IDaHTUcnMZ/Qj/zuA1Wonj2TxEjOPrd0+fchVz7snrofjG/lGjBX6KN+eA6f008s7SWxQGVa93suoS7rqfzzGlatPc2nteSUhAbp+43HGe18wHDtFqVn3g+nqZconTg8hl1tTcnrMZQS+2ZH/Zze5GlpA0JruXjXnExmF3yZyOq4fHgZfcow+MuZyH8zhBlNPVm/YLMzHM7qCd+X2N+1Yl+RRWheWazTlvRORc7s0o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b567c8d5-f3bb-4fe1-7354-08d735b71563
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:21:15.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7o03Q3P41eVQbBo/K214MB3KlgnviL+DfOsPkZuJw8M8+J2zltgGtP6D1rPr3M1bVQRqneFKMXzpJRnzQtw3vM0/z+x4YHgEtukXTBPrUsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the possibility to choose the compatible
"regulator-fixed-clock" in devicetree.

This is a special regulator-fixed that has to have a clock, from which
the regulator gets switched on and off.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- return priv->clk_enable_counter > 0 directly.

 drivers/regulator/fixed.c | 83 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 999547dde99d..d90a6fd8cbc7 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -23,14 +23,63 @@
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
+#include <linux/clk.h>
+
=20
 struct fixed_voltage_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
+
+	struct clk *enable_clock;
+	unsigned int clk_enable_counter;
 };
=20
+struct fixed_dev_type {
+	bool has_enable_clock;
+};
+
+static const struct fixed_dev_type fixed_voltage_data =3D {
+	.has_enable_clock =3D false,
+};
+
+static const struct fixed_dev_type fixed_clkenable_data =3D {
+	.has_enable_clock =3D true,
+};
+
+static int reg_clock_enable(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv =3D rdev_get_drvdata(rdev);
+	int ret =3D 0;
+
+	ret =3D clk_prepare_enable(priv->enable_clock);
+	if (ret)
+		return ret;
+
+	priv->clk_enable_counter++;
+
+	return ret;
+}
+
+static int reg_clock_disable(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv =3D rdev_get_drvdata(rdev);
+
+	clk_disable_unprepare(priv->enable_clock);
+	priv->clk_enable_counter--;
+
+	return 0;
+}
+
+static int reg_clock_is_enabled(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv =3D rdev_get_drvdata(rdev);
+
+	return priv->clk_enable_counter > 0;
+}
+
=20
 /**
  * of_get_fixed_voltage_config - extract fixed_voltage_config structure in=
fo
@@ -84,10 +133,19 @@ of_get_fixed_voltage_config(struct device *dev,
 static struct regulator_ops fixed_voltage_ops =3D {
 };
=20
+static struct regulator_ops fixed_voltage_clkenabled_ops =3D {
+	.enable =3D reg_clock_enable,
+	.disable =3D reg_clock_disable,
+	.is_enabled =3D reg_clock_is_enabled,
+};
+
 static int reg_fixed_voltage_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct fixed_voltage_config *config;
 	struct fixed_voltage_data *drvdata;
+	const struct fixed_dev_type *drvtype =3D
+		of_match_device(dev->driver->of_match_table, dev)->data;
 	struct regulator_config cfg =3D { };
 	enum gpiod_flags gflags;
 	int ret;
@@ -118,7 +176,18 @@ static int reg_fixed_voltage_probe(struct platform_dev=
ice *pdev)
 	}
 	drvdata->desc.type =3D REGULATOR_VOLTAGE;
 	drvdata->desc.owner =3D THIS_MODULE;
-	drvdata->desc.ops =3D &fixed_voltage_ops;
+
+	if (drvtype->has_enable_clock) {
+		drvdata->desc.ops =3D &fixed_voltage_clkenabled_ops;
+
+		drvdata->enable_clock =3D devm_clk_get(dev, NULL);
+		if (IS_ERR(drvdata->enable_clock)) {
+			dev_err(dev, "Cant get enable-clock from devicetree\n");
+			return -ENOENT;
+		}
+	} else {
+		drvdata->desc.ops =3D &fixed_voltage_ops;
+	}
=20
 	drvdata->desc.enable_time =3D config->startup_delay;
=20
@@ -191,8 +260,16 @@ static int reg_fixed_voltage_probe(struct platform_dev=
ice *pdev)
=20
 #if defined(CONFIG_OF)
 static const struct of_device_id fixed_of_match[] =3D {
-	{ .compatible =3D "regulator-fixed", },
-	{},
+	{
+		.compatible =3D "regulator-fixed",
+		.data =3D &fixed_voltage_data,
+	},
+	{
+		.compatible =3D "regulator-fixed-clock",
+		.data =3D &fixed_clkenable_data,
+	},
+	{
+	},
 };
 MODULE_DEVICE_TABLE(of, fixed_of_match);
 #endif
--=20
2.23.0

