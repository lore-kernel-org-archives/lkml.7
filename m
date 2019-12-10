Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F55AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C52207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950543;
	bh=cHLTLZeys6gPXi7kdLlViUglgETxAyHwd8fFYGAZ/Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X+4F3VkeTnIPYV8kLZwZBnOnnyr1fH8AC0O8wQBo/FCHxjILiM01kkYfUA576wmQl
	 bAhSRXm6gGzzAJ5du1+1ZxS8fXdRasXY4I2MHRinq0oxTH8EOqTBRvXk5AxPUrkwJg
	 9wRyu5Awc1akWmAUMzIoBDSWZoDScNR2UBBrAnnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLJECS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfLJECB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:02:01 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B42C2465B;
        Tue, 10 Dec 2019 04:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950519;
        bh=cHLTLZeys6gPXi7kdLlViUglgETxAyHwd8fFYGAZ/Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzJeNo/9m0pOYg1n5q24g4Hor/GFr9eZ+ERGWoDN5419b7lolK8RxTmyACAB3N4zu
         z893QFTjqDxDTn3A4idz3eT5wESuoT/0jiB8uhMrEFg1Cu/NCeqBZnbRO26mnGZFqC
         tu4JxAIhlXkjaNczaqHPuikDwzcxvfEmvk2vHCs4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/10] rcu: Allow only one expedited GP to run concurrently with wakeups
Date:   Mon,  9 Dec 2019 20:01:50 -0800
Message-Id: <20191210040154.2498-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

The current expedited RCU grace-period code expects that a task
requesting an expedited grace period cannot awaken until that grace
period has reached the wakeup phase.  However, it is possible for a long
preemption to result in the waiting task never sleeping.  For example,
consider the following sequence of events:

1.	Task A starts an expedited grace period by invoking
	synchronize_rcu_expedited().  It proceeds normally up to the
	wait_event() near the end of that function, and is then preempted
	(or interrupted or whatever).

2.	The expedited grace period completes, and a kworker task starts
	the awaken phase, having incremented the counter and acquired
	the rcu_state structure's .exp_wake_mutex.  This kworker task
	is then preempted or interrupted or whatever.

3.	Task A resumes and enters wait_event(), which notes that the
	expedited grace period has completed, and thus doesn't sleep.

4.	Task B starts an expedited grace period exactly as did Task A,
	complete with the preemption (or whatever delay) just before
	the call to wait_event().

5.	The expedited grace period completes, and another kworker
	task starts the awaken phase, having incremented the counter.
	However, it blocks when attempting to acquire the rcu_state
	structure's .exp_wake_mutex because step 2's kworker task has
	not yet released it.

6.	Steps 4 and 5 repeat, resulting in overflow of the rcu_node
	structure's ->exp_wq[] array.

In theory, this is harmless.  Tasks waiting on the various ->exp_wq[]
array will just be spuriously awakened, but they will just sleep again
on noting that the rcu_state structure's ->expedited_sequence value has
not advanced far enough.

In practice, this wastes CPU time and is an accident waiting to happen.
This commit therefore moves the rcu_exp_gp_seq_end() call that officially
ends the expedited grace period (along with associate tracing) until
after the ->exp_wake_mutex has been acquired.  This prevents Task A from
awakening prematurely, thus preventing more than one expedited grace
period from being in flight during a previous expedited grace period's
wakeup phase.

Fixes: 3b5f668e715b ("rcu: Overlap wakeups with next expedited grace period")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
[ paulmck: Added updated comment. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index fa143e4..7a1f093 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -539,14 +539,13 @@ static void rcu_exp_wait_wake(unsigned long s)
 	struct rcu_node *rnp;
 
 	synchronize_sched_expedited_wait();
-	rcu_exp_gp_seq_end();
-	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
-	/*
-	 * Switch over to wakeup mode, allowing the next GP, but -only- the
-	 * next GP, to proceed.
-	 */
+	// Switch over to wakeup mode, allowing the next GP to proceed.
+	// End the previous grace period only after acquiring the mutex
+	// to ensure that only one GP runs concurrently with wakeups.
 	mutex_lock(&rcu_state.exp_wake_mutex);
+	rcu_exp_gp_seq_end();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
-- 
2.9.5

