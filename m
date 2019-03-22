Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E697420835
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCVNmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:42:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfCVNmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:42:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MDftWv599494
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 06:41:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MDfsgV599491;
        Fri, 22 Mar 2019 06:41:54 -0700
Date:   Fri, 22 Mar 2019 06:41:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d7dcf26ff0ffd7b56fe2b09ed7f1867589f3cdf1@git.kernel.org>
Cc:     bigeasy@linutronix.de, hpa@zytor.com, davem@davemloft.net,
        anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
          hpa@zytor.com, bigeasy@linutronix.de, davem@davemloft.net
In-Reply-To: <20190301224821.29843-4-bigeasy@linutronix.de>
References: <20190301224821.29843-4-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] softirq: Remove tasklet_hrtimer
Git-Commit-ID: d7dcf26ff0ffd7b56fe2b09ed7f1867589f3cdf1
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

Commit-ID:  d7dcf26ff0ffd7b56fe2b09ed7f1867589f3cdf1
Gitweb:     https://git.kernel.org/tip/d7dcf26ff0ffd7b56fe2b09ed7f1867589f3cdf1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 1 Mar 2019 23:48:21 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 14:36:02 +0100

softirq: Remove tasklet_hrtimer

There are no more users of this interface.
Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/r/20190301224821.29843-4-bigeasy@linutronix.de
---
 include/linux/interrupt.h | 25 -----------------------
 kernel/softirq.c          | 51 -----------------------------------------------
 2 files changed, 76 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 690b238a44d5..c7eef32e7739 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -668,31 +668,6 @@ extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 
-struct tasklet_hrtimer {
-	struct hrtimer		timer;
-	struct tasklet_struct	tasklet;
-	enum hrtimer_restart	(*function)(struct hrtimer *);
-};
-
-extern void
-tasklet_hrtimer_init(struct tasklet_hrtimer *ttimer,
-		     enum hrtimer_restart (*function)(struct hrtimer *),
-		     clockid_t which_clock, enum hrtimer_mode mode);
-
-static inline
-void tasklet_hrtimer_start(struct tasklet_hrtimer *ttimer, ktime_t time,
-			   const enum hrtimer_mode mode)
-{
-	hrtimer_start(&ttimer->timer, time, mode);
-}
-
-static inline
-void tasklet_hrtimer_cancel(struct tasklet_hrtimer *ttimer)
-{
-	hrtimer_cancel(&ttimer->timer);
-	tasklet_kill(&ttimer->tasklet);
-}
-
 /*
  * Autoprobing for irqs:
  *
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 10277429ed84..2c3382378d94 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -573,57 +573,6 @@ void tasklet_kill(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(tasklet_kill);
 
-/*
- * tasklet_hrtimer
- */
-
-/*
- * The trampoline is called when the hrtimer expires. It schedules a tasklet
- * to run __tasklet_hrtimer_trampoline() which in turn will call the intended
- * hrtimer callback, but from softirq context.
- */
-static enum hrtimer_restart __hrtimer_tasklet_trampoline(struct hrtimer *timer)
-{
-	struct tasklet_hrtimer *ttimer =
-		container_of(timer, struct tasklet_hrtimer, timer);
-
-	tasklet_hi_schedule(&ttimer->tasklet);
-	return HRTIMER_NORESTART;
-}
-
-/*
- * Helper function which calls the hrtimer callback from
- * tasklet/softirq context
- */
-static void __tasklet_hrtimer_trampoline(unsigned long data)
-{
-	struct tasklet_hrtimer *ttimer = (void *)data;
-	enum hrtimer_restart restart;
-
-	restart = ttimer->function(&ttimer->timer);
-	if (restart != HRTIMER_NORESTART)
-		hrtimer_restart(&ttimer->timer);
-}
-
-/**
- * tasklet_hrtimer_init - Init a tasklet/hrtimer combo for softirq callbacks
- * @ttimer:	 tasklet_hrtimer which is initialized
- * @function:	 hrtimer callback function which gets called from softirq context
- * @which_clock: clock id (CLOCK_MONOTONIC/CLOCK_REALTIME)
- * @mode:	 hrtimer mode (HRTIMER_MODE_ABS/HRTIMER_MODE_REL)
- */
-void tasklet_hrtimer_init(struct tasklet_hrtimer *ttimer,
-			  enum hrtimer_restart (*function)(struct hrtimer *),
-			  clockid_t which_clock, enum hrtimer_mode mode)
-{
-	hrtimer_init(&ttimer->timer, which_clock, mode);
-	ttimer->timer.function = __hrtimer_tasklet_trampoline;
-	tasklet_init(&ttimer->tasklet, __tasklet_hrtimer_trampoline,
-		     (unsigned long)ttimer);
-	ttimer->function = function;
-}
-EXPORT_SYMBOL_GPL(tasklet_hrtimer_init);
-
 void __init softirq_init(void)
 {
 	int cpu;
