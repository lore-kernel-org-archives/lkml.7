Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A368C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1114020842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551658027;
	bh=o9G2UrrjH0XekxanB6vwwjcrp06WjT4mtOTri1QZtKk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=edrtFmgVJYjTqmZ/2tDTlxTx78L4QnHqMifVUe7PSSSIbxd422D6FDr01RVyCSyrX
	 WuJZBnKTkLdCAB7wEOLlNza8VsPjb6njTtgA+cSIHtoMVDcE7AhBL77QCbkn5RKepm
	 ejuCDo81AofGySxrlnNPdWGEfcxz2deQrELmGUqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfCDAHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:07:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfCDAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gDn797ig5FaDk2WPoQQMdZhHdnEXPt52mjFsCC2+nbw=; b=hQXgfRh/FUjP
        gnmhopskaqDfb99HUiSPVF7im8pZSZmkmb+HdxhoDZTR3h8bJH3Nk9U1hkDjPfLHe+UIH0bGrABVJ
        1LQ4Hw3I/nAse3xoDzCEW1JGBO0eIVpOEleMlbIHRAAqQhboiIZaSBy88bSbqJytCw3WRpD6aLz9x
        BqjWY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b89-0007Qf-Ho; Mon, 04 Mar 2019 00:06:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DAEC6440082; Mon,  4 Mar 2019 00:06:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Add set/get_current_limit helpers for regmap users" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190304000652.DAEC6440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add set/get_current_limit helpers for regmap users

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a32e0c773b5f233b0589dbb621bb2b9681dbfec3 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 28 Feb 2019 21:40:13 +0800
Subject: [PATCH] regulator: core: Add set/get_current_limit helpers for regmap
 users

By setting curr_table, n_current_limits, csel_reg and csel_mask, the
regmap users can use regulator_set_current_limit_regmap and
regulator_get_current_limit_regmap for set/get_current_limit callbacks.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/helpers.c      | 86 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 68ac6017ef28..32d3f0499e2d 100644
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
index b9557c9623b5..377da2357118 100644
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
2.20.1

