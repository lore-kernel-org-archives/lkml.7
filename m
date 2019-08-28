Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D0AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8407D233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="j5pxfVL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfH1GJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:09:30 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:29925
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1GJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i36pYYGuwflKwXCq4RfdgnE4kmJStunnvtwPDuajRUlh3lso80jGaWSot9apAI74fSx6k1OOsQncnpBLYGsCGU2L2dMQXhEcXV0J6c38plxQ+juCa83LP3Tr3ED3ncAaAsgGTeE9UX8qudr7EeT+i3hsDWsvT1VLCO/+BWVwRoC/uyqqu4B6CGIy166f2Yx8nPTnmp2cF0gAdxwUudLiDLQ0yi5gcN2LaxEqy/OgGEqeAfIo0mvflqW7dW25jF7zk3LtYFJaGaOvNUHfFpaIwFMIJQdHHN3H6EPvWlCy1oVjWG1WJKbzQVvKEkLKQpid7KzwI2IpIfT0qG9THh/3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgKMKGWdmAPnB1jAR8frxahntzRQe3qlFARAZNMYTlg=;
 b=EiucwEyIZYJ/CYrehpstVtsndiPQzgHv9q7EnAQPvFBF5PUpkR0SOuVQr5tHJrRvgoH6StPTlxbbC54Iw1716856yELQy1niRWaNH5ESM7m1Uj35HRxf+KmL/3NF9R279SsqEkae9YqRwQ0XjxAJW/d2EBrauU/9ZT5EaP1IBEHOgufWVcUN/8cgBAdkMxqZmMfWMIeLjUKeTqmurzcNhjhu3lNNKsHqE87RvEBhliwzCBIXfJvIeAlHqPGYr8ZUA6TzxmlCJaJEUzS8l4xwR2a4OR4HdvF4TtVXWNzr+zuMJz5G303LG9t3xPv3eBo5Xt3J3bL5GFkblNvHblaD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgKMKGWdmAPnB1jAR8frxahntzRQe3qlFARAZNMYTlg=;
 b=j5pxfVL4O4jpCtAr3pjxztWFzD6Zjeu/zc+zgIavL7zMEddK7Q5E3VjZ5QuILv/4YTnAyT4E3v6Q21mrRDZ+QQtnPOGe8KyjfJqntXkTCW3JOqshACjJVuAyXezSTU4ESN15rbfOMTZ6CGZ5ORu5mmRBAnhsy6JB7ZKIscIobVQ=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4487.namprd03.prod.outlook.com (20.178.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 06:09:27 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:09:26 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/8] regulator: add support for SY8824C regulator
Thread-Topic: [PATCH v2 2/8] regulator: add support for SY8824C regulator
Thread-Index: AQHVXWclp7aK1vuNHkeeeWn8nf3VJg==
Date:   Wed, 28 Aug 2019 06:09:26 +0000
Message-ID: <20190828135810.07e55ce9@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:4::16) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf25f333-3c2b-4ce8-5cf5-08d72b7e47b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4487;
x-ms-traffictypediagnostic: BYAPR03MB4487:
x-microsoft-antispam-prvs: <BYAPR03MB4487F6F27B03BA9557945298EDA30@BYAPR03MB4487.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(54906003)(66066001)(50226002)(186003)(102836004)(305945005)(8936002)(7736002)(26005)(52116002)(386003)(99286004)(8676002)(11346002)(3846002)(110136005)(81166006)(81156014)(6436002)(5660300002)(66476007)(66446008)(64756008)(66556008)(476003)(76176011)(6116002)(5024004)(2906002)(1076003)(71190400001)(486006)(14444005)(66946007)(256004)(86362001)(25786009)(4326008)(14454004)(6512007)(478600001)(6486002)(53936002)(71200400001)(446003)(6506007)(316002)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4487;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9TovRXDJtNKwVti58WERTJ0XNhEKqM+W78twmj4J+bhDM4x5ClAqQ/Re1LVbaMU4ZVU3mm2iI2NBKtipHYnswfMafU9RCCBf1/elDbb0UBymZnLCDFaVm4/LIk/dWxqOQr+UccvpgqnoQvqAjTe9stjh/48tqIWmqdZzWeMYrDD2QK2/8e3h7QgcG8KT6gV9MBKrCw2tA0D2JGFwplCtHPv6Nb19GSWiIx1VAVM8oLkjFIUvjA4D+5433wkfzQP3uvwxWVF9kh2BTYDmkmqV9+c8ZAwKq2aL3tc9h+90O6JzStDMaA/RgWTOHwnETFy0RY+/HTCuHZynliCJ+ReJXArm6rw9S7jy8KkkdribOJB0KlAaql78l8SMT9KgoTFSj3JxnW/1485kL8kYyb39h+wxGppul/X7kYHlRyCclKk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC658CE1DD63FD4480C73AC75AC563FE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf25f333-3c2b-4ce8-5cf5-08d72b7e47b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:09:26.8735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SgxGvfZkO80F1ZNC78A25Z7X9m1aS7K15rL3fibVhTax7GJexttSlvh0xmoKR2kv7+/4hT00cOZ7Lo8mqoqqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4487
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
index 000000000000..335a2cc1fc4a
--- /dev/null
+++ b/drivers/regulator/sy8824x.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// SY8824C regulator driver
+//
+// Copyright (C) 2019 Synaptics Incorporated
+// Author: Jisheng Zhang <jszhang@kernel.org>
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SY8824C_BUCK_EN		(1 << 7)
+#define SY8824C_MODE		(1 << 6)
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
+		regmap_update_bits(rdev->regmap, cfg->mode_reg,
+				   SY8824C_MODE, SY8824C_MODE);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		regmap_update_bits(rdev->regmap, cfg->mode_reg,
+				   SY8824C_MODE, 0);
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
+	if (val & SY8824C_MODE)
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
+	rdesc->enable_mask =3D SY8824C_BUCK_EN;
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

