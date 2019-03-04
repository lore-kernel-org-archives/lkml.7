Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B383A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="d6zhVoUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCDNQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:16:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37282 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCDNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:16:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so3015719pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Lk0lozmpSr6PhGIcaMsKSY28zfWmmH4+w3MioZAgWWU=;
        b=d6zhVoUydFbkEaddPp7k12nE0MWBo602H0+5LbHQqB4BhBoVkZ/rc3Xnzfi4gpAmmG
         wfbIz8GXpQsdWBJunfUXypR008bmoVKlPNej0RxGMMjNkl/KcCtHD4wRNYh0tcokvY8i
         UcU67zhUP8pD/Fhyu0UD3H9fdHlCs7x8yXXPH3POPq4RHBF47kNg5Vw3OksTJ2RqxAqJ
         WfVQ1FB2TqxttzoAO5Vbzg4jeHe7dQ414NpgFTXU7kMa3N63iXhOqc3Hh0Chkhtx+zIz
         N9IL49bZxN57HIN6+VR45fLXMUtDl2rM8rbFKYPYJk7/2Z26yJ2ysjE7wF5NeHwLDSkH
         rgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lk0lozmpSr6PhGIcaMsKSY28zfWmmH4+w3MioZAgWWU=;
        b=cAbI/A5K/w/wV8a070kAOVf4nsZA0cvReqGRTw5rJ509t1caa5yPNJ426ZxXphzI8i
         /+ePR6uOuo8xQomqlGw5sChkvI87g9o9bjAb3VJ5t0bIrHTo10H9v2AWgjQODgTcGv9i
         oyL7DRs6H1iqufcJdKcoD4ZkaGjTLc7tjNZxIdHVmkFH2Q+kyPSVR9nvz0WmX3FM55M+
         GFDaAaqxKfmHIurENbxwvPghQbvWvruGaZ0ZxAN5AaoPSkSn7hGq4y74Yy0l/x6HAdzy
         bNvwSOb1DTd/ZIwKei5Te0wZQ8tHvOWsfuPbGw8rUr0ufRpXgZah6vPlzkRZLXWOcj2E
         LfYw==
X-Gm-Message-State: APjAAAXLOhIrJ3D9dUd6B11IFH+g23ht1Wdmcv6PL1+IqMn8cnXdPGrA
        sGuvuufIDvjBkSUWoaxfnhSFqA==
X-Google-Smtp-Source: APXvYqy+I+TSE9uHx3Ct+aCjAO9YrZpyr9e4cm1JvsjdDIAXle/J8h7j7obIzepCUqf41xPAPzatSw==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr20279424plb.258.1551705378845;
        Mon, 04 Mar 2019 05:16:18 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id j1sm6956774pgp.84.2019.03.04.05.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:16:17 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9062: Convert to use regulator_set/get_current_limit_regmap
