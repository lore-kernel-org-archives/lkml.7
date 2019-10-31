Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA5CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B1B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfJaKJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:09:34 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40391 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbfJaKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tgm6rf8_1572516513;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgm6rf8_1572516513)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:33 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 06/11] rcu: clear t->rcu_read_unlock_special in one go
Date:   Thu, 31 Oct 2019 10:08:01 +0000
Message-Id: <20191031100806.1326-7-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing t->rcu_read_unlock_special in one go makes the code
more clearly.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bb3bcdb5c9b8..e612c77dc446 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -420,6 +420,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
+ * t->rcu_read_unlock_special is cleared after called.
  */
 static void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
@@ -439,11 +440,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	t->rcu_read_unlock_special.b.exp_hint = false;
-	t->rcu_read_unlock_special.b.deferred_qs = false;
+	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
 		rcu_qs();
-		t->rcu_read_unlock_special.b.need_qs = false;
 	}
 
 	/*
@@ -459,8 +458,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 
 	/* Clean up if blocked during RCU read-side critical section. */
 	if (special.b.blocked) {
-		t->rcu_read_unlock_special.b.blocked = false;
-
 		/*
 		 * Remove this task from the list it blocked on.  The task
 		 * now remains queued on the rcu_node corresponding to the
-- 
2.20.1

