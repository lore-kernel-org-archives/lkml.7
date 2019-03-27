Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C54B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="BiLLiHTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfC0BaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:30:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46421 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfC0BaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:30:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so2491302pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CDbm01/NbPOUGekO7QlvZQTNiDEoDl+lxY2QAE1KQ4g=;
        b=BiLLiHTdF9hTV5OfQLvqJmV/7NZogzKV1nV1r4ZzLwkC2w3VCoLfulB/bQ6IvaZKV6
         jNDjas+pwQhFSbb/DGpdR/k7XCj3kMXA9rnAyR1tFoWu0kC/OitIdGgazFeOqmlyvNDj
         CGeSi0hF29IgkkjafASoshLG9ibxVSJnl0KrTL0T5CWSGKG/Ez119YfgVR2gi8P9KrAD
         ZOThyQbF8WT0oR8dyJIupPRkJ+girfbnZjPw4fGuKj3gRZhta3W9tJZkF/0QfRkw5aPH
         E9C6voFyf7lXyQIM9JrufB6uVANZ88hni/xGfb+lh+lAnNgw6bSCotsYSFqvtGcgICN+
         Xfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CDbm01/NbPOUGekO7QlvZQTNiDEoDl+lxY2QAE1KQ4g=;
        b=mVUF2/X8wmNtWPXeRwTpBX/bYpOUPRSF+MwJ9TSO1O+qmR2vmlANOjlgMr5aSGAyD3
         15WnZjSwkmiHEKVWhmV6G4maF9OzCZaqzugRjV1pLQMyghfvOefgymV1vGg5MxSmg9jA
         a+dumFDccpgpT0ZYT+l86WqnvQI7uzaqLNzWC0KZ7eqGrZjis0YAy1dzlJaZR/2JLdAs
         nVovyNicMOCKmHyoEc68Qn/WmNQw2VaHqfGQtpIHlvtofYJwIi8rBpH8njibfyeyVJJQ
         wBIKnMgxmpou6U38H9kV0p4U58lkOiP5g0ITtr06XoTgJfmT5BboeTaHSKcZko52vcy8
         ZaDQ==
X-Gm-Message-State: APjAAAWoX18g6jObjf5QeSQFTJZCCnizu5AXezVT2WyvuFPyhhgiDefT
        T0nIjcLfOcZf9sLwlaGQCzcfKCMQBEA=
X-Google-Smtp-Source: APXvYqxJp+6kGmUnz9fQ0/9bsjD2tN0F6+Rq1XqSqt+pwe+IXNcwbqo2MeGQqSasxUWzqgKZ/5iWuA==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr33907384plt.195.1553650200066;
        Tue, 26 Mar 2019 18:30:00 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id i31sm31158195pgi.36.2019.03.26.18.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:29:59 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Florian Lobmaier <florian.lobmaier@ams.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Vince Hsu <vinceh@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: as3722: Convert to use regulator_set/get_current_limit_regmap
Date:   Wed, 27 Mar 2019 09:29:46 +0800
Message-Id: <20190327012947.6029-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/as3722-regulator.c | 212 ++++++++-------------------
 1 file changed, 60 insertions(+), 152 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 7a315adbe6c4..4dda77417300 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -313,63 +313,10 @@ static const struct as3722_register_mapping as3722_reg_lookup[] = {
 	},
 };
 
