Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A270CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E62120684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="WEx1hidF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfFFP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:26:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44219 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbfFFP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:26:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so1671767qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7IPeRG+XRH2ia6q2FaZ0+0nEBCt2oXJyyHCFUpk0wYA=;
        b=WEx1hidFm1qwEHyuxngLYoJZ+Y5p+ZlwoQBCUqQ8ulFW6uIj3mTnFkHiOO+ZCE5N61
         GhUcqJPHpwVVV5Unadw2n36NCegtBzOaGm1tc1or/fhdB2wc3bJtDnG2W0JYZj3awzFD
         8ju6VjanD1VfQnfLPehzeTbyTtZqS01JExW98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7IPeRG+XRH2ia6q2FaZ0+0nEBCt2oXJyyHCFUpk0wYA=;
        b=oKktuY1VSr5xjZ02A6sr7sQdU54698oehriekNYyj/YQZvn9AiIDmncRF53LzFyjow
         hqYSSTtj4yo95tJZSLquH8b205ShuP428VXC1eGMXMmrP7TvQY+Aig1cGHU/FEZP7PTW
         3V8BuazGkFrV2Qd3m+lNXiZndgYZ8cjhmIFJwpMrRXTSOFeude2H2CD/EjB8PAWi9dCG
         Gf/FaPknFVPQp6eSZNpCVXmUMJnyJXAwrTZVWvO8vliaww2VSau90kWFAbV+c5iSyzBh
         9NjZPCExnJ2/PLvfZb+6hK8upbs9T8KT1AnoDZS2IihnrudxDOQCN4iefrK5iB3JN92i
         um0w==
X-Gm-Message-State: APjAAAVB+E5Hn7xZfHeADFHA49zF2Ja4ZkyRTN9M3NPD7DpxLieF+nPw
        eyvQpfnB7ht7dt4RhudXo3zyGA==
X-Google-Smtp-Source: APXvYqzyePlqJ2Iu0FnmME3n9lINkPRUyBrYIR+hvHrRLMQDa1WupuW4KF0tBTjwA730hT/h5mLx0Q==
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr29816790qki.302.1559834808895;
        Thu, 06 Jun 2019 08:26:48 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id j26sm1325248qtj.70.2019.06.06.08.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 08:26:47 -0700 (PDT)
