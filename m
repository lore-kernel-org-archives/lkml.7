Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC14C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0820B24656
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949365;
	bh=AWeg2RjnPQtVutO9UvRJfTLtgkGJZ9+nEI0LkLwBsKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVLQyHuy5CEkcAfHb54YoleLEPzZdnZH729KyHTiIL2PSsWWfbA3ACyhvB5MOVHPS
	 oJ5+loTi8mmx1wON4aubQoDdyU1XPgYY7NaxV04kLCpe3jukETgKOlXpkqyEfRstMW
	 xjjR83lGG22L2DZxMunM5ZeWcEMb01wM0CloT02w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfLJDm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfLJDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:25 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D5F2077B;
        Tue, 10 Dec 2019 03:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949344;
        bh=AWeg2RjnPQtVutO9UvRJfTLtgkGJZ9+nEI0LkLwBsKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APnBeJKVLfaOwZ7O1MgljAXxBvkdQoWPXn6E0WvzyotBaRkTMGPgeODnv/JityZ2r
         RauFBhoL4BYiWEQCnXEpqbmMba94a5uUalQjARdBk/uT+U/noOLKnHWX8mLLPdI19p
         4k700dejgWr+siFSTBxV3myEi3KQm2LjQWBAz/+s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/12] rcutorture: Pull callback forward-progress data into rcu_fwd struct
Date:   Mon,  9 Dec 2019 19:42:11 -0800
Message-Id: <20191210034217.405-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that RCU behaves reasonably well with the current single-kthread
call_rcu() forward-progress testing, it is time to add more kthreads.
This commit takes a first step towards that goal by wrapping what
will be the per-kthread data into a new rcu_fwd structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 103 +++++++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dee043f..22a75a4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1663,23 +1663,34 @@ struct rcu_fwd_cb {
 	struct rcu_fwd_cb *rfc_next;
 	int rfc_gps;
 };
-static DEFINE_SPINLOCK(rcu_fwd_lock);
-static struct rcu_fwd_cb *rcu_fwd_cb_head;
-static struct rcu_fwd_cb **rcu_fwd_cb_tail = &rcu_fwd_cb_head;
-static long n_launders_cb;
-static unsigned long rcu_fwd_startat;
-static bool rcu_fwd_emergency_stop;
+
 #define MAX_FWD_CB_JIFFIES	(8 * HZ) /* Maximum CB test duration. */
 #define MIN_FWD_CB_LAUNDERS	3	/* This many CB invocations to count. */
 #define MIN_FWD_CBS_LAUNDERED	100	/* Number of counted CBs. */
 #define FWD_CBS_HIST_DIV	10	/* Histogram buckets/second. */
+#define N_LAUNDERS_HIST (2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV))
+
 struct rcu_launder_hist {
 	long n_launders;
 	unsigned long launder_gp_seq;
 };
-#define N_LAUNDERS_HIST (2 * MAX_FWD_CB_JIFFIES / (HZ / FWD_CBS_HIST_DIV))
-static struct rcu_launder_hist n_launders_hist[N_LAUNDERS_HIST];
-static unsigned long rcu_launder_gp_seq_start;
+
+struct rcu_fwd {
+	spinlock_t rcu_fwd_lock;
+	struct rcu_fwd_cb *rcu_fwd_cb_head;
+	struct rcu_fwd_cb **rcu_fwd_cb_tail;
+	long n_launders_cb;
+	unsigned long rcu_fwd_startat;
+	struct rcu_launder_hist n_launders_hist[N_LAUNDERS_HIST];
+	unsigned long rcu_launder_gp_seq_start;
+};
+
+struct rcu_fwd rcu_fwds = {
+	.rcu_fwd_lock = __SPIN_LOCK_UNLOCKED(rcu_fwds.rcu_fwd_lock),
+	.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head,
+};
+
+bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(void)
 {
@@ -1688,16 +1699,17 @@ static void rcu_torture_fwd_cb_hist(void)
 	int i;
 	int j;
 
-	for (i = ARRAY_SIZE(n_launders_hist) - 1; i > 0; i--)
-		if (n_launders_hist[i].n_launders > 0)
+	for (i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1; i > 0; i--)
+		if (rcu_fwds.n_launders_hist[i].n_launders > 0)
 			break;
 	pr_alert("%s: Callback-invocation histogram (duration %lu jiffies):",
-		 __func__, jiffies - rcu_fwd_startat);
-	gps_old = rcu_launder_gp_seq_start;
+		 __func__, jiffies - rcu_fwds.rcu_fwd_startat);
+	gps_old = rcu_fwds.rcu_launder_gp_seq_start;
 	for (j = 0; j <= i; j++) {
-		gps = n_launders_hist[j].launder_gp_seq;
+		gps = rcu_fwds.n_launders_hist[j].launder_gp_seq;
 		pr_cont(" %ds/%d: %ld:%ld",
-			j + 1, FWD_CBS_HIST_DIV, n_launders_hist[j].n_launders,
+			j + 1, FWD_CBS_HIST_DIV,
+			rcu_fwds.n_launders_hist[j].n_launders,
 			rcutorture_seq_diff(gps, gps_old));
 		gps_old = gps;
 	}
