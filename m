Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA620C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7922239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obC10n73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfGWGOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGWGO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so13191643pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T27u9AQsojQ674GAmNKFLMWAOrQITFIdhdVL3SNGHa0=;
        b=obC10n73Pw4AyLlrcsn5/50+eeV/qQEk85Cbw+xZkhbh4MPjLohj3d/ZOmCp8DseMu
         DitCeDke4pM/cf4uAG6ZPAG4Do9GZbJDeG5DQuXKlWl15ugwrxGSJhlTWQrkZyjV0KVw
         n2T357xJC5QCIPCbb7yDlZxIhLILw/zLfI2L75eRSvXWbqU03EBwL/3js1hFD66A+iBN
         JCVhOzwIiklzKhDvdvVQU9NcUp8FSTOQgTl1ycy6/V++FHd4Wkd060jTFegArCstZ/S7
         WKRaMntXZbUSP6dr6P9EXhYmV7kbmNNvUqiE0+5mwuq0BN/uB4rMvsJvAKbRlQ+iyY7J
         pcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T27u9AQsojQ674GAmNKFLMWAOrQITFIdhdVL3SNGHa0=;
        b=DSl76pltgegJNUWk3urMzBauvy36S7Dpnq2/PLVRpWuEYoOppoKGjfMfqw8QdJDs6/
         JoMFhTlfqN9Fr/KbAFlclNzrfQVnQtWYAa/0cI/4d9ryjS/jcnQ9cTGJlyer3rHz4crU
         TtscCv+LM7ycV0rDgKrQfML8YwBmRxGrMtqLVXmrmRvB6HjLF5Tr4cWnS2A9nZyYtUpe
         h/iU5Qud67/laMTLx3FHb4j5JdxJbPuW0rWDEy4xcM/GwFm5Li3eJokXXm4GsWwBynRV
         Lxx/9bZyPppMXPfAmWzxeQV5DgaZM9Dch7Clv62CX6j/m08OKf1rDFW151BhIXs+z+PO
         qJ6g==
X-Gm-Message-State: APjAAAXo+IbMn65uN6UG34uBBNRkDFmGdMbXSyGK6oigeyfq7jsojwZK
        lXwYg8JQ5h/NPi/xUJ5SyqzEZg==
X-Google-Smtp-Source: APXvYqylbHkh7T2K64hBeHU3LnqC9FrQjrjlDKrGKS9IOg+HfCbNR93IgtPfqPpOdmTBhW9vcbTTig==
X-Received: by 2002:a17:902:e306:: with SMTP id cg6mr79006572plb.263.1563862467328;
        Mon, 22 Jul 2019 23:14:27 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o11sm70597491pfh.114.2019.07.22.23.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/10] thermal: cpu_cooling: Switch to QoS requests instead of cpufreq notifier
Date:   Tue, 23 Jul 2019 11:44:02 +0530
Message-Id: <22a22cba8855c914056dec8f8173c885b870f7a4.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for cpu_cooling driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 110 ++++++++--------------------------
 1 file changed, 26 insertions(+), 84 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4c5db59a619b..391f39776c6a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