Date:   Thu, 6 Jun 2019 11:26:37 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190606152637.GA5703@sinkpad>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531210816.GA24027@sinkpad>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-May-2019 05:08:16 PM, Julien Desfossez wrote:
> > My first reaction is: when shell wakes up from sleep, it will
> > fork date. If the script is untagged and those workloads are
> > tagged and all available cores are already running workload
> > threads, the forked date can lose to the running workload
> > threads due to __prio_less() can't properly do vruntime comparison
> > for tasks on different CPUs. So those idle siblings can't run
> > date and are idled instead. See my previous post on this:
> > 
> > https://lore.kernel.org/lkml/20190429033620.GA128241@aaronlu/
> > (Now that I re-read my post, I see that I didn't make it clear
> > that se_bash and se_hog are assigned different tags(e.g. hog is
> > tagged and bash is untagged).
> > 
> > Siblings being forced idle is expected due to the nature of core
> > scheduling, but when two tasks belonging to two siblings are
> > fighting for schedule, we should let the higher priority one win.
> > 
> > It used to work on v2 is probably due to we mistakenly
> > allow different tagged tasks to schedule on the same core at
> > the same time, but that is fixed in v3.
> 
> I confirm this is indeed what is happening, we reproduced it with a
> simple script that only uses one core (cpu 2 and 38 are sibling on this
> machine):
> 
> setup:
> cgcreate -g cpu,cpuset:test
> cgcreate -g cpu,cpuset:test/set1
> cgcreate -g cpu,cpuset:test/set2
> echo 2,38 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
> echo 2,38 > /sys/fs/cgroup/cpuset/test/set1/cpuset.cpus
> echo 2,38 > /sys/fs/cgroup/cpuset/test/set2/cpuset.cpus
> echo 0 > /sys/fs/cgroup/cpuset/test/set1/cpuset.mems
> echo 0 > /sys/fs/cgroup/cpuset/test/set2/cpuset.mems
> echo 1 > /sys/fs/cgroup/cpu,cpuacct/test/set1/cpu.tag
> 
> In one terminal:
> sudo cgexec -g cpu,cpuset:test/set1 sysbench --threads=1 --time=30
> --test=cpu run
> 
> In another one:
> sudo cgexec -g cpu,cpuset:test/set2 date
> 
> It's very clear that 'date' hangs until sysbench is done.
> 
> We started experimenting with marking a task on the forced idle sibling
> if normalized vruntimes are equal. That way, at the next compare, if the
> normalized vruntimes are still equal, it prefers the task on the forced
> idle sibling. It still needs more work, but in our early tests it helps.

As mentioned above, we have come up with a fix for the long starvation
of untagged interactive threads competing for the same core with tagged
threads at the same priority. The idea is to detect the stall and boost
the stalling threads priority so that it gets a chance next time.
Boosting is done by a new counter(min_vruntime_boost) for every task
which we subtract from vruntime before comparison. The new logic looks
like this:

If we see that normalized runtimes are equal, we check the min_vruntimes
of their runqueues and give a chance for the task in the runqueue with
less min_vruntime. That will help it to progress its vruntime. While
doing this, we boost the priority of the task in the sibling so that, we
don’t starve the task in the sibling until the min_vruntime of this
runqueue catches up.

If min_vruntimes are also equal, we do as before and consider the task
‘a’ of higher priority. Here we boost the task ‘b’ so that it gets to
run next time.

The min_vruntime_boost is reset to zero once the task in on cpu. So only
waiting tasks will have a non-zero value if it is starved while matching
a task on the other sibling.

The attached patch has a sched_feature to enable the above feature so
that you can compare the results with and without this feature.

What we observe with this patch is that it helps for untagged
interactive tasks and fairness in general, but this increases the
overhead of core scheduling when there is contention for the CPU with
tasks of varying cpu usage. The general trend we see is that if there is
a cpu intensive thread and multiple relatively idle threads in different
tags, the cpu intensive tasks continuously yields to be fair to the
relatively idle threads when it becomes runnable. And if the relatively
idle threads make up for most of the tasks in a system and are tagged,
the cpu intensive tasks sees a considerable drop in performance.

If you have any feedback or creative ideas to help improve, let us
know !

Thanks


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1a309e8..56cad0e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -642,6 +642,7 @@ struct task_struct {
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
 	unsigned int			core_occupation;
+	unsigned int			core_vruntime_boost;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 73329da..c302853 100644
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
 
@@ -102,21 +106,36 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
-		     a->comm, a->pid, pa, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
-		     b->comm, b->pid, pb, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
+		u64 a_vruntime = a->se.vruntime - a->core_vruntime_boost;
+		u64 b_vruntime = b->se.vruntime - b->core_vruntime_boost;
 
 		/*
 		 * Normalize the vruntime if tasks are in different cpus.
 		 */
 		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
+			s64 min_vruntime_diff = task_cfs_rq(a)->min_vruntime -
+						 task_cfs_rq(b)->min_vruntime;
+			b_vruntime += min_vruntime_diff;
+
+			trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
+				     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
+				     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
+
+			if (sched_feat(CORESCHED_STALL_FIX) &&
+			    a_vruntime == b_vruntime) {
+				bool less_prio = min_vruntime_diff > 0;
+
+				if (less_prio)
+					a->core_vruntime_boost++;
+				else
+					b->core_vruntime_boost++;
+
+				return less_prio;
+
+			}
 		}
 
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
+		return !((s64)(a_vruntime - b_vruntime) <= 0);
 	}
 
 	return false;
@@ -2456,6 +2475,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_COMPACTION
 	p->capture_control = NULL;
 #endif
+#ifdef CONFIG_SCHED_CORE
+	p->core_vruntime_boost = 0UL;
+#endif
 	init_numa_balancing(clone_flags, p);
 }
 
@@ -3723,6 +3745,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			     next->comm, next->pid,
 			     next->core_cookie);
 
+		next->core_vruntime_boost = 0UL;
 		return next;
 	}
 
@@ -3835,6 +3858,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
 
 				if (old_max) {
+					if (old_max->core_vruntime_boost)
+						old_max->core_vruntime_boost--;
+
 					for_each_cpu(j, smt_mask) {
 						if (j == i)
 							continue;
@@ -3905,6 +3931,7 @@ next_class:;
 
 done:
 	set_next_task(rq, next);
+	next->core_vruntime_boost = 0UL;
 	return next;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 858589b..332a092 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,9 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+
+/*
+ * Prevent task stall due to vruntime comparison limitation across
+ * cpus.
+ */
+SCHED_FEAT(CORESCHED_STALL_FIX, false)
