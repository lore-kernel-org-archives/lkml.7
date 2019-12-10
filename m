Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C49C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFEE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951135;
	bh=JKuN4lBujLD638NBg3cjQ2Oo07HtN/wZRzRaYxqIeHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NUUeHDuxihX7uxciElSOpyQNNpFcwysw9W5g/G8h8p/dAQvIlzZjfTS57zBtvScRS
	 c7102wL7Tz8gLauub+c9Pq3W1iGJbbuDxfM+6oSJPkWIIEd+mT1AS9960suSTvLfhL
	 lMlKk4yQDnBz4p2kCllD5R3PVpUWKCcTViBjuDAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLJEMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfLJELw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:52 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7FAD20836;
        Tue, 10 Dec 2019 04:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951111;
        bh=JKuN4lBujLD638NBg3cjQ2Oo07HtN/wZRzRaYxqIeHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TE06S0QqrMLqJwxKH7vA5U9fQgnAPnDoXxx9sd3XGfeRT37Lzy7/aomeD9I8NEsK+
         XPghmi97S2P0uw2Cnjze3IMngxqtiYv0d/oUsaqEMjHa9mX3QE3b/4kD+DjQBVQTfE
         nQO26IXR+kKRXK9Q/mJOBfk9W6QH+Od64kNLt8fQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/7] rcu: Make kfree_rcu() use a non-atomic ->monitor_todo
Date:   Mon,  9 Dec 2019 20:11:43 -0800
Message-Id: <20191210041147.3181-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041118.GA3115@paulmck-ThinkPad-P72>
References: <20191210041118.GA3115@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

Because the ->monitor_todo field is always protected by krcp->lock,
this commit downgrades from xchg() to non-atomic unmarked assignment
statements.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
[ paulmck: Update to include early-boot kick code. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0af016f..6106b9e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2708,7 +2708,7 @@ struct kfree_rcu_cpu {
 	struct rcu_head *head_free;
 	spinlock_t lock;
 	struct delayed_work monitor_work;
-	int monitor_todo;
+	bool monitor_todo;
 	bool initialized;
 };
 
@@ -2765,6 +2765,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
+	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
 		spin_unlock_irqrestore(&krcp->lock, flags);
@@ -2772,8 +2773,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	if (!xchg(&krcp->monitor_todo, true))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	krcp->monitor_todo = true;
+	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
@@ -2788,7 +2789,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 						 monitor_work.work);
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	if (xchg(&krcp->monitor_todo, false))
+	if (krcp->monitor_todo)
 		kfree_rcu_drain_unlock(krcp, flags);
 	else
 		spin_unlock_irqrestore(&krcp->lock, flags);
@@ -2837,8 +2838,10 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !xchg(&krcp->monitor_todo, true))
+	    !krcp->monitor_todo) {
+		krcp->monitor_todo = true;
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	}
 
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
@@ -2855,10 +2858,11 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || xchg(&krcp->monitor_todo, true)) {
+		if (!krcp->head || krcp->monitor_todo) {
 			spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
+		krcp->monitor_todo = true;
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 		spin_unlock_irqrestore(&krcp->lock, flags);
 	}
-- 
2.9.5

