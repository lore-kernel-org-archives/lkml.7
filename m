Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA4C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31147207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfIKOXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:23:32 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:49555 "EHLO
        10.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfIKOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:23:32 -0400
X-Greylist: delayed 3606 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 10:23:28 EDT
Received: from player168.ha.ovh.net (unknown [10.109.143.145])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id AE18C785D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:04:25 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id 30D9F9980149;
        Wed, 11 Sep 2019 13:04:09 +0000 (UTC)
From:   Quentin Perret <qperret@qperret.net>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@qperret.net
Subject: [PATCH v8 3/4] thermal: cpu_cooling: Make the power-related code depend on IPA
Date:   Wed, 11 Sep 2019 15:03:13 +0200
Message-Id: <20190911130314.29973-4-qperret@qperret.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911130314.29973-1-qperret@qperret.net>
References: <20190911130314.29973-1-qperret@qperret.net>
X-Ovh-Tracer-Id: 17354902642160327673
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

The core CPU cooling infrastructure has power-related functions
that have only one client: IPA. Since there can be no user of those
functions if IPA is not compiled in, make sure to guard them with
checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
unnecessarily.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 110 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4c5db59a619b..498f59ab64b2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -46,7 +46,9 @@
  */
 struct freq_table {
 	u32 frequency;
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	u32 power;
+#endif
 };
 
 /**
@@ -96,28 +98,6 @@ static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
-/* Below code defines functions to be used for cpufreq as cooling device */
-
-/**
- * get_level: Find the level for a particular frequency
- * @cpufreq_cdev: cpufreq_cdev for which the property is required
- * @freq: Frequency
- *
- * Return: level corresponding to the frequency.
- */
-static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
-			       unsigned int freq)
-{
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
-	unsigned long level;
-
-	for (level = 1; level <= cpufreq_cdev->max_level; level++)
-		if (freq > freq_table[level].frequency)
-			break;
-
-	return level - 1;
-}
-
 /**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
@@ -171,6 +151,27 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
+/**
+ * get_level: Find the level for a particular frequency
+ * @cpufreq_cdev: cpufreq_cdev for which the property is required
+ * @freq: Frequency
+ *
+ * Return: level corresponding to the frequency.
+ */
+static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
+			       unsigned int freq)
+{
+	struct freq_table *freq_table = cpufreq_cdev->freq_table;
+	unsigned long level;
+
+	for (level = 1; level <= cpufreq_cdev->max_level; level++)
+		if (freq > freq_table[level].frequency)
+			break;
+
+	return level - 1;
+}
+
 /**
  * update_freq_table() - Update the freq table with power numbers
  * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
@@ -319,80 +320,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
-/* cpufreq cooling device callback functions are defined below */
-
-/**
- * cpufreq_get_max_state - callback function to get the max cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the max cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * max cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->max_level;
-	return 0;
-}
-
-/**
- * cpufreq_get_cur_state - callback function to get the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the current cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->cpufreq_state;
-
-	return 0;
-}
-
-/**
- * cpufreq_set_cur_state - callback function to set the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: set this variable to the current cooling state.
- *
- * Callback for the thermal cooling device to change the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	unsigned int clip_freq;
-
-	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
-		return -EINVAL;
-
-	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_cdev->cpufreq_state == state)
-		return 0;
-
-	clip_freq = cpufreq_cdev->freq_table[state].frequency;
-	cpufreq_cdev->cpufreq_state = state;
-	cpufreq_cdev->clipped_freq = clip_freq;
-
-	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
-
-	return 0;
-}
-
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -536,22 +463,88 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 				      power);
 	return 0;
 }
+#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
+
+/* cpufreq cooling device callback functions are defined below */
+
+/**
+ * cpufreq_get_max_state - callback function to get the max cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the max cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * max cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->max_level;
+	return 0;
+}
+
+/**
+ * cpufreq_get_cur_state - callback function to get the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the current cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->cpufreq_state;
+
+	return 0;
+}
+
+/**
+ * cpufreq_set_cur_state - callback function to set the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: set this variable to the current cooling state.
+ *
+ * Callback for the thermal cooling device to change the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int clip_freq;
+
+	/* Request state should be less than max_level */
+	if (WARN_ON(state > cpufreq_cdev->max_level))
+		return -EINVAL;
+
+	/* Check if the old cooling action is same as new cooling action */
+	if (cpufreq_cdev->cpufreq_state == state)
+		return 0;
+
+	clip_freq = cpufreq_cdev->freq_table[state].frequency;
+	cpufreq_cdev->cpufreq_state = state;
+	cpufreq_cdev->clipped_freq = clip_freq;
+
+	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
+
+	return 0;
+}
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
 
 static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
-	.get_max_state = cpufreq_get_max_state,
-	.get_cur_state = cpufreq_get_cur_state,
-	.set_cur_state = cpufreq_set_cur_state,
-};
-
-static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
 	.get_max_state		= cpufreq_get_max_state,
 	.get_cur_state		= cpufreq_get_cur_state,
 	.set_cur_state		= cpufreq_set_cur_state,
-	.get_requested_power	= cpufreq_get_requested_power,
-	.state2power		= cpufreq_state2power,
-	.power2state		= cpufreq_power2state,
 };
 
 /* Notifier for cpufreq policy change */
@@ -659,18 +652,19 @@ __cpufreq_cooling_register(struct device_node *np,
 			pr_debug("%s: freq:%u KHz\n", __func__, freq);
 	}
 
+	cooling_ops = &cpufreq_cooling_ops;
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (capacitance) {
 		ret = update_freq_table(cpufreq_cdev, capacitance);
 		if (ret) {
 			cdev = ERR_PTR(ret);
 			goto remove_ida;
 		}
-
-		cooling_ops = &cpufreq_power_cooling_ops;
-	} else {
-		cooling_ops = &cpufreq_cooling_ops;
+		cooling_ops->get_requested_power = cpufreq_get_requested_power;
+		cooling_ops->state2power = cpufreq_state2power;
+		cooling_ops->power2state = cpufreq_power2state;
 	}
-
+#endif
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
-- 
2.22.1

