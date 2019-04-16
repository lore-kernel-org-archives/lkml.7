Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97160C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FD020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVECsf/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfDPTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:38:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43995 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:38:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so24679825qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TguL0qXFpdoQPdCMMxXUN1DOZgs5y7WCqH1cN7imVPk=;
        b=RVECsf/Ty8kRUb5hdZswhPos288RtA8hIoPKCB2YLr+FY3aBAkjByxifi5roX9Gci6
         mfikE3klcA9pjDh6MDF338flL+YXz+GVT6bICLYv4i/62eLeKRgI2ojnZYEiXQLCy5Vv
         rxvqgEC9iYCC53TBaF9mChDVaoEdKY2eoFD3ji1eIjN86cH2HgDvy0TjIPQjLlcbMyXu
         1RDbMiZM37vOmwo6AgAXzG8OoNsP5HtQoH9bSjlXoqy2vO28uSwyRUb81ntEbaerY/SN
         E9ylW2XpfUCrGGcC0OzPHmJzKR0HepGiE4J5SGg5D81UsyK/2aHqZIqUhpybepYQiDHa
         bQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TguL0qXFpdoQPdCMMxXUN1DOZgs5y7WCqH1cN7imVPk=;
        b=DfuNy6Q5SL4hoIfqF4wd/824k7F9wZy4x00mBX/5rdqTwQV87GhJUqQ0AUBr8O6uQK
         6BiM3RaKrTwEAAj7J73BRreqIPOClzUNMJ0LcaDEZeAhuRoUzQm4Qnx1etYwpf78k757
         ojx2/btaMdv3ugsnLAPfpqO9a34vSXn5HTAlGVHXrzSgRT2KQZNlPfhZxWNlAgTyzaix
         Z0WEbYG8mxr/kIPGh71Ga/mEPGaDMtCEZxAr3+J7ecwSrpqf0Nzz3lkUCKXbDj2RgVvq
         L3LwjfRjX6AVo1Vs+XQtehEaIwhJUZ3M9OsUl/ppMKQQtqJDGRmos5bkanIh5z3y31Oz
         nYfA==
X-Gm-Message-State: APjAAAV5W5W+f+4z3AFT1ZtJdI61rRXzvoDj/2pEqVCaAZ5xi3swKJuz
        engPzci2N/5jsbPM2yJMlVmi2w==
X-Google-Smtp-Source: APXvYqwxxeOQcN/sjdS3WnbWVlvsjIPU4+hYzB5yT6feQaN3S/LYjawoi18fW7K4ZpYsnDMIhQhT+A==
X-Received: by 2002:a0c:b342:: with SMTP id a2mr64255690qvf.211.1555443525919;
        Tue, 16 Apr 2019 12:38:45 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id k41sm46150797qtc.89.2019.04.16.12.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 12:38:45 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: [PATCH V2 1/3] Calculate Thermal Pressure
Date:   Tue, 16 Apr 2019 15:38:39 -0400
Message-Id: <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal.c and thermal.h files that provides interface
APIs to initialize, update/average, track, accumulate and decay
thermal pressure per cpu basis. A per cpu structure thermal_pressure is
introduced to keep track of instantaneous per cpu thermal pressure.
Per cpu timers are scheduled to accumulate and decay thermal pressure
periodically. Two interfaces are introduced: sched_update_thermal_pressure
to be called from any entity that caps the maximum frequency of a cpu
and sched_get_thermal_pressure to be called by scheduler to get the
thermal pressure of the cpu.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched/thermal.h |  11 +++
 kernel/sched/Makefile         |   2 +-
 kernel/sched/thermal.c        | 220 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sched/thermal.h
 create mode 100644 kernel/sched/thermal.c

