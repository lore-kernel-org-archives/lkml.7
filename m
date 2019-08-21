Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214E8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5422064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfHUTaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:30:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57180 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfHUTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJj-0004Ao-DN; Wed, 21 Aug 2019 21:30:47 +0200
Message-Id: <20190821192920.050770464@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 09/38] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_set()
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
as argument to the sample functions. That allows to simplify them once all
callers are fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -556,10 +556,11 @@ static void cpu_timer_fire(struct k_itim
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
-	unsigned long flags;
-	struct sighand_struct *sighand;
-	struct task_struct *p = timer->it.cpu.task;
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
+	struct task_struct *p = timer->it.cpu.task;
+	struct sighand_struct *sighand;
+	unsigned long flags;
 	int ret;
 
 	if (WARN_ON_ONCE(!p))
@@ -606,9 +607,9 @@ static int posix_cpu_timer_set(struct k_
 	 * check if it's already passed.  In short, we need a sample.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &val);
+		cpu_clock_sample(clkid, p, &val);
 	} else {
-		cpu_clock_sample_group(timer->it_clock, p, &val, true);
+		cpu_clock_sample_group(clkid, p, &val, true);
 	}
 
 	if (old) {


