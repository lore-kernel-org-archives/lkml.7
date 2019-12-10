Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EE3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A9F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950872;
	bh=Y8HMxG0duC5wP4CKmvA4yTsGM/L3pmyRs9QNMDPlBn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4f5tJ5KG8EcRkdtsct6+9qb8KVw5zN5LfoaPy/WD2yyTjWx37ATpVpLV7WFKjhD7
	 HWcqkg2NK3Q1FCn4wAk4CzcBwNfoSxd/1ADr4wAAGHtJkYzAvtXK+vWRmLwkaoOWiz
	 GOj+jRAwUBgCt6urlAGPhKbDpMoecJb1Et6CQjIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLJEHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfLJEHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:47 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324B620838;
        Tue, 10 Dec 2019 04:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950866;
        bh=Y8HMxG0duC5wP4CKmvA4yTsGM/L3pmyRs9QNMDPlBn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USnF7W3ruF87d7i8Ex+SUsrx28/EMuKGi0RVDNiN5si3CKSGohxfHQv8v6Uos5T1M
         SC4+iLfb7/4kssQA5Ceu9f3ehS8BQLdunabKNFSAJun/tz2YX1bZylCLs67jtMAOJ8
         v8dcPSwpX/awRYPFdPgl2Dzeldj7mUJFxwG1asY8=
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
Subject: [PATCH tip/core/rcu 05/12] rcu: Remove the declaration of call_rcu() in tree.h
Date:   Mon,  9 Dec 2019 20:07:34 -0800
Message-Id: <20191210040741.2943-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The call_rcu() function is an external RCU API that is declared in
include/linux/rcupdate.h.  There is thus no point in redeclaring it
in kernel/rcu/tree.h, so this commit removes that redundant declaration.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4dc5de..54ff989 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -413,7 +413,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_sched_clock_irq(int user);
-void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
-- 
2.9.5

