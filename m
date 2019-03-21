Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E9BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD23218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfCUMKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:10:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37924 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:10:18 -0400
Received: from p200300d06f010d00c8d029af8ffc83b7.dip0.t-ipconnect.de ([2003:d0:6f01:d00:c8d0:29af:8ffc:83b7] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h6wWU-00035a-Cg; Thu, 21 Mar 2019 13:10:14 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, fweisbec@gmail.com, peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 4/4] trace/timer: Improve timer tracing
Date:   Thu, 21 Mar 2019 13:09:21 +0100
Message-Id: <20190321120921.16463-5-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321120921.16463-1-anna-maria@linutronix.de>
References: <20190321120921.16463-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timers are added to the timer wheel off by one. This is required in
case a timer is queued directly before incrementing jiffies to prevent
early timer expiry.

When reading a timer trace and relying only on the expiry time of the
timer in timer_start trace point and on the now in timer_expiry_entry
trace point, it seems that the timer fires late. With the current
timer_expiry_entry trace point information only now=jiffies is printed
but not the value of base->clk. This makes it impossible to draw a
conclusion to the index of base->clk and makes it impossible to
examine timer problems without additional trace points.

Therefore add the base->clk value to the timer_expire_entry trace
point, to be able to calculate the index the timer base is located at
during collecting expired timers.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 include/trace/events/timer.h | 11 +++++++----
 kernel/time/timer.c          | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index da975d69c453..dade735657ef 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -89,24 +89,27 @@ TRACE_EVENT(timer_start,
  */
 TRACE_EVENT(timer_expire_entry,
 
-	TP_PROTO(struct timer_list *timer),
+	TP_PROTO(struct timer_list *timer, unsigned long baseclk),
 
-	TP_ARGS(timer),
+	TP_ARGS(timer, baseclk),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer	)
 		__field( unsigned long,	now	)
 		__field( void *,	function)
+		__field( unsigned long,	baseclk	)
 	),
 
 	TP_fast_assign(
 		__entry->timer		= timer;
 		__entry->now		= jiffies;
 		__entry->function	= timer->function;
+		__entry->baseclk	= baseclk;
 	),
 
-	TP_printk("timer=%p function=%ps now=%lu",
-		  __entry->timer, __entry->function, __entry->now)
+	TP_printk("timer=%p function=%ps now=%lu base->clk=%lu",
+		  __entry->timer, __entry->function, __entry->now,
+		  __entry->baseclk)
 );
 
 /**
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8d7918ae4d0c..c0233c1a4ccb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1293,7 +1293,8 @@ int del_timer_sync(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 
-static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list *))
+static void call_timer_fn(unsigned long baseclk, struct timer_list *timer,
+			  void (*fn)(struct timer_list *))
 {
 	int count = preempt_count();
 
@@ -1316,7 +1317,7 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 	 */
 	lock_map_acquire(&lockdep_map);
 
-	trace_timer_expire_entry(timer);
+	trace_timer_expire_entry(timer, baseclk);
 	fn(timer);
 	trace_timer_expire_exit(timer);
 
@@ -1337,6 +1338,14 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 
 static void expire_timers(struct timer_base *base, struct hlist_head *head)
 {
+	/*
+	 * this value is required for tracing only
+	 *
+	 * base->clk was incremented directly before expire_timers was
+	 * called. But expiry is related to the old base->clk value.
+	 */
+	unsigned long baseclk = base->clk - 1;
+
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
 		void (*fn)(struct timer_list *);
@@ -1350,11 +1359,11 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
-			call_timer_fn(timer, fn);
+			call_timer_fn(baseclk, timer, fn);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
-			call_timer_fn(timer, fn);
+			call_timer_fn(baseclk, timer, fn);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
-- 
2.20.1

