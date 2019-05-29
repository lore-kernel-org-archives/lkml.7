Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A97622389
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="hKVDrehS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfE2Uh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50829 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE2UhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:19 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so6289176itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yEC2+0WbuuZvbN9MF45zkkqCR1Y7Z1sJ51mOopvbHAk=;
        b=hKVDrehSDieR9MoJvSMG7Xqzi1n92lgzoTohYWiGf/plciqM42g2cQZnvd/w3NkoF7
         hZgv6jpp9pj45C+kYb8bhqxE0M/gqLrLuQD99z+p62vx1/+b9FDY/4bqoA58/wiIywPQ
         YUXDo1hMYdigFK37dWXScJgMJe+nHzTu9lrQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yEC2+0WbuuZvbN9MF45zkkqCR1Y7Z1sJ51mOopvbHAk=;
        b=FcmMOY+4XH2YSXV6sZQlLMegYh69lwwMqTuWa/rFxeIeaK8n0fOWM/+nB2WMxuw3rs
         sPoLnRSNEqYkSF00ybME5sBPU6S83hTEyq6K2FxHQlAqPxPc2FT0p91Zk2DboYrnItfG
         cXN9+zb2jEZWWxkigxlalC45lH91azi3jcTqyNUFX0n59505S0pHcHllrJHxdirB79t4
         Enj9MTbHuRu3Uxsbmr1VmVcYVrdFrAj6FgzAkMX30gPxYjVblxG0IYHz44P5k1Pqtm9Y
         Zm3GWbWwvukiSWeAotFD5OflH6AllausbUIxW/MuT5OQMVO/08GxC0ph0OFCRLWrnKpD
         T/mw==
X-Gm-Message-State: APjAAAU8F5rgfR5MPQcitL3G7ithDupyhE69Tj+VjKWQl4f8GrGgmnUe
        daAcS6cYL9/KRHt1NJ4dGftjKg==
X-Google-Smtp-Source: APXvYqzpHUgm1M0B0O7mm8LRVDyAgyq6PZCteW6QL0Isd7Qi9BjXYkORb5rlea6kiWaBAqi50Uo5aw==
X-Received: by 2002:a02:2b1d:: with SMTP id h29mr28154932jaa.76.1559162233048;
        Wed, 29 May 2019 13:37:13 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id k203sm159596itk.41.2019.05.29.13.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:12 -0700 (PDT)
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
Subject: [RFC PATCH v3 16/16] sched: Debug bits...
Date:   Wed, 29 May 2019 20:36:52 +0000
Message-Id: <c1fd166d42ded9cc9839eb2722174549059dd36f.1559129225.git.vpillai@digitalocean.com>
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

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b8223c9a723..90655c9ad937 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -92,6 +92,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -246,6 +250,8 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
@@ -254,6 +260,8 @@ static void __sched_core_disable(void)
 
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -3707,6 +3715,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			put_prev_task(rq, prev);
 			set_next_task(rq, next);
 		}
+
+		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
+			     rq->core->core_task_seq,
+			     rq->core->core_pick_seq,
+			     rq->core_sched_seq,
+			     next->comm, next->pid,
+			     next->core_cookie);
+
 		return next;
 	}
 
@@ -3786,6 +3802,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
+
 				goto done;
 			}
 
@@ -3794,6 +3813,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -3810,6 +3832,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -3837,6 +3861,7 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -3862,11 +3887,20 @@ next_class:;
 		if (i == cpu)
 			continue;
 
-		if (rq_i->curr != rq_i->core_pick)
+		if (rq_i->curr != rq_i->core_pick) {
+			trace_printk("IPI(%d)\n", i);
 			resched_curr(rq_i);
+		}
 
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+		if (unlikely(!cookie_match(next, rq_i->core_pick))) {
+			trace_printk("[%d]: cookie mismatch. %s/%d/0x%lx/0x%lx\n",
+				     rq_i->cpu, rq_i->core_pick->comm,
+				     rq_i->core_pick->pid,
+				     rq_i->core_pick->core_cookie,
+				     rq_i->core->core_cookie);
+			WARN_ON_ONCE(1);
+		}
 	}
 
 done:
@@ -3905,6 +3939,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -6501,6 +6539,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1

