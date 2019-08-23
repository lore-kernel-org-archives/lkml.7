Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC466C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F3223405
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfHWCMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389361AbfHWCMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3p-0000xy-Px; Fri, 23 Aug 2019 04:12:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 791A11C0883;
        Fri, 23 Aug 2019 04:12:17 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:17 -0000
From:   tip-bot2 for Frederic Weisbecker <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Improve comments on handling priority
 inversion against softirq
 kthread
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
In-Reply-To: <20190820132656.GC2093@lenoir>
References: <20190820132656.GC2093@lenoir>
MIME-Version: 1.0
Message-ID: <156652633741.11664.5398841645445804148.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0bee3b601b77dbe7981b5474ae8758d6bf60177a
Gitweb:        https://git.kernel.org/tip/0bee3b601b77dbe7981b5474ae8758d6bf60177a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 20 Aug 2019 15:12:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2019 22:05:46 +02:00

hrtimer: Improve comments on handling priority inversion against softirq kthread

The handling of a priority inversion between timer cancelling and a a not
well defined possible preemption of softirq kthread is not very clear.

Especially in the posix timers side it's unclear why there is a specific RT
wait callback.

All the nice explanations can be found in the initial changelog of
f61eff83cec9 (hrtimer: Prepare support for PREEMPT_RT").

Extract the detailed informations from there and put it into comments.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190820132656.GC2093@lenoir
---
 kernel/time/hrtimer.c      | 14 ++++++++++----
 kernel/time/posix-timers.c |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4991227..8333537 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1201,10 +1201,16 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
  * deletion of a timer failed because the timer callback function was
  * running.
  *
- * This prevents priority inversion, if the softirq thread on a remote CPU
- * got preempted, and it prevents a life lock when the task which tries to
- * delete a timer preempted the softirq thread running the timer callback
- * function.
+ * This prevents priority inversion: if the soft irq thread is preempted
+ * in the middle of a timer callback, then calling del_timer_sync() can
+ * lead to two issues:
+ *
+ *  - If the caller is on a remote CPU then it has to spin wait for the timer
+ *    handler to complete. This can result in unbound priority inversion.
+ *
+ *  - If the caller originates from the task which preempted the timer
+ *    handler on the same CPU, then spin waiting for the timer handler to
+ *    complete is never going to end.
  */
 void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 9e37783..0ec5b7a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -810,6 +810,12 @@ static void common_timer_wait_running(struct k_itimer *timer)
 	hrtimer_cancel_wait_running(&timer->it.real.timer);
 }
 
+/*
+ * On PREEMPT_RT this prevent priority inversion against softirq kthread in
+ * case it gets preempted while executing a timer callback. See comments in
+ * hrtimer_cancel_wait_running. For PREEMPT_RT=n this just results in a
+ * cpu_relax().
+ */
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
