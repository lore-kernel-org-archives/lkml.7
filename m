Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F8E218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dSGGAH/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGYQRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:17:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGYQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:17:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGGlV01075230
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:16:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGGlV01075230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071408;
        bh=K8/4EXYTAOYg1KI3nUvy13jLc8kfpfL9vnkfzswdXtg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dSGGAH/AXGqjsOgeFbopiLDiufe4vr3ZDHIi3Qglnsu3i2ujfGXZA7MM/0DMZOfSa
         aN8bEhHWeTWrDohPUHQxhQt841czY7xr6O5QY+DwGemqo2X/L81xtXZP2YO6RVjS4b
         bsI6ct3BG1FtJONXh+bOImPTmGav36pOiqL6NZEPWcEwgXJIdAMFrD1g6EfaJ4KPk4
         8bPvqj/o5eORkNiEIg9GhwEqqirRzZc3ng0NXOl0/fL1i/uhMWeas1S8vNLYygjtld
         3nTj3mdj/jcG42xYkWHI5sIIS11YqOvCvLk6/0lbWrWN+UHPELRr4aSxUcLwAYqkpb
         lEy/UsVyJpbDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGGlna1075227;
        Thu, 25 Jul 2019 09:16:47 -0700
Date:   Thu, 25 Jul 2019 09:16:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Matthew Wilcox (Oracle)" <tipbot@zytor.com>
Message-ID: <tip-7b3c92b85a65c2db1f542265bc98e1f9e3056eba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, willy@infradead.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, willy@infradead.org
In-Reply-To: <20190704221323.24290-1-willy@infradead.org>
References: <20190704221323.24290-1-willy@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Convert get_task_struct() to return
 the task
Git-Commit-ID: 7b3c92b85a65c2db1f542265bc98e1f9e3056eba
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7b3c92b85a65c2db1f542265bc98e1f9e3056eba
Gitweb:     https://git.kernel.org/tip/7b3c92b85a65c2db1f542265bc98e1f9e3056eba
Author:     Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate: Thu, 4 Jul 2019 15:13:23 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:54 +0200

sched/core: Convert get_task_struct() to return the task

Returning the pointer that was passed in allows us to write
slightly more idiomatic code.  Convert a few users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190704221323.24290-1-willy@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/task.h        | 6 +++++-
 kernel/events/core.c              | 9 +++------
 kernel/irq/manage.c               | 3 +--
 kernel/locking/rtmutex.c          | 6 ++----
 kernel/trace/trace_sched_wakeup.c | 3 +--
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0497091e40c1..3d90ed8f75f0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -105,7 +105,11 @@ extern void sched_exec(void);
 #define sched_exec()   {}
 #endif
 
-#define get_task_struct(tsk) do { refcount_inc(&(tsk)->usage); } while(0)
+static inline struct task_struct *get_task_struct(struct task_struct *t)
+{
+	refcount_inc(&t->usage);
+	return t;
+}
 
 extern void __put_task_struct(struct task_struct *t);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..ea5e8139fe62 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4089,10 +4089,8 @@ alloc_perf_context(struct pmu *pmu, struct task_struct *task)
 		return NULL;
 
 	__perf_event_init_context(ctx);
-	if (task) {
-		ctx->task = task;
-		get_task_struct(task);
-	}
+	if (task)
+		ctx->task = get_task_struct(task);
 	ctx->pmu = pmu;
 
 	return ctx;
@@ -10355,8 +10353,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * and we cannot use the ctx information because we need the
 		 * pmu before we get a ctx.
 		 */
-		get_task_struct(task);
-		event->hw.target = task;
+		event->hw.target = get_task_struct(task);
 	}
 
 	event->clock = &local_clock;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f179bf77..9d50fbe5531a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1255,8 +1255,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	 * the thread dies to avoid that the interrupt code
 	 * references an already freed task_struct.
 	 */
-	get_task_struct(t);
-	new->thread = t;
+	new->thread = get_task_struct(t);
 	/*
 	 * Tell the thread to set its affinity. This is
 	 * important for shared interrupt handlers as we do
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index fa83d36e30c6..2874bf556162 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -628,8 +628,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		}
 
 		/* [10] Grab the next task, i.e. owner of @lock */
-		task = rt_mutex_owner(lock);
-		get_task_struct(task);
+		task = get_task_struct(rt_mutex_owner(lock));
 		raw_spin_lock(&task->pi_lock);
 
 		/*
@@ -709,8 +708,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	}
 
 	/* [10] Grab the next task, i.e. the owner of @lock */
-	task = rt_mutex_owner(lock);
-	get_task_struct(task);
+	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
 	/* [11] requeue the pi waiters if necessary */
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 743b2b520d34..5e43b9664eca 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -579,8 +579,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	else
 		tracing_dl = 0;
 
-	wakeup_task = p;
-	get_task_struct(wakeup_task);
+	wakeup_task = get_task_struct(p);
 
 	local_save_flags(flags);
 
