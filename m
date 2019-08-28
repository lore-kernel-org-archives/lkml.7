Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C85C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74D12189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfH1KQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46468 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfH1KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0I-0000Mu-Ps; Wed, 28 Aug 2019 12:16:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 772F01C0DEA;
        Wed, 28 Aug 2019 12:16:34 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Get rid of 64bit divisions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.458286860@linutronix.de>
References: <20190821192922.458286860@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739440.5789.14850588211802753975.tip-bot2@tip-bot2>
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

Commit-ID:     8ea1de90a5eccdc18c8f05f8596bae8660a3ff9a
Gitweb:        https://git.kernel.org/tip/8ea1de90a5eccdc18c8f05f8596bae8660a3ff9a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:41 +02:00

posix-cpu-timers: Get rid of 64bit divisions

Instead of dividing A to match the units of B it's more efficient to
multiply B to match the units of A.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.458286860@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index caafdfd..dcdf9c8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -798,10 +798,11 @@ static void check_thread_timers(struct task_struct *tsk,
 	 */
 	soft = task_rlimit(tsk, RLIMIT_RTTIME);
 	if (soft != RLIM_INFINITY) {
+		/* Task RT timeout is accounted in jiffies. RTTIME is usec */
+		unsigned long rtim = tsk->rt.timeout * (USEC_PER_SEC / HZ);
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_RTTIME);
 
-		if (hard != RLIM_INFINITY &&
-		    tsk->rt.timeout > DIV_ROUND_UP(hard, USEC_PER_SEC/HZ)) {
+		if (hard != RLIM_INFINITY && rtim >= hard) {
 			/*
 			 * At the hard limit, we just die.
 			 * No need to calculate anything else now.
@@ -813,7 +814,7 @@ static void check_thread_timers(struct task_struct *tsk,
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
-		if (tsk->rt.timeout > DIV_ROUND_UP(soft, USEC_PER_SEC/HZ)) {
+		if (rtim >= soft) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
@@ -910,11 +911,13 @@ static void check_process_timers(struct task_struct *tsk,
 
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
-		u64 softns, ptime = samples[CPUCLOCK_PROF];
+		/* RLIMIT_CPU is in seconds. Samples are nanoseconds */
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
-		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+		u64 ptime = samples[CPUCLOCK_PROF];
+		u64 softns = (u64)soft * NSEC_PER_SEC;
+		u64 hardns = (u64)hard * NSEC_PER_SEC;
 
-		if (hard != RLIM_INFINITY && psecs >= hard) {
+		if (hard != RLIM_INFINITY && ptime >= hardns) {
 			/*
 			 * At the hard limit, we just die.
 			 * No need to calculate anything else now.
@@ -926,7 +929,7 @@ static void check_process_timers(struct task_struct *tsk,
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
-		if (psecs >= soft) {
+		if (ptime >= softns) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
@@ -936,11 +939,12 @@ static void check_process_timers(struct task_struct *tsk,
 			}
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
 			if (soft < hard) {
-				soft++;
-				sig->rlim[RLIMIT_CPU].rlim_cur = soft;
+				sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
+				softns += NSEC_PER_SEC;
 			}
 		}
-		softns = soft * NSEC_PER_SEC;
+
+		/* Update the expiry cache */
 		if (softns < pct->bases[CPUCLOCK_PROF].nextevt)
 			pct->bases[CPUCLOCK_PROF].nextevt = softns;
 	}
