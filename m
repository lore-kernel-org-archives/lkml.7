Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DFEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF505208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfE1Uuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:50:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbfE1Uub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:50:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SKg3ht094539
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 16:50:30 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ssayqbmst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 16:50:29 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 28 May 2019 21:50:27 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 21:50:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SKoPvi30933374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 20:50:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59191B2065;
        Tue, 28 May 2019 20:50:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D4B9B2066;
        Tue, 28 May 2019 20:50:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 May 2019 20:50:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EDBA416C8E8A; Tue, 28 May 2019 13:50:30 -0700 (PDT)
Date:   Tue, 28 May 2019 13:50:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: Review of RCU-related patches in -rt
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052820-0052-0000-0000-000003C81555
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011176; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209949; UDB=6.00635652; IPR=6.00990978;
 MB=3.00027091; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 20:50:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052820-0053-0000-0000-00006114D164
Message-Id: <20190528205030.GA27149@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sebastian,

Finally getting around to taking another look:

c7e07056a108 EXP rcu: skip the workqueue path on RT

	This one makes sense given the later commit setting the
	rcu_normal_after_boot kernel parameter.  Otherwise, it is
	slowing down expedited grace periods for no reason.  But
	should the check also include rcu_normal_after_boot and
	rcu_normal?  For example:

		if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
		     (rcu_normal || rcu_normal_after_boot) ||
		    !READ_ONCE(rcu_par_gp_wq) ||
		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
		    rcu_is_last_leaf_node(rnp)) {

	Alternatively, one approach would be to take the kernel
	parameters out in -rt:

		static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
		#ifndef CONFIG_PREEMPT_RT_FULL
		module_param(rcu_normal_after_boot, int, 0);
		#endif

	And similar for rcu_normal and rcu_expedited.

	Or is there some reason to allow run-time expedited grace
	periods in CONFIG_PREEMPT_RT_FULL=y kernels?

d1f52391bd8a rcu: Disable RCU_FAST_NO_HZ on RT

	Looks good.  More complexity could be added if too many people
	get themselves in trouble via "select RCU_FAST_NO_HZ".

42b346870326 rcu: make RCU_BOOST default on RT

	To avoid complaints about this showing up when people don't
	expected, could you please instead "select RCU_BOOST" in
	the Kconfig definition of PREEMPT_RT_FULL?

	Or do people really want to be able to disable boosting?

457c1b0d9c0e sched: Do not account rcu_preempt_depth on RT in might_sleep()

	The idea behind this one is to avoid false-positive complaints
	about -rt's sleeping spinlocks, correct?

7ee13e640b01 rbtree: don't include the rcu header
c9b0c9b87081 rtmutex: annotate sleeping lock context

	No specific comments.

7912d002ebf9 rcu: Eliminate softirq processing from rcutree

	This hasn't caused any problems in -rcu from what I can see.
	I am therefore planning to submit the -rcu variant of this to
	mainline during the next merge window.

f06d34ebdbbb srcu: Remove srcu_queue_delayed_work_on()

	Looks plausible.  I will check more carefully for mainline.

aeb04e894cc9 srcu: replace local_irqsave() with a locallock
e48989b033ad irqwork: push most work into softirq context

	These look to still be -rt only.

							Thanx, Paul

