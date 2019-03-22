Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7E3218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfCVObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:31:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728639AbfCVObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:31:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MEL6QP011607
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:30:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd0saj7vf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:30:57 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 14:30:58 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 14:30:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MEUp1h24182934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 14:30:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBE55B2066;
        Fri, 22 Mar 2019 14:30:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D548B205F;
        Fri, 22 Mar 2019 14:30:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 14:30:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A3EE516C2A63; Fri, 22 Mar 2019 00:35:53 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:35:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190320234601.GQ4102@linux.ibm.com>
 <20190321233244.GA11476@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321233244.GA11476@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032214-2213-0000-0000-00000368A767
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010794; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178056; UDB=6.00616317; IPR=6.00958755;
 MB=3.00026111; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 14:30:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032214-2214-0000-0000-00005DC2899E
Message-Id: <20190322073553.GA22086@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:32:44PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 20, 2019 at 04:46:01PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 20, 2019 at 10:13:33PM +0100, Sebastian Andrzej Siewior wrote:
> > > Running RCU out of softirq is a problem for some workloads that would
> > > like to manage RCU core processing independently of other softirq
> > > work, for example, setting kthread priority.  This commit therefore
> > > introduces the `rcunosoftirq' option which moves the RCU core work
> > > from softirq to a per-CPU/per-flavor SCHED_OTHER kthread named rcuc.
> > > The SCHED_OTHER approach avoids the scalability problems that appeared
> > > with the earlier attempt to move RCU core processing to from softirq
> > > to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> > > rcuc kthreads at the RCU-boosting priority.
> > > 
> > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > Tested-by: Mike Galbraith <efault@gmx.de>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Thank you!  I reverted v2 and applied this one with the same sort of
> > update.  Testing is going well thus far aside from my failing to add
> > the required "=0" after the rcutree.use_softirq.  I will probably not
> > be the only one who will run afoul of this, so I updated the commit log
> > and the documentation accordingly, as shown below.
> 
> And I took a look, please see updates/questions interspersed.
> 
> I didn't find anything substantive, but still I get hangs.  Which is
> the normal situation.  ;-)
> 
> Will fire off more testing...

And despite my protestations about restrictions involving the scheduler
and rcu_read_unlock(), with the patch below TREE01, TREE02, TREE03, and
TREE09 pass an hour of rcutorture with rcutree.use_softirq=0.  Without
this patch, seven-minute runs get hard hangs and this:

[   18.417315] BUG: spinlock recursion on CPU#5, rcu_torture_rea/763
[   18.418624]  lock: 0xffff9d207eb61940, .magic: dead4ead, .owner: rcu_torture_rea/763, .owner_cpu: 5
[   18.420418] CPU: 5 PID: 763 Comm: rcu_torture_rea Not tainted 5.1.0-rc1+ #1
[   18.421786] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[   18.423375] Call Trace:
[   18.423880]  <IRQ>
[   18.424284]  dump_stack+0x46/0x5b
[   18.424953]  do_raw_spin_lock+0x8d/0x90
[   18.425699]  try_to_wake_up+0x2cd/0x4f0
[   18.426493]  invoke_rcu_core_kthread+0x63/0x80
[   18.427337]  rcu_read_unlock_special+0x41/0x80
[   18.428212]  __rcu_read_unlock+0x48/0x50
[   18.428984]  cpuacct_charge+0x96/0xd0
[   18.429725]  ? cpuacct_charge+0x2e/0xd0
[   18.430463]  update_curr+0x112/0x240
[   18.431172]  enqueue_task_fair+0xa9/0x1220
[   18.432009]  ttwu_do_activate+0x49/0xa0
[   18.432741]  sched_ttwu_pending+0x75/0xa0
[   18.433583]  scheduler_ipi+0x53/0x150
[   18.434291]  reschedule_interrupt+0xf/0x20
[   18.435137]  </IRQ

I clearly need to audit the setting of ->rcu_read_unlock_special.

Again, the patch below is bad for expedited grace periods, so it is
experimental.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ca972b0b2467..d133fa837426 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -607,12 +607,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 		/* Need to defer quiescent state until everything is enabled. */
-		if (irqs_were_disabled) {
+		if (irqs_were_disabled && use_softirq) {
 			/* Enabling irqs does not reschedule, so... */
-			if (use_softirq)
-				raise_softirq_irqoff(RCU_SOFTIRQ);
-			else
-				invoke_rcu_core();
+			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			/* Enabling BH or preempt does reschedule, so... */
 			set_tsk_need_resched(current);

