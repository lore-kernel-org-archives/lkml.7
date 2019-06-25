Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F03214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561461643;
	bh=mDmtSZT9O4MOjVflR3tL9B9hnhva1mWHHPxArvsOmsA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Nzst7H3mlsWHRIzTTDlVSDIzjvWx1Z+aCN+xfbxGU9HDFE84AN+LuQacv/j1CUvAg
	 80zZ5kbJA3atrs5XqjR6LymglzkDJIobM11TT3YnTZmqoZ/pjyn0XAecRTWT427iBj
	 cgX+1GcAgVT80Rlv+cB6OeSTaFTmRc8emzMzcdlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfFYLUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:20:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730665AbfFYLUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uCSDwv+9yNyFyaDdq5UrkMrdBsIDHs9bJqFwZOUU2DM=; b=YdKxtgXohqjB
        VmFHBY83p8zYneUta0Uc+fJkTmrKu2H1JROShQ/CNcvDOpJryXGYQRJMSRSA5goIB84OwJLFNV2Xd
        HdaAp53YxSeNiPO1F53WTuvqoGbeUiUm/efACOg4P7t61VvqRS2R5QavEVrL43Dom4aW07qx6QMg3
        vOcJU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfjV7-00057o-R6; Tue, 25 Jun 2019 11:20:37 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5F2E4440046; Tue, 25 Jun 2019 12:20:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Expose some of core functions needed by couplers" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190625112037.5F2E4440046@finisterre.sirena.org.uk>
Date:   Tue, 25 Jun 2019 12:20:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Expose some of core functions needed by couplers

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

From d22b85a1b97d12a4940ef9d778f6122546736f78 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 24 Jun 2019 00:08:32 +0300
Subject: [PATCH] regulator: core: Expose some of core functions needed by
 couplers

