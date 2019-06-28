Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF68CC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE19208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfF1MZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:25:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfF1MZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:25:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SCLst0045212;
        Fri, 28 Jun 2019 08:24:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdjcg9ctd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 08:24:10 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SCMJ2f049002;
        Fri, 28 Jun 2019 08:24:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdjcg9cs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 08:24:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5SC9hlX021911;
        Fri, 28 Jun 2019 12:24:08 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 2t9by7n9uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 12:24:08 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SCO7pV13763376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 12:24:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20264B2065;
        Fri, 28 Jun 2019 12:24:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DECDFB206C;
        Fri, 28 Jun 2019 12:24:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.201.148])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 12:24:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5C8F916C6AD7; Fri, 28 Jun 2019 05:24:07 -0700 (PDT)
Date:   Fri, 28 Jun 2019 05:24:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, kernel-team@lge.com
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628122407.GR26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628074350.GA11214@X58A-UD3R>
 <20190628081432.GA22890@X58A-UD3R>
 <20190628082438.GB22890@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628082438.GB22890@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:24:38PM +0900, Byungchul Park wrote:
> On Fri, Jun 28, 2019 at 05:14:32PM +0900, Byungchul Park wrote:
> > On Fri, Jun 28, 2019 at 04:43:50PM +0900, Byungchul Park wrote:
> > > On Fri, Jun 28, 2019 at 04:31:38PM +0900, Byungchul Park wrote:
> > > > On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > > > > > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > > > > > On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> > > > > > > > 
> > > > > > > > I think the fix should be to prevent the wake-up not based on whether we
> > > > > > > > are
> > > > > > > > in hard/soft-interrupt mode but that we are doing the rcu_read_unlock()
> > > > > > > > from
> > > > > > > > a scheduler path (if we can detect that)
> > > > > > > 
> > > > > > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > > > > > of any way to determine whether rcu_read_unlock() is being called from
> > > > > > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > > > > > about that.
> > > > > > > 
> > > > > > > Of course, unconditionally refusing to do the wakeup might not be happy
> > > > > > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > > > > > 
> > > > > > Couldn't smp_send_reschedule() be used instead?
> > > > > 
> > > > > Good point.  If current -rcu doesn't fix things for Sebastian's case,
> > > > > that would be well worth looking at.  But there must be some reason
> > > > > why Peter Zijlstra didn't suggest it when he instead suggested using
> > > > > the IRQ work approach.
> > > > > 
> > > > > Peter, thoughts?
> > > > 
> > > 
> > > +cc kernel-team@lge.com
> > > (I'm sorry for more noise on the thread.)
> > > 
> > > > Hello,
> > > > 
> > > > Isn't the following scenario possible?
> > > > 
> > > > The original code
> > > > -----------------
> > > > rcu_read_lock();
> > > > ...
> > > > /* Experdite */
> > > > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > ...
> > > > __rcu_read_unlock();
> > > > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > > > 		rcu_read_unlock_special(t);
> > > > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > 		barrier();  /* ->rcu_read_unlock_special load before assign */
> > > > 		t->rcu_read_lock_nesting = 0;
> > > > 
> > > > The reordered code by machine
> > > > -----------------------------
> > > > rcu_read_lock();
> > > > ...
> > > > /* Experdite */
> > > > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > ...
> > > > __rcu_read_unlock();
> > > > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > > > 		rcu_read_unlock_special(t);
> > > > 		t->rcu_read_lock_nesting = 0; <--- LOOK AT THIS!!!
> > > > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > 		barrier();  /* ->rcu_read_unlock_special load before assign */
> > > > 
> > > > An interrupt happens
> > > > --------------------
> > > > rcu_read_lock();
> > > > ...
> > > > /* Experdite */
> > > > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > ...
> > > > __rcu_read_unlock();
> > > > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > > > 		rcu_read_unlock_special(t);
> > > > 		t->rcu_read_lock_nesting = 0; <--- LOOK AT THIS!!!
> > > > <--- Handle an (any) irq
> > > > 	rcu_read_lock();
> > > > 	/* This call should be skipped */
> > > > 	rcu_read_unlock_special(t);
> > > > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > > > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > 		barrier();  /* ->rcu_read_unlock_special load before assign */
> > > > 
> > > > We don't have to handle the special thing twice like this which is one
> > > > reason to cause the problem even though another problem is of course to
> > > > call ttwu w/o being aware it's within a context holding pi lock.
> > > > 
> > > > Apart from the discussion about how to avoid ttwu in an improper
> > > > condition, I think the following is necessary. I may have something
> > > > missing. It would be appreciated if you let me know in case I'm wrong.
> > > > 
> > > > Anyway, logically I think we should prevent reordering between
> > > > t->rcu_read_lock_nesting and t->rcu_read_unlock_special.b.exp_hint not
> > > > only by compiler but also by machine like the below.
> > > > 
> > > > Do I miss something?
> > > > 
> > > > Thanks,
> > > > Byungchul
> > > > 
> > > > ---8<---
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 3c8444e..9b137f1 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -412,7 +412,13 @@ void __rcu_read_unlock(void)
> > > >  		barrier();  /* assign before ->rcu_read_unlock_special load */
> > > >  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > > >  			rcu_read_unlock_special(t);
> > > > -		barrier();  /* ->rcu_read_unlock_special load before assign */
> > > > +		/*
> > > > +		 * Prevent reordering between clearing
> > > > +		 * t->rcu_reak_unlock_special in
> > > > +		 * rcu_read_unlock_special() and the following
> > > > +		 * assignment to t->rcu_read_lock_nesting.
> > > > +		 */
> > > > +		smp_wmb();
> > 
> > Ah. But the problem is this makes rcu_read_unlock() heavier, which is
> > too bad. Need to consider something else. But I'm still curious about
> > if the scenario I told you is correct?
> 
> Instead, this patch should be replaced with the following:
> 
> ---8<---
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c8444e..f103e98 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -624,8 +624,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  
>  	local_irq_save(flags);
>  	irqs_were_disabled = irqs_disabled_flags(flags);
> +
> +	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> +	/*
> +	 * Prevent reordering between rcu_read_unlock_special.b.exp_hint
> +	 * above and rcu_read_lock_nesting outside of this function.
> +	 */
> +	smp_wmb();

Except that these are manipulated by the current CPU (aside from debug
code), so inter-CPU ordering is not needed.  Plus .exp_hint is just a
heuristic.

Or am I missing something subtle here?  If so, please provide a
step-by-step explanation of the failure scenario.

							Thanx, Paul

> +
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> -		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>  		/* Need to defer quiescent state until everything is enabled. */
>  		if (irqs_were_disabled) {
>  			/* Enabling irqs does not reschedule, so... */
> @@ -638,7 +645,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		local_irq_restore(flags);
>  		return;
>  	}
> -	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>  }
>  
> 
