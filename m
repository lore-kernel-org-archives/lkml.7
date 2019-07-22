Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B40BC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613F422296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfGVHi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:38:59 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38561 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727483AbfGVHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:38:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXUL6mK_1563781132;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXUL6mK_1563781132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jul 2019 15:38:52 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] cputime: remove rq parameter from irqtime_account_process_tick func
Date:   Mon, 22 Jul 2019 15:38:40 +0800
Message-Id: <20190722073840.32613-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190722073840.32613-1-alex.shi@linux.alibaba.com>
References: <20190722073840.32613-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the per cpu rq in function internal is better and meaningful, don't
need get and pass it from outside as a parameter.

It also reduce the object size. with defconfig + CONFIG_IRQ_TIME_ACCOUNTING
             base		with this patch
cputime.o    10632 bytes	10568 bytes

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5086b24d7bee..4e7a1841be86 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -354,9 +354,10 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
  * softirq as those do not count in task exec_runtime any more.
  */
 static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-					 struct rq *rq, int ticks)
+					 int ticks)
 {
 	u64 other, cputime = TICK_NSEC * ticks;
+	struct rq *rq;
 
 	/*
 	 * When returning from idle, many ticks can get accounted at
@@ -370,6 +371,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		return;
 
 	cputime -= other;
+	rq = this_rq();
 
 	if (this_cpu_ksoftirqd() == p) {
 		/*
@@ -392,9 +394,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 static void irqtime_account_idle_ticks(int ticks)
 {
-	struct rq *rq = this_rq();
-
-	irqtime_account_process_tick(current, 0, rq, ticks);
+	irqtime_account_process_tick(current, 0, ticks);
 }
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 static inline void irqtime_account_idle_ticks(int ticks) { }
@@ -472,12 +472,10 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
  */
 void account_process_tick(struct task_struct *p, int user_tick)
 {
-	struct rq *rq = this_rq();
-
 	if (vtime_accounting_cpu_enabled())
 		return;
 
-	irqtime_account_process_tick(p, user_tick, rq, 1);
+	irqtime_account_process_tick(p, user_tick, 1);
 }
 
 /*
-- 
2.19.1.856.g8858448bb

