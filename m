Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F52C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2620879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HuyPC5N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfEMM3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:29:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54140 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfEMM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wu8hVf2vJ3hrllMzZo0PE3FI6oe7BR0AimixYE2nb8Q=; b=HuyPC5N5xzlXlz2F0oZ1hKgUp
        6GckwWxZHwAYkusF8cp7WU4N+ZccDVmRJ8svIAUaMjuxLTt/zNChKFp2w/fR7zXhyKSia5tS2FS6E
        rLGweWnoi+5cladEpW4b18I1nG2OwpDlopNpqb7R6ackEXoNEFUzxTLdFylBLVThYV5M3Sg698M/G
        9iSPK6tVqfrIoL8txee6M1M27/blm2jVHUDtMnsqvD4Ar+fbth2LJwG/7rcu8BXI9P4eSvkyR7qqQ
        FtAf1idi505y2oHjwtkbCLKkgXzAf2so0DytH7W2mkqQa3CuuIQMNe8qQ7130oB7uv+izQatyYeEV
        jIXtmU3yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQA4i-0006xo-3J; Mon, 13 May 2019 12:29:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 630F02029FD7A; Mon, 13 May 2019 14:28:57 +0200 (CEST)
Date:   Mon, 13 May 2019 14:28:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 0/7] Add new tracepoints required for EAS testing
Message-ID: <20190513122857.GU2623@hirez.programming.kicks-ass.net>
References: <20190510113013.1193-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c8c7c7efb487..11555f95a88e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -594,6 +594,23 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 
 	TP_printk("cpu=%d", __entry->cpu)
 );
+
+/*
+ * Following tracepoints are not exported in tracefs and provide hooking
+ * mechanisms only for testing and debugging purposes.
+ */
+DECLARE_TRACE(pelt_cfs_rq,
+	TP_PROTO(struct cfs_rq *cfs_rq),
+	TP_ARGS(cfs_rq));
+
+DECLARE_TRACE(pelt_se,
+	TP_PROTO(struct sched_entity *se),
+	TP_ARGS(se));
+
+DECLARE_TRACE(sched_overutilized,
+	TP_PROTO(int overutilized),
+	TP_ARGS(overutilized));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2d4ff5353ded..2067080bb235 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -259,7 +259,6 @@ void proc_sched_autogroup_show_task(struct task_struct *p, struct seq_file *m)
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_SCHED_DEBUG
 int autogroup_path(struct task_group *tg, char *buf, int buflen)
 {
 	if (!task_group_is_autogroup(tg))
@@ -267,4 +266,3 @@ int autogroup_path(struct task_group *tg, char *buf, int buflen)
 
 	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
 }
-#endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..629bbf4f4247 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -22,6 +22,14 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
+/*
+ * Export tracepoints that act as a bare tracehook (ie: have no trace event
+ * associated with them) to allow external modules to probe them.
+ */
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_cfs_rq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized);
+
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..e7f82b1778b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3334,6 +3334,9 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
+	trace_pelt_cfs_rq(cfs_rq);
+	trace_pelt_se(se);
+
 	return 1;
 }
 
@@ -3486,6 +3489,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, flags);
+
+	trace_pelt_cfs_rq(cfs_rq);
 }
 
 /**
@@ -3505,6 +3510,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
+
+	trace_pelt_cfs_rq(cfs_rq);
 }
 
 /*
@@ -5153,8 +5160,10 @@ static inline bool cpu_overutilized(int cpu)
 
 static inline void update_overutilized_status(struct rq *rq)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
 		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized(1);
+	}
 }
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
@@ -8516,8 +8525,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
+
+		trace_sched_overutilized(!!(sg_status & SG_OVERUTILIZED));
 	} else if (sg_status & SG_OVERUTILIZED) {
 		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized(1);
 	}
 }
 
@@ -10737,3 +10749,17 @@ __init void init_sched_fair_class(void)
 #endif /* SMP */
 
 }
+
+char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, size_t len)
+{
+	cfs_rq_tg_path(cfs_rq, path, len);
+	return str;
+}
+EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_path);
+
+int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq)
+{
+	return cpu_of(rq_of(cfs_rq));
+}
+EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_cpu);
+
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29bd882..ebca40ba71f3 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/sched.h>
+#include <trace/events/sched.h>
 #include "sched.h"
 #include "pelt.h"
 
@@ -265,6 +266,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		trace_pelt_se(se);
 		return 1;
 	}
 
@@ -278,6 +280,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
+		trace_pelt_se(se);
 		return 1;
 	}
 
@@ -292,6 +295,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
+		trace_pelt_cfs_rq(cfs_rq);
 		return 1;
 	}
 
@@ -317,6 +321,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
+//		sched_trace_pelt_rt_rq(rq);
 		return 1;
 	}
 
@@ -340,6 +345,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 				running)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
+//		sched_trace_pelt_dl_rq(rq);
 		return 1;
 	}
 
