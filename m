Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D172087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SExylMA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfC0Okb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:40:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33662 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfC0Okb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:40:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so14655178ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Do62RarFZKiaJHchChMBUqt67JhmdRrqCmB3BM4qNsk=;
        b=SExylMA02q7PZ48R903XNHtcZaHznnBFU3GYNrYfefHUzLtJm5Lqun6991Y5jjWezc
         yRlM+36xvPbS5+hyrrtknzYodp/kGeczP6BqnfB3lMXC2QVRIUIg0jIYGQZ9atQ438Cu
         BNHaF/atI4/VMxQ+V3lO2Aw0EjVO4VjZjUh+24y0cxt/6tWgZV9wtIKqjBCfCarctrXb
         HGVRYsdUoaIe+7uyVSQ+04qkz/348Uj6Mk/35cXSqOhF9kMAvgrgTR8T4j5BRITKzdOM
         rlWknBBoa+jwwdnaiDMCqiIwOMGe4YVMHi4i4fuIPRX0xRMqGUMrfBeo8Ca4PGJLZy2h
         Yv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Do62RarFZKiaJHchChMBUqt67JhmdRrqCmB3BM4qNsk=;
        b=MqWjMtyU4ZOlp3DjRdv4Qj3+pCcJx8O1o1C2vfl72MX0GN7oKf2MJd19JgGbVOP/5T
         t8XTRGrm4/AGTW1YJlpxzKO13S+HkGPPA8WkXhBald4bMrHwoxhJyxm7K+XVzjmF+QPi
         kjpYdrcLJ4cath5iHp1d+/5XtiDSUawWib640cMy1cU99IWKXY2akogpbwGi50tQkBbv
         6xKvxeysBlfQrPfnzm8tUOWUAcXZ+aSjmVgZhGN2rqzGOwmrvdmOjR86klxVMc75RVCy
         fS16atZj7hzoNJFhVZHr/LoqShH7dr3skOHtJLkjcKjbHvc3yIN4N5xn/zeVnxjuHjgY
         FZ4g==
X-Gm-Message-State: APjAAAXDoG0cvNoSn+xTmIZTJGceenKVW+tZf08eILbir3VKfLoTazQa
        rduLcQbWw6U2TifHVOTN71JeQw==
X-Google-Smtp-Source: APXvYqzjdwuDI5vxyAhyj7gxalpzOXpSx3KUDHUetkufjXTlih/+CyBnThwqhfzHkK5w4ELgH0oc1g==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr3023901ljh.60.1553697627798;
        Wed, 27 Mar 2019 07:40:27 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f19sm4604376lfk.69.2019.03.27.07.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:40:26 -0700 (PDT)
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
Subject: [PATCH v13 2/4] PM / Domains: Add support for CPU devices to genpd
Date:   Wed, 27 Mar 2019 15:40:23 +0100
Message-Id: <20190327144023.25383-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
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

