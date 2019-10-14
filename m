Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8322C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A42083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfEBTd6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfJNA6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35156 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfJNA6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so14483585qkf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HXCk7WFSvFXYWs/yCn2J75WJ4FkUD1kjnWRu7u1SlbU=;
        b=IfEBTd6pxtYseUl5ivLDlRrw2pUdcU14DsbG/j4fNMOQ7tnNYxM6AGyj/63cnSz+P8
         3S5iRysN1BOvSLTH+0xS8ZnI0qfeQtGfrvsxnCSuU+nmXtDv+4i9RZxwJ9yVV8sNmqF4
         bAsqXta4BvcufRImA76CJwCaN8P24CCjCgftvx3+avEFRPeq86WOhoj+DY0xznixF4aK
         +C669lUh5fqWkx243UocpT5Tgqx6MUp9+P5oSApv67EnQUQ89NiN6WaEvU0emeyguVof
         DW9zfIswCPmOogOCbfxZ04O0y0iMfYFkTc224qRJtCq5VmoUY8aheoEDFOiZu+vwyJC+
         K1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HXCk7WFSvFXYWs/yCn2J75WJ4FkUD1kjnWRu7u1SlbU=;
        b=RtSfqHRdcy24uPgT5kMSCRqAkEEgwSfGU0AKfBTzvZqhz6EcTyUGUMS4x60slw8IcH
         lvg9VxE0bNUtB7NWH63FLFqnKNGIxRMXbioQifNi0n+Bg/RaV6zdInXR383b95UclCsx
         ARah1ROgdfCYsc+C9Bb5Ub6Bfb1cQEm7NQ/Aef+E0FVAtxT+UWyUCB0Uyk/dd7NgE2Ja
         +CtEFWL6POaPXKsv1kojWRgumd1OCmkbST8eCWchssVsWK7UXoeQerjCHguAYPypk+x1
         0g+7f8dUnSPf/B6TJ0ccaZV19g5KG4nxira/HaN9Sbmduzk7TXdTcxOJDUZO2xssgP7X
         YIag==
X-Gm-Message-State: APjAAAXuZhjajSM01Hh9Mimau3KZr1e+pyroAuG5g+xsmCiHnvAeu+/a
        SUO9HxMslSQLq1/7P1TJIBWUYw==
X-Google-Smtp-Source: APXvYqy69L3uW98ouB3FOFnzj3MHsc4HwzvQZSr4swhJjCk8coZAAPKeHVuVUhzMPG9dtps1e3fXBg==
X-Received: by 2002:a37:4dca:: with SMTP id a193mr27620584qkb.292.1571014710026;
        Sun, 13 Oct 2019 17:58:30 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:29 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 2/7] sched: Add infrastructure to store and update instantaneous thermal pressure
Date:   Sun, 13 Oct 2019 20:58:20 -0400
Message-Id: <1571014705-19646-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal.c and thermal.h files that provides interface
APIs to initialize, update/average, track, accumulate and decay
thermal pressure per cpu basis. A per cpu structure max_capacity_info is
introduced to keep track of instantaneous per cpu thermal pressure.
Thermal pressure is the delta between max_capacity and cap_capacity.
API update_periodic_maxcap is called for periodic accumulate and decay
of the thermal pressure. It is to to be called from a periodic tick
function. This API calculates the delta between max_capacity and
cap_capacity and passes on the delta to update_thermal_avg to do the
necessary accumulate, decay and average. API update_maxcap_capacity is for
the system to update the thermal pressure by updating cap_capacity.
Considering, update_periodic_maxcap reads cap_capacity and
update_maxcap_capacity writes into cap_capacity, one can argue for
some sort of locking mechanism to avoid a stale value.
But considering update_periodic_maxcap can be called from a system
critical path like scheduler tick function, a locking mechanism is not
ideal. This means that it is possible the value used to
calculate average thermal pressure for a cpu can be stale for upto 1
tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/linux/sched.h  | 14 +++++++++++
 kernel/sched/Makefile  |  2 +-
 kernel/sched/thermal.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h | 13 ++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56b..875ce2b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1983,6 +1983,20 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_SMP
+void update_maxcap_capacity(int cpu, u64 capacity);
+
+void populate_max_capacity_info(void);
+#else
+static inline void update_maxcap_capacity(int cpu, u64 capacity)
+{
+}
+
+static inline void populate_max_capacity_info(void)
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
index 0000000..5f0b2d4
--- /dev/null
+++ b/kernel/sched/thermal.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sceduler Thermal Interactions
+ *
+ *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
+ */
+
+#include <linux/sched.h>
+#include "sched.h"
+#include "pelt.h"
+#include "thermal.h"
+
+struct max_capacity_info {
+	unsigned long max_capacity;
+	unsigned long cap_capacity;
+};
+
+static DEFINE_PER_CPU(struct max_capacity_info, max_cap);
+
+void update_maxcap_capacity(int cpu, u64 capacity)
+{
+	struct max_capacity_info *__max_cap;
+	unsigned long __capacity;
+
+	__max_cap = (&per_cpu(max_cap, cpu));
+	if (!__max_cap) {
+		pr_err("no max_capacity_info structure for cpu %d\n", cpu);
+		return;
+	}
+
+	/* Normalize the capacity */
+	__capacity = (capacity * arch_scale_cpu_capacity(cpu)) >>
+							SCHED_CAPACITY_SHIFT;
+	pr_debug("updating cpu%d capped capacity from %lu to %lu\n", cpu, __max_cap->cap_capacity, __capacity);
+
+	__max_cap->cap_capacity = __capacity;
+}
+
+void populate_max_capacity_info(void)
+{
+	struct max_capacity_info *__max_cap;
+	u64 capacity;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		__max_cap = (&per_cpu(max_cap, cpu));
+		if (!__max_cap)
+			continue;
+		capacity = arch_scale_cpu_capacity(cpu);
+		__max_cap->max_capacity = capacity;
+		__max_cap->cap_capacity = capacity;
+		pr_debug("cpu %d max capacity set to %ld\n", cpu, __max_cap->max_capacity);
+	}
+}
+
+void update_periodic_maxcap(struct rq *rq)
+{
+	struct max_capacity_info *__max_cap = (&per_cpu(max_cap, cpu_of(rq)));
+	unsigned long delta;
+
+	if (!__max_cap)
+		return;
+
+	delta = __max_cap->max_capacity - __max_cap->cap_capacity;
+	update_thermal_avg(rq_clock_task(rq), rq, delta);
+}
diff --git a/kernel/sched/thermal.h b/kernel/sched/thermal.h
new file mode 100644
index 0000000..5657cb4
--- /dev/null
+++ b/kernel/sched/thermal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler thermal interaction internal methods.
+ */
+
+#ifdef CONFIG_SMP
+void update_periodic_maxcap(struct rq *rq);
+
+#else
+static inline void update_periodic_maxcap(struct rq *rq)
+{
+}
+#endif
-- 
2.1.4

