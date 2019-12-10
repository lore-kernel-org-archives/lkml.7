Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1036C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB69120828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949378;
	bh=T9qxpyhzOayEJTox8hfWLM4ehgIwUVF3G56mydf7+8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/dBCuSQcIPrpjrq3YIgpv+TpJ04COq+2cF0bLERI3rgy2WOE4/50gM7uLWZauHdu
	 LcPsw0b2FQYGjyKo/vvfbhB6NGCl8FpjGp+5N2+YqXEQS1D7jH6mOLA7z+sKPMeH/K
	 B/bt3MVRt6Re+NH4+tobUWGy6plIEerRaJsqOxLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLJDm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLJDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:25 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B806208C3;
        Tue, 10 Dec 2019 03:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949345;
        bh=T9qxpyhzOayEJTox8hfWLM4ehgIwUVF3G56mydf7+8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/ZaS2WVNyPiwStfrkXr6UQ6dz7+nPeQKII8wHMWmctY6IcihB88n5ofuekEyOpfl
         EKKl7b46H1QAivGiU5k73/bEbZ5kvcXkSKjvYiPLZ0FvvAS7SJdvHpYkFC3EO855sb
         GkVXu8pe/uNfrJC5G654BnpR4zBtjTI8rquijwE0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/12] rcutorture: Thread rcu_fwd pointer through forward-progress functions
Date:   Mon,  9 Dec 2019 19:42:12 -0800
Message-Id: <20191210034217.405-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In order to add multiple kthreads, it will be necessary to allow
the various functions to operate on a pointer to their kthread's
rcu_fwd structure.  This commit therefore starts the process of
adding the needed "struct rcu_fwd" parameters and arguments to the
various callback forward-progress functions.

Note that rcutorture_oom_notify() and rcu_torture_fwd_cb_hist() will
eventually need to iterate over all kthreads' rcu_fwd structures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 78 ++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 22a75a4..cc88ce9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1661,6 +1661,7 @@ static void rcu_torture_fwd_prog_cb(struct rcu_head *rhp)
 struct rcu_fwd_cb {
 	struct rcu_head rh;
 	struct rcu_fwd_cb *rfc_next;
+	struct rcu_fwd *rfc_rfp;
 	int rfc_gps;
 };
 
@@ -1692,24 +1693,24 @@ struct rcu_fwd rcu_fwds = {
 
 bool rcu_fwd_emergency_stop;
 
-static void rcu_torture_fwd_cb_hist(void)
+static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 {
 	unsigned long gps;
 	unsigned long gps_old;
 	int i;
 	int j;
 
-	for (i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1; i > 0; i--)
-		if (rcu_fwds.n_launders_hist[i].n_launders > 0)
+	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
+		if (rfp->n_launders_hist[i].n_launders > 0)
 			break;
 	pr_alert("%s: Callback-invocation histogram (duration %lu jiffies):",
-		 __func__, jiffies - rcu_fwds.rcu_fwd_startat);
-	gps_old = rcu_fwds.rcu_launder_gp_seq_start;
+		 __func__, jiffies - rfp->rcu_fwd_startat);
+	gps_old = rfp->rcu_launder_gp_seq_start;
 	for (j = 0; j <= i; j++) {
-		gps = rcu_fwds.n_launders_hist[j].launder_gp_seq;
+		gps = rfp->n_launders_hist[j].launder_gp_seq;
 		pr_cont(" %ds/%d: %ld:%ld",
 			j + 1, FWD_CBS_HIST_DIV,
-			rcu_fwds.n_launders_hist[j].n_launders,
+			rfp->n_launders_hist[j].n_launders,
 			rcutorture_seq_diff(gps, gps_old));
 		gps_old = gps;
 	}
@@ -1723,20 +1724,21 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	int i;
 	struct rcu_fwd_cb *rfcp = container_of(rhp, struct rcu_fwd_cb, rh);
 	struct rcu_fwd_cb **rfcpp;
+	struct rcu_fwd *rfp = rfcp->rfc_rfp;
 
 	rfcp->rfc_next = NULL;
 	rfcp->rfc_gps++;
-	spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
-	rfcpp = rcu_fwds.rcu_fwd_cb_tail;
-	rcu_fwds.rcu_fwd_cb_tail = &rfcp->rfc_next;
+	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
+	rfcpp = rfp->rcu_fwd_cb_tail;
+	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
 	WRITE_ONCE(*rfcpp, rfcp);
-	WRITE_ONCE(rcu_fwds.n_launders_cb, rcu_fwds.n_launders_cb + 1);
-	i = ((jiffies - rcu_fwds.rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
-	if (i >= ARRAY_SIZE(rcu_fwds.n_launders_hist))
-		i = ARRAY_SIZE(rcu_fwds.n_launders_hist) - 1;
-	rcu_fwds.n_launders_hist[i].n_launders++;
-	rcu_fwds.n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
-	spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
+	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
+	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
+		i = ARRAY_SIZE(rfp->n_launders_hist) - 1;
+	rfp->n_launders_hist[i].n_launders++;
+	rfp->n_launders_hist[i].launder_gp_seq = cur_ops->get_gp_seq();
+	spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 }
 
 // Give the scheduler a chance, even on nohz_full CPUs.
@@ -1786,7 +1788,8 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 }
 
 /* Carry out need_resched()/cond_resched() forward-progress testing. */
-static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
+static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
+				    int *tested, int *tested_tries)
 {
 	unsigned long cver;
 	unsigned long dur;
@@ -1816,8 +1819,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	sd = cur_ops->stall_dur() + 1;
 	sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
 	dur = sd4 + torture_random(&trs) % (sd - sd4);
-	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
-	stopat = rcu_fwds.rcu_fwd_startat + dur;
+	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
+	stopat = rfp->rcu_fwd_startat + dur;
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1852,7 +1855,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 }
 
 /* Carry out call_rcu() forward-progress testing. */
