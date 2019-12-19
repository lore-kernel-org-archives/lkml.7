Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E0C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7D624672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLSVqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfLSVqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:46:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D688224685;
        Thu, 19 Dec 2019 21:45:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ii3cM-000UmW-VY; Thu, 19 Dec 2019 16:45:58 -0500
Message-Id: <20191219214558.845353593@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Dec 2019 16:44:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH 3/4] sched: Remove struct sched_class next field
References: <20191219214451.340746474@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that the sched_class descriptors are defined in order via the linker
script vmlinux.lds.h, there's no reason to have a "next" pointer to the
previous priroity structure. The order of the sturctures can be aligned as
an array, and used to index and find the next sched_class descriptor.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 kernel/sched/deadline.c           | 1 -
 kernel/sched/fair.c               | 1 -
 kernel/sched/idle.c               | 1 -
 kernel/sched/rt.c                 | 1 -
 kernel/sched/sched.h              | 6 +++---
 kernel/sched/stop_task.c          | 1 -
 7 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1c14c4ddf785..f4d480c4f7c6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -128,6 +128,7 @@
  */
 #define SCHED_DATA				\
 	STRUCT_ALIGN();				\
+	__start_sched_classes = .;		\
 	*(__idle_sched_class)			\
 	*(__fair_sched_class)			\
 	*(__rt_sched_class)			\
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5abdbe569f93..9c232214fe63 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2430,7 +2430,6 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 
 const struct sched_class dl_sched_class
 	__attribute__((section("__dl_sched_class"))) = {
-	.next			= &rt_sched_class,
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e745fe0e0cd3..52f2a7b06d9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10747,7 +10747,6 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
  */
 const struct sched_class fair_sched_class
 	__attribute__((section("__fair_sched_class"))) = {
-	.next			= &idle_sched_class,
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 700a9c826f0e..f0871a9b8c98 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -456,7 +456,6 @@ static void update_curr_idle(struct rq *rq)
  */
 const struct sched_class idle_sched_class
 	__attribute__((section("__idle_sched_class"))) = {
-	/* .next is NULL */
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5d3f9bcddaeb..d6b330b72c60 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2356,7 +2356,6 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 
 const struct sched_class rt_sched_class
 	__attribute__((section("__rt_sched_class"))) = {
-	.next			= &fair_sched_class,
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0554c588ad85..30a4615cf480 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1700,7 +1700,6 @@ extern const u32		sched_prio_to_wmult[40];
 #define RETRY_TASK		((void *)-1UL)
 
 struct sched_class {
-	const struct sched_class *next;
 
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
@@ -1773,12 +1772,13 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 
 /* Defined in include/asm-generic/vmlinux.lds.h */
 extern struct sched_class sched_class_highest;
+extern struct sched_class __start_sched_classes;
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class = class->next)
+	for (class = (_from); class > (_to); class--)
 
 #define for_each_class(class) \
-	for_class_range(class, &sched_class_highest, NULL)
+	for_class_range(class, &sched_class_highest, (&__start_sched_classes) - 1)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 03bc7530ff75..0f88eec8d4da 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -117,7 +117,6 @@ static void update_curr_stop(struct rq *rq)
  */
 const struct sched_class stop_sched_class
 	__attribute__((section("__stop_sched_class"))) = {
-	.next			= &dl_sched_class,
 
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
-- 
2.24.0


