Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C78C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="haj7hgDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfJ3SeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:18 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45386 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfJ3SeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:13 -0400
Received: by mail-yb1-f196.google.com with SMTP id q143so1290396ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tBQRYzPOu2X0VuL5aGW3hRK0A7H69nk97Z0lgRZxnPo=;
        b=haj7hgDNm8/t8vU4aHKMsYkFUWKR5ustCTfRZ9xLeeAunkcHJfoDv8VZFnoMLia/go
         3eQ5FOmuWv3N5MUO8CULiFz1ZMHmWTdVajbCIouKQ78iV7IyDfw+5Xo1ufWrtfa4zfIc
         JjVZi50gSSm5QMx6LuvPVacqcTRnZi+4dL1ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tBQRYzPOu2X0VuL5aGW3hRK0A7H69nk97Z0lgRZxnPo=;
        b=XwKf5DrJ3pbvMkZbWsvodP0eFLKOTlw8BqW2LrJkLR5YR5PpYr69remBP5DEY26PGw
         qFYnT19QsaPh7nDFRnBhJxv+OQkU7CpZm23bRwADoYXC3ydrIEg/Px5M017J5EDx0lvO
         jrtiKiAMuO6uWbSnZhV2/J8yzPXHyGlZHWwIC7eCCJhoxxOWnKZil+eeTo4uv8yfq3ue
         ZyFHRn9PYJIf96MA62WnXdd1naG6t7ouxvsAWEglgGvFaYAIuYJReEPS2siUhWcjHoXl
         0JcO4yggWT1w+dJ5c6B8h8blk6enqj2Ro1a6W743fnRkXHvWtJos3Cx2fU+aPYOsMRwG
         ZVzA==
X-Gm-Message-State: APjAAAWL382YfpHegReoaXvEhsJfT/qzX94eU3rjRH5avHQPl7wwh345
        aM3GJzLct2g5UVKdQRvQIyrZBg==
X-Google-Smtp-Source: APXvYqwdB85ZkJAPWVqnzQjzGKF1P96CUYkRcEIOSbO924SSbXTvJF5tIVtdmmQZXdjV5y/qjtWfWg==
X-Received: by 2002:a25:fc26:: with SMTP id v38mr647354ybd.322.1572460452756;
        Wed, 30 Oct 2019 11:34:12 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id k62sm245693ywd.72.2019.10.30.11.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:12 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 07/19] sched: Allow put_prev_task() to drop rq->lock
Date:   Wed, 30 Oct 2019 18:33:20 +0000
Message-Id: <d0b63d308a8635438597d780977cff955c5009cd.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
index 95cc10ecc7c9..3fa7d37f2879 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6015,7 +6015,7 @@ static void calc_load_migrate(struct rq *rq)
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
-static void put_prev_task_fake(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fake(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38b45f2f890b..416e06c97e98 100644
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
index c6b6835a5945..7ee57472d88e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6930,7 +6930,7 @@ done: __maybe_unused;
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 3ff4889196e1..5848ae3d5210 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,7 +374,7 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a857945772d1..a7d9656f70b5 100644
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
index dc889af24efb..8b86b24a3ccd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1718,7 +1718,7 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
@@ -1764,7 +1764,7 @@ struct sched_class {
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

