Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F0C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7131421537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055756;
	bh=uEWMFYio0WY05yLNxWgzEXOwSUlRF13te6Ozn/Tepk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0Y00Ah8Duis9ky0sxVQY7J5JP7JOFttZo9tosJqrlKOqLOzKt6vp1pNylsYV6lRe
	 y/ErWZNvGOKvnkVBqtgT8JFu9UPK1aWfriuDVWdEcSqglPThLPPItk0r5IspFCIGhK
	 eo7lEKW3xouc7AhMTV42xIMT9NGccJVJr3IHJdLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfFTSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfFTSfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:35:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02FC206BF;
        Thu, 20 Jun 2019 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561055752;
        bh=uEWMFYio0WY05yLNxWgzEXOwSUlRF13te6Ozn/Tepk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDNdM/KdMqP8pQh9GL/7yCz0dPylR8hmSdQDNCf9ywNG37WKngYp/UbZN9nA0rgPb
         rr/QR+KkQvLmvqwOvAM1gaqXWcllG4OWDluYqi5/T2BOi7y3iqKO8Os0qNZZv6p9ME
         E8vbBMb8Dc4jCUjAgjd8MZFfUv/J56gSLvPhcNsQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 3/6] regulator: s2mps11: Add support for disabling S2MPS11 regulators in suspend
Date:   Thu, 20 Jun 2019 20:35:27 +0200
Message-Id: <20190620183530.5386-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620183530.5386-1-krzk@kernel.org>
References: <20190620183530.5386-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supported turning off regulators in suspend only for S2MPS14
device.  However this makes also sense for S2MPS11 and can reduce the
power consumption during suspend to RAM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mps11.c         | 210 +++++++++++++++-------------
 include/linux/mfd/samsung/s2mps11.h |   5 +
 2 files changed, 120 insertions(+), 95 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index da3a746e65dc..6a83960822d4 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -34,7 +34,7 @@ struct s2mps11_info {
 	enum sec_device_type dev_type;
 
 	/*
-	 * One bit for each S2MPS13/S2MPS14/S2MPU02 regulator whether
+	 * One bit for each S2MPS11/S2MPS13/S2MPS14/S2MPU02 regulator whether
 	 * the suspend mode was enabled.
 	 */
 	DECLARE_BITMAP(suspend_state, S2MPS_REGULATOR_MAX);
@@ -225,27 +225,133 @@ static int s2mps11_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  1 << enable_shift, 0);
 }
 
+static int s2mps11_regulator_enable(struct regulator_dev *rdev)
+{
+	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
+	int rdev_id = rdev_get_id(rdev);
+	unsigned int val;
+
+	switch (s2mps11->dev_type) {
+	case S2MPS11X:
+		if (test_bit(rdev_id, s2mps11->suspend_state))
+			val = S2MPS14_ENABLE_SUSPEND;
+		else
+			val = rdev->desc->enable_mask;
+		break;
+	case S2MPS13X:
+	case S2MPS14X:
+		if (test_bit(rdev_id, s2mps11->suspend_state))
+			val = S2MPS14_ENABLE_SUSPEND;
+		else if (s2mps11->ext_control_gpiod[rdev_id])
+			val = S2MPS14_ENABLE_EXT_CONTROL;
+		else
+			val = rdev->desc->enable_mask;
+		break;
+	case S2MPU02:
+		if (test_bit(rdev_id, s2mps11->suspend_state))
+			val = S2MPU02_ENABLE_SUSPEND;
+		else
+			val = rdev->desc->enable_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+			rdev->desc->enable_mask, val);
+}
+
+static int s2mps11_regulator_set_suspend_disable(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val, state;
+	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
+	int rdev_id = rdev_get_id(rdev);
+
+	/* Below LDO should be always on or does not support suspend mode. */
+	switch (s2mps11->dev_type) {
+	case S2MPS11X:
+		switch (rdev_id) {
+		case S2MPS11_LDO2:
+		case S2MPS11_LDO36:
+		case S2MPS11_LDO37:
+		case S2MPS11_LDO38:
+			return 0;
+		default:
+			state = S2MPS14_ENABLE_SUSPEND;
+			break;
+		}
+		break;
+	case S2MPS13X:
+	case S2MPS14X:
+		switch (rdev_id) {
+		case S2MPS14_LDO3:
+			return 0;
+		default:
+			state = S2MPS14_ENABLE_SUSPEND;
+			break;
+		}
+		break;
+	case S2MPU02:
+		switch (rdev_id) {
+		case S2MPU02_LDO13:
+		case S2MPU02_LDO14:
+		case S2MPU02_LDO15:
+		case S2MPU02_LDO17:
+		case S2MPU02_BUCK7:
+			state = S2MPU02_DISABLE_SUSPEND;
+			break;
+		default:
+			state = S2MPU02_ENABLE_SUSPEND;
+			break;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(rdev->regmap, rdev->desc->enable_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	set_bit(rdev_id, s2mps11->suspend_state);
+	/*
+	 * Don't enable suspend mode if regulator is already disabled because
+	 * this would effectively for a short time turn on the regulator after
+	 * resuming.
+	 * However we still want to toggle the suspend_state bit for regulator
+	 * in case if it got enabled before suspending the system.
+	 */
+	if (!(val & rdev->desc->enable_mask))
+		return 0;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				  rdev->desc->enable_mask, state);
+}
+
 static const struct regulator_ops s2mps11_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
+	.enable			= s2mps11_regulator_enable,
 	.disable		= regulator_disable_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+	.set_suspend_disable	= s2mps11_regulator_set_suspend_disable,
 };
 
 static const struct regulator_ops s2mps11_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= regulator_enable_regmap,
+	.enable			= s2mps11_regulator_enable,
 	.disable		= regulator_disable_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= s2mps11_regulator_set_voltage_time_sel,
 	.set_ramp_delay		= s2mps11_set_ramp_delay,
+	.set_suspend_disable	= s2mps11_regulator_set_suspend_disable,
 };
 
 #define regulator_desc_s2mps11_ldo(num, step) {		\
