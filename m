Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D04C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284A6206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLSPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:21:20 -0500
Received: from relay.sw.ru ([185.231.240.75]:56214 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:21:19 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihxbn-000749-4U; Thu, 19 Dec 2019 18:20:59 +0300
Subject: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <20191219140252.GS2871@hirez.programming.kicks-ass.net>
 <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
 <20191219094330.0e44c748@gandalf.local.home>
 <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
 <20191219095941.2eebed84@gandalf.local.home>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
Date:   Thu, 19 Dec 2019 18:20:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219095941.2eebed84@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

This introduces an optimization based on xxx_sched_class addresses
in two hot scheduler functions: pick_next_task() and check_preempt_curr().

After this patch, it will be possible to compare pointers to sched classes
to check, which of them has a higher priority, instead of current iterations
using for_each_class().

One more result of the patch is that size of object file becomes a little
less (excluding added BUG_ON(), which goes in __init section):

$size kernel/sched/core.o
         text     data      bss	    dec	    hex	filename
before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o

SCHED_DATA improvements guaranteeing order of sched classes are made
by Steven Rostedt <rostedt@goodmis.org>

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

v2: Steven's data sections ordering. Hunk with comment in Makefile is removed.
---
 include/asm-generic/vmlinux.lds.h |    8 ++++++++
 kernel/sched/core.c               |   24 +++++++++---------------
 kernel/sched/deadline.c           |    3 ++-
 kernel/sched/fair.c               |    3 ++-
 kernel/sched/idle.c               |    3 ++-
 kernel/sched/rt.c                 |    3 ++-
 kernel/sched/stop_task.c          |    3 ++-
 7 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..ff12a422ff19 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,6 +108,13 @@
 #define SBSS_MAIN .sbss
 #endif
 
+#define SCHED_DATA				\
+	*(__idle_sched_class)			\
+	*(__fair_sched_class)			\
+	*(__rt_sched_class)			\
+	*(__dl_sched_class)			\
+	*(__stop_sched_class)
+
 /*
  * Align to a 32 byte boundary equal to the
  * alignment gcc 4.5 uses for a struct
@@ -308,6 +315,7 @@
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
+	SCHED_DATA							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	MEM_KEEP(init.data*)						\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15508c202bf5..befdd7158b27 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1416,20 +1416,10 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	const struct sched_class *class;
-
-	if (p->sched_class == rq->curr->sched_class) {
+	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	} else {
-		for_each_class(class) {
-			if (class == rq->curr->sched_class)
-				break;
-			if (class == p->sched_class) {
-				resched_curr(rq);
-				break;
-			}
-		}
-	}
+	else if (p->sched_class > rq->curr->sched_class)
+		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -3914,8 +3904,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * higher scheduling class, because otherwise those loose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
-	if (likely((prev->sched_class == &idle_sched_class ||
-		    prev->sched_class == &fair_sched_class) &&
+	if (likely(prev->sched_class <= &fair_sched_class &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
@@ -6569,6 +6558,11 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
+	BUG_ON(&idle_sched_class > &fair_sched_class ||
+		&fair_sched_class > &rt_sched_class ||
+		&rt_sched_class > &dl_sched_class ||
+		&dl_sched_class > &stop_sched_class);
+
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f875cb9..5abdbe569f93 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2428,7 +2428,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	}
 }
 
-const struct sched_class dl_sched_class = {
+const struct sched_class dl_sched_class
+	__attribute__((section("__dl_sched_class"))) = {
 	.next			= &rt_sched_class,
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da0222924cf..9379b3804582 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10760,7 +10760,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 /*
  * All the scheduling class methods:
  */
-const struct sched_class fair_sched_class = {
+const struct sched_class fair_sched_class
+	__attribute__((section("__fair_sched_class"))) = {
 	.next			= &idle_sched_class,
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ffa959e91227..700a9c826f0e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -454,7 +454,8 @@ static void update_curr_idle(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
-const struct sched_class idle_sched_class = {
+const struct sched_class idle_sched_class
+	__attribute__((section("__idle_sched_class"))) = {
 	/* .next is NULL */
 	/* no enqueue/yield_task for idle tasks */
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e591d40fd645..5d3f9bcddaeb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2354,7 +2354,8 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 		return 0;
 }
 
-const struct sched_class rt_sched_class = {
+const struct sched_class rt_sched_class
+	__attribute__((section("__rt_sched_class"))) = {
 	.next			= &fair_sched_class,
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4c9e9975684f..03bc7530ff75 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -115,7 +115,8 @@ static void update_curr_stop(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
-const struct sched_class stop_sched_class = {
+const struct sched_class stop_sched_class
+	__attribute__((section("__stop_sched_class"))) = {
 	.next			= &dl_sched_class,
 
 	.enqueue_task		= enqueue_task_stop,
