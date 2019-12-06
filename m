Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC0DC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B693024670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQsBqJKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLFSqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44277 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id w5so3086999pjh.11;
        Fri, 06 Dec 2019 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8pAzxJiWSzLWTkMhjf7LFuYSquj8IkeZocPiiwyPjA=;
        b=KQsBqJKww9wIJwvFg/b3yL0EaiIZoK35YdLFO7U244cS+Zqo2uiiPnJNrKQZuw1dCG
         TWo2Qtssjro+Z8Xr93ozkvK7Of5o+GkBtYoOfVZFLXvPGPLWeL+oo8SG6ZN25Cihu/pV
         4EPiiMS+kxXDvLOX6V1Iheumcue78XEQ1iQfrn6YOC1VpzK3WxAUxRYDiKk6nZuyd28A
         yg/q7eSgrgrVRKTdGf+lB8E1nED3Lki39mY3BwJZdgiy7Tc/Fu/9LgbtjoUFC7CIGp90
         2ozw0jGqp7djMeTCzf7pFjhMgJCBRucJGhHv/Iqh+YsXuYrYY4BdKTX0/IBUd3iX6Mat
         tBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8pAzxJiWSzLWTkMhjf7LFuYSquj8IkeZocPiiwyPjA=;
        b=GNJICdq+u7Zjqm7k585AzmboulNP9RsKgpRKkR47w4eWGqnstkF+8umqlRdpQF4t55
         z5ZGlkgp7fzy4GnGIHlLG9QfELzgir6+Fyid3M7roT8qvqPlYCdKf3V61AlqtW6bUPrm
         ROBOzd7+jxlORxHQyNHKUyinJlUV8Vi8hrpiDyQOJki9/9zPrNib1iFcDHeQOqdCV1YB
         xJudcZZbQvcm6PBNL4wTVLDXOo0max30MjriIFPl4bIZ2qtgN5ogGLCD9cVTiOw/8dWf
         sU0kpEUt0uBySAtzbAoh4pJYQ3neRpHAABp7mhq79JC5na6gDVgAkW+wfu42aOx47n2L
         iW4w==
X-Gm-Message-State: APjAAAV2tHsQ0Yq5srRbyHovrJKQDJ5/HFfesAUdlTBJAKHtoZ0Kz8o+
        psQ+VqL/wUBoVEJUa4Ax55k=
X-Google-Smtp-Source: APXvYqzZcLwMJtzwcSHxWJGWN6EAUVCNFcYOu++yCa37tyO+1b3rjKFjqxj1edX+4F/17amIegyK9A==
X-Received: by 2002:a17:902:d708:: with SMTP id w8mr16244989ply.280.1575657980698;
        Fri, 06 Dec 2019 10:46:20 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:20 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 1/8] mfd: rk808: Refactor shutdown functions
Date:   Fri,  6 Dec 2019 18:45:29 +0000
Message-Id: <20191206184536.2507-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Schultz <d.schultz@phytec.de>

Since all shutdown functions have almost the same code, all logic
from the shutdown functions can be refactored to a new function
"rk808_update_bits", which can update a register by a given address
and bitmask and value.

link: https://lore.kernel.org/patchwork/patch/937404/
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[rebased on latest kernel]
Modified the API to set the value.
This changes were submited with below patch.
[0] https://lore.kernel.org/patchwork/patch/937404/
---
 drivers/mfd/rk808.c | 87 ++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 61 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index a69a6742ecdc..e637f5bcc8bb 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -449,81 +449,52 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 
 static struct i2c_client *rk808_i2c_client;
 
-static void rk805_device_shutdown(void)
+static void rk808_update_bits(unsigned int reg, unsigned int mask,
+		unsigned int value)
 {
-	int ret;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	int ret;
 
-	if (!rk808)
+	if (!rk808) {
+		dev_warn(&rk808_i2c_client->dev,
+			"have no rk805/rk808/rk817/rk818, so do nothing here\n");
 		return;
+	}
 
-	ret = regmap_update_bits(rk808->regmap,
-				 RK805_DEV_CTRL_REG,
-				 DEV_OFF, DEV_OFF);
+	ret = regmap_update_bits(rk808->regmap,	reg, mask, value);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+		dev_err(&rk808_i2c_client->dev,
+			"can't write to register 0x%x: %x!\n", reg, ret);
 }
 
-static void rk805_device_shutdown_prepare(void)
+static void rk805_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
+	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
+}
 
-	ret = regmap_update_bits(rk808->regmap,
-				 RK805_GPIO_IO_POL_REG,
-				 SLP_SD_MSK, SHUTDOWN_FUN);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+static void rk805_device_shutdown_prepare(void)
+{
+	rk808_update_bits(RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SHUTDOWN_FUN);
 }
 
 static void rk808_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK808_DEVCTRL_REG,
-				 DEV_OFF_RST, DEV_OFF_RST);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST, DEV_OFF_RST);
 }
 
 static void rk818_device_shutdown(void)
 {
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK818_DEVCTRL_REG,
-				 DEV_OFF, DEV_OFF);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
+	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
 }
 
 static void rk8xx_syscore_shutdown(void)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-	int ret;
 
 	if (system_state == SYSTEM_POWER_OFF &&
 	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
-		ret = regmap_update_bits(rk808->regmap,
-					 RK817_SYS_CFG(3),
-					 RK817_SLPPIN_FUNC_MSK,
-					 SLPPIN_DN_FUN);
-		if (ret) {
-			dev_warn(&rk808_i2c_client->dev,
-				 "Cannot switch to power down function\n");
-		}
+		rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK,
+				SLPPIN_DN_FUN);
 	}
 }
 
@@ -720,41 +691,35 @@ static int rk808_remove(struct i2c_client *client)
 static int __maybe_unused rk8xx_suspend(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-	int ret = 0;
 
 	switch (rk808->variant) {
 	case RK809_ID:
 	case RK817_ID:
-		ret = regmap_update_bits(rk808->regmap,
-					 RK817_SYS_CFG(3),
-					 RK817_SLPPIN_FUNC_MSK,
-					 SLPPIN_SLP_FUN);
+		rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK,
+				SLPPIN_SLP_FUN);
 		break;
 	default:
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused rk8xx_resume(struct device *dev)
 {
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-	int ret = 0;
 
 	switch (rk808->variant) {
 	case RK809_ID:
 	case RK817_ID:
-		ret = regmap_update_bits(rk808->regmap,
-					 RK817_SYS_CFG(3),
-					 RK817_SLPPIN_FUNC_MSK,
-					 SLPPIN_NULL_FUN);
+		rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK,
+				SLPPIN_NULL_FUN);
 		break;
 	default:
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
 
-- 
2.24.0

