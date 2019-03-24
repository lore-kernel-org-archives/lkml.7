Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54286C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D59420989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfCXUVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:21:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:21:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OKL6Y21615496
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 13:21:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OKL6Jl1615493;
        Sun, 24 Mar 2019 13:21:06 -0700
Date:   Sun, 24 Mar 2019 13:21:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-f28d3d5346e97e60c81f933ac89ccf015430e5cf@git.kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, hpa@zytor.com,
        anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: rostedt@goodmis.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190321120921.16463-5-anna-maria@linutronix.de>
References: <20190321120921.16463-5-anna-maria@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer/trace: Improve timer tracing
Git-Commit-ID: f28d3d5346e97e60c81f933ac89ccf015430e5cf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f28d3d5346e97e60c81f933ac89ccf015430e5cf
Gitweb:     https://git.kernel.org/tip/f28d3d5346e97e60c81f933ac89ccf015430e5cf
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Thu, 21 Mar 2019 13:09:21 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 20:29:33 +0100

timer/trace: Improve timer tracing

Timers are added to the timer wheel off by one. This is required in
case a timer is queued directly before incrementing jiffies to prevent
early timer expiry.

When reading a timer trace and relying only on the expiry time of the timer
in the timer_start trace point and on the now in the timer_expiry_entry
trace point, it seems that the timer fires late. With the current
timer_expiry_entry trace point information only now=jiffies is printed but
not the value of base->clk. This makes it impossible to draw a conclusion
to the index of base->clk and makes it impossible to examine timer problems
without additional trace points.

Therefore add the base->clk value to the timer_expire_entry trace
point, to be able to calculate the index the timer base is located at
during collecting expired timers.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Cc: peterz@infradead.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20190321120921.16463-5-anna-maria@linutronix.de

---
 include/trace/events/timer.h | 11 +++++++----
 kernel/time/timer.c          | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index da975d69c453..b7a904825e7d 100644
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
+	TP_printk("timer=%p function=%ps now=%lu baseclk=%lu",
+		  __entry->timer, __entry->function, __entry->now,
+		  __entry->baseclk)
 );
 
 /**
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 8d7918ae4d0c..a9b1bbc2d88d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1293,7 +1293,9 @@ int del_timer_sync(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 
-static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list *))
+static void call_timer_fn(struct timer_list *timer,
+			  void (*fn)(struct timer_list *),
+			  unsigned long baseclk)
 {
 	int count = preempt_count();
 
@@ -1316,7 +1318,7 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 	 */
 	lock_map_acquire(&lockdep_map);
 
-	trace_timer_expire_entry(timer);
+	trace_timer_expire_entry(timer, baseclk);
 	fn(timer);
 	trace_timer_expire_exit(timer);
 
@@ -1337,6 +1339,13 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(struct timer_list
 
 static void expire_timers(struct timer_base *base, struct hlist_head *head)
 {
+	/*
+	 * This value is required only for tracing. base->clk was
+	 * incremented directly before expire_timers was called. But expiry
+	 * is related to the old base->clk value.
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
+			call_timer_fn(timer, fn, baseclk);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
-			call_timer_fn(timer, fn);
+			call_timer_fn(timer, fn, baseclk);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
