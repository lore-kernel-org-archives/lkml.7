Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518A22077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951117;
	bh=23X8As3LtLzSWfubNif9hGJNq8LPzWRDyu6nOQWPES8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uh1XpNN1kL1I5mdKgR+Ptjx3XTL+v6PpKdejaY0KR6dEuU1OjWPZtg3gReXzsb3J4
	 wifeJ5FzN6NTx+mi6XlAV2J3qGYmjcych56kGrqzdCcKEw5iRiub+BglXMW2RNJI++
	 pEwMu5hdMay1F9NI9ZuDBXe+qRrFXS5H/5fAo/tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJEL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfLJELx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:53 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2D7214AF;
        Tue, 10 Dec 2019 04:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951112;
        bh=23X8As3LtLzSWfubNif9hGJNq8LPzWRDyu6nOQWPES8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQ/uSqWQol1tLiWbTBj+ozd2ZzQNeZo/RbyECXe+Mnpg30/OkEZ++d7rsChxyU+3M
         CG/G7cQzqTbOpGLp8OZZwmj7JwCBhCfzrMhus/0fAHRVXb7tv4hkRSD5EWOfyG4Y8g
         USrYAcU6mG0EXHDocUbb4/7MtFzsR3JT7cB9vQLY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/7] rcu: Add support for debug_objects debugging for kfree_rcu()
Date:   Mon,  9 Dec 2019 20:11:45 -0800
Message-Id: <20191210041147.3181-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041118.GA3115@paulmck-ThinkPad-P72>
References: <20191210041118.GA3115@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit applies RCU's debug_objects debugging to the new batched
kfree_rcu() implementations.  The object is queued at the kfree_rcu()
call and dequeued during reclaim.

Tested that enabling CONFIG_DEBUG_OBJECTS_RCU_HEAD successfully detects
double kfree_rcu() calls.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Fix IRQ per kbuild test robot <lkp@intel.com> feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a40fd58..0512221 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2749,6 +2749,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; head; head = next) {
 		next = head->next;
 		// Potentially optimize with kfree_bulk in future.
+		debug_rcu_head_unqueue(head);
 		__rcu_reclaim(rcu_state.name, head);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -2855,6 +2856,12 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
+	if (debug_rcu_head_queue(head)) {
+		// Probable double kfree_rcu(), just leak.
+		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
+			  __func__, head);
+		goto unlock_return;
+	}
 	head->func = func;
 	head->next = krcp->head;
 	krcp->head = head;
@@ -2866,6 +2873,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	}
 
+unlock_return:
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
-- 
2.9.5

