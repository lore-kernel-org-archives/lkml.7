Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE40205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RiwStQQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfG3WI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:08:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58043 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbfG3WI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:08:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UM88LL3397651
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:08:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UM88LL3397651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524489;
        bh=XyaoS+L4Hsa701vCZzzeiBcqJKmBhh32OUQswa1MGDo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RiwStQQCdoxfcVlwP+XM6ZiJl8/N4RxeMmBA/R4VclPhhItBuJoAXNk5J+kCYmuGO
         XHAe2yZGgDaecjusrXFaFu+tyhv9KNRbs6jT/4eC+EvJNF2iqGJeHCNmAKfGvlhc76
         rafQC/2EmOAJqaknqIZBdTdYJfh/+V55Eim+NOiY9Jr66K+2pp2fFoE1pBvlE9nQWv
         yL0J1hLDzmRRXyc4Cwy6vCeeYxaG9eX97g5RsgQvJqO3Iui74zu373kdQWUYgag+/X
         rMrXJzLLyZRHqGbW/0WoPMzGcXybmT3BbmwITr3PnF0Sf5PZ1wafR3cWONXTKSdiXO
         /pu1N9JV3Qo+g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UM87O93397648;
        Tue, 30 Jul 2019 15:08:07 -0700
Date:   Tue, 30 Jul 2019 15:08:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-82e18bace3dd3fe4d594b9a2915035f09a3deb55@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de,
        anna-maria@linutronix.de, peterz@infradead.org
Reply-To: bigeasy@linutronix.de, anna-maria@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190726185752.887468908@linutronix.de>
References: <20190726185752.887468908@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Consolidate hrtimer_init() +
 hrtimer_init_sleeper() calls
Git-Commit-ID: 82e18bace3dd3fe4d594b9a2915035f09a3deb55
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

Commit-ID:  82e18bace3dd3fe4d594b9a2915035f09a3deb55
Gitweb:     https://git.kernel.org/tip/82e18bace3dd3fe4d594b9a2915035f09a3deb55
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:51 +0200

hrtimer: Consolidate hrtimer_init() + hrtimer_init_sleeper() calls

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185752.887468908@linutronix.de
---
 block/blk-mq.c                 |  3 +--
 drivers/staging/android/vsoc.c |  6 ++----
 include/linux/hrtimer.h        | 17 ++++++++++++++---
 include/linux/wait.h           |  4 ++--
 kernel/futex.c                 |  8 +++-----
 kernel/time/hrtimer.c          | 43 +++++++++++++++++++++++++++++++-----------
 net/core/pktgen.c              |  4 +---
 7 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5f647cb8c695..df3fafbfe9a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3415,10 +3415,9 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index ce480bcf20d2..628c06096dfd 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -437,12 +437,10 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
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
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 3c74f89367c4..0df373bed3d7 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -347,10 +347,15 @@ DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
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
@@ -360,6 +365,14 @@ static inline void hrtimer_init_on_stack(struct hrtimer *timer,
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
 
@@ -463,10 +476,8 @@ extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
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
diff --git a/include/linux/wait.h b/include/linux/wait.h
index d57832774ca6..4707543ef575 100644
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
diff --git a/kernel/futex.c b/kernel/futex.c
index 5e9842ea4012..c8561aa5338e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -487,11 +487,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index de895d86800c..bb55d62f631e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -427,6 +427,17 @@ void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
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
@@ -1639,11 +1650,27 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
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
@@ -1669,8 +1696,6 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t);
-
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
@@ -1707,10 +1732,9 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
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
@@ -1728,7 +1752,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
 
-	hrtimer_init_on_stack(&t.timer, clockid, mode);
+	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
@@ -1927,11 +1951,8 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
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
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f3cf2381f27..a5905975bc12 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2156,7 +2156,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_on_stack(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));
@@ -2170,8 +2170,6 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 			end_time = ktime_get();
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
-		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);
