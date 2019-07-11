Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCBC74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D707F21670
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qW7/U0pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfGKNIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:08:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46417 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfGKNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:08:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so2991348plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bERwlcG3C4nlijCFRRI6OTUZ0wG24LbZHXp5D5LjinE=;
        b=qW7/U0pUSWBXYYdu4uGqL2CtKwWUWkSrSSyzBaOT6PO0jcr3truea92twlsXMeiV1T
         ksURAl7b7Br64uZp1KBabXWQBsq3pIpEXy3M0scKBzH90+A4/bdvN/La+Hsih+VYrsiV
         sGcWqpV5iQFnGtKnEJ5ss0/GprmTbxdGUpE8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bERwlcG3C4nlijCFRRI6OTUZ0wG24LbZHXp5D5LjinE=;
        b=k9KDdtetn9bsUETDu0fr/Fdqw1mSHCCCX6c9vqWcrgoEVkuOBW8vaIKNRTeSIYueKN
         oAmUWXbxX5m6f/8dWrWlj3t67Ms4n5Nv6s8DvVfLNK1aMwSUFxz5nPym/gkno8oWl9Eo
         BEaLKiwbqifcfpCj+ABlPJ/5iqXgcm07RHKt+aaxxx3GMIa471J7cvgYUMGXMpsdmpKR
         oihg8u2hNnQ0sJnz4xtMJlpvcY0iVlBHU/KTk+zgkn+lpinTtvhixkqn2ZTXMInSVdGX
         DMnRCzfIQS4q70ENMQQ1wQ68Ja4+Y+9NXdfWz4z27p/ZPLq/YeIZIpSkPFI9LiYKtiJV
         N1HQ==
X-Gm-Message-State: APjAAAXV+V/15maA+iFBLIqS0r87500VelrRToA61TUzzcYj3LyHT1m0
        VGJjkO10jbX7MVhVsoQWedY=
X-Google-Smtp-Source: APXvYqx0BTW5i3GAwItQ8FIubZcjqgNjH2b/VFDz+UlvQS697hZqRSYcXKRLk4IIDQcqvcKUbwvL5w==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr4483534plo.249.1562850531927;
        Thu, 11 Jul 2019 06:08:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s24sm5885299pfh.133.2019.07.11.06.08.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:08:51 -0700 (PDT)
Date:   Thu, 11 Jul 2019 09:08:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190711130849.GA212044@google.com>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711123052.GI26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 10, 2019 at 10:20:25AM +0900, Byungchul Park wrote:
> > On Tue, Jul 09, 2019 at 05:41:02AM -0700, Paul E. McKenney wrote:
> > > > Hi Paul,
> > > > 
> > > > IMHO, as much as we want to tune the time for fqs to be initiated, we
> > > > can also want to tune the time for the help from scheduler to start.
> > > > I thought only difference between them is a level of urgency. I might be
> > > > wrong. It would be appreciated if you let me know if I miss something.
> > > 
> > > Hello, Byungchul,
> > > 
> > > I understand that one hypothetically might want to tune this at runtime,
> > > but have you had need to tune this at runtime on a real production
> > > workload?  If so, what problem was happening that caused you to want to
> > > do this tuning?
> > 
> > Not actually.
> > 
> > > > And it's ok even if the patch is turned down based on your criteria. :)
> > > 
> > > If there is a real need, something needs to be provided to meet that
> > > need.  But in the absence of a real need, past experience has shown
> > > that speculative tuning knobs usually do more harm than good.  ;-)
> > 
> > It makes sense, "A speculative tuning knobs do more harm than good".
> > 
> > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > but jiffies_till_sched_qs until we need it.
> > 
> > However,
> > 
> > (1) In case that jiffies_till_sched_qs is tunnable:
> > 
> > 	We might need all of jiffies_till_{first,next}_qs,
> > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > 	jiffies_to_sched_qs can be affected by any of them. So we
> > 	should be able to read each value at any time.
> > 
> > (2) In case that jiffies_till_sched_qs is not tunnable:
> > 
> > 	I think we don't have to keep the jiffies_till_sched_qs any
> > 	longer since that's only for setting jiffies_to_sched_qs at
> > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > 	It's meaningless to keep all of tree variables.
> > 
> > The simpler and less knobs that we really need we have, the better.
> > 
> > what do you think about it?
> > 
> > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > think jiffies_till_sched_qs is a much better name for the purpose. I
> > will resend it with a commit msg after knowing your opinion on it.
> 
> I will give you a definite "maybe".
> 
> Here are the two reasons for changing RCU's embarrassingly large array
> of tuning parameters:
> 
> 1.	They are causing a problem in production.  This would represent a
> 	bug that clearly must be fixed.  As you say, this change is not
> 	in this category.
> 
> 2.	The change simplifies either RCU's code or the process of tuning
> 	RCU, but without degrading RCU's ability to run everywhere and
> 	without removing debugging tools.
> 
> The change below clearly simplifies things by removing a few lines of
> code, and it does not change RCU's default self-configuration.  But are
> we sure about the debugging aspect?  (Please keep in mind that many more
> sites are willing to change boot parameters than are willing to patch
> their kernels.)
> 
> What do you think?

