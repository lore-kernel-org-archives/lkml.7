Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F4A206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSMju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:39:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:50550 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSMjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:39:49 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihv5G-0005qc-Ro; Thu, 19 Dec 2019 15:39:14 +0300
Subject: [PATCH RFC] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ktkhai@virtuozzo.com
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 19 Dec 2019 15:39:14 +0300
Message-ID: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/sched/Makefile files, describing different sched classes, already
go in the order from the lowest priority class to the highest priority class:

idle.o fair.o rt.o deadline.o stop_task.o

The documentation of GNU linker says, that section appears in the order
they are seen during link time (see [1]):

>Normally, the linker will place files and sections matched by wildcards
>in the order in which they are seen during the link. You can change this
>by using the SORT keyword, which appears before a wildcard pattern
>in parentheses (e.g., SORT(.text*)).

So, we may expect const variables from idle.o will go before ro variables
from fair.o in RO_DATA section, while ro variables from fair.o will go
before ro variables from rt.o, etc.

(Also, it looks like the linking order is already used in kernel, e.g.
 in drivers/md/Makefile)

Thus, we may introduce an optimization based on xxx_sched_class addresses
in these two hot scheduler functions: pick_next_task() and check_preempt_curr().

One more result of the patch is that size of object file becomes a little
less (excluding added BUG_ON(), which goes in __init section):

$size kernel/sched/core.o
         text     data      bss	    dec	    hex	filename
before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o

[1] https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/4/html/Using_ld_the_GNU_Linker/sections.html

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/sched/Makefile |    2 ++
 kernel/sched/core.c   |   24 +++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b70862..f78f177c660a 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -23,6 +23,8 @@ CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
+# Order is significant: a more priority class xxx is described by variable
+# xxx_sched_class with a bigger address. See BUG_ON() in sched_init().
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
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


