Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DB02166E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbfGWGIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:08:11 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45703 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729098AbfGWGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:08:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXbg7o6_1563862083;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXbg7o6_1563862083)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:08:04 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] cputime: unify account_process_tick func
Date:   Tue, 23 Jul 2019 14:01:42 +0800
Message-Id: <20190723060142.145747-3-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190723060142.145747-1-alex.shi@linux.alibaba.com>
References: <20190723060142.145747-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqtime_account_process_tick path was introduced for precise ns irq
time account from commit abb74cefa9c6 ("sched: Export ns irqtimes
through /proc/stat") while account_process_tick still use jiffes. This
divide isn't necessary especially now both paths are ns precison.

Move out the irqtime_account_process_tick func from IRQ_TIME_ACCOUNTING.
and combine the code for both *account_process_tick funcs for 2 paths.
Then remove the useless irqtime_account_process_tick().

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 84 ++++++------------------------------------
 1 file changed, 12 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3bf94eb7b7c6..3cc581409252 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -332,68 +332,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_IRQ_TIME_ACCOUNTING
-/*
- * Account a tick to a process and cpustat
- * @p: the process that the CPU time gets accounted to
- * @user_tick: is the tick from userspace
- * @rq: the pointer to rq
- *
- * Tick demultiplexing follows the order
- * - pending hardirq update
- * - pending softirq update
- * - user_time
- * - idle_time
- * - system time
- *   - check for guest_time
- *   - else account as system_time
- *
- * Check for hardirq is done both for system and user time as there is
- * no timer going off while we are on hardirq and hence we may never get an
- * opportunity to update it solely in system time.
- * p->stime and friends are only updated on system time and not on irq
- * softirq as those do not count in task exec_runtime any more.
- */
-static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-					 struct rq *rq, int ticks)
-{
-	u64 other, cputime = TICK_NSEC * ticks;
-
-	/*
-	 * When returning from idle, many ticks can get accounted at
-	 * once, including some ticks of steal, irq, and softirq time.
-	 * Subtract those ticks from the amount of time accounted to
-	 * idle, or potentially user or system time. Due to rounding,
-	 * other time can exceed ticks occasionally.
-	 */
-	other = account_other_time(ULONG_MAX);
-	if (other >= cputime)
-		return;
-
-	cputime -= other;
-
-	if (this_cpu_ksoftirqd() == p) {
-		/*
-		 * ksoftirqd time do not get accounted in cpu_softirq_time.
-		 * So, we have to handle it separately here.
-		 * Also, p->stime needs to be updated for ksoftirqd.
-		 */
-		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
-	} else if (user_tick) {
-		account_user_time(p, cputime);
-	} else if (p == rq->idle) {
-		account_idle_time(cputime);
-	} else if (p->flags & PF_VCPU) { /* System time or guest time */
-		account_guest_time(p, cputime);
-	} else {
-		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
-	}
-}
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
-static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-						struct rq *rq, int nr_ticks) { }
-#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
-
 /*
  * Use precise platform statistics if available:
  */
@@ -466,26 +404,28 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
  */
 void account_process_tick(struct task_struct *p, int user_tick)
 {
-	u64 cputime, steal;
+	u64 cputime, other;
 	struct rq *rq = this_rq();
 
 	if (vtime_accounting_cpu_enabled())
 		return;
 
-	if (sched_clock_irqtime) {
-		irqtime_account_process_tick(p, user_tick, rq, 1);
-		return;
-	}
-
 	cputime = TICK_NSEC;
-	steal = steal_account_process_time(ULONG_MAX);
+	other = account_other_time(ULONG_MAX);
 
-	if (steal >= cputime)
+	if (other >= cputime)
 		return;
 
-	cputime -= steal;
+	cputime -= other;
 
-	if (user_tick)
+	if (this_cpu_ksoftirqd() == p)
+		/*
+		 * ksoftirqd time do not get accounted in cpu_softirq_time.
+		 * So, we have to handle it separately here.
+		 * Also, p->stime needs to be updated for ksoftirqd.
+		 */
+		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
+	else if (user_tick)
 		account_user_time(p, cputime);
 	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
 		account_system_time(p, HARDIRQ_OFFSET, cputime);
-- 
2.19.1.856.g8858448bb

