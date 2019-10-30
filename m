Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C3CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1EA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UhDoc/q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfJ3Se7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:59 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44489 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfJ3Se2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:28 -0400
Received: by mail-yw1-f66.google.com with SMTP id i123so1176802ywe.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=98e7PpYrKI/1xEOfuSF5mHE9VtQjq+YVN1RFcXUJZJY=;
        b=UhDoc/q0Xi+MHNJo2gJyJLb+lk6GPvK/4QXUNnYherZzqwpYap1C+ntVLA7lldhTky
         K19gA/3x01yBhy7xSE2xcqqvQSubrWzmIphusSESE6gs0oQwJDRAW3ydsf09KTq4HjGV
         hblKWMnLwGOruycNy2W/07xSNRhv1TkHWEXLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=98e7PpYrKI/1xEOfuSF5mHE9VtQjq+YVN1RFcXUJZJY=;
        b=T/QwjOqa+GVfP06LHovrJTEwYFwv4kdBW1oKqvzgXbBu0Ey64SVfHPB5lNG5ob+byY
         aWhZyGI4A+qOhhrFySrZ4Ls2wG4rdmJOXphEYL80nd9AYzbWAaCdppJ+OTqYBdbpc9QO
         va54RZTnBTwivTpFWdLp6AF+Dc1ODI2lcjc06v/v/iq+CvMFrAbKByoUDknPtv0kRjL5
         EQjTk0L7iQc6ZBsFdtI7c7pqEO/irfgf77YbyU8m1VigkevA6F/V1+Gp6HPds/OMWFDS
         56EBcC38Aoo9nV8INqYdE+2ec+dPJXck/UWFVMMURCGCbv73+i0g9Wz1w6Ghi4Csurx2
         T7NQ==
X-Gm-Message-State: APjAAAW5mssqdTc66SJQy7jGJW67WToAxQvDJ5/DxVpkqI2CJ8mzE4ij
        /lTmQVnEHXZVMldwInzjTlAAkw==
X-Google-Smtp-Source: APXvYqyvcXec1FDLwGvaTDj3toyX4rzl1ZsYh9gTFDxYzNdZO0zfbtbMVQbB66nO9GMYNJM22aMLfA==
X-Received: by 2002:a0d:f887:: with SMTP id i129mr809992ywf.343.1572460467731;
        Wed, 30 Oct 2019 11:34:27 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id n65sm270432ywf.99.2019.10.30.11.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:27 -0700 (PDT)
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
Subject: [RFC PATCH v4 16/19] sched: Debug bits...
Date:   Wed, 30 Oct 2019 18:33:29 +0000
Message-Id: <b0d52363baebb9c8e05899e3171f1b51ea0f3b86.1572437285.git.vpillai@digitalocean.com>
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

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f0a63fe5f0a4..18fbaa85ec30 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -104,6 +104,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -258,6 +262,8 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
@@ -266,6 +272,8 @@ static void __sched_core_disable(void)
 
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -4083,6 +4091,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -4162,6 +4178,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
+
 				goto done;
 			}
 
@@ -4170,6 +4189,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -4186,6 +4208,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -4213,6 +4237,7 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -4238,11 +4263,20 @@ next_class:;
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
@@ -4281,6 +4315,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -6921,6 +6959,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1

