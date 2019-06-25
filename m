Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88CAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8421655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FW/Q/n+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfFYI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:27:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbfFYI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:27:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8QR1R3529876
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:26:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8QR1R3529876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451187;
        bh=gKg4v3jTlYC5JMt2MpCNHqT/Jx2awnO925l1su/Dq3s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FW/Q/n+LEijh9EvSU/eFV5M/kZnC60AxEEDnvMdcvn6DPakpdSjE/V3u8CcFBPz26
         XbmggqrI0Y46OIrWzF8ONSkzDoaaAZwtDtSehbbZ4tDhQsksYsEuN9yeI/+0VynDh5
         O4XqGZj7n/I8PPuACBb6FLalEBRzyOuaJrV5/Qq12wLninN8u0wW71K1pzjtpQLoqO
         fx9CntJdndW+mLr3VT/w5kvYm+fF+3782UBNtALSlWuqfwAM+0ifjJToxx9URiadBL
         BHwJYCEM2OnEIEN26ApIu+4sJNqP/DzQLL4D2+uHrP3gvycEKiIaWsgrhgNLm4bnVb
         aRWGpQKvEV/iA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8QQbT3529871;
        Tue, 25 Jun 2019 01:26:26 -0700
Date:   Tue, 25 Jun 2019 01:26:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-ba19f51fcb549c7ee6261da243eea55a47e98d78@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        quentin.perret@arm.com, bigeasy@linutronix.de,
        u.kleine-koenig@pengutronix.de, mingo@kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, rostedt@goodmis.org, qais.yousef@arm.com,
        torvalds@linux-foundation.org
Reply-To: qais.yousef@arm.com, rostedt@goodmis.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          peterz@infradead.org, bigeasy@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, quentin.perret@arm.com,
          dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
          u.kleine-koenig@pengutronix.de, pkondeti@codeaurora.org
In-Reply-To: <20190604111459.2862-4-qais.yousef@arm.com>
References: <20190604111459.2862-4-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Add new tracepoints to track PELT at
 rq level
Git-Commit-ID: ba19f51fcb549c7ee6261da243eea55a47e98d78
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ba19f51fcb549c7ee6261da243eea55a47e98d78
Gitweb:     https://git.kernel.org/tip/ba19f51fcb549c7ee6261da243eea55a47e98d78
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:41 +0200

sched/debug: Add new tracepoints to track PELT at rq level

The new tracepoints allow tracking PELT signals at rq level for all
scheduling classes + irq.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Link: https://lkml.kernel.org/r/20190604111459.2862-4-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 461c3e9a67b2..e883d7e17e36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3347,6 +3347,8 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
+	trace_pelt_cfs_tp(cfs_rq);
+
 	return 1;
 }
 
@@ -3499,6 +3501,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, flags);
+
+	trace_pelt_cfs_tp(cfs_rq);
 }
 
 /**
@@ -3518,6 +3522,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
+
+	trace_pelt_cfs_tp(cfs_rq);
 }
 
 /*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 42ea66b07b1d..4e961b55b5ea 100644
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
