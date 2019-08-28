Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7645C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7210F22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n+Iz3RNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfH1V5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:57:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43669 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfH1V47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:56:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so411201pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nd+bPWlCXNocXiigb90jYgWHpu3MGjlLHt1H4GIPKsk=;
        b=n+Iz3RNKIv2G78ZVZ1TXSEKF9j9dLXkEdNpnMNVoicyXdstnIuPLFqkCjqyGSH9iJY
         o8gawdyeaRKIA7HYM9GwBrmZEUjqEqoQzGDPL6Qjj+hPvALZQLVeqdqiODiTzfmDwDgB
         jXgqJyq703XAb4M2dMxq/L+kBPkok4Gcf/Gco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nd+bPWlCXNocXiigb90jYgWHpu3MGjlLHt1H4GIPKsk=;
        b=EGDFOQ+4RMfRM2DTdS0tHZ3m78c3nNYEAgD8dkdnGd6AHF+ESP1KuT8odN9rTDj+m6
         BP2AJlDgWHM1pTNZsCNZXcO/2C2R9nJOeqa+bKSVnMIJMIldsNnaLqIEkoK08p0T7tNK
         s6bLKp+/+Zl2hibLh4wLq5RHSKdHDf+aeyc/upr1zRCFOJwJ1HhTbrD7XnxRsmOrTRLD
         CeZREA1GBw1c18Vhk5uFAISNJeggr5ssYFPzUWhi2VV/z2y1dUWrfF6v4YgpLAwJ3vMD
         fpCCpF4pFBOxV9h7L5qAA695FTulIhlMVwMPXMZcNmx+EjGoCF9VJyoOVFP0akwb2zcF
         2EkA==
X-Gm-Message-State: APjAAAVhw2RP8vjCMxxNJsQKUW1QZVEnjwNJY+IwZPnF1lRcjhdn0ghm
        XuT92FF2UWgRc66FguT1aosrFQ==
X-Google-Smtp-Source: APXvYqxBWzjFcxT5J+UW/brCQQfj77xr5PR8jRpUK60AFtolo6N4nAisXuYYuZDv08g7jCpB0ygItg==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr6143826pjr.84.1567029418977;
        Wed, 28 Aug 2019 14:56:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p20sm144125pgj.47.2019.08.28.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:56:58 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:56:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 1/2] rcu/tree: Clean up dynticks counter usage
Message-ID: <20190828215657.GA71365@google.com>
References: <5d648895.1c69fb81.5e60a.fc6f@mx.google.com>
 <20190828201344.GR26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828201344.GR26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:13:44PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 26, 2019 at 09:33:53PM -0400, Joel Fernandes (Google) wrote:
> > The dynticks counter are confusing due to crowbar writes of
> > DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
> > see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
> > if so then do a reset of the dyntick_nmi_nesting counters. This patch
> > tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
> > working, fully functional, and less confusing. The confusion recently
> > has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
> > to which wasted lots of time.
> > 
> > The patch has the following changes:
[snip]
> >  /*
> >   * Grace-period counter management.
> >   */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 68ebf0eb64c8..255cd6835526 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -81,7 +81,7 @@
> >  
> >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> >  	.dynticks_nesting = 1,
> > -	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> > +	.dynticks_nmi_nesting = 0,
> 
> C initializes to zero by default, so this can simply be deleted.

Fixed.

> >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> >  };
> >  struct rcu_state rcu_state = {
> > @@ -558,17 +558,18 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
> >  /*
> >   * Enter an RCU extended quiescent state, which can be either the
> >   * idle loop or adaptive-tickless usermode execution.
> > - *
> > - * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
> > - * the possibility of usermode upcalls having messed up our count
> > - * of interrupt nesting level during the prior busy period.
> >   */
> >  static void rcu_eqs_enter(bool user)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> > -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> > +	/* Entering usermode/idle from interrupt is not handled. These would
> > +	 * mean usermode upcalls or idle entry happened from interrupts. But,
> > +	 * reset the counter if we warn.
> > +	 */
> 
> Please either put the "/*" on its own line or use "//"-style comments.

I'll put "/*" on its own line.

> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
> >  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
> >  
> > +	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> > +		   rdp->dynticks_nmi_nesting - 1);
> 
> This is problematic.  The +/-1 and +/-2 dance is specifically for NMIs, so...

This counter is deleted in the following patch so I hope its Ok to leave it
here for this one. I just kept it split into different patch to make
testing/review/development easier.

> >  	if (irq)
> >  		rcu_prepare_for_idle();
> > @@ -723,10 +728,6 @@ void rcu_irq_exit_irqson(void)
> >  /*
> >   * Exit an RCU extended quiescent state, which can be either the
> >   * idle loop or adaptive-tickless usermode execution.
> > - *
> > - * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
> > - * allow for the possibility of usermode upcalls messing up our count of
> > - * interrupt nesting level during the busy period that is just now starting.
> >   */
> >  static void rcu_eqs_exit(bool user)
> >  {
> > @@ -747,8 +748,13 @@ static void rcu_eqs_exit(bool user)
> >  	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >  	WRITE_ONCE(rdp->dynticks_nesting, 1);
> > -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > -	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> > +
> > +	/* Exiting usermode/idle from interrupt is not handled. These would
> > +	 * mean usermode upcalls or idle exit happened from interrupts. But,
> > +	 * reset the counter if we warn.
> > +	 */
> > +	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> > +		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> 
> And here.  Plus this is adding a test and branch in the common case.
> Given that the location being written to should be hot in the cache,
> it is not clear that this is a win.

The next patch removes the branch itself and just has the warning.

> >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> >  
> >  	/*
> > @@ -826,16 +833,21 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >  
> >  		incby = 1;
> >  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> > -		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> > -		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +		   !rdp->dynticks_nmi_nesting && rdp->rcu_urgent_qs &&
> > +		   !rdp->rcu_forced_tick) {
> 
> OK.  Though you should be able to save a line by pulling the
> "rdp->rcu_urgent_qs &&" onto the first line.

Fixed.

> >  		rdp->rcu_forced_tick = true;
> >  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> >  	}
> > +
> 
> Not clear that the added blank line is a win, here or below.

Fixed,

thanks!

 - Joel

[snip]
