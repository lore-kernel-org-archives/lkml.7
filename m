Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC6CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33C320637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952000;
	bh=0kDqNffIxuxFydTbB5GLnSmkSjysWRJ0qdXtn/EgnzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wy3nUQnLeWALQq5J26hwfA6rq/lqP0iNJ3B5kThHtNXsxFm/231sAX5DcsXbeTbu5
	 KJ+SvWbmVISPPuyhZTXYCks2rsWcBe9gjl31i2623a+sXDGyv/5MCej0auz1guicAt
	 ZVCHLHYeXsV5ynj0UicHKEy9MbbC8IkfpGpyZSIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLJE0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLJE0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:37 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E163A24653;
        Tue, 10 Dec 2019 04:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951996;
        bh=0kDqNffIxuxFydTbB5GLnSmkSjysWRJ0qdXtn/EgnzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZH1xDJRE+r9MfnT/5kTfmfAdnPzc0mXg1DVRwpp6DY7WaofGQqLogiOFeqyxlC1c
         nvA20ZcI9CEdHm0mDG0ljo/6BMEVfKe2gneg3hRD+HHYTfy8kt6x2VYtCmgICICBF1
         vb9CJruBHhK4x+t+mU7kDzBrsTn1jvtUXJRTckzE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/11] rcu: Clear .exp_hint only when deferred quiescent state has been reported
Date:   Mon,  9 Dec 2019 20:26:25 -0800
Message-Id: <20191210042629.3808-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Currently, the .exp_hint flag is cleared in rcu_read_unlock_special(),
which works, but which can also prevent subsequent rcu_read_unlock() calls
from helping expedite the quiescent state needed by an ongoing expedited
RCU grace period.  This commit therefore defers clearing of .exp_hint
from rcu_read_unlock_special() to rcu_preempt_deferred_qs_irqrestore(),
thus ensuring that intervening calls to rcu_read_unlock() have a chance
to help end the expedited grace period.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8cdce11..7487c79 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -444,6 +444,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		local_irq_restore(flags);
 		return;
 	}
+	t->rcu_read_unlock_special.b.exp_hint = false;
 	t->rcu_read_unlock_special.b.deferred_qs = false;
 	if (special.b.need_qs) {
 		rcu_qs();
@@ -610,7 +611,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		t->rcu_read_unlock_special.b.exp_hint = false;
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
@@ -640,7 +640,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		local_irq_restore(flags);
 		return;
 	}
-	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
-- 
2.9.5

