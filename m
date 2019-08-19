Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7891C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8741E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfHSPpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:45:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfHSPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:39 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqj-0006ti-U9; Mon, 19 Aug 2019 17:45:37 +0200
Message-Id: <20190819143801.945469967@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 06/44] posix-cpu-timers: Remove tsk argument from
 run_posix_cpu_timers()
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's always current. Don't give people wrong ideas.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 +-
 kernel/time/posix-cpu-timers.c |    5 +++--
 kernel/time/timer.c            |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -118,7 +118,7 @@ struct k_itimer {
 	struct rcu_head		rcu;
 };
 
-void run_posix_cpu_timers(struct task_struct *task);
+void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
 void posix_cpu_timers_exit_group(struct task_struct *task);
 void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1137,11 +1137,12 @@ static inline int fastpath_timer_check(s
  * already updated our counts.  We need to check if any timers fire now.
  * Interrupts are disabled.
  */
-void run_posix_cpu_timers(struct task_struct *tsk)
+void run_posix_cpu_timers(void)
 {
-	LIST_HEAD(firing);
+	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	LIST_HEAD(firing);
 
 	lockdep_assert_irqs_disabled();
 
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1728,7 +1728,7 @@ void update_process_times(int user_tick)
 #endif
 	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
-		run_posix_cpu_timers(p);
+		run_posix_cpu_timers();
 }
 
 /**


