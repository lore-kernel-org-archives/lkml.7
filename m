Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C28C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17E2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfHAWvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:51:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390131AbfHAWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:51:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MlCE9104882;
        Thu, 1 Aug 2019 18:50:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48upgms7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:31 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MlMID106385;
        Thu, 1 Aug 2019 18:50:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48upgmrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:50:30 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MnZBp021128;
        Thu, 1 Aug 2019 22:50:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87h80h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:50:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MoTSb43188654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:50:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D64B207D;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5854B206C;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C855216C9A52; Thu,  1 Aug 2019 15:50:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/11] rcu/nocb: Rename __wake_nocb_leader() to __wake_nocb_gp()
Date:   Thu,  1 Aug 2019 15:50:23 -0700
Message-Id: <20190801225028.18225-6-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801225009.GA17155@linux.ibm.com>
References: <20190801225009.GA17155@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adjusts naming to account for the new distinction between
callback and grace-period no-CBs kthreads.  While in the area, it also
updates local variables.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 632c2cfb9856..7c7870da234a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1524,24 +1524,24 @@ bool rcu_is_nocb_cpu(int cpu)
  * Kick the GP kthread for this NOCB group.  Caller holds ->nocb_lock
  * and this function releases it.
  */
-static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
-			       unsigned long flags)
+static void __wake_nocb_gp(struct rcu_data *rdp, bool force,
+			   unsigned long flags)
 	__releases(rdp->nocb_lock)
 {
-	struct rcu_data *rdp_leader = rdp->nocb_gp_rdp;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	lockdep_assert_held(&rdp->nocb_lock);
-	if (!READ_ONCE(rdp_leader->nocb_gp_kthread)) {
+	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		return;
 	}
-	if (rdp_leader->nocb_gp_sleep || force) {
+	if (rdp_gp->nocb_gp_sleep || force) {
 		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
-		WRITE_ONCE(rdp_leader->nocb_gp_sleep, false);
+		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		del_timer(&rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		smp_mb(); /* ->nocb_gp_sleep before swake_up_one(). */
-		swake_up_one(&rdp_leader->nocb_gp_wq);
+		swake_up_one(&rdp_gp->nocb_gp_wq);
 	} else {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	}
@@ -1556,7 +1556,7 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-	__wake_nocb_leader(rdp, force, flags);
+	__wake_nocb_gp(rdp, force, flags);
 }
 
 /*
@@ -1988,7 +1988,7 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 	}
 	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-	__wake_nocb_leader(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	__wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 }
 
-- 
2.17.1

