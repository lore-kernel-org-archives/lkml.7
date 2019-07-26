Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927F6218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MINbHlwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfGZQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:21:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfGZQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IkuJEjf3jjAHnNNfJltckDOcnAoGB5oVO+XgSCJzQHQ=; b=MINbHlwH531LegJvn8aF4q/buH
        xU7nBUE8Aj3d9Xiru4I4ltzamWdUoAoQBFCYeBJ30OHunbAUkFbtKrCS7nWhuy16mey/Qm9L+2Fbj
        V9DonEUqFE1p4AqM1T3G1rXvz/sfVlEbJJN1pNG1nNNGulbMlvRE6pShSELVxkxGxXUXV9IVvz2+S
        fFHUTSdMQsaYy/QtX6Kx4oQyE3LQ96qJ64XiRofAoyNbj8ewv2rEUjWkwoIf1Q/4WcOWv2vBIllvP
        alkkg3pAoCnwxRnvS+6eLiAAZKXlNC0vohsugp5BBj28vq/HBwzv0gjHbPJndwUdydVMzdqoiNPVL
        m4oGM+DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wz-00072B-Vm; Fri, 26 Jul 2019 16:20:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6041420229755; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.883133230@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org, peterz@infradead.org
Subject: [RFC][PATCH 09/13] sched: Unify runtime accounting across classes
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All classes use sched_entity::exec_start to track runtime and have
copies of the exact same code around to compute runtime.

Collapse all that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h    |    2 -
 kernel/sched/deadline.c  |   17 ++-------------
 kernel/sched/fair.c      |   50 ++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/rt.c        |   17 ++-------------
 kernel/sched/sched.h     |    2 +
 kernel/sched/stop_task.c |   16 ---------------
 6 files changed, 49 insertions(+), 55 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -433,7 +433,7 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1147,9 +1147,8 @@ static void update_curr_dl(struct rq *rq
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1162,23 +1161,13 @@ static void update_curr_dl(struct rq *rq
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0)) {
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -828,30 +828,58 @@ static void update_tg_load_avg(struct cf
 }
 #endif /* CONFIG_SMP */
 
+static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+{
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec = now - curr->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	curr->exec_start = now;
+	curr->sum_exec_runtime += delta_exec;
+
+	schedstat_set(curr->statistics.exec_max,
+		      max(delta_exec, curr->statistics.exec_max));
+
+	return delta_exec;
+}
+
+/*
+ * Used by other classes to account runtime.
+ */
+s64 update_curr_common(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	s64 delta_exec;
+
+	delta_exec = update_curr_se(rq, &curr->se);
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	return delta_exec;
+}
+
 /*
  * Update the current task's runtime statistics.
  */
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
-	u64 delta_exec;
+	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	if (unlikely(delta_exec <= 0))
 		return;
 
-	curr->exec_start = now;
-
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
-
-	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
-
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -955,26 +955,15 @@ static void update_curr_rt(struct rq *rq
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 delta_exec;
-	u64 now;
+	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec < 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1689,6 +1689,8 @@ extern const u32		sched_prio_to_wmult[40
 
 #define RETRY_TASK		((void *)-1UL)
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 	const struct sched_class *next;
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -62,21 +62,7 @@ static void yield_task_stop(struct rq *r
 
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *curr = rq->curr;
-	u64 delta_exec;
-
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
-	if (unlikely((s64)delta_exec < 0))
-		delta_exec = 0;
-
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = rq_clock_task(rq);
-	cgroup_account_cputime(curr, delta_exec);
+	update_curr_common(rq);
 }
 
 /*


