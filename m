Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F17F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbfCZXXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:23:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732945AbfCZXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:22:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNIgwZ098355
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rfuyg3g80-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:22:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:22:32 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:22:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QNMQMr7405792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:22:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A5EB2075;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16ED2B206A;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:22:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CDA6C16C610A; Tue, 26 Mar 2019 16:22:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/11] rcu: Inline RCU stall-warning info helper functions
Date:   Tue, 26 Mar 2019 16:22:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326232208.GA20384@linux.ibm.com>
References: <20190326232208.GA20384@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0060-0000-0000-00000322743A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180136; UDB=6.00617574; IPR=6.00960851;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:22:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0061-0000-0000-000048BCD2B3
Message-Id: <20190326232225.21332-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print_cpu_stall_info_begin() and print_cpu_stall_info_end() print a
single character each onto the console, and are a holdover from a time
when RCU CPU stall warning messages could be abbreviated using a long-gone
Kconfig option.  This commit therefore adds these single characters to
already-printed strings in the calling functions, and then eliminates
both print_cpu_stall_info_begin() and print_cpu_stall_info_end().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  2 --
 kernel/rcu/tree_plugin.h | 12 ------------
 kernel/rcu/tree_stall.h  | 12 ++++--------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c6df9a13dd06..d73472af49e7 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -416,9 +416,7 @@ static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
-static void print_cpu_stall_info_begin(void);
 static void print_cpu_stall_info(int cpu);
-static void print_cpu_stall_info_end(void);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static bool rcu_nocb_cpu_needs_barrier(int cpu);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 72519c57f656..2df5bb04fd7a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1550,12 +1550,6 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 
 #endif /* #else #ifdef CONFIG_RCU_FAST_NO_HZ */
 
-/* Initiate the stall-info list. */
-static void print_cpu_stall_info_begin(void)
-{
-	pr_cont("\n");
-}
-
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -1606,12 +1600,6 @@ static void print_cpu_stall_info(int cpu)
 	       fast_no_hz);
 }
 
-/* Terminate the stall-info list. */
-static void print_cpu_stall_info_end(void)
-{
-	pr_err("\t");
-}
-
 /* Zero ->ticks_this_gp and snapshot the number of RCU softirq handlers. */
 static void zero_cpu_stall_ticks(struct rcu_data *rdp)
 {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b476786b8ef7..7ef3b596e45f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -243,8 +243,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:", rcu_state.name);
-	print_cpu_stall_info_begin();
+	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		ndetected += rcu_print_task_stall(rnp);
@@ -258,10 +257,9 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 
-	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
+	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
 	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
@@ -314,15 +312,13 @@ static void print_cpu_stall(void)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s self-detected stall on CPU", rcu_state.name);
-	print_cpu_stall_info_begin();
+	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
-	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
-	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
+	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
 		jiffies - rcu_state.gp_start,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
-- 
2.17.1

