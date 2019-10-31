Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF76A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfJaKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60654 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfJaKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgmAXpl_1572516509;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgmAXpl_1572516509)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:29 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 01/11] rcu: avoid leaking exp_deferred_qs into next GP
Date:   Thu, 31 Oct 2019 10:07:56 +0000
Message-Id: <20191031100806.1326-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If exp_deferred_qs is incorrectly set and leaked to the next
exp GP, it may cause the next GP to be incorrectly prematurely
completed.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_exp.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a0e1e51c51c2..6dec21909b30 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -603,6 +603,18 @@ static void rcu_exp_handler(void *unused)
 	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
 
+	/*
+	 * Note that there is a large group of race conditions that
+	 * can have caused this quiescent state to already have been
+	 * reported, so we really do need to check ->expmask first.
+	 */
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!(rnp->expmask & rdp->grpmask)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
 	/*
 	 * First, the common case of not being in an RCU read-side
 	 * critical section.  If also enabled or idle, immediately
@@ -628,17 +640,10 @@ static void rcu_exp_handler(void *unused)
 	 * a future context switch.  Either way, if the expedited
 	 * grace period is still waiting on this CPU, set ->deferred_qs
 	 * so that the eventual quiescent state will be reported.
-	 * Note that there is a large group of race conditions that
-	 * can have caused this quiescent state to already have been
-	 * reported, so we really do need to check ->expmask.
 	 */
 	if (t->rcu_read_lock_nesting > 0) {
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		if (rnp->expmask & rdp->grpmask) {
-			rdp->exp_deferred_qs = true;
-			t->rcu_read_unlock_special.b.exp_hint = true;
-		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		rdp->exp_deferred_qs = true;
+		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
 		return;
 	}
 
-- 
2.20.1

