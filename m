Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766FCC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C54820882
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Ot6xSkoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIEBod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:44:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40548 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIEBod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:44:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id f10so601868qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUhZHEq7bNl11lBnP+WiZRr0A7EAnMqBDd2Yv9VbHUo=;
        b=Ot6xSkoCR4XPnufaAAgE//PIBSVdd/vmli7d1fugt7luMAJ32oU33ZGOa6mqveJOuS
         Oz2OUzCkjLSPcQmw4dcG9DO8eZ+qiz9v6WuAyrTbMEN+ABhW9FCOvHTYqSWx7+HkXiOy
         cX4Kw+lyO01q9/OKjHfrSAkVaWv6wFLiPGFpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUhZHEq7bNl11lBnP+WiZRr0A7EAnMqBDd2Yv9VbHUo=;
        b=Y4ROG47nt7Mk90Xc0ogi/Jp8lFe6suwdR1qMwT7f2joN2CMLjVHjEsPyBY3fp5wxqZ
         AHmAlKSPfu1Q+/yWkEubYb2Tx+6Hz3tLBCkv7arg5xEEelE6Ej8JEoHrazDp7dB9LOol
         iO0e0vN/+OVCfQCpil4Vsjl9K4g2Uj+cK4rjw3f4nTEBkbHF628S1wOFXR/0Ox1pdvOT
         ptha2dcKRyi/pZfIxibxqoHtQeEF0MKgGO2WkIIjLwOK16aD2Udob/TDxiJWvsjQy4pu
         tibPmImsZi25sT/rQnifCl5BrT1mYEVFxv55qw9/Bbzzw1BQeqgUrWOYxYlVndjN203L
         bZLQ==
X-Gm-Message-State: APjAAAVvjKICwXiuqaN2SbRm56ms4eYGsE2iVl/ElFqOUXyDJhKeb0Qb
        5zNCeXAFNVqLpZPeyRot8RaQKQ==
X-Google-Smtp-Source: APXvYqyxGKkGJ18XGd/jaMSAhzxUv+1taC5JhD16oQChYk4/dubIPRD8rEBPeO+W8oGn7rQ4CyPs1Q==
X-Received: by 2002:a37:4ec2:: with SMTP id c185mr584332qkb.161.1567647871693;
        Wed, 04 Sep 2019 18:44:31 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id t17sm762737qtt.57.2019.09.04.18.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 18:44:30 -0700 (PDT)
Date:   Wed, 4 Sep 2019 21:44:23 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190905014423.GA5234@sinkpad>
References: <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Unfairness between the sibling threads
> -----------------------------------------
> One sibling thread could be suppressing and force idling
> the sibling thread over proportionally.  Resulting in
> the force idled CPU not getting run and stall tasks on
> suppressed CPU.
> 
> Status:
> i) Aaron has proposed a patchset here based on using one
> rq as a base reference for vruntime for task priority
> comparison between siblings.
> 
> https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/
> It works well on fairness but has some initialization issues
> 
> ii) Tim has proposed a patchset here to account for forced
> idle time in rq's min_vruntime
> https://lore.kernel.org/lkml/f96350c1-25a9-0564-ff46-6658e96d726c@linux.intel.com/
> It improves over v3 with simpler logic compared to
> Aaron's patch, but does not work as well on fairness
> 
> iii) Tim has proposed yet another patch to maintain fairness
> of forced idle time between CPU threads per Peter's suggestion.
> https://lore.kernel.org/lkml/21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com/
> Its performance has yet to be tested.
> 
> 2) Not rescheduling forced idled CPU
> ------------------------------------
> The forced idled CPU does not get a chance to re-schedule
> itself, and will stall for a long time even though it
> has eligible tasks to run.
> 
> Status:
> i) Aaron proposed a patch to fix this to check if there
> are runnable tasks when scheduling tick comes in.
> https://lore.kernel.org/lkml/20190725143344.GD992@aaronlu/
> 
> ii) Vineeth has patches to this issue and also issue 1, based
> on scheduling in a new "forced idle task" when getting forced
> idle, but has yet to post the patches.

We finished writing and debugging the PoC for the coresched_idle task
and here are the results and the code.

Those patches are applied on top of Aaron's patches:
- sched: Fix incorrect rq tagged as forced idle
- wrapper for cfs_rq->min_vruntime
  https://lore.kernel.org/lkml/20190725143127.GB992@aaronlu/
- core vruntime comparison
  https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/

For the testing, we used the same strategy as described in
https://lore.kernel.org/lkml/20190802153715.GA18075@sinkpad/

