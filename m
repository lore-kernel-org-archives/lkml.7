Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EACA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A47C208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfJaKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33054 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfJaKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tgm67mS_1572516511;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tgm67mS_1572516511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:31 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 03/11] rcu: clean up rcu_preempt_deferred_qs_irqrestore()
Date:   Thu, 31 Oct 2019 10:07:58 +0000
Message-Id: <20191031100806.1326-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove several unneeded return.

It doesn't need to return earlier after every code block.
The code protects itself and be safe to fall through because
every code block has its own condition tests.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 59ef10da1e39..82595db04eec 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -439,19 +439,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(&rcu_data);
-	if (!special.s && !rdp->exp_deferred_qs) {
-		local_irq_restore(flags);
-		return;
-	}
 	t->rcu_read_unlock_special.b.deferred_qs = false;
 	if (special.b.need_qs) {
 		rcu_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
-		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
-			local_irq_restore(flags);
-			return;
-		}
 	}
 
 	/*
@@ -460,12 +451,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
+	rdp = this_cpu_ptr(&rcu_data);
 	if (rdp->exp_deferred_qs) {
 		rcu_report_exp_rdp(rdp);
-		if (!t->rcu_read_unlock_special.s) {
-			local_irq_restore(flags);
-			return;
-		}
 	}
 
 	/* Clean up if blocked during RCU read-side critical section. */
-- 
2.20.1

