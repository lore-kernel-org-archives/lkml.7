Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D814C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1334220838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950521;
	bh=QS4T5xpAWAQGTWAbZNcOJsHMEtZKlWCJtg4r+mGgi+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5URHnqJPso4dJLr5LYcsznW3VvypxypbeyW2EDeQIAg4nfNas4JlP3B2pWOPDRz0
	 KJ15jmTeekoaEVx53XF+vXNPoXqDx8gGVA0MZofG87PuKSPQOH0ckgifSeqXIgUdYh
	 vVldrbFl+M/caymvsqr7DJUxtczX6kpi4uqioRmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLJECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfLJEB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:58 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FDD2080D;
        Tue, 10 Dec 2019 04:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950517;
        bh=QS4T5xpAWAQGTWAbZNcOJsHMEtZKlWCJtg4r+mGgi+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyL/n95jXjrIYe0Bhw3BJiOJf8+S0cm0slC5q28I3XafrSwBHcgT9shTFiDuA+JCk
         nESwfRwwOk/MvoweYTvh2hMMbEIgmC/6sxoR5FJcM+pYlQOsIA9qvSZ1Eqgbgw4u9I
         FYgzApWJvtMJh0A2ZPEWhD7R0W7xWMw6NiVV18K8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] rcu: Avoid modifying mask_ofl_ipi in sync_rcu_exp_select_node_cpus()
Date:   Mon,  9 Dec 2019 20:01:46 -0800
Message-Id: <20191210040154.2498-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The "mask_ofl_ipi" is used to track which CPUs get IPIed, however
in the IPI sending loop, "mask_ofl_ipi" along with another variable
"mask_ofl_test" might also get modified to record which CPUs' quiesent
states must be reported by the sync_rcu_exp_select_node_cpus() at
the end of sync_rcu_exp_select_node_cpus().  This overlap of roles
can be confusing, so this patch cleans things a little by using
"mask_ofl_ipi" solely for determining which CPUs must be IPIed  and
"mask_ofl_test" for solely determining on behalf of  which CPUs
sync_rcu_exp_select_node_cpus() must report a quiscent state.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_exp.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 69c5aa6..6a6f328 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		}
 		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 		put_cpu();
-		if (!ret) {
-			mask_ofl_ipi &= ~mask;
+		/* The CPU will report the QS in response to the IPI. */
+		if (!ret)
 			continue;
-		}
+
 		/* Failed, raced with CPU hotplug operation. */
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if ((rnp->qsmaskinitnext & mask) &&
@@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			schedule_timeout_uninterruptible(1);
 			goto retry_ipi;
 		}
-		/* CPU really is offline, so we can ignore it. */
-		if (!(rnp->expmask & mask))
-			mask_ofl_ipi &= ~mask;
+		/* CPU really is offline, so we must report its QS. */
+		if (rnp->expmask & mask)
+			mask_ofl_test |= mask;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	/* Report quiescent states for those that went offline. */
-	mask_ofl_test |= mask_ofl_ipi;
 	if (mask_ofl_test)
 		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
-- 
2.9.5

