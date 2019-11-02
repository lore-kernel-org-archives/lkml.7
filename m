Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE01214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfKBMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44642 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfKBMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th-eIhK_1572698838;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-eIhK_1572698838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:19 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Date:   Sat,  2 Nov 2019 12:45:54 +0000
Message-Id: <20191102124559.1135-3-laijs@linux.alibaba.com>
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

Don't need to set ->rcu_read_lock_nesting negative, irq-protected
rcu_preempt_deferred_qs_irqrestore() doesn't expect
->rcu_read_lock_nesting to be negative to work, it even
doesn't access to ->rcu_read_lock_nesting any more.

It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
may access to ->rcu_read_lock_nesting, but it is still safe
since rcu_read_unlock_special() can protect itself from NMI.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index aba5896d67e3..2fab8be2061f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
-	if (couldrecurse)
-		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
-	if (couldrecurse)
-		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
 /*
-- 
2.20.1

