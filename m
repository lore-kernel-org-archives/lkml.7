Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F166FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55CE24B6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFDLPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:15:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfFDLPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FED01682;
        Tue,  4 Jun 2019 04:15:14 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADF43F690;
        Tue,  4 Jun 2019 04:15:12 -0700 (PDT)
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
Subject: [PATCH v3 3/6] sched: Add new tracepoints to track pelt at rq level
Date:   Tue,  4 Jun 2019 12:14:56 +0100
Message-Id: <20190604111459.2862-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoints allow tracking PELT signals at rq level for all
scheduling classes + irq.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h | 23 +++++++++++++++++++++++
 kernel/sched/fair.c          |  6 ++++++
 kernel/sched/pelt.c          |  9 ++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c8c7c7efb487..520b89d384ec 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -594,6 +594,29 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+/*
+ * Following tracepoints are not exported in tracefs and provide hooking
+ * mechanisms only for testing and debugging purposes.
+ *
+ * Postfixed with _tp to make them easily identifiable in the code.
+ */
+DECLARE_TRACE(pelt_cfs_tp,
+	TP_PROTO(struct cfs_rq *cfs_rq),
+	TP_ARGS(cfs_rq));
+
+DECLARE_TRACE(pelt_rt_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
+DECLARE_TRACE(pelt_dl_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
+DECLARE_TRACE(pelt_irq_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18c89ebadfc7..dee1338ec4a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3353,6 +3353,8 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
+	trace_pelt_cfs_tp(cfs_rq);
+
 	return 1;
 }
 
@@ -3505,6 +3507,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, flags);
+
+	trace_pelt_cfs_tp(cfs_rq);
 }
 
 /**
@@ -3524,6 +3528,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
+
+	trace_pelt_cfs_tp(cfs_rq);
 }
 
 /*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29bd882..c9d4945861a4 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -28,6 +28,8 @@
 #include "sched.h"
 #include "pelt.h"
 
+#include <trace/events/sched.h>
+
 /*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
@@ -292,6 +294,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
+		trace_pelt_cfs_tp(cfs_rq);
 		return 1;
 	}
 
@@ -317,6 +320,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
+		trace_pelt_rt_tp(rq);
 		return 1;
 	}
 
@@ -340,6 +344,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
+		trace_pelt_dl_tp(rq);
 		return 1;
 	}
 
@@ -388,8 +393,10 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 				1,
 				1);
 
-	if (ret)
+	if (ret) {
 		___update_load_avg(&rq->avg_irq, 1, 1);
+		trace_pelt_irq_tp(rq);
+	}
 
 	return ret;
 }
-- 
2.17.1

