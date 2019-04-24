Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859AC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbfDXSEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45307 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388657AbfDXRTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0DEC5411A;
        Wed, 24 Apr 2019 17:19:35 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2A275D9CD;
        Wed, 24 Apr 2019 17:19:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] futex: Consolidate duplicated timer setup code
Date:   Wed, 24 Apr 2019 13:19:15 -0400
Message-Id: <20190424171915.24627-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Apr 2019 17:19:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new futex_setup_timer() helper function is added to consolidate all
the hrtimer_sleeper setup code.

 v2: Use only hrtimer_set_expires_range_ns().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/futex.c | 69 ++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a0514e01c3eb..23b0e1830461 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -486,6 +486,37 @@ enum futex_access {
 	FUTEX_WRITE
 };
 
+/**
+ * futex_setup_timer - set up the sleeping hrtimer.
+ * @time:	ptr to the given timeout value
+ * @timeout:	the hrtimer_sleeper structure to be set up
+ * @flags:	futex flags
+ * @range_ns:	optional range in ns
+ *
+ * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
+ *	   value given
+ */
+static inline struct hrtimer_sleeper *
+futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+		  int flags, u64 range_ns)
+{
+	if (!time)
+		return NULL;
+
+	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
+			      CLOCK_REALTIME : CLOCK_MONOTONIC,
+			      HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper(timeout, current);
+
+	/*
+	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
+	 * effectively the same as calling hrtimer_set_expires().
+	 */
+	hrtimer_set_expires_range_ns(&timeout->timer, *time, range_ns);
+
+	return timeout;
+}
+
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
@@ -2679,7 +2710,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
@@ -2689,17 +2720,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		return -EINVAL;
 	q.bitset = bitset;
 
-	if (abs_time) {
-		to = &timeout;
-
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
-		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
-					     current->timer_slack_ns);
-	}
-
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
 retry:
 	/*
 	 * Prepare to wait on uaddr. On success, holds hb lock and increments
@@ -2779,7 +2801,7 @@ static long futex_wait_restart(struct restart_block *restart)
 static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 ktime_t *time, int trylock)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
@@ -2792,13 +2814,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	if (refill_pi_state_cache())
 		return -ENOMEM;
 
-	if (time) {
-		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, CLOCK_REALTIME,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
-		hrtimer_set_expires(&to->timer, *time);
-	}
+	to = futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);
 
 retry:
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
@@ -3182,7 +3198,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 				 u32 val, ktime_t *abs_time, u32 bitset,
 				 u32 __user *uaddr2)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
@@ -3199,15 +3215,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	if (!bitset)
 		return -EINVAL;
 
-	if (abs_time) {
-		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
-		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
-					     current->timer_slack_ns);
-	}
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
 
 	/*
 	 * The waiter is allocated on our stack, manipulated by the requeue
-- 
2.18.1

