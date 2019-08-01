Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB07A20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MBDk6CO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfHAS7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:59:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfHAS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:59:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71Iwt4H068311
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 11:58:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71Iwt4H068311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564685935;
        bh=Qncvp8O17aShIVNOljtXmqNUvx1zEmoHEZL0D4VK8Hw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MBDk6CO7vKqEorxVkoJC0drHqydfYpYppSiZhtV5INCan2dWsb+24LBFp7H282Jdc
         nhgNITW7aOktnos6JnvR4CqJVrjRcHf+CXnNv9/0ojDw1+RJTIRNhRIdmy9uIn5T/i
         KDHPS/q4GC1EFldT4dmMEnx8P4dInDxe+2dc4XLKyavedpBclcRl/rXLpVE9QLeK2O
         YCvSPhqHKP1Rl3ZtlVWp/8wsGsnb+qDXMO5Clvx1uk7Sg5CXyGy/hUO2PAI6Amz1PM
         5KFkRciR+xP03tLGPzBhuUA/x8YglWUjZTT1yJ2CxLH/mxuSOU8UyMueUZxZatMbZH
         gsd5CQzjP6Tog==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71Iwstu068307;
        Thu, 1 Aug 2019 11:58:54 -0700
Date:   Thu, 1 Aug 2019 11:58:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-d5096aa65acd0ef2d18ac8247260ab4481ade399@git.kernel.org>
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190726185753.077004842@linutronix.de>
References: <20190726185753.077004842@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched: Mark hrtimers to expire in hard interrupt
 context
Git-Commit-ID: d5096aa65acd0ef2d18ac8247260ab4481ade399
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d5096aa65acd0ef2d18ac8247260ab4481ade399
Gitweb:     https://git.kernel.org/tip/d5096aa65acd0ef2d18ac8247260ab4481ade399
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:19 +0200

sched: Mark hrtimers to expire in hard interrupt context

The scheduler related hrtimers need to expire in hard interrupt context
even on PREEMPT_RT enabled kernels. Mark then as such.

No functional change.

[ tglx: Split out from larger combo patch. Add changelog. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.077004842@linutronix.de



---
 kernel/sched/core.c     | 6 +++---
 kernel/sched/deadline.c | 4 ++--
 kernel/sched/rt.c       | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..389e0993fbb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -255,7 +255,7 @@ static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
 
-	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 /*
@@ -314,7 +314,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 */
 	delay = max_t(u64, delay, 10000LL);
 	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 #endif /* CONFIG_SMP */
 
@@ -328,7 +328,7 @@ static void hrtick_rq_init(struct rq *rq)
 	rq->hrtick_csd.info = rq;
 #endif
 
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
 #else	/* CONFIG_SCHED_HRTICK */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..0359612d5443 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -923,7 +923,7 @@ static int start_dl_timer(struct task_struct *p)
 	 */
 	if (!hrtimer_is_queued(timer)) {
 		get_task_struct(p);
-		hrtimer_start(timer, act, HRTIMER_MODE_ABS);
+		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
@@ -1053,7 +1053,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = dl_task_timer;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..da3e85e61013 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -45,8 +45,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
 
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
 
-	hrtimer_init(&rt_b->rt_period_timer,
-			CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_HARD);
 	rt_b->rt_period_timer.function = sched_rt_period_timer;
 }
 
@@ -67,7 +67,8 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 		 * to update the period.
 		 */
 		hrtimer_forward_now(&rt_b->rt_period_timer, ns_to_ktime(0));
-		hrtimer_start_expires(&rt_b->rt_period_timer, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(&rt_b->rt_period_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
 	}
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