Just to add that independent of whether the runtime tunable make sense or
not, may be it is still worth correcting the 0444 to be 0644 to be a separate
patch?
 
> Finally, I urge you to join with Joel Fernandes and go through these
> grace-period-duration tuning parameters.  Once you guys get your heads
> completely around all of them and how they interact across the different
> possible RCU configurations, I bet that the two of you will have excellent
> ideas for improvement.

Yes, I am quite happy to join forces. Byungchul, let me know what about this
or other things you had in mind. I have some other RCU topics too I am trying
to get my head around and planning to work on more patches.

Paul, in case you had any other specific tunables or experiments in mind, let
me know. I am quite happy to try out new experiments and learn something
based on tuning something.

thanks,

- Joel



> > Thanks,
> > Byungchul
> > 
> > ---8<---
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e72c184..94b58f5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3792,10 +3792,6 @@
> >  			a value based on the most recent settings
> >  			of rcutree.jiffies_till_first_fqs
> >  			and rcutree.jiffies_till_next_fqs.
> > -			This calculated value may be viewed in
> > -			rcutree.jiffies_to_sched_qs.  Any attempt to set
> > -			rcutree.jiffies_to_sched_qs will be cheerfully
> > -			overwritten.
> >  
> >  	rcutree.kthread_prio= 	 [KNL,BOOT]
> >  			Set the SCHED_FIFO priority of the RCU per-CPU
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a2f8ba2..ad9dc86 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -421,10 +421,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >   * How long the grace period must be before we start recruiting
> >   * quiescent-state help from rcu_note_context_switch().
> >   */
> > -static ulong jiffies_till_sched_qs = ULONG_MAX;
> > +static ulong jiffies_till_sched_qs = ULONG_MAX; /* See adjust_jiffies_till_sched_qs(). */
> >  module_param(jiffies_till_sched_qs, ulong, 0444);
> > -static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> >  
> >  /*
> >   * Make sure that we give the grace-period kthread time to detect any
> > @@ -436,18 +434,13 @@ static void adjust_jiffies_till_sched_qs(void)
> >  {
> >  	unsigned long j;
> >  
> > -	/* If jiffies_till_sched_qs was specified, respect the request. */
> > -	if (jiffies_till_sched_qs != ULONG_MAX) {
> > -		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > -		return;
> > -	}
> >  	/* Otherwise, set to third fqs scan, but bound below on large system. */
> >  	j = READ_ONCE(jiffies_till_first_fqs) +
> >  		      2 * READ_ONCE(jiffies_till_next_fqs);
> >  	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> >  		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> >  	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > -	WRITE_ONCE(jiffies_to_sched_qs, j);
> > +	WRITE_ONCE(jiffies_till_sched_qs, j);
> >  }
> >  
> >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > @@ -1033,16 +1026,16 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >  
> >  	/*
> >  	 * A CPU running for an extended time within the kernel can
> > -	 * delay RCU grace periods: (1) At age jiffies_to_sched_qs,
> > -	 * set .rcu_urgent_qs, (2) At age 2*jiffies_to_sched_qs, set
> > +	 * delay RCU grace periods: (1) At age jiffies_till_sched_qs,
> > +	 * set .rcu_urgent_qs, (2) At age 2*jiffies_till_sched_qs, set
> >  	 * both .rcu_need_heavy_qs and .rcu_urgent_qs.  Note that the
> >  	 * unsynchronized assignments to the per-CPU rcu_need_heavy_qs
> >  	 * variable are safe because the assignments are repeated if this
> >  	 * CPU failed to pass through a quiescent state.  This code
> > -	 * also checks .jiffies_resched in case jiffies_to_sched_qs
> > +	 * also checks .jiffies_resched in case jiffies_till_sched_qs
> >  	 * is set way high.
> >  	 */
> > -	jtsq = READ_ONCE(jiffies_to_sched_qs);
> > +	jtsq = READ_ONCE(jiffies_till_sched_qs);
> >  	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> >  	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> >  	if (!READ_ONCE(*rnhqp) &&
> > @@ -3383,7 +3376,8 @@ static void __init rcu_init_geometry(void)
> >  		jiffies_till_first_fqs = d;
> >  	if (jiffies_till_next_fqs == ULONG_MAX)
> >  		jiffies_till_next_fqs = d;
> > -	adjust_jiffies_till_sched_qs();
> > +	if (jiffies_till_sched_qs == ULONG_MAX)
> > +		adjust_jiffies_till_sched_qs();
> >  
> >  	/* If the compile-time values are accurate, just leave. */
> >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> 
