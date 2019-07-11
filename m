Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C064C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566D21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfGKPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:02:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728491AbfGKPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:02:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BEvuUW145133
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 11:02:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tp5y5cftt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 11:02:30 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 11 Jul 2019 16:02:21 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 16:02:17 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BF2GMf51118368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 15:02:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B53B2064;
        Thu, 11 Jul 2019 15:02:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F84B205F;
        Thu, 11 Jul 2019 15:02:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.190.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 15:02:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4CF2C16C39C0; Thu, 11 Jul 2019 08:02:15 -0700 (PDT)
Date:   Thu, 11 Jul 2019 08:02:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711130849.GA212044@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19071115-0072-0000-0000-000004479A25
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011408; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230671; UDB=6.00648239; IPR=6.01011946;
 MB=3.00027681; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-11 15:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071115-0073-0000-0000-00004CB7DEAE
Message-Id: <20190711150215.GK26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:08:49AM -0400, Joel Fernandes wrote:
> On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > > can also want to tune the time for the help from scheduler to start.
> > > > > I thought only difference between them is a level of urgency. I might be
> > > > > wrong. It would be appreciated if you let me know if I miss something.
> > > > 
> > > > Hello, Byungchul,
> > > > 
> > > > I understand that one hypothetically might want to tune this at runtime,
> > > > but have you had need to tune this at runtime on a real production
> > > > workload?  If so, what problem was happening that caused you to want to
> > > > do this tuning?
> > > 
> > > Not actually.
> > > 
> > > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > > 
> > > > If there is a real need, something needs to be provided to meet that
> > > > need.  But in the absence of a real need, past experience has shown
> > > > that speculative tuning knobs usually do more harm than good.  ;-)
> > > 
> > > It makes sense, "A speculative tuning knobs do more harm than good".
> > > 
> > > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > > but jiffies_till_sched_qs until we need it.
> > > 
> > > However,
> > > 
> > > (1) In case that jiffies_till_sched_qs is tunnable:
> > > 
> > > 	We might need all of jiffies_till_{first,next}_qs,
> > > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > > 	jiffies_to_sched_qs can be affected by any of them. So we
> > > 	should be able to read each value at any time.
> > > 
> > > (2) In case that jiffies_till_sched_qs is not tunnable:
> > > 
> > > 	I think we don't have to keep the jiffies_till_sched_qs any
> > > 	longer since that's only for setting jiffies_to_sched_qs at
> > > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > > 	It's meaningless to keep all of tree variables.
> > > 
> > > The simpler and less knobs that we really need we have, the better.
> > > 
> > > what do you think about it?
> > > 
> > > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > > think jiffies_till_sched_qs is a much better name for the purpose. I
> > > will resend it with a commit msg after knowing your opinion on it.
> > 
> > I will give you a definite "maybe".
> > 
> > Here are the two reasons for changing RCU's embarrassingly large array
> > of tuning parameters:
> > 
> > 1.	They are causing a problem in production.  This would represent a
> > 	bug that clearly must be fixed.  As you say, this change is not
> > 	in this category.
> > 
> > 2.	The change simplifies either RCU's code or the process of tuning
> > 	RCU, but without degrading RCU's ability to run everywhere and
> > 	without removing debugging tools.
> > 
> > The change below clearly simplifies things by removing a few lines of
> > code, and it does not change RCU's default self-configuration.  But are
> > we sure about the debugging aspect?  (Please keep in mind that many more
> > sites are willing to change boot parameters than are willing to patch
> > their kernels.)
> > 
> > What do you think?
> 
> Just to add that independent of whether the runtime tunable make sense or
> not, may be it is still worth correcting the 0444 to be 0644 to be a separate
> patch?

You lost me on this one.  Doesn't changing from 0444 to 0644 make it be
a runtime tunable?

> > Finally, I urge you to join with Joel Fernandes and go through these
> > grace-period-duration tuning parameters.  Once you guys get your heads
> > completely around all of them and how they interact across the different
> > possible RCU configurations, I bet that the two of you will have excellent
> > ideas for improvement.
> 
> Yes, I am quite happy to join forces. Byungchul, let me know what about this
> or other things you had in mind. I have some other RCU topics too I am trying
> to get my head around and planning to work on more patches.
> 
> Paul, in case you had any other specific tunables or experiments in mind, let
> me know. I am quite happy to try out new experiments and learn something
> based on tuning something.

These would be the tunables controlling how quickly RCU takes its
various actions to encourage the current grace period to end quickly.
I would be happy to give you the exact list if you wish, but most of
them have appeared in this thread.

