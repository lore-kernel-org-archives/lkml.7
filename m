Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A4EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17DB222C5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066749;
	bh=UjqYB5SekydtulNhxTwjwTsMjjV+WrUsz39ttMq5r5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QaMB/iGalKcYE0ZtmLzNlHd2Et4nmlibgPLH18gKXjl8MhZlLzIQaJVG/XmAerEGY
	 hG6phBflTZyEgG3Bz4+4Ql10qjBiC1TE++67MnL08gh6KoTX4zsUY91KMU9bcZWBWz
	 43VM6l90xbMZOhaWaTpZQqfSTVtBl5D6+zaxq0/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfJCBjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfJCBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CC5D222C6;
        Thu,  3 Oct 2019 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066746;
        bh=UjqYB5SekydtulNhxTwjwTsMjjV+WrUsz39ttMq5r5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdlIhIBfxLXG1/Gci9lQXshyutXy6tcvMTqXJwxcW6SXALee+xO+qD3WAiy2qvC9o
         LzyAksRVj2fFAIn5liyKEzEtFtVTU6vUuaZDz/c+e88sFwyeR3S2Y++QMctC/sQi7l
         +lsjJmWjj1oY54bZsOJDwXZQuQ3ON7dIc33O68R0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/12] rcu: Force on tick when invoking lots of callbacks
Date:   Wed,  2 Oct 2019 18:38:54 -0700
Message-Id: <20191003013903.13079-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Callback invocation can run for a significant time period, and within
CONFIG_NO_HZ_FULL=y kernels, this period will be devoid of scheduler-clock
interrupts.  In-kernel execution without such interrupts can cause all
manner of malfunction, with RCU CPU stall warnings being but one result.

This commit therefore forces scheduling-clock interrupts on whenever more
than a few RCU callbacks are invoked.  Because offloaded callback invocation
can be preempted, this forcing is withdrawn on each context switch.  This
in turn requires that the loop invoking RCU callbacks reiterate the forcing
periodically.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8110514..db673ae 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2151,6 +2151,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
@@ -2217,6 +2219,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Re-invoke RCU core processing if there are callbacks remaining. */
 	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_core();
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 }
 
 /*
-- 
2.9.5

