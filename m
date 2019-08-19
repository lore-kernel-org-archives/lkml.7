Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F49C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1219322CE2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfHSPqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqt-0006yO-Ax; Mon, 19 Aug 2019 17:45:47 +0200
Message-Id: <20190819143804.051673822@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:09 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 28/44] posix-cpu-timers: Simplify timer queueing
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the expiry cache can be accessed as an array, the per clock
checking can be reduced to just comparing the corresponding array elements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   57 +++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -449,20 +449,20 @@ static inline int expires_gt(u64 expires
  */
 static void arm_timer(struct k_itimer *timer)
 {
+	struct cpu_timer_list *const nt = &timer->it.cpu;
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	u64 *cpuexp, newexp = timer->it.cpu.expires;
 	struct task_struct *p = timer->it.cpu.task;
 	struct list_head *head, *listpos;
-	struct task_cputime *cputime_expires;
-	struct cpu_timer_list *const nt = &timer->it.cpu;
 	struct cpu_timer_list *next;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->posix_cputimers.cpu_timers;
-		cputime_expires = &p->posix_cputimers.cputime_expires;
+		head = p->posix_cputimers.cpu_timers + clkidx;
+		cpuexp = p->posix_cputimers.expiries + clkidx;
 	} else {
-		head = p->signal->posix_cputimers.cpu_timers;
-		cputime_expires = &p->signal->posix_cputimers.cputime_expires;
+		head = p->signal->posix_cputimers.cpu_timers + clkidx;
+		cpuexp = p->signal->posix_cputimers.expiries + clkidx;
 	}
-	head += CPUCLOCK_WHICH(timer->it_clock);
 
 	listpos = head;
 	list_for_each_entry(next, head, entry) {
@@ -472,35 +472,22 @@ static void arm_timer(struct k_itimer *t
 	}
 	list_add(&nt->entry, listpos);
 
-	if (listpos == head) {
-		u64 exp = nt->expires;
+	if (listpos != head)
+		return;
 
-		/*
-		 * We are the new earliest-expiring POSIX 1.b timer, hence
-		 * need to update expiration cache. Take into account that
-		 * for process timers we share expiration cache with itimers
-		 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
-		 */
-
-		switch (CPUCLOCK_WHICH(timer->it_clock)) {
-		case CPUCLOCK_PROF:
-			if (expires_gt(cputime_expires->prof_exp, exp))
-				cputime_expires->prof_exp = exp;
-			break;
-		case CPUCLOCK_VIRT:
-			if (expires_gt(cputime_expires->virt_exp, exp))
-				cputime_expires->virt_exp = exp;
-			break;
-		case CPUCLOCK_SCHED:
-			if (expires_gt(cputime_expires->sched_exp, exp))
-				cputime_expires->sched_exp = exp;
-			break;
-		}
-		if (CPUCLOCK_PERTHREAD(timer->it_clock))
-			tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
-		else
-			tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
-	}
+	/*
+	 * We are the new earliest-expiring POSIX 1.b timer, hence
+	 * need to update expiration cache. Take into account that
+	 * for process timers we share expiration cache with itimers
+	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
+	 */
+	if (expires_gt(*cpuexp, newexp))
+		*cpuexp = newexp;
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
+	else
+		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*


