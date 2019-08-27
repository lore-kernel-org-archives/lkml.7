Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D84C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884A52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GDNWdtf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfH0DoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:44:18 -0400
Received: from mail-eopbgr730049.outbound.protection.outlook.com ([40.107.73.49]:13872
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbfH0DoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVm5+dKyTwqvtnsZ64rF5an/nUuwH34uTyQeonk2xIwse8EgXwo+si4EefFyyKfMeSvV/gmYQiyMKPUDgCA53VYtZJUGIl5NuTHde7pp1lRomBLjXd2kNTKmLcAKpAJuIPulE3AmfyevoC4kK9T9II+3/c0dP1A9BcGUc4ocrNPpz8ILwPDNJ4/GwP06Dl7WDiNsR0TmdisiyysRCB1Jln/x14u5C5MSSzqYKtqir9lxy4mNT8uWQSbfPAIUX4zglLJXwG2d1q3BFgRitNHascXg7a5AUstsONg0wTdDjTbJKXASCzF5xLoKqkySVEzNIRYGx82Y9Yd1rSsBrzansg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKz+Aikrr/VI5iNxAwD9hJUURcVXhnLdz+fPy6XfA/Q=;
 b=WW59hHHx/wAGaDVI0tBhQ8NBwwcGHxcIUcudInFHan7xlySgjMy5UApJy9fnJq4w4xn+cB0NwwyJ7itxCJ+tAZLdekMz9FTR9+N9/z/7s8DW8hONxFQTgsyvH5yX4NBTf2UXM/UT2r1UmbadWJznOgMxIMg4XPPoswbhecWqkEN+rVVOJ8PtBOe4XvewsM53HDAk5KRR3pDbWuMsY1UsX+mUZ6gTUoO6eAu8ZYtEqNFaLW2R4tXMHF9kjXGN8d+uuw+4MIGFkRinmqL7s3vLdEHhQPa63TCBtfZMeORw1DL/43BfPBwss33GPZa8xaebDuxRfMt4d7nLxRnZ/cyDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKz+Aikrr/VI5iNxAwD9hJUURcVXhnLdz+fPy6XfA/Q=;
 b=GDNWdtf06bzgM9HmDCtv9R0z4OLKpVu8A2IRwCbV2BE2a01y3jwRHSsgm4MYvtmD37Rgb0ANjLEmetGYl1ltsnKY41JN7ZzyLFgb0IaO0zI5+VaC6q6/dL6YEaFeZzeMe142RxIV4bcmVlEdNXs2AYvRcJHPTzMfmawwoELzwY4=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3621.namprd03.prod.outlook.com (52.135.215.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 03:44:15 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 03:44:15 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Topic: [PATCH v2 1/2] hwmon: Add Synaptics AS370 PVT sensor driver
Thread-Index: AQHVXImy/vXMF/O8qUenDQAqhrxEjg==
Date:   Tue, 27 Aug 2019 03:44:15 +0000
Message-ID: <20190827113259.4fb64a17@xhacker.debian>
References: <20190827113214.13773d45@xhacker.debian>
In-Reply-To: <20190827113214.13773d45@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5daa0151-f896-434e-0899-08d72aa0d4e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3621;
x-ms-traffictypediagnostic: BYAPR03MB3621:
x-microsoft-antispam-prvs: <BYAPR03MB362199D1DA316B598A6D41C6EDA00@BYAPR03MB3621.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(6436002)(102836004)(476003)(26005)(186003)(1076003)(478600001)(386003)(305945005)(2906002)(8676002)(9686003)(8936002)(66066001)(446003)(6486002)(486006)(81156014)(11346002)(7736002)(256004)(71200400001)(5660300002)(81166006)(14454004)(52116002)(86362001)(53936002)(110136005)(54906003)(76176011)(66946007)(3846002)(6116002)(66446008)(66476007)(64756008)(66556008)(71190400001)(99286004)(25786009)(6506007)(4326008)(316002)(6512007)(50226002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3621;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxMh2kIFqcHLz7QCRXIEwIg1j18UGAJGAwFokcpCqn6AOZ+1hJ7FDVJp36Xt8H+CzQxVkkalhH0bS/6jHH0gXt289YgKxm+OSkKTiYLB6I13VZnS3fX0e/8zoClKnhEOeE3Ch52j3JO3PVjTBAD27p6N5wRPIg80v+J6zeY7rJYseXZyZ1alH7cMFvaeAZ6FqYSg/IAYB1tnFQGaqNzf0rOijKpHR7J0in+ZMJifW7JCKzHuUElgtV27QngzDAyVjOo2mloQh+uh+GRxCktDZ3xyKMMDnUbK0tcIstz+2TKjRQdQHkqjp3kqsWhLn5HR11mLsOyyPsLIx+Zdac2GaRY4Bn+IPwg/jirxt26EUWFJYonBcSbSTGzLfq0yyVhvIxRfc/0/N0ggzdqIuZyd5jELWPgG5xrIlkEHB8QtsBo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <535A8AF4762D13478597ABBB834FFA0C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daa0151-f896-434e-0899-08d72aa0d4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 03:44:15.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7JlFkBZQO+O1DUSwosyzeLKT/pQlkKDm/l7KaJ2yZ/9O7HmonUBj7hEdo9hSEtKDpz1WmXrodfzHP+Z/rGWGEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3621
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
 drivers/hwmon/as370-hwmon.c | 147 ++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
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
index 000000000000..554f03b91bfe
--- /dev/null
+++ b/drivers/hwmon/as370-hwmon.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics AS370 SoC Hardware Monitoring Driver
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/bitops.h>
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
+#define  BN_MASK	GENMASK(11, 0)
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
+	writel_relaxed(val, addr);
+	val |=3D EN;
+	writel_relaxed(val, addr);
+	val &=3D ~PD;
+	writel_relaxed(val, addr);
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
+		val =3D readl_relaxed(hwmon->base + STS) & BN_MASK;
+		*temp =3D DIV_ROUND_CLOSEST(val * 251802, 4096) - 85525;
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
+							 "as370",
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

