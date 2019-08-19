Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9919EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E1422CE6
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfHSPsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:48:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47582 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfHSPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjql-0006uG-49; Mon, 19 Aug 2019 17:45:39 +0200
Message-Id: <20190819143802.234798688@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 09/44] posix-cpu-timers: Use common permission check in
 posix_cpu_clock_get()
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the next slightly different copy of permission checks. That also
removes the necessarity to check the return value of the sample functions
because the clock id is already validated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   61 ++++++++++-------------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -289,53 +289,24 @@ static int cpu_clock_sample_group(const
 	return 0;
 }
 
-static int posix_cpu_clock_get_task(struct task_struct *tsk,
-				    const clockid_t which_clock,
-				    struct timespec64 *tp)
+static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 {
-	int err = -EINVAL;
-	u64 rtn;
+	const clockid_t clkid = CPUCLOCK_WHICH(clock);
+	struct task_struct *tsk;
+	u64 t;
+
+	tsk = get_task_for_clock(clock);
+	if (!tsk)
+		return -EINVAL;
+
+	if (CPUCLOCK_PERTHREAD(clock))
+		cpu_clock_sample(clkid, tsk, &t);
+	else
+		cpu_clock_sample_group(clkid, tsk, &t);
+	put_task_struct(tsk);
 
-	if (CPUCLOCK_PERTHREAD(which_clock)) {
-		if (same_thread_group(tsk, current))
-			err = cpu_clock_sample(which_clock, tsk, &rtn);
-	} else {
-		if (tsk == current || thread_group_leader(tsk))
-			err = cpu_clock_sample_group(which_clock, tsk, &rtn);
-	}
-
-	if (!err)
-		*tp = ns_to_timespec64(rtn);
-
-	return err;
-}
-
-
-static int posix_cpu_clock_get(const clockid_t which_clock, struct timespec64 *tp)
-{
-	const pid_t pid = CPUCLOCK_PID(which_clock);
-	int err = -EINVAL;
-
-	if (pid == 0) {
-		/*
-		 * Special case constant value for our own clocks.
-		 * We don't have to do any lookup to find ourselves.
-		 */
-		err = posix_cpu_clock_get_task(current, which_clock, tp);
-	} else {
-		/*
-		 * Find the given PID, and validate that the caller
-		 * should be able to see it.
-		 */
-		struct task_struct *p;
-		rcu_read_lock();
-		p = find_task_by_vpid(pid);
-		if (p)
-			err = posix_cpu_clock_get_task(p, which_clock, tp);
-		rcu_read_unlock();
-	}
-
-	return err;
+	*tp = ns_to_timespec64(t);
+	return 0;
 }
 
 /*


