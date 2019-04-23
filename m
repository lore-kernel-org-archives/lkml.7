Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E13C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97FF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Qrwe40Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfDWQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:19:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40186 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfDWQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:59 -0400
Received: by mail-io1-f67.google.com with SMTP id i21so12517726iol.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=U4Bk9ysil8FB8vbEYXTiQbrVskD3ILGclaWtUsLKJQM=;
        b=Qrwe40WpI1NWOItCU4AczgY5YJlJgvdRPMNtfpR84Oqcx5bPv2f8HPud0oUd0St+oV
         atDWfdyDNrcv5nqHCOv987/9zuaNhSPq0VeejdiUtskW//YT2heeVCRk0qwsY92Yy7bq
         RKC092fZ7oSyUvW9QaCeA2gqmBu8A6TsbxqCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=U4Bk9ysil8FB8vbEYXTiQbrVskD3ILGclaWtUsLKJQM=;
        b=BXv0k6UG6d1y/TT7xZuA6dUOi9cMNl8zjd28HRfF53fZrLJ2RmF2eQOA+vkXLfnWUa
         j8ettXkw6PgsOv5vsooKZDbAcssqAo0TB7jdTyOu18Hr94tRTEBpfXk1c8q5IPwH/DT2
         tLbs+3pnRRH8Pb9olP26b+bDNAqpaF74FcMVIPeP2+dLnwZIKZmeG3WgTMnUBAOHjlg6
         naRaDLFjLITUOB6Uqr+LljcdN4Bibg4Dcoa2lUzrMwc2oBAYTzdA8KFmw9raVQ94LH1R
         5kvaGcoph0ScqObpO2qbxJvLl++WzPBE2p51ybSadOiI9fcB8DzxAFLyNgnQ75ykXygY
         bnxQ==
X-Gm-Message-State: APjAAAW0i61K1pymZLnqqFIfNq4gNfgpZSy1EeFEugc03rFljzxNQj/g
        dZdA9QAKWjBRXUBHiasgzg2LJA==
X-Google-Smtp-Source: APXvYqw3h/PKouTk0VHvIKTbpQruRLvPpAAqIky+YUQYX840HTdAXe1ZKjXA0cdifthIPeFrHurEgA==
X-Received: by 2002:a5e:8a0a:: with SMTP id d10mr12016381iok.132.1556036338149;
        Tue, 23 Apr 2019 09:18:58 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id b199sm8007021itb.29.2019.04.23.09.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:57 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/17] sched: Debug bits...
Date:   Tue, 23 Apr 2019 16:18:22 +0000
Message-Id: <57169361f2adf39569e061d3dd1e5588d22c65a3.1556025155.git.vpillai@digitalocean.com>
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

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e3c51a1b54a..e8e5f26db052 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -106,6 +106,10 @@ static inline bool __prio_less(struct task_struct *a, struct task_struct *b, boo
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -264,6 +268,8 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
@@ -272,6 +278,8 @@ static void __sched_core_disable(void)
 
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -3706,6 +3714,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -3777,6 +3793,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				next = p;
 				rq->core_pick = NULL;
  
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+					     next->comm, next->pid, next->core_cookie);
+
 				/*
 				 * If the sibling is idling, we might want to wake it
 				 * so that it can check for any runnable tasks that did
@@ -3787,6 +3806,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq_j->core_pick = NULL;
 					if (j != cpu &&
 					    is_idle_task(rq_j->curr) && rq_j->nr_running) {
+						trace_printk("IPI(%d->%d[%d]) idle preempt\n",
+							     cpu, j, rq_j->nr_running);
 						resched_curr(rq_j);
 					}
 				}
@@ -3798,6 +3819,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+				     i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -3812,6 +3836,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
+
 				if (old_max && !cookie_match(old_max, p)) {
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
@@ -3847,13 +3873,17 @@ next_class:;
 		if (i == cpu)
 			continue;
 
-		if (rq_i->curr != rq_i->core_pick)
+		if (rq_i->curr != rq_i->core_pick) {
+			trace_printk("IPI(%d)\n", i);
 			resched_curr(rq_i);
+		}
 	}
 
 	rq->core_sched_seq = rq->core->core_pick_seq;
 	next = rq->core_pick;
 
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
+
 done:
 	set_next_task(rq, next);
 	return next;
@@ -3890,6 +3920,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -6471,6 +6505,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);
-- 
2.17.1

