Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA3BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87BC21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfLQMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55280 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfLQMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8s-0001ro-UJ; Tue, 17 Dec 2019 13:39:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 15EDB1C2A40;
        Tue, 17 Dec 2019 13:39:53 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:52 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use fair:prio_changed() instead of ad-hoc
 implementation
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191203160106.18806-3-frederic@kernel.org>
References: <20191203160106.18806-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157658639295.30329.4061098261424663170.tip-bot2@tip-bot2>
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

Commit-ID:     5443a0be6121d557e12951537e10159e4c61035d
Gitweb:        https://git.kernel.org/tip/5443a0be6121d557e12951537e10159e4c61035d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 03 Dec 2019 17:01:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:50 +01:00

sched: Use fair:prio_changed() instead of ad-hoc implementation

set_user_nice() implements its own version of fair::prio_changed() and
therefore misses a specific optimization towards nohz_full CPUs that
avoid sending an resched IPI to a reniced task running alone. Use the
proper callback instead.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20191203160106.18806-3-frederic@kernel.org
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00..15508c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4540,17 +4540,17 @@ void set_user_nice(struct task_struct *p, long nice)
 	p->prio = effective_prio(p);
 	delta = p->prio - old_prio;
 
-	if (queued) {
+	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-		/*
-		 * If the task increased its priority or is running and
-		 * lowered its priority, then reschedule its CPU:
-		 */
-		if (delta < 0 || (delta > 0 && task_running(rq, p)))
-			resched_curr(rq);
-	}
 	if (running)
 		set_next_task(rq, p);
+
+	/*
+	 * If the task increased its priority or is running and
+	 * lowered its priority, then reschedule its CPU:
+	 */
+	p->sched_class->prio_changed(rq, p, old_prio);
+
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
 }