-
-static const int as3722_ldo_current[] = { 150000, 300000 };
-static const int as3722_sd016_current[] = { 2500000, 3000000, 3500000 };
-
-static int as3722_current_to_index(int min_uA, int max_uA,
-		const int *curr_table, int n_currents)
-{
-	int i;
-
-	for (i = n_currents - 1; i >= 0; i--) {
-		if ((min_uA <= curr_table[i]) && (curr_table[i] <= max_uA))
-			return i;
-	}
-	return -EINVAL;
-}
-
-static int as3722_ldo_get_current_limit(struct regulator_dev *rdev)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	u32 val;
-	int ret;
-
-	ret = as3722_read(as3722, as3722_reg_lookup[id].vsel_reg, &val);
-	if (ret < 0) {
-		dev_err(as3722_regs->dev, "Reg 0x%02x read failed: %d\n",
-			as3722_reg_lookup[id].vsel_reg, ret);
-		return ret;
-	}
-	if (val & AS3722_LDO_ILIMIT_MASK)
-		return 300000;
-	return 150000;
-}
-
-static int as3722_ldo_set_current_limit(struct regulator_dev *rdev,
-		int min_uA, int max_uA)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	int ret;
-	u32 reg = 0;
-
-	ret = as3722_current_to_index(min_uA, max_uA, as3722_ldo_current,
-				ARRAY_SIZE(as3722_ldo_current));
-	if (ret < 0) {
-		dev_err(as3722_regs->dev,
-			"Current range min:max = %d:%d does not support\n",
-			min_uA, max_uA);
-		return ret;
-	}
-	if (ret)
-		reg = AS3722_LDO_ILIMIT_BIT;
-	return as3722_update_bits(as3722, as3722_reg_lookup[id].vsel_reg,
-			AS3722_LDO_ILIMIT_MASK, reg);
-}
+static const unsigned int as3722_ldo_current[] = { 150000, 300000 };
+static const unsigned int as3722_sd016_current[] = {
+	2500000, 3000000, 3500000
+};
 
 static const struct regulator_ops as3722_ldo0_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
@@ -378,16 +325,16 @@ static const struct regulator_ops as3722_ldo0_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static const struct regulator_ops as3722_ldo0_extcntrl_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static int as3722_ldo3_set_tracking_mode(struct as3722_regulators *as3722_reg,
@@ -439,8 +386,8 @@ static const struct regulator_ops as3722_ldo6_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
@@ -450,8 +397,8 @@ static const struct regulator_ops as3722_ldo6_extcntrl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
@@ -470,8 +417,8 @@ static const struct regulator_ops as3722_ldo_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static const struct regulator_ops as3722_ldo_extcntrl_ops = {
@@ -479,8 +426,8 @@ static const struct regulator_ops as3722_ldo_extcntrl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear_range,
-	.get_current_limit = as3722_ldo_get_current_limit,
-	.set_current_limit = as3722_ldo_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static unsigned int as3722_sd_get_mode(struct regulator_dev *rdev)
@@ -538,85 +485,6 @@ static int as3722_sd_set_mode(struct regulator_dev *rdev,
 	return ret;
 }
 
-static int as3722_sd016_get_current_limit(struct regulator_dev *rdev)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	u32 val, reg;
-	int mask;
-	int ret;
-
-	switch (id) {
-	case AS3722_REGULATOR_ID_SD0:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD0_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD1:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD1_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD6:
-		reg = AS3722_OVCURRENT_DEB_REG;
-		mask = AS3722_OVCURRENT_SD6_TRIP_MASK;
-		break;
-	default:
-		return -EINVAL;
-	}
-	ret = as3722_read(as3722, reg, &val);
-	if (ret < 0) {
-		dev_err(as3722_regs->dev, "Reg 0x%02x read failed: %d\n",
-			reg, ret);
-		return ret;
-	}
-	val &= mask;
-	val >>= ffs(mask) - 1;
-	if (val == 3)
-		return -EINVAL;
-	return as3722_sd016_current[val];
-}
-
-static int as3722_sd016_set_current_limit(struct regulator_dev *rdev,
-		int min_uA, int max_uA)
-{
-	struct as3722_regulators *as3722_regs = rdev_get_drvdata(rdev);
-	struct as3722 *as3722 = as3722_regs->as3722;
-	int id = rdev_get_id(rdev);
-	int ret;
-	int val;
-	int mask;
-	u32 reg;
-
-	ret = as3722_current_to_index(min_uA, max_uA, as3722_sd016_current,
-				ARRAY_SIZE(as3722_sd016_current));
-	if (ret < 0) {
-		dev_err(as3722_regs->dev,
-			"Current range min:max = %d:%d does not support\n",
-			min_uA, max_uA);
-		return ret;
-	}
-
-	switch (id) {
-	case AS3722_REGULATOR_ID_SD0:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD0_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD1:
-		reg = AS3722_OVCURRENT_REG;
-		mask = AS3722_OVCURRENT_SD1_TRIP_MASK;
-		break;
-	case AS3722_REGULATOR_ID_SD6:
-		reg = AS3722_OVCURRENT_DEB_REG;
-		mask = AS3722_OVCURRENT_SD6_TRIP_MASK;
-		break;
-	default:
-		return -EINVAL;
-	}
-	ret <<= ffs(mask) - 1;
-	val = ret & mask;
-	return as3722_update_bits(as3722, reg, mask, val);
-}
-
 static bool as3722_sd0_is_low_voltage(struct as3722_regulators *as3722_regs)
 {
 	int err;
@@ -648,8 +516,8 @@ static const struct regulator_ops as3722_sd016_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_sd016_get_current_limit,
-	.set_current_limit = as3722_sd016_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_mode = as3722_sd_get_mode,
 	.set_mode = as3722_sd_set_mode,
 };
@@ -659,8 +527,8 @@ static const struct regulator_ops as3722_sd016_extcntrl_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_current_limit = as3722_sd016_get_current_limit,
-	.set_current_limit = as3722_sd016_set_current_limit,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 	.get_mode = as3722_sd_get_mode,
 	.set_mode = as3722_sd_set_mode,
 };
