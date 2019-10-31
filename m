Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69408CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A512087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfJaLzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJaLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92v-00038t-BC; Thu, 31 Oct 2019 12:55:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E6AB31C04E8;
        Thu, 31 Oct 2019 12:55:10 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:10 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make CPU-hotplug removal operations enable tick
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252291056.29376.4271367091061665605.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     96926686deab853bcacf887501f4ed958e38666b
Gitweb:        https://git.kernel.org/tip/96926686deab853bcacf887501f4ed958e38666b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2019 15:12:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 10:46:05 -07:00

rcu: Make CPU-hotplug removal operations enable tick

CPU-hotplug removal operations run the multi_cpu_stop() function, which
relies on the scheduler to gain control from whatever is running on the
various online CPUs, including any nohz_full CPUs running long loops in
kernel-mode code.  Lack of the scheduler-clock interrupt on such CPUs
can delay multi_cpu_stop() for several minutes and can also result in
RCU CPU stall warnings.  This commit therefore causes CPU-hotplug removal
operations to enable the scheduler-clock interrupt on all online CPUs.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
[ paulmck: Apply simplifications suggested by Frederic Weisbecker. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a5c296d..7c67ea5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2101,6 +2101,9 @@ int rcutree_dead_cpu(unsigned int cpu)
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
 	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
+
+	// Stop-machine done, so allow nohz_full to disable tick.
+	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
 }
 
@@ -3085,6 +3088,9 @@ int rcutree_online_cpu(unsigned int cpu)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
 	rcutree_affinity_setting(cpu, -1);
+
+	// Stop-machine done, so allow nohz_full to disable tick.
+	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
 }
 
@@ -3105,6 +3111,9 @@ int rcutree_offline_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
+
+	// nohz_full CPUs need the tick for stop-machine to work quickly
+	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
 }
 
