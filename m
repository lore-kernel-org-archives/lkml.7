Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623EEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C6207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949373;
	bh=UNYnG4cXwz2KO2JZKMgmi1b6QB5VeGaNMGGhH2qABk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L6Hm2ql0MdFVM5Nq3WtCvzKdrNAFptB/VmgPsdJL0ye0VKgDVuSdRMeov9V2v0cgI
	 LmOcnNusCTHjvFM21p8lLfpUa1W5J1Msg9sAcDlzI0AuwwqiGNaFen1YhklRncDC/e
	 Rm9lPY8fLmM9eHC5+apI/SfU3bqSwGHxknjMrfdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJDmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfLJDm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:27 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C7721556;
        Tue, 10 Dec 2019 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949346;
        bh=UNYnG4cXwz2KO2JZKMgmi1b6QB5VeGaNMGGhH2qABk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwyLnenob6iyEwNBBFyAoL9USeQYTMcMIvK+sdIcRWFj7jlGh9oYJDxOtrdXGbRgO
         VIhnkZ8zSxtKRue6K3UgRcZ61RF/TeweEZzY9izekehL7FCsYPWRFLFgETz5l8wyhj
         LYFm2LyxtNKwAEAaEWlWKqel/8iyVRKU9btQRIlA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/12] rcutorture: Complete threading rcu_fwd pointers through functions
Date:   Mon,  9 Dec 2019 19:42:14 -0800
Message-Id: <20191210034217.405-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit threads pointers to rcu_fwd structures through the remaining
functions using rcu_fwds directly, namely rcu_torture_fwd_prog_cbfree(),
rcutorture_oom_notify() and rcu_torture_fwd_prog_init().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6f540fe..394baac 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1754,23 +1754,23 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
  * Free all callbacks on the rcu_fwd_cb_head list, either because the
  * test is over or because we hit an OOM event.
  */
-static unsigned long rcu_torture_fwd_prog_cbfree(void)
+static unsigned long rcu_torture_fwd_prog_cbfree(struct rcu_fwd *rfp)
 {
 	unsigned long flags;
 	unsigned long freed = 0;
 	struct rcu_fwd_cb *rfcp;
 
 	for (;;) {
-		spin_lock_irqsave(&rcu_fwds.rcu_fwd_lock, flags);
-		rfcp = rcu_fwds.rcu_fwd_cb_head;
+		spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
+		rfcp = rfp->rcu_fwd_cb_head;
 		if (!rfcp) {
-			spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+			spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 			break;
 		}
-		rcu_fwds.rcu_fwd_cb_head = rfcp->rfc_next;
-		if (!rcu_fwds.rcu_fwd_cb_head)
-			rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
-		spin_unlock_irqrestore(&rcu_fwds.rcu_fwd_lock, flags);
+		rfp->rcu_fwd_cb_head = rfcp->rfc_next;
+		if (!rfp->rcu_fwd_cb_head)
+			rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+		spin_unlock_irqrestore(&rfp->rcu_fwd_lock, flags);
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
@@ -1926,7 +1926,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
-	(void)rcu_torture_fwd_prog_cbfree();
+	(void)rcu_torture_fwd_prog_cbfree(rfp);
 
 	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop) &&
 	    !shutdown_time_arrived()) {
@@ -1952,20 +1952,22 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
+	struct rcu_fwd *rfp = &rcu_fwds;
+
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
-	rcu_torture_fwd_cb_hist(&rcu_fwds);
-	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwds.rcu_fwd_startat)) / 2);
+	rcu_torture_fwd_cb_hist(rfp);
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rfp->rcu_fwd_startat)) / 2);
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
 	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	rcu_barrier();
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	rcu_barrier();
 	pr_info("%s: Freed %lu RCU callbacks.\n",
-		__func__, rcu_torture_fwd_prog_cbfree());
+		__func__, rcu_torture_fwd_prog_cbfree(rfp));
 	smp_mb(); /* Frees before return to avoid redoing OOM. */
 	(*(unsigned long *)nfreed)++; /* Forward progress CBs freed! */
 	pr_info("%s returning after OOM processing.\n", __func__);
@@ -2008,6 +2010,8 @@ static int rcu_torture_fwd_prog(void *args)
 /* If forward-progress checking is requested and feasible, spawn the thread. */
 static int __init rcu_torture_fwd_prog_init(void)
 {
+	struct rcu_fwd *rfp = &rcu_fwds;
+
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
 	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
@@ -2022,14 +2026,13 @@ static int __init rcu_torture_fwd_prog_init(void)
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
 	}
-	spin_lock_init(&rcu_fwds.rcu_fwd_lock);
-	rcu_fwds.rcu_fwd_cb_tail = &rcu_fwds.rcu_fwd_cb_head;
+	spin_lock_init(&rfp->rcu_fwd_lock);
+	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
-	return torture_create_kthread(rcu_torture_fwd_prog,
-				      &rcu_fwds, fwd_prog_task);
+	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
 /* Callback function for RCU barrier testing. */
-- 
2.9.5

