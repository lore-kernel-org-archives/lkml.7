Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14D2222D1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066758;
	bh=R4+8y7N9zQgrqWaJoUYn/0mob3suNOYTLqxQSBYW3A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGDWkmLGN0z464BpBdTeyQqJ5cy98LqagEeIBPLufIl1jeccqNW73hypLsrHsq+BQ
	 jSCQ2Vea3Q/gFyKBUROYEQWksSW+HwCydmCidTDjy2MRKfEvZhlthBajbHZyxDz4TO
	 0mK4Okd6LUivakU1cAubRqbhftfyCgJqt2ndtmgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfJCBjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfJCBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3104222C9;
        Thu,  3 Oct 2019 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066747;
        bh=R4+8y7N9zQgrqWaJoUYn/0mob3suNOYTLqxQSBYW3A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HW070pkccYDNcKw7OKYXUyV9GyonGVRezBxdDSvc9hW1pZS+BRJqfoRlsp/2QhxKn
         YGE0AABiUG0JEjPmybbAI1kBgQpe8LBfvy4xDXMUIzvwGenr1G0AFxs/P6xsOELgdi
         YqNcIt37xwO35dY87x9BnN+CutmGKyJd8Yr5h5DU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/12] stop_machine: EXP Provide RCU quiescent state in multi_cpu_stop()
Date:   Wed,  2 Oct 2019 18:38:56 -0700
Message-Id: <20191003013903.13079-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

When multi_cpu_stop() loops waiting for other tasks, it can trigger an RCU
CPU stall warning.  This can be misleading because what is instead needed
is information on whatever task is blocking multi_cpu_stop().  This commit
therefore inserts an RCU quiescent state into the multi_cpu_stop()
function's waitloop.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcutree.h | 1 +
 kernel/rcu/tree.c       | 2 +-
 kernel/stop_machine.c   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 18b1ed9..c5147de 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,6 +37,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
+void rcu_momentary_dyntick_idle(void);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index db673ae..f708d54 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -364,7 +364,7 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-static void __maybe_unused rcu_momentary_dyntick_idle(void)
+void rcu_momentary_dyntick_idle(void)
 {
 	int special;
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index c7031a2..34c4f11 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -233,6 +233,7 @@ static int multi_cpu_stop(void *data)
 			 */
 			touch_nmi_watchdog();
 		}
+		rcu_momentary_dyntick_idle();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
-- 
2.9.5