Expose some of internal functions that are required for implementation of
customized regulator couplers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c          | 58 ++++++++++++++-----------------
 include/linux/regulator/coupler.h | 35 +++++++++++++++++++
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 12c870f790f5..b9bc45128b8c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -100,7 +100,6 @@ struct regulator_supply_alias {
 
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
-static int _regulator_get_voltage(struct regulator_dev *rdev);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev);
 static int _notifier_call_chain(struct regulator_dev *rdev,
@@ -109,15 +108,12 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
 static int regulator_balance_voltage(struct regulator_dev *rdev,
 				     suspend_state_t state);
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
-				      int min_uV, int max_uV,
-				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
 static void _regulator_put(struct regulator *regulator);
 
-static const char *rdev_get_name(struct regulator_dev *rdev)
+const char *rdev_get_name(struct regulator_dev *rdev)
 {
 	if (rdev->constraints && rdev->constraints->name)
 		return rdev->constraints->name;
@@ -431,8 +427,8 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 }
 
 /* Platform voltage constraint check */
-static int regulator_check_voltage(struct regulator_dev *rdev,
-				   int *min_uV, int *max_uV)
+int regulator_check_voltage(struct regulator_dev *rdev,
+			    int *min_uV, int *max_uV)
 {
 	BUG_ON(*min_uV > *max_uV);
 
@@ -464,9 +460,9 @@ static int regulator_check_states(suspend_state_t state)
 /* Make sure we select a voltage that suits the needs of all
  * regulator consumers
  */
-static int regulator_check_consumers(struct regulator_dev *rdev,
-				     int *min_uV, int *max_uV,
-				     suspend_state_t state)
+int regulator_check_consumers(struct regulator_dev *rdev,
+			      int *min_uV, int *max_uV,
+			      suspend_state_t state)
 {
 	struct regulator *regulator;
 	struct regulator_voltage *voltage;
@@ -577,7 +573,7 @@ static ssize_t regulator_uV_show(struct device *dev,
 	ssize_t ret;
 
 	regulator_lock(rdev);
-	ret = sprintf(buf, "%d\n", _regulator_get_voltage(rdev));
+	ret = sprintf(buf, "%d\n", regulator_get_voltage_rdev(rdev));
 	regulator_unlock(rdev);
 
 	return ret;
@@ -948,7 +944,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
 			rdev_err(rdev, "failed to set load %d\n", current_uA);
 	} else {
 		/* get output voltage */
-		output_uV = _regulator_get_voltage(rdev);
+		output_uV = regulator_get_voltage_rdev(rdev);
 		if (output_uV <= 0) {
 			rdev_err(rdev, "invalid output voltage found\n");
 			return -EINVAL;
@@ -1061,7 +1057,7 @@ static void print_constraints(struct regulator_dev *rdev)
 
 	if (!constraints->min_uV ||
 	    constraints->min_uV != constraints->max_uV) {
-		ret = _regulator_get_voltage(rdev);
+		ret = regulator_get_voltage_rdev(rdev);
 		if (ret > 0)
 			count += scnprintf(buf + count, len - count,
 					   "at %d mV ", ret / 1000);
@@ -1120,7 +1116,7 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 	if (rdev->constraints->apply_uV &&
 	    rdev->constraints->min_uV && rdev->constraints->max_uV) {
 		int target_min, target_max;
-		int current_uV = _regulator_get_voltage(rdev);
+		int current_uV = regulator_get_voltage_rdev(rdev);
 
 		if (current_uV == -ENOTRECOVERABLE) {
 			/* This regulator can't be read and must be initialized */
@@ -1130,7 +1126,7 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			_regulator_do_set_voltage(rdev,
 						  rdev->constraints->min_uV,
 						  rdev->constraints->max_uV);
-			current_uV = _regulator_get_voltage(rdev);
+			current_uV = regulator_get_voltage_rdev(rdev);
 		}
 
 		if (current_uV < 0) {
@@ -3072,7 +3068,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = min_uV;
 	data.max_uV = max_uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3096,7 +3092,7 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = uV;
 	data.max_uV = uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3149,7 +3145,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	unsigned int selector;
 	int old_selector = -1;
 	const struct regulator_ops *ops = rdev->desc->ops;
-	int old_uV = _regulator_get_voltage(rdev);
+	int old_uV = regulator_get_voltage_rdev(rdev);
 
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
@@ -3176,7 +3172,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				best_val = ops->list_voltage(rdev,
 							     selector);
 			else
-				best_val = _regulator_get_voltage(rdev);
+				best_val = regulator_get_voltage_rdev(rdev);
 		}
 
 	} else if (ops->set_voltage_sel) {
@@ -3295,7 +3291,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	 * changing the voltage.
 	 */
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
-		current_uV = _regulator_get_voltage(rdev);
+		current_uV = regulator_get_voltage_rdev(rdev);
 		if (min_uV <= current_uV && current_uV <= max_uV) {
 			voltage->min_uV = min_uV;
 			voltage->max_uV = max_uV;
@@ -3332,8 +3328,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	return ret;
 }
 
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
-				      int max_uV, suspend_state_t state)
+int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+			       int max_uV, suspend_state_t state)
 {
 	int best_supply_uV = 0;
 	int supply_change_uV = 0;
@@ -3361,7 +3357,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
 
-		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
+		current_supply_uV = regulator_get_voltage_rdev(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
 			goto out;
@@ -3412,7 +3408,7 @@ static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 		return 1;
 
 	if (*current_uV < 0) {
-		*current_uV = _regulator_get_voltage(rdev);
+		*current_uV = regulator_get_voltage_rdev(rdev);
 
 		if (*current_uV < 0)
 			return *current_uV;
@@ -3517,7 +3513,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (!_regulator_is_enabled(c_rdevs[i]))
 			continue;
 
-		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
 		if (tmp_act < 0)
 			return tmp_act;
 
@@ -3559,7 +3555,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	if (n_coupled > 1 && *current_uV == -1) {
 
 		if (_regulator_is_enabled(rdev)) {
-			ret = _regulator_get_voltage(rdev);
+			ret = regulator_get_voltage_rdev(rdev);
 			if (ret < 0)
 				return ret;
 
@@ -3923,7 +3919,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_sync_voltage);
 
-static int _regulator_get_voltage(struct regulator_dev *rdev)
+int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 {
 	int sel, ret;
 	bool bypassed;
@@ -3940,7 +3936,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 				return -EPROBE_DEFER;
 			}
 
-			return _regulator_get_voltage(rdev->supply->rdev);
+			return regulator_get_voltage_rdev(rdev->supply->rdev);
 		}
 	}
 
@@ -3956,7 +3952,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 	} else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
 		ret = rdev->desc->fixed_uV;
 	} else if (rdev->supply) {
-		ret = _regulator_get_voltage(rdev->supply->rdev);
+		ret = regulator_get_voltage_rdev(rdev->supply->rdev);
 	} else {
 		return -EINVAL;
 	}
@@ -3981,7 +3977,7 @@ int regulator_get_voltage(struct regulator *regulator)
 	int ret;
 
 	regulator_lock_dependent(regulator->rdev, &ww_ctx);
-	ret = _regulator_get_voltage(regulator->rdev);
+	ret = regulator_get_voltage_rdev(regulator->rdev);
 	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
@@ -5377,7 +5373,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		   rdev->use_count, rdev->open_count, rdev->bypass_count,
 		   regulator_opmode_to_str(opmode));
 
-	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
+	seq_printf(s, "%5dmV ", regulator_get_voltage_rdev(rdev) / 1000);
 	seq_printf(s, "%5dmA ",
 		   _regulator_get_current_limit_unlocked(rdev) / 1000);
 
diff --git a/include/linux/regulator/coupler.h b/include/linux/regulator/coupler.h
index 98dd1f74d605..0212d6255e4e 100644
--- a/include/linux/regulator/coupler.h
+++ b/include/linux/regulator/coupler.h
@@ -52,11 +52,46 @@ struct regulator_coupler {
 
 #ifdef CONFIG_REGULATOR
 int regulator_coupler_register(struct regulator_coupler *coupler);
+const char *rdev_get_name(struct regulator_dev *rdev);
+int regulator_check_consumers(struct regulator_dev *rdev,
+			      int *min_uV, int *max_uV,
+			      suspend_state_t state);
+int regulator_check_voltage(struct regulator_dev *rdev,
+			    int *min_uV, int *max_uV);
+int regulator_get_voltage_rdev(struct regulator_dev *rdev);
+int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+			       int min_uV, int max_uV,
+			       suspend_state_t state);
 #else
 static inline int regulator_coupler_register(struct regulator_coupler *coupler)
 {
 	return 0;
 }
+static inline const char *rdev_get_name(struct regulator_dev *rdev)
+{
+	return NULL;
+}
+static inline int regulator_check_consumers(struct regulator_dev *rdev,
+					    int *min_uV, int *max_uV,
+					    suspend_state_t state)
+{
+	return -EINVAL;
+}
+static inline int regulator_check_voltage(struct regulator_dev *rdev,
+					  int *min_uV, int *max_uV)
+{
+	return -EINVAL;
+}
+static inline int regulator_get_voltage_rdev(struct regulator_dev *rdev)
+{
+	return -EINVAL;
+}
+static inline int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+					     int min_uV, int max_uV,
+					     suspend_state_t state)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
2.20.1