The experiments should be designed to work out whether the current
default settings have configurations where they act badly.  This might
also come up with advice for people attempting hand-tuning, or proposed
parameter-checking code to avoid bad combinations.

For one example, setting the RCU CPU stall timeout too low will definitely
cause some unwanted splats.  (Yes, one could argue that other things in
the kernel should change to allow this value to decrease, but things
like latency tracer and friends are probably more useful and important.)

							Thanx, Paul

> thanks,
> 
> - Joel
> 
> 
> 
> > > Thanks,
> > > Byungchul
> > > 
> > > ---8<---
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index e72c184..94b58f5 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3792,10 +3792,6 @@
> > >  			a value based on the most recent settings
> > >  			of rcutree.jiffies_till_first_fqs
> > >  			and rcutree.jiffies_till_next_fqs.
> > > -			This calculated value may be viewed in
> > > -			rcutree.jiffies_to_sched_qs.  Any attempt to set
> > > -			rcutree.jiffies_to_sched_qs will be cheerfully
> > > -			overwritten.
> > >  
> > >  	rcutree.kthread_prio= 	 [KNL,BOOT]
> > >  			Set the SCHED_FIFO priority of the RCU per-CPU
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a2f8ba2..ad9dc86 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -421,10 +421,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > >   * How long the grace period must be before we start recruiting
> > >   * quiescent-state help from rcu_note_context_switch().
> > >   */
> > > -static ulong jiffies_till_sched_qs = ULONG_MAX;
> > > +static ulong jiffies_till_sched_qs = ULONG_MAX; /* See adjust_jiffies_till_sched_qs(). */
> > >  module_param(jiffies_till_sched_qs, ulong, 0444);
> > > -static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> > >  
> > >  /*
> > >   * Make sure that we give the grace-period kthread time to detect any
> > > @@ -436,18 +434,13 @@ static void adjust_jiffies_till_sched_qs(void)
> > >  {
> > >  	unsigned long j;
> > >  
> > > -	/* If jiffies_till_sched_qs was specified, respect the request. */
> > > -	if (jiffies_till_sched_qs != ULONG_MAX) {
> > > -		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > > -		return;
> > > -	}
> > >  	/* Otherwise, set to third fqs scan, but bound below on large system. */
> > >  	j = READ_ONCE(jiffies_till_first_fqs) +
> > >  		      2 * READ_ONCE(jiffies_till_next_fqs);
> > >  	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > >  		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > >  	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > > -	WRITE_ONCE(jiffies_to_sched_qs, j);
> > > +	WRITE_ONCE(jiffies_till_sched_qs, j);
> > >  }
> > >  
> > >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > > @@ -1033,16 +1026,16 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> > >  
> > >  	/*
> > >  	 * A CPU running for an extended time within the kernel can
> > > -	 * delay RCU grace periods: (1) At age jiffies_to_sched_qs,
> > > -	 * set .rcu_urgent_qs, (2) At age 2*jiffies_to_sched_qs, set
> > > +	 * delay RCU grace periods: (1) At age jiffies_till_sched_qs,
> > > +	 * set .rcu_urgent_qs, (2) At age 2*jiffies_till_sched_qs, set
> > >  	 * both .rcu_need_heavy_qs and .rcu_urgent_qs.  Note that the
> > >  	 * unsynchronized assignments to the per-CPU rcu_need_heavy_qs
> > >  	 * variable are safe because the assignments are repeated if this
> > >  	 * CPU failed to pass through a quiescent state.  This code
> > > -	 * also checks .jiffies_resched in case jiffies_to_sched_qs
> > > +	 * also checks .jiffies_resched in case jiffies_till_sched_qs
> > >  	 * is set way high.
> > >  	 */
> > > -	jtsq = READ_ONCE(jiffies_to_sched_qs);
> > > +	jtsq = READ_ONCE(jiffies_till_sched_qs);
> > >  	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> > >  	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> > >  	if (!READ_ONCE(*rnhqp) &&
> > > @@ -3383,7 +3376,8 @@ static void __init rcu_init_geometry(void)
> > >  		jiffies_till_first_fqs = d;
> > >  	if (jiffies_till_next_fqs == ULONG_MAX)
> > >  		jiffies_till_next_fqs = d;
> > > -	adjust_jiffies_till_sched_qs();
> > > +	if (jiffies_till_sched_qs == ULONG_MAX)
> > > +		adjust_jiffies_till_sched_qs();
> > >  
> > >  	/* If the compile-time values are accurate, just leave. */
> > >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> > 

