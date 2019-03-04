Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBCDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B814F20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="O8OrZhm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCDNQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:16:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCDNQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:16:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so3095837pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YJDRYCxk20K4JKC9hkgYoKpQYmGzgltavWE7rVF4G0o=;
        b=O8OrZhm6uSA6imgPaGUBEoTSyknftwp2wJiVtLMzI6fDr3CvSs3ref27q12qCW92On
         BcL6BunXc7ZwBjnH65jrnnsdBYmjSndvgGiXM6u+6X+a/JtLycWP1CgZlsunlqBSwMz+
         2aaWzPIj71ptmtyBEeKdQP2IspB0j7Br3E7t5C55Tlo128vqbLx3LmSlXylUgyhY/EsE
         6x9VSOjvax/dqZT9sBWsbVXZcXluydZrD3L8okAVcCegWYEPZzoD/lXVJumYgxEKALAd
         kGWjDKBLghp8rionHeIfQiEfyIgTNBnnURCShobZ1YlA9OlqNTV4x5wudUmDq4FE7xms
         pXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YJDRYCxk20K4JKC9hkgYoKpQYmGzgltavWE7rVF4G0o=;
        b=AG4i8l+7JjVGxk8mottrTsl5vILdZ/QXcYb5l7xuIeV8KtowwSOkLR0v9jWKH2H4P4
         63FlnuBXruNHBxFaIQ6MKv7ldIRoIRb5mMyzMRePsqO09PY2B6+M2D4EEuWEfxGqXGSv
         bhbH1xb6jZnWfF0hzuH7hJPY/ahUiN/42ZRwphDmWPfIcfMMxtNmk+tyrYKm5XD+iNO7
         MpsZ6aTDYLZZ1v8/deQTQYe/XmRoUp6BbVYxMiZkKktoi52BPTfWzmxo7sMqOe+rvtN9
         Pb36CsGsXCrJNvF5GNJ+bKsw3nXboZ1CfQSHDKq4O5FUaXzZzvVuCuOqQTEyfovQZdqS
         2axw==
X-Gm-Message-State: APjAAAV/E+vivP59YbuYPrdT3YicFJWoO3sUg2NgRE+0ZTSnPMVr0jDT
        9HB2/gH2ES0Bxb0NaIv5ZsX80w==
X-Google-Smtp-Source: APXvYqzeHI/FqhgAihCkMOjv8/VRLzepD92yDSpw5S7DVihrGcjgBUcSPqYCoVR2gSsJvMftlkw/8w==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr18556701pgg.267.1551705382979;
        Mon, 04 Mar 2019 05:16:22 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id j1sm6956774pgp.84.2019.03.04.05.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:16:22 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9063: Convert to use regulator_set/get_current_limit_regmap
