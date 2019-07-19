Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C783E2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfGSCm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:42:57 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37160 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfGSCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:42:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXFEz7S_1563504172;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXFEz7S_1563504172)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 10:42:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] cputime: remove duplicate code in account_process_tick
Date:   Fri, 19 Jul 2019 10:42:42 +0800
Message-Id: <20190719024242.249429-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
References: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqtime_account_process_tick path was introduced for precise ns irq
time account from commit abb74cefa9c682fb (sched: Export ns irqtimes through
/proc/stat) while account_process_tick still use jiffes. This divide
isn't neccessary especially now both pathes are ns precison.

Move out the irqtime_account_process_tick func from IRQ_TIME_ACCOUNTING.
So it do generally same things as account_process_tick whenever if
IRQ_TIME_ACCOUNTING set or if sched_clock_irqtime enabled.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3aaf761ede81..6116f50e1f37 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -332,7 +332,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_IRQ_TIME_ACCOUNTING
 /*
  * Account a tick to a process and cpustat
  * @p: the process that the CPU time gets accounted to
@@ -390,14 +389,13 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	}
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
 static void irqtime_account_idle_ticks(int ticks)
 {
 	irqtime_account_process_tick(current, 0, ticks);
 }
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 static inline void irqtime_account_idle_ticks(int ticks) { }
-static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-						int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 /*
@@ -472,30 +470,10 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
  */
 void account_process_tick(struct task_struct *p, int user_tick)
 {
-	u64 cputime, steal;
-
 	if (vtime_accounting_cpu_enabled())
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
+	irqtime_account_process_tick(p, user_tick, 1);
 }
 
 /*
-- 
2.19.1.856.g8858448bb

