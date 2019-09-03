Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEFEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24BE21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="m3BbNl/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfICIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:03:52 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:43751
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfICIDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:03:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HATWzs65G1a5j8/WyS93znngx3GxOFUYQsP1F96/rtsXlyKT4xVG1eu7XwlG7Sa3dkjJCPGFJJgVvs5hnHGVCqe2JD+pFPI+ZRQ3wdHWbDk9kIeB+4f524dcq78v/gSVRYWPVNFQRNwtnYfevTuaecuVDt9306KZ1yjh34n9wmGc+WyqnvGQGzoIGZsXm7mrrDl3ruQKcAxYfB4ShfdVOPkkI9kOjxHFjqlrjVhAMMzeIBJ7b7w3DvXvWhqJVpM9SgS4lexMNHN0BGOlx3a8ILz35/H39hZ6yedJGtI6bcLzyeks9c5MDR39u0X6bjNr+CkjIZASHg+e0fUJIFgLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11shAEnm54iYqWnxs1WQewo/2M+laZAnVa3TTLn3/cs=;
 b=iRKAfLKLw1o+Mt/5sac+H8iJfrnQqaq44Nu5jRX/C/urmahr8qyZdl4vPMCeeGKCWWL86znlHz4m+CvPl8EhcgtIvorbhwaP9s6ZFJkmc2NDGnBMYcLZtEHzFTXdGsrW2r7Wqrc8wtpnDCp+sUDu6wKvhtErJjEvHxmzWXSATesYY1fhqOM/tNVX4eVhffQqX0DEos+hBqcoY5ZrJgohYbFRwgqRATTHAC55Nw/NpFahDgVvSAi2acbURn8TNvl9w/qGdRucHDzz+FoaL6boJFG6DonRWJg7dg/DP5ZkaXT4OpZJ7Tp2rwO6yooQk6C1b91zS+UX6Zib9xvaX8oiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11shAEnm54iYqWnxs1WQewo/2M+laZAnVa3TTLn3/cs=;
 b=m3BbNl/W9xGPPF41pe4pfo+WM6fqCeWATnyQG+NTQHPnrUGgryn9ZqD0H5MEm3ar6PzUz+rqSCQ8QQ5XpC+L9Q+gTRpppiYtHY9g7OIIXmZSPDVVZUTu/eJovq/gkafiCP8PYrXpxwqyUKnVuaMytnJFETSuUV1vjCXl23s3GAw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4014.eurprd05.prod.outlook.com (52.134.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Tue, 3 Sep 2019 08:03:47 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 08:03:47 +0000
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
Subject: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Topic: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Index: AQHVYi4cgyK53mdiuEKJwWlDc8lstw==
Date:   Tue, 3 Sep 2019 08:03:46 +0000
Message-ID: <20190903080336.32288-2-philippe.schenker@toradex.com>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
In-Reply-To: <20190903080336.32288-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d877e1cb-927d-4b96-94d8-08d730453f33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB4014;
x-ms-traffictypediagnostic: VI1PR0502MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB401456E05849538990E4E18AF4B90@VI1PR0502MB4014.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(6436002)(66066001)(81166006)(110136005)(54906003)(5660300002)(71200400001)(305945005)(2501003)(25786009)(476003)(81156014)(2616005)(44832011)(107886003)(6512007)(66446008)(99286004)(66946007)(66556008)(186003)(64756008)(66476007)(26005)(6486002)(71190400001)(4326008)(53936002)(446003)(52116002)(486006)(102836004)(11346002)(1076003)(6116002)(478600001)(86362001)(50226002)(14454004)(2906002)(36756003)(8936002)(76176011)(3846002)(6506007)(386003)(316002)(256004)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4014;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mmJ8sopXh3iWVuvyJJzxjaNL1FjIVqc3hLJ7nkWOPvxQPJT7S0Zok+JGxpRZSEGKneGQiHs0PsWEqO1NqnFJW5m2pKfWengoVeQDLn13vCY1QDO+OujCmGRnD+oTH/aj4UnCxcR7pdBQFNjmBDQL+Wue546J/NoE8U9jEsbLHNJkAfgZQ1TDGmANG9wM6VWHDiPtI3JV/kPoDRuI1HB66ryBvYpM1Bk4BewI4fuiPZHyjxEMo16w7dEJt6yBj7026DjJZkcJ7aVN2EWBNhhlDjedRAAIKL2nl8ycm4CjopPFXJtbl9ysD5ySZ1euWyc9y5E3e4Gm3MgS7wubVVc/qKf8IOKAKQabJGG7fufLpYleszeRvjFYymppSjgvH5SBIg9GsBb/YFYjr/Eulczx1sUPZaLonXHVQefsJB/rujE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d877e1cb-927d-4b96-94d8-08d730453f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 08:03:46.9644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to/U//IDPULCOxneSCX3lq2LH0vrLBKhmPjZJ4R3mfewjb9O+YF4bVcr+3PpwcIc42WYmq22JdMYJZbC6HoGrCw73CtMxWjf8SkxG7P52Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4014
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

 drivers/regulator/fixed.c | 86 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 999547dde99d..eadeca9a1a6c 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -23,14 +23,66 @@
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
+};
+
+struct fixed_dev_type {
+	bool has_enable_clock;
+};
+
+static const struct fixed_dev_type fixed_voltage_data =3D {
+	.has_enable_clock =3D false,
 };
=20
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
+	if (priv->clk_enable_counter > 0)
+		return 1;
+
+	return 0;
+}
+
=20
 /**
  * of_get_fixed_voltage_config - extract fixed_voltage_config structure in=
fo
@@ -84,10 +136,19 @@ of_get_fixed_voltage_config(struct device *dev,
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
@@ -118,7 +179,18 @@ static int reg_fixed_voltage_probe(struct platform_dev=
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
@@ -191,8 +263,16 @@ static int reg_fixed_voltage_probe(struct platform_dev=
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