@@ -501,102 +607,16 @@ static const struct regulator_desc s2mps13_regulators[] = {
 	regulator_desc_s2mps13_buck8_10(10, MIN_500_MV,  STEP_6_25_MV, 0x10),
 };
 
-static int s2mps14_regulator_enable(struct regulator_dev *rdev)
-{
-	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
-	int rdev_id = rdev_get_id(rdev);
-	unsigned int val;
-
-	switch (s2mps11->dev_type) {
-	case S2MPS13X:
-	case S2MPS14X:
-		if (test_bit(rdev_id, s2mps11->suspend_state))
-			val = S2MPS14_ENABLE_SUSPEND;
-		else if (s2mps11->ext_control_gpiod[rdev_id])
-			val = S2MPS14_ENABLE_EXT_CONTROL;
-		else
-			val = rdev->desc->enable_mask;
-		break;
-	case S2MPU02:
-		if (test_bit(rdev_id, s2mps11->suspend_state))
-			val = S2MPU02_ENABLE_SUSPEND;
-		else
-			val = rdev->desc->enable_mask;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-			rdev->desc->enable_mask, val);
-}
-
-static int s2mps14_regulator_set_suspend_disable(struct regulator_dev *rdev)
-{
-	int ret;
-	unsigned int val, state;
-	struct s2mps11_info *s2mps11 = rdev_get_drvdata(rdev);
-	int rdev_id = rdev_get_id(rdev);
-
-	/* Below LDO should be always on or does not support suspend mode. */
-	switch (s2mps11->dev_type) {
-	case S2MPS13X:
-	case S2MPS14X:
-		switch (rdev_id) {
-		case S2MPS14_LDO3:
-			return 0;
-		default:
-			state = S2MPS14_ENABLE_SUSPEND;
-			break;
-		}
-		break;
-	case S2MPU02:
-		switch (rdev_id) {
-		case S2MPU02_LDO13:
-		case S2MPU02_LDO14:
-		case S2MPU02_LDO15:
-		case S2MPU02_LDO17:
-		case S2MPU02_BUCK7:
-			state = S2MPU02_DISABLE_SUSPEND;
-			break;
-		default:
-			state = S2MPU02_ENABLE_SUSPEND;
-			break;
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = regmap_read(rdev->regmap, rdev->desc->enable_reg, &val);
-	if (ret < 0)
-		return ret;
-
-	set_bit(rdev_id, s2mps11->suspend_state);
-	/*
-	 * Don't enable suspend mode if regulator is already disabled because
-	 * this would effectively for a short time turn on the regulator after
-	 * resuming.
-	 * However we still want to toggle the suspend_state bit for regulator
-	 * in case if it got enabled before suspending the system.
-	 */
-	if (!(val & rdev->desc->enable_mask))
-		return 0;
-
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
-			rdev->desc->enable_mask, state);
-}
-
 static const struct regulator_ops s2mps14_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= s2mps14_regulator_enable,
+	.enable			= s2mps11_regulator_enable,
 	.disable		= regulator_disable_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_suspend_disable	= s2mps14_regulator_set_suspend_disable,
+	.set_suspend_disable	= s2mps11_regulator_set_suspend_disable,
 };
 
 #define regulator_desc_s2mps14_ldo(num, min, step) {	\
@@ -889,24 +909,24 @@ static const struct regulator_ops s2mpu02_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= s2mps14_regulator_enable,
+	.enable			= s2mps11_regulator_enable,
 	.disable		= regulator_disable_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_suspend_disable	= s2mps14_regulator_set_suspend_disable,
+	.set_suspend_disable	= s2mps11_regulator_set_suspend_disable,
 };
 
 static const struct regulator_ops s2mpu02_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.enable			= s2mps14_regulator_enable,
+	.enable			= s2mps11_regulator_enable,
 	.disable		= regulator_disable_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_suspend_disable	= s2mps14_regulator_set_suspend_disable,
+	.set_suspend_disable	= s2mps11_regulator_set_suspend_disable,
 	.set_ramp_delay		= s2mpu02_set_ramp_delay,
 };
 
diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index 6e7668a389a1..f6c035eb87be 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -188,4 +188,9 @@ enum s2mps11_regulators {
 #define S2MPS11_BUCK6_RAMP_EN_SHIFT	0
 #define S2MPS11_PMIC_EN_SHIFT	6
 
+/*
+ * Bits for "enable suspend" (On/Off controlled by PWREN)
+ * are the same as in S2MPS14: S2MPS14_ENABLE_SUSPEND
+ */
+
 #endif /*  __LINUX_MFD_S2MPS11_H */
-- 
2.17.1

