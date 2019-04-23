Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AACB2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="SgfnErvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfDWQTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45630 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfDWQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:57 -0400
Received: by mail-io1-f66.google.com with SMTP id e8so798860ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=R44A5/YkLGkeY9si7Vswv49s16/buRIZLRAf2l2d/Vc=;
        b=SgfnErvWNi4dnKwE0F9wsbTY7BqXNr2Q84AudXiI5tAK6QkjeRAd/o8rvAA5VYjTcw
         SVmJy5mvrRFsIIwP1Y4IRBRUDWJor1nJgpXFPqrHzOFxnOGpQZwP+b8tvbiiH05d9wyJ
         SDEKLeC9h1RLvFJdBvYHbnv041wC1R9h35RVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R44A5/YkLGkeY9si7Vswv49s16/buRIZLRAf2l2d/Vc=;
        b=eksQM+ITkZMty5TVV2bbz1c3FHaykuqAj+pfRdMsL6PU9YWMMI0qCGuZKEMyU49Xgy
         XAh94E1yAzXqhHOAkUEfCIUyyDZNWL8pR8x9qrwYKSV5cYOmO3uSYqfvmZ4WoGvWLDIX
         lBh1TWN8GPlNtRV3+udTaPVV5nUJzFecRfHrFOTPfmZPwO2ISXSFF8/dWq7faMvIA+FR
         N0fQUs6UIUZtQwTPa3nABV/VgD0U0RuYxWEyL/NuWReu5+dtG1Ds+cYiw79Q81VH3I1n
         4O2mMWpHXdi9t/jyI/2kzgnSY+F6ABh/18puDncnX1UqDR2PYIM5ovdKSRntPLm7Ya25
         5l5g==
X-Gm-Message-State: APjAAAU9jRn7lnAs9D+jOBzdodEoSunxKDiJFqDZEScafKAiY5fnpbkL
        Wvly2AHacdfQYjCsEUt8zTyJUw==
X-Google-Smtp-Source: APXvYqzvturXnpfXZbbAzRTsfAU8cxJjJ8hr8ynejcHo5H/6iPzOJRVEbaydUfzStPwgat4A9VBg2Q==
X-Received: by 2002:a5d:948d:: with SMTP id v13mr7854789ioj.59.1556036336055;
        Tue, 23 Apr 2019 09:18:56 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id y22sm5404570ioa.47.2019.04.23.09.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:55 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/17] sched: Trivial forced-newidle balancer
Date:   Tue, 23 Apr 2019 16:18:20 +0000
Message-Id: <002304fa58577c7926abe9f4cdc8039945985b3d.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |   1 +
 kernel/sched/sched.h  |   6 ++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4b39a28236f..1a309e8546cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -641,6 +641,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e6e90c6f9b9..e8f5ec641d0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -217,6 +217,21 @@ struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
+struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -3672,7 +3687,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
+	int i, j, cpu, occ = 0;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -3763,6 +3778,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -3786,6 +3804,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				}
 			}
@@ -3808,6 +3827,8 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -3823,6 +3844,114 @@ next_class:;
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_allowed))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	rcu_read_lock();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			break;
+
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static struct task_struct *
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e7f38da60373..44decdcccba1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -387,6 +387,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 static struct task_struct *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4cfde289610d..2a5f5a6b11ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1013,6 +1013,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1025,6 +1027,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.17.1

