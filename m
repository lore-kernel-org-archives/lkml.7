Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCE219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRKviTX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfHGHGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:06:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43426 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfHGHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:06:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so32311778pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP7WtIX8WuuPc2QyYwkR7MBl6FcTzg8DxX/JykR288c=;
        b=RRKviTX6toH/7yNLtlJODs7ECpfQ76vl7lQIacOecjZHLqg6iofmuELQjUqeqNtLyr
         ILArp90c75xLvJAVLRpjKs7VtH426mMBbvjaGkvTlUHtR+ID1Qrqria2ow8XPLbB5YfV
         JHQC5eD115e/vQmH/QKK4fAoJD/AVmr3ssvI238PeJ1W/sUba8j+ThIw9E08shuMCP4U
         W7lO53n6viOQpB0lEdM8WlXnjPB1diQqQ//x6nF8snusbShJApRw85KOKtQQnqZC1oIP
         6hlGs5O+O23RQ7G+v3+Mib3CLwG5rCNmpgp68pHlb02sJbkcJPVX0R1yWv6zxcdaOVBy
         hZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP7WtIX8WuuPc2QyYwkR7MBl6FcTzg8DxX/JykR288c=;
        b=rpyvUijAnfwk9uoM2ZbkDX8IOAzs2IzNdTp3MZrqR2zdJFZoq9TOMjLWqUKthiec3N
         gFINrLAPzGU33A/inBxaOz45GB/kk5nUhzc7+GMfDacH1TeCAL29seZaQoLwrb1OEqdk
         IjZ+fi2dEXFa6BxcRT9Tb8Y/xOZlBOmQjU+TfxuIjSx/EtKHe9WyUl9qji7Zx8yV7pXh
         PF1fju3W7oyBWQpS+LBwXD1EkDfrcbU/2IkYmeJbPm5wFwjonjkFkxdeu7Fxd/1luv8b
         Q6k+c/pYRmDowkweB4RrKICrheBkRoN/2Lb5zvK8u2FYxpAp5l8EYbm/UmkUrJHopU+k
         qU8w==
X-Gm-Message-State: APjAAAWFEZpO/GFFmie8jNSXXSdrg2GJsOBvgXjydO7i5M6jCAKUms5I
        5vNzE3WGIZRqpbFkdFlBrEbHFQ==
X-Google-Smtp-Source: APXvYqxXcGf4kGZGFDUWRqQomONIVyB/5kgZrxfDeL4NnSYLhNN7vbmiQzj5W8AyGROze0t9+xZe3A==
X-Received: by 2002:a63:903:: with SMTP id 3mr6416426pgj.371.1565161571879;
        Wed, 07 Aug 2019 00:06:11 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id bg3sm36281178pjb.9.2019.08.07.00.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 00:06:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] cpufreq: intel_pstate: Implement QoS supported freq constraints
Date:   Wed,  7 Aug 2019 12:36:02 +0530
Message-Id: <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
References: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel pstate driver exposes min_perf_pct and max_perf_pct sysfs files,
which can be used to force a limit on the min/max P state of the driver.
Though these files eventually control the min/max frequencies that the
CPUs will run at, they don't make a change to policy->min/max values.

When the values of these files are changed (in passive mode of the
driver), it leads to calling ->limits() callback of the cpufreq
governors, like schedutil. On a call to it the governors shall
forcefully update the frequency to come within the limits. Since the
limits, i.e.  policy->min/max, aren't updated by the driver, the
governors fails to get the target freq within limit and sometimes aborts
the update believing that the frequency is already set to the target
value.

This patch implements the QoS supported frequency constraints to update
policy->min/max values whenever min_perf_pct or max_perf_pct files are
updated. This is only done for the passive mode as of now, as the driver
is already working fine in active mode.

Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Reimplemented the solution using QoS constraints instead of
  resolve_freq() callback.

 drivers/cpufreq/intel_pstate.c | 120 +++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cc27d4c59dca..e9fbd6c36822 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
+#include <linux/pm_qos.h>
 #include <trace/events/power.h>
 
 #include <asm/div64.h>