-static void rcu_torture_fwd_prog_cr(void)
+static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 {
 	unsigned long cver;
 	unsigned long flags;
@@ -1876,23 +1879,23 @@ static void rcu_torture_fwd_prog_cr(void)
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
 	cur_ops->sync(); /* Later readers see above write. */
-	WRITE_ONCE(rcu_fwds.rcu_fwd_startat, jiffies);
-	stopat = rcu_fwds.rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
+	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
+	stopat = rfp->rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
 	n_launders = 0;
-	rcu_fwds.n_launders_cb = 0; // Hoist initialization for multi-kthread
+	rfp->n_launders_cb = 0; // Hoist initialization for multi-kthread
 	n_launders_sa = 0;
 	n_max_cbs = 0;
 	n_max_gps = 0;
-	for (i = 0; i < ARRAY_SIZE(rcu_fwds.n_launders_hist); i++)
-		rcu_fwds.n_launders_hist[i].n_launders = 0;
+	for (i = 0; i < ARRAY_SIZE(rfp->n_launders_hist); i++)
+		rfp->n_launders_hist[i].n_launders = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
-	rcu_fwds.rcu_launder_gp_seq_start = gps;
+	rfp->rcu_launder_gp_seq_start = gps;
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-		rfcp = READ_ONCE(rcu_fwds.rcu_fwd_cb_head);
+		rfcp = READ_ONCE(rfp->rcu_fwd_cb_head);
 		rfcpn = NULL;
 		if (rfcp)
 			rfcpn = READ_ONCE(rfcp->rfc_next);
@@ -1900,7 +1903,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
 			    ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
 				break;
-			rcu_fwds.rcu_fwd_cb_head = rfcpn;
+			rfp->rcu_fwd_cb_head = rfcpn;
 			n_launders++;
 			n_launders_sa++;
 		} else {
@@ -1912,6 +1915,7 @@ static void rcu_torture_fwd_prog_cr(void)
 			n_max_cbs++;
 			n_launders_sa = 0;
 			rfcp->rfc_gps = 0;
+			rfcp->rfc_rfp = rfp;
 		}
 		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
@@ -1922,7 +1926,7 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 	}
 	stoppedat = jiffies;
-	n_launders_cb_snap = READ_ONCE(rcu_fwds.n_launders_cb);
+	n_launders_cb_snap = READ_ONCE(rfp->n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
@@ -1933,12 +1937,11 @@ static void rcu_torture_fwd_prog_cr(void)
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
 			 __func__,
-			 stoppedat - rcu_fwds.rcu_fwd_startat,
-			 jiffies - stoppedat,
+			 stoppedat - rfp->rcu_fwd_startat, jiffies - stoppedat,
 			 n_launders + n_max_cbs - n_launders_cb_snap,
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
-		rcu_torture_fwd_cb_hist();
+		rcu_torture_fwd_cb_hist(rfp);
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
@@ -1955,7 +1958,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 {
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
-	rcu_torture_fwd_cb_hist();
+	rcu_torture_fwd_cb_hist(&rcu_fwds);
 	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
@@ -1980,6 +1983,7 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	struct rcu_fwd *rfp = args;
 	int tested = 0;
 	int tested_tries = 0;
 
@@ -1991,8 +1995,8 @@ static int rcu_torture_fwd_prog(void *args)
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
 		register_oom_notifier(&rcutorture_oom_nb);
-		rcu_torture_fwd_prog_nr(&tested, &tested_tries);
-		rcu_torture_fwd_prog_cr();
+		rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
+		rcu_torture_fwd_prog_cr(rfp);
 		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
@@ -2027,7 +2031,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
 	return torture_create_kthread(rcu_torture_fwd_prog,
-				      NULL, fwd_prog_task);
+				      &rcu_fwds, fwd_prog_task);
 }
 
 /* Callback function for RCU barrier testing. */
-- 
2.9.5

