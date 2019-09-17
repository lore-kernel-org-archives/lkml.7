Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1FCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C621881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfIQMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:43:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58501 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfIQMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:43:07 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iACow-0000dG-08; Tue, 17 Sep 2019 14:43:02 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iACov-000391-En; Tue, 17 Sep 2019 14:43:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        stwiss.opensource@diasemi.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable preparation
Date:   Tue, 17 Sep 2019 14:42:42 +0200
Message-Id: <20190917124246.11732-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917124246.11732-1-m.felsch@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
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

Currently the suspend reg_field maps to the pmic voltage selection bits
and is used during suspend_enabe/disable() and during get_mode(). This
seems to be wrong for both use cases.

Use case one (suspend_enabe/disable):
Those callbacks are used to mark a regulator device as enabled/disabled
during suspend. Marking the regulator enabled during suspend is done by
the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT registers.
Setting this bit tells the DA9062 PMIC state machine to keep the
regulator on in POWERDOWN mode and switch to suspend voltage.

Use case two (get_mode):
The get_mode callback is used to retrieve the active mode state. Since
the regulator-setting-A is used for the active state and
regulator-setting-B for the suspend state there is no need to check
which regulator setting is active.

Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/regulator/da9062-regulator.c | 118 +++++++++++----------------
 1 file changed, 47 insertions(+), 71 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..9b2ca472f70c 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -136,7 +136,6 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	unsigned int val, mode = 0;
 	int ret;
 
@@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 		return REGULATOR_MODE_NORMAL;
 	}
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	int ret, val;
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -408,10 +384,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK2,
@@ -444,10 +420,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK3,
@@ -480,10 +456,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_LDO1,
@@ -509,10 +485,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO1_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -542,10 +518,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO2_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -575,10 +551,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO3_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -608,10 +584,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO4_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -652,10 +628,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK2,
@@ -688,10 +664,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK2_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK2_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK2_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK3,
@@ -724,10 +700,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK4,
@@ -760,10 +736,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
+			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_LDO1,
@@ -789,10 +765,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO1_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
+			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -822,10 +798,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO2_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
+			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -855,10 +831,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO3_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
+			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -888,10 +864,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
 		.suspend_vsel_reg = DA9062AA_VLDO4_B,
-		.suspend = REG_FIELD(DA9062AA_DVC_1,
-			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
+		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
+			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
+			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
 		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
 			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-- 
2.20.1

