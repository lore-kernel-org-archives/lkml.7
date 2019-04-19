Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907ACC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430BD214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="dNi544Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDSA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:58:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfDSA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:58:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so1853120pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UlLWtPT1KVnXFDWHWBqj7eHHX2QR1bJps7Vij/lVN18=;
        b=dNi544DcluD68JN1rXbqvUNDBMNin+M4bdntuHEjvNeFhX+mgf9QD3U84R9kqDx9cq
         mPjAuvz2qBCbUDBP6kAkn8Bs7fogffQkJ1N2lxhMC3fU0yN+HYmGA5bmZdtXlgVQ/ecc
         snjlTiQBF8wxrKmsJ94PAfGqMKMaE6/lApRtIeyh0MBzb2Ea0JoZiy5iK1myfuyGrHzl
         +FnAdVUN0fhmhO/l7jL1Bz6W/SBLHoBxrqfCNtgvbOdV1dwR2QQXjWM7dohDXU/J3icE
         M5/Gs23/emaH6Z71peMQYTU4iSt8NoI1gpTxkr7e682PN5q9ETkh8ft7MK1Ep+a1Ex1x
         W8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlLWtPT1KVnXFDWHWBqj7eHHX2QR1bJps7Vij/lVN18=;
        b=SxvsO2+VMZnW5o/AuuAgdIU4QR+7e2eht66O3Ww86LDLAFf0YsDnvHETN1LSmtyfk7
         TJdB3WOku8OaC89kjGWgeMOdWcvsileO7pEtG+/YGsrtuUHE+Ds7XH1nn2mUsmX6tN7o
         D8Jl7za/3pHJF9QlBTwg2w7cEQGpYFu+oixIuLPrKe38nfiy8BMzUcqcoceget5T8Tub
         +TvpjoJQ+E/8VUn9H1QIxyCSyM7kAB1bMmoBzYxCLT/UWauVzmrYGO7T2OLh41ZkBl+J
         +X1xgm+adIzjxaAImmAC/arZzNgxOlTe/A/rXTOUDlsQGgeBE3h3I0jqAaKTpVCa51H6
         Mpgw==
X-Gm-Message-State: APjAAAV0kyQ5HqvNknlyaGNjKrX9BQgL8/tVVc1A/UKhoh61FDyyhapq
        plr1eC0N0Qq+aAPRGPlAHPd8Ww==
X-Google-Smtp-Source: APXvYqwWY/aAmHHtHRIp3JtqzsMkq6baV0OpWE3dW+P3qIP2YGzFGd2Mnf167m6MBC8kje6myNxu2Q==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr786297pfo.3.1555635517616;
        Thu, 18 Apr 2019 17:58:37 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id 6sm4209106pfj.95.2019.04.18.17.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 17:58:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wadim Egorov <w.egorov@phytec.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Yunfan Zhang <yfzhang@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: fan53555: Clean up unneeded fields from struct fan53555_device_info
