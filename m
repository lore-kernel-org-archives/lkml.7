Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CC3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfHSPqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfHSPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqt-0006ye-NH; Mon, 19 Aug 2019 17:45:47 +0200
Message-Id: <20190819143804.144102557@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 29/44] posix-cpu-timers: Simplify set_process_cpu_timer()
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expiry cache can now be accessed as an array. Replace the per clock
checks with a simple comparison of the clock indexed array member.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1181,15 +1181,15 @@ void run_posix_cpu_timers(void)
  * Set one of the process-wide special case CPU timers or RLIMIT_CPU.
  * The tsk->sighand->siglock must be held by the caller.
  */
-void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
+void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			   u64 *newval, u64 *oldval)
 {
-	u64 now;
+	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
 
-	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
+	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
 		return;
 
-	now = cpu_clock_sample_group(clock_idx, tsk, true);
+	now = cpu_clock_sample_group(clkid, tsk, true);
 
 	if (oldval) {
 		/*
@@ -1212,19 +1212,11 @@ void set_process_cpu_timer(struct task_s
 	}
 
 	/*
-	 * Update expiration cache if we are the earliest timer, or eventually
-	 * RLIMIT_CPU limit is earlier than prof_exp cpu timer expire.
+	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
+	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	switch (clock_idx) {
-	case CPUCLOCK_PROF:
-		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.prof_exp, *newval))
-			tsk->signal->posix_cputimers.cputime_expires.prof_exp = *newval;
-		break;
-	case CPUCLOCK_VIRT:
-		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.virt_exp, *newval))
-			tsk->signal->posix_cputimers.cputime_expires.virt_exp = *newval;
-		break;
-	}
+	if (expires_gt(*expiry, *newval))
+		*expiry = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }


