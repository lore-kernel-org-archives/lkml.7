Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCA2206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JMyHQH/C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ljjaUzVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfC1P3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfC1P3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:29:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2CDA619C6; Thu, 28 Mar 2019 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786941;
        bh=CXIkHPKNCSxKMJ9BxS5wFSnViYneB1z5X+9DDurq+Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMyHQH/CuYqOmssDB6CKi2xrfYEtXH2kOu/CpsRZjIgxX9Rm2Cwb6trnCJiowNIMQ
         Jxt6bE320Xu5kHqyM4CL45K98jhfCMNP3HfDyQP6lmF7xET0O+6htLTGHum0sEaTdf
         t3E5rrAYIl+EGcglM/rqLW93v9EqNnELhw2mm66M=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B70EA6192C;
        Thu, 28 Mar 2019 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786938;
        bh=CXIkHPKNCSxKMJ9BxS5wFSnViYneB1z5X+9DDurq+Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljjaUzVgNkRM9wTQPIYoVKpZciQM9kT+GqvFhoM2XwW67mWlWzhdfsQo4IhW8II0h
         jQFTMeMEqwO0lHI8Nn8QFrdG2ZaX1AsKCEyEWSj3dcM90+DZ7MfLU3dp9jsSReQut4
         oCNRiUxUgdotsJDAJFsJXm+Cj4DE1Id55ICMRAzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B70EA6192C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to passive_governor
Date:   Thu, 28 Mar 2019 20:58:16 +0530
Message-Id: <20190328152822.532-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the
CPUs. Frequency scaling of the caches is necessary to make sure the cache
is not a performance bottleneck that leads to poor performance and
power. The same idea applies for RAM/DDR.

To achieve this, this patch add support for cpu based scaling to the
passive governor. This is accomplished by taking the current frequency
of each CPU frequency domain and then adjusts the frequency of the cache
(or any devfreq device) based on the frequency of the CPUs. It listens
to CPU frequency transition notifiers to keep itself up to date on the
current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:
* Constructs a CPU frequency to device frequency mapping table from
  required-opps property of the devfreq device's opp_table

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: Integrated cpu-freqmap governor into passive_governor]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/devfreq/Kconfig            |   4 +
 drivers/devfreq/governor_passive.c | 276 ++++++++++++++++++++++++++++-
 include/linux/devfreq.h            |  43 ++++-
 3 files changed, 315 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d338f6d..9a45f464a56b 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -72,6 +72,10 @@ config DEVFREQ_GOV_PASSIVE
 	  device. This governor does not change the frequency by itself
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
+	  Alternatively the governor can also be chosen to scale based on
+	  the online CPUs current frequency. A CPU frequency to device
+	  frequency mapping table(s) is auto-populated by the governor
+	  for this purpose.
 
 comment "DEVFREQ Drivers"
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..2506682b233b 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -11,10 +11,63 @@
  */
 
 #include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
+#include <linux/of.h>
+#include <linux/slab.h>
 #include "governor.h"
 
