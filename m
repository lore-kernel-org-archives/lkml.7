Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C347C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E7E2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfHAXRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387693AbfHAXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:17:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71ND9YM072093;
        Thu, 1 Aug 2019 19:16:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahy5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:38 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71NDTkq073673;
        Thu, 1 Aug 2019 19:16:38 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahy4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:37 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71NG8fa002023;
        Thu, 1 Aug 2019 23:16:36 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 2u0e879b90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:16:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGa0G45285634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BEA4B2065;
        Thu,  1 Aug 2019 23:16:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DBAB206A;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 15EB116C9A4E; Thu,  1 Aug 2019 16:16:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/10] rcu/nocb: Reduce contention at no-CBs registry-time CB advancement
Date:   Thu,  1 Aug 2019 16:16:32 -0700
Message-Id: <20190801231636.23115-7-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801231619.GA22610@linux.ibm.com>
References: <20190801231619.GA22610@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __call_rcu_nocb_wake() conditionally acquires the leaf rcu_node
structure's ->lock, and only afterwards does rcu_advance_cbs_nowake()
check to see if it is possible to advance callbacks without potentially
needing to awaken the grace-period kthread.  Given that the no-awaken
check can be done locklessly, this commit reverses the order, so that
rcu_advance_cbs_nowake() is invoked without holding the leaf rcu_node
structure's ->lock and rcu_advance_cbs_nowake() checks the grace-period
state before conditionally acquiring that lock, thus reducing the number
of needless acquistions of the leaf rcu_node structure's ->lock.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c        | 5 +++--
 kernel/rcu/tree_plugin.h | 4 +---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a6ddfae6978d..ec320658aeef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1341,10 +1341,11 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 						  struct rcu_data *rdp)
 {
-	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
+	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
+	    !raw_spin_trylock_rcu_node(rnp))
 		return;
 	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
+	raw_spin_unlock_rcu_node(rnp);
 }
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 06b4fe275b3a..a1a2fc9df6d8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1666,10 +1666,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if (!rdp->nocb_cb_sleep &&
 		    rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			// Already going full tilt, so don't try to rewake.
-		} else if (rcu_segcblist_pend_cbs(&rdp->cblist) &&
-			   raw_spin_trylock_rcu_node(rdp->mynode)) {
+		} else if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
-			raw_spin_unlock_rcu_node(rdp->mynode);
 		} else {
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-- 
2.17.1

