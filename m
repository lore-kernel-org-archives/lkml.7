Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325F25BAC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfE3Owk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:52:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfE3Owi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:52:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpqXR105311
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:37 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgu3sjhm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:36 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:52:35 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:52:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqTmR37879820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 893E2B2066;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B1EBB2068;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 35E3C16C5D84; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/12] rcu: Only do rcu_read_unlock_special() wakeups if expedited
Date:   Thu, 30 May 2019 07:52:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0052-0000-0000-000003C912BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210783; UDB=6.00636156; IPR=6.00991817;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:52:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0053-0000-0000-0000611A1069
Message-Id: <20190530145229.29565-3-paulmck@linux.ibm.com>
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

Currently, rcu_read_unlock_special() will do wakeups whenever it is safe
to do so.  However, wakeups are expensive, and they are only really
needed when the just-ended RCU read-side critical section is blocking
an expedited grace period (in which case speed is of the essence)
or on a nohz_full CPU (where it might be a good long time before an
interrupt arrives).  This commit therefore checks for these conditions,
and does the expensive wakeups only if doing so would be useful.

Note it can be rather expensive to determine whether or not the current
task (as opposed to the current CPU) is blocking the current expedited
grace period.  Doing so requires traversing the ->blkd_tasks list, which
can be quite long.  This commit therefore cheats:  If the current task
is on a given ->blkd_tasks list, and some task on that list is blocking
the current expedited grace period, the code assumes that the current
task is blocking that expedited grace period.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 75110ea75d01..d15cdab6aeb4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -606,20 +606,28 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
+		bool exp;
+		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+		struct rcu_node *rnp = rdp->mynode;
+
 		t->rcu_read_unlock_special.b.exp_hint = false;
+		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
+		      (rdp->grpmask & rnp->expmask) ||
+		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
-		if (irqs_were_disabled && use_softirq &&
+		if (exp && irqs_were_disabled && use_softirq &&
 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
-		} else if (irqs_were_disabled && !use_softirq &&
+		} else if (exp && irqs_were_disabled && !use_softirq &&
 			   !t->rcu_read_unlock_special.b.deferred_qs) {
 			// Safe to awaken and we get no help from enabling
 			// irqs, unlike bh/preempt.
 			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
+			// Also if no expediting or NO_HZ_FULL, slow is OK.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}
-- 
2.17.1