@@ -1714,17 +1726,17 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 
 	rfcp->rfc_next = NULL;
 	rfcp->rfc_gps++;
-	spin_lock_irqsave(&rcu_fwd_lock, flags);
-	rfcpp = rcu_fwd_cb_tail;
-	rcu_fwd_cb_tail = &rfcp->rfc_next;
+	spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
+	rfcpp = rcu_fwds.rcu_fwd_cb_tail;
+	rcu_fwds.rcu_fwd_cb_tail = &rfcp->rfc_next;
 	WRITE_ONCE(*rfcpp, rfcp);
-	WRITE_ONCE(n_launders_cb, n_launders_cb + 1);
-	i = ((jiffies - rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
-	if (i >= ARRAY_SIZE(n_launders_hist))
-		i = ARRAY_SIZE(n_launders_hist) - 1;
-	n_launders_hist[i].n_launders++;
-	n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
-	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+	WRITE_ONCE(rcu_fwds.n_launders_cb, rcu_fwds.n_launders_cb + 1);
+	i = ((jiffies - rcu_fwds.rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
+	if (i >= ARRAY_SIZE(rcu_fwds.n_launders_hist))
+		i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1;
+	rcu_fwds.n_launders_hist[i].n_launders++;
+	rcu_fwds.n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
+	spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 }
 
 // Give the scheduler a chance, even on nohz_full CPUs.
@@ -1751,16 +1763,16 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 	struct rcu_fwd_cb *rfcp;
 
 	for (;;) {
-		spin_lock_irqsave(&rcu_fwd_lock, flags);
-		rfcp = rcu_fwd_cb_head;
+		spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
+		rfcp = rcu_fwds.rcu_fwd_cb_head;
 		if (!rfcp) {
-			spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+			spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 			break;
 		}
-		rcu_fwd_cb_head = rfcp->rfc_next;
-		if (!rcu_fwd_cb_head)
-			rcu_fwd_cb_tail = &rcu_fwd_cb_head;
-		spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+		rcu_fwds.rcu_fwd_cb_head = rfcp->rfc_next;
+		if (!rcu_fwds.rcu_fwd_cb_head)
+			rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
+		spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
@@ -1804,8 +1816,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	sd = cur_ops->stall_dur() + 1;
 	sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
 	dur = sd4 + torture_random(&trs) % (sd - sd4);
-	WRITE_ONCE(rcu_fwd_startat, jiffies);
-	stopat = rcu_fwd_startat + dur;
+	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
+	stopat = rcu_fwds.rcu_fwd_startat + dur;
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1864,23 +1876,23 @@ static void rcu_torture_fwd_prog_cr(void)
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
 	cur_ops->sync(); /* Later readers see above write. */
-	WRITE_ONCE(rcu_fwd_startat, jiffies);
-	stopat = rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
+	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
+	stopat = rcu_fwds.rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
 	n_launders = 0;
-	n_launders_cb = 0;
+	rcu_fwds.n_launders_cb = 0; // Hoist initialization for multi-kthread
 	n_launders_sa = 0;
 	n_max_cbs = 0;
 	n_max_gps = 0;
-	for (i = 0; i < ARRAY_SIZE(n_launders_hist); i++)
-		n_launders_hist[i].n_launders = 0;
+	for (i = 0; i < ARRAY_SIZE(rcu_fwds.n_launders_hist); i++)
+		rcu_fwds.n_launders_hist[i].n_launders = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
-	rcu_launder_gp_seq_start = gps;
+	rcu_fwds.rcu_launder_gp_seq_start = gps;
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-		rfcp = READ_ONCE(rcu_fwd_cb_head);
+		rfcp = READ_ONCE(rcu_fwds.rcu_fwd_cb_head);
 		rfcpn = NULL;
 		if (rfcp)
 			rfcpn = READ_ONCE(rfcp->rfc_next);
@@ -1888,7 +1900,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
 			    ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
 				break;
-			rcu_fwd_cb_head = rfcpn;
+			rcu_fwds.rcu_fwd_cb_head = rfcpn;
 			n_launders++;
 			n_launders_sa++;
 		} else {
@@ -1910,7 +1922,7 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 	}
 	stoppedat = jiffies;
-	n_launders_cb_snap = READ_ONCE(n_launders_cb);
+	n_launders_cb_snap = READ_ONCE(rcu_fwds.n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
@@ -1921,7 +1933,8 @@ static void rcu_torture_fwd_prog_cr(void)
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
 			 __func__,
-			 stoppedat - rcu_fwd_startat, jiffies - stoppedat,
+			 stoppedat - rcu_fwds.rcu_fwd_startat,
+			 jiffies - stoppedat,
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
@@ -1943,7 +1956,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
 	rcu_torture_fwd_cb_hist();
-	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat)) / 2);
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-- 
2.9.5

