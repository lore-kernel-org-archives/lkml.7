Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E92171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0xz/rqkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfB1Nk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:40:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34370 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfB1Nk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:40:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so9796448plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln8GO4brHYR4ubNSWLkCcHdbPzz8XDjeNg4WSxm7Rcw=;
        b=0xz/rqkV7ToW9nlSMZaPVqtPgwh6wyYb8Tb/W7JHcQCQRWdziR8jF7WJgoUkRjtWxA
         u19BsD2Zs8aBcz7/v4ccgDGJdpSXHBhQgxkj5PFIQw0Vlg6OiSBPaJ++zhAvzr8lTODS
         CdfhvWvAeLB0lAe0UALkh9zTtalVEuXGEMcnRQjNlWZX0iFvkOrMSb0r5xWtMam53hBm
         B30pOXNwGVdQZFIMob6lvQZsC0WGRtXanoR9u1DYBMNiHehaogQjmdWI0YDgIlaX6SpF
         mcQv20U6PURIuljHuiJNYuqixF7f5efk45GUzMyu9Cw697vUjUVVo7WwB5Q2+vLu5QY0
         sARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln8GO4brHYR4ubNSWLkCcHdbPzz8XDjeNg4WSxm7Rcw=;
        b=T7bDFHob5ZyD1bSlxu83wBbi2jb8TM+d+cuJA4QlSYK0E4jmim/+vkqo5bzHRiAqi2
         6kQl6AxBCfORsa7vlbsegqOXJNzfTOGpUKapzaDiPuyM3IA2IEu6xLRb07C/eTIBz6Zy
         yzVmm4bsQbOBTvXWVlkTmXNDp0QXw7CdsyTuyLoqqW6PMpNPGMdTIwmH3TDojKiuAz/p
         mUx/MTv2NpOhCGAYzZ4tcjz3k+MUAsns+kkgxpXeELGUKm8uEj1/mbxbjzK9Za5sR5Aa
         iD+62ibf3Prx0wkqNdDrJjeB6w8Mj40BiCErfVcpUYKAmhg3wvSo3bvCiLkmshLIV8ZS
         hT0Q==
X-Gm-Message-State: AHQUAuanxyng6+TboIv/AtRZoxI+lAICyl3wrw9nGeDEky30R4VwipT7
        LfnmbaTr49CcDlyv33hQWsN+FA==
X-Google-Smtp-Source: AHgI3Ib2go1z/22N0ZKlfAWzEYtrwYauPdeZAdkTaXBetwVFsP04tKEgHwoKA212q1cZQXypPUX/gA==
X-Received: by 2002:a17:902:505:: with SMTP id 5mr8202911plf.337.1551361256202;
        Thu, 28 Feb 2019 05:40:56 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:40:55 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 03/11] regulator: da9055: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:14 +0800
Message-Id: <20190228134022.32625-4-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9055-regulator.c | 45 ++++++----------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 417cafe2aba0..3c6fac793658 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -48,7 +48,9 @@
 #define DA9055_ID_LDO6		7
 
 /* DA9055 BUCK current limit */
-static const int da9055_current_limits[] = { 500000, 600000, 700000, 800000 };
+static const unsigned int da9055_current_limits[] = {
+	500000, 600000, 700000, 800000
+};
 
 struct da9055_conf_reg {
 	int reg;
@@ -169,39 +171,6 @@ static int da9055_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
 				 val << volt.sl_shift);
 }
 
-static int da9055_buck_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9055_regulator_info *info = regulator->info;
-	int ret;
-
-	ret = da9055_reg_read(regulator->da9055, DA9055_REG_BUCK_LIM);
-	if (ret < 0)
-		return ret;
-
-	ret &= info->mode.mask;
-	return da9055_current_limits[ret >> info->mode.shift];
-}
-
-static int da9055_buck_set_current_limit(struct regulator_dev *rdev, int min_uA,
-					 int max_uA)
-{
-	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9055_regulator_info *info = regulator->info;
-	int i;
-
-	for (i = ARRAY_SIZE(da9055_current_limits) - 1; i >= 0; i--) {
-		if ((min_uA <= da9055_current_limits[i]) &&
-		    (da9055_current_limits[i] <= max_uA))
-			return da9055_reg_update(regulator->da9055,
-						 DA9055_REG_BUCK_LIM,
-						 info->mode.mask,
-						 i << info->mode.shift);
-	}
-
-	return -EINVAL;
-}
-
 static int da9055_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct da9055_regulator *regulator = rdev_get_drvdata(rdev);
@@ -329,8 +298,8 @@ static const struct regulator_ops da9055_buck_ops = {
 	.get_mode = da9055_buck_get_mode,
 	.set_mode = da9055_buck_set_mode,
 
-	.get_current_limit = da9055_buck_get_current_limit,
-	.set_current_limit = da9055_buck_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 
 	.get_voltage_sel = da9055_regulator_get_voltage_sel,
 	.set_voltage_sel = da9055_regulator_set_voltage_sel,
@@ -407,6 +376,10 @@ static const struct regulator_ops da9055_ldo_ops = {
 		.uV_step = (step) * 1000,\
 		.linear_min_sel = (voffset),\
 		.owner = THIS_MODULE,\
+		.curr_table = da9055_current_limits,\
+		.n_current_limits = ARRAY_SIZE(da9055_current_limits),\
+		.csel_reg = DA9055_REG_BUCK_LIM,\
+		.csel_mask = (mbits),\
 	},\
 	.conf = {\
 		.reg = DA9055_REG_BCORE_CONT + DA9055_ID_##_id, \
-- 
2.17.1

