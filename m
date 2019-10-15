Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F249ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfJOK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:26:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45603 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfJOK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:26:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tf7eiZ4_1571135168;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tf7eiZ4_1571135168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 18:26:26 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 2/7] rcu: fix tracepoint string when RCU CPU kthread runs
Date:   Tue, 15 Oct 2019 10:23:57 +0000
Message-Id: <20191015102402.1978-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015102402.1978-1-laijs@linux.alibaba.com>
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"rcu_wait" is incorrct here, use "rcu_run" instead.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 278798e58698..c351fc280945 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2485,7 +2485,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	int spincnt;
 
 	for (spincnt = 0; spincnt < 10; spincnt++) {
-		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
+		trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2496,7 +2496,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 			rcu_core();
 		local_bh_enable();
 		if (*workp == 0) {
-			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
+			trace_rcu_utilization(TPS("End CPU kthread@rcu_run"));
 			*statusp = RCU_KTHREAD_WAITING;
 			return;
 		}
-- 
2.20.1

