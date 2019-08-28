Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9404C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA96D217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfH1KRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH1KQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0F-0000HM-0D; Wed, 28 Aug 2019 12:16:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BCEA31C0DE2;
        Wed, 28 Aug 2019 12:16:28 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:28 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Simplify set_process_cpu_timer()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.303316423@linutronix.de>
References: <20190821192921.303316423@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738863.5753.1896232532462251513.tip-bot2@tip-bot2>
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

Commit-ID:     1b0dd96d0f07c482bf1d04987cc1b35e376a7518
Gitweb:        https://git.kernel.org/tip/1b0dd96d0f07c482bf1d04987cc1b35e376a7518
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:36 +02:00

posix-cpu-timers: Simplify set_process_cpu_timer()

The expiry cache can now be accessed as an array. Replace the per clock
checks with a simple comparison of the clock indexed array member.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.303316423@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b132417..2c47ce6 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1174,15 +1174,15 @@ void run_posix_cpu_timers(void)
  * Set one of the process-wide special case CPU timers or RLIMIT_CPU.
  * The tsk->sighand->siglock must be held by the caller.
  */
-void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
+void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			   u64 *newval, u64 *oldval)
 {
-	u64 now;
+	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
 
-	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
+	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
 		return;
 
-	now = cpu_clock_sample_group(clock_idx, tsk, true);
+	now = cpu_clock_sample_group(clkid, tsk, true);
 
 	if (oldval) {
 		/*
@@ -1205,19 +1205,11 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	}
 
 	/*
-	 * Update expiration cache if we are the earliest timer, or eventually
-	 * RLIMIT_CPU limit is earlier than prof_exp cpu timer expire.
+	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
+	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	switch (clock_idx) {
-	case CPUCLOCK_PROF:
-		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.prof_exp, *newval))
-			tsk->signal->posix_cputimers.cputime_expires.prof_exp = *newval;
-		break;
-	case CPUCLOCK_VIRT:
-		if (expires_gt(tsk->signal->posix_cputimers.cputime_expires.virt_exp, *newval))
-			tsk->signal->posix_cputimers.cputime_expires.virt_exp = *newval;
-		break;
-	}
+	if (expires_gt(*expiry, *newval))
+		*expiry = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