@@ -832,6 +700,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].uV_step = 25000;
 			as3722_regs->desc[id].linear_min_sel = 1;
 			as3722_regs->desc[id].enable_time = 500;
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+				as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+				AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_LDO3:
 			if (reg_config->ext_control)
@@ -870,6 +745,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
 			as3722_regs->desc[id].n_linear_ranges =
 						ARRAY_SIZE(as3722_ldo_ranges);
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+				as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+				AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_SD0:
 		case AS3722_REGULATOR_ID_SD1:
@@ -891,6 +773,25 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].uV_step = 10000;
 			as3722_regs->desc[id].linear_min_sel = 1;
 			as3722_regs->desc[id].enable_time = 600;
+			as3722_regs->desc[id].curr_table = as3722_sd016_current;
+			as3722_regs->desc[id].n_current_limits =
+				ARRAY_SIZE(as3722_sd016_current);
+			if (id == AS3722_REGULATOR_ID_SD0) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD0_TRIP_MASK;
+			} else if (id == AS3722_REGULATOR_ID_SD1) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD1_TRIP_MASK;
+			} else if (id == AS3722_REGULATOR_ID_SD6) {
+				as3722_regs->desc[id].csel_reg =
+					AS3722_OVCURRENT_DEB_REG;
+				as3722_regs->desc[id].csel_mask =
+					AS3722_OVCURRENT_SD6_TRIP_MASK;
+			}
 			break;
 		case AS3722_REGULATOR_ID_SD2:
 		case AS3722_REGULATOR_ID_SD3:
@@ -914,6 +815,13 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
 			as3722_regs->desc[id].n_linear_ranges =
 						ARRAY_SIZE(as3722_ldo_ranges);
+			as3722_regs->desc[id].curr_table = as3722_ldo_current;
+			as3722_regs->desc[id].n_current_limits =
+						ARRAY_SIZE(as3722_ldo_current);
+			as3722_regs->desc[id].csel_reg =
+						as3722_reg_lookup[id].vsel_reg;
+			as3722_regs->desc[id].csel_mask =
+						AS3722_LDO_ILIMIT_MASK;
 			break;
 		}
 		as3722_regs->desc[id].ops = ops;
-- 
2.17.1

