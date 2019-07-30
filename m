Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50E8206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbfG3Wkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:40:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbfG3Wku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:40:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsanS-0002Nj-AS; Wed, 31 Jul 2019 00:40:42 +0200
Message-Id: <20190730223828.600085866@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 2/7] timerfd: Prepare for PREEMPT_RT
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the hrtimer_cancel_wait_running() synchronization mechanism to prevent
priority inversion and live locks on PREEMPT_RT.

[ tglx: Split out of combo patch ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/timerfd.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,7 +471,11 @@ static int do_timerfd_settime(int ufd, i
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
-		cpu_relax();
+
+		if (isalarm(ctx))
+			hrtimer_cancel_wait_running(&ctx->t.alarm.timer);
+		else
+			hrtimer_cancel_wait_running(&ctx->t.tmr);
 	}
 
 	/*


