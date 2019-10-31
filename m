Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A3CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6C521835
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfJaLzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfJaLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92q-00036q-MT; Thu, 31 Oct 2019 12:55:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C67A31C04DD;
        Thu, 31 Oct 2019 12:55:08 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:08 -0000
From:   "tip-bot2 for Ethan Hansen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove unused variable rcu_perf_writer_state
Cc:     Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290845.29376.5219527334083036042.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b3ffb206ddd7f07d83bafd10e1b403df57055af4
Gitweb:        https://git.kernel.org/tip/b3ffb206ddd7f07d83bafd10e1b403df57055af4
Author:        Ethan Hansen <1ethanhansen@gmail.com>
AuthorDate:    Wed, 07 Aug 2019 17:27:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:49:36 -07:00

rcu: Remove unused variable rcu_perf_writer_state

The variable rcu_perf_writer_state is declared and initialized,
but is never actually referenced. Remove it to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
[ paulmck: Also removed unused macros assigned to that variable. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 5a879d0..5f884d5 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -109,15 +109,6 @@ static unsigned long b_rcu_perf_writer_started;
 static unsigned long b_rcu_perf_writer_finished;
 static DEFINE_PER_CPU(atomic_t, n_async_inflight);
 
-static int rcu_perf_writer_state;
-#define RTWS_INIT		0
-#define RTWS_ASYNC		1
-#define RTWS_BARRIER		2
-#define RTWS_EXP_SYNC		3
-#define RTWS_SYNC		4
-#define RTWS_IDLE		5
-#define RTWS_STOPPING		6
-
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
 
@@ -404,25 +395,20 @@ retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
-				rcu_perf_writer_state = RTWS_ASYNC;
 				atomic_inc(this_cpu_ptr(&n_async_inflight));
 				cur_ops->async(rhp, rcu_perf_async_cb);
 				rhp = NULL;
 			} else if (!kthread_should_stop()) {
-				rcu_perf_writer_state = RTWS_BARRIER;
 				cur_ops->gp_barrier();
 				goto retry;
 			} else {
 				kfree(rhp); /* Because we are stopping. */
 			}
 		} else if (gp_exp) {
-			rcu_perf_writer_state = RTWS_EXP_SYNC;
 			cur_ops->exp_sync();
 		} else {
-			rcu_perf_writer_state = RTWS_SYNC;
 			cur_ops->sync();
 		}
-		rcu_perf_writer_state = RTWS_IDLE;
 		t = ktime_get_mono_fast_ns();
 		*wdp = t - *wdp;
 		i_max = i;
@@ -463,10 +449,8 @@ retry:
 		rcu_perf_wait_shutdown();
 	} while (!torture_must_stop());
 	if (gp_async) {
-		rcu_perf_writer_state = RTWS_BARRIER;
 		cur_ops->gp_barrier();
 	}
-	rcu_perf_writer_state = RTWS_STOPPING;
 	writer_n_durations[me] = i_max;
 	torture_kthread_stopping("rcu_perf_writer");
 	return 0;
