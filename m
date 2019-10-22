Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB01CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FB621848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oo5sa5N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfJVUed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39876 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389153AbfJVUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so17625126qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vJ9FZ+tbutK9H8P0UifHj9bRmxWrH0GAs5h60TIQ7uw=;
        b=oo5sa5N9CFOG7T1MGV0uPi7I5GlqjQpyKB/7oTUGTiOH0MrVZ8drYGpCpG3ObxxquP
         rJ2/AHUUK8ryiEGIbMmJ2UtExbT046g+n+99VqVGXNZOBnCKk5Rm7XedybmItpvQE5zC
         h2O/ZfmQropsP0xpw2qZj+ZZaWu3y1Q2mYGRgKWV/7u1yTWWVlG86bWgk+r6LUNH0rPM
         FrLzeeH1ELrLsR5xXEwluTSbHJ5ndB5IpP7tllyZUJfoknab8MOPoB2oWu0RWXWtDRYb
         5rLuf0SP90WynjqrOkkiN5VDwhnoHnBoii5DLv4F4J9qERcjZn4S5OreXO3cwkDgcRN1
         AoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJ9FZ+tbutK9H8P0UifHj9bRmxWrH0GAs5h60TIQ7uw=;
        b=DEP5lAEzxOkmC1UA2eC/1VEWHarB9AnUNMlACe8JC0Fobm5ynaScWi+MQjJ4ISGRnh
         lBjZRgnQBmEVrQxpF5B3oPa+KTkSVR1mlR6522mqMh7oSUsQWPL+nTMSjZ2CzE+SOHOM
         8UM+PBlJuKoxzvYDB8sEK6En5D2KSUklDqqVl5DNIRiQvJsX9Mw2LB5k0HMg4U+NlM2b
         iQQ6R+ez/pUVfRVIhFkv9b6EOeHxnYr54/FAyHxjKVZEqC9oRUySYSSicNPmIfxGbHNt
         80vIimgDyZ2ZLk6GD3+dzhDc/FOl7aHgM+RgsBQQOmBlWO/Cj0MSuYgzjbysRdwToEcz
         QgWQ==
X-Gm-Message-State: APjAAAXHsiqzgmL2EdLBPJXCsOoVEheZkNLh9EccXRoONuX4v3topMhS
        Y7ymUb8tloY2iCslRDyyRru6Kw==
X-Google-Smtp-Source: APXvYqwl9ROl0z6ZPZlo2EebcF0v4cwfddz3vs5rIgVt+z1OWKLxLZzyZAFrKUpSY+D0R4FrmklzJA==
X-Received: by 2002:ae9:f012:: with SMTP id l18mr4803736qkg.291.1571776470728;
        Tue, 22 Oct 2019 13:34:30 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:30 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 2/6] sched: Add infrastructure to store and update instantaneous thermal pressure
Date:   Tue, 22 Oct 2019 16:34:21 -0400
Message-Id: <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal.c and thermal.h files that provides interface
APIs to initialize, update/average, track, accumulate and decay
thermal pressure per cpu basis. A per cpu variable delta_capacity is
introduced to keep track of instantaneous per cpu thermal pressure.
Thermal pressure is the delta between maximum capacity and capped
capacity due to a thermal event.
API trigger_thermal_pressure_average is called for periodic accumulate
and decay of the thermal pressure. It is to to be called from a
periodic tick function. This API passes on the instantaneous delta
capacity of a cpu to update_thermal_load_avg to do the necessary
accumulate, decay and average. 
API update_thermal_pressure is for the system to update the thermal
pressure by providing a capped frequency ratio.
Considering, trigger_thermal_pressure_average reads delta_capacity and
update_thermal_pressure writes into delta_capacity, one can argue for
some sort of locking mechanism to avoid a stale value.
But considering trigger_thermal_pressure_average can be called from a
system critical path like scheduler tick function, a locking mechanism
is not ideal. This means that it is possible the delta_capacity value
used to calculate average thermal pressure for a cpu can be
stale for upto 1 tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Dropped per cpu max_capacity_info struct and instead added a per
	  delta_capacity variable to store the delta between maximum
	  capacity and capped capacity. The delta is now calculated when
	  thermal pressure is updated and not every tick.
	- Dropped populate_max_capacity_info api as only per cpu delta
	  capacity is stored.
	- Renamed update_periodic_maxcap to
	  trigger_thermal_pressure_average and update_maxcap_capacity to
	  update_thermal_pressure.

 include/linux/sched.h  |  8 ++++++++
 kernel/sched/Makefile  |  2 +-
 kernel/sched/thermal.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h | 13 +++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56b..d7ef543 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1983,6 +1983,14 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_SMP
+void update_thermal_pressure(int cpu, u64 capacity);
+#else
+static inline void update_thermal_pressure(int cpu, u64 capacity)
+{
+}
+#endif
+
 const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
 char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
 int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
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
index 0000000..0c84960
--- /dev/null
+++ b/kernel/sched/thermal.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Scheduler Thermal Interactions
+ *
+ *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
+ */
+
+#include <linux/sched.h>
+#include "sched.h"
+#include "pelt.h"
+#include "thermal.h"
+
+static DEFINE_PER_CPU(unsigned long, delta_capacity);
+
+/**
+ * update_thermal_pressure: Update thermal pressure
+ * @cpu: the cpu for which thermal pressure is to be updated for
+ * @capped_freq_ratio: capped max frequency << SCHED_CAPACITY_SHIFT / max freq
+ *
+ * capped_freq_ratio is normalized into capped capacity and the delta between
+ * the arch_scale_cpu_capacity and capped capacity is stored in per cpu
+ * delta_capacity.
+ */
+void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
+{
+	unsigned long __capacity, delta;
+
+	/* Normalize the capped freq ratio */
+	__capacity = (capped_freq_ratio * arch_scale_cpu_capacity(cpu)) >>
+							SCHED_CAPACITY_SHIFT;
+	delta = arch_scale_cpu_capacity(cpu) -  __capacity;
+	pr_debug("updating cpu%d thermal pressure to %lu\n", cpu, delta);
+
+	per_cpu(delta_capacity, cpu) = delta;
+}
+
+/**
+ * trigger_thermal_pressure_average: Trigger the thermal pressure accumulate
+ *				     and average algorithm
+ */
+void trigger_thermal_pressure_average(struct rq *rq)
+{
+	update_thermal_load_avg(rq_clock_task(rq), rq,
+				per_cpu(delta_capacity, cpu_of(rq)));
+}
diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
new file mode 100644
index 0000000..26e5b07
--- /dev/null
+++ b/kernel/sched/thermal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler thermal interaction internal methods.
+ */
+
+#ifdef CONFIG_SMP
+void trigger_thermal_pressure_average(struct rq *rq);
+
+#else
+static inline void trigger_thermal_pressure_average(struct rq *rq)
+{
+}
+#endif
-- 
2.1.4

