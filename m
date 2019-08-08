Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF40D2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbfHHVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:43:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:21944 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733295AbfHHVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 14:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="203725004"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2019 14:42:58 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
 <20190806171241.GQ2349@hirez.programming.kicks-ass.net>
 <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
 <20190808064731.GA5121@aaronlu>
 <70d1ff90-9be9-7b05-f1ff-e751f266183b@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com>
Date:   Thu, 8 Aug 2019 14:42:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <70d1ff90-9be9-7b05-f1ff-e751f266183b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 10:27 AM, Tim Chen wrote:
> On 8/7/19 11:47 PM, Aaron Lu wrote:
>> On Tue, Aug 06, 2019 at 02:19:57PM -0700, Tim Chen wrote:
>>> +void account_core_idletime(struct task_struct *p, u64 exec)
>>> +{
>>> +	const struct cpumask *smt_mask;
>>> +	struct rq *rq;
>>> +	bool force_idle, refill;
>>> +	int i, cpu;
>>> +
>>> +	rq = task_rq(p);
>>> +	if (!sched_core_enabled(rq) || !p->core_cookie)
>>> +		return;
>>
>> I don't see why return here for untagged task. Untagged task can also
>> preempt tagged task and force a CPU thread enter idle state.
>> Untagged is just another tag to me, unless we want to allow untagged
>> task to coschedule with a tagged task.
> 
> You are right.  This needs to be fixed.
> 

Here's the updated patchset, including Aaron's fix and also
added accounting of force idle time by deadline and rt tasks.

Tim

-----------------patch 1----------------------
From 730dbb125f5f67c75f97f6be154d382767810f8b Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@linux.alibaba.com>
Date: Thu, 8 Aug 2019 08:57:46 -0700
Subject: [PATCH 1/3 v2] sched: Fix incorrect rq tagged as forced idle

Incorrect run queue was tagged as forced idle.
Tag the correct one.

Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e3cd9cb17809..50453e1329f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3903,7 +3903,7 @@ next_class:;
 		WARN_ON_ONCE(!rq_i->core_pick);
 
 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
-			rq->core_forceidle = true;
+			rq_i->core_forceidle = true;
 
 		rq_i->core_pick->core_occupation = occ;
 
-- 
2.20.1

--------------patch 2------------------------
From 263ceeb40843b8ca3a91f1b268bec2b836d4986b Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 24 Jul 2019 13:58:18 -0700
Subject: [PATCH 2/3 v2] sched: Move sched fair prio comparison to fair.c

Consolidate the task priority comparison of the fair class
to fair.c.  A simple code reorganization and there are no functional changes.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 21 ++-------------------
 kernel/sched/fair.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50453e1329f3..0f893853766c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -105,25 +105,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 a_vruntime = a->se.vruntime;
-		u64 b_vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			b_vruntime -= task_cfs_rq(b)->min_vruntime;
-			b_vruntime += task_cfs_rq(a)->min_vruntime;
-
-			trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
-				     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
-				     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
-
-		}
-
-		return !((s64)(a_vruntime - b_vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return prio_less_fair(a, b);
 
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02bff10237d4..e289b6e1545b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -602,6 +602,27 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 	return delta;
 }
 
+bool prio_less_fair(struct task_struct *a, struct task_struct *b)
+{
+	u64 a_vruntime = a->se.vruntime;
+	u64 b_vruntime = b->se.vruntime;
+
+	/*
+	 * Normalize the vruntime if tasks are in different cpus.
+	 */
+	if (task_cpu(a) != task_cpu(b)) {
+		b_vruntime -= task_cfs_rq(b)->min_vruntime;
+		b_vruntime += task_cfs_rq(a)->min_vruntime;
+
+		trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
+			     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
+			     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
+
+	}
+
+	return !((s64)(a_vruntime - b_vruntime) <= 0);
+}
+
 /*
  * The idea is to set a period in which each task runs once.
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e91c188a452c..bdabe7ce1152 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1015,6 +1015,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 }
 
 extern void queue_core_balance(struct rq *rq);
+extern bool prio_less_fair(struct task_struct *a, struct task_struct *b);
 
 #else /* !CONFIG_SCHED_CORE */
 
-- 
2.20.1

------------------------patch 3---------------------------
From 5318e23c741a832140effbaf2f79fdf4b08f883c Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 6 Aug 2019 12:50:45 -0700
Subject: [PATCH 3/3 v2] sched: Enforce fairness between cpu threads

CPU thread could be suppressed by its sibling for extended time.
Implement a budget for force idling, making all CPU threads have
equal chance to run.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c     | 43 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c |  1 +
 kernel/sched/fair.c     | 11 +++++++++++
 kernel/sched/rt.c       |  1 +
 kernel/sched/sched.h    |  4 ++++
 5 files changed, 60 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f893853766c..de83dcb84495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -207,6 +207,46 @@ static struct task_struct *sched_core_next(struct task_struct *p, unsigned long
 	return p;
 }
 
+void account_core_idletime(struct task_struct *p, u64 exec)
+{
+	const struct cpumask *smt_mask;
+	struct rq *rq;
+	bool force_idle, refill;
+	int i, cpu;
+
+	rq = task_rq(p);
+	if (!sched_core_enabled(rq))
+		return;
+
+	cpu = task_cpu(p);
+	force_idle = false;
+	refill = true;
+	smt_mask = cpu_smt_mask(cpu);
+
+	for_each_cpu(i, smt_mask) {
+		if (cpu == i || cpu_is_offline(i))
+			continue;
+
+		if (cpu_rq(i)->core_forceidle)
+			force_idle = true;
+
+		/* Only refill if everyone has run out of allowance */
+		if (cpu_rq(i)->core_idle_allowance > 0)
+			refill = false;
+	}
+
+	if (force_idle)
+		rq->core_idle_allowance -= (s64) exec;
+
+	if (rq->core_idle_allowance < 0 && refill) {
+		for_each_cpu(i, smt_mask) {
+			if (cpu_is_offline(i))
+				continue;
+			cpu_rq(i)->core_idle_allowance += (s64) SCHED_IDLE_ALLOWANCE;
+		}
+	}
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -273,6 +313,8 @@ void sched_core_put(void)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static inline void account_core_idletime(struct task_struct *p, u64 exec) { }
+{
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -6773,6 +6815,7 @@ void __init sched_init(void)
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
+		rq->core_idle_allowance = (s64) SCHED_IDLE_ALLOWANCE;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 64fc444f44f9..684c64a95ec7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1175,6 +1175,7 @@ static void update_curr_dl(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	account_core_idletime(curr, delta_exec);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e289b6e1545b..f65270784c28 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -611,6 +611,16 @@ bool prio_less_fair(struct task_struct *a, struct task_struct *b)
 	 * Normalize the vruntime if tasks are in different cpus.
 	 */
 	if (task_cpu(a) != task_cpu(b)) {
+
+		if (a->core_cookie != b->core_cookie) {
+			/*
+			 * Will be force idling one thread,
+			 * pick the thread that has more allowance.
+			 */
+			return (task_rq(a)->core_idle_allowance <
+				task_rq(b)->core_idle_allowance) ? true : false;
+		}
+
 		b_vruntime -= task_cfs_rq(b)->min_vruntime;
 		b_vruntime += task_cfs_rq(a)->min_vruntime;
 
@@ -817,6 +827,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
+		account_core_idletime(curtask, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 81557224548c..6f18e1455778 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -971,6 +971,7 @@ static void update_curr_rt(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	account_core_idletime(curr, delta_exec);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bdabe7ce1152..927334b2078c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -963,6 +963,7 @@ struct rq {
 	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
+	s64			core_idle_allowance;
 	struct rb_root		core_tree;
 	bool			core_forceidle;
 
@@ -999,6 +1000,8 @@ static inline int cpu_of(struct rq *rq)
 }
 
 #ifdef CONFIG_SCHED_CORE
+#define SCHED_IDLE_ALLOWANCE	5000000 	/* 5 msec */
+
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1016,6 +1019,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 extern void queue_core_balance(struct rq *rq);
 extern bool prio_less_fair(struct task_struct *a, struct task_struct *b);
+extern void  account_core_idletime(struct task_struct *p, u64 exec);
 
 #else /* !CONFIG_SCHED_CORE */
 
-- 
2.20.1