Date:   Fri, 19 Apr 2019 08:58:23 +0800
Message-Id: <20190419005824.21533-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *regmap and *rdev can be replaced by local variables.
The slew_rate is no longer used since commit dd7e71fbeefe
("regulator: fan53555: use set_ramp_delay to set the ramp up slew rate").

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 771a06d1900d..e2caf4173ab5 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -91,10 +91,8 @@ enum {
 
 struct fan53555_device_info {
 	enum fan53555_vendor vendor;
-	struct regmap *regmap;
 	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	struct regulator_init_data *regulator;
 	/* IC Type and Rev */
 	int chip_id;
@@ -106,8 +104,6 @@ struct fan53555_device_info {
 	unsigned int vsel_min;
 	unsigned int vsel_step;
 	unsigned int vsel_count;
-	/* Voltage slew rate limiting */
-	unsigned int slew_rate;
 	/* Mode */
 	unsigned int mode_reg;
 	unsigned int mode_mask;
@@ -125,7 +121,7 @@ static int fan53555_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	ret = regulator_map_voltage_linear(rdev, uV, uV);
 	if (ret < 0)
 		return ret;
-	ret = regmap_update_bits(di->regmap, di->sleep_reg,
+	ret = regmap_update_bits(rdev->regmap, di->sleep_reg,
 				 di->desc.vsel_mask, ret);
 	if (ret < 0)
 		return ret;
@@ -140,7 +136,7 @@ static int fan53555_set_suspend_enable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(di->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_reg,
 				  VSEL_BUCK_EN, VSEL_BUCK_EN);
 }
 
@@ -148,7 +144,7 @@ static int fan53555_set_suspend_disable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(di->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_reg,
 				  VSEL_BUCK_EN, 0);
 }
 
@@ -158,11 +154,11 @@ static int fan53555_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		regmap_update_bits(di->regmap, di->mode_reg,
+		regmap_update_bits(rdev->regmap, di->mode_reg,
 				   di->mode_mask, di->mode_mask);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		regmap_update_bits(di->regmap, di->vol_reg, di->mode_mask, 0);
+		regmap_update_bits(rdev->regmap, di->vol_reg, di->mode_mask, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -176,7 +172,7 @@ static unsigned int fan53555_get_mode(struct regulator_dev *rdev)
 	unsigned int val;
 	int ret = 0;
 
-	ret = regmap_read(di->regmap, di->mode_reg, &val);
+	ret = regmap_read(rdev->regmap, di->mode_reg, &val);
 	if (ret < 0)
 		return ret;
 	if (val & di->mode_mask)
@@ -213,7 +209,7 @@ static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(di->regmap, FAN53555_CONTROL,
+	return regmap_update_bits(rdev->regmap, FAN53555_CONTROL,
 				  CTL_SLEW_MASK, regval << CTL_SLEW_SHIFT);
 }
 
@@ -396,6 +392,7 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 			struct regulator_config *config)
 {
 	struct regulator_desc *rdesc = &di->desc;
+	struct regulator_dev *rdev;
 
 	rdesc->name = "fan53555-reg";
 	rdesc->supply_name = "vin";
@@ -410,8 +407,8 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->vsel_mask = di->vsel_count - 1;
 	rdesc->owner = THIS_MODULE;
 
-	di->rdev = devm_regulator_register(di->dev, &di->desc, config);
-	return PTR_ERR_OR_ZERO(di->rdev);
+	rdev = devm_regulator_register(di->dev, &di->desc, config);
+	return PTR_ERR_OR_ZERO(rdev);
 }
 
 static const struct regmap_config fan53555_regmap_config = {
@@ -466,6 +463,7 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 	struct fan53555_device_info *di;
 	struct fan53555_platform_data *pdata;
 	struct regulator_config config = { };
+	struct regmap *regmap;
 	unsigned int val;
 	int ret;
 
@@ -502,22 +500,22 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 		di->vendor = id->driver_data;
 	}
 
-	di->regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
-	if (IS_ERR(di->regmap)) {
+	regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
+	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to allocate regmap!\n");
-		return PTR_ERR(di->regmap);
+		return PTR_ERR(regmap);
 	}
 	di->dev = &client->dev;
 	i2c_set_clientdata(client, di);
 	/* Get chip ID */
-	ret = regmap_read(di->regmap, FAN53555_ID1, &val);
+	ret = regmap_read(regmap, FAN53555_ID1, &val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to get chip ID!\n");
 		return ret;
 	}
 	di->chip_id = val & DIE_ID;
 	/* Get chip revision */
-	ret = regmap_read(di->regmap, FAN53555_ID2, &val);
+	ret = regmap_read(regmap, FAN53555_ID2, &val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to get chip Rev!\n");
 		return ret;
@@ -534,7 +532,7 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 	/* Register regulator */
 	config.dev = di->dev;
 	config.init_data = di->regulator;
-	config.regmap = di->regmap;
+	config.regmap = regmap;
 	config.driver_data = di;
 	config.of_node = np;
 
-- 
2.17.1

