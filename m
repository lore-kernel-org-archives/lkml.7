Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8482923405
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1KQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1KQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2uzz-0000AQ-T3; Wed, 28 Aug 2019 12:16:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 830F01C0DE2;
        Wed, 28 Aug 2019 12:16:19 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Use common permission check in
 posix_cpu_clock_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.414813172@linutronix.de>
References: <20190821192919.414813172@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bfcf3e92c6c07cd1084624bad5622f3dad96328c
Gitweb:        https://git.kernel.org/tip/bfcf3e92c6c07cd1084624bad5622f3dad96328c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:25 +02:00

posix-cpu-timers: Use common permission check in posix_cpu_clock_get()

Replace the next slightly different copy of permission checks. That also
removes the necessarity to check the return value of the sample functions
because the clock id is already validated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.414813172@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 57 ++++++++-------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b06ed8b..eb11117 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -289,53 +289,24 @@ static int cpu_clock_sample_group(const clockid_t which_clock,
 	return 0;
 }
 
-static int posix_cpu_clock_get_task(struct task_struct *tsk,
-				    const clockid_t which_clock,
-				    struct timespec64 *tp)
+static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 {
-	int err = -EINVAL;
-	u64 rtn;
-
-	if (CPUCLOCK_PERTHREAD(which_clock)) {
-		if (same_thread_group(tsk, current))
-			err = cpu_clock_sample(which_clock, tsk, &rtn);
-	} else {
-		if (tsk == current || thread_group_leader(tsk))
-			err = cpu_clock_sample_group(which_clock, tsk, &rtn);
-	}
-
-	if (!err)
-		*tp = ns_to_timespec64(rtn);
+	const clockid_t clkid = CPUCLOCK_WHICH(clock);
+	struct task_struct *tsk;
+	u64 t;
 
-	return err;
-}
-
-
-static int posix_cpu_clock_get(const clockid_t which_clock, struct timespec64 *tp)
-{
-	const pid_t pid = CPUCLOCK_PID(which_clock);
-	int err = -EINVAL;
+	tsk = get_task_for_clock(clock);
+	if (!tsk)
+		return -EINVAL;
 
-	if (pid == 0) {
-		/*
-		 * Special case constant value for our own clocks.
-		 * We don't have to do any lookup to find ourselves.
-		 */
-		err = posix_cpu_clock_get_task(current, which_clock, tp);
-	} else {
-		/*
-		 * Find the given PID, and validate that the caller
-		 * should be able to see it.
-		 */
-		struct task_struct *p;
-		rcu_read_lock();
-		p = find_task_by_vpid(pid);
-		if (p)
-			err = posix_cpu_clock_get_task(p, which_clock, tp);
-		rcu_read_unlock();
-	}
+	if (CPUCLOCK_PERTHREAD(clock))
+		cpu_clock_sample(clkid, tsk, &t);
+	else
+		cpu_clock_sample_group(clkid, tsk, &t);
+	put_task_struct(tsk);
 
-	return err;
+	*tp = ns_to_timespec64(t);
+	return 0;
 }
 
 /*
