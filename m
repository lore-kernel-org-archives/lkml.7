Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6771C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E5524676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSOne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfLSOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:43:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC52521D7D;
        Thu, 19 Dec 2019 14:43:32 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:43:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Micro optimization in pick_next_task() and
 in check_preempt_curr()
Message-ID: <20191219094330.0e44c748@gandalf.local.home>
In-Reply-To: <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
        <20191219131242.GK2827@hirez.programming.kicks-ass.net>
        <20191219140252.GS2871@hirez.programming.kicks-ass.net>
        <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 17:25:40 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> (17:19:25) nbjoerg: but it is not guarenteed behavior
> (17:19:50) nbjoerg: if for some strange reason you really need to enforce relative orders of global objects, put them in consecutively named sections

Which appears to work. I tried this patch on top of yours:

Not sure how this does with locality though.

-- Steve

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
index 08a233e97a01..e745fe0e0cd3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10745,7 +10745,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
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
