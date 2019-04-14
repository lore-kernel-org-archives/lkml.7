Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F59C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA420850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCQ01NMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDNSGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:06:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35706 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:06:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so7467116pfh.2;
        Sun, 14 Apr 2019 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFVqBZT5v8ld4sa186wu1NMMQzFASES6pQkfldZHoxw=;
        b=jCQ01NMb799os4ZD7pZMrLxvCXVhN9cKuXiO5c0l02OtvHk8VigTeqUKpr8j0qv3tV
         1fs3qGTg5LHYPiySQpbytfnwDLnUI/DmbKX9uXEWYhwzdKDLZdMaF1I3llx3lUGILgtp
         AykvMrUnk2IrR870zU8aKUha/v+xB2o5afXJFUbxTNca6FUy9XAeKXjLs2PfDXZFGheL
         9+D1Sq4seLsivKJMrJtRaBJVJ9ZW96D4PiJVgq2+v7kLHRlR+bPNZoB8oiR93jm2nunk
         5OVqhj5kK88n4mp+QO9/zVtesbyc7EuPmznN4sL6OeQrf5f/Eav+c/6dSQn9YbH/Y3aB
         O4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFVqBZT5v8ld4sa186wu1NMMQzFASES6pQkfldZHoxw=;
        b=KeQ6lHm94RHKXCnnPsKH1+HAO1E/mGNKhw1H05sv+M1czqeEEUutMd6wef2w+JtYvZ
         FhWZ7FbPjMBEzGBSfo4P6rOSCnXOhelOuoolHOX2KBKQJy9p6qMMRB8gzlqoWaHCP0fh
         /BnYv+iECf/r7AiRVL8HKJaMQ+wy85fS9D74eBVbf+TPRDa91Q96WzXWtD42o7CKy/WS
         urcL8ekVzVqnL70PNXQDLcJny9omLBC6fhYG2H9mN/sSZc6KC3irYmV/mt26g4gb592V
         JvK8ATRsrGffLMcDMqAELApE7BILjr/VGeQkgEQmNFJv/0G0bfIIUOqlSTOohvDGd0aV
         YY3w==
X-Gm-Message-State: APjAAAUOcLFJcwyPNTlKnycl6nECM6mA9ph1iexCwmQ7XfzWq3XRnPB7
        ClpAHGqn7L8fUhint08vRek=
X-Google-Smtp-Source: APXvYqzIftvpM/y0hmuTkRfkaaq10WZVKQjRZgnvIoAdh+aUd0kdt4pXhz3i39b8NblCpFRvaiSFdA==
X-Received: by 2002:a62:47d0:: with SMTP id p77mr70628328pfi.95.1555265163626;
        Sun, 14 Apr 2019 11:06:03 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:06:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/6] regulator: core: Expose some of core functions
Date:   Sun, 14 Apr 2019 20:59:36 +0300
Message-Id: <20190414175939.12368-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
References: <20190414175939.12368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose some of internal functions that are required for implementing
machine-specific regulators coupling for NVIDIA Tegra.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c         | 58 +++++++++++++++-----------------
 include/linux/regulator/driver.h | 12 +++++++
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cdb25bbee631..fa2f4e9e8bcd 100644
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
@@ -3071,7 +3067,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = min_uV;
 	data.max_uV = max_uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3095,7 +3091,7 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	struct pre_voltage_change_data data;
 	int ret;
 
-	data.old_uV = _regulator_get_voltage(rdev);
+	data.old_uV = regulator_get_voltage_rdev(rdev);
 	data.min_uV = uV;
 	data.max_uV = uV;
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_PRE_VOLTAGE_CHANGE,
@@ -3148,7 +3144,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	unsigned int selector;
 	int old_selector = -1;
 	const struct regulator_ops *ops = rdev->desc->ops;
-	int old_uV = _regulator_get_voltage(rdev);
+	int old_uV = regulator_get_voltage_rdev(rdev);
 
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
@@ -3175,7 +3171,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				best_val = ops->list_voltage(rdev,
 							     selector);
 			else
-				best_val = _regulator_get_voltage(rdev);
+				best_val = regulator_get_voltage_rdev(rdev);
 		}
 
 	} else if (ops->set_voltage_sel) {
@@ -3294,7 +3290,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	 * changing the voltage.
 	 */
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
-		current_uV = _regulator_get_voltage(rdev);
+		current_uV = regulator_get_voltage_rdev(rdev);
 		if (min_uV <= current_uV && current_uV <= max_uV) {
 			voltage->min_uV = min_uV;
 			voltage->max_uV = max_uV;
@@ -3331,8 +3327,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	return ret;
 }
 
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
-				      int max_uV, suspend_state_t state)
+int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+			       int max_uV, suspend_state_t state)
 {
 	int best_supply_uV = 0;
 	int supply_change_uV = 0;
@@ -3360,7 +3356,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
 
-		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
+		current_supply_uV = regulator_get_voltage_rdev(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
 			goto out;
@@ -3411,7 +3407,7 @@ static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 		return 1;
 
 	if (*current_uV < 0) {
-		*current_uV = _regulator_get_voltage(rdev);
+		*current_uV = regulator_get_voltage_rdev(rdev);
 
 		if (*current_uV < 0)
 			return *current_uV;
@@ -3515,7 +3511,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (!_regulator_is_enabled(c_rdevs[i]))
 			continue;
 
-		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
 		if (tmp_act < 0)
 			return tmp_act;
 
@@ -3557,7 +3553,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	if (n_coupled > 1 && *current_uV == -1) {
 
 		if (_regulator_is_enabled(rdev)) {
-			ret = _regulator_get_voltage(rdev);
+			ret = regulator_get_voltage_rdev(rdev);
 			if (ret < 0)
 				return ret;
 
@@ -3929,7 +3925,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_sync_voltage);
 
-static int _regulator_get_voltage(struct regulator_dev *rdev)
+int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 {
 	int sel, ret;
 	bool bypassed;
@@ -3946,7 +3942,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 				return -EPROBE_DEFER;
 			}
 
-			return _regulator_get_voltage(rdev->supply->rdev);
+			return regulator_get_voltage_rdev(rdev->supply->rdev);
 		}
 	}
 
@@ -3962,7 +3958,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 	} else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
 		ret = rdev->desc->fixed_uV;
 	} else if (rdev->supply) {
-		ret = _regulator_get_voltage(rdev->supply->rdev);
+		ret = regulator_get_voltage_rdev(rdev->supply->rdev);
 	} else {
 		return -EINVAL;
 	}
@@ -3987,7 +3983,7 @@ int regulator_get_voltage(struct regulator *regulator)
 	int ret;
 
 	regulator_lock_dependent(regulator->rdev, &ww_ctx);
-	ret = _regulator_get_voltage(regulator->rdev);
+	ret = regulator_get_voltage_rdev(regulator->rdev);
 	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
@@ -5296,7 +5292,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		   rdev->use_count, rdev->open_count, rdev->bypass_count,
 		   regulator_opmode_to_str(opmode));
 
-	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
+	seq_printf(s, "%5dmV ", regulator_get_voltage_rdev(rdev) / 1000);
 	seq_printf(s, "%5dmA ",
 		   _regulator_get_current_limit_unlocked(rdev) / 1000);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 377da2357118..25c5a1862af2 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
 #include <linux/ww_mutex.h>
 
 struct gpio_desc;
@@ -552,4 +553,15 @@ void regulator_unlock(struct regulator_dev *rdev);
  */
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector);
+
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
 #endif
-- 
2.21.0

