Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DEDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E9220678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0N7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:59:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39565 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK0N7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:59:39 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0005PG-JQ; Wed, 27 Nov 2019 14:59:33 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iZxqv-0008Hc-5L; Wed, 27 Nov 2019 14:59:33 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 5/5] regulator: da9062: add gpio based regulator dis-/enable support
Date:   Wed, 27 Nov 2019 14:59:32 +0100
Message-Id: <20191127135932.7223-6-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127135932.7223-1-m.felsch@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each regulator can be enabeld/disabled by the internal pmic state
machine or by a gpio input signal. Typically the OTP configures the
regulators to be enabled/disabled on a specific sequence number which is
most the time fine. Sometimes we need to reconfigure that due to a PCB
bug. This patch adds the support to disable/enable the regulator based
on a gpio input signal.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/regulator/da9062-regulator.c | 84 +++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index f545ae39352e..484b5c9a1d7e 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -52,6 +52,7 @@ struct da9062_regulator_info {
 	struct reg_field suspend_sleep;
 	unsigned int suspend_vsel_reg;
 	struct reg_field vsel_gpi;
+	struct reg_field ena_gpi;
 	/* Event detection bit */
 	struct reg_field oc_event;
 };
@@ -68,6 +69,7 @@ struct da9062_regulator {
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
 	struct regmap_field			*vsel_gpi;
+	struct regmap_field			*ena_gpi;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -413,7 +415,10 @@ static int da9062_config_gpi(struct device_node *np,
 		goto free;
 	}
 
-	ret = regmap_field_write(regl->vsel_gpi, nr);
+	if (!strncmp(gpi_id, "ena", 3))
+		ret = regmap_field_write(regl->ena_gpi, nr);
+	else
+		ret = regmap_field_write(regl->vsel_gpi, nr);
 
 free:
 	kfree(prop);
@@ -426,7 +431,13 @@ static int da9062_parse_dt(struct device_node *np,
 			   const struct regulator_desc *desc,
 			   struct regulator_config *cfg)
 {
-	return da9062_config_gpi(np, desc, cfg, "vsel");
+	int error;
+
+	error = da9062_config_gpi(np, desc, cfg, "vsel");
+	if (error)
+		return error;
+
+	return da9062_config_gpi(np, desc, cfg, "ena");
 }
 
 /* DA9061 Regulator information */
@@ -471,6 +482,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK1_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK2,
@@ -512,6 +527,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK3_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK3,
@@ -553,6 +572,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK4_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_LDO1,
@@ -587,6 +610,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO1_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -625,6 +652,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO2_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -663,6 +694,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO3_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -701,6 +736,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO4_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -750,6 +789,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK1_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK1_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK2,
@@ -791,6 +834,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK2_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK2_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK2_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK2_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK2_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK3,
@@ -832,6 +879,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK3_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK3_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK4,
@@ -873,6 +924,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VBUCK4_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_BUCK4_GPI_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_LDO1,
@@ -907,6 +962,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO1_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO1_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO1_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -945,6 +1004,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO2_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO2_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO2_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -983,6 +1046,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO3_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO3_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO3_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -1021,6 +1088,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VLDO4_GPI_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz(DA9062AA_VLDO4_GPI_MASK) - 1),
+		.ena_gpi = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_GPI_MASK) - 1,
+			sizeof(unsigned int) * 8 -
+			__builtin_clz(DA9062AA_LDO4_GPI_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -1150,6 +1221,15 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				return PTR_ERR(regl->vsel_gpi);
 		}
 
+		if (regl->info->ena_gpi.reg) {
+			regl->ena_gpi = devm_regmap_field_alloc(
+					&pdev->dev,
+					chip->regmap,
+					regl->info->ena_gpi);
+			if (IS_ERR(regl->ena_gpi))
+				return PTR_ERR(regl->ena_gpi);
+		}
+
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
 		config.dev = chip->dev;
-- 
2.20.1

