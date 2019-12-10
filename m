Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14504C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54C420652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952012;
	bh=NtcbtfBcwy0FOSNvRbbRjLfqRKrxMsAf+LEJkhGOTl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NsPi1Tl+ymRQWu6hL5d0NxHlQOhGatVVL5jrlmytwUPCaTynwQTNw9iUBbXuYFzEA
	 pTMVb+d3TmYDFkTA0Qj0IbFk3FWyQAR0b3jV/77UzCOZZ9AdMGSiGD2ILbR/e6Euaj
	 cODYcNDYkwRIxVZsRzC1izFph0FljViIGvX8SK7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJE0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfLJE0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:34 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3EE214AF;
        Tue, 10 Dec 2019 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951993;
        bh=NtcbtfBcwy0FOSNvRbbRjLfqRKrxMsAf+LEJkhGOTl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pV2Lqjyk/M1GCStFvYb4eD+ZOmvLxA7XXtU5xzuUHZeMGAeFi+9IVvjmdcCPwzrTT
         s0/k7TW+rGjsbcqIWqYSFeu0X2UnO6/qY1H0XGChdVFe/G18D94l7F9hWc/HoS/eVM
         NdvDHZykcBJh/7Z94XMZqg2eqr7wlQfb9X9xiGuM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/11] rcu: Use lockdep rather than comment to enforce lock held
Date:   Mon,  9 Dec 2019 20:26:21 -0800
Message-Id: <20191210042629.3808-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_preempt_check_blocked_tasks() function has a comment
that states that the rcu_node structure's ->lock must be held,
which might be informative, but which carries little weight if
not read.  This commit therefore removes this comment in favor of
raw_lockdep_assert_held_rcu_node(), which will complain quite
visibly if the required lock is not held.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fe5f448..ed54d36 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -648,8 +648,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
  * Check that the list of blocked tasks for the newly completed grace
  * period is in fact empty.  It is a serious bug to complete a grace
  * period that still has RCU readers blocked!  This function must be
- * invoked -before- updating this rnp's ->gp_seq, and the rnp's ->lock
- * must be held by the caller.
+ * invoked -before- updating this rnp's ->gp_seq.
  *
  * Also, if there are blocked tasks on the list, they automatically
  * block the newly created grace period, so set up ->gp_tasks accordingly.
@@ -659,6 +658,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
-- 
2.9.5

