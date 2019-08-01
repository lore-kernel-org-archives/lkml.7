Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4576CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173092083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfHAXRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:17:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387739AbfHAXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:17:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NDATN072139;
        Thu, 1 Aug 2019 19:16:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahy5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:38 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71NDPRH073359;
        Thu, 1 Aug 2019 19:16:38 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hahy4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 19:16:37 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71NG23f024654;
        Thu, 1 Aug 2019 23:16:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2u0e879eee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 23:16:36 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71NGaG449414460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 23:16:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13A3CB2067;
        Thu,  1 Aug 2019 23:16:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA765B2070;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 23:16:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2024316C9A50; Thu,  1 Aug 2019 16:16:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/10] rcu/nocb: Reduce ->nocb_lock contention with separate ->nocb_gp_lock
Date:   Thu,  1 Aug 2019 16:16:34 -0700
Message-Id: <20190801231636.23115-9-paulmck@linux.ibm.com>
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

The sleep/wakeup of the no-CBs grace-period kthreads is synchronized
using the ->nocb_lock of the first CPU corresponding to that kthread.
This commit provides a separate ->nocb_gp_lock for this purpose, thus
reducing contention on ->nocb_lock.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        | 3 ++-
 kernel/rcu/tree_plugin.h | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7062f9d9c053..2c3e9068671c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -202,7 +202,8 @@ struct rcu_data {
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 
 	/* The following fields are used by GP kthread, hence own cacheline. */
-	bool nocb_gp_sleep ____cacheline_internodealigned_in_smp;
+	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
+	bool nocb_gp_sleep;
 					/* Is the nocb GP thread asleep? */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7fbf2c4411a1..af9cbc7d4784 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1602,9 +1602,9 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 		del_timer(&rdp->nocb_timer);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		smp_mb(); /* enqueue before ->nocb_gp_sleep. */
-		rcu_nocb_lock_irqsave(rdp_gp, flags);
+		raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
-		rcu_nocb_unlock_irqrestore(rdp_gp, flags);
+		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 	} else {
 		rcu_nocb_unlock_irqrestore(rdp, flags);
@@ -1759,9 +1759,9 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
 	}
 	if (!rcu_nocb_poll) {
-		rcu_nocb_lock_irqsave(my_rdp, flags);
+		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
-		rcu_nocb_unlock_irqrestore(my_rdp, flags);
+		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
 	WARN_ON(signal_pending(current));
 }
@@ -1941,6 +1941,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	init_swait_queue_head(&rdp->nocb_cb_wq);
 	init_swait_queue_head(&rdp->nocb_gp_wq);
 	raw_spin_lock_init(&rdp->nocb_lock);
+	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 }
 
-- 
2.17.1

