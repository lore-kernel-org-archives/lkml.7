Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77BC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4408266D2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIwwWwb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFDAAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:00:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33837 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFCX7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:59:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so17952242ljg.1;
        Mon, 03 Jun 2019 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBa4M4Es6lOC40L56eaCdmY6jh6Ow/MPOO/b+pKmR2I=;
        b=EIwwWwb26u6pvLS+dWyGDtZaQXOeqSpSDyNJJPj/2Y0jrZ6Q+/m2EXx9HDkiGSTZl8
         3g1VKxc/CYNF9i3+Y7MJpJ7e8fT24CyqAcWw6Wnhrnx/0rIRjDOa7yrWxJW5XINGg9C7
         sMvQH38DrHVEwj1inVJKan9RDq/y3KvxFYkrX4lk9ORDn8o5MIuKXiBKbXyNFcis+hzd
         3I5gyVrVTMmplwHWv/M3LDxJGrZXew+sAUBHoXYxLT7dphM348l6dMb90vxD2AcIBBVN
         X2MAYaF77oOfZohjKqfnKB1pHEBP5eAfnWaIcxI9JT7NMHXSbcUIA1LBfQEpyzvyLaQz
         vvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBa4M4Es6lOC40L56eaCdmY6jh6Ow/MPOO/b+pKmR2I=;
        b=GZL9jYPAb0gi0Z6x6PwMWqnx3t6mJIpMcF6+X3TvMrwOcTaSuGbZWstxk8TrVu+/Mk
         Y/GbWuoSLseYE6tPLCONSaoM0gkgZNY2FqHsnYiGwl9U5EwF03TrQvlduk/34vYSaO6P
         +Hnkg15eu1eLwo88dr9BEaF4Ay/WsK3Q6joB+tUklbTVtE5ir0MJSITtxRMTUxKt5mdl
         bDC6b/Yl+Y3uwaVeX9i9dJoHurwgQMM4ZpSCGulxqqQC5YjGKb47gaYoV392pcuccJi0
         llW2BuZ/YGQDP9wYN3UnQZLr9Vw0rHziDbiRL8ZGWeKv0fYVYoGQ3mME6yqO9sI6to8W
         MqLg==
X-Gm-Message-State: APjAAAXe9Qo6utUCOJG4WBrdq3lSZCEHe+I4zVDGi7JVipWlhZsjEo4x
        0ZI0/8ao/q9PAU5FgrOd4BY=
X-Google-Smtp-Source: APXvYqxQFV/Jc8PaL2AenxWJ97CLF+bNSEFRcvx6zU9O6E23TIpQeiqaPM7lH/PQk4Hw2NTWF1BjEA==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr1739250ljj.120.1559606388254;
        Mon, 03 Jun 2019 16:59:48 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n7sm2943151lfi.68.2019.06.03.16.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:59:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] regulator: core: Expose some of core functions
Date:   Tue,  4 Jun 2019 02:58:59 +0300
Message-Id: <20190603235904.19097-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603235904.19097-1-digetx@gmail.com>
References: <20190603235904.19097-1-digetx@gmail.com>
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
 drivers/regulator/core.c         | 58 +++++++++++++++-----------------
 include/linux/regulator/driver.h | 11 ++++++
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c148dd7d306e..5a5b86d3edfb 100644
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
@@ -3510,7 +3506,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		if (!_regulator_is_enabled(c_rdevs[i]))
 			continue;
 
-		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		tmp_act = regulator_get_voltage_rdev(c_rdevs[i]);
 		if (tmp_act < 0)
 			return tmp_act;
 
@@ -3552,7 +3548,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 	if (n_coupled > 1 && *current_uV == -1) {
 
 		if (_regulator_is_enabled(rdev)) {
-			ret = _regulator_get_voltage(rdev);
+			ret = regulator_get_voltage_rdev(rdev);
 			if (ret < 0)
 				return ret;
 
@@ -3922,7 +3918,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 }
 EXPORT_SYMBOL_GPL(regulator_sync_voltage);
 
-static int _regulator_get_voltage(struct regulator_dev *rdev)
+int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 {
 	int sel, ret;
 	bool bypassed;
@@ -3939,7 +3935,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 				return -EPROBE_DEFER;
 			}
 
-			return _regulator_get_voltage(rdev->supply->rdev);
+			return regulator_get_voltage_rdev(rdev->supply->rdev);
 		}
 	}
 
@@ -3955,7 +3951,7 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
 	} else if (rdev->desc->fixed_uV && (rdev->desc->n_voltages == 1)) {
 		ret = rdev->desc->fixed_uV;
 	} else if (rdev->supply) {
-		ret = _regulator_get_voltage(rdev->supply->rdev);
+		ret = regulator_get_voltage_rdev(rdev->supply->rdev);
 	} else {
 		return -EINVAL;
 	}
@@ -3980,7 +3976,7 @@ int regulator_get_voltage(struct regulator *regulator)
 	int ret;
 
 	regulator_lock_dependent(regulator->rdev, &ww_ctx);
-	ret = _regulator_get_voltage(regulator->rdev);
+	ret = regulator_get_voltage_rdev(regulator->rdev);
 	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
@@ -5343,7 +5339,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		   rdev->use_count, rdev->open_count, rdev->bypass_count,
 		   regulator_opmode_to_str(opmode));
 
-	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
+	seq_printf(s, "%5dmV ", regulator_get_voltage_rdev(rdev) / 1000);
 	seq_printf(s, "%5dmA ",
 		   _regulator_get_current_limit_unlocked(rdev) / 1000);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 18bbbd4135a1..dfd8e518b283 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -585,4 +585,15 @@ int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 
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
+
 #endif
-- 
2.21.0

