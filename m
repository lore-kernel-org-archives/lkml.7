Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF39820679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfHUTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:31:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHUTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJz-0004FK-Gy; Wed, 21 Aug 2019 21:31:03 +0200
Message-Id: <20190821192921.790209622@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 27/38] posix-cpu-timers: Remove cputime_expires
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last users of the magic struct cputime based expiry cache are
gone. Remove the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    9 ++-------
 kernel/time/posix-cpu-timers.c |   10 ----------
 2 files changed, 2 insertions(+), 17 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,19 +65,14 @@ static inline int clockid_to_fd(const cl
 #ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data
- * @cputime_expires:	Earliest-expiration cache task_cputime based
  * @expiries:		Earliest-expiration cache array based
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	/* Temporary union until all users are cleaned up */
-	union {
-		struct task_cputime	cputime_expires;
-		u64			expiries[CPUCLOCK_MAX];
-	};
-	struct list_head		cpu_timers[CPUCLOCK_MAX];
+	u64			expiries[CPUCLOCK_MAX];
+	struct list_head	cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -18,16 +18,6 @@
 
 #include "posix-timers.h"
 
-static inline void temporary_check(void)
-{
-	BUILD_BUG_ON(offsetof(struct task_cputime, stime) !=
-		     CPUCLOCK_PROF * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, utime) !=
-		     CPUCLOCK_VIRT * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, sum_exec_runtime) !=
-		     CPUCLOCK_SCHED * sizeof(u64));
-}
-
 static void posix_cpu_timer_rearm(struct k_itimer *timer);
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)


