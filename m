Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EAC4646B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAE82073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyqCSNn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfFWVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 17:10:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFWVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 17:10:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so8545032lfa.5;
        Sun, 23 Jun 2019 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvzKq4F+r68I78ntyxMJxjmo7NqVv1ygDHDM2FmPFDk=;
        b=NyqCSNn78lSSr3FpdHfV0GbH1xcvDnbuRkacZDTaUoKTY8C9pQm/cLiQfZ/KAiY6Ca
         KZr61LEaMN2+IlRm4cjt4C6t97TOVAkcTUi17h0gTiqR1eoA5bOKwmGOCi2/1hQQSEbu
         oglY+iR1q+pBQ/n1tOpyqyXleTaHIWGgP3MjNeGgO2KjbMQ5OmJs0cFSO2DNVn7JBlqC
         EW3smgXuyLawdI9sDhlCo+XGnX3rdAzYVcus1h3TsfQ7f5SGOic1WAdYahaSYQPqSU3B
         FfU2a3/vtB37LQUSh05lECUI/5qyY8oWxpEdxHif0mZgOJJ8uSlMRW7aUNh0asNJneNp
         tTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvzKq4F+r68I78ntyxMJxjmo7NqVv1ygDHDM2FmPFDk=;
        b=sXmIi7KohDF5sjtQ/YEwpLQktg2/jRyZOFW3t3r8sBy9vKjes4TJJk+tencwbTqaOO
         adLeO0azD7w9da3Q7460u7Q9JU3rGBhhFErqp0nw1ZsvS9im2UX00pHhDdCFCJaZAacd
         aFMIUOfjg8kOrYfEmdErWV5Hh3aI0I++ifhaHaDQmGJdU9zPeZv/hysBhxuck6xjvwRV
         cLzbKX9AUpiUG+b6DlLrGECU04RcWmQX50NLgoBturjzFUGqd/PMEFZJwJ4HISewtVai
         DZS2ThYASfE6GSUCaFeOULbmCjARQbG4Ri0ACzFedqk1UXQbrJAZJM2QrRkPpcJaCosh
         Ap1A==
X-Gm-Message-State: APjAAAVLVINzH2Q/9MnBYJDKh6p3Sfd7d62RBahefVAtC+eIgjor8rlD
        BuPR2od1Epaxt06XeLTKs/c=
X-Google-Smtp-Source: APXvYqyMKM4NHtHKNF2TisASCafMpS8C8p+1ECVL6WUcAg0ON3CAVroKs3QT3PtQJpY8yhBrDyfD6w==
X-Received: by 2002:a19:ae0d:: with SMTP id f13mr23523135lfc.123.1561324230768;
        Sun, 23 Jun 2019 14:10:30 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id b11sm1431125ljf.8.2019.06.23.14.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:10:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] regulator: core: Expose some of core functions needed by couplers
