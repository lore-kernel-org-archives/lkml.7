Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B7C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4171E2177B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfEEL6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:58:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfEEL6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:58:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8102D1713;
        Sun,  5 May 2019 04:58:32 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065C23F5C1;
        Sun,  5 May 2019 04:58:30 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 5/7] sched: Add sched_load_se tracepoint
Date:   Sun,  5 May 2019 12:57:30 +0100
Message-Id: <20190505115732.9844-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190505115732.9844-1-qais.yousef@arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
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
index 2be4c471c6e9..0933c08cfc7e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -596,6 +596,10 @@ DECLARE_TRACE(sched_load_rq,
 	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
 	TP_ARGS(cpu, path, avg));
 
+DECLARE_TRACE(sched_load_se,
+	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
+	TP_ARGS(cpu, path, se));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e1e0cc7db7f6..3fd306079b57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3139,6 +3139,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
 	sched_tp_load_cfs_rq(cfs_rq);
+	sched_tp_load_se(se);
 
 	return 1;
 }
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 302affb14302..74e7bd121324 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		sched_tp_load_se(se);
 		return 1;
 	}
 
@@ -279,6 +280,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
+		sched_tp_load_se(se);
 		return 1;
 	}
 
diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
index f4ded705118e..4a53578c9a69 100644
--- a/kernel/sched/sched_tracepoints.h
+++ b/kernel/sched/sched_tracepoints.h
@@ -37,3 +37,16 @@ static __always_inline void sched_tp_load_dl_rq(struct rq *rq)
 		trace_sched_load_rq(cpu, NULL, &rq->avg_dl);
 	}
 }
+
+static __always_inline void sched_tp_load_se(struct sched_entity *se)
+{
+	if (trace_sched_load_se_enabled()) {
+		struct cfs_rq *gcfs_rq = group_cfs_rq(se);
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		char path[SCHED_TP_PATH_LEN];
+		int cpu = cpu_of(rq_of(cfs_rq));
+
+		cfs_rq_tg_path(gcfs_rq, path, SCHED_TP_PATH_LEN);
+		trace_sched_load_se(cpu, path, se);
+	}
+}
-- 
2.17.1

