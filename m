Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6139C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4D72087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfG3WlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:41:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388293AbfG3WlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:41:01 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsanX-0002OF-0v; Wed, 31 Jul 2019 00:40:47 +0200
Message-Id: <20190730223828.782664411@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 4/7] posix-timers: Cleanup the flag/flags confusion
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_timer_settime() has a 'flags' argument and uses 'flag' for the interrupt
flags, which is confusing at best.

Rename the argument so 'flags' can be used for interrupt flags as usual.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -844,13 +844,13 @@ int common_timer_set(struct k_itimer *ti
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int flags,
+static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
 	const struct k_clock *kc;
 	struct k_itimer *timr;
-	unsigned long flag;
+	unsigned long flags;
 	int error = 0;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -860,7 +860,7 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 retry:
-	timr = lock_timer(timer_id, &flag);
+	timr = lock_timer(timer_id, &flags);
 	if (!timr)
 		return -EINVAL;
 
@@ -868,9 +868,9 @@ static int do_timer_settime(timer_t time
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
-		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
+		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
+	unlock_timer(timr, flags);
 	if (error == TIMER_RETRY) {
 		old_spec64 = NULL;	// We already got the old time...
 		goto retry;