Date:   Mon,  4 Mar 2019 21:16:02 +0800
Message-Id: <20190304131603.15730-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 125 +++++++--------------------
 1 file changed, 32 insertions(+), 93 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index b064d8a19d4c..ad0facb2be6a 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -53,16 +53,12 @@ enum {
 /* Regulator capabilities and registers description */
 struct da9062_regulator_info {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned int n_current_limits;
-	const int *current_limits;
 	/* Main register fields */
 	struct reg_field mode;
 	struct reg_field suspend;
 	struct reg_field sleep;
 	struct reg_field suspend_sleep;
 	unsigned int suspend_vsel_reg;
-	struct reg_field ilimit;
 	/* Event detection bit */
 	struct reg_field oc_event;
 };
@@ -78,7 +74,6 @@ struct da9062_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
-	struct regmap_field			*ilimit;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -104,7 +99,7 @@ enum {
  * - DA9062_ID_[BUCK1|BUCK2|BUCK4]
  * Entry indexes corresponds to register values.
  */
-static const int da9062_buck_a_limits[] = {
+static const unsigned int da9062_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
@@ -114,44 +109,11 @@ static const int da9062_buck_a_limits[] = {
  * - DA9062_ID_BUCK3
  * Entry indexes corresponds to register values.
  */
-static const int da9062_buck_b_limits[] = {
+static const unsigned int da9062_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
-static int da9062_set_current_limit(struct regulator_dev *rdev,
-				    int min_ua, int max_ua)
-{
-	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9062_regulator_info *rinfo = regl->info;
-	int n, tval;
-
-	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
-		tval = rinfo->current_limits[n];
-		if (tval >= min_ua && tval <= max_ua)
-			return regmap_field_write(regl->ilimit, n);
-	}
-
-	return -EINVAL;
-}
-
-static int da9062_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9062_regulator_info *rinfo = regl->info;
-	unsigned int sel;
-	int ret;
-
-	ret = regmap_field_read(regl->ilimit, &sel);
-	if (ret < 0)
-		return ret;
-
-	if (sel >= rinfo->n_current_limits)
-		sel = rinfo->n_current_limits - 1;
-
-	return rinfo->current_limits[sel];
-}
-
 static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
@@ -395,8 +357,8 @@ static const struct regulator_ops da9062_buck_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= da9062_set_current_limit,
-	.get_current_limit	= da9062_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_mode		= da9062_buck_set_mode,
 	.get_mode		= da9062_buck_get_mode,
 	.get_status		= da9062_buck_get_status,
@@ -433,8 +395,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK1_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK1_CONT,
 		.desc.enable_mask = DA9062AA_BUCK1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
@@ -457,10 +421,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK1_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK1_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK2,
@@ -471,8 +431,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (800) * 1000,
 		.desc.uV_step = (20) * 1000,
 		.desc.n_voltages = ((3340) - (800))/(20) + 1,
-		.current_limits = da9062_buck_b_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.curr_table = da9062_buck_b_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_A,
+		.desc.csel_mask = DA9062AA_BUCK3_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK3_CONT,
 		.desc.enable_mask = DA9062AA_BUCK3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
@@ -495,10 +457,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_A,
-			__builtin_ffs((int)DA9062AA_BUCK3_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK3_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_BUCK3,
@@ -509,8 +467,10 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 		.desc.min_uV = (530) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1800) - (530))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_B,
+		.desc.csel_mask = DA9062AA_BUCK4_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK4_CONT,
 		.desc.enable_mask = DA9062AA_BUCK4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
@@ -533,10 +493,6 @@ static const struct da9062_regulator_info local_da9061_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_B,
-			__builtin_ffs((int)DA9062AA_BUCK4_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK4_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9061_ID_LDO1,
@@ -679,8 +635,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK1_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK1_CONT,
 		.desc.enable_mask = DA9062AA_BUCK1_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
@@ -703,10 +661,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK1_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK1_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK2,
@@ -717,8 +671,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (300) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1570) - (300))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_C,
+		.desc.csel_mask = DA9062AA_BUCK2_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK2_CONT,
 		.desc.enable_mask = DA9062AA_BUCK2_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK2_A,
@@ -741,10 +697,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_C,
-			__builtin_ffs((int)DA9062AA_BUCK2_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK2_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK3,
@@ -755,8 +707,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (800) * 1000,
 		.desc.uV_step = (20) * 1000,
 		.desc.n_voltages = ((3340) - (800))/(20) + 1,
-		.current_limits = da9062_buck_b_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.curr_table = da9062_buck_b_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_b_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_A,
+		.desc.csel_mask = DA9062AA_BUCK3_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK3_CONT,
 		.desc.enable_mask = DA9062AA_BUCK3_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
@@ -779,10 +733,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_A,
-			__builtin_ffs((int)DA9062AA_BUCK3_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK3_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_BUCK4,
@@ -793,8 +743,10 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.min_uV = (530) * 1000,
 		.desc.uV_step = (10) * 1000,
 		.desc.n_voltages = ((1800) - (530))/(10) + 1,
-		.current_limits = da9062_buck_a_limits,
-		.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.curr_table = da9062_buck_a_limits,
+		.desc.n_current_limits = ARRAY_SIZE(da9062_buck_a_limits),
+		.desc.csel_reg = DA9062AA_BUCK_ILIM_B,
+		.desc.csel_mask = DA9062AA_BUCK4_ILIM_MASK,
 		.desc.enable_reg = DA9062AA_BUCK4_CONT,
 		.desc.enable_mask = DA9062AA_BUCK4_EN_MASK,
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
@@ -817,10 +769,6 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
 			sizeof(unsigned int) * 8 -
 			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
-		.ilimit = REG_FIELD(DA9062AA_BUCK_ILIM_B,
-			__builtin_ffs((int)DA9062AA_BUCK4_ILIM_MASK) - 1,
-			sizeof(unsigned int) * 8 -
-			__builtin_clz((DA9062AA_BUCK4_ILIM_MASK)) - 1),
 	},
 	{
 		.desc.id = DA9062_ID_LDO1,
@@ -1063,15 +1011,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				return PTR_ERR(regl->suspend_sleep);
 		}
 
-		if (regl->info->ilimit.reg) {
-			regl->ilimit = devm_regmap_field_alloc(
-					&pdev->dev,
-					chip->regmap,
-					regl->info->ilimit);
-			if (IS_ERR(regl->ilimit))
-				return PTR_ERR(regl->ilimit);
-		}
-
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
 		config.dev = chip->dev;
-- 
2.17.1

