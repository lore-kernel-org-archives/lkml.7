Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC1720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fMy/vbJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfJ3SeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:22 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33209 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfJ3SeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:18 -0400
Received: by mail-yb1-f193.google.com with SMTP id e14so1326993ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DGSETA7D0h692ZpiwRHsLL/KeVnMBVIjCqAn4OuArLA=;
        b=fMy/vbJmKWCqMmypzQhjB0ysWRvCI6XMdMIntG0EeZQEQEDurZbf7Z6OCcP98Qukdd
         ovMfsQxrw/6nQUrSNkJOF5r74BZaKCwqtIrl/CahN3blyPQ/1QWeWU5Kjdiu8bygkaCh
         OOdjCiHfI9s6Xlxz4NNaRFFMu2JAe5t+uIklc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DGSETA7D0h692ZpiwRHsLL/KeVnMBVIjCqAn4OuArLA=;
        b=KhljH9xKJ2va6lfe6YiSbL/xLl5K78q/YzYTo7lY1ATk9AZgKGs3sPSDOrxqCBa1QP
         b0NEwA19A0a/9QmDnmzOhuINfmQX0itFxbF6vjjbnPs7yOCgj8NssNP936YMjLozz144
         H6uPtpnmMfioA9sPJ222EAs24/eIZibtVWh1htmdwpSUpSKV80rfPK41UK2ehG1CcuHu
         iqvhcrV15k2OKKRAn5gNm/K2sagLO2rO1ShCSrAHhFBludgb+FOdcJBRY49k85AzhTpE
         CxFa4mwA1YlyDGiYLpi2aZWDyXG7vNDC06nmM79Vtg2ZxEAT6bApdtBr24QUGQw3CXOh
         HM/w==
X-Gm-Message-State: APjAAAV2FRKIf60bzn+J8xjfGcFeiyzdIqvwuK9LLz/kDsZ9p/mNE5NI
        MvAym4ax26WpRic36/LaqQGwqw==
X-Google-Smtp-Source: APXvYqxmBHMADmmBDLZlh+K53pRq5l6X+6FEuaNPfRQ0qe5YE9Qoa683pMN1OJ+tD9PU8e9wB8khxA==
X-Received: by 2002:a25:2611:: with SMTP id m17mr640559ybm.124.1572460456868;
        Wed, 30 Oct 2019 11:34:16 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id d205sm721653ywh.75.2019.10.30.11.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:16 -0700 (PDT)
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v4 09/19] sched: Introduce sched_class::pick_task()
Date:   Wed, 30 Oct 2019 18:33:22 +0000
Message-Id: <7e75e9e096a2690dfb97641ca34047cd11d4c495.1572437285.git.vpillai@digitalocean.com>
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

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/deadline.c  | 21 ++++++++++++++++-----
 kernel/sched/fair.c      | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      | 10 +++++++++-
 kernel/sched/rt.c        | 21 ++++++++++++++++-----
 kernel/sched/sched.h     |  2 ++
 kernel/sched/stop_task.c | 21 ++++++++++++++++-----
 6 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0c7a51745813..461f1c1b791d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1722,15 +1722,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *
-pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct task_struct *p;
 	struct dl_rq *dl_rq;
 
-	WARN_ON_ONCE(prev || rf);
-
 	dl_rq = &rq->dl;
 
 	if (unlikely(!dl_rq->dl_nr_running))
@@ -1741,7 +1738,19 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = dl_task_of(dl_se);
 
-	set_next_task_dl(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -2380,6 +2389,8 @@ const struct sched_class dl_sched_class = {
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_dl,
+
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 850e235c9209..cc78b334e1c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4211,7 +4211,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4229,13 +4229,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	/*
 	 * Prefer last buddy, try to return the CPU to a preempted task.
 	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
 		se = cfs_rq->last;
 
 	/*
 	 * Someone really wants this to run. If it's not unfair, run it.
 	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
 		se = cfs_rq->next;
 
 	clear_buddies(cfs_rq, se);
@@ -6786,6 +6786,34 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		set_last_buddy(se);
 }
 
+static struct task_struct *
+pick_task_fair(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct sched_entity *se;
+
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		se = pick_next_entity(cfs_rq, NULL);
+
+		if (curr) {
+			if (se && curr->on_rq)
+				update_curr(cfs_rq);
+
+			if (!se || entity_before(curr, se))
+				se = curr;
+		}
+
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+
 static struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -10469,6 +10497,8 @@ const struct sched_class fair_sched_class = {
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_fair,
+
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5bb8d44fbff9..87c55e3b988d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,6 +374,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
+static struct task_struct *
+pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
@@ -387,11 +393,12 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next = rq->idle;
+	struct task_struct *next;
 
 	if (prev)
 		put_prev_task(rq, prev);
 
+	next = pick_task_idle(rq);
 	set_next_task_idle(rq, next);
 
 	return next;
@@ -459,6 +466,7 @@ const struct sched_class idle_sched_class = {
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 09c317a916aa..4714630a90b9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,20 +1548,29 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *
-pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!rt_rq->rt_queued)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task_rt(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_rt(rq);
+	if (p)
+		set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2364,6 +2373,8 @@ const struct sched_class rt_sched_class = {
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_rt,
+
 	.select_task_rq		= select_task_rq_rt,
 
 	.set_cpus_allowed       = set_cpus_allowed_common,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 16c9654ac750..44f45aad3f97 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1725,6 +1725,8 @@ struct sched_class {
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 7e1cee4e65b2..fb6c436cba6c 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -29,20 +29,30 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
 }
 
 static struct task_struct *
-pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+pick_task_stop(struct rq *rq)
 {
 	struct task_struct *stop = rq->stop;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	set_next_task_stop(rq, stop);
-
 	return stop;
 }
 
+static struct task_struct *
+pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_stop(rq);
+	if (p)
+		set_next_task_stop(rq, p);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -129,6 +139,7 @@ const struct sched_class stop_sched_class = {
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
-- 
2.17.1