No tag
------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          828.15      32.45
Aaron's first 2 patches:        832.12      36.53
Tim's first patchset:           852.50      4.11
Tim's second patchset:          855.11      9.89
coresched_idle                  985.67      0.83

Sysbench mem untagged, sysbench cpu tagged
------------------------------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          586.06      1.77
Tim's first patchset:           852.50      4.11
Tim's second patchset:          663.88      44.43
coresched_idle                  653.58      0.49

Sysbench mem tagged, sysbench cpu untagged
------------------------------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          583.77      3.52
Tim's first patchset:           564.04      58.05
Tim's second patchset:          524.72      55.24
coresched_idle                  653.30      0.81

Both sysbench tagged
--------------------
Test                            Average     Stdev
Alone                           1306.90     0.94
nosmt                           649.95      1.44
Aaron's full patchset:          582.15      3.75
Tim's first patchset:           679.43      70.07
Tim's second patchset:          563.10      34.58
coresched_idle                  653.12      1.68

As we can see from this stress-test, with the coresched_idle thread
being a real process, the fairness is more consistent (low stdev). Also,
the performance remains the same regardless of the tagging, and even
always slightly better than nosmt.

Thanks,

Julien

From: vpillai <vpillai@digitalocean.com>
Date: Wed, 4 Sep 2019 17:41:38 +0000
Subject: [RFC PATCH 1/2] coresched_idle thread

---
 kernel/sched/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f7839bf96e8b..fe560739c247 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3639,6 +3639,51 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
+static int coresched_idle_worker(void *data)
+{
+	struct rq *rq = (struct rq *)data;
+
+	/*
+	 * Transition to parked state and dequeue from runqueue.
+	 * pick_task() will select us if needed without enqueueing.
+	 */
+	set_special_state(TASK_PARKED);
+	schedule();
+
+	while (true) {
+		if (kthread_should_stop())
+			break;
+
+		play_idle(1);
+	}
+
+	return 0;
+}
+
+static void coresched_idle_worker_init(struct rq *rq)
+{
+
+	// XXX core_idle_task needs lock protection?
+	if (!rq->core_idle_task) {
+		rq->core_idle_task = kthread_create_on_cpu(coresched_idle_worker,
+				(void *)rq, cpu_of(rq), "coresched_idle");
+		if (rq->core_idle_task) {
+			wake_up_process(rq->core_idle_task);
+		}
+
+	}
+
+	return;
+}
+
+static void coresched_idle_worker_fini(struct rq *rq)
+{
+	if (rq->core_idle_task) {
+		kthread_stop(rq->core_idle_task);
+		rq->core_idle_task = NULL;
+	}
+}
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -6774,6 +6819,7 @@ void __init sched_init(void)
 		atomic_set(&rq->nr_iowait, 0);
 
 #ifdef CONFIG_SCHED_CORE
