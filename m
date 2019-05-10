Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99266C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7498920850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEJLcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:32:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfEJLcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C2B16A3;
        Fri, 10 May 2019 04:32:40 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64193F6C4;
        Fri, 10 May 2019 04:32:38 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 4/7] sched: Add pelt_rq tracepoint
Date:   Fri, 10 May 2019 12:30:10 +0100
Message-Id: <20190510113013.1193-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoint allows tracking PELT signals at rq level for all
scheduling classes.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h     |  9 ++++++
 kernel/sched/fair.c              |  9 ++++--
 kernel/sched/pelt.c              |  4 +++
 kernel/sched/sched_tracepoints.h | 50 ++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 kernel/sched/sched_tracepoints.h

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfadab07..50346098e026 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -587,6 +587,15 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+/*
+ * Following tracepoints are not exported in tracefs and provide hooking
+ * mechanisms only for testing and debugging purposes.
+ */
+DECLARE_TRACE(pelt_rq,
+	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
+	TP_ARGS(cpu, path, avg));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b4963bbeab4..34782e37387c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,8 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
-
-#include <trace/events/sched.h>
+#include "sched_tracepoints.h"
 
 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -3139,6 +3138,8 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
+	sched_trace_pelt_cfs_rq(cfs_rq);
+
 	return 1;
 }
 
@@ -3291,6 +3292,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, flags);
+
+	sched_trace_pelt_cfs_rq(cfs_rq);
 }
 
 /**
@@ -3310,6 +3313,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
+
+	sched_trace_pelt_cfs_rq(cfs_rq);
 }
 
 /*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29bd882..39418e80699f 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -26,6 +26,7 @@
 
 #include <linux/sched.h>
 #include "sched.h"
+#include "sched_tracepoints.h"
 #include "pelt.h"
 
 /*
@@ -292,6 +293,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
+		sched_trace_pelt_cfs_rq(cfs_rq);
 		return 1;
 	}
 
@@ -317,6 +319,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
+		sched_trace_pelt_rt_rq(rq);
 		return 1;
 	}
 
@@ -340,6 +343,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
+		sched_trace_pelt_dl_rq(rq);
 		return 1;
 	}
 
diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
new file mode 100644
index 000000000000..5f804629d3b7
--- /dev/null
+++ b/kernel/sched/sched_tracepoints.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Scheduler tracepoints that are probe-able only and aren't exported ABI in
+ * tracefs.
+ */
+#ifndef __SCHED_TRACEPOINTS_H
+#define __SCHED_TRACEPOINTS_H
+
+#include <trace/events/sched.h>
+
+#define SCHED_TP_PATH_LEN		20
+
+
+#ifdef CONFIG_SMP
+static __always_inline void sched_trace_pelt_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	if (trace_pelt_rq_enabled()) {
+		int cpu = cpu_of(rq_of(cfs_rq));
+		char path[SCHED_TP_PATH_LEN];
+
+		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
+		trace_pelt_rq(cpu, path, &cfs_rq->avg);
+	}
+}
+
+static __always_inline void sched_trace_pelt_rt_rq(struct rq *rq)
+{
+	if (trace_pelt_rq_enabled()) {
+		int cpu = cpu_of(rq);
+
+		trace_pelt_rq(cpu, NULL, &rq->avg_rt);
+	}
+}
+
+static __always_inline void sched_trace_pelt_dl_rq(struct rq *rq)
+{
+	if (trace_pelt_rq_enabled()) {
+		int cpu = cpu_of(rq);
+
+		trace_pelt_rq(cpu, NULL, &rq->avg_dl);
+	}
+}
+#else
+static inline void sched_trace_pelt_cfs_rq(struct cfs_rq *cfs_rq) {}
+static inline void sched_trace_pelt_rt_rq(struct rq *rq) {}
+static inline void sched_trace_pelt_dl_rq(struct rq *rq) {}
+#endif /* CONFIG_SMP */
+
+
+#endif /* __SCHED_TRACEPOINTS_H */
-- 
2.17.1