@@ -1085,6 +1086,47 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 	return count;
 }
 
+static struct cpufreq_driver intel_pstate;
+
+static void update_qos_request(enum dev_pm_qos_req_type type)
+{
+	int max_state, turbo_max, freq, i, perf_pct;
+	struct dev_pm_qos_request *req;
+	struct cpufreq_policy *policy;
+
+	for_each_possible_cpu(i) {
+		struct cpudata *cpu = all_cpu_data[i];
+
+		policy = cpufreq_cpu_get(i);
+		if (!policy)
+			continue;
+
+		req = policy->driver_data;
+		cpufreq_cpu_put(policy);
+
+		if (!req)
+			continue;
+
+		if (hwp_active)
+			intel_pstate_get_hwp_max(i, &turbo_max, &max_state);
+		else
+			turbo_max = cpu->pstate.turbo_pstate;
+
+		if (type == DEV_PM_QOS_MIN_FREQUENCY) {
+			perf_pct = global.min_perf_pct;
+		} else {
+			req++;
+			perf_pct = global.max_perf_pct;
+		}
+
+		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
+		freq *= cpu->pstate.scaling;
+
+		if (dev_pm_qos_update_request(req, freq))
+			pr_warn("Failed to update freq constraint: CPU%d\n", i);
+	}
+}
+
 static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 				  const char *buf, size_t count)
 {
@@ -1108,7 +1150,10 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	intel_pstate_update_policies();
+	if (intel_pstate_driver == &intel_pstate)
+		intel_pstate_update_policies();
+	else
+		update_qos_request(DEV_PM_QOS_MAX_FREQUENCY);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1139,7 +1184,10 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	intel_pstate_update_policies();
+	if (intel_pstate_driver == &intel_pstate)
+		intel_pstate_update_policies();
+	else
+		update_qos_request(DEV_PM_QOS_MIN_FREQUENCY);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -2332,8 +2380,16 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int ret = __intel_pstate_cpu_init(policy);
+	int max_state, turbo_max, min_freq, max_freq, ret;
+	struct dev_pm_qos_request *req;
+	struct cpudata *cpu;
+	struct device *dev;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
 
+	ret = __intel_pstate_cpu_init(policy);
 	if (ret)
 		return ret;
 
@@ -2342,7 +2398,63 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	req = kcalloc(2, sizeof(*req), GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto pstate_exit;
+	}
+
+	cpu = all_cpu_data[policy->cpu];
+
+	if (hwp_active)
+		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
+	else
+		turbo_max = cpu->pstate.turbo_pstate;
+
+	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
+	min_freq *= cpu->pstate.scaling;
+	max_freq = DIV_ROUND_UP(turbo_max * global.max_perf_pct, 100);
+	max_freq *= cpu->pstate.scaling;
+
+	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_MIN_FREQUENCY,
+				     min_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
+		goto free_req;
+	}
+
+	ret = dev_pm_qos_add_request(dev, req + 1, DEV_PM_QOS_MAX_FREQUENCY,
+				     max_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
+		goto remove_min_req;
+	}
+
+	policy->driver_data = req;
+
 	return 0;
+
+remove_min_req:
+	dev_pm_qos_remove_request(req);
+free_req:
+	kfree(req);
+pstate_exit:
+	intel_pstate_exit_perf_limits(policy);
+
+	return ret;
+}
+
+static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct dev_pm_qos_request *req;
+
+	req = policy->driver_data;
+
+	dev_pm_qos_remove_request(req + 1);
+	dev_pm_qos_remove_request(req);
+	kfree(req);
+
+	return intel_pstate_cpu_exit(policy);
 }
 
 static struct cpufreq_driver intel_cpufreq = {
@@ -2351,7 +2463,7 @@ static struct cpufreq_driver intel_cpufreq = {
 	.target		= intel_cpufreq_target,
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
-	.exit		= intel_pstate_cpu_exit,
+	.exit		= intel_cpufreq_cpu_exit,
 	.stop_cpu	= intel_cpufreq_stop_cpu,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
-- 
2.21.0.rc0.269.g1a574e7a288b

