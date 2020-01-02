Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7155C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB520866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgABKIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:08:15 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36138 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727978AbgABKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:08:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TmbxjSZ_1577959689;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TmbxjSZ_1577959689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 18:08:10 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched/cputime: cleanup account_process_tick/account_idle_ticks
Date:   Thu,  2 Jan 2020 18:07:54 +0800
Message-Id: <1577959674-255537-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqtime_account_process_tick() was introduced for precise ns irq
time account from commit abb74cefa9c6 ("sched: Export ns irqtimes
through /proc/stat") which is necessary since account_process_tick()
still use jiffes at that time.

Now account_process_tick/account_idle_ticks functions do the actual
same actions as irqtime_account_process_tick() to account ns precision
cputime when !sched_clock_irqtime. which could be replaced by
irqtime_account_process_tick();

So we move out irqtime_account_process_tick from IRQ_TIME_ACCOUNTING
config, let it work w/o IRQ_TIME_ACCOUNTING. and remove the duplicated
code in account_process_tick/account_idle_ticks.
And furthmore I removed the function account_idle_ticks by a directly
call.

It can simplify the code, also reduce a bit object size.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/kernel_stat.h |  2 +-
 kernel/sched/cputime.c      | 58 ++-------------------------------------------
 kernel/time/tick-sched.c    |  2 +-
 3 files changed, 4 insertions(+), 58 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745c096d..e924bdb8c874 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -113,6 +113,6 @@ static inline void account_process_tick(struct task_struct *tsk, int user)
 extern void account_process_tick(struct task_struct *, int user);
 #endif
 
-extern void account_idle_ticks(unsigned long ticks);
+extern void irqtime_account_process_tick(struct task_struct *, int , int);
 
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 46b837e94fce..0e0c74c1b3c9 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -332,7 +332,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_IRQ_TIME_ACCOUNTING
 /*
  * Account a tick to a process and cpustat
  * @p: the process that the CPU time gets accounted to
@@ -354,7 +353,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
  * p->stime and friends are only updated on system time and not on irq
  * softirq as those do not count in task exec_runtime any more.
  */
-static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
+void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 					 int ticks)
 {
 	u64 other, cputime = TICK_NSEC * ticks;
@@ -387,16 +386,6 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		account_idle_time(cputime);
 }
 
-static void irqtime_account_idle_ticks(int ticks)
-{
-	irqtime_account_process_tick(current, 0, ticks);
-}
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
-static inline void irqtime_account_idle_ticks(int ticks) { }
-static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-						int nr_ticks) { }
-#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
-
 /*
  * Use precise platform statistics if available:
  */
@@ -467,53 +456,10 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
  */
 void account_process_tick(struct task_struct *p, int user_tick)
 {
-	u64 cputime, steal;
-
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
-	if (sched_clock_irqtime) {
-		irqtime_account_process_tick(p, user_tick, 1);
-		return;
-	}
-
-	cputime = TICK_NSEC;
-	steal = steal_account_process_time(ULONG_MAX);
-
-	if (steal >= cputime)
-		return;
-
-	cputime -= steal;
-
-	if (user_tick)
-		account_user_time(p, cputime);
-	else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
-		account_system_time(p, HARDIRQ_OFFSET, cputime);
-	else
-		account_idle_time(cputime);
-}
-
-/*
- * Account multiple ticks of idle time.
- * @ticks: number of stolen ticks
- */
-void account_idle_ticks(unsigned long ticks)
-{
-	u64 cputime, steal;
-
-	if (sched_clock_irqtime) {
-		irqtime_account_idle_ticks(ticks);
-		return;
-	}
-
-	cputime = ticks * TICK_NSEC;
-	steal = steal_account_process_time(ULONG_MAX);
-
-	if (steal >= cputime)
-		return;
-
-	cputime -= steal;
-	account_idle_time(cputime);
+	irqtime_account_process_tick(p, user_tick, 1);
 }
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b192e67aabc..92a0979633e9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1142,7 +1142,7 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 	 * We might be one off. Do not randomly account a huge number of ticks!
 	 */
 	if (ticks && ticks < LONG_MAX)
-		account_idle_ticks(ticks);
+		irqtime_account_process_tick(current, 0, ticks);
 #endif
 }
 
-- 
1.8.3.1