@@ -66,8 +67,6 @@ struct time_in_idle {
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
- * @clipped_freq: integer value representing the absolute value of the clipped
- *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @freq_table: Freq table in descending order of frequencies
@@ -84,12 +83,12 @@ struct cpufreq_cooling_device {
 	int id;
 	u32 last_load;
 	unsigned int cpufreq_state;
-	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
+	struct dev_pm_qos_request qos_req;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -118,59 +117,6 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 	return level - 1;
 }
 
-/**
- * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
- * @nb:	struct notifier_block * with callback info.
- * @event: value showing cpufreq event for which this function invoked.
- * @data: callback-specific data
- *
- * Callback to hijack the notification on cpufreq policy transition.
- * Every time there is a change in policy, we will intercept and
- * update the cpufreq policy with thermal constraints.
- *
- * Return: 0 (success)
- */
-static int cpufreq_thermal_notifier(struct notifier_block *nb,
-				    unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	unsigned long clipped_freq;
-	struct cpufreq_cooling_device *cpufreq_cdev;
-
-	if (event != CPUFREQ_ADJUST)
-		return NOTIFY_DONE;
-
-	mutex_lock(&cooling_list_lock);
-	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
-		/*
-		 * A new copy of the policy is sent to the notifier and can't
-		 * compare that directly.
-		 */
-		if (policy->cpu != cpufreq_cdev->policy->cpu)
-			continue;
-
-		/*
-		 * policy->max is the maximum allowed frequency defined by user
-		 * and clipped_freq is the maximum that thermal constraints
-		 * allow.
-		 *
-		 * If clipped_freq is lower than policy->max, then we need to
-		 * readjust policy->max.
-		 *
-		 * But, if clipped_freq is greater than policy->max, we don't
-		 * need to do anything.
-		 */
-		clipped_freq = cpufreq_cdev->clipped_freq;
-
-		if (policy->max > clipped_freq)
-			cpufreq_verify_within_limits(policy, 0, clipped_freq);
-		break;
-	}
-	mutex_unlock(&cooling_list_lock);
-
-	return NOTIFY_OK;
-}
-
 /**
  * update_freq_table() - Update the freq table with power numbers
  * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
@@ -374,7 +320,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -384,13 +329,10 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_cdev->cpufreq_state == state)
 		return 0;
 
-	clip_freq = cpufreq_cdev->freq_table[state].frequency;
 	cpufreq_cdev->cpufreq_state = state;
-	cpufreq_cdev->clipped_freq = clip_freq;
-
-	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
 
-	return 0;
+	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
+				cpufreq_cdev->freq_table[state].frequency);
 }
 
 /**
@@ -554,11 +496,6 @@ static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
 	.power2state		= cpufreq_power2state,
 };
 
-/* Notifier for cpufreq policy change */
-static struct notifier_block thermal_cpufreq_notifier_block = {
-	.notifier_call = cpufreq_thermal_notifier,
-};
-
 static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 				  unsigned int prev_max)
 {
@@ -596,9 +533,16 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	unsigned int freq, i, num_cpus;
+	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
-	bool first;
+
+	dev = get_cpu_device(policy->cpu);
+	if (unlikely(!dev)) {
+		pr_warn("No cpu device for cpu %d\n", policy->cpu);
+		return ERR_PTR(-ENODEV);
+	}
+
 
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
@@ -671,25 +615,29 @@ __cpufreq_cooling_register(struct device_node *np,
 		cooling_ops = &cpufreq_cooling_ops;
 	}
 
+	ret = dev_pm_qos_add_request(dev, &cpufreq_cdev->qos_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     cpufreq_cdev->freq_table[0].frequency);
+	if (ret < 0) {
+		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
+		       ret);
+		cdev = ERR_PTR(ret);
+		goto remove_ida;
+	}
+
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
-		goto remove_ida;
-
-	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
+		goto remove_qos_req;
 
 	mutex_lock(&cooling_list_lock);
-	/* Register the notifier for first cpufreq cooling device */
-	first = list_empty(&cpufreq_cdev_list);
 	list_add(&cpufreq_cdev->node, &cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
 
-	if (first)
-		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
-					  CPUFREQ_POLICY_NOTIFIER);
-
 	return cdev;
 
+remove_qos_req:
+	dev_pm_qos_remove_request(&cpufreq_cdev->qos_req);
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_table:
@@ -777,7 +725,6 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev;
-	bool last;
 
 	if (!cdev)
 		return;
@@ -786,15 +733,10 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_lock(&cooling_list_lock);
 	list_del(&cpufreq_cdev->node);
-	/* Unregister the notifier for the last cpufreq cooling device */
-	last = list_empty(&cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
 
-	if (last)
-		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
-					    CPUFREQ_POLICY_NOTIFIER);
-
 	thermal_cooling_device_unregister(cdev);
+	dev_pm_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
-- 
2.21.0.rc0.269.g1a574e7a288b

