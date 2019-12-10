Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E24C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D7220838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfLJNYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:34 -0500
Received: from foss.arm.com ([217.140.110.172]:44318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfLJNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A411045;
        Tue, 10 Dec 2019 05:24:31 -0800 (PST)
Received: from DESKTOP-VLO843J.cambridge.arm.com (DESKTOP-VLO843J.cambridge.arm.com [10.1.26.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DD263F52E;
        Tue, 10 Dec 2019 05:24:30 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, smoch@web.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
Subject: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
Date:   Tue, 10 Dec 2019 13:24:33 +0000
Message-Id: <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575932654.git.robin.murphy@arm.com>
References: <cover.1575932654.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK817,
so it makes little sense for the driver to have to have two completely
different mechanisms to handle essentially the same thing. Bring RK805
in line with the RK809/RK817 flow to clean things up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c       | 58 +++++++++++++++++----------------------
 include/linux/mfd/rk808.h |  1 -
 2 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 657b8baa3b8a..e88bdb889d3a 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -186,7 +186,6 @@ static const struct rk808_reg_data rk805_pre_init_reg[] = {
 	{RK805_BUCK4_CONFIG_REG, RK805_BUCK3_4_ILMAX_MASK,
 				 RK805_BUCK4_ILMAX_3500MA},
 	{RK805_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK, BUCK_ILMIN_400MA},
-	{RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SLEEP_FUN},
 	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
 };
 
@@ -449,21 +448,6 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 
 static struct i2c_client *rk808_i2c_client;
 
-static void rk805_device_shutdown_prepare(void)
-{
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK805_GPIO_IO_POL_REG,
-				 SLP_SD_MSK, SHUTDOWN_FUN);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
-}
-
 static void rk808_device_shutdown(void)
 {
 	int ret;
@@ -499,17 +483,29 @@ static void rk8xx_syscore_shutdown(void)
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 	int ret;
 
-	if (system_state == SYSTEM_POWER_OFF &&
-	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
+	if (system_state != SYSTEM_POWER_OFF)
+	       return;
+
+	switch (rk808->variant) {
+	case RK805_ID:
+		ret = regmap_update_bits(rk808->regmap,
+					 RK805_GPIO_IO_POL_REG,
+					 SLP_SD_MSK,
+					 SHUTDOWN_FUN);
+		break;
+	case RK809_ID:
+	case RK817_ID:
 		ret = regmap_update_bits(rk808->regmap,
 					 RK817_SYS_CFG(3),
 					 RK817_SLPPIN_FUNC_MSK,
 					 SLPPIN_DN_FUN);
-		if (ret) {
-			dev_warn(&rk808_i2c_client->dev,
-				 "Cannot switch to power down function\n");
-		}
+		break;
+	default:
+		return;
 	}
+	if (ret)
+		dev_warn(&rk808_i2c_client->dev,
+			 "Cannot switch to power down function\n");
 }
 
 static struct syscore_ops rk808_syscore_ops = {
@@ -579,7 +575,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
-		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -658,10 +653,8 @@ static int rk808_probe(struct i2c_client *client,
 		goto err_irq;
 	}
 
-	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
+	if (of_property_read_bool(np, "rockchip,system-power-controller"))
 		pm_power_off = rk808_device_shutdown;
-		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
-	}
 
 	return 0;
 
@@ -686,13 +679,6 @@ static int rk808_remove(struct i2c_client *client)
 	if (pm_power_off == rk808_device_shutdown)
 		pm_power_off = NULL;
 
-	/**
-	 * As above, check if the pointer is set by us before overwrite.
-	 */
-	if (rk808->pm_pwroff_prep_fn &&
-	    pm_power_off_prepare == rk808->pm_pwroff_prep_fn)
-		pm_power_off_prepare = NULL;
-
 	return 0;
 }
 
@@ -702,6 +688,12 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
 	int ret = 0;
 
 	switch (rk808->variant) {
+	case RK805_ID:
+		ret = regmap_update_bits(rk808->regmap,
+					 RK805_GPIO_IO_POL_REG,
+					 SLP_SD_MSK,
+					 SLEEP_FUN);
+		break;
 	case RK809_ID:
 	case RK817_ID:
 		ret = regmap_update_bits(rk808->regmap,
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index b038653fa87e..e07f6e61cd38 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -620,6 +620,5 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
-	void				(*pm_pwroff_prep_fn)(void);
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.17.1

