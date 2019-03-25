Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73065C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319412085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfCYOBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:01:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45954 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfCYOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:01:52 -0400
Received: from [5.158.153.52] (helo=somnus.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h8QAd-00064O-Nl; Mon, 25 Mar 2019 15:01:47 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v3] hrtimer: Consolidate hrtimer_init() + hrtimer_init_sleeper() calls
Date:   Mon, 25 Mar 2019 15:01:20 +0100
Message-Id: <20190325140120.16030-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hrtimer_init_sleeper() calls require a prior initialisation of the
hrtimer object with hrtimer_init(). Lets make the initialisation of
the hrtimer object part of hrtimer_init_sleeper(). To remain
consistent consider init_on_stack as well.

Beside adapting the hrtimer_init_sleeper[_on_stack]() functions, call
sites need to be updated as well.

Link: http://lkml.kernel.org/r/20180703092541.2870-1-anna-maria@linutronix.de
[anna-maria: Updating the commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
v2..v3: Update to current version

v1..v2: Fix missing call site in drivers/staging/android/vsoc.c

 block/blk-mq.c                 |  3 +--
 drivers/staging/android/vsoc.c |  6 ++---
 include/linux/hrtimer.h        | 19 +++++++++++---
 include/linux/wait.h           |  4 +--
 kernel/futex.c                 | 19 ++++++--------
 kernel/time/hrtimer.c          | 46 ++++++++++++++++++++++++++--------
 net/core/pktgen.c              |  4 +--
 7 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70b210a308c4..f378e2f8ec2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3365,10 +3365,9 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode, current);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs, current);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 8a75bd27c413..27daa8ae56a4 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -436,12 +436,10 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
 
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
 	}
 
 	while (1) {
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..f669dc5b63e7 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -361,10 +361,17 @@ DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+				 enum hrtimer_mode mode,
+				 struct task_struct *task);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					  clockid_t clock_id,
+					  enum hrtimer_mode mode,
+					  struct task_struct *task);
 
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
@@ -374,6 +381,15 @@ static inline void hrtimer_init_on_stack(struct hrtimer *timer,
 {
 	hrtimer_init(timer, which_clock, mode);
 }
+
+static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					    clockid_t clock_id,
+					    enum hrtimer_mode mode,
+					    struct task_struct *task)
+{
+	hrtimer_init_sleeper(sl, clock_id, mode, task);
+}
+
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
 
@@ -477,9 +493,6 @@ extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				 struct task_struct *tsk);
-
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
 						const enum hrtimer_mode mode);
 extern int schedule_hrtimeout_range_clock(ktime_t *expires,
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5f3efabc36f4..671e8ceaac15 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -488,8 +488,8 @@ do {										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_on_stack(&__t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);	\
-	hrtimer_init_sleeper(&__t, current);					\
+	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC, HRTIMER_MODE_REL,	\
+				      current);					\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
diff --git a/kernel/futex.c b/kernel/futex.c
index 9e40cf7be606..05e1f4333844 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2688,10 +2688,9 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (abs_time) {
 		to = &timeout;
 
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, (flags & FLAGS_CLOCKRT) ?
+					      CLOCK_REALTIME : CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
 					     current->timer_slack_ns);
 	}
@@ -2790,9 +2789,8 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 
 	if (time) {
 		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, CLOCK_REALTIME,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_REALTIME,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires(&to->timer, *time);
 	}
 
@@ -3197,10 +3195,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 
 	if (abs_time) {
 		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, (flags & FLAGS_CLOCKRT) ?
+					      CLOCK_REALTIME : CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
 					     current->timer_slack_ns);
 	}
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff23c1f9..d7d2d7217c69 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1639,13 +1639,44 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id,
+				   enum hrtimer_mode mode,
+				   struct task_struct *task)
 {
+	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
 }
+
+/**
+ * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ * @task:	the task to wake up
+ */
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+			  enum hrtimer_mode mode, struct task_struct *task)
+{
+	debug_init(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode, task);
+
+}
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id,
+				   enum hrtimer_mode mode,
+				   struct task_struct *task)
+{
+	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
+	__hrtimer_init_sleeper(sl, clock_id, mode, task);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
+#endif
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
@@ -1669,8 +1700,6 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t, current);
-
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
@@ -1707,10 +1736,9 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
 
-	hrtimer_init_on_stack(&t.timer, restart->nanosleep.clockid,
-				HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
+				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -1728,7 +1756,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
 
-	hrtimer_init_on_stack(&t.timer, clockid, mode);
+	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
@@ -1927,11 +1955,9 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	hrtimer_init_on_stack(&t.timer, clock_id, mode);
+	hrtimer_init_sleeper_on_stack(&t, clock_id, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 
-	hrtimer_init_sleeper(&t, current);
-
 	hrtimer_start_expires(&t.timer, mode);
 
 	if (likely(t.task))
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f3f5a78cd062..01a11ba42114 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2161,7 +2161,8 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_on_stack(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS,
+				      current);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));
@@ -2176,7 +2177,6 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
 		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t, current);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);
-- 
2.20.1

