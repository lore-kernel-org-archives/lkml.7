Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E15C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D725BA1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfE3Owh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:52:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbfE3Owh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:52:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEprrX041013
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:36 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stfeved6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:36 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:52:35 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:52:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqTiV39256224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A78EDB2067;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7806EB206B;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4251616C5D8A; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/12] rcu: Use irq_work to get scheduler's attention in clean context
Date:   Thu, 30 May 2019 07:52:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0040-0000-0000-000004F681DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210783; UDB=6.00636156; IPR=6.00991817;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:52:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0041-0000-0000-000009029C2A
Message-Id: <20190530145229.29565-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rcu_read_unlock_special() is invoked with interrupts disabled, is
either not in an interrupt handler or is not using RCU_SOFTIRQ, is not
the first RCU read-side critical section in the chain, and either there
is an expedited grace period in flight or this is a NO_HZ_FULL kernel,
the end of the grace period can be unduly delayed.  The reason for this
is that it is not safe to do wakeups in this situation.

This commit fixes this problem by using the irq_work subsystem to
force a later interrupt handler in a clean environment.  Because
set_tsk_need_resched(current) and set_preempt_need_resched() are
invoked prior to this, the scheduler will force a context switch
upon return from this interrupt (though perhaps at the end of any
interrupted preempt-disable or BH-disable region of code), which will
invoke rcu_note_context_switch() (again in a clean environment), which
will in turn give RCU the chance to report the deferred quiescent state.

Of course, by then this task might be within another RCU read-side
critical section.  But that will be detected at that time and reporting
will be further deferred to the outermost rcu_read_unlock().  See
rcu_preempt_need_deferred_qs() and rcu_preempt_deferred_qs() for more
details on the checking.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  2 ++
 kernel/rcu/tree_plugin.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a1a72a1ecb02..21d740f0b8dc 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -161,6 +161,8 @@ struct rcu_data {
 					/*  ticks this CPU has handled */
 					/*  during and after the last grace */
 					/* period it is aware of. */
+	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
+	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
 
 	/* 2) batch handling */
 	struct rcu_segcblist cblist;	/* Segmented callback list, with */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e1005f5e8094..58c7853f19e7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -587,6 +587,17 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
 		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
+/*
+ * Minimal handler to give the scheduler a chance to re-evaluate.
+ */
+static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
+{
+	struct rcu_data *rdp;
+
+	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	rdp->defer_qs_iw_pending = false;
+}
+
 /*
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
@@ -630,6 +641,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
+			if (IS_ENABLED(CONFIG_IRQ_WORK) &&
+			    !rdp->defer_qs_iw_pending && exp) {
+				// Get scheduler to re-evaluate and call hooks.
+				// If !IRQ_WORK, FQS scan will eventually IPI.
+				init_irq_work(&rdp->defer_qs_iw,
+					      rcu_preempt_deferred_qs_handler);
+				rdp->defer_qs_iw_pending = true;
+				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
+			}
 		}
 		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
-- 
2.17.1

