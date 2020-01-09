Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC63EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8256B20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yBtdOkoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgAIQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:16:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33906 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbgAIQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:16:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so6323078qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mdnXo1n7IOmKvSMvLVmKwYwOTOjfHeuYWw62rImsh4=;
        b=yBtdOkoGuWHdJ6VRkhBqtIwxUYgWnzZ8CdrtPux30kjxNQw6kWpgTDmlZxtTKHzLVr
         KPPgq1tnnFA+icose7b4H6vmFF0eBR5mpz8xZAcmQa1488glIdxgm0e2reZ+xsUT74c8
         6gVWrvNq3yvw0qaV23Ddxpz45WBtPU0FYw9uXZ98x2d6udvVhzdSv6hWqC4GMf9NHJEk
         GisxMmn6umthcfkIESYgl1MfP0/Nhb+RWXWKeUxKQaA050UZM7DwjmVrbJ3fkxIu3u/U
         t0J1lZYh8ay/3/pV4il/4QBXJBalpAvZ6EVOrpj7Z2eJx7N6n6vvQBBHEMHOn1/+/TMg
         QStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mdnXo1n7IOmKvSMvLVmKwYwOTOjfHeuYWw62rImsh4=;
        b=MrtI8MYhlB/TwrRRyBRuXx4wt0LwjVGgwGtjvnNd+XEKpX6pOf7t2a9AMiXgogahaT
         TPeOK+2NKXbKcOTgfiBHFW1gQOFFxBOwaB3HhQTXPnk0NCussEyRYKJjLtvhZGQr11VU
         QIesZWzJ8WD0Xhu/EwnTyNpU0eHRW0VkYkUQZR8FnseXxzOG7kG3obsNGJcqJuYbePIf
         WF/p4gh/s7jjyllcAeYsxcUmqyG5ytWuoJUARRuYa4IZJNgPwXD4ozOvsBiFecY0G1n2
         UMgS4k6ZglcYp8XCEi6gglKjdX8KPRVDFD+Vn8ik3nDIFXUo6z5f2ndNrjZavMUCuPaF
         2tDw==
X-Gm-Message-State: APjAAAUwh6vkXIpksvSTgv1sgwKbCkPumrlkXjW0kFfkxzev6u3m7zcT
        6ifPpy/NzYeWa9+89Bi5NMx7qvpw5eg=
X-Google-Smtp-Source: APXvYqzamhQ3IBX9bwl3A2rD9M7uy9SeUHt4DBOuS2kUHUxQIy1cZSVAgPrmOeUs50phYpKMfD6SPA==
X-Received: by 2002:aed:3e83:: with SMTP id n3mr8577049qtf.322.1578586594308;
        Thu, 09 Jan 2020 08:16:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:d72d])
        by smtp.gmail.com with ESMTPSA id o16sm3085757qkj.91.2020.01.09.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:16:33 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:16:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: Lower than expected CPU pressure in PSI
Message-ID: <20200109161632.GB8547@cmpxchg.org>
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:47:10AM -0800, Ivan Babrou wrote:
> We added reporting for PSI in cgroups and results are somewhat surprising.
> 
> My test setup consists of 3 services:
> 
> * stress-cpu1-no-contention.service : taskset -c 1 stress --cpu 1
> * stress-cpu2-first-half.service    : taskset -c 2 stress --cpu 1
> * stress-cpu2-second-half.service   : taskset -c 2 stress --cpu 1
> 
> First service runs unconstrained, the other two compete for CPU.
> 
> As expected, I can see 500ms/s sched delay for the latter two and
> aggregated 1000ms/s delay for /system.slice, no surprises here.
> 
> However, CPU pressure reported by PSI says that none of my services
> have any pressure on them. I can see around 434ms/s pressure on
> /unified/system.slice and 425ms/s pressure on /unified cgroup, which
> is surprising for three reasons:
> 
> * Pressure is absent for my services (I expect it to match scheed delay)
> * Pressure on /unified/system.slice is lower than both 500ms/s and 1000ms/s
> * Pressure on root cgroup is lower than on system.slice

