Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B40C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE217222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066770;
	bh=IbqrUn9h/v3hw2FzDoNPSS9hMwA0fdvI0wfndOTtDBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfIuks/wdcRN6m9GswbqV4+j/3d3jfX+IGLtpd3Gx5ER6oCht2V/TMiPduoYCsgmC
	 3j853daRNxj9vuAdPmcqDEEiRzZP7GVEyv/YiBtwCJqgsIOy1N+f1Z0EciuO0P9M+S
	 pXFc4BREUHQ9PfX5weuaEyVg1cdX32rG1GA0JeqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfJCBj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbfJCBjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8335C222C3;
        Thu,  3 Oct 2019 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066748;
        bh=IbqrUn9h/v3hw2FzDoNPSS9hMwA0fdvI0wfndOTtDBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7nMpioqqqCPwEd7Zfle0AsNTzk8UpsoW7EEkUiOJZ/I+3d7ic45fH4h6EtPpg1jh
         G0GmbDvwOSgaTRideNqJhmtkhDVIz779gGwtCucmhnTA7QUXiJT7tZObIieYGmT/je
         xVNzUNVsl/z/sA6oONsUMOhHZqpXL8fajj4+esHI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/12] rcu: Reset CPU hints when reporting a quiescent state
Date:   Wed,  2 Oct 2019 18:39:01 -0700
Message-Id: <20191003013903.13079-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In some cases, tracing shows that need_heavy_qs is still set even though
urgent_qs was cleared upon reporting of a quiescent state.  One such
case is when the softirq reports that a CPU has passed quiescent state.

Commit 671a63517cf9 ("rcu: Avoid unnecessary softirq when system is
idle") fixed a bug where core_needs_qs was not being cleared.  In order
to avoid running into similar situations with the urgent-grace-period
flags, this commit causes rcu_disable_urgency_upon_qs(), previously
rcu_disable_tick_upon_qs(), to clear the urgency hints, ->rcu_urgent_qs
and ->rcu_need_heavy_qs.  Note that it is possible for CPUs to go
offline with these urgency hints still set.  This is handled because
rcu_disable_urgency_upon_qs() is also invoked during the online process.

Because these hints can be cleared both by the corresponding CPU and by
the grace-period kthread, this commit also adds a number of READ_ONCE()
and WRITE_ONCE() calls.

Tested overnight with rcutorture running for 60 minutes on all
configurations of RCU.

Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
[ paulmck: Clear urgency flags in rcu_disable_urgency_upon_qs(). ]
[ paulmck: Remove ->core_needs_qs from the set cleared at quiescent state. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1601fa6..59527b0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -826,7 +826,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
 		rdp->rcu_forced_tick = true;
 		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 	}
@@ -891,11 +891,14 @@ void rcu_irq_enter_irqson(void)
 }
 
 /*
- * If the scheduler-clock interrupt was enabled on a nohz_full CPU
- * in order to get to a quiescent state, disable it.
+ * If any sort of urgency was applied to the current CPU (for example,
+ * the scheduler-clock interrupt was enabled on a nohz_full CPU) in order
+ * to get to a quiescent state, disable it.
  */
-void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
+void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 {
+	WRITE_ONCE(rdp->rcu_urgent_qs, false);
+	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
 		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		rdp->rcu_forced_tick = false;
@@ -1996,7 +1999,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		if (!offloaded)
 			needwake = rcu_accelerate_cbs(rnp, rdp);
 
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
@@ -2314,7 +2317,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (f(rdp)) {
 					mask |= bit;
-					rcu_disable_tick_upon_qs(rdp);
+					rcu_disable_urgency_upon_qs(rdp);
 				}
 			}
 		}
@@ -3189,7 +3192,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
-		rcu_disable_tick_upon_qs(rdp);
+		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
-- 
2.9.5