Date:   Mon, 24 Jun 2019 00:08:32 +0300
Message-Id: <20190623210835.26281-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623210835.26281-1-digetx@gmail.com>
References: <20190623210835.26281-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose some of internal functions that are required for implementation of
customized regulator couplers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c          | 58 ++++++++++++++-----------------
 include/linux/regulator/coupler.h | 35 +++++++++++++++++++
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 98912f1c808d..41a062eb1470 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -94,7 +94,6 @@ struct regulator_supply_alias {
 
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
-static int _regulator_get_voltage(struct regulator_dev *rdev);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev);
 static int _notifier_call_chain(struct regulator_dev *rdev,
@@ -103,15 +102,12 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
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
@@ -425,8 +421,8 @@ static struct device_node *of_get_regulator(struct device *dev, const char *supp
 }
 
 /* Platform voltage constraint check */
-static int regulator_check_voltage(struct regulator_dev *rdev,
-				   int *min_uV, int *max_uV)
+int regulator_check_voltage(struct regulator_dev *rdev,
+			    int *min_uV, int *max_uV)
 {
 	BUG_ON(*min_uV > *max_uV);
 
@@ -458,9 +454,9 @@ static int regulator_check_states(suspend_state_t state)
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
@@ -571,7 +567,7 @@ static ssize_t regulator_uV_show(struct device *dev,
 	ssize_t ret;
 
 	regulator_lock(rdev);
-	ret = sprintf(buf, "%d\n", _regulator_get_voltage(rdev));
+	ret = sprintf(buf, "%d\n", regulator_get_voltage_rdev(rdev));
 	regulator_unlock(rdev);
 
 	return ret;
@@ -942,7 +938,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
 			rdev_err(rdev, "failed to set load %d\n", current_uA);
 	} else {
 		/* get output voltage */
-		output_uV = _regulator_get_voltage(rdev);
+		output_uV = regulator_get_voltage_rdev(rdev);
 		if (output_uV <= 0) {
 			rdev_err(rdev, "invalid output voltage found\n");
 			return -EINVAL;
@@ -1055,7 +1051,7 @@ static void print_constraints(struct regulator_dev *rdev)
 
 	if (!constraints->min_uV ||
 	    constraints->min_uV != constraints->max_uV) {
-		ret = _regulator_get_voltage(rdev);
+		ret = regulator_get_voltage_rdev(rdev);
 		if (ret > 0)
 			count += scnprintf(buf + count, len - count,
 					   "at %d mV ", ret / 1000);
@@ -1114,7 +1110,7 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 	if (rdev->constraints->apply_uV &&
 	    rdev->constraints->min_uV && rdev->constraints->max_uV) {
 		int target_min, target_max;
-		int current_uV = _regulator_get_voltage(rdev);
+		int current_uV = regulator_get_voltage_rdev(rdev);
 
 		if (current_uV == -ENOTRECOVERABLE) {
 			/* This regulator can't be read and must be initialized */
@@ -1124,7 +1120,7 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			_regulator_do_set_voltage(rdev,
 						  rdev->constraints->min_uV,
 						  rdev->constraints->max_uV);
-			current_uV = _regulator_get_voltage(rdev);
+			current_uV = regulator_get_voltage_rdev(rdev);
 		}
 
 		if (current_uV < 0) {
@@ -3066,7 +3062,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = min_uV;
 	data.max_uV = max_uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3090,7 +3086,7 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = uV;
 	data.max_uV = uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3143,7 +3139,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	unsigned int selector;
 	int old_selector = -1;
 	const struct regulator_ops *ops = rdev->desc->ops;
-	int old_uV = _regulator_get_voltage(rdev);
+	int old_uV = regulator_get_voltage_rdev(rdev);
 
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
@@ -3170,7 +3166,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				best_val = ops->list_voltage(rdev,
 							     selector);
 			else
-				best_val = _regulator_get_voltage(rdev);
+				best_val = regulator_get_voltage_rdev(rdev);
 		}
 
 	} else if (ops->set_voltage_sel) {
@@ -3289,7 +3285,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	 * changing the voltage.
 	 */
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
-		current_uV = _regulator_get_voltage(rdev);
+		current_uV = regulator_get_voltage_rdev(rdev);
 		if (min_uV <= current_uV && current_uV <= max_uV) {
 			voltage->min_uV = min_uV;
 			voltage->max_uV = max_uV;
@@ -3326,8 +3322,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	return ret;
 }
 
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
-				      int max_uV, suspend_state_t state)
+int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+			       int max_uV, suspend_state_t state)
 {
 	int best_supply_uV = 0;
 	int supply_change_uV = 0;
@@ -3355,7 +3351,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
 
-		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
+		current_supply_uV = regulator_get_voltage_rdev(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
 			goto out;
@@ -3406,7 +3402,7 @@ static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 		return 1;
 
 	if (*current_uV < 0) {
-		*current_uV = _regulator_get_voltage(rdev);
+		*current_uV = regulator_get_voltage_rdev(rdev);
 
 		if (*current_uV < 0)
 			return *current_uV;
@@ -3511,7 +3507,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (!_regulator_is_enabled(c_rdevs[i]))
 			continue;
 
-		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
 		if (tmp_act < 0)
 			return tmp_act;
 
@@ -3553,7 +3549,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	if (n_coupled > 1 && *current_uV == -1) {
 
 		if (_regulator_is_enabled(rdev)) {
-			ret = _regulator_get_voltage(rdev);
+			ret = regulator_get_voltage_rdev(rdev);
 			if (ret < 0)
 				return ret;
 
@@ -3917,7 +3913,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_sync_voltage);
 
-static int _regulator_get_voltage(struct regulator_dev *rdev)
+int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 {
 	int sel, ret;
 	bool bypassed;
@@ -3934,7 +3930,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 				return -EPROBE_DEFER;
 			}
 
-			return _regulator_get_voltage(rdev->supply->rdev);
+			return regulator_get_voltage_rdev(rdev->supply->rdev);
 		}
 	}
 
@@ -3950,7 +3946,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 	} else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
 		ret = rdev->desc->fixed_uV;
 	} else if (rdev->supply) {
-		ret = _regulator_get_voltage(rdev->supply->rdev);
+		ret = regulator_get_voltage_rdev(rdev->supply->rdev);
 	} else {
 		return -EINVAL;
 	}
@@ -3975,7 +3971,7 @@ int regulator_get_voltage(struct regulator *regulator)
 	int ret;
 
 	regulator_lock_dependent(regulator->rdev, &ww_ctx);
-	ret = _regulator_get_voltage(regulator->rdev);
+	ret = regulator_get_voltage_rdev(regulator->rdev);
 	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
@@ -5371,7 +5367,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
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
2.22.0

