Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B375EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E81222CE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066761;
	bh=t8dOztihM4jRTxXHKG16m4sv8yQked4/7cFoEOKxFzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsHYvfZNwCoZ0a4FE1O6gKn4mRXxOwkq/+huvI8ck8vbsb9SpyRw8CHYwdZuEOJcw
	 dF1s7CLnga42f80tZF1Nj3DcgIf5bQ+kcygGJs8cGGpD25AkmUJ4CSZnNiZos7ERKg
	 OTpwWgTxtIjxRw4YjF0nKHMQmkx0NIDv/kiQ5Gic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfJCBjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfJCBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830AD222C8;
        Thu,  3 Oct 2019 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066746;
        bh=t8dOztihM4jRTxXHKG16m4sv8yQked4/7cFoEOKxFzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0WtQSFYpwdisb5S1Z0tiAVYf3MopmUCLNBYy3aOy7W73PlaNrI7SHGEohxhJnUAu
         CqSSNibye3X/VdcYI5yy5qhzj737j4e4F3wdrMAU2PkQ6DMnlzig79OiMMCIKeG8AA
         nCwYTYr3qQlht8JWZKMudCKZbzL+Obl1ABAWHI2k=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 04/12] rcutorture: Force on tick for readers and callback flooders
Date:   Wed,  2 Oct 2019 18:38:55 -0700
Message-Id: <20191003013903.13079-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Readers and callback flooders in the rcutorture stress-test suite run for
extended time periods by design.  They do take pains to relinquish the
CPU from time to time, but in some cases this relies on the scheduler
being active, which in turn relies on the scheduler-clock interrupt
firing from time to time.

This commit therefore forces scheduling-clock interrupts within
these loops.  While in the area, this commit also prevents
rcu_torture_reader()'s occasional timed sleeps from delaying shutdown.

[ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca..1ce6a7e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -44,6 +44,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
+#include <linux/tick.h>
 
 #include "rcu.h"
 
@@ -1363,15 +1364,16 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
 				mod_timer(&t, jiffies + 1);
 		}
-		if (!rcu_torture_one_read(&rand))
+		if (!rcu_torture_one_read(&rand) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
-		if (time_after(jiffies, lastsleep)) {
+		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
 			schedule_timeout_interruptible(1);
 			lastsleep = jiffies + 10;
 		}
@@ -1383,6 +1385,8 @@ rcu_torture_reader(void *arg)
 		del_timer_sync(&t);
 		destroy_timer_on_stack(&t);
 	}
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 	torture_kthread_stopping("rcu_torture_reader");
 	return 0;
 }
@@ -1729,10 +1733,10 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 		// Real call_rcu() floods hit userspace, so emulate that.
 		if (need_resched() || (iter & 0xfff))
 			schedule();
-	} else {
-		// No userspace emulation: CB invocation throttles call_rcu()
-		cond_resched();
+		return;
 	}
+	// No userspace emulation: CB invocation throttles call_rcu()
+	cond_resched();
 }
 
 /*
@@ -1865,6 +1869,8 @@ static void rcu_torture_fwd_prog_cr(void)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rcu_launder_gp_seq_start = gps;
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
@@ -1911,6 +1917,8 @@ static void rcu_torture_fwd_prog_cr(void)
 		rcu_torture_fwd_cb_hist();
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
+	if (IS_ENABLED(CONFIG_NO_HZ_FULL))
+		tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
 }
 
-- 
2.9.5

