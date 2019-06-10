Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814AC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EF62082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/pp7YAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbfFJKwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:52:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfFJKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:52:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so3130751pgr.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD3T9MCLCYxGulnk73bKwaz231dtpYkEEua08iZOx+I=;
        b=O/pp7YAF1RQo1GHkZFg7/2+iN63SCUFnDo2HrYxtseC2jdETBLug2Cy6VuaKvodXEc
         iOcx+FdEs8SHR9TUP3phFqxDI51GfhRsVuzEktr2bjp4Ma2+/QW+koEZHNxeJZ+ZTF7x
         4TVvr6twnVpNtXTGZTzzxVHif81lCN42VWHAf/035AhvnQk7Xh5SOLUw81IYtDoZWnqb
         H7gTgLE9A9MX/MpIJaciG+v2nOlZMDXPZ82iFEYMQHHQx8rgffspLwokmo+Uy/qYpYJA
         5rbIX8HIvXF9HfnPIv6FfcL4m9/V+Q7pIkzsFlQmWoOsrN/ns9hHcpoC2fabtb6Mt/Cl
         RuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD3T9MCLCYxGulnk73bKwaz231dtpYkEEua08iZOx+I=;
        b=ETidjIBVDDceq7MSxtpjZydQ+3+T8AVorndwqodsc5Vwl5516vbRhnI4lF3wIMhF6y
         tct1GiyfuGDQa4l0V7kjtmTx3Vnc+yLO0a9mkeWFP0PTtNhV37/6pVUk/y/GbkdkiWak
         oKAFKtll2VhHr5JuVeIDi0cNuih7opX0FwjGYzPvb1toFulC1Hy1fbxN11jwypD5KzzA
         fNK6FRtN6fpyCeeD9gOQKzXCszTN39zxJz0fV1pHhPUGHhdmaeIZkIA6jHw3nNrExLmX
         4RO+WbOewnROGLykaXK4To+NWo7tmq2MAOEdsJqAWGhHEipvPTBVcOvfLiSa/czwsUuQ
         7g+Q==
X-Gm-Message-State: APjAAAUGFT4NxRxDY0QLdb45/WRRT6ZLdTElONUt4H+glM0b6RmC7cJM
        +AiT2LL8EPoTuqyZGvSLWxnAXg==
X-Google-Smtp-Source: APXvYqxdUDW1A1kx7znA7bJUchTxzDsoqXPdO+Nt0Syv8PE4m8vmNIHuBm8hS6oPpvVMcsD5yCyaBw==
X-Received: by 2002:a65:4b88:: with SMTP id t8mr15619667pgq.374.1560163923691;
        Mon, 10 Jun 2019 03:52:03 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id m5sm19858101pgn.59.2019.06.10.03.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:52:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS framework
Date:   Mon, 10 Jun 2019 16:21:35 +0530
Message-Id: <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This registers the notifiers for min/max frequency constraints with the
PM QoS framework. The constraints are also taken into consideration in
cpufreq_set_policy().

This also relocates cpufreq_policy_put_kobj() as it is required to be
called from cpufreq_policy_alloc() now.

No constraints are added until now though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
 include/linux/cpufreq.h   |   4 ++
 2 files changed, 120 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..547d221b2ff2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
 	cpufreq_update_policy(cpu);
 }
 
+static void cpufreq_update_freq_work(struct work_struct *work)
+{
+	struct cpufreq_policy *policy =
+		container_of(work, struct cpufreq_policy, req_work);
+	struct cpufreq_policy new_policy = *policy;
+
+	/* We should read constraint values from QoS layer */
+	new_policy.min = 0;
+	new_policy.max = UINT_MAX;
+
+	down_write(&policy->rwsem);
+
+	if (!policy_is_inactive(policy))
+		cpufreq_set_policy(policy, &new_policy);
+
+	up_write(&policy->rwsem);
+}
+
+static int cpufreq_update_freq(struct cpufreq_policy *policy)
+{
+	schedule_work(&policy->req_work);
+	return 0;
+}
+
+static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
+
+	return cpufreq_update_freq(policy);
+}
+
+static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
+
+	return cpufreq_update_freq(policy);
+}
+
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+{
+	struct kobject *kobj;
+	struct completion *cmp;
+
+	down_write(&policy->rwsem);
+	cpufreq_stats_free_table(policy);
+	kobj = &policy->kobj;
+	cmp = &policy->kobj_unregister;
+	up_write(&policy->rwsem);
+	kobject_put(kobj);
+
+	/*
+	 * We need to make sure that the underlying kobj is
+	 * actually not referenced anymore by anybody before we
+	 * proceed with unloading.
+	 */
+	pr_debug("waiting for dropping of refcount\n");
+	wait_for_completion(cmp);
+	pr_debug("wait complete\n");
+}
+
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	struct device *dev = get_cpu_device(cpu);
 	int ret;
 
+	if (!dev)
+		return NULL;
+
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1147,7 +1214,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
 		/*
 		 * The entire policy object will be freed below, but the extra
 		 * memory allocated for the kobject name needs to be freed by
@@ -1157,16 +1224,41 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	policy->nb_min.notifier_call = cpufreq_notifier_min;
+	policy->nb_max.notifier_call = cpufreq_notifier_max;
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_kobj_remove;
+	}
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_min_qos_notifier;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
+	INIT_WORK(&policy->req_work, cpufreq_update_freq_work);
 
 	policy->cpu = cpu;
 	return policy;
 
+err_min_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+err_kobj_remove:
+	cpufreq_policy_put_kobj(policy);
 err_free_real_cpus:
 	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
@@ -1179,30 +1271,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
-{
-	struct kobject *kobj;
-	struct completion *cmp;
-
-	down_write(&policy->rwsem);
-	cpufreq_stats_free_table(policy);
-	kobj = &policy->kobj;
-	cmp = &policy->kobj_unregister;
-	up_write(&policy->rwsem);
-	kobject_put(kobj);
-
-	/*
-	 * We need to make sure that the underlying kobj is
-	 * actually not referenced anymore by anybody before we
-	 * proceed with unloading.
-	 */
-	pr_debug("waiting for dropping of refcount\n");
-	wait_for_completion(cmp);
-	pr_debug("wait complete\n");
-}
-
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
+	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned long flags;
 	int cpu;
 
@@ -1214,6 +1285,10 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -2290,6 +2365,8 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 		       struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2304,11 +2381,27 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (new_policy->min > new_policy->max)
 		return -EINVAL;
 
+	/*
+	 * PM QoS framework collects all the requests from users and provide us
+	 * the final aggregated value here.
+	 */
+	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
+
+	if (min > new_policy->min)
+		new_policy->min = min;
+	if (max < new_policy->max)
+		new_policy->max = max;
+
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
 
+	/*
+	 * The notifier-chain shall be removed once all the users of
+	 * CPUFREQ_ADJUST are moved to use the QoS framework.
+	 */
 	/* adjust if necessary - all reasons */
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_ADJUST, new_policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..0fe7678da9c2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -83,6 +83,7 @@ struct cpufreq_policy {
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
+	struct work_struct	req_work;
 
 	struct cpufreq_user_policy user_policy;
 	struct cpufreq_frequency_table	*freq_table;
@@ -147,6 +148,9 @@ struct cpufreq_policy {
 
 	/* Pointer to the cooling device if used for thermal mitigation */
 	struct thermal_cooling_device *cdev;
+
+	struct notifier_block nb_min;
+	struct notifier_block nb_max;
 };
 
 struct cpufreq_freqs {
-- 
2.21.0.rc0.269.g1a574e7a288b

