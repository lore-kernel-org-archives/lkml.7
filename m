Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC0DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97776217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="CtJS9u1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfHZKBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:01:49 -0400
Received: from mail-eopbgr820040.outbound.protection.outlook.com ([40.107.82.40]:22449
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfHZKBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdVI1unku7IH4wG4llXgu1xbSOq41R63DC0zwMb87RIN/wKU3lWJZ43TyG31UeS/bXbrRfatpT/ZWawnqDP8u+4PyR6/LrvTX80hVdiijyH0wy+THPpoX8j63NzRpw8S5BSTM/F+CujRh6vc/gtgbhI5nbEsb2Hqus6XuPHXm/vYeV99V50ta42EKCZz+ExUNFXSoViC+a+RqlqTHklZb+E0CM2JlCKCa5DzjnQ45Rwqu8TJIPVDuKhloisjI1csZLDvYFQY7yy3W6B46rlBmwnmc9s2gBjKWxCkAq2XLN58NKPqqGrh+YC9/071pRpczgQo+nzGLeL9JrkEhyBQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ARWcsn/gIq4EEGLyWxwrGlWX/l4C4rWGZ9b2T9N5Yc=;
 b=GoFfiOzBtW4KcL5quyIubjfgeyZLAjHsXAKDPBVpRJsxz8y25Uhk+/LI0wSs+m2GZYdQJbMoaJ3cRlHfy/T7a/6FyX/mNtMW0iJpe0EYiHkEhwV+wMSqT3qElB1NJaRm1sD2O3umMeQQ00zLtDgtqBoYpL6sLxdj9TXKixmhrHxoI2kXvHpNMSTAWQ/ezQmPA3Bm3F7blYKEWBkoYjpk14dPHTVCtbUyaTfV1ffU621Ttcr2sqH8EisnPs22I3UeT66YUt9gO4MEdcHqhkEqBZQqStiWTtKolCeW4ybo4dLXQjk7AB3m/2WIbajiaYpIAcZg0+c/Ac2LT/Qbz25+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ARWcsn/gIq4EEGLyWxwrGlWX/l4C4rWGZ9b2T9N5Yc=;
 b=CtJS9u1D/3UVZuwHAGe1A9N0Q2HXaeXPEzWNegyeOt2Ys0WHyyEU8QkGKGAKtbO1sK1py6ZoIKRFZMh8fa3Yk8yNSgFVxdPMI8y1RcFqC42g6aNajFKpwWRQcmpVvah4MWDAYUP7xFg/PFogNAlzR8+dx8Bpc+ckklmUM1F2fu0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3589.namprd03.prod.outlook.com (52.135.213.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 10:01:43 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 10:01:43 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Topic: [PATCH 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Index: AQHVW/VDhzRa9WH15EyS2WUdGKipxA==
Date:   Mon, 26 Aug 2019 10:01:43 +0000
Message-ID: <20190826175029.433632f6@xhacker.debian>
References: <20190826174942.2b28ff05@xhacker.debian>
In-Reply-To: <20190826174942.2b28ff05@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3c9cb34-9f71-4950-d5d1-08d72a0c658b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3589;
x-ms-traffictypediagnostic: BYAPR03MB3589:
x-microsoft-antispam-prvs: <BYAPR03MB358924EE8C9400FD2ED8729FEDA10@BYAPR03MB3589.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(14454004)(81166006)(71190400001)(81156014)(71200400001)(50226002)(486006)(316002)(7736002)(52116002)(25786009)(76176011)(11346002)(5660300002)(99286004)(476003)(2906002)(446003)(86362001)(6512007)(9686003)(66066001)(305945005)(4326008)(1076003)(6486002)(478600001)(256004)(186003)(8936002)(102836004)(6116002)(6436002)(66446008)(66556008)(64756008)(66476007)(26005)(66946007)(110136005)(8676002)(6506007)(3846002)(53936002)(386003)(54906003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3589;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qJpXa1Oer44M2ilwpSkOltpmQdkEW0d0mCDFoCQYw6zHkuATF/YMtUHG9kT18X/njPxUraOinRI60KA9bzE9wRyypoI1ATFFVV1CZyNCRoC6oHoYnpiwqZoOp6FgLj5eSxh9Y6HSXmgJCH/7qFO957bLvpW8NbXgSnsU1VHAjbJWbGV1duiIFlinIHFRfe4EqT0e33GatlK/KQA1I57kEnMigNwvNltg4uj6s2i5LmDAAoc/zF1MQ+xJbHLAaqw23uJPU9JRCCHaeJPfZS4thqOT/q4+8wXF8wHHDhZaBhoLaPpUy8oyCcjJwdWL290lUBfM8P17epxA70VaAYZTe+Sbcxm+VbQ/RvBYZV81NWHBVOwzvI1iJSDynSpTgfytVjiiCT4QNwmj3dcBHxeIeONOpC/tMsJImkftONl1KPk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B58D33BCFB9C534091E21161EAC5AE6D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c9cb34-9f71-4950-d5d1-08d72a0c658b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 10:01:43.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzLRJDomTDbOODA6/OYX1YfhoKq799bcp/e3xLCKi5ILi+YIC+k+A0horHcpcaKH83g2gbdPXK0SaP1dbHWiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for Synaptics AS370 PVT sensors. Currently, only
temperature is supported.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/hwmon/Kconfig       |  10 +++
 drivers/hwmon/Makefile      |   1 +
 drivers/hwmon/as370-hwmon.c | 158 ++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/hwmon/as370-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 650dd71f9724..d31610933faa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -246,6 +246,16 @@ config SENSORS_ADT7475
 	  This driver can also be built as a module. If so, the module
 	  will be called adt7475.
=20
+config SENSORS_AS370
+	tristate "Synaptics AS370 SoC hardware monitoring driver"
+	help
+	  If you say yes here you get support for the PVT sensors of
+	  the Synaptics AS370 SoC
+
+	  This driver can also be built as a module. If so, the module
+	  will be called as370-hwmon.
+
+
 config SENSORS_ASC7621
 	tristate "Andigilog aSC7621"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8db472ea04f0..252e8a4c9781 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+=3D adt7475.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+=3D applesmc.o
 obj-$(CONFIG_SENSORS_ARM_SCMI)	+=3D scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+=3D scpi-hwmon.o
+obj-$(CONFIG_SENSORS_AS370)	+=3D as370-hwmon.o
 obj-$(CONFIG_SENSORS_ASC7621)	+=3D asc7621.o
 obj-$(CONFIG_SENSORS_ASPEED)	+=3D aspeed-pwm-tacho.o
 obj-$(CONFIG_SENSORS_ATXP1)	+=3D atxp1.o
diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
new file mode 100644
index 000000000000..98dfba45e1b0
--- /dev/null
+++ b/drivers/hwmon/as370-hwmon.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics AS370 SoC Hardware Monitoring Driver
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#define CTRL		0x0
+#define  PD		BIT(0)
+#define  EN		BIT(1)
+#define  T_SEL		BIT(2)
+#define  V_SEL		BIT(3)
+#define  NMOS_SEL	BIT(8)
+#define  PMOS_SEL	BIT(9)
+#define STS		0x4
+#define  BN_MASK	(0xfff << 0)
+#define  EOC		BIT(12)
+
+struct as370_hwmon {
+	void __iomem *base;
+};
+
+static void init_pvt(struct as370_hwmon *hwmon)
+{
+	u32 val;
+	void __iomem *addr =3D hwmon->base + CTRL;
+
+	val =3D PD;
+	writel_relaxed(val, addr);
+	val |=3D T_SEL;
+	val &=3D ~V_SEL;
+	val &=3D ~NMOS_SEL;
+	val &=3D ~PMOS_SEL;
+	writel_relaxed(val, addr);
+	val |=3D EN;
+	writel_relaxed(val, addr);
+	val &=3D ~PD;
+	writel_relaxed(val, addr);
+}
+
+static int read_pvt(struct as370_hwmon *hwmon)
+{
+	return readl_relaxed(hwmon->base + STS) & BN_MASK;
+}
+
+static int as370_hwmon_read(struct device *dev, enum hwmon_sensor_types ty=
pe,
+			    u32 attr, int channel, long *temp)
+{
+	int val;
+	struct as370_hwmon *hwmon =3D dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_input:
+		val =3D read_pvt(hwmon);
+		if (val < 0)
+			return val;
+		*temp =3D val * 251802 / 4096 - 85525;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static umode_t
+as370_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+		       u32 attr, int channel)
+{
+	if (type !=3D hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static const u32 as370_hwmon_temp_config[] =3D {
+	HWMON_T_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info as370_hwmon_temp =3D {
+	.type =3D hwmon_temp,
+	.config =3D as370_hwmon_temp_config,
+};
+
+static const struct hwmon_channel_info *as370_hwmon_info[] =3D {
+	&as370_hwmon_temp,
+	NULL
+};
+
+static const struct hwmon_ops as370_hwmon_ops =3D {
+	.is_visible =3D as370_hwmon_is_visible,
+	.read =3D as370_hwmon_read,
+};
+
+static const struct hwmon_chip_info as370_chip_info =3D {
+	.ops =3D &as370_hwmon_ops,
+	.info =3D as370_hwmon_info,
+};
+
+static int as370_hwmon_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *hwmon_dev;
+	struct as370_hwmon *hwmon;
+	struct device *dev =3D &pdev->dev;
+
+	hwmon =3D devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hwmon->base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hwmon->base))
+		return PTR_ERR(hwmon->base);
+
+	init_pvt(hwmon);
+
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev,
+							 "as370_hwmon",
+							 hwmon,
+							 &as370_chip_info,
+							 NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id as370_hwmon_match[] =3D {
+	{ .compatible =3D "syna,as370-hwmon" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, as370_hwmon_match);
+
+static struct platform_driver as370_hwmon_driver =3D {
+	.probe =3D as370_hwmon_probe,
+	.driver =3D {
+		.name =3D "as370-hwmon",
+		.of_match_table =3D as370_hwmon_match,
+	},
+};
+module_platform_driver(as370_hwmon_driver);
+
+MODULE_AUTHOR("Jisheng Zhang<jszhang@kernel.org>");
+MODULE_DESCRIPTION("Synaptics AS370 SoC hardware monitor");
+MODULE_LICENSE("GPL v2");
--=20
2.23.0.rc1

