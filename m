Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA887C10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869442146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoB0C/P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfC0OgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:36:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34876 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfC0OgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:36:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so11559260lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/DRGI4bD5hxWQz0RfripmToZCqku1wrBoz6VqQCAxM=;
        b=AoB0C/P6/wN599c40fA7FnfEHKiR7xeJ7iQmmglTyYj5F7TdqnpFwOiPVkri1hG8sp
         ARptOc6fXizzOnP4L5FQuk5esopJcWQ+JW8LnKxDNbXzcZ+IAjOG+346RpopY45y7NCv
         XN9qFMtVdnzZ1twakoIFLSjUOCID5QPM6ZL2TdIVgshdDxw2edfQ5xZpKXu2/bJUNsr6
         WujH02a4iLbZyLLKr303Cd/xcwky2IRKn1/FPMIauCLVndH7lwpAi2Cd+OHZjqdPEyrO
         I01box3+bUsmQsyzJF/nigg3kCfs6jS8swImNBcEH7LbM0wZ5+SJTm1TwdTIr0KUsHSV
         PstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/DRGI4bD5hxWQz0RfripmToZCqku1wrBoz6VqQCAxM=;
        b=GUrdpaklFdpOa/2KvJxrAD9BrCw+ukboS9X0hcgaUwVvkQrZLx6xb9P+HgFd/xgxeF
         gizxKM//Ma41GezJZr32OTYGDpsKEC0iJt6yP+VgGp7t8E2rXGouPySksD0Gu7nWG3RA
         /2kT0XzAaYDZMi+fQfnRRK0T3A0t6pbllexVbOcSLZjckfpJBD9EnHb125jOCwdxTF/b
         1/+3ErCbHwMGxEwzhR22ZgNmyaQWF6K9DjWnqrii2VFf8W+kVpAnTAfswZ+JZ8HzgpdG
         e4puBrpQ82rVjypt8ZEaeosCKpJAJG5/apNRLQ0dKclYZrvUvp8/KqevEc8RuWmH2iT8
         JkEA==
X-Gm-Message-State: APjAAAWDSiHc1rfhVGAWmdiHajLOEbrIuJdv4kHWoCfHCJWl7VcCQWJv
        7iwCFkurQWHk6PuJXquMJx1/Pg==
X-Google-Smtp-Source: APXvYqwVSECMJDyPtKk3qdNVbNspLWl8YfiJbJb0coBO8l42U3F7Cr7jGh2Pwe9hzNBWHEBxdliY8A==
X-Received: by 2002:a19:4b53:: with SMTP id y80mr20608817lfa.146.1553697362971;
        Wed, 27 Mar 2019 07:36:02 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q2sm4548789lfj.58.2019.03.27.07.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:36:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 4/4] PM / Domains: Add genpd governor for CPUs
Date:   Wed, 27 Mar 2019 15:35:48 +0100
Message-Id: <20190327143548.25305-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327143548.25305-1-ulf.hansson@linaro.org>
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's now perfectly possible that a PM domain managed by genpd contains
devices belonging to CPUs, we should start to take into account the
residency values for the idle states during the state selection process.
The residency value specifies the minimum duration of time, the CPU or a
group of CPUs, needs to spend in an idle state to not waste energy entering
it.

To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
may be used for a PM domain that have CPU devices attached or if the CPUs
are attached through subdomains.

The new governor computes the minimum expected idle duration time for the
online CPUs being attached to the PM domain and its subdomains. Then in the
state selection process, trying the deepest state first, it verifies that
the idle duration time satisfies the state's residency value.

It should be noted that, when computing the minimum expected idle duration
time, we use the information about the next timer/tick that is stored in
the per CPU variable, cpuidle_devices, for the related CPUs. Future wise,
this deserves to be improved, as there are obviously more reasons to why a
CPU may be woken up from idle.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v13:
	- As suggested by Rafael, use READ_ONCE when reading the next_hrtimer
	variable.

---
 drivers/base/power/domain_governor.c | 65 +++++++++++++++++++++++++++-
 include/linux/pm_domain.h            |  3 ++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 4d07e38a8247..7f9b80f46b3a 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
@@ -210,8 +213,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -236,6 +241,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -244,6 +250,58 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpuidle_device *dev;
+	ktime_t domain_wakeup, next_hrtimer;
+	s64 idle_duration_ns;
+	int cpu, i;
+
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
+		return true;
+
+	/*
+	 * Find the next wakeup for any of the online CPUs within the PM domain
+	 * and its subdomains. Note, we only need the genpd->cpus, as it already
+	 * contains a mask of all CPUs from subdomains.
+	 */
+	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		if (dev) {
+			next_hrtimer = READ_ONCE(dev->next_hrtimer);
+			if (ktime_before(next_hrtimer, domain_wakeup))
+				domain_wakeup = next_hrtimer;
+		}
+	}
+
+	/* The minimum idle duration is from now - until the next wakeup. */
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	if (idle_duration_ns <= 0)
+		return false;
+
+	/*
+	 * Find the deepest idle state that has its residency value satisfied
+	 * and by also taking into account the power off latency for the state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
+	 */
+	i = genpd->state_idx;
+	do {
+		if (idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) {
+			genpd->state_idx = i;
+			return true;
+		}
+	} while (--i >= 0);
+
+	return false;
+}
+
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
@@ -256,3 +314,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
 	.power_down_ok = always_on_power_down_ok,
 	.suspend_ok = default_suspend_ok,
 };
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = default_suspend_ok,
+	.power_down_ok = cpu_power_down_ok,
+};
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a6e251fe9deb..ae7061556a26 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,6 +118,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -202,6 +203,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern struct dev_power_governor pm_domain_cpu_gov;
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -245,6 +247,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
+#define pm_domain_cpu_gov		(*(struct dev_power_governor *)(NULL))
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-- 
2.17.1

