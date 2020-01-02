Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A00C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DF421734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgABKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:08:12 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40189 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgABKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:08:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TmbR1li_1577959689;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TmbR1li_1577959689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 18:08:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched/cputime: code cleanup in irqtime_account_process_tick
Date:   Thu,  2 Jan 2020 18:07:53 +0800
Message-Id: <1577959674-255537-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this func, since account_system_time() considers guest time account
and other system time.  we could fold the account_guest_time into
account_system_time() to simply the code.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cff3e656566d..46b837e94fce 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -381,13 +381,10 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
-	} else if (p == this_rq()->idle) {
+	} else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
+		account_system_time(p, HARDIRQ_OFFSET, cputime);
+	else
 		account_idle_time(cputime);
-	} else if (p->flags & PF_VCPU) { /* System time or guest time */
-		account_guest_time(p, cputime);
-	} else {
-		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
-	}
 }
 
 static void irqtime_account_idle_ticks(int ticks)
-- 
1.8.3.1

