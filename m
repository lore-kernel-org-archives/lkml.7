Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E1C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543F92183F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ByM7ru0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfE2UhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51509 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfE2UhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:13 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so6276655itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PpmrO9QSzjOPZoRPgSbvtF4t4n5qN659GHtpQTPUio8=;
        b=ByM7ru0fShaA1rV89WRBqqlpBw3E0TXrDgzrwddMshQsmrU/WPq03xq7Mf58eA+jGX
         WDkrG3A79yclSVPlUYds+mHlQq58fWMBF1kSz8dtS8CtUnhHuWuJud+AetTzWmDARzRQ
         WhCw/DtS5ImIPW+bJv4/HXXWIft6o67y6GpR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PpmrO9QSzjOPZoRPgSbvtF4t4n5qN659GHtpQTPUio8=;
        b=hs6t+5lyHKxiMYTmnVygw3US7Kzy1eXy3rPPRtAVJ60iDgTAwqcMx7H5TmVWTr8Nm9
         +frH+Cab055b6N3DT7GVAIVJjMc+n8sYe7oXRkfu1/YwJoNR95Z2A+rWdbhjhxTmAphb
         Fl9lcAU7dJl45aZivdjYrnN1Entw9Ufj8cUPdEaFQJLeGrXPfLmAnr+ytwXLZAS54dB0
         Nc9NmBgw0B9BE2HhI48soWR0+B1vcSHQAWkssnSxDjT3AqXwNWSMclnGxIeiqAdMCuhP
         RULdQuemtYUv//qlpYzHHoQpucqCrDIv/YOGJaggWxcuIl/UhvHwFKiWUc9EYMncyBiU
         EmFA==
X-Gm-Message-State: APjAAAVx/eUI8eoSCPUti4FlqXyWS+4MKAoa87RE76WwQT5ZmMe7ki5+
        7YXDc3GGLZcz6BjpqWEbHQxILA==
X-Google-Smtp-Source: APXvYqwkbByxJ4oKotHMZXIyusSdhb2+tWL2GONVZluaT3z30NO37g1md4xvXjND2cp3Y4th3jfn0w==
X-Received: by 2002:a24:27c6:: with SMTP id g189mr164783ita.114.1559162232136;
        Wed, 29 May 2019 13:37:12 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id e22sm175685iob.66.2019.05.29.13.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:11 -0700 (PDT)
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
Subject: [RFC PATCH v3 15/16] sched: Trivial forced-newidle balancer
Date:   Wed, 29 May 2019 20:36:51 +0000
Message-Id: <011e60ed11ce980da400e4835a8994f9d98b134d.1559129225.git.vpillai@digitalocean.com>
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
index e25811b81562..5b8223c9a723 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -199,6 +199,21 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
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
 	bool need_sync = false;
 
 	if (!sched_core_enabled(rq))
@@ -3774,6 +3789,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -3799,6 +3817,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				} else {
 					/*
@@ -3838,6 +3857,8 @@ next_class:;
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
 			rq->core_forceidle = true;
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -3853,6 +3874,114 @@ next_class:;
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
index cd8ced09826f..e91c188a452c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1014,6 +1014,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1026,6 +1028,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
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

