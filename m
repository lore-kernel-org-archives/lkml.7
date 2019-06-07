Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFFA214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFGMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:42:56 -0400
Received: from olimex.com ([184.105.72.32]:45386 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfFGMmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:42:52 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 7 Jun 2019 05:42:51 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v3 2/2] mfd: rk808: Prepare rk805 for poweroff
Date:   Fri,  7 Jun 2019 15:42:26 +0300
Message-Id: <20190607124226.17694-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607124226.17694-1-stefan@olimex.com>
References: <20190607124226.17694-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK805 has SLEEP signal, which can put the device into SLEEP or OFF
mode. The default is SLEEP mode.

However, when the kernel performs power-off (actually the ATF) the
device will not go fully off and this will result in higher power
consumption and inability to wake the device with RTC alarm.

The solution is to enable pm_power_off_prepare function, which will
configure SLEEP pin for OFF function.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
Change for v3:
 - Remove useless warning messages
 - Change poweroff error messages
 - Add explanation comments
Changes for v2:
 - Move pm_pwroff_prep_fn to header
 - Check pm_power_off_prepare before make it NULL

 drivers/mfd/rk808.c       | 50 +++++++++++++++++++++++++++------------
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 46d26e141cc4..416575343b4d 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -374,17 +374,29 @@ static void rk805_device_shutdown(void)
 	int ret;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk805, so do nothing here\n");
+	if (!rk808)
 		return;
-	}
 
 	ret = regmap_update_bits(rk808->regmap,
 				 RK805_DEV_CTRL_REG,
 				 DEV_OFF, DEV_OFF);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+}
+
+static void rk805_device_shutdown_prepare(void)
+{
+	int ret;
+	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+
+	if (!rk808)
+		return;
+
+	ret = regmap_update_bits(rk808->regmap,
+				 RK805_GPIO_IO_POL_REG,
+				 SLP_SD_MSK, SHUTDOWN_FUN);
+	if (ret)
+		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
 static void rk808_device_shutdown(void)
@@ -392,17 +404,14 @@ static void rk808_device_shutdown(void)
 	int ret;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk808, so do nothing here\n");
+	if (!rk808)
 		return;
-	}
 
 	ret = regmap_update_bits(rk808->regmap,
 				 RK808_DEVCTRL_REG,
 				 DEV_OFF_RST, DEV_OFF_RST);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
 static void rk818_device_shutdown(void)
@@ -410,17 +419,14 @@ static void rk818_device_shutdown(void)
 	int ret;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk818, so do nothing here\n");
+	if (!rk808)
 		return;
-	}
 
 	ret = regmap_update_bits(rk808->regmap,
 				 RK818_DEVCTRL_REG,
 				 DEV_OFF, DEV_OFF);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
 static const struct of_device_id rk808_of_match[] = {
@@ -475,6 +481,7 @@ static int rk808_probe(struct i2c_client *client,
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
 		rk808->pm_pwroff_fn = rk805_device_shutdown;
+		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
 		break;
 	case RK808_ID:
 		rk808->regmap_cfg = &rk808_regmap_config;
@@ -550,6 +557,12 @@ static int rk808_probe(struct i2c_client *client,
 		pm_power_off = rk808->pm_pwroff_fn;
 	}
 
+	if (pm_off && !pm_power_off_prepare) {
+		if (!rk808_i2c_client)
+			rk808_i2c_client = client;
+		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
+	}
+
 	return 0;
 
 err_irq:
@@ -570,6 +583,13 @@ static int rk808_remove(struct i2c_client *client)
 	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
 		pm_power_off = NULL;
 
+	/**
+	 * As above, check if the pointer is set by us before overwrite.
+	 */
+	if (rk808->pm_pwroff_prep_fn &&
+	    pm_power_off_prepare == rk808->pm_pwroff_prep_fn)
+		pm_power_off_prepare = NULL;
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 8b5d68a7bb9c..ec928173e507 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -454,5 +454,6 @@ struct rk808 {
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
 	void				(*pm_pwroff_fn)(void);
+	void				(*pm_pwroff_prep_fn)(void);
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.17.1
