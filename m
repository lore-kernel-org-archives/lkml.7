Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC28CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF5620717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJ0Grr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40940 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJ0Grr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:47:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iOcL3-0002pf-3w; Sun, 27 Oct 2019 07:47:45 +0100
Date:   Sun, 27 Oct 2019 06:46:26 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.4-rc5
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
Message-ID: <157215878694.13117.5360990944289610665.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  7f2cbcbcafbc: posix-cpu-timers: Fix two trivial comments

A small set of fixes for time(keeping):

 - Add a missing include to prevent compiler warnings.

 - Make the VDSO implementation of clock_getres() POSIX compliant again.
   A recent change dropped the NULL pointer guard which is required as
   NULL is a valid pointer value for this function.

 - Fix two function documentation typos.

Thanks,

	tglx

------------------>
Ben Dooks (Codethink) (1):
      timers/sched_clock: Include local timekeeping.h for missing declarations

Thomas Gleixner (1):
      lib/vdso: Make clock_getres() POSIX compliant again

Yi Wang (1):
      posix-cpu-timers: Fix two trivial comments


 kernel/time/posix-cpu-timers.c | 6 +++---
 kernel/time/sched_clock.c      | 2 ++
 lib/vdso/gettimeofday.c        | 9 +++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 92a431981b1c..42d512fcfda2 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -266,7 +266,7 @@ static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
 /**
  * thread_group_sample_cputime - Sample cputime for a given task
  * @tsk:	Task for which cputime needs to be started
- * @iimes:	Storage for time samples
+ * @samples:	Storage for time samples
  *
  * Called from sys_getitimer() to calculate the expiry time of an active
  * timer. That means group cputime accounting is already active. Called
@@ -1038,12 +1038,12 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
  * member of @pct->bases[CLK].nextevt. False otherwise
  */
 static inline bool
-task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
+task_cputimers_expired(const u64 *samples, struct posix_cputimers *pct)
 {
 	int i;
 
 	for (i = 0; i < CPUCLOCK_MAX; i++) {
-		if (sample[i] >= pct->bases[i].nextevt)
+		if (samples[i] >= pct->bases[i].nextevt)
 			return true;
 	}
 	return false;
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 142b07619918..dbd69052eaa6 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -17,6 +17,8 @@
 #include <linux/seqlock.h>
 #include <linux/bitops.h>
 
+#include "timekeeping.h"
+
 /**
  * struct clock_read_data - data required to read from sched_clock()
  *
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e630e7ff57f1..45f57fd2db64 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -214,9 +214,10 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 		return -1;
 	}
 
-	res->tv_sec = 0;
-	res->tv_nsec = ns;
-
+	if (likely(res)) {
+		res->tv_sec = 0;
+		res->tv_nsec = ns;
+	}
 	return 0;
 }
 
@@ -245,7 +246,7 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 		ret = clock_getres_fallback(clock, &ts);
 #endif
 
-	if (likely(!ret)) {
+	if (likely(!ret && res)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}


