Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60241C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7642064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfHUTa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:30:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfHUTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJp-0004CV-Al; Wed, 21 Aug 2019 21:30:53 +0200
Message-Id: <20190821192920.729298382@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 16/38] posix-cpu-timers: Move prof/virt_ticks into caller
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions have only one caller left. No point in having them.

Move the almost duplicated code into the caller and simplify it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -130,23 +130,6 @@ static inline int task_cputime_zero(cons
 	return 0;
 }
 
-static inline u64 prof_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime + stime;
-}
-static inline u64 virt_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime;
-}
-
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
@@ -184,13 +167,18 @@ posix_cpu_clock_set(const clockid_t cloc
  */
 static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 {
+	u64 utime, stime;
+
+	if (clkid == CPUCLOCK_SCHED)
+		return task_sched_runtime(p);
+
+	task_cputime(p, &utime, &stime);
+
 	switch (clkid) {
 	case CPUCLOCK_PROF:
-		return prof_ticks(p);
+		return utime + stime;
 	case CPUCLOCK_VIRT:
-		return virt_ticks(p);
-	case CPUCLOCK_SCHED:
-		return task_sched_runtime(p);
+		return utime;
 	default:
 		WARN_ON_ONCE(1);
 	}


