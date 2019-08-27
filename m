Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42001C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026072184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DwP7zStc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfH0IsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:48:12 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:13475
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0IsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2xPMLa+QyKz8h6D4PcX7/gXBD7ow7haVI6Bk2+KzI+jc/FykhTpHucA5oXy6sZLlhG24T5WbSp7rqw0Q5/31Ak5ncjMdItFPpcACihmG9ARMr0tqv/FfjrgHF7uaj+YSlEvmgHQIwuUV2yRByfvSQkVwD5rb+9XwGwfbzgzEr5BdPbavKndpfyBj4TDkHpa0FkvSjAws+mBq9ndQgHv2DTMElFYTWldJ3nSTi65FIMV17Y7tL8Ge2O8Z5FxuDIoRauZfar9rWDmAi9Z+YTpVQJcVFMbvXj9thVEcsqNhWBxPm/oNA5V8XKizxOm28eJeNNNrqjb7km4wPjOeBK1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc8Ac38aF34cEJSpqph0fbATF4EWg/ZBlApKDnis3IM=;
 b=Mo6lmP9prJAEJ3T9TGC0S4EhfVfXOhZzBAzTg3cWo5Xod5vcr2ELPwIVLg98BM5ZHnM4JCuQdn7mSyLEq+tn3QllWp63gCv/EIqUdEQRSIxWQu0So26j4rddn4bEFjk2lwj7c6B3+iCg1a9MeWdxCTaxbx5b/MeM05zRxhwq5oZxZ3LH8R3pcno45FMPu9vM/p19ZtLDlxBoirMcyij4Zd5MpLOU1RLdAkvFCdowOSSu2osJNGZETwg3gaqOVp6yZ3tOcXFSuWg1IV7EtPzWZbZ35nh5bNhyPCANZLvPpu/clbrvp/i0byQNI+iFxo4LdnFLIqJ4oPoX2Rqnaav+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc8Ac38aF34cEJSpqph0fbATF4EWg/ZBlApKDnis3IM=;
 b=DwP7zStc+lgHkzyjvl3qRHEBfcmkvP/MOsUze9zoV+es0CVOtz4o7rNvo+RtBKBrX70231GP4doXEPFG2qRHeDhdK0JYapgzz8RLDZTba2CdzgJCMX5xFD5rb7QcmASkb5LhMQWaYzcCWwqD0y3z91U/GhysyyOnE+StNwpbX9I=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4135.namprd03.prod.outlook.com (20.177.184.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Tue, 27 Aug 2019 08:45:33 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:45:33 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Topic: [PATCH 2/8] regulator: add support for SY8824C regulator
Thread-Index: AQHVXLPJEFafB224QUapDDwu+1xRqA==
Date:   Tue, 27 Aug 2019 08:45:33 +0000
Message-ID: <20190827163418.1a32fc48@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:404:29::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a091a118-6f77-4b0b-3631-08d72acaec40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4135;
x-ms-traffictypediagnostic: BYAPR03MB4135:
x-microsoft-antispam-prvs: <BYAPR03MB4135446DC9B0CAE41AAAE4BAEDA00@BYAPR03MB4135.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(316002)(386003)(2906002)(186003)(50226002)(4326008)(53936002)(25786009)(446003)(8936002)(6512007)(305945005)(9686003)(11346002)(6506007)(26005)(66066001)(14454004)(66446008)(52116002)(476003)(478600001)(99286004)(7736002)(81156014)(6486002)(102836004)(6436002)(66556008)(64756008)(54906003)(81166006)(5660300002)(86362001)(8676002)(5024004)(3846002)(256004)(14444005)(6116002)(71190400001)(76176011)(486006)(71200400001)(66946007)(1076003)(66476007)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4135;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0++YVyWDga9N7HKTdmguuYLsPijbkqHgazzTjjuH77lE7NMOCHBkgdG4VwevORm+mxeLyuCH4S/jFTuRjJb0grGnrjiYU9mwVt14kEZsi5FFfDnBP+uq0u7KfvIHhwE3km6fCS2Vg+xuMj3rRclrVA+bF4jVQ+Tsfcnz8xb0BFTc0bP8d9c+/kqEtQmDvIJUowX5AAd/dp57ZMkKffw92TjY/OZr8rtQqHEkAjLa7z9Zojm3OW/7VtyMKoRclWVXzK1sKpv57ykq7n3o03q2m//c5hYDNFi2JOnPjz95Dsaf9P5c24DPstEzgkd/yMS7+OhjWprgQKd1LNCybEtg7w+Gkj29ol7FiX5VeDfA1J+d/O3Y225xR/pBVfoA/AgF9JgpC/F01ZZ/M6SAeYTU5Eh5NTC6zRARJxn3mn5kgbI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22CDAC869B941D468C6D90BB0FD699A0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a091a118-6f77-4b0b-3631-08d72acaec40
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:45:33.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jN2xCXvs7LbUMaWTL7a+K+qygWw8nXvZPg7SngrMHmH3ZFSO9nxS9WDifP5vkNMMTEc7OirwmLjvEzbJ+xQcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY8824C is an I2C attached single output regulator made by Silergy Corp,
which is used on several Synaptics berlin platforms to control the
power supply of the ARM cores.

Add a driver for it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/Kconfig   |   7 ++
 drivers/regulator/Makefile  |   1 +
 drivers/regulator/sy8824x.c | 192 ++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/regulator/sy8824x.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b57093d7c01f..e8093a909e85 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -906,6 +906,13 @@ config REGULATOR_SY8106A
 	help
 	  This driver supports SY8106A single output regulator.
=20
+config REGULATOR_SY8824X
+	tristate "Silergy SY8824C regulator"
+	depends on I2C && (OF || COMPILE_TEST)
+	select REGMAP_I2C
+	help
+	  This driver supports SY8824C single output regulator.
+
 config REGULATOR_TPS51632
 	tristate "TI TPS51632 Power Regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index eef73b5a35a4..922bf975070f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_REGULATOR_STM32_PWR) +=3D stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) +=3D stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) +=3D stw481x-vmmc.o
 obj-$(CONFIG_REGULATOR_SY8106A) +=3D sy8106a-regulator.o
+obj-$(CONFIG_REGULATOR_SY8824X) +=3D sy8824x.o
 obj-$(CONFIG_REGULATOR_TI_ABB) +=3D ti-abb-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6105X) +=3D tps6105x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS62360) +=3D tps62360-regulator.o
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
new file mode 100644
index 000000000000..2d8a61ca6643
--- /dev/null
+++ b/drivers/regulator/sy8824x.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SY8824C regulator driver
+ *
+ * Copyright (C) 2019 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define BUCK_EN		(1 << 7)
+#define MODE		(1 << 6)
+
+struct sy8824_config {
+	/* registers */
+	unsigned int vol_reg;
+	unsigned int mode_reg;
+	unsigned int enable_reg;
+	/* Voltage range and step(linear) */
+	unsigned int vsel_min;
+	unsigned int vsel_step;
+	unsigned int vsel_count;
+};
+
+struct sy8824_device_info {
+	struct device *dev;
+	struct regulator_desc desc;
+	struct regulator_init_data *regulator;
+	const struct sy8824_config *cfg;
+};
+
+static int sy8824_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct sy8824_device_info *di =3D rdev_get_drvdata(rdev);
+	const struct sy8824_config *cfg =3D di->cfg;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		regmap_update_bits(rdev->regmap, cfg->mode_reg, MODE, MODE);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		regmap_update_bits(rdev->regmap, cfg->mode_reg, MODE, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static unsigned int sy8824_get_mode(struct regulator_dev *rdev)
+{
+	struct sy8824_device_info *di =3D rdev_get_drvdata(rdev);
+	const struct sy8824_config *cfg =3D di->cfg;
+	u32 val;
+	int ret =3D 0;
+
+	ret =3D regmap_read(rdev->regmap, cfg->mode_reg, &val);
+	if (ret < 0)
+		return ret;
+	if (val & MODE)
+		return REGULATOR_MODE_FAST;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops sy8824_regulator_ops =3D {
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
+	.map_voltage =3D regulator_map_voltage_linear,
+	.list_voltage =3D regulator_list_voltage_linear,
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.set_mode =3D sy8824_set_mode,
+	.get_mode =3D sy8824_get_mode,
+};
+
+static int sy8824_regulator_register(struct sy8824_device_info *di,
+			struct regulator_config *config)
+{
+	struct regulator_desc *rdesc =3D &di->desc;
+	const struct sy8824_config *cfg =3D di->cfg;
+	struct regulator_dev *rdev;
+
+	rdesc->name =3D "sy8824-reg";
+	rdesc->supply_name =3D "vin";
+	rdesc->ops =3D &sy8824_regulator_ops;
+	rdesc->type =3D REGULATOR_VOLTAGE;
+	rdesc->n_voltages =3D cfg->vsel_count;
+	rdesc->enable_reg =3D cfg->enable_reg;
+	rdesc->enable_mask =3D BUCK_EN;
+	rdesc->min_uV =3D cfg->vsel_min;
+	rdesc->uV_step =3D cfg->vsel_step;
+	rdesc->vsel_reg =3D cfg->vol_reg;
+	rdesc->vsel_mask =3D cfg->vsel_count - 1;
+	rdesc->owner =3D THIS_MODULE;
+
+	rdev =3D devm_regulator_register(di->dev, &di->desc, config);
+	return PTR_ERR_OR_ZERO(rdev);
+}
+
+static const struct regmap_config sy8824_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+};
+
+static int sy8824_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct device *dev =3D &client->dev;
+	struct device_node *np =3D dev->of_node;
+	struct sy8824_device_info *di;
+	struct regulator_config config =3D { };
+	struct regmap *regmap;
+	int ret;
+
+	di =3D devm_kzalloc(dev, sizeof(struct sy8824_device_info), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->regulator =3D of_get_regulator_init_data(dev, np, &di->desc);
+	if (!di->regulator) {
+		dev_err(dev, "Platform data not found!\n");
+		return -EINVAL;
+	}
+
+	di->dev =3D dev;
+	di->cfg =3D of_device_get_match_data(dev);
+
+	regmap =3D devm_regmap_init_i2c(client, &sy8824_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+	i2c_set_clientdata(client, di);
+
+	config.dev =3D di->dev;
+	config.init_data =3D di->regulator;
+	config.regmap =3D regmap;
+	config.driver_data =3D di;
+	config.of_node =3D np;
+
+	ret =3D sy8824_regulator_register(di, &config);
+	if (ret < 0)
+		dev_err(dev, "Failed to register regulator!\n");
+	return ret;
+}
+
+static const struct sy8824_config sy8824c_cfg =3D {
+	.vol_reg =3D 0x00,
+	.mode_reg =3D 0x00,
+	.enable_reg =3D 0x00,
+	.vsel_min =3D 762500,
+	.vsel_step =3D 12500,
+	.vsel_count =3D 64,
+};
+
+static const struct of_device_id sy8824_dt_ids[] =3D {
+	{
+		.compatible =3D "silergy,sy8824c",
+		.data =3D &sy8824c_cfg
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
+
+static const struct i2c_device_id sy8824_id[] =3D {
+	{ "sy8824", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sy8824_id);
+
+static struct i2c_driver sy8824_regulator_driver =3D {
+	.driver =3D {
+		.name =3D "sy8824-regulator",
+		.of_match_table =3D of_match_ptr(sy8824_dt_ids),
+	},
+	.probe =3D sy8824_i2c_probe,
+	.id_table =3D sy8824_id,
+};
+module_i2c_driver(sy8824_regulator_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("SY8824C regulator driver");
+MODULE_LICENSE("GPL v2");
--=20
2.23.0.rc1

