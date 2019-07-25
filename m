Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC2C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0473F22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AoSUvOgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfGYQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:15:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGYQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:15:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGFKEf1075074
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:15:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGFKEf1075074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071321;
        bh=28hNTJUWySJ7mONJThPH7+Zsj8pU+f/59Q8yun5JHTw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AoSUvOgHzIk6Hlb7nZV1FbDEEsvHVURngzenDG8Y3tzmaZwcT/zh/TUw+NyxAen3U
         UHXBpPA3haRkSmHZQbQY/qRjuI2KFVGRHTsQfUsqk7RDd5fe95C5BHbarcxNzZZRZQ
         k8HZfHRq/8luOIWKLHXaIDXMY0a8emUunem47EAVKDIXORuCbYMuMp+R14HVqANEeC
         FzSdvRJ1mDVZrpBqsA6J6p+V1bx0Jt2YG8nThOF+oG4ZHLg4R8QXRiXg6XaeoXq5SH
         LVWVwsgPfE9AS+/obZfdwGKgXguXmw0+nyr/7wr02ZHGrmFlv4TCJOiCuMaknbyfPB
         K2f70QdQsb92g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGFKdA1075071;
        Thu, 25 Jul 2019 09:15:20 -0700
Date:   Thu, 25 Jul 2019 09:15:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-43e9f7f231e40e4534fc3a735da152911a085c16@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.guittot@linaro.org, hpa@zytor.com, viresh.kumar@linaro.org
Reply-To: torvalds@linux-foundation.org, vincent.guittot@linaro.org,
          mingo@kernel.org, viresh.kumar@linaro.org, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org,
          daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <0d3cdc427fc68808ad5bccc40e86ed0bf9da8bb4.1561523542.git.viresh.kumar@linaro.org>
References: <0d3cdc427fc68808ad5bccc40e86ed0bf9da8bb4.1561523542.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Start tracking SCHED_IDLE tasks count
 in cfs_rq
Git-Commit-ID: 43e9f7f231e40e4534fc3a735da152911a085c16
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

Commit-ID:  43e9f7f231e40e4534fc3a735da152911a085c16
Gitweb:     https://git.kernel.org/tip/43e9f7f231e40e4534fc3a735da152911a085c16
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Wed, 26 Jun 2019 10:36:29 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:53 +0200

sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq

Track how many tasks are present with SCHED_IDLE policy in each cfs_rq.
This will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chris.redpath@arm.com
Cc: quentin.perret@linaro.org
Cc: songliubraving@fb.com
Cc: steven.sistare@oracle.com
Cc: subhra.mazumdar@oracle.com
Cc: tkjos@google.com
Link: https://lkml.kernel.org/r/0d3cdc427fc68808ad5bccc40e86ed0bf9da8bb4.1561523542.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 14 ++++++++++++--
 kernel/sched/sched.h |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9be36ffb5689..9ed5ab53872f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4555,7 +4555,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, dequeue = 1;
 	bool empty;
 
 	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
@@ -4566,6 +4566,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -4575,6 +4576,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
 		if (qcfs_rq->load.weight)
 			dequeue = 0;
@@ -4614,7 +4616,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
-	long task_delta;
+	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -4634,6 +4636,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			enqueue = 0;
@@ -4642,6 +4645,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5255,6 +5259,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int idle_h_nr_running = task_has_idle_policy(p);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5287,6 +5292,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -5294,6 +5300,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5355,6 +5362,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	int idle_h_nr_running = task_has_idle_policy(p);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5369,6 +5377,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -5388,6 +5397,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..aaca0e743776 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -483,7 +483,8 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned long		runnable_weight;
 	unsigned int		nr_running;
-	unsigned int		h_nr_running;
+	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	u64			exec_clock;
 	u64			min_vruntime;
