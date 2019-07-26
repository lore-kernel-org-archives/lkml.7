Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E608FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8B21994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfGZTTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50228 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfGZTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:05 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5jy-00019s-Hc; Fri, 26 Jul 2019 21:18:54 +0200
Message-Id: <20190726185752.887468908@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 02/12] hrtimer: Consolidate hrtimer_init() +
 hrtimer_init_sleeper() calls
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hrtimer_init_sleeper() calls require prior initialisation of the hrtimer
object which is embedded into the hrtimer_sleeper.

Combine the initialization and spare a function call. Fixup all call sites.

This is also a preparatory change for PREEMPT_RT to do hrtimer sleeper
specific initializations of the embedded hrtimer without modifying any of
the call sites.

No functional change.

[ anna-maria: Minor cleanups ]
[ tglx: Adopted to the removal of the task argument of
  	hrtimer_init_sleeper() and trivial polishing ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
v2..v3: Update to current version

v1..v2: Fix missing call site in drivers/staging/android/vsoc.c

 block/blk-mq.c                 |    3 --
 drivers/staging/android/vsoc.c |    6 +----
 include/linux/hrtimer.h        |   17 +++++++++++++---
 include/linux/wait.h           |    4 +--
 kernel/futex.c                 |    8 ++-----
 kernel/time/hrtimer.c          |   43 ++++++++++++++++++++++++++++++-----------
 net/core/pktgen.c              |    4 ---
 7 files changed, 55 insertions(+), 30 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3415,10 +3415,9 @@ static bool blk_mq_poll_hybrid_sleep(str
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -437,12 +437,10 @@ static int handle_vsoc_cond_wait(struct
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
 
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+		hrtimer_init_sleeper_on_stack(&to, CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS);
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to);
 	}
 
 	while (1) {
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -347,10 +347,15 @@ DECLARE_PER_CPU(struct tick_device, tick
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+				 enum hrtimer_mode mode);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					  clockid_t clock_id,
+					  enum hrtimer_mode mode);
 
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
@@ -360,6 +365,14 @@ static inline void hrtimer_init_on_stack
 {
 	hrtimer_init(timer, which_clock, mode);
 }
+
+static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+						 clockid_t clock_id,
+						 enum hrtimer_mode mode)
+{
+	hrtimer_init_sleeper(sl, clock_id, mode);
+}
+
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
 
@@ -463,10 +476,8 @@ extern long hrtimer_nanosleep(const stru
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl);
-
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
-						const enum hrtimer_mode mode);
+				    const enum hrtimer_mode mode);
 extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 					  u64 delta,
 					  const enum hrtimer_mode mode,
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -488,8 +488,8 @@ do {										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_on_stack(&__t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);	\
-	hrtimer_init_sleeper(&__t);						\
+	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				      HRTIMER_MODE_REL);			\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -487,11 +487,9 @@ futex_setup_timer(ktime_t *time, struct
 	if (!time)
 		return NULL;
 
-	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
-			      CLOCK_REALTIME : CLOCK_MONOTONIC,
-			      HRTIMER_MODE_ABS);
-	hrtimer_init_sleeper(timeout);
-
+	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
+				      CLOCK_REALTIME : CLOCK_MONOTONIC,
+				      HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -427,6 +427,17 @@ void hrtimer_init_on_stack(struct hrtime
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
 
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode);
+
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
+
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -1639,11 +1650,27 @@ static enum hrtimer_restart hrtimer_wake
 	return HRTIMER_NORESTART;
 }
 
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl)
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
 {
+	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = current;
 }
+
+/**
+ * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+			  enum hrtimer_mode mode)
+{
+	debug_init(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+
+}
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
@@ -1669,8 +1696,6 @@ static int __sched do_nanosleep(struct h
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t);
-
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
@@ -1707,10 +1732,9 @@ static long __sched hrtimer_nanosleep_re
 	struct hrtimer_sleeper t;
 	int ret;
 
-	hrtimer_init_on_stack(&t.timer, restart->nanosleep.clockid,
-				HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
+				      HRTIMER_MODE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -1728,7 +1752,7 @@ long hrtimer_nanosleep(const struct time
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
 
-	hrtimer_init_on_stack(&t.timer, clockid, mode);
+	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
@@ -1927,11 +1951,8 @@ schedule_hrtimeout_range_clock(ktime_t *
 		return -EINTR;
 	}
 
-	hrtimer_init_on_stack(&t.timer, clock_id, mode);
+	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
-
-	hrtimer_init_sleeper(&t);
-
 	hrtimer_start_expires(&t.timer, mode);
 
 	if (likely(t.task))
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2156,7 +2156,7 @@ static void spin(struct pktgen_dev *pkt_
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_on_stack(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));
@@ -2170,8 +2170,6 @@ static void spin(struct pktgen_dev *pkt_
 			end_time = ktime_get();
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
-		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);


