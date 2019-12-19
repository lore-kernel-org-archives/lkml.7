Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D8C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E7D24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLSVqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfLSVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:46:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B6B24687;
        Thu, 19 Dec 2019 21:46:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ii3cN-000Un0-56; Thu, 19 Dec 2019 16:45:59 -0500
Message-Id: <20191219214559.014320534@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Dec 2019 16:44:55 -0500
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
Subject: [RFC][PATCH 4/4] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
References: <20191219214451.340746474@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>

This introduces an optimization based on xxx_sched_class addresses
in two hot scheduler functions: pick_next_task() and check_preempt_curr().

It is possible to compare pointers to sched classes to check, which
of them has a higher priority, instead of current iterations using
for_each_class().

One more result of the patch is that size of object file becomes a little
less (excluding added BUG_ON(), which goes in __init section):

$size kernel/sched/core.o
         text     data      bss	    dec	    hex	filename
before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o

Link: http://lkml.kernel.org/r/711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..63401807fcf0 100644
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
-- 
2.24.0


