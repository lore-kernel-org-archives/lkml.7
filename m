Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4341A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QpZtbDm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfG3WI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:08:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbfG3WIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:08:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UM7O7l3397620
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:07:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UM7O7l3397620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524445;
        bh=rMVyzwby2dJLMkp3euakC/pPTa7nG7wh4ryLVe7XIx0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QpZtbDm5mrFjKlHnda02ILpGx7J/IxTPbo/QkFuDzdsoL0P6jfpsfLF5iY3/8poP9
         ppPMeerPybdpvLGIfVWD62jgh47mAmoRUpOgyIDLF6Xr8UZKnYaUdRe71fmJBhWQkW
         UBy7d8qyxi/dhC1vEUvMd8THiTXlYrTvNh+Kls8bZZM3xyKZc/W/i8WFXb19waKn7R
         7cLHl1cciuOofTutyGSWd1u21jTlgUt3Vaqt2jIkOyhHZnhuSG4Lpx668s87Ne3Dtt
         0JDj2QCBCAW21IvaFLvoPHWcGQdlhDAV/yoNlE+TMh5TUE+Dj53uYH/yPiThmEIdt6
         L8rgL0JfVqGGg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UM7Ouj3397617;
        Tue, 30 Jul 2019 15:07:24 -0700
Date:   Tue, 30 Jul 2019 15:07:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b74494872555d1f7888dfd9225700a363f4a84fc@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, rostedt@goodmis.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190726185752.791885290@linutronix.de>
References: <20190726185752.791885290@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Remove task argument from
 hrtimer_init_sleeper()
Git-Commit-ID: b74494872555d1f7888dfd9225700a363f4a84fc
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

Commit-ID:  b74494872555d1f7888dfd9225700a363f4a84fc
Gitweb:     https://git.kernel.org/tip/b74494872555d1f7888dfd9225700a363f4a84fc
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:51 +0200

hrtimer: Remove task argument from hrtimer_init_sleeper()

All callers hand in 'current' and that's the only task pointer which
actually makes sense. Remove the task argument and set current in the
function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185752.791885290@linutronix.de

---
 block/blk-mq.c                 | 2 +-
 drivers/staging/android/vsoc.c | 2 +-
 include/linux/hrtimer.h        | 3 +--
 include/linux/wait.h           | 2 +-
 kernel/futex.c                 | 2 +-
 kernel/time/hrtimer.c          | 8 ++++----
 net/core/pktgen.c              | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..5f647cb8c695 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3418,7 +3418,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs, current);
+	hrtimer_init_sleeper(&hs);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 00a1ec7b9154..ce480bcf20d2 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -442,7 +442,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
 
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper(to);
 	}
 
 	while (1) {
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4971100a8cab..3c74f89367c4 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -463,8 +463,7 @@ extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				 struct task_struct *tsk);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl);
 
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
 						const enum hrtimer_mode mode);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b6f77cf60dd7..d57832774ca6 100644
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
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..5e9842ea4012 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -490,7 +490,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
 			      CLOCK_REALTIME : CLOCK_MONOTONIC,
 			      HRTIMER_MODE_ABS);
-	hrtimer_init_sleeper(timeout, current);
+	hrtimer_init_sleeper(timeout);
 
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5ee77f1a8a92..de895d86800c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1639,10 +1639,10 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
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
 
@@ -1669,7 +1669,7 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t, current);
+	hrtimer_init_sleeper(t);
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1930,7 +1930,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	hrtimer_init_on_stack(&t.timer, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 
-	hrtimer_init_sleeper(&t, current);
+	hrtimer_init_sleeper(&t);
 
 	hrtimer_start_expires(&t.timer, mode);
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index bb9915291644..7f3cf2381f27 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2171,7 +2171,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
 		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t, current);
+		hrtimer_init_sleeper(&t);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);