diff --git a/include/linux/sched/thermal.h b/include/linux/sched/thermal.h
new file mode 100644
index 0000000..cda158e
--- /dev/null
+++ b/include/linux/sched/thermal.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_THERMAL_H
+#define _LINUX_SCHED_THERMAL_H
+
+void sched_update_thermal_pressure(struct cpumask *cpus,
+				   unsigned long cap_max_freq,
+				   unsigned long max_freq);
+
+unsigned long sched_get_thermal_pressure(int cpu);
+
+#endif /* _LINUX_SCHED_THERMAL_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5..4d3b820 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o thermal.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
new file mode 100644
index 0000000..1acee52
--- /dev/null
+++ b/kernel/sched/thermal.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sceduler Thermal Interactions
+ *
+ *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
+ */
+
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include "sched.h"
+
+/* Per cpu structure to keep track of Thermal Pressure */
+struct thermal_pressure {
+	unsigned long scale; /* scale reflecting average cpu max capacity*/
+	unsigned long acc_scale; /* Accumulated scale for this time window */
+	unsigned long old_scale; /* Scale value for the previous window */
+	unsigned long raw_scale; /* Raw max capacity */
+	unsigned long age_stamp; /* Last time old_scale was updated */
+	unsigned long last_update; /* Last time acc_scale was updated */
+	spinlock_t lock; /* Lock for protecting from simultaneous access*/
+	/* Timer for periodic update of thermal pressure */
+	struct timer_list timer;
+	int cpu;
+};
+
+DEFINE_PER_CPU(struct thermal_pressure *, thermal_pressure_cpu);
+
+#define THERMAL_PRESSURE_DECAY_PERIOD	(NSEC_PER_SEC / 2)
+
+static unsigned long calculate_simple(struct thermal_pressure *cpu_thermal,
+				      s64 delta, s64 period)
+{
+	unsigned long scale;
+	s64 decay_period = THERMAL_PRESSURE_DECAY_PERIOD;
+
+	cpu_thermal->acc_scale += delta * cpu_thermal->raw_scale;
+	scale = cpu_thermal->old_scale * decay_period;
+	scale += cpu_thermal->acc_scale;
+	scale /= (decay_period + period);
+	cpu_thermal->last_update += delta;
+
+	return scale;
+}
+
+/*
+ * Calculate thermal pressure.
+ * At the crux this is an averaging algorithm. Intially a tunable
+ * decay period(D) is defined. Thermal pressure at the end of a decay
+ * period D is the average of thermal pressure of period D-1 and D.
+ *
+ * Time             D-2            D-1             D
+ * ----------------------------------------------------------
+ * Raw Thermal  r1          r2            r3
+ * Pressure
+ *
+ * Average Thermal   r1         (r1+r2)/2       ((r1+r2)/2 + r3)/2
+ * Pressure.
+ */
+static void calculate_thermal_pressure(struct thermal_pressure *cpu_thermal)
+{
+	unsigned long scale;
+	s64 now, delta, decay_period, period;
+	int cpu;
+
+	if (!cpu_thermal)
+		return;
+
+	cpu = cpu_thermal->cpu;
+	now = sched_clock_cpu(cpu);
+	period = now - cpu_thermal->age_stamp;
+	decay_period = THERMAL_PRESSURE_DECAY_PERIOD;
+
+	if (period <= 0)
+		return;
+
+	/*
+	 * If period is less than decay_period,
+	 * just accumulate thermal pressure
+	 */
+	if (period < decay_period) {
+		delta = now - cpu_thermal->last_update;
+		scale = calculate_simple(cpu_thermal, delta, period);
+	} else {
+		/* delta here is the remaining time in the last time window */
+		delta = decay_period -
+			(cpu_thermal->last_update - cpu_thermal->age_stamp);
+		scale = calculate_simple(cpu_thermal, delta, decay_period);
+		cpu_thermal->acc_scale = 0;
+		cpu_thermal->age_stamp += decay_period;
+		/* Decay thermal pressure for every decay period remaining */
+		while ((sched_clock_cpu(cpu) - cpu_thermal->age_stamp)
+							> decay_period) {
+			scale += cpu_thermal->raw_scale;
+			scale /= 2;
+			cpu_thermal->age_stamp += decay_period;
+			cpu_thermal->last_update += decay_period;
+		}
+		cpu_thermal->old_scale = scale;
+		delta = sched_clock_cpu(cpu) - cpu_thermal->age_stamp;
+		if (delta > 0)
+			scale = calculate_simple(cpu_thermal, delta, delta);
+	}
+	cpu_thermal->scale = scale;
+}
+
+static void thermal_pressure_update(struct thermal_pressure *cpu_thermal,
+				    unsigned long cap_max_freq,
+				    unsigned long max_freq, bool change_scale)
+{
+	unsigned long flags = 0;
+
+	calculate_thermal_pressure(cpu_thermal);
+	if (change_scale)
+		cpu_thermal->raw_scale =
+			(cap_max_freq << SCHED_CAPACITY_SHIFT) / max_freq;
+
+	mod_timer(&cpu_thermal->timer, jiffies +
+				usecs_to_jiffies(TICK_USEC));
+
+	spin_unlock_irqrestore(&cpu_thermal->lock, flags);
+}
+
+/**
+ * Function for the tick update of the thermal pressure.
+ * The thermal pressure update is aborted if already an update is
+ * happening.
+ */
+static void thermal_pressure_timeout(struct timer_list *timer)
+{
+	struct thermal_pressure *cpu_thermal = from_timer(cpu_thermal, timer,
+							  timer);
+	unsigned long flags = 0;
+
+	if (!cpu_thermal)
+		return;
+
+	if (!spin_trylock_irqsave(&cpu_thermal->lock, flags))
+		return;
+
+	thermal_pressure_update(cpu_thermal, 0, 0, 0);
+}
+
+/**
+ * Function to update thermal pressure from cooling device
+ * or any framework responsible for capping cpu maximum
+ * capacity.
+ */
+void sched_update_thermal_pressure(struct cpumask *cpus,
+				   unsigned long cap_max_freq,
+				   unsigned long max_freq)
+{
+	int cpu;
+	unsigned long flags = 0;
+	struct thermal_pressure *cpu_thermal;
+
+	for_each_cpu(cpu, cpus) {
+		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
+		if (!cpu_thermal)
+			return;
+		spin_lock_irqsave(&cpu_thermal->lock, flags);
+		thermal_pressure_update(cpu_thermal, cap_max_freq, max_freq, 1);
+	}
+}
+
+/**
+ * Function to be called from scheduler to get thermal pressure
+ * of a cpu
+ */
+unsigned long sched_get_thermal_pressure(int cpu)
+{
+	struct thermal_pressure *cpu_thermal = per_cpu(thermal_pressure_cpu,
+							cpu);
+
+	if (!cpu_thermal)
+		return SCHED_CAPACITY_SCALE;
+	else
+		return cpu_thermal->scale;
+}
+
+static void __init init_thermal_pressure(void)
+{
+	struct thermal_pressure *cpu_thermal;
+	unsigned long scale;
+	int cpu;
+
+	pr_debug("Init thermal pressure\n");
+	for_each_possible_cpu(cpu) {
+		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
+		if (cpu_thermal)
+			continue;
+
+		cpu_thermal = kzalloc(sizeof(*cpu_thermal), GFP_KERNEL);
+		if (!cpu_thermal)
+			continue;
+		scale = SCHED_CAPACITY_SCALE;
+		cpu_thermal->scale = scale;
+		cpu_thermal->old_scale = scale;
+		cpu_thermal->raw_scale = scale;
+		cpu_thermal->age_stamp = sched_clock_cpu(cpu);
+		cpu_thermal->last_update = sched_clock_cpu(cpu);
+		cpu_thermal->cpu = cpu;
+		spin_lock_init(&cpu_thermal->lock);
+		timer_setup(&cpu_thermal->timer, thermal_pressure_timeout,
+			    TIMER_DEFERRABLE);
+		per_cpu(thermal_pressure_cpu, cpu) = cpu_thermal;
+		pr_debug("cpu %d thermal scale = %ld\n", cpu, cpu_thermal->scale);
+	}
+
+	for_each_possible_cpu(cpu) {
+		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
+		if (!cpu_thermal)
+			continue;
+		cpu_thermal->timer.expires = jiffies +
+						usecs_to_jiffies(TICK_USEC);
+		add_timer(&cpu_thermal->timer);
+	}
+}
+
+late_initcall(init_thermal_pressure);
-- 
2.1.4

