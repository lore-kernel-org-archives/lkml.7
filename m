Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5665C2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhP79mrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfC0OgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:36:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40660 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfC0OgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:36:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so14632275ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Do62RarFZKiaJHchChMBUqt67JhmdRrqCmB3BM4qNsk=;
        b=KhP79mrRfRrsAir3ZbeLkpEDaUFnZcXgy4dlrUVtV8lML0eWBceZEwB0ezuPNHY+1c
         Iq1UJXV7GcgXCRg/xcAcpI4MhRAeR3Ll0LQKwPPgj60Xt3muNyAxwTK+WKwMYlApbkgr
         n1Uw3OLTWqi7HbQxkCZv5Fn+3qOjlxbAkU+B8B4RFb9qShGuTC9ad27zlG+1UQX8V94E
         jSqOGJW7wKzMSL5V5W0vVquYRSVmMwnr26ysFcHMGWO7oFAh99YyGCYSFX7tHqcUMzFf
         +dUJ0EdnCraD5KLu2v/H3sruhCmV+Vdk60NEBJLauuw+MGHLv/90O098+wvCCkGT1cur
         jrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Do62RarFZKiaJHchChMBUqt67JhmdRrqCmB3BM4qNsk=;
        b=ehzLQcfh6Q2U7BqBgYqD8hWnhE89KpWsSRALPU8YeDlD7L/q8mLuIFwX+PcXuSvu4r
         37/rShUCD6IUyFFvKYnm3ZSLXo/XUv009fZkTeRnsMTb+HG7l2mwQyWkxXBNgD90ln4B
         QyJeJcGUYLvFGNGsAUYBGF/IpyGXPmjjoxNXOXogK7v4CKwSIITyDRihsXFpXAtGTI0g
         35x8EeaAbxHzvkr0S+xl+OWAwZr1vVGKzfvdnwZEP4JHwBNMX0g40b5fxZUnIfyPTzyp
         9VCsFNDcJrfYQ9J212osGYmuCjzK88lh/+WoYU6UopAijqjoYK/7V5D5bbifrae26aOX
         Cr9A==
X-Gm-Message-State: APjAAAVR2Os2l1xtpDdcuAlfkGzwQIpJqlbQ87xFjRYrRyh8H2OV4C5S
        ZdQjXD1b0bU2h68wLVmoIOddFg==
X-Google-Smtp-Source: APXvYqxvJpHzjkikSC9P794Ufie27oyHGtWUvApWjshRK2vNSuvPv1H/ixxVqHnz+Ufj42EuSVQ5aQ==
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr18347734lje.138.1553697358467;
        Wed, 27 Mar 2019 07:35:58 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q2sm4548789lfj.58.2019.03.27.07.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:35:57 -0700 (PDT)
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
Subject: [PATCH 2/4] PM / Domains: Add support for CPU devices to genpd
Date:   Wed, 27 Mar 2019 15:35:46 +0100
Message-Id: <20190327143548.25305-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327143548.25305-1-ulf.hansson@linaro.org>
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable a device belonging to a CPU to be attached to a PM domain managed
by genpd, let's do a few changes to it, as to make it convenient to manage
the specifics around CPUs.

To be able to quickly find out what CPUs that are attached to a genpd,
which typically becomes useful from a genpd governor as following changes
is about to show, let's add a cpumask to the struct generic_pm_domain. At
the point when a CPU device gets attached to a genpd, let's update the
genpd's cpumask. Moreover, let's also propagate changes to the cpumask
upwards in the topology to the master PM domains. In this way, the cpumask
for a genpd hierarchically reflects all CPUs attached to the topology below
it.

Finally, let's make this an opt-in feature, to avoid having to manage CPUs
and the cpumask for a genpd that doesn't need it. For that reason, let's
add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v13:
	- None (re-based).

---
 drivers/base/power/domain.c | 65 ++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   | 13 ++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ff6f992f7a1d..ecac03dcc9b2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -128,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
+#define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -1454,6 +1456,56 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
+				   int cpu, bool set, unsigned int depth)
+{
+	struct gpd_link *link;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		__genpd_update_cpumask(master, cpu, set, depth + 1);
+		genpd_unlock(master);
+	}
+
+	if (set)
+		cpumask_set_cpu(cpu, genpd->cpus);
+	else
+		cpumask_clear_cpu(cpu, genpd->cpus);
+}
+
+static void genpd_update_cpumask(struct generic_pm_domain *genpd,
+				 struct device *dev, bool set)
+{
+	int cpu;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (get_cpu_device(cpu) == dev) {
+			__genpd_update_cpumask(genpd, cpu, set, 0);
+			return;
+		}
+	}
+}
+
+static void genpd_set_cpumask(struct generic_pm_domain *genpd,
+			      struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, true);
+}
+
+static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
+				struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, false);
+}
+
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
@@ -1475,6 +1527,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	genpd_lock(genpd);
 
+	genpd_set_cpumask(genpd, dev);
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1532,6 +1585,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
+	genpd_clear_cpumask(genpd, dev);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -1768,11 +1822,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
 
+	if (genpd_is_cpu_domain(genpd) &&
+	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
-		if (ret)
+		if (ret) {
+			if (genpd_is_cpu_domain(genpd))
+				free_cpumask_var(genpd->cpus);
 			return ret;
+		}
 	} else if (!gov && genpd->state_count > 1) {
 		pr_warn("%s: no governor for states\n", genpd->name);
 	}
@@ -1818,6 +1879,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	if (genpd_is_cpu_domain(genpd))
+		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
 		genpd->free_states(genpd->states, genpd->state_count);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8e1399231753..a6e251fe9deb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
+#include <linux/cpumask.h>
 
 /*
  * Flags to control the behaviour of a genpd.
@@ -42,11 +43,22 @@
  * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
  *				on, in case any of its attached devices is used
  *				in the wakeup path to serve system wakeups.
+ *
+ * GENPD_FLAG_CPU_DOMAIN:	Instructs genpd that it should expect to get
+ *				devices attached, which may belong to CPUs or
+ *				possibly have subdomains with CPUs attached.
+ *				This flag enables the genpd backend driver to
+ *				deploy idle power management support for CPUs
+ *				and groups of CPUs. Note that, the backend
+ *				driver must then comply with the so called,
+ *				last-man-standing algorithm, for the CPUs in the
+ *				PM domain.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
 #define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
+#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -94,6 +106,7 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
+	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-- 
2.17.1

