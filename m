Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD40C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A89123404
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbfHWCMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389300AbfHWCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3n-0000wA-45; Fri, 23 Aug 2019 04:12:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C578E1C0883;
        Fri, 23 Aug 2019 04:12:14 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:14 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Sanitize bogus WARNONS
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190819143801.846497772@linutronix.de>
References: <20190819143801.846497772@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633476.11645.833680996843703655.tip-bot2@tip-bot2>
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

Commit-ID:     692117c1f7a6770ed41dd8f277cd9fed1dfb16f1
Gitweb:        https://git.kernel.org/tip/692117c1f7a6770ed41dd8f277cd9fed1dfb16f1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 Aug 2019 16:31:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Aug 2019 20:27:15 +02:00

posix-cpu-timers: Sanitize bogus WARNONS

Warning when p == NULL and then proceeding and dereferencing p does not
make any sense as the kernel will crash with a NULL pointer dereference
right away.

Bailing out when p == NULL and returning an error code does not cure the
underlying problem which caused p to be NULL. Though it might allow to
do proper debugging.

Same applies to the clock id check in set_process_cpu_timer().

Clean them up and make them return without trying to do further damage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.846497772@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 742d4a4..98223d2 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -375,7 +375,8 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	struct sighand_struct *sighand;
 	struct task_struct *p = timer->it.cpu.task;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Protect against sighand release/switch in exit/exec and process/
@@ -581,7 +582,8 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	u64 old_expires, new_expires, old_incr, val;
 	int ret;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -716,10 +718,11 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
 {
-	u64 now;
 	struct task_struct *p = timer->it.cpu.task;
+	u64 now;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Easy part: convert the reload time.
@@ -1001,12 +1004,13 @@ static void check_process_timers(struct task_struct *tsk,
  */
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
+	struct task_struct *p = timer->it.cpu.task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
-	struct task_struct *p = timer->it.cpu.task;
 	u64 now;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -1203,7 +1207,9 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	u64 now;
 	int ret;
 
-	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
+	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
+		return;
+
 	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
 
 	if (oldval && ret != -EINVAL) {
