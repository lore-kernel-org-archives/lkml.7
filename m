Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A6BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520422175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfEJLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:32:45 -0400
Received: from foss.arm.com ([217.140.101.70]:44556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfEJLcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B591715;
        Fri, 10 May 2019 04:32:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1D483F6C4;
        Fri, 10 May 2019 04:32:40 -0700 (PDT)
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
Subject: [PATCH v2 5/7] sched: Add pelt_se tracepoint
Date:   Fri, 10 May 2019 12:30:11 +0100
Message-Id: <20190510113013.1193-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoint allows tracking PELT signals at sched_entity level.
Which is supported in CFS tasks and taskgroups only.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h     |  4 ++++
 kernel/sched/fair.c              |  1 +
 kernel/sched/pelt.c              |  2 ++
 kernel/sched/sched_tracepoints.h | 13 +++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 50346098e026..cbcb47972232 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -596,6 +596,10 @@ DECLARE_TRACE(pelt_rq,
 	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
 	TP_ARGS(cpu, path, avg));
 
+DECLARE_TRACE(pelt_se,
+	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
+	TP_ARGS(cpu, path, se));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34782e37387c..81036c34fd29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3139,6 +3139,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
 	sched_trace_pelt_cfs_rq(cfs_rq);
+	sched_trace_pelt_se(se);
 
 	return 1;
 }
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 39418e80699f..75eea3b61a97 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		sched_trace_pelt_se(se);
 		return 1;
 	}
 
@@ -279,6 +280,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
+		sched_trace_pelt_se(se);
 		return 1;
 	}
 
diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
index 5f804629d3b7..d1992f04ee27 100644
--- a/kernel/sched/sched_tracepoints.h
+++ b/kernel/sched/sched_tracepoints.h
@@ -47,4 +47,17 @@ static inline void sched_trace_pelt_dl_rq(struct rq *rq) {}
 #endif /* CONFIG_SMP */
 
 
+static __always_inline void sched_trace_pelt_se(struct sched_entity *se)
+{
+	if (trace_pelt_se_enabled()) {
+		struct cfs_rq *gcfs_rq = group_cfs_rq(se);
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		int cpu = cpu_of(rq_of(cfs_rq));
+		char path[SCHED_TP_PATH_LEN];
+
+		cfs_rq_tg_path(gcfs_rq, path, SCHED_TP_PATH_LEN);
+		trace_pelt_se(cpu, path, se);
+	}
+}
+
 #endif /* __SCHED_TRACEPOINTS_H */
-- 
2.17.1

