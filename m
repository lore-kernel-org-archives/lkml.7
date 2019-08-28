Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD89C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2542189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfH1KRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfH1KQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0K-0000NK-4X; Wed, 28 Aug 2019 12:16:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E181F1C0DEB;
        Wed, 28 Aug 2019 12:16:34 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove pointless comparisons
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192922.548747613@linutronix.de>
References: <20190821192922.548747613@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739482.5792.3730695065929406910.tip-bot2@tip-bot2>
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

Commit-ID:     dd6702241337bcd0bae01d2644b7bae1a496d937
Gitweb:        https://git.kernel.org/tip/dd6702241337bcd0bae01d2644b7bae1a496d937
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:42 +02:00

posix-cpu-timers: Remove pointless comparisons

The soft RLIMIT expiry code checks whether the soft limit is greater than
the hard limit. That's pointless because if the soft RLIMIT is greater than
the hard RLIMIT then that code cannot be reached as the hard RLIMIT check
is before that and already killed the process.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192922.548747613@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index dcdf9c8..115c8df 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -814,15 +814,14 @@ static void check_thread_timers(struct task_struct *tsk,
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
+
 		if (rtim >= soft) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
-			if (soft < hard) {
-				soft += USEC_PER_SEC;
-				tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur =
-					soft;
-			}
+			soft += USEC_PER_SEC;
+			tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur = soft;
+
 			if (print_fatal_signals) {
 				pr_info("RT Watchdog Timeout (soft): %s[%d]\n",
 					tsk->comm, task_pid_nr(tsk));
@@ -938,10 +937,9 @@ static void check_process_timers(struct task_struct *tsk,
 					tsk->comm, task_pid_nr(tsk));
 			}
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
-			if (soft < hard) {
-				sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
-				softns += NSEC_PER_SEC;
-			}
+
+			sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
+			softns += NSEC_PER_SEC;
 		}
 
 		/* Update the expiry cache */
