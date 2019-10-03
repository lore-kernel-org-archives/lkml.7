Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FAF222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066780;
	bh=LRIWSPHZafJqQ6wvcH4sR9Kf82LcG8I3tiNau/DRovM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INwWpi/YIeywsyAuDWwSsIAlyLIvO0pb9zJ4MtXYxoTbaWsRpHD1vPVbsredJ9saC
	 EYkQCrdw8D98iReSvbQ4bHPh/sz6UIxXTkEiRNBfHU9tTTFG63y7Pk9hMGDHGWUq5T
	 vnUiJZbaGQXA0cECo753pUZyOJJgfqMjbHqhj+tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfJCBjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfJCBjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E888222CA;
        Thu,  3 Oct 2019 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066747;
        bh=LRIWSPHZafJqQ6wvcH4sR9Kf82LcG8I3tiNau/DRovM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN8AY+WLV8dclOFKpqvcGcNl+pUo5YFoPngyBn8QfpigUivkFkhkT80CRTX8buchW
         1Txc+naATYkl3MubUoULLprQkvKSxLU2PSwLEeM04ZFxsXxztNSm+XXOL1rTyyLEml
         P20zZYKA4IPidhL7BL6P/d2J9MDGOsUydcSd5bL8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/12] rcu: Make CPU-hotplug removal operations enable tick
Date:   Wed,  2 Oct 2019 18:38:57 -0700
Message-Id: <20191003013903.13079-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

CPU-hotplug removal operations run the multi_cpu_stop() function, which
relies on the scheduler to gain control from whatever is running on the
various online CPUs, including any nohz_full CPUs running long loops in
kernel-mode code.  Lack of the scheduler-clock interrupt on such CPUs
can delay multi_cpu_stop() for several minutes and can also result in
RCU CPU stall warnings.  This commit therefore causes CPU-hotplug removal
operations to enable the scheduler-clock interrupt on all online CPUs.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f708d54..74bf5c65 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2091,6 +2091,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
+	int c;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
@@ -2101,6 +2102,10 @@ int rcutree_dead_cpu(unsigned int cpu)
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
 	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
+
+	// Stop-machine done, so allow nohz_full to disable tick.
+	for_each_online_cpu(c)
+		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
 	return 0;
 }
 
@@ -3074,6 +3079,7 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
  */
 int rcutree_online_cpu(unsigned int cpu)
 {
+	int c;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -3087,6 +3093,10 @@ int rcutree_online_cpu(unsigned int cpu)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
 	rcutree_affinity_setting(cpu, -1);
+
+	// Stop-machine done, so allow nohz_full to disable tick.
+	for_each_online_cpu(c)
+		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);
 	return 0;
 }
 
@@ -3096,6 +3106,7 @@ int rcutree_online_cpu(unsigned int cpu)
  */
 int rcutree_offline_cpu(unsigned int cpu)
 {
+	int c;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -3107,6 +3118,10 @@ int rcutree_offline_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
+
+	// nohz_full CPUs need the tick for stop-machine to work quickly
+	for_each_online_cpu(c)
+		tick_dep_set_cpu(c, TICK_DEP_BIT_RCU);
 	return 0;
 }
 
-- 
2.9.5

