Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFAE2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfFTWcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:32:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfFTWcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:32:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KMOO8S146246
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:32:10 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8ht02esn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:32:10 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 23:32:09 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 23:32:06 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KMW6dT38011304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:32:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9A97B2064;
        Thu, 20 Jun 2019 22:32:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDCB0B2066;
        Thu, 20 Jun 2019 22:32:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 22:32:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CCB2016C2A15; Thu, 20 Jun 2019 15:32:07 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:32:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Review of RCU-related patches in -rt
Reply-To: paulmck@linux.ibm.com
References: <20190528205030.GA27149@linux.ibm.com>
 <20190607160857.nsxkrytedyfroxf3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607160857.nsxkrytedyfroxf3@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062022-0052-0000-0000-000003D35B5C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011299; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220894; UDB=6.00642290; IPR=6.01002032;
 MB=3.00027398; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 22:32:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062022-0053-0000-0000-00006165ACD3
Message-Id: <20190620223207.GC26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 06:08:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-28 13:50:30 [-0700], Paul E. McKenney wrote:
> > Hello, Sebastian,
> Hi Paul,
> 
> > Finally getting around to taking another look:
> > 
> > c7e07056a108 EXP rcu: skip the workqueue path on RT
> > 
> > 	This one makes sense given the later commit setting the
> > 	rcu_normal_after_boot kernel parameter.  Otherwise, it is
> > 	slowing down expedited grace periods for no reason.  But
> > 	should the check also include rcu_normal_after_boot and
> > 	rcu_normal?  For example:
> > 
> > 		if ((IS_ENABLED(CONFIG_PREEMPT_RT_FULL) &&
> > 		     (rcu_normal || rcu_normal_after_boot) ||
> > 		    !READ_ONCE(rcu_par_gp_wq) ||
> > 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> > 		    rcu_is_last_leaf_node(rnp)) {
> 
> I recently dropped that patch from the queue because the workqueue
> problem vanished.
> 
> > 	Alternatively, one approach would be to take the kernel
> > 	parameters out in -rt:
> > 
> > 		static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> > 		#ifndef CONFIG_PREEMPT_RT_FULL
> > 		module_param(rcu_normal_after_boot, int, 0);
> > 		#endif
> > 
> > 	And similar for rcu_normal and rcu_expedited.
> 
> This makes sense.
> 
> > 	Or is there some reason to allow run-time expedited grace
> > 	periods in CONFIG_PREEMPT_RT_FULL=y kernels?
> 
> No, I doubt there is any need to use the `expedited' version. The
> problem is that it increases latencies.
> 
> > d1f52391bd8a rcu: Disable RCU_FAST_NO_HZ on RT
> > 
> > 	Looks good.  More complexity could be added if too many people
> > 	get themselves in trouble via "select RCU_FAST_NO_HZ".
> 
> That patch disables RCU_FAST_NO_HZ and claims that it has something to
> do with a timer_list timer and IRQ-off section. We couldn't schedule
> timers from IRQ-off regions but not anymore. Only del_timer_sync() can't
> be invoked from IRQ-off regions.
> I just booted a box with this enabled together with NO_HZ/ NO_HZ_FULL
> and I not complains yet. So I might drop that…
> 
> > 42b346870326 rcu: make RCU_BOOST default on RT
> > 
> > 	To avoid complaints about this showing up when people don't
> > 	expected, could you please instead "select RCU_BOOST" in
> > 	the Kconfig definition of PREEMPT_RT_FULL?
> > 
> > 	Or do people really want to be able to disable boosting?
> 
> I have no idea. I guess most people don't know what it does and stay
> with the default. It become default on RT once a few people complained
> that they run OOM during boot on some "memory contrained systems". That
> option avoided it.
> So yes, will make it depend on RT.
> 
> > 457c1b0d9c0e sched: Do not account rcu_preempt_depth on RT in might_sleep()
> > 
> > 	The idea behind this one is to avoid false-positive complaints
> > 	about -rt's sleeping spinlocks, correct?
> 
> Correct. Maybe we could invoke a different schedule() primitiv so RCU is
> aware that this is a sleeping spinlock and not a regular sleeping lock.
> 
> > 7ee13e640b01 rbtree: don't include the rcu header
> > c9b0c9b87081 rtmutex: annotate sleeping lock context
> > 
> > 	No specific comments.
> > 
> > 7912d002ebf9 rcu: Eliminate softirq processing from rcutree
> > 
> > 	This hasn't caused any problems in -rcu from what I can see.
> > 	I am therefore planning to submit the -rcu variant of this to
> > 	mainline during the next merge window.
> 
> wonderful.
> 
> > f06d34ebdbbb srcu: Remove srcu_queue_delayed_work_on()
> > 
> > 	Looks plausible.  I will check more carefully for mainline.
> 
> Hmmm. I though this was already upstream.
> That said, we can now schedule work from a preempt_disable() section but
> I still like the negative diffstat here :)

Right you are!  e81baf4cb19a ("srcu: Remove srcu_queue_delayed_work_on()")
is in v5.1.

> > aeb04e894cc9 srcu: replace local_irqsave() with a locallock
> > e48989b033ad irqwork: push most work into softirq context
> > 
> > 	These look to still be -rt only.
> 
> I might get rid of the local_lock in srcu. Will have to check.
> 
> Thank you Paul.

And you!  I will check again in a few months, for some definition of "a few".

							Thanx, Paul

