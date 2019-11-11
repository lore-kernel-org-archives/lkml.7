Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36233C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DBA20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKKJdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:33:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKKJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:33:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63o-00039X-JJ; Mon, 11 Nov 2019 10:32:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 282C21C0093;
        Mon, 11 Nov 2019 10:32:36 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Make pick_next_task_idle() more consistent
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        ktkhai@virtuozzo.com, mgorman@suse.de, qais.yousef@arm.com,
        qperret@google.com, rostedt@goodmis.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108131909.545730862@infradead.org>
References: <20191108131909.545730862@infradead.org>
MIME-Version: 1.0
Message-ID: <157346475585.29376.10209379419645304652.tip-bot2@tip-bot2>
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

Commit-ID:     f488e1057bb97b881ed317557dc5e62ff8747393
Gitweb:        https://git.kernel.org/tip/f488e1057bb97b881ed317557dc5e62ff8747393
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 Nov 2019 14:15:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 08:35:19 +01:00

sched/core: Make pick_next_task_idle() more consistent

Only pick_next_task_fair() needs the @prev and @rf argument; these are
required to implement the cpu-cgroup optimization. None of the other
pick_next_task() methods need this. Make pick_next_task_idle() more
consistent.

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
Link: https://lkml.kernel.org/r/20191108131909.545730862@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 6 ++++--
 kernel/sched/idle.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f2eb36..59c4f29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3922,8 +3922,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
-		if (unlikely(!p))
-			p = idle_sched_class.pick_next_task(rq, prev, rf);
+		if (unlikely(!p)) {
+			put_prev_task(rq, prev);
+			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
+		}
 
 		return p;
 	}
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f65ef1e..179d1d4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -396,8 +396,7 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct task_struct *next = rq->idle;
 
-	if (prev)
-		put_prev_task(rq, prev);
+	WARN_ON_ONCE(prev || rf);
 
 	set_next_task_idle(rq, next);
 