CPU pressure is currently implemented based only on the number of
*runnable* tasks, not on who gets to actively use the CPU. This works
for contention within cgroups or at the global scope, but it doesn't
correctly reflect competition between cgroups. It also doesn't show
the effects of e.g. cpu cycle limiting through cpu.max where there
might *be* only one runnable task, but it's not getting the CPU.

I've been working on fixing this, but hadn't gotten around to sending
the patch upstream. Attaching it below. Would you mind testing it?

Peter, what would you think of the below?

---
From 98c233aae05b7d43e465d4c382a3a20905235296 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 14 Nov 2019 15:53:45 -0500
Subject: [PATCH] psi: fix cpu.pressure for cpu.max and competing cgroups

For simplicity, cpu pressure is defined as having more than one
runnable task on a given CPU. This works on the system-level, but it
has limitations in a cgrouped reality: When cpu.max is in use, it
doesn't capture the time in which a task is not executing on the CPU
due to throttling. Likewise, it doesn't capture the time in which a
competing cgroup is occupying the CPU - meaning it only reflects
cgroup-internal competitive pressure, not outside pressure.

Enable tracking of currently executing tasks, and then change the
definition of cpu pressure in a cgroup from

	NR_RUNNING > 1

to

	NR_RUNNING > ON_CPU

which will capture the effects of cpu.max as well as competition from
outside the cgroup.

After this patch, a cgroup running `stress -c 1` with a cpu.max
setting of 5000 10000 shows ~50% continuous CPU pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi_types.h | 10 +++++++++-
 kernel/sched/core.c       |  2 ++
 kernel/sched/psi.c        | 12 +++++++-----
 kernel/sched/stats.h      | 28 ++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b82241..4b7258495a04 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -14,13 +14,21 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	NR_PSI_TASK_COUNTS = 3,
+	/*
+	 * This can't have values other than 0 or 1 and could be
+	 * implemented as a bit flag. But for now we still have room
+	 * in the first cacheline of psi_group_cpu, and this way we
+	 * don't have to special case any state tracking for it.
+	 */
+	NR_ONCPU,
+	NR_PSI_TASK_COUNTS = 4,
 };
 
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
+#define TSK_ONCPU	(1 << NR_ONCPU)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4d14e8..9296e0de7b72 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4072,6 +4072,8 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+
 		trace_sched_switch(preempt, prev, next);
 
 		/* Also unlocks the rq: */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e3719027e..fad91da54aab 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -224,7 +224,7 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_FULL:
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > 1;
+		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -694,10 +694,10 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 		if (!(m & (1 << t)))
 			continue;
 		if (groupc->tasks[t] == 0 && !psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					clear, set);
+					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
 		groupc->tasks[t]--;
@@ -915,9 +915,11 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task))
+	if (task_on_rq_queued(task)) {
 		task_flags = TSK_RUNNING;
-	else if (task->in_iowait)
+		if (task_current(rq, task))
+			task_flags |= TSK_ONCPU;
+	} else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
 	if (task->flags & PF_MEMSTALL)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ba683fe81a6e..6ff0ac1a803f 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -93,6 +93,14 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		if (p->flags & PF_MEMSTALL)
 			clear |= TSK_MEMSTALL;
 	} else {
+		/*
+		 * When a task sleeps, schedule() dequeues it before
+		 * switching to the next one. Merge the clearing of
+		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
+		 * psi_task_change() call in psi_sched_switch().
+		 */
+		clear |= TSK_ONCPU;
+
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
 	}
@@ -126,6 +134,23 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	}
 }
 
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	/*
+	 * Clear the TSK_ONCPU state if the task was preempted. If
+	 * it's a voluntary sleep, dequeue will have taken care of it.
+	 */
+	if (!sleep)
+		psi_task_change(prev, TSK_ONCPU, 0);
+
+	psi_task_change(next, 0, TSK_ONCPU);
+}
+
 static inline void psi_task_tick(struct rq *rq)
 {
 	if (static_branch_likely(&psi_disabled))
@@ -138,6 +163,9 @@ static inline void psi_task_tick(struct rq *rq)
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep) {}
 static inline void psi_task_tick(struct rq *rq) {}
 #endif /* CONFIG_PSI */
 
-- 
2.24.1
