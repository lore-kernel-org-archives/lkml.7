Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C73C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5D5222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066764;
	bh=KQkSVy0lBRFpixlJVhO54dRUinxcSeVRLqZihn1ksFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cM6GIPZe6gKjYf5llDhQanzWrZbn9HHQy264r2vbRKCvrEhGsWcX4nTeli9PLOrud
	 dgKPmTMrl02WpbNqBJwgLuATLYw6Uh3rIvJdLRYdOWJDpm/efQlQ+gG42Yz06zgUvN
	 DMxxpWLfn+5O88LE+RxdmY4JONnTjKAguQqvRoWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfJCBjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfJCBjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E826222C2;
        Thu,  3 Oct 2019 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066749;
        bh=KQkSVy0lBRFpixlJVhO54dRUinxcSeVRLqZihn1ksFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AikMfF/nL9n7EgI97lF3Gkc1YfeUNd9w8VG/l/0ZdsCiBpqdsT/pH4Ypp860psKEg
         zCUQfAQN8ocVqpQtC3lnFOWwehen5Yx2EuU4nHjF6NlI/So2eB4NT5PyUJgDPw5MCu
         puGGnTx9UKKrautQY17pVP+dHeaG6qzCCQku57T8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 12/12] rcu: Make kernel-mode nohz_full CPUs invoke the RCU core processing
Date:   Wed,  2 Oct 2019 18:39:03 -0700
Message-Id: <20191003013903.13079-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

If a nohz_full CPU is idle or executing in userspace, it makes good sense
to keep it out of RCU core processing.  After all, the RCU grace-period
kthread can see its quiescent states and all of its callbacks are
offloaded, so there is nothing for RCU core processing to do.

However, if a nohz_full CPU is executing in kernel space, the RCU
grace-period kthread cannot do anything for it, so such a CPU must report
its own quiescent states.  This commit therefore makes nohz_full CPUs
skip RCU core processing only if the scheduler-clock interrupt caught
them in idle or in userspace.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1b250d4..9ffe503 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -496,7 +496,7 @@ module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next
 module_param(rcu_kick_kthreads, bool, 0644);
 
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
-static int rcu_pending(void);
+static int rcu_pending(int user);
 
 /*
  * Return the number of RCU GPs completed thus far for debug & stats.
@@ -2270,7 +2270,7 @@ void rcu_sched_clock_irq(int user)
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
 	rcu_flavor_sched_clock_irq(user);
-	if (rcu_pending())
+	if (rcu_pending(user))
 		invoke_rcu_core();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
@@ -2819,7 +2819,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
  * CPU-local state are performed first.  However, we must check for CPU
  * stalls first, else we might not get a chance.
  */
-static int rcu_pending(void)
+static int rcu_pending(int user)
 {
 	bool gp_in_progress;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -2832,8 +2832,8 @@ static int rcu_pending(void)
 	if (rcu_nocb_need_deferred_wakeup(rdp))
 		return 1;
 
-	/* Is this CPU a NO_HZ_FULL CPU that should ignore RCU? */
-	if (rcu_nohz_full_cpu())
+	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
+	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-- 
2.9.5

