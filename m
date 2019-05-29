Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0524190
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="VQwl52pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfE2Uhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40338 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfE2UhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:05 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so3063416ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mxMDXOH11CG9HkxEHER6u//QzdgDeYc242m4FO3zHhs=;
        b=VQwl52pfbj2HNX+AUbmZeECsVhh7wZ0t9zb0xkLDHiQAGt2iBVcQ/ejQ6xRJA8Fp15
         HASY5F1j0/yj7iSpimUspru643Fz0OgdcWmPNiqneBaDtDWz2wNSR2+zVhQY/jOdTlFS
         kyzFIfsEB9Vw3KLLmspAZdSPpDkVvL8LKaiJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mxMDXOH11CG9HkxEHER6u//QzdgDeYc242m4FO3zHhs=;
        b=BVOjA04GBGdh3bii7t0YzBLxYt9ostKW35zkQPuYw3limyKWbCXkKvDe5NrhX7q2V+
         feL5BheCQPSN9lehQYL7JDBq9paDj1MoO4V3LyezzfP3+ZttO2qc9Io6sy4f0UeZBoC/
         r0R2z5Ezs8fydfgxwEteuVHTMdOQ8Hy9BR1YnKK3hEpKvs/Dxaa6YtxKats3bT0YXzEI
         EvLY62WrlYKXgcpsiyyiMGkPDeAI4k4onXLm4SssiJzdZPn7cLKAktV7kL5wMIQeoq/7
         DJgrPcL+ZI52e+uC466MKU/5hA5f6BhN5NCgjDzTcLsu4dGob0V4naQPDl+vZNf5ZL9/
         SKlg==
X-Gm-Message-State: APjAAAXFhNv/DNJA/uK/BWhciAOK1/IYHWpWrbVdU/lXWANEguFccuFQ
        5MV/GIV3zv1Efm0BiYc/1RyCsQ==
X-Google-Smtp-Source: APXvYqxkW13RPtDLKh9rmPsHJcTDyDIlmW7QV9Z+9HD171M5MCD5mb9zf5cCoFq+ssLihO4xUvNvvw==
X-Received: by 2002:a5e:8704:: with SMTP id y4mr7244581ioj.135.1559162224143;
        Wed, 29 May 2019 13:37:04 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id c18sm156012iob.80.2019.05.29.13.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:03 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 07/16] sched: Allow put_prev_task() to drop rq->lock
Date:   Wed, 29 May 2019 20:36:43 +0000
Message-Id: <e4519f6850477ab7f3d257062796e6425ee4ba7c.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Currently the pick_next_task() loop is convoluted and ugly because of
how it can drop the rq->lock and needs to restart the picking.

For the RT/Deadline classes, it is put_prev_task() where we do
balancing, and we could do this before the picking loop. Make this
possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |  2 +-
 kernel/sched/deadline.c  | 14 +++++++++++++-
 kernel/sched/fair.c      |  2 +-
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        | 14 +++++++++++++-
 kernel/sched/sched.h     |  4 ++--
 kernel/sched/stop_task.c |  2 +-
 7 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 32ea79fb8d29..9dfa0c53deb3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5595,7 +5595,7 @@ static void calc_load_migrate(struct rq *rq)
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
-static void put_prev_task_fake(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fake(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c02b3229e2c3..45425f971eec 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1772,13 +1772,25 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
+
+	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
 }
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49707b4797de..8e3eb243fd9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7110,7 +7110,7 @@ done: __maybe_unused;
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index dd64be34881d..1b65a4c3683e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,7 +373,7 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index adec98a94f2b..51ee87c5a28a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1593,7 +1593,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_rt(rq);
 
@@ -1605,6 +1605,18 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
+
+	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_rt_task(rq);
+		rq_repin_lock(rq, rf);
+	}
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bfcbcbb25646..4cbe2bef92e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1675,7 +1675,7 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
@@ -1721,7 +1721,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev);
+	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 47a3d2a18a9a..8f414018d5e0 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -59,7 +59,7 @@ static void yield_task_stop(struct rq *rq)
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;
-- 
2.17.1

