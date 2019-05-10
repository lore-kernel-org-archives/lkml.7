Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5072175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfEJLcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:32:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfEJLcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9950219BF;
        Fri, 10 May 2019 04:32:45 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9FD3F6C4;
        Fri, 10 May 2019 04:32:42 -0700 (PDT)
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
Subject: [PATCH v2 6/7] sched: Add sched_overutilized tracepoint
Date:   Fri, 10 May 2019 12:30:12 +0100
Message-Id: <20190510113013.1193-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoint allows us to track the changes in overutilized
status.

Overutilized status is associated with EAS. It indicates that the system
is in high performance state. EAS is disabled when the system is in this
state since there's not much energy savings while high performance tasks
are pushing the system to the limit and it's better to default to the
spreading behavior of the scheduler.

This tracepoint helps understanding and debugging the conditions under
which this happens.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/fair.c          | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index cbcb47972232..0cf42d13d6c4 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -600,6 +600,10 @@ DECLARE_TRACE(pelt_se,
 	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
 	TP_ARGS(cpu, path, se));
 
+DECLARE_TRACE(sched_overutilized,
+	TP_PROTO(int overutilized),
+	TP_ARGS(overutilized));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81036c34fd29..494032220fe7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4965,8 +4965,10 @@ static inline bool cpu_overutilized(int cpu)
 
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
@@ -8330,8 +8332,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
+
+		trace_sched_overutilized(!!(sg_status & SG_OVERUTILIZED));
 	} else if (sg_status & SG_OVERUTILIZED) {
 		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized(1);
 	}
 }
 
-- 
2.17.1

