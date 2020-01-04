Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE4C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B260321734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgADPdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:33:51 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:44126 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgADPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:33:48 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1inlQt-0000zw-7h; Sat, 04 Jan 2020 16:33:43 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from roc-pc (p508F384D.dip0.t-ipconnect.de [80.143.56.77])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 004FXgjv009230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Jan 2020 16:33:42 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] regulator: mp8859: add driver
Date:   Sat,  4 Jan 2020 16:32:45 +0100
Message-Id: <20200104153321.6584-2-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200104153321.6584-1-m.reichl@fivetechno.de>
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578152027;4063e63e;
X-HE-SMSGID: 1inlQt-0000zw-7h
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MP8859 from Monolithic Power Systems is a single output DC/DC
converter. The voltage can be controlled via I2C.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 drivers/regulator/mp8859.c | 156 +++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 drivers/regulator/mp8859.c

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
new file mode 100644
index 000000000000..e804a5267301
--- /dev/null
+++ b/drivers/regulator/mp8859.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2019 five technologies GmbH
+// Author: Markus Reichl <m.reichl@fivetechno.de>
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regmap.h>
+
+
+#define VOL_MIN_IDX			0x00
+#define VOL_MAX_IDX			0x7ff
+
+/* Register definitions */
+#define MP8859_VOUT_L_REG		0    //3 lo Bits
+#define MP8859_VOUT_H_REG		1    //8 hi Bits
+#define MP8859_VOUT_GO_REG		2
+#define MP8859_IOUT_LIM_REG		3
+#define MP8859_CTL1_REG			4
+#define MP8859_CTL2_REG			5
+#define MP8859_RESERVED1_REG		6
+#define MP8859_RESERVED2_REG		7
+#define MP8859_RESERVED3_REG		8
+#define MP8859_STATUS_REG		9
+#define MP8859_INTERRUPT_REG		0x0A
+#define MP8859_MASK_REG			0x0B
+#define MP8859_ID1_REG			0x0C
+#define MP8859_MFR_ID_REG		0x27
+#define MP8859_DEV_ID_REG		0x28
+#define MP8859_IC_REV_REG		0x29
+
+#define MP8859_MAX_REG			0x29
+
+#define MP8859_GO_BIT			0x01
+
+
+static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+
+	ret = regmap_write(rdev->regmap, MP8859_VOUT_L_REG, sel & 0x7);
+
+	if (ret)
+		return ret;
+	ret = regmap_write(rdev->regmap, MP8859_VOUT_H_REG, sel >> 3);
+
+	if (ret)
+		return ret;
+	ret = regmap_update_bits(rdev->regmap, MP8859_VOUT_GO_REG,
+					MP8859_GO_BIT, 1);
+	return ret;
+}
+
+static int mp8859_get_voltage_sel(struct regulator_dev *rdev)
+{
+	unsigned int val_tmp;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MP8859_VOUT_H_REG, &val_tmp);
+
+	if (ret)
+		return ret;
+	val = val_tmp << 3;
+
+	ret = regmap_read(rdev->regmap, MP8859_VOUT_L_REG, &val_tmp);
+
+	if (ret)
+		return ret;
+	val |= val_tmp & 0x07;
+	return val;
+}
+
+static const struct regulator_linear_range mp8859_dcdc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, VOL_MIN_IDX, VOL_MAX_IDX, 10000),
+};
+
+static const struct regmap_config mp8859_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MP8859_MAX_REG,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct regulator_ops mp8859_ops = {
+	.set_voltage_sel = mp8859_set_voltage_sel,
+	.get_voltage_sel = mp8859_get_voltage_sel,
+	.list_voltage = regulator_list_voltage_linear_range,
+};
+
+static const struct regulator_desc mp8859_regulators[] = {
+	{
+		.id = 0,
+		.type = REGULATOR_VOLTAGE,
+		.name = "mp8859_dcdc",
+		.of_match = of_match_ptr("mp8859_dcdc"),
+		.n_voltages = VOL_MAX_IDX + 1,
+		.linear_ranges = mp8859_dcdc_ranges,
+		.n_linear_ranges = 1,
+		.ops = &mp8859_ops,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int mp8859_i2c_probe(struct i2c_client *i2c)
+{
+	int ret;
+	struct regulator_config config = {.dev = &i2c->dev};
+	struct regmap *regmap = devm_regmap_init_i2c(i2c, &mp8859_regmap);
+	struct regulator_dev *rdev;
+
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+	rdev = devm_regulator_register(&i2c->dev, &mp8859_regulators[0],
+					&config);
+
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(&i2c->dev, "failed to register %s: %d\n",
+			mp8859_regulators[0].name, ret);
+			return ret;
+		}
+	return 0;
+}
+
+static const struct of_device_id mp8859_dt_id[] = {
+	{.compatible =  "mps,mp8859"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mp8859_dt_id);
+
+static const struct i2c_device_id mp8859_i2c_id[] = {
+	{ "mp8859", },
+	{  },
+};
+MODULE_DEVICE_TABLE(i2c, mp8859_i2c_id);
+
+static struct i2c_driver mp8859_regulator_driver = {
+	.driver = {
+		.name = "mp8859",
+		.of_match_table = of_match_ptr(mp8859_dt_id),
+	},
+	.probe_new = mp8859_i2c_probe,
+	.id_table = mp8859_i2c_id,
+};
+
+module_i2c_driver(mp8859_regulator_driver);
+
+MODULE_DESCRIPTION("Monolithic Power Systems MP8859 voltage regulator driver");
+MODULE_AUTHOR("Markus Reichl <m.reichl@fivetechno.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.1

