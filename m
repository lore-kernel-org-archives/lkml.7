Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26261C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1942206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFUOgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:36:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfFUOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:36:50 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heKem-0004et-16; Fri, 21 Jun 2019 16:36:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] posix-timers: Use spin_lock_irq() in itimer_delete()
Date:   Fri, 21 Jun 2019 16:36:43 +0200
Message-Id: <20190621143643.25649-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621143643.25649-1-bigeasy@linutronix.de>
References: <20190621143643.25649-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

itimer_delete() uses spin_lock_irqsave() to obtain a `flags' variable
which can then be passed to unlock_timer(). It uses already spin_lock
locking for the structure instead of lock_timer() because it has a timer
which can not be removed by others at this point. The cleanup is always
performed with enabled interrupts.

Use spin_lock_irq() / spin_unlock_irq() so the `flags' variable can be
removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index caa63e58e3d88..d7f2d91acdac1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -980,18 +980,16 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-	unsigned long flags;
-
 retry_delete:
-	spin_lock_irqsave(&timer->it_lock, flags);
+	spin_lock_irq(&timer->it_lock);
 
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+		spin_unlock_irq(&timer->it_lock);
 		goto retry_delete;
 	}
 	list_del(&timer->list);
 
-	unlock_timer(timer, flags);
+	spin_unlock_irq(&timer->it_lock);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
-- 
2.20.1

