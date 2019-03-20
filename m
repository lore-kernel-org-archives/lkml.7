Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E044CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3A621841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCTR3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726644AbfCTR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KHO6Mv114482
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:29:17 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbrpgkytt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:29:17 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Mar 2019 17:29:14 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 17:29:10 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KHTBXO21364986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 17:29:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97A39B2066;
        Wed, 20 Mar 2019 17:29:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6876CB206B;
        Wed, 20 Mar 2019 17:29:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 17:29:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E05EF16C1B3D; Wed, 20 Mar 2019 10:30:01 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:30:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190318022434.GE4102@linux.ibm.com>
 <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
 <20190320113219.d6c3gouqbnsnl5nj@linutronix.de>
 <20190320152146.GH4102@linux.ibm.com>
 <20190320154440.GA16332@linux.ibm.com>
 <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320163532.mr32oi53iaueuizw@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032017-0068-0000-0000-000003A89C10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177162; UDB=6.00615777; IPR=6.00957858;
 MB=3.00026075; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 17:29:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032017-0069-0000-0000-000047E1DB4F
Message-Id: <20190320173001.GM4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 05:35:32PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-03-20 09:15:00 [-0700], Paul E. McKenney wrote:
> > I am considering making it a module_param() to avoid namespace pollution,
> > as it would become something like rcutree.nosoftirq.
> > 
> > Thoughts?
> 
> nope, perfect.

Please see below for an untested patch.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d377a2166b79..767cdea30a1c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3672,6 +3672,10 @@
 			the propagation of recent CPU-hotplug changes up
 			the rcu_node combining tree.
 
+	rcutree.nosoftirq=	[KNL]
+			If set, move all RCU_SOFTIRQ processing to per-CPU
+			rcuc kthreads.  Defaults to using RCU_SOFTIRQ.
+
 	rcutree.rcu_fanout_exact= [KNL]
 			Disable autobalancing of the rcu_node combining
 			tree.  This is used by rcutorture, and might
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 961dbc7b8949..e4baba8800f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -98,6 +98,9 @@ struct rcu_state rcu_state = {
 /* Dump rcu_node combining tree at boot to verify correct setup. */
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
+/* Move RCU_SOFTIRQ to rcuc kthreads. */
+static bool nosoftirq;
+module_param(nosoftirq, bool, 0444);
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
@@ -2330,15 +2333,6 @@ static void rcu_wake_cond(struct task_struct *t, int status)
 		wake_up_process(t);
 }
 
-static bool rcu_softirq_enabled = true;
-
-static int __init rcunosoftirq_setup(char *str)
-{
-	rcu_softirq_enabled = false;
-	return 0;
-}
-__setup("rcunosoftirq", rcunosoftirq_setup);
-
 /*
  * Wake up this CPU's rcuc kthread to do RCU core processing.
  */
@@ -2349,7 +2343,7 @@ static void invoke_rcu_core(void)
 
 	if (!cpu_online(smp_processor_id()))
 		return;
-	if (rcu_softirq_enabled) {
+	if (!nosoftirq) {
 		raise_softirq(RCU_SOFTIRQ);
 	} else {
 		local_irq_save(flags);
@@ -2424,7 +2418,7 @@ static int __init rcu_spawn_core_kthreads(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
-	if (!IS_ENABLED(CONFIG_RCU_BOOST) && rcu_softirq_enabled)
+	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !nosoftirq)
 		return 0;
 	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
 	return 0;
@@ -3467,7 +3461,7 @@ void __init rcu_init(void)
 	rcu_init_one();
 	if (dump_tree)
 		rcu_dump_rcu_node_tree();
-	if (rcu_softirq_enabled)
+	if (!nosoftirq)
 		open_softirq(RCU_SOFTIRQ, rcu_core_si);
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index eb99e750a930..c5a2acb2c7af 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -72,6 +72,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
 	if (gp_cleanup_delay)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
+	if (nosoftirq)
+		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
 		pr_info("\tRCU debug extended QS entry/exit.\n");
 	rcupdate_announce_bootup_oddness();

