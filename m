Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E2C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E020620B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 19:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0TPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:15:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfF0TPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 15:15:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RJD81v066933;
        Thu, 27 Jun 2019 15:14:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td0frhqwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 15:14:22 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5RJDgqJ071610;
        Thu, 27 Jun 2019 15:14:22 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td0frhqvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 15:14:21 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5RJ9ewe020392;
        Thu, 27 Jun 2019 19:14:20 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2t9by78e4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 19:14:20 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RJEKpr54788544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 19:14:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D77CB205F;
        Thu, 27 Jun 2019 19:14:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3BE8B2064;
        Thu, 27 Jun 2019 19:14:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 19:14:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 12B2016C5D5C; Thu, 27 Jun 2019 12:14:22 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:14:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627191421.GB26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de>
 <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
 <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
 <20190627181112.GY26519@linux.ibm.com>
 <20190627182722.GA216610@google.com>
 <20190627185103.GA8956@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627185103.GA8956@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:51:03PM -0400, Joel Fernandes wrote:
> On Thu, Jun 27, 2019 at 02:27:22PM -0400, Joel Fernandes wrote:
> > On Thu, Jun 27, 2019 at 11:11:12AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 27, 2019 at 01:46:27PM -0400, Joel Fernandes wrote:
> > > > On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> > > > > <bigeasy@linutronix.de> wrote:
> > > > > >
> > > > > > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > > > > > Sebastian it would be nice if possible to trace where the
> > > > > > > t->rcu_read_unlock_special is set for this scenario of calling
> > > > > > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > > > > > really because of an IPI. I guess we could also add additional RCU
> > > > > > > debug fields to task_struct (just for debugging) to see where there
> > > > > > > unlock_special is set.
> > > > > > >
> > > > > > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > > > > > machine with "threadirqs" and run into it?
> > > > > >
> > > > > > Do you want to send me a patch or should I send you my kvm image which
> > > > > > triggers the bug on boot?
> > > > >
> > > > > I could reproduce this as well just booting Linus tree with threadirqs
> > > > > command line and running rcutorture. In 15 seconds or so it locks
> > > > > up... gdb backtrace shows the recursive lock:
> > > > 
> > > > Sorry that got badly wrapped, so I pasted it here:
> > > > https://hastebin.com/ajivofomik.shell
> > > 
> > > Which rcutorture scenario would that be?  TREE03 is thus far refusing
> > > to fail for me when run this way:
> > > 
> > > $ tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --trust-make --configs "TREE03" --bootargs "threadirqs"
> > 
> > I built x86_64_defconfig with CONFIG_PREEMPT enabled, then I ran it with
> > following boot params:
> > rcutorture.shutdown_secs=60 rcutorture.n_barrier_cbs=4 rcutree.kthread_prio=2
> > 
> > and also "threadirqs"
> > 
> > This was not a TREE config, but just my simple RCU test using qemu.
> 
> Ah, it seems that the issue is reproducible in Linus tree only (which matches
> the initial diff Sebastian posted). It cannot be reproduced with your /dev
> branch. So perhaps the in_irq() check indeed works.
> 
> Looking further, in_irq() does also set the HARDIRQ_MASK in the preempt_count
> courtesy of:
> #define __irq_enter()                                   \
>         do {                                            \
>                 account_irq_enter_time(current);        \
>                 preempt_count_add(HARDIRQ_OFFSET);      \
>                 trace_hardirq_enter();
> 
> I dumped the stack at this point as well even with "threadirqs" just to
> double confirm that is the case.
> 
> So probably, the in_irq() check is sufficient. However I am still a bit
> nervous about this issue manifesting in other paths of the scheduler
> that don't execute from an interrupt handler, but still would have RCU
> reader sections with spinlocks held - I am not sure if this is possible
> though but it does make me nervous.

I have gotten back to this -rcu commit:

385b599e8c04 ("rcu: Allow rcu_read_unlock_special() to raise_softirq() if in_irq()")

It works there, and that will be part of my pull request later today.
I am continuing an informal manual bisection.  ;-)

							Thanx, Paul

> Thanks!
> 
> > 
> > 
> > I will try this diff and let you know.
> > 
> > > If it had failed, I would have tried the patch shown below.  I know that
> > > Sebastian has some concerns about the bug happening anyway, but we have
> > > to start somewhere!  ;-)
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 82c925df1d92..be7bafc2c0a0 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -624,25 +624,16 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > >  		      (rdp->grpmask & rnp->expmask) ||
> > >  		      tick_nohz_full_cpu(rdp->cpu);
> > >  		// Need to defer quiescent state until everything is enabled.
> > > -		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > > -		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > > -			// Using softirq, safe to awaken, and we get
> > > -			// no help from enabling irqs, unlike bh/preempt.
> > > -			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > -		} else {
> > > -			// Enabling BH or preempt does reschedule, so...
> > > -			// Also if no expediting or NO_HZ_FULL, slow is OK.
> > > -			set_tsk_need_resched(current);
> > > -			set_preempt_need_resched();
> > > -			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > > -			    !rdp->defer_qs_iw_pending && exp) {
> > > -				// Get scheduler to re-evaluate and call hooks.
> > > -				// If !IRQ_WORK, FQS scan will eventually IPI.
> > > -				init_irq_work(&rdp->defer_qs_iw,
> > > -					      rcu_preempt_deferred_qs_handler);
> > > -				rdp->defer_qs_iw_pending = true;
> > > -				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > > -			}
> > > +		set_tsk_need_resched(current);
> > > +		set_preempt_need_resched();
> > > +		if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> > > +		    !rdp->defer_qs_iw_pending && exp) {
> > > +			// Get scheduler to re-evaluate and call hooks.
> > > +			// If !IRQ_WORK, FQS scan will eventually IPI.
> > > +			init_irq_work(&rdp->defer_qs_iw,
> > > +				      rcu_preempt_deferred_qs_handler);
> > > +			rdp->defer_qs_iw_pending = true;
> > > +			irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > 
> > Nice to see the code here got simplified ;-)
> > 
