Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D739DCA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0066218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfKBMrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58895 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfKBMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Th-jskr_1572698838;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-jskr_1572698838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:18 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 1/7] rcu: use preempt_count to test whether scheduler locks is held
Date:   Sat,  2 Nov 2019 12:45:53 +0000
Message-Id: <20191102124559.1135-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191102124559.1135-1-laijs@linux.alibaba.com>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
Reply-To: <20191101162109.GN20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since preemption was introduced to linux kernel,
irq disabled spinlocks are always held with preemption
disabled. One of the reason is that sometimes we need
to use spin_unlock() which will do preempt_enable()
to unlock the irq disabled spinlock with keeping irq
disabled. So preempt_count can be used to test whether
scheduler locks is possible held.

CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0982e9886103..aba5896d67e3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -603,10 +603,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
 		if (irqs_were_disabled && use_softirq &&
-		    (in_interrupt() ||
-		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
+		    (in_interrupt() || (exp && !preempt_bh_were_disabled))) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
+			// in_interrupt(): raise_softirq_irqoff() is
+			// guaranteed not to not do wakeup
+			// !preempt_bh_were_disabled: scheduler locks cannot
+			// be held, since spinlocks are always held with
+			// preempt_disable(), so the wakeup will be safe.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-- 
2.20.1

