Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B0208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="r55AwMo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfE1UXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:23:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1UXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:23:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SKMXbN2218182
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 13:22:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SKMXbN2218182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559074954;
        bh=QwhIhPchHY4JDzdo/Kdl6T8Xb9DK0fGxJgtnfhiwEbo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=r55AwMo4Cf8fnyw3IIPjcHb0CEbcoMlw8EsayvDizfct49AZ49Type1a2jtDGjPGD
         zFcQ1rA5wNSCE8+0dep6n5e0Yq/ChtDIwkhbj8xNyuekWAY/ehl4jnhRtwuWIE21tm
         ZeIpREUc474/tWDMp8X/Hq8OLfQmt/hXJhhOOC2KD92cRuzyYVOhpjKGWzqvFW81UM
         Y4ZSPgpzHzkOxuNX7cF7IzqmjA7Lyi2ahoPUzd3d0hPrb+Jadua7ACZWAEDch683z/
         0U7QeKy8GR2P20H1WmAOQ7Tag2+0b1Z8WxysT9DxfRJkYsLSwWShwb31bquuGBk3Ib
         8SPlQAr3XleTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SKMXJZ2218179;
        Tue, 28 May 2019 13:22:33 -0700
Date:   Tue, 28 May 2019 13:22:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-5ca584d935c32906d114924dc0e1dbfcbb13fdb2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, dvhart@infradead.org,
        longman@redhat.com, dave@stgolabs.net
Reply-To: dave@stgolabs.net, longman@redhat.com, dvhart@infradead.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190528160345.24017-1-longman@redhat.com>
References: <20190528160345.24017-1-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] futex: Consolidate duplicated timer setup code
Git-Commit-ID: 5ca584d935c32906d114924dc0e1dbfcbb13fdb2
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

Commit-ID:  5ca584d935c32906d114924dc0e1dbfcbb13fdb2
Gitweb:     https://git.kernel.org/tip/5ca584d935c32906d114924dc0e1dbfcbb13fdb2
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 28 May 2019 12:03:45 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 28 May 2019 11:12:00 -0700

futex: Consolidate duplicated timer setup code

Add a new futex_setup_timer() helper function to consolidate all the
hrtimer_sleeper setup code.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lkml.kernel.org/r/20190528160345.24017-1-longman@redhat.com

---
 kernel/futex.c | 69 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 2268b97d5439..49bf20a8c512 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -483,6 +483,37 @@ enum futex_access {
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
@@ -2692,7 +2723,7 @@ out:
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
@@ -2702,17 +2733,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
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
@@ -2792,7 +2814,7 @@ static long futex_wait_restart(struct restart_block *restart)
 static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 ktime_t *time, int trylock)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
@@ -2805,13 +2827,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -3208,7 +3224,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 				 u32 val, ktime_t *abs_time, u32 bitset,
 				 u32 __user *uaddr2)
 {
-	struct hrtimer_sleeper timeout, *to = NULL;
+	struct hrtimer_sleeper timeout, *to;
 	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
@@ -3225,15 +3241,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
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
