Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A72C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D41206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfHUP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:26:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbfHUP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:26:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LFMgSU021061
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:26:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh66m7krb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:26:51 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Aug 2019 16:26:50 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 16:26:46 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LFQj5A52756760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 15:26:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D36B2066;
        Wed, 21 Aug 2019 15:26:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D6EFB2065;
        Wed, 21 Aug 2019 15:26:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 15:26:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 22AE816C1775; Wed, 21 Aug 2019 08:26:46 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:26:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Reply-To: paulmck@linux.ibm.com
References: <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
 <20190819143314.GT28441@linux.ibm.com>
 <20190819154143.GA18470@linux.ibm.com>
 <20190821143841.GC147977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821143841.GC147977@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19082115-2213-0000-0000-000003BE7A57
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250043; UDB=6.00659946; IPR=6.01031598;
 MB=3.00028262; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-21 15:26:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082115-2214-0000-0000-00005FB84583
Message-Id: <20190821152646.GF28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:38:41AM -0400, Joel Fernandes wrote:
> On Mon, Aug 19, 2019 at 08:41:43AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2019 at 07:33:14AM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 19, 2019 at 05:57:57AM -0700, Paul E. McKenney wrote:
> > > > On Sun, Aug 18, 2019 at 07:29:27PM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Aug 18, 2019 at 09:46:23PM -0400, Joel Fernandes wrote:
> > > > > > On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> > > > > > > On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> > > > > > [snip]
> > > > > > > > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > > > > > > > which implies raising softirq will not do any wake ups."  This mention
> > > > > > > > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > > > > > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > > > > > > > 
> > > > > > > > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > > > > > > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > > > > > > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > > > > > > > path anyway since in_irq() implies in_interrupt().
> > > > > > > > 
> > > > > > > > Please!  Could you also add a first-principles explanation of why
> > > > > > > > the added condition is immune from scheduler deadlocks?
> > > > > > > 
> > > > > > > Sure I can add an example in the change log, however I was thinking of this
> > > > > > > example which you mentioned:
> > > > > > > https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> > > > > > > 
> > > > > > > 	previous_reader()
> > > > > > > 	{
> > > > > > > 		rcu_read_lock();
> > > > > > > 		do_something(); /* Preemption happened here. */
> > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > 		do_something_else();
> > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > 		do_some_other_thing();
> > > > > > > 		local_irq_enable();
> > > > > > > 	}
> > > > > > > 
> > > > > > > 	current_reader() /* QS from previous_reader() is still deferred. */
> > > > > > > 	{
> > > > > > > 		local_irq_disable();  /* Might be the scheduler. */
> > > > > > > 		do_whatever();
> > > > > > > 		rcu_read_lock();
> > > > > > > 		do_whatever_else();
> > > > > > > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > > > > > > 		do_whatever_comes_to_mind();
> > > > > > > 		local_irq_enable();
> > > > > > > 	}
> > > > > > > 
> > > > > > > One modification of the example could be, previous_reader() could also do:
> > > > > > > 	previous_reader()
> > > > > > > 	{
> > > > > > > 		rcu_read_lock();
> > > > > > > 		do_something_that_takes_really_long(); /* causes need_qs in
> > > > > > > 							  the unlock_special_union to be set */
> > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > 		do_something_else();
> > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > 		do_some_other_thing();
> > > > > > > 		local_irq_enable();
> > > > > > > 	}
> > > > > > 
> > > > > > The point you were making in that thread being, current_reader() ->
> > > > > > rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
> > > > > > because previous_reader() sets the deferred_qs bit.
> > > > > > 
> > > > > > Anyway, I will add all of this into the changelog.
> > > > > 
> > > > > Examples are good, but what makes it so that there are no examples of
> > > > > its being unsafe?
> > > > > 
> > > > > And a few questions along the way, some quick quiz, some more serious.
> > > > > Would it be safe if it checked in_interrupt() instead of in_irq()?
> > > > > If not, should the in_interrupt() in the "if" condition preceding the
> > > > > added "else if" be changed to in_irq()?  Would it make sense to add an
> > > > > "|| !irqs_were_disabled" do your new "else if" condition?  Would the
> > > > > body of the "else if" actually be executed in current mainline?
> > > > > 
> > > > > In an attempt to be at least a little constructive, I am doing some
> > > > > testing of this patch overnight, along with a WARN_ON_ONCE() to see if
> > > > > that invoke_rcu_core() is ever reached.
> > > > 
> > > > And that WARN_ON_ONCE() never triggered in two-hour rcutorture runs of
> > > > TREE01, TREE02, TREE03, and TREE09.  (These are the TREE variants in
> > > > CFLIST that have CONFIG_PREEMPT=y.)
> > > > 
> > > > This of course raises other questions.  But first, do you see that code
> > > > executing in your testing?
> > > 
> > > Never mind!  Idiot here forgot the "--bootargs rcutree.use_softirq"...
> > 
> > So this time I ran the test this way:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 10 --configs "TREE01 TREE02 TREE03 TREE09" --bootargs "rcutree.use_softirq=0"
> > 
> > Still no splats.  Though only 10-minute runs instead of the two-hour runs
> > I did last night.  (Got other stuff I need to do, sorry!)
> > 
> > My test version of your patch is shown below.  Please let me know if I messed
> > something up.
> 
> I think you also need to pass rcutorture.irqreader=1 ?

Yes, but rcutorture.irqreader=1 is the default:

rcu-torture:--- Start of test: nreaders=7 nfakewriters=4 stat_interval=15 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=28800 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_barrier_cbs=4 onoff_interval=1000 onoff_holdoff=30

Or from the source-code level:

torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");

> Otherwise seems all readers happen in process context AFAICS.

Yes, should irqreader=0, all readers would happen in process context.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 2defc7fe74c3..abf2fbba2568 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -621,6 +621,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  			// Using softirq, safe to awaken, and we get
> >  			// no help from enabling irqs, unlike bh/preempt.
> >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> > +		} else if (exp && in_irq() && !use_softirq &&
> > +			   !t->rcu_read_unlock_special.b.deferred_qs) {
> > +			WARN_ON_ONCE(1); // Live code?
> > +			invoke_rcu_core();
> >  		} else {
> >  			// Enabling BH or preempt does reschedule, so...
> >  			// Also if no expediting or NO_HZ_FULL, slow is OK.

