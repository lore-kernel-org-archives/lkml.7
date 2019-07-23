Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC2C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C2B2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfGWGIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:08:05 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46006 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729098AbfGWGIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:08:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXbg7nQ_1563862080;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXbg7nQ_1563862080)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:08:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] cputime: unify account_idle_ticks
Date:   Tue, 23 Jul 2019 14:01:41 +0800
Message-Id: <20190723060142.145747-2-alex.shi@linux.alibaba.com>
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

Check the 'current' task in account_idle_ticks is meaningless. So we
could remove irqtime_account_idle_ticks and unify this function.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d78aee140957..3bf94eb7b7c6 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -389,15 +389,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
 	}
 }
-
-static void irqtime_account_idle_ticks(int ticks)
-{
-	struct rq *rq = this_rq();
-
-	irqtime_account_process_tick(current, 0, rq, ticks);
-}
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
-static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 						struct rq *rq, int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
@@ -507,20 +499,15 @@ void account_process_tick(struct task_struct *p, int user_tick)
  */
 void account_idle_ticks(unsigned long ticks)
 {
-	u64 cputime, steal;
-
-	if (sched_clock_irqtime) {
-		irqtime_account_idle_ticks(ticks);
-		return;
-	}
+	u64 cputime, other;
 
 	cputime = ticks * TICK_NSEC;
-	steal = steal_account_process_time(ULONG_MAX);
+	other = account_other_time(ULONG_MAX);
 
-	if (steal >= cputime)
+	if (other >= cputime)
 		return;
 
-	cputime -= steal;
+	cputime -= other;
 	account_idle_time(cputime);
 }
 
-- 
2.19.1.856.g8858448bb

