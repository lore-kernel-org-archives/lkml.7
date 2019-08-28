Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D914C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888C208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfH1KSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:18:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfH1KQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0A-0000Hl-L9; Wed, 28 Aug 2019 12:16:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34BCD1C0DE7;
        Wed, 28 Aug 2019 12:16:29 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Switch check_*_timers() to array cache
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.408222378@linutronix.de>
References: <20190821192921.408222378@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738911.5756.9860023779470771200.tip-bot2@tip-bot2>
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

Commit-ID:     c02b078e63a6f42029cb655d0aa3c991271637ac
Gitweb:        https://git.kernel.org/tip/c02b078e63a6f42029cb655d0aa3c991271637ac
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:36 +02:00

posix-cpu-timers: Switch check_*_timers() to array cache

Use the array based expiry cache in check_thread_timers() and convert the
store in check_process_timers() for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.408222378@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2c47ce6..220e3c7 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -778,8 +778,7 @@ static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
 	struct list_head *timers = tsk->posix_cputimers.cpu_timers;
-	struct task_cputime *tsk_expires = &tsk->posix_cputimers.cputime_expires;
-	u64 expires, stime, utime;
+	u64 stime, utime, *expires = tsk->posix_cputimers.expiries;
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -789,19 +788,14 @@ static void check_thread_timers(struct task_struct *tsk,
 	 * If cputime_expires is zero, then there are no active
 	 * per thread CPU timers.
 	 */
-	if (task_cputime_zero(tsk_expires))
+	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
 		return;
 
 	task_cputime(tsk, &utime, &stime);
 
-	expires = check_timers_list(timers, firing, utime + stime);
-	tsk_expires->prof_exp = expires;
-
-	expires = check_timers_list(++timers, firing, utime);
-	tsk_expires->virt_exp = expires;
-
-	tsk_expires->sched_exp = check_timers_list(++timers, firing,
-						   tsk->se.sum_exec_runtime);
+	*expires++ = check_timers_list(timers, firing, utime + stime);
+	*expires++ = check_timers_list(++timers, firing, utime);
+	*expires = check_timers_list(++timers, firing, tsk->se.sum_exec_runtime);
 
 	/*
 	 * Check for the special case thread timers.
@@ -839,7 +833,8 @@ static void check_thread_timers(struct task_struct *tsk,
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 		}
 	}
-	if (task_cputime_zero(tsk_expires))
+
+	if (task_cputime_zero(&tsk->posix_cputimers.cputime_expires))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -958,9 +953,10 @@ static void check_process_timers(struct task_struct *tsk,
 			prof_expires = x;
 	}
 
-	sig->posix_cputimers.cputime_expires.prof_exp = prof_expires;
-	sig->posix_cputimers.cputime_expires.virt_exp = virt_expires;
-	sig->posix_cputimers.cputime_expires.sched_exp = sched_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_PROF] = prof_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_VIRT] = virt_expires;
+	sig->posix_cputimers.expiries[CPUCLOCK_SCHED] = sched_expires;
+
 	if (task_cputime_zero(&sig->posix_cputimers.cputime_expires))
 		stop_process_timers(sig);
 
