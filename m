Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1DC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E225218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Mal3AfZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfB1NlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46737 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1NlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so9737756pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qbt1GrP2h2tIpdfGu6AGObhXiJawZKuHHC/4co7nvb4=;
        b=Mal3AfZdmdXYcpK2+OxGM+yIMr7NxxbCedjVmogId//dU1pxZw0yNrIkIb6SHV9fEd
         ESGw3AE6Pc9JHJd7nzchhfb+YXVYYxCGADusj78XW0jFyPE0lcU+fXJbpuZPq7DAND9I
         9LWltcdmOJ0cRVqycaKgxXcI+SADs7Majt665jNEVDh5yFa/0d8m2jh1rjyUBXtOjGjm
         AwCSsJ0dh6gFGX6cSliNXp+6K930W3Oeg2qEUZnzBnd9WhHi4X3N5YLzZdUwkGA+Be0F
         mqUW46cE0RKHqaNMux2QfhEkelvwiqtyiq5fG1UiyY1udPbfrwiMTasAOMR9GaK4BfIY
         PJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qbt1GrP2h2tIpdfGu6AGObhXiJawZKuHHC/4co7nvb4=;
        b=Qs4qIFtdeTLPACG5CU9JR1nIyptmoyY3ZqAu0wEHALN0C2HBQXt33GXo2hAfoQlMpB
         RBzuzhmdSiMyiSCVRuEpzLWYUfws7S9mYuMl8k53VTzn46hQui6qfrP+OkI/S6j/XRh0
         MKcZyV/3HRPmwbaQeXaJhIQiyFVVEsiCNRr08C6Alsjbc/qmx+C9Y3dyR3DNhGgjFYrw
         aZB6xbwRWfDBoe3dZmyPXFUj1S/eFtyYqbnPgNcEBX0gwpeSBNVpe9jiWr0GVeBhRgVu
         wU+u6/VtB2rUMq/JLZE3/ejQV7CB16oND/n5G6KsicWV63uEfdh0PznDh4MmIMNHyC0w
         fkEQ==
X-Gm-Message-State: AHQUAuZuPYVcfKx39s3Hv9szBXsJvZlDnVn6M2b68m8zf+QsOVLaNriB
        rMRglxm7BMRIOr2QAXcrWG14jA==
X-Google-Smtp-Source: AHgI3IbCkBivTFW6AGDMc6XvOPh9A9+Ga/EMTvhVkK3uK7oPIhPdZ/YPZuhl5b8nYFnLCrfUQ3gjgg==
X-Received: by 2002:a65:4784:: with SMTP id e4mr8424129pgs.12.1551361274063;
        Thu, 28 Feb 2019 05:41:14 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:13 -0800 (PST)
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
Subject: [PATCH 07/11] regulator: max77650: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:18 +0800
Message-Id: <20190228134022.32625-8-axel.lin@ingics.com>
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
 drivers/regulator/max77650-regulator.c | 74 +++++++++-----------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index a1af414db751..31ebf34b01ec 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -26,9 +26,6 @@
 #define MAX77650_REGULATOR_AD_ENABLED		BIT(3)
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
-#define MAX77650_REGULATOR_CURR_LIM_BITS(_reg) \
-		(((_reg) & MAX77650_REGULATOR_CURR_LIM_MASK) >> 6)
-#define MAX77650_REGULATOR_CURR_LIM_SHIFT(_val)	((_val) << 6)
 
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
@@ -82,7 +79,7 @@ static const u32 max77651_sbb1_regulator_volt_table[] = {
 		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
 	} while (0)
 
-static const int max77650_current_limit_table[] = {
+static const unsigned int max77650_current_limit_table[] = {
 	1000000, 866000, 707000, 500000,
 };
 
@@ -220,47 +217,6 @@ static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-static int max77650_regulator_get_current_limit(struct regulator_dev *rdev)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-	int val, rv, limit;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	rv = regmap_read(map, rdesc->regA, &val);
-	if (rv)
-		return rv;
-
-	limit = MAX77650_REGULATOR_CURR_LIM_BITS(val);
-
-	return max77650_current_limit_table[limit];
-}
-
-static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
-						int min_uA, int max_uA)
-{
-	struct max77650_regulator_desc *rdesc;
-	struct regmap *map;
-	int i, limit;
-
-	rdesc = rdev_get_drvdata(rdev);
-	map = rdev_get_regmap(rdev);
-
-	for (i = 0; i < ARRAY_SIZE(max77650_current_limit_table); i++) {
-		limit = max77650_current_limit_table[i];
-
-		if (limit >= min_uA && limit <= max_uA) {
-			return regmap_update_bits(map, rdesc->regA,
-					MAX77650_REGULATOR_CURR_LIM_MASK,
-					MAX77650_REGULATOR_CURR_LIM_SHIFT(i));
-		}
-	}
-
-	return -EINVAL;
-}
-
 static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
@@ -280,8 +236,8 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
-	.get_current_limit	= max77650_regulator_get_current_limit,
-	.set_current_limit	= max77650_regulator_set_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -293,8 +249,8 @@ static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
-	.get_current_limit	= max77650_regulator_get_current_limit,
-	.set_current_limit	= max77650_regulator_set_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -343,6 +299,10 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB0_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB0_A,
 	.regB		= MAX77650_REG_CNFG_SBB0_B,
@@ -368,6 +328,10 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -392,6 +356,10 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -417,6 +385,10 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
@@ -442,6 +414,10 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
 		.owner			= THIS_MODULE,
+		.csel_reg		= MAX77650_REG_CNFG_SBB2_A,
+		.csel_mask		= MAX77650_REGULATOR_CURR_LIM_MASK,
+		.curr_table		= max77650_current_limit_table,
+		.n_current_limits = ARRAY_SIZE(max77650_current_limit_table),
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
-- 
2.17.1

