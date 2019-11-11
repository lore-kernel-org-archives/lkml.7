Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85660C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F520856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKKJdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:33:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55822 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKKJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63o-00039Q-5Y; Mon, 11 Nov 2019 10:32:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BCCD31C03AB;
        Mon, 11 Nov 2019 10:32:35 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Optimize pick_next_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.603037345@infradead.org>
References: <20191108131909.603037345@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475546.29376.4590888474085572805.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5d7d605642b28a5911198a405a6072f091bfbee6
Gitweb:        https://git.kernel.org/tip/5d7d605642b28a5911198a405a6072f091bfbee6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:15:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:19 +01:00

sched/core: Optimize pick_next_task()

Ever since we moved the sched_class definitions into their own files,
the constant expression {fair,idle}_sched_class.pick_next_task() is
not in fact a compile time constant anymore and results in an indirect
call (barring LTO).

Fix that by exposing pick_next_task_{fair,idle}() directly, this gets
rid of the indirect call (and RETPOLINE) on the fast path.

Also remove the unlikely() from the idle case, it is in fact /the/ way
we select idle -- and that is a very common thing to do.

Performance for will-it-scale/sched_yield improves by 2% (as reported
by 0-day).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: ktkhai@virtuozzo.com
Cc: mgorman@suse.de
Cc: qais.yousef@arm.com
Cc: qperret@google.com
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20191108131909.603037345@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 6 +++---
 kernel/sched/fair.c  | 2 +-
 kernel/sched/idle.c  | 2 +-
 kernel/sched/sched.h | 3 +++
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 59c4f29..7cf6547 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3917,14 +3917,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		    prev->sched_class == &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
-		p = fair_sched_class.pick_next_task(rq, prev, rf);
+		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
 			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
-		if (unlikely(!p)) {
+		if (!p) {
 			put_prev_task(rq, prev);
-			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
+			p = pick_next_task_idle(rq, NULL, NULL);
 		}
 
 		return p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c48a695..da81451 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6611,7 +6611,7 @@ preempt:
 		set_last_buddy(se);
 }
 
-static struct task_struct *
+struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 179d1d4..0fdceac 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -391,7 +391,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
 	schedstat_inc(rq->sched_goidle);
 }
 
-static struct task_struct *
+struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next = rq->idle;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8870c5..66172a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1821,6 +1821,9 @@ static inline bool sched_fair_runnable(struct rq *rq)
 	return rq->cfs.nr_running > 0;
 }
 
+extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+extern struct task_struct *pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