+static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
+					     unsigned int cpu)
+{
+	unsigned int cpu_min, cpu_max;
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	unsigned int dev_min, dev_max, cpu_percent, cpu_freq = 0, freq = 0;
+	unsigned long *freq_table = devfreq->profile->freq_table;
+	struct device *dev = devfreq->dev.parent;
+	struct devfreq_map *map;
+	int opp_cnt, i;
+
+	if (!data->state[cpu] || data->state[cpu]->first_cpu != cpu) {
+		freq = 0;
+		goto out;
+	}
+
+	/* Use Interpolation if map is not available */
+	cpu_freq = data->state[cpu]->freq;
+	if (!data->map) {
+		cpu_min = data->state[cpu]->min_freq;
+		cpu_max = data->state[cpu]->max_freq;
+		if (freq_table) {
+			dev_min = freq_table[0];
+			dev_max = freq_table[devfreq->profile->max_state - 1];
+		} else {
+			if (devfreq->max_freq <= devfreq->min_freq)
+				return 0;
+			dev_min = devfreq->min_freq;
+			dev_max = devfreq->max_freq;
+		}
+
+		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
+		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+		goto out;
+	}
+
+	map = data->map[cpu];
+	opp_cnt = dev_pm_opp_get_opp_count(dev);
+	for (i = 0; i < opp_cnt; i++) {
+		freq = max(freq, map[i].dev_hz);
+		if (map[i].cpu_khz >= cpu_freq)
+			break;
+	}
+out:
+	dev_dbg(dev, "CPU%u: %d -> dev: %u\n", cpu, cpu_freq, freq);
+	return freq;
+}
+
 static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 					unsigned long *freq)
 {
@@ -23,6 +76,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
 	struct dev_pm_opp *opp;
+	unsigned int cpu, tgt_freq = 0;
 	int i, count, ret = 0;
 
 	/*
@@ -35,6 +89,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 		goto out;
 	}
 
+	if (p_data->cpufreq_type) {
+		for_each_possible_cpu(cpu)
+			tgt_freq = max(tgt_freq,
+				       xlate_cpufreq_to_devfreq(p_data, cpu));
+		*freq = tgt_freq;
+		goto out;
+	}
+
 	/*
 	 * If the parent and passive devfreq device uses the OPP table,
 	 * get the next frequency by using the OPP table.
@@ -149,6 +211,200 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int cpufreq_passive_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *data =
+			container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	struct cpufreq_freqs *freq = ptr;
+	struct devfreq_cpu_state *state;
+	int ret = 0;
+
+	if (event != CPUFREQ_POSTCHANGE)
+		goto out;
+
+	state = data->state[freq->cpu];
+	if (!state)
+		goto out;
+
+	if (state->freq != freq->new) {
+		state->freq = freq->new;
+		mutex_lock(&devfreq->lock);
+		ret = update_devfreq(devfreq);
+		mutex_unlock(&devfreq->lock);
+		if (ret)
+			dev_err(&devfreq->dev, "Frequency update failed.\n");
+	}
+out:
+	return ret;
+}
+
+static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
+{
+	unsigned int cpu;
+	struct devfreq_map **cpu_map;
+	struct devfreq_map *map, *per_cpu_map;
+	struct devfreq_passive_data *data = *p_data;
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	int i, count = 0, opp_cnt = 0, ret = 0, iter_val = 0;
+	struct device_node *np, *opp_table_np, *cpu_np;
+	struct opp_table *opp_table, *cpu_opp_tbl;
+	struct device *dev = devfreq->dev.parent;
+	struct devfreq_cpu_state *state;
+	struct dev_pm_opp *opp, *cpu_opp;
+	struct cpufreq_policy *policy;
+	struct device *cpu_dev;
+	u64 cpu_khz, dev_hz;
+
+	get_online_cpus();
+	data->nb.notifier_call = cpufreq_passive_notifier_call;
+	ret = cpufreq_register_notifier(&data->nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret)
+		return ret;
+
+	/* Populate devfreq_cpu_state */
+	for_each_online_cpu(cpu) {
+		if (data->state[cpu])
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (policy) {
+			state = kzalloc(sizeof(*state), GFP_KERNEL);
+			if (!state)
+				return -ENOMEM;
+
+			state->first_cpu = cpumask_first(policy->related_cpus);
+			state->freq = policy->cur;
+			state->min_freq = policy->cpuinfo.min_freq;
+			state->max_freq = policy->cpuinfo.max_freq;
+			data->state[cpu] = state;
+			cpufreq_cpu_put(policy);
+		} else {
+			return -EPROBE_DEFER;
+		}
+	}
+
+	opp_table_np = dev_pm_opp_of_get_opp_desc_node(dev);
+	if (!opp_table_np)
+		goto out;
+
+	opp_cnt = dev_pm_opp_get_opp_count(dev);
+	if (opp_cnt <= 0)
+		goto put_opp_table;
+
+	/* Allocate memory for devfreq_map*/
+	cpu_map = kcalloc(num_possible_cpus(), sizeof(*cpu_map), GFP_KERNEL);
+	if (!cpu_map)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu_map = kcalloc(opp_cnt, sizeof(*per_cpu_map),
+				      GFP_KERNEL);
+		if (!per_cpu_map)
+			return -ENOMEM;
+		cpu_map[cpu] = per_cpu_map;
+	}
+	data->map = cpu_map;
+
+	/* Populate devfreq_map */
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return -ENOMEM;
+
+	for_each_available_child_of_node(opp_table_np, np) {
+		opp = dev_pm_opp_find_opp_of_np(opp_table, np);
+		if (IS_ERR(opp))
+			continue;
+
+		dev_hz = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+
+		count = of_count_phandle_with_args(np, "required-opps", NULL);
+		for (i = 0; i < count; i++) {
+			for_each_possible_cpu(cpu) {
+				cpu_dev = get_cpu_device(cpu);
+				if (!cpu_dev) {
+					dev_err(dev, "CPU get device failed.\n");
+					continue;
+				}
+
+				cpu_np = of_parse_required_opp(np, i);
+				if (!cpu_np) {
+					dev_err(dev, "Parsing required opp failed.\n");
+					continue;
+				}
+
+				/* Get cpu opp-table */
+				cpu_opp_tbl = dev_pm_opp_get_opp_table(cpu_dev);
+				if (!cpu_opp_tbl) {
+					dev_err(dev, "CPU opp table get failed.\n");
+					goto put_cpu_node;
+				}
+
+				/* Match the cpu opp node from required-opp with
+				 * the cpu-opp table */
+				cpu_opp = dev_pm_opp_find_opp_of_np(cpu_opp_tbl,
+								    cpu_np);
+				if (!cpu_opp) {
+					dev_dbg(dev, "CPU opp get failed.\n");
+					goto put_cpu_opp_table;
+				}
+
+				cpu_khz = dev_pm_opp_get_freq(cpu_opp);
+				if (cpu_opp && cpu_khz) {
+					/* Update freq-map if not already set */
+					map = cpu_map[cpu];
+					map[iter_val].cpu_khz = cpu_khz / 1000;
+					map[iter_val].dev_hz = dev_hz;
+				}
+				dev_pm_opp_put(cpu_opp);
+put_cpu_opp_table:
+				dev_pm_opp_put_opp_table(cpu_opp_tbl);
+put_cpu_node:
+				of_node_put(cpu_np);
+			}
+		}
+		iter_val++;
+	}
+	dev_pm_opp_put_opp_table(opp_table);
+put_opp_table:
+	of_node_put(opp_table_np);
+out:
+	put_online_cpus();
+
+	/* Update devfreq */
+	mutex_lock(&devfreq->lock);
+	ret = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (ret)
+		dev_err(dev, "Frequency update failed.\n");
+
+	return ret;
+}
+
+static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
+{
+	int cpu;
+	struct devfreq_passive_data *data = *p_data;
+
+	cpufreq_unregister_notifier(&data->nb,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	for_each_possible_cpu(cpu) {
+		kfree(data->state[cpu]);
+		kfree(data->map[cpu]);
+		data->state[cpu] = NULL;
+		data->map[cpu] = NULL;
+	}
+
+	kfree(data->map);
+	data->map = NULL;
+
+	return 0;
+}
+
 static int devfreq_passive_event_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
@@ -159,7 +415,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	struct notifier_block *nb = &p_data->nb;
 	int ret = 0;
 
-	if (!parent)
+	if (!parent && !p_data->cpufreq_type)
 		return -EPROBE_DEFER;
 
 	switch (event) {
@@ -167,13 +423,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
-		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devm_devfreq_register_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->cpufreq_type) {
+			ret = cpufreq_passive_register(&p_data);
+		} else {
+			nb->notifier_call = devfreq_passive_notifier_call;
+			ret = devm_devfreq_register_notifier(dev, parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER);
+		}
 		break;
 	case DEVFREQ_GOV_STOP:
-		devm_devfreq_unregister_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->cpufreq_type) {
+			cpufreq_passive_unregister(&p_data);
+		} else {
+			devm_devfreq_unregister_notifier(dev, parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER);
+		}
 		break;
 	default:
 		break;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fbffa74bfc1b..e8235fbe49e6 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -265,6 +265,38 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+/**
+ * struct devfreq_cpu_state - holds the per-cpu state
+ * @freq:	holds the current frequency of the cpu.
+ * @min_freq:	holds the min frequency of the cpu.
+ * @max_freq:	holds the max frequency of the cpu.
+ * @first_cpu:	holds the cpumask of the first cpu of a policy.
+ *
+ * This structure stores the required cpu_state of a cpu.
+ * This is auto-populated by the governor.
+ */
+struct devfreq_cpu_state {
+	unsigned int freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+	unsigned int first_cpu;
+};
+
+/**
+ * struct devfreq_map - holds mapping from cpu frequency
+ * to devfreq frequency
+ * @cpu_khz:	holds the cpu frequency in Khz
+ * @dev_hz:	holds the devfreq device frequency in Hz
+ *
+ * This structure stores the lookup table between cpu
+ * and the devfreq device. This is auto-populated by the
+ * governor.
+ */
+struct devfreq_map {
+	unsigned int cpu_khz;
+	unsigned int dev_hz;
+};
+
 /**
  * struct devfreq_passive_data - void *data fed to struct devfreq
  *	and devfreq_add_device
@@ -278,11 +310,13 @@ struct devfreq_simple_ondemand_data {
  *			the next frequency, should use this callback.
  * @this:	the devfreq instance of own device.
  * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ * @state:	holds the state min/max/current frequency of all online cpu's
+ * @map:	holds the maps between cpu frequency and device frequency
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
- * initialize the 'this' and 'nb' field because the devfreq core will handle
- * them.
+ * initialize the 'this', 'nb', 'state' and 'map' field because the devfreq
+ * core will handle them.
  */
 struct devfreq_passive_data {
 	/* Should set the devfreq instance of parent device */
@@ -291,9 +325,14 @@ struct devfreq_passive_data {
 	/* Optional callback to decide the next frequency of passvice device */
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 
+	/* Should be set if the devfreq device wants to be scaled with cpu*/
+	u8 cpufreq_type;
+
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
+	struct devfreq_cpu_state *state[NR_CPUS];
+	struct devfreq_map **map;
 };
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

