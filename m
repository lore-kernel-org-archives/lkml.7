Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108A218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ao2cwd5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfB1Nkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:40:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34368 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfB1Nkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:40:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so9759179pgd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QeLJ9DVmTyiKwmPn76FvOxc2tlSOjGWQncHZrNeVrdY=;
        b=ao2cwd5JMpE2f5HBqDTOg+1c/OXFc2C5tqoRSbHak88kyHaMoKRQKXlQ8WX0EPxmTk
         FsD/znNx6lOkz+tmZY41jmu3XzslMX9iYxFmJey8SDNaYFQhQgu2PbuuZMuwSIuhMMfL
         mfe/kjX+xPGnSVCrgCOD3N/NxC+HxwBNbI+VcA+YQpFlyN5/rOzJDmpXyboWFT+y+i3R
         IrJAEkYC5WcgBijPBFXac9ZIU9ZMmNr1uGq3W3pKDdbqINHl0NARb+jEdTmFWf6qfhmz
         vRWZQy20NTvYbUZDKqBMlWIta4fblcZGZnFNqFM1mOLKfUkSE4WhoDaAsDUA8qMuR6IJ
         Rtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QeLJ9DVmTyiKwmPn76FvOxc2tlSOjGWQncHZrNeVrdY=;
        b=lgcNpTB0oY7YpPSVA4rfo5qXOELxG3Uwiix/1xrpFSwAF/IRaqW0p/WHNgCmJNzc5I
         OTO23Y8VaWI15gZZ1/dQlytCKJSGu/cFEqCsB/4+EjaOQj5FAM5jrSAI0GCLntGx7c8S
         Z9CCurRNdUyRqW8RaIxSo0D9j9wuR3X/R+8mZEiy4IlvyCQiDxDryB9Q+TSJUVdFIZaT
         65K8GUosspVdQDekmzBsuQD2taBjCYlzA+sPdP69pOJPtWmYua5eZ0ArSpofprbUgaJd
         YH9S/sDlysZaN8bdTXHOfxzbniLIOuzJoL07YBiUcT1BVSBDWUaNi2JafzbAD/k7A+xC
         2kjA==
X-Gm-Message-State: AHQUAuajM291SfiaVQ92REmsoLnRGJZ/cYj2oRM/42fITWoz4u7DHB6D
        EHQcSlpXwkS3VtU+JkMj8P3p7Q==
X-Google-Smtp-Source: AHgI3IbeUTho+xi7duykCD2oNAQ2o25QRSkFAzdRbKvbwJ2U38oNa4I2l47HB2PP7EpHEBdZ4hreRw==
X-Received: by 2002:a63:ca:: with SMTP id 193mr8572200pga.288.1551361251488;
        Thu, 28 Feb 2019 05:40:51 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:40:50 -0800 (PST)
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
Subject: [PATCH 02/11] regulator: core: Add set/get_current_limit helpers for regmap users
Date:   Thu, 28 Feb 2019 21:40:13 +0800
Message-Id: <20190228134022.32625-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting curr_table, n_current_limits, csel_reg and csel_mask, the
regmap users can use regulator_set_current_limit_regmap and
regulator_get_current_limit_regmap for set/get_current_limit callbacks.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/helpers.c      | 86 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 68ac6017ef28..09b316559ef6 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -780,3 +780,89 @@ int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 				  rdev->desc->active_discharge_mask, val);
 }
 EXPORT_SYMBOL_GPL(regulator_set_active_discharge_regmap);
+
+/**
+ * regulator_set_current_limit_regmap - set_current_limit for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @min_uA: Lower bound for current limit
+ * @max_uA: Upper bound for current limit
+ *
+ * Regulators that use regmap for their register I/O can set curr_table,
+ * csel_reg and csel_mask fields in their descriptor and then use this
+ * as their set_current_limit operation, saving some code.
+ */
+int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
+				       int min_uA, int max_uA)
+{
+	unsigned int n_currents = rdev->desc->n_current_limits;
+	int i, sel = -1;
+
+	if (n_currents == 0)
+		return -EINVAL;
+
+	if (rdev->desc->curr_table) {
+		const unsigned int *curr_table = rdev->desc->curr_table;
+		bool ascend = curr_table[n_currents - 1] > curr_table[0];
+
+		/* search for closest to maximum */
+		if (ascend) {
+			for (i = n_currents - 1; i >= 0; i--) {
+				if (min_uA <= curr_table[i] &&
+				    curr_table[i] <= max_uA) {
+					sel = i;
+					break;
+				}
+			}
+		} else {
+			for (i = 0; i < n_currents; i++) {
+				if (min_uA <= curr_table[i] &&
+				    curr_table[i] <= max_uA) {
+					sel = i;
+					break;
+				}
+			}
+		}
+	}
+
+	if (sel < 0)
+		return -EINVAL;
+
+	sel <<= ffs(rdev->desc->csel_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->csel_reg,
+				  rdev->desc->csel_mask, sel);
+}
+EXPORT_SYMBOL_GPL(regulator_set_current_limit_regmap);
+
+/**
+ * regulator_get_current_limit_regmap - get_current_limit for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * csel_reg and csel_mask fields in their descriptor and then use this
+ * as their get_current_limit operation, saving some code.
+ */
+int regulator_get_current_limit_regmap(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->csel_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	val &= rdev->desc->csel_mask;
+	val >>= ffs(rdev->desc->csel_mask) - 1;
+
+	if (rdev->desc->curr_table) {
+		if (val >= rdev->desc->n_current_limits)
+			return -EINVAL;
+
+		return rdev->desc->curr_table[val];
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(regulator_get_current_limit_regmap);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index a0b9df5f60e0..c3dff2272664 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -264,6 +264,7 @@ enum regulator_type {
  * @continuous_voltage_range: Indicates if the regulator can set any
  *                            voltage within constrains range.
  * @n_voltages: Number of selectors available for ops.list_voltage().
+ * @n_current_limits: Number of selectors available for current limits
  *
  * @min_uV: Voltage given by the lowest selector (if linear mapping)
  * @uV_step: Voltage increase with each selector (if linear mapping)
@@ -278,6 +279,7 @@ enum regulator_type {
  * @n_linear_ranges: Number of entries in the @linear_ranges (and in
  *		     linear_range_selectors if used) table(s).
  * @volt_table: Voltage mapping table (if table based mapping)
+ * @curr_table: Current limit mapping table (if table based mapping)
  *
  * @vsel_range_reg: Register for range selector when using pickable ranges
  *		    and regulator_regmap_X_voltage_X_pickable functions.
@@ -333,6 +335,7 @@ struct regulator_desc {
 	int id;
 	unsigned int continuous_voltage_range:1;
 	unsigned n_voltages;
+	unsigned int n_current_limits;
 	const struct regulator_ops *ops;
 	int irq;
 	enum regulator_type type;
@@ -351,6 +354,7 @@ struct regulator_desc {
 	int n_linear_ranges;
 
 	const unsigned int *volt_table;
+	const unsigned int *curr_table;
 
 	unsigned int vsel_range_reg;
 	unsigned int vsel_range_mask;
@@ -534,6 +538,9 @@ int regulator_set_pull_down_regmap(struct regulator_dev *rdev);
 
 int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 					  bool enable);
+int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
+				       int min_uA, int max_uA);
+int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 
 void regulator_lock(struct regulator_dev *rdev);
-- 
2.17.1