+		rq->core_idle_task = NULL;
 		rq->core = NULL;
 		rq->core_pick = NULL;
 		rq->core_enabled = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e91c188a452c..c3ae0af55b05 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -965,6 +965,7 @@ struct rq {
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
 	bool			core_forceidle;
+	struct task_struct	*core_idle_task;
 
 	/* shared state */
 	unsigned int		core_task_seq;
-- 
2.17.1

From: vpillai <vpillai@digitalocean.com>
Date: Wed, 4 Sep 2019 18:22:55 +0000
Subject: [RFC PATCH 2/2] Use coresched_idle to force idle a sibling

Currently we use idle thread to force idle on a sibling. Lets
use the new coresched_idle thread that scheduler sees a valid
task during force idle.
---
 kernel/sched/core.c | 66 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe560739c247..e35d69a81adb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -244,23 +244,33 @@ static int __sched_core_stopper(void *data)
 static DEFINE_MUTEX(sched_core_mutex);
 static int sched_core_count;
 
+static void coresched_idle_worker_init(struct rq *rq);
+static void coresched_idle_worker_fini(struct rq *rq);
 static void __sched_core_enable(void)
 {
+	int cpu;
+
 	// XXX verify there are no cookie tasks (yet)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
 
+	for_each_online_cpu(cpu)
+		coresched_idle_worker_init(cpu_rq(cpu));
 	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
 {
+	int cpu;
+
 	// XXX verify there are no cookie tasks (left)
 
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 
+	for_each_online_cpu(cpu)
+		coresched_idle_worker_fini(cpu_rq(cpu));
 	printk("core sched disabled\n");
 }
 
@@ -3626,14 +3636,25 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 #ifdef CONFIG_SCHED_CORE
 
+static inline bool is_force_idle_task(struct task_struct *p)
+{
+	BUG_ON(task_rq(p)->core_idle_task == NULL);
+	return task_rq(p)->core_idle_task == p;
+}
+
+static inline bool is_core_idle_task(struct task_struct *p)
+{
+	return is_idle_task(p) || is_force_idle_task(p);
+}
+
 static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
 {
-	return is_idle_task(a) || (a->core_cookie == cookie);
+	return is_core_idle_task(a) || (a->core_cookie == cookie);
 }
 
 static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 {
-	if (is_idle_task(a) || is_idle_task(b))
+	if (is_core_idle_task(a) || is_core_idle_task(b))
 		return true;
 
 	return a->core_cookie == b->core_cookie;
@@ -3641,8 +3662,6 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 
 static int coresched_idle_worker(void *data)
 {
-	struct rq *rq = (struct rq *)data;
-
 	/*
 	 * Transition to parked state and dequeue from runqueue.
 	 * pick_task() will select us if needed without enqueueing.
@@ -3666,7 +3685,7 @@ static void coresched_idle_worker_init(struct rq *rq)
 	// XXX core_idle_task needs lock protection?
 	if (!rq->core_idle_task) {
 		rq->core_idle_task = kthread_create_on_cpu(coresched_idle_worker,
-				(void *)rq, cpu_of(rq), "coresched_idle");
+				NULL, cpu_of(rq), "coresched_idle");
 		if (rq->core_idle_task) {
 			wake_up_process(rq->core_idle_task);
 		}
@@ -3684,6 +3703,14 @@ static void coresched_idle_worker_fini(struct rq *rq)
 	}
 }
 
+static inline struct task_struct *core_idle_task(struct rq *rq)
+{
+	BUG_ON(rq->core_idle_task == NULL);
+
+	return rq->core_idle_task;
+
+}
+
 // XXX fairness/fwd progress conditions
 /*
  * Returns
@@ -3709,7 +3736,7 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		 */
 		if (max && class_pick->core_cookie &&
 		    prio_less(class_pick, max))
-			return idle_sched_class.pick_task(rq);
+			return core_idle_task(rq);
 
 		return class_pick;
 	}
@@ -3853,7 +3880,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				goto done;
 			}
 
-			if (!is_idle_task(p))
+			if (!is_force_idle_task(p))
 				occ++;
 
 			rq_i->core_pick = p;
@@ -3906,7 +3933,6 @@ next_class:;
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
 	rq->core_sched_seq = rq->core->core_pick_seq;
-	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 	/*
 	 * Reschedule siblings
@@ -3924,13 +3950,24 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
-		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+		if (is_core_idle_task(rq_i->core_pick) && rq_i->nr_running) {
+			/*
+			 * Matching logic can sometimes select idle_task when
+			 * iterating the sched_classes. If that selection is
+			 * actually a forced idle case, we need to update the
+			 * core_pick to coresched_idle.
+			 */
+			if (is_idle_task(rq_i->core_pick))
+				rq_i->core_pick = core_idle_task(rq_i);
 			rq_i->core_forceidle = true;
+		}
 
 		rq_i->core_pick->core_occupation = occ;
 
-		if (i == cpu)
+		if (i == cpu) {
+			next = rq_i->core_pick;
 			continue;
+		}
 
 		if (rq_i->curr != rq_i->core_pick) {
 			trace_printk("IPI(%d)\n", i);
@@ -3947,6 +3984,7 @@ next_class:;
 			WARN_ON_ONCE(1);
 		}
 	}
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 done:
 	set_next_task(rq, next);
@@ -4200,6 +4238,12 @@ static void __sched notrace __schedule(bool preempt)
 		 *   is a RELEASE barrier),
 		 */
 		++*switch_count;
+#ifdef CONFIG_SCHED_CORE
+		if (next == rq->core_idle_task)
+			next->state = TASK_RUNNING;
+		else if (prev == rq->core_idle_task)
+			prev->state = TASK_PARKED;
+#endif
 
 		trace_sched_switch(preempt, prev, next);
 
@@ -6479,6 +6523,7 @@ int sched_cpu_activate(unsigned int cpu)
 #ifdef CONFIG_SCHED_CORE
 		if (static_branch_unlikely(&__sched_core_enabled)) {
 			rq->core_enabled = true;
+			coresched_idle_worker_init(rq);
 		}
 #endif
 	}
@@ -6535,6 +6580,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		struct rq *rq = cpu_rq(cpu);
 		if (static_branch_unlikely(&__sched_core_enabled)) {
 			rq->core_enabled = false;
+			coresched_idle_worker_fini(rq);
 		}
 #endif
 		static_branch_dec_cpuslocked(&sched_smt_present);
-- 
2.17.1