Date:   Mon,  4 Mar 2019 21:16:03 +0800
Message-Id: <20190304131603.15730-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304131603.15730-1-axel.lin@ingics.com>
References: <20190304131603.15730-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9063-regulator.c | 107 +++++++--------------------
 1 file changed, 28 insertions(+), 79 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2b0c7a85306a..ceaaac602c6f 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -38,17 +38,12 @@
 struct da9063_regulator_info {
 	struct regulator_desc desc;
 
-	/* Current limiting */
-	unsigned	n_current_limits;
-	const int	*current_limits;
-
 	/* DA9063 main register fields */
 	struct reg_field mode;		/* buck mode of operation */
 	struct reg_field suspend;
 	struct reg_field sleep;
 	struct reg_field suspend_sleep;
 	unsigned int suspend_vsel_reg;
-	struct reg_field ilimit;
 
 	/* DA9063 event detection bit */
 	struct reg_field oc_event;
@@ -73,15 +68,18 @@ struct da9063_regulator_info {
 	.suspend_vsel_reg = DA9063_REG_V##regl_name##_B
 
 /* Macros for voltage DC/DC converters (BUCKs) */
-#define DA9063_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array) \
+#define DA9063_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array, \
+		    creg, cmask) \
 	.desc.id = chip##_ID_##regl_name, \
 	.desc.name = __stringify(chip##_##regl_name), \
 	.desc.ops = &da9063_buck_ops, \
 	.desc.min_uV = (min_mV) * 1000, \
 	.desc.uV_step = (step_mV) * 1000, \
 	.desc.n_voltages = ((max_mV) - (min_mV))/(step_mV) + 1, \
-	.current_limits = limits_array, \
-	.n_current_limits = ARRAY_SIZE(limits_array)
+	.desc.csel_reg = (creg), \
+	.desc.csel_mask = (cmask), \
+	.desc.curr_table = limits_array, \
+	.desc.n_current_limits = ARRAY_SIZE(limits_array)
 
 #define DA9063_BUCK_COMMON_FIELDS(regl_name) \
 	.desc.enable_reg = DA9063_REG_##regl_name##_CONT, \
@@ -112,7 +110,6 @@ struct da9063_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
-	struct regmap_field			*ilimit;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -134,65 +131,32 @@ enum {
 
 /* Current limits array (in uA) for BCORE1, BCORE2, BPRO.
    Entry indexes corresponds to register values. */
-static const int da9063_buck_a_limits[] = {
+static const unsigned int da9063_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
 
 /* Current limits array (in uA) for BMEM, BIO, BPERI.
    Entry indexes corresponds to register values. */
-static const int da9063_buck_b_limits[] = {
+static const unsigned int da9063_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
 /* Current limits array (in uA) for merged BCORE1 and BCORE2.
    Entry indexes corresponds to register values. */
-static const int da9063_bcores_merged_limits[] = {
+static const unsigned int da9063_bcores_merged_limits[] = {
 	1000000, 1200000, 1400000, 1600000, 1800000, 2000000, 2200000, 2400000,
 	2600000, 2800000, 3000000, 3200000, 3400000, 3600000, 3800000, 4000000
 };
 
 /* Current limits array (in uA) for merged BMEM and BIO.
    Entry indexes corresponds to register values. */
-static const int da9063_bmem_bio_merged_limits[] = {
+static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	3000000, 3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000,
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
-static int da9063_set_current_limit(struct regulator_dev *rdev,
-							int min_uA, int max_uA)
-{
-	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9063_regulator_info *rinfo = regl->info;
-	int n, tval;
-
-	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
-		tval = rinfo->current_limits[n];
-		if (tval >= min_uA && tval <= max_uA)
-			return regmap_field_write(regl->ilimit, n);
-	}
-
-	return -EINVAL;
-}
-
-static int da9063_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	const struct da9063_regulator_info *rinfo = regl->info;
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
 static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
@@ -434,8 +398,8 @@ static const struct regulator_ops da9063_buck_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
-	.set_current_limit	= da9063_set_current_limit,
-	.get_current_limit	= da9063_get_current_limit,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_mode		= da9063_buck_set_mode,
 	.get_mode		= da9063_buck_get_mode,
 	.get_status		= da9063_buck_get_status,
@@ -465,69 +429,61 @@ static const struct regulator_ops da9063_ldo_ops = {
 static const struct da9063_regulator_info da9063_regulator_info[] = {
 	{
 		DA9063_BUCK(DA9063, BCORE1, 300, 10, 1570,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE1_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE2_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE2_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
-			    da9063_buck_a_limits),
+			    da9063_buck_a_limits,
+			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPRO_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_B,
-				 DA9063_BPRO_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BMEM_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BIO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BIO),
 		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VBIO_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BIO_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
-			    da9063_buck_b_limits),
+			    da9063_buck_b_limits,
+			    DA9063_REG_BUCK_ILIM_B, DA9063_BPERI_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPERI),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPERI_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_B,
-				 DA9063_BPERI_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
-			    da9063_bcores_merged_limits),
+			    da9063_bcores_merged_limits,
+			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_C,
-				 DA9063_BCORE1_ILIM_MASK),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
-			    da9063_bmem_bio_merged_limits),
+			    da9063_bmem_bio_merged_limits,
+			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
 		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
-		.ilimit = BFIELD(DA9063_REG_BUCK_ILIM_A,
-				 DA9063_BMEM_ILIM_MASK),
 	},
 	{
 		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
@@ -861,13 +817,6 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				return PTR_ERR(regl->suspend_sleep);
 		}
 
-		if (regl->info->ilimit.reg) {
-			regl->ilimit = devm_regmap_field_alloc(&pdev->dev,
-					da9063->regmap, regl->info->ilimit);
-			if (IS_ERR(regl->ilimit))
-				return PTR_ERR(regl->ilimit);
-		}
-
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
 		config.dev = &pdev->dev;
-- 
2.17.1

