Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C88222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066768;
	bh=CAee0HkekqhN4kNQWmaAnn8lhpve7s8cW9MrImWDFXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GveRt1LkkxWqY3TAXlb5rYSBAh64fgp/vVrH2yXBn8ieyMkov1fZ/xMyZbyeJQR9q
	 NdsdyYRLxxaHNuAC+egc0hKaMMW9l0YQAHJ8LT44j7pTmJK0Yo83tYkDUi9puWjjaj
	 SDFTiAaAVUT9l/JeqR3j2Z+2Z7dibawZZszWTezg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfJCBj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfJCBjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E4E222CF;
        Thu,  3 Oct 2019 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066749;
        bh=CAee0HkekqhN4kNQWmaAnn8lhpve7s8cW9MrImWDFXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1XzDlSatGM8IseECc92cX9E17OJKDP2FSFLI83KQCe0p5BCbqmcfl7CGcWQgNu4A
         3qX5PAr9d2M4LmUMvD9bJpGLay65TNbhCl2ohHYKdXvvjgg50ox35IZwPG+RNDMx9i
         yNbXdkoRSBra4EpYKR/oZ22bC1fTWwYCYLJ70O5w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 11/12] rcu: Confine ->core_needs_qs accesses to the corresponding CPU
Date:   Wed,  2 Oct 2019 18:39:02 -0700
Message-Id: <20191003013903.13079-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Commit 671a63517cf9 ("rcu: Avoid unnecessary softirq when system
is idle") fixed a bug that could result in an indefinite number of
unnecessary invocations of the RCU_SOFTIRQ handler at the trailing edge
of a scheduler-clock interrupt.  However, the fix introduced off-CPU
stores to ->core_needs_qs.  These writes did not conflict with the
on-CPU stores because the CPU's leaf rcu_node structure's ->lock was
held across all such stores.  However, the loads from ->core_needs_qs
were not promoted to READ_ONCE() and, worse yet, the code loading from
->core_needs_qs was written assuming that it was only ever updated by
the corresponding CPU.  So operation has been robust, but only by luck.
This situation is therefore an accident waiting to happen.

This commit therefore takes a different approach.  Instead of clearing
->core_needs_qs from the grace-period kthread's force-quiescent-state
processing, it modifies the rcu_pending() function to suppress the
rcu_sched_clock_irq() function's call to invoke_rcu_core() if there is no
grace period in progress.  This avoids the infinite needless RCU_SOFTIRQ
handlers while still keeping all accesses to ->core_needs_qs local to
the corresponding CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 59527b0..1b250d4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1988,7 +1988,6 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -2822,6 +2821,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
  */
 static int rcu_pending(void)
 {
+	bool gp_in_progress;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -2837,7 +2837,8 @@ static int rcu_pending(void)
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
+	gp_in_progress = rcu_gp_in_progress();
+	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
@@ -2845,8 +2846,7 @@ static int rcu_pending(void)
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) &&
+	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
 	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
-- 
2.9.5

