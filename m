Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7946121994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbfGZTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:19:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388580AbfGZTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:01 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5jx-00019o-P5; Fri, 26 Jul 2019 21:18:53 +0200
Message-Id: <20190726185752.791885290@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 01/12] hrtimer: Remove task argument from
 hrtimer_init_sleeper()
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers hand in 'current' and that's the only task pointer which
actually makes sense. Remove the task argument and set current in the
function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 block/blk-mq.c                 |    2 +-
 drivers/staging/android/vsoc.c |    2 +-
 include/linux/hrtimer.h        |    3 +--
 include/linux/wait.h           |    2 +-
 kernel/futex.c                 |    2 +-
 kernel/time/hrtimer.c          |    8 ++++----
 net/core/pktgen.c              |    2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3418,7 +3418,7 @@ static bool blk_mq_poll_hybrid_sleep(str
 	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs, current);
+	hrtimer_init_sleeper(&hs);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -442,7 +442,7 @@ static int handle_vsoc_cond_wait(struct
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
 
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper(to);
 	}
 
 	while (1) {
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -463,8 +463,7 @@ extern long hrtimer_nanosleep(const stru
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				 struct task_struct *tsk);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl);
 
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
 						const enum hrtimer_mode mode);
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -489,7 +489,7 @@ do {										\
 	struct hrtimer_sleeper __t;						\
 										\
 	hrtimer_init_on_stack(&__t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);	\
-	hrtimer_init_sleeper(&__t, current);					\
+	hrtimer_init_sleeper(&__t);						\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -490,7 +490,7 @@ futex_setup_timer(ktime_t *time, struct
 	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
 			      CLOCK_REALTIME : CLOCK_MONOTONIC,
 			      HRTIMER_MODE_ABS);
-	hrtimer_init_sleeper(timeout, current);
+	hrtimer_init_sleeper(timeout);
 
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1639,10 +1639,10 @@ static enum hrtimer_restart hrtimer_wake
 	return HRTIMER_NORESTART;
 }
 
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl)
 {
 	sl->timer.function = hrtimer_wakeup;
-	sl->task = task;
+	sl->task = current;
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 
@@ -1669,7 +1669,7 @@ static int __sched do_nanosleep(struct h
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t, current);
+	hrtimer_init_sleeper(t);
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1930,7 +1930,7 @@ schedule_hrtimeout_range_clock(ktime_t *
 	hrtimer_init_on_stack(&t.timer, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 
-	hrtimer_init_sleeper(&t, current);
+	hrtimer_init_sleeper(&t);
 
 	hrtimer_start_expires(&t.timer, mode);
 
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2171,7 +2171,7 @@ static void spin(struct pktgen_dev *pkt_
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
 		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t, current);
+		hrtimer_init_sleeper(&t);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);


