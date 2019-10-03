Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F56AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65864222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067265;
	bh=yIBjfYOEPsz/21qdYEvppUqb2W8DmvJA4e/0lsedspA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLsuUiPz0CuBECps2xQYy+faHv2TpTuC7b6pHdI6/kvWjU0W0TjZnxRShwvT2uaaZ
	 GPr81ZQNs4s+0tmYqQ7Gb9LhbkH+SMTG2lpxex4+3TXehYlkCvzZOcmKH2zqUpokcQ
	 iFR+Q85ejkded+N3pmnKFJ/6l844MXT1deCK65qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJCBre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfJCBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26CC222C9;
        Thu,  3 Oct 2019 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067252;
        bh=yIBjfYOEPsz/21qdYEvppUqb2W8DmvJA4e/0lsedspA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5hkVVUsIsfMwE7PphqQTi1wL6wV1QLfD829shr/jZpRfezv2LP7oetf4dC6U7pkD
         RhhLPEJqtbIVEZZAtABIA5EJqz5onrYsHXDZyvwc9znz18Rk2QG5Po9Rd+JrYK1KWt
         hrrLPdULeqSC7ytEvRkV6XxyUSIS+SPT5anDQ+Ow=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 5/9] rcu: Remove unused variable rcu_perf_writer_state
Date:   Wed,  2 Oct 2019 18:47:24 -0700
Message-Id: <20191003014728.13496-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Hansen <1ethanhansen@gmail.com>

The variable rcu_perf_writer_state is declared and initialized,
but is never actually referenced. Remove it to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
[ ethansen: Also removed unused macros assigned to that variable. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
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
 
@@ -404,25 +395,20 @@ rcu_perf_writer(void *arg)
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
@@ -463,10 +449,8 @@ rcu_perf_writer(void *arg)
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
-- 
2.9.5

