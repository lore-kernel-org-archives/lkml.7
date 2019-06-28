Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD6EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E872086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfF1UHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:07:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbfF1UHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:07:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SK3PAV106391;
        Fri, 28 Jun 2019 16:06:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdnvsyx5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 16:06:09 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SK4k7j110123;
        Fri, 28 Jun 2019 16:06:09 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdnvsyx4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 16:06:09 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5SK0VTL009511;
        Fri, 28 Jun 2019 20:06:07 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by7qq53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 20:06:07 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SK66gF52756924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:06:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE3D5B2067;
        Fri, 28 Jun 2019 20:06:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1122B2065;
        Fri, 28 Jun 2019 20:06:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 20:06:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8F1AB16C5D8D; Fri, 28 Jun 2019 13:06:06 -0700 (PDT)
Date:   Fri, 28 Jun 2019 13:06:06 -0700
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
Message-ID: <20190628200606.GC26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
 <20190628182216.GY26519@linux.ibm.com>
 <20190628192923.GB89956@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628192923.GB89956@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 03:29:23PM -0400, Joel Fernandes wrote:
> On Fri, Jun 28, 2019 at 11:22:16AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 28, 2019 at 07:45:45PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-06-28 10:30:11 [-0700], Paul E. McKenney wrote:
> > > > > I believe the .blocked field remains set even though we are not any more in a
> > > > > reader section because of deferred processing of the blocked lists that you
> > > > > mentioned yesterday.
> > > > 
> > > > That can indeed happen.  However, in current -rcu, that would mean
> > > > that .deferred_qs is also set, which (if in_irq()) would prevent
> > > > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > > > asking the questions about whether in_irq() returns true within threaded
> > > > interrupts yesterday.  If it does, I need to find if there is some way
> > > > of determining whether rcu_read_unlock_special() is being called from
> > > > a threaded interrupt in order to suppress the call to raise_softirq()
> > > > in that case.
> > > 
> > > Please not that:
> > > | void irq_exit(void)
> > > | {
> > > |…
> > > in_irq() returns true
> > > |         preempt_count_sub(HARDIRQ_OFFSET);
> > > in_irq() returns false
> > > |         if (!in_interrupt() && local_softirq_pending())
> > > |                 invoke_softirq();
> > > 
> > > -> invoke_softirq() does
> > > |        if (!force_irqthreads) {
> > > |                 __do_softirq();
> > > |         } else {
> > > |                 wakeup_softirqd();
> > > |         }
> > > 
> > > so for `force_irqthreads' rcu_read_unlock_special() within
> > > wakeup_softirqd() will see false.
> > 
> > OK, fair point.  How about the following instead, again on -rcu?
> > 
> > Here is the rationale for the new version of the "if" statement:
> > 
> > 1.	irqs_were_disabled:  If interrupts are enabled, we should
> > 	instead let the upcoming irq_enable()/local_bh_enable()
> > 	do the rescheduling for us.
> > 2.	use_softirq: If we aren't using softirq, then
> > 	raise_softirq_irqoff() will be unhelpful.
> > 3a.	in_interrupt(): If this returns true, the subsequent
> > 	call to raise_softirq_irqoff() is guaranteed not to
> > 	do a wakeup, so that call will be both very cheap and
> > 	quite safe.
> > 3b.	Otherwise, if !in_interrupt(), if exp (an expedited RCU grace
> > 	period is being blocked), then incurring wakeup overhead
> > 	is worthwhile, and if also !.deferred_qs then scheduler locks
> > 	cannot be held so the wakeup will be safe.
> > 
> > Does that make more sense?
> 
> This makes a lot of sense. It would be nice to stick these comments on top of
> rcu_read_unlock_special() for future reference.

I do have an expanded version in the commit log.  I hope to get a more
high-level description in comments.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 82c925df1d92..83333cfe8707 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -624,8 +624,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		      (rdp->grpmask & rnp->expmask) ||
> >  		      tick_nohz_full_cpu(rdp->cpu);
> >  		// Need to defer quiescent state until everything is enabled.
> > -		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > -		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > +		if (irqs_were_disabled && use_softirq &&
> > +		    (in_interrupt() ||
> > +		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
> >  			// Using softirq, safe to awaken, and we get
> >  			// no help from enabling irqs, unlike bh/preempt.
> >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> > 
> 
