Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD6CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DC02086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfJaKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:42 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58854 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbfJaKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tgm6rfN_1572516514;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgm6rfN_1572516514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:34 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 07/11] rcu: set special.b.deferred_qs before wake_up()
Date:   Thu, 31 Oct 2019 10:08:02 +0000
Message-Id: <20191031100806.1326-8-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 10f39bb1b2c1
(rcu: protect __rcu_read_unlock() against scheduler-using irq handlers)
unveiled a kind of deadlock and resolved the deadlock problem by
avoiding the condition when ->rcu_read_lock_nesting is zero &&
->rcu_read_unlock_special is non-zero. To achieve it, the commit
used negative values for ->rcu_read_lock_nesting.

But now we have deferred_qs mechanism, we can defer qs rather
than persevere in reporting qs and deadlock. All we need is
setting special.b.deferred_qs before scheduler locks
such as wake_up() and leave the qs deferred and return.

After this change, rcu_read_unlock_special() is safe to be
called in any context, including nested in __rcu_read_unlock()
in interrupt.

This change is important to change ->rcu_read_lock_nesting
back to non-negative and further simplify the rcu_read_unlock().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e612c77dc446..dbded2b8c792 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -591,6 +591,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
 		bool exp;
+		bool deferred_qs = t->rcu_read_unlock_special.b.deferred_qs;
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
@@ -599,9 +600,18 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		      (rdp->grpmask & rnp->expmask) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
+		// In some cases when in_interrupt() returns false,
+		// raise_softirq_irqoff() has to call wake_up(),
+		// and the !deferred_qs says that scheduler locks
+		// cannot be held, so the wakeup will be safe now.
+		// But this wake_up() may have RCU critical section nested
+		// in the scheduler locks and its rcu_read_unlock() would
+		// call rcu_read_unlock_special() and then wake_up()
+		// recursively and deadlock if deferred_qs is still false.
+		// To avoid it, deferred_qs has to be set beforehand.
+		t->rcu_read_unlock_special.b.deferred_qs = true;
 		if (irqs_were_disabled && use_softirq &&
-		    (in_interrupt() ||
-		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
+		    (in_interrupt() || (exp && !deferred_qs))) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
@@ -620,7 +630,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
-- 
2.20.1

