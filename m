Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49643C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED6D25BBA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfE3Oxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:53:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfE3Oxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:53:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEprCg062082
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:53:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfmbdr6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:53:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:53:50 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:53:46 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqUJo34865584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6085FB205F;
        Thu, 30 May 2019 14:52:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D491CB206A;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 53C5616C5D9E; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/12] rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()
Date:   Thu, 30 May 2019 07:52:25 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0064-0000-0000-000003E70D94
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210783; UDB=6.00636156; IPR=6.00991817;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:53:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0065-0000-0000-00003DAB9879
Message-Id: <20190530145229.29565-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=967 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync_sched_exp_online_cleanup() is invoked at online time to handle
the case where the start of an expedited grace period ran concurrently
with a CPU being taken offline and then immediately being placed online.
It checks to see if RCU needs an expedited quiescent state from the
incoming CPU, sending it an IPI if so.  However, it is quite possible
that sync_sched_exp_online_cleanup() is running on that CPU, in which
case it is considerably less overhead to simply request the quiescent
state locally instead of simulating a self-IPI.

This commit therefore places the last few lines of rcu_exp_handler()
into a new rcu_exp_need_qs() function, which is invoked both by
rcu_exp_handler() and by sync_sched_exp_online_cleanup() in the self-IPI
case.

This also reduces the rcu_exp_handler() function's state space by
removing the direct call that this smp_call_function_single() uses to
emulate the requested self-IPI.  This in turn will allow tighter error
checking in rcu_is_cpu_rrupt_from_idle().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 5390618787b6..de1b4acf6979 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -699,6 +699,16 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
+/* Request an expedited quiescent state. */
+static void rcu_exp_need_qs(void)
+{
+	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
+	/* Store .exp before .rcu_urgent_qs. */
+	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+}
+
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
 static void rcu_exp_handler(void *unused)
 {
@@ -714,25 +724,38 @@ static void rcu_exp_handler(void *unused)
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
-	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
-	/* Store .exp before .rcu_urgent_qs. */
-	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	rcu_exp_need_qs();
 }
 
 /* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
 static void sync_sched_exp_online_cleanup(int cpu)
 {
+	unsigned long flags;
+	int my_cpu;
 	struct rcu_data *rdp;
 	int ret;
 	struct rcu_node *rnp;
 
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
-	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
+	my_cpu = get_cpu();
+	/* Quiescent state either not needed or already requested, leave. */
+	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
+	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp)) {
+		put_cpu();
 		return;
+	}
+	/* Quiescent state needed on current CPU, so set it up locally. */
+	if (my_cpu == cpu) {
+		local_irq_save(flags);
+		rcu_exp_need_qs();
+		local_irq_restore(flags);
+		put_cpu();
+		return;
+	}
+	/* Quiescent state needed on some other CPU, send IPI. */
 	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
+	put_cpu();
 	WARN_ON_ONCE(ret);
 }
 
-- 
2.17.1

