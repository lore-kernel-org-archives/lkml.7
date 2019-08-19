Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfHSPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:46:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47807 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfHSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqy-00072A-IM; Mon, 19 Aug 2019 17:45:52 +0200
Message-Id: <20190819143805.114825587@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 39/44] posix-cpu-timers: Get rid of 64bit divisions
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of dividing A to match the units of B it's more efficient to
multiply B to match the units of A.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -791,10 +791,11 @@ static void check_thread_timers(struct t
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
@@ -806,7 +807,7 @@ static void check_thread_timers(struct t
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
-		if (tsk->rt.timeout > DIV_ROUND_UP(soft, USEC_PER_SEC/HZ)) {
+		if (rtim >= soft) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
@@ -901,11 +902,13 @@ static void check_process_timers(struct
 
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
+		/* RLIMIT_CPU is in seconds. Samples are nanoseconds */
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
-		u64 softns, ptime = samples[CPUCLOCK_PROF];
-		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+		u64 ptime = samples[CPUCLOCK_PROF];
+		u64 softns = (u64)soft * NSEC_PER_SEC;
+		u64 hardns = (u64)hard * NSEC_PER_SEC;
 
-		if (hard != RLIM_INFINITY && psecs >= hard) {
+		if (hard != RLIM_INFINITY && ptime >= hardns) {
 			/*
 			 * At the hard limit, we just die.
 			 * No need to calculate anything else now.
@@ -917,7 +920,7 @@ static void check_process_timers(struct
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
-		if (psecs >= soft) {
+		if (ptime >= softns) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
@@ -931,7 +934,8 @@ static void check_process_timers(struct
 				sig->rlim[RLIMIT_CPU].rlim_cur = soft;
 			}
 		}
-		softns = soft * NSEC_PER_SEC;
+
+		/* Update the expiry cache */
 		if (softns < exp[CPUCLOCK_PROF])
 			exp[CPUCLOCK_PROF] = softns;
 	}


