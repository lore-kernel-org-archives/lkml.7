Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4BCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066AD2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfJaKI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:08:59 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:9713 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbfJaKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgluWgs_1572516516;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgluWgs_1572516516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:36 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 10/11] rcu: clear the special.b.need_qs in rcu_note_context_switch()
Date:   Thu, 31 Oct 2019 10:08:05 +0000
Message-Id: <20191031100806.1326-11-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to clear the special.b.need_qs when it is
replaced by special.b.blocked or it is really fulfill its
goal in rcu_preempt_deferred_qs_irqrestore().

It makes rcu_qs() easier to be understood, and also prepares for
the percpu rcu_preempt_depth patch, which reqires rcu_special
bits to be clearred in irq-disable context.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 81cacf637865..21bb04fec0d2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -264,8 +264,6 @@ static void rcu_qs(void)
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
 	}
 }
 
@@ -297,6 +295,7 @@ void rcu_note_context_switch(bool preempt)
 		/* Possibly blocking in an RCU read-side critical section. */
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp);
+		t->rcu_read_unlock_special.b.need_qs = false;
 		t->rcu_read_unlock_special.b.blocked = true;
 		t->rcu_blocked_node = rnp;
 
-- 
2.20.1

