Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE549C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B14520661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgAINb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:31:58 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44213 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730471AbgAINb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:31:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TnFa0Xr_1578576712;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnFa0Xr_1578576712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jan 2020 21:31:52 +0800
Subject: Re: [PATCH 2/3] sched/cputime: code cleanup in
 irqtime_account_process_tick
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577959674-255537-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200106155350.GB26097@lenoir>
 <20200107091315.GS2844@hirez.programming.kicks-ass.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <835fd412-544a-1bdd-e75f-f557e299a50a@linux.alibaba.com>
Date:   Thu, 9 Jan 2020 21:30:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107091315.GS2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I fear we can't really play the exact same game as account_process_tick() here.
>> Since this is irqtime precise accounting, we have already computed the
>> irqtime delta in account_other_time() (or we will at some point in the future)
>> and substracted it from the ticks to account. This means that the remaining cputime
>> to account has to be either utime/stime/gtime/idle-time but not interrupt time, or
>> we may account interrupt time twice. And account_system_time() tries to account
>> irq time, for example if we interrupt a softirq.
> 
> OK, I've dropped 2 and 3. Thanks Frederic!
> 

Hi Frederic & Peter,

Thanks a lot for the comments and review! 
It's my fault to mess up the account_system_time details. And seems there is no easy way to replace irqtime_account_process_tick or account_process_tick with each other.

but on the other side, the account_idle_ticks could be replaced by irqtime_account_process_tick, or at least to remove irqtime_account_idle_ticks function. Any comments?

Thanks
Alex

---

From 7073e60babc3b42a987b4e89f380956887734233 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Thu, 9 Jan 2020 20:32:55 +0800
Subject: [PATCH] sched/cputime: remove irqtime_account_idle_ticks

irqtime_account_idle_ticks and irqtime_account_process_tick use in same
condition. We don't bother to name and use a irqtime_account_idle_ticks
for only one calling. Remove the function to simply code and reduce a
bit object size of kernel.

And further more, we could replace account_idle_ticks by
irqtime_account_process_tick too. But feed and check 'current' looks weird.
So this is ok.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/sched/cputime.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cff3e656566d..17640d145e44 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -390,12 +390,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	}
 }
 
-static void irqtime_account_idle_ticks(int ticks)
-{
-	irqtime_account_process_tick(current, 0, ticks);
-}
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
-static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 						int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
@@ -505,7 +500,7 @@ void account_idle_ticks(unsigned long ticks)
 	u64 cputime, steal;
 
 	if (sched_clock_irqtime) {
-		irqtime_account_idle_ticks(ticks);
+		irqtime_account_process_tick(current, 0, ticks);
 		return;
 	}
 
-- 
1.8.3.1

