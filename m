Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54AB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pM9GmN8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDYJhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:37:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45948 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfDYJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:37:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so6483089pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iq/bivqDNw4UWEitcfvy3I+JHGmEQEUsypk4F+POh50=;
        b=pM9GmN8F0uzTCNoL074eI2mPsgbkwh0i9EM7iZ2buiBA+82fygsTV1YSb4zel73rAU
         HxPKdULUwLWNm4yfdqHOX4+8Db3s4TOe9CTNtBmYnZcVg5DvBN/3MjWkwLSmLOI0WT/y
         917900Gz178TyLvXmj5nK1JGTeLBW4dFQv0JOceOIefGDLv9VSn0YB53GM3ZJ5qDraDs
         1tQ7A5+jCTqbE6XbSSNhd4AEjcx3ieY4tqs/d6ylrO86xTzL5rwrm94+MO3yMo0sRN/y
         uWsk94MGfHqF2H5/bKTIJEtyLuZvMMd0iHt44jrJTjHmEamOc61+MYdsFsrbU23wqj5c
         R7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iq/bivqDNw4UWEitcfvy3I+JHGmEQEUsypk4F+POh50=;
        b=OsKKwQy9h9/GQFOQ0ffCTkirk3KmSbOSqTTCWefaiI1ytRZsOm2UUUZrMrLua7aZDn
         DdNuvA2X2QVIJlSOluZS4g7YZaAy8vi/y5+JjLGAxrYtRJb7BJkfoF3t7IA6nk+aHY4+
         L6xEtSoYD8AS2jK31vbkSrVizI37K6UI4tRSjM3vnW5HSxohiLcE1VJ0bwALWAKtU5op
         Dh2kvnwzNB7rfz1fH/KidlIrFmqLgm1WK5Ffp32HM+j78vWEk9+HiQPlXzxI/sC4ugdr
         +EyuJgE+PfxjAyLSpDcMqBy/wpy9GdCgXQZtFuw2Foc2zuTPtd0JMIywR+XAl2Q0kw//
         Vhaw==
X-Gm-Message-State: APjAAAUVLCw0qvM0nuuUrWOFTKwq78M0w0ImxHgHfIN4DZ9couQrZNNV
        pYxNfDEKiA1vq84gIyFkBYMq5VnrIcI=
X-Google-Smtp-Source: APXvYqyeo5M1Rd9HfVjpcjOrdSYIRag0mz6NnUVj2Ss0OB01uRV09xBIrqsGCzE6eyAGbbnQidhbDQ==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr38598391plo.283.1556185067744;
        Thu, 25 Apr 2019 02:37:47 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h4sm29206595pfo.119.2019.04.25.02.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:37:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC V2 1/2] sched: Start tracking SCHED_IDLE tasks count in cfs_rq
Date:   Thu, 25 Apr 2019 15:07:39 +0530
Message-Id: <ec46d6d30116742c48bfc0eb301aa72df266d6ce.1556182965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1556182964.git.viresh.kumar@linaro.org>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start tracking how many tasks with SCHED_IDLE policy are present in each
cfs_rq. This will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c  | 14 ++++++++++++--
 kernel/sched/sched.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4275eb07c0b2..6511cb57acdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4475,7 +4475,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, dequeue = 1;
 	bool empty;
 
 	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
@@ -4486,6 +4486,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -4495,6 +4496,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
 		if (qcfs_rq->load.weight)
 			dequeue = 0;
@@ -4534,7 +4536,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
-	long task_delta;
+	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -4554,6 +4556,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			enqueue = 0;
@@ -4562,6 +4565,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5166,6 +5170,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5198,6 +5203,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -5205,6 +5211,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5266,6 +5273,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	int idle_h_nr_running = unlikely(task_has_idle_policy(p)) ? 1 : 0;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5280,6 +5288,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -5299,6 +5308,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..0f07d9b55a79 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -490,6 +490,8 @@ struct cfs_rq {
 	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;
+	/* h_nr_running for SCHED_IDLE tasks */
+	unsigned int		idle_h_nr_running;
 
 	u64			exec_clock;
 	u64			min_vruntime;
-- 
2.21.0.rc0.269.g1a574e7a288b

