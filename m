Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A633C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1728422CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="v0hfGK8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfIDE7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:59:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44807 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfIDE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:59:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so7399226pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+ym4sinwY6uTtXkK5V5+QZuRG/fgGPDKfrI660KS9U=;
        b=v0hfGK8e/rtBNaWOo89PfCvuFpOxLM5US79nUya+ZEiU4okcocG4UmxreUiNreHOYj
         w6IkDREkf02tfleQejFHfQFpvaBDdn7Ogk2JV6oThDHl3UuGCWs/sYDbZmYCSgrlCema
         kpqWo/XrHlC6KN4WUf4KY6eann9TElltDJXtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+ym4sinwY6uTtXkK5V5+QZuRG/fgGPDKfrI660KS9U=;
        b=Es3N3uTmxbu92NhWIyMyvLw/lkndBZ9tvp4R6ugaHYej1Eecec1iKgWi5l6n5xng6y
         1wfeMHnkc5SUBJYYb4ayDHxgyxBhA+xN4HRiIihiDqEOUsZIJAMyKCKYRdSsLYTcZ5JJ
         /VdkPJD9P6dfUk6EyA2EHF83kTm+kc3UgU0g7LBNQCLRcGtE4FYxtYYV7ejvIfGSSmQb
         GKJtssIhC/drGT6uSV79WtXu8wkUhietSI+K4UYv4tO85uEAUjnLlkZKihYqAGRSUh6c
         D2TcMgwsrnHA4EOKDyFTKVtevLj/gGOsePqALYy0PTk5fGCCDSkD9HHzWysM2lOhvOL6
         TBkA==
X-Gm-Message-State: APjAAAXbRc8Tsm8+vdst/HWnutfaLVLhyglQk2kywcJl9cCa0jiR3dQW
        xd/aRYx5px0mGy6R/L2JGKIFEQ==
X-Google-Smtp-Source: APXvYqyGV80F9mmFcLLdefSH8rdaK+phJ4GFwnVlRnqU+i7OEZP1XmR6h4wJEcnxZ8DIHao5o8C8nw==
X-Received: by 2002:a17:90a:25a9:: with SMTP id k38mr3189433pje.12.1567573151848;
        Tue, 03 Sep 2019 21:59:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m24sm7599561pfa.37.2019.09.03.21.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:59:11 -0700 (PDT)
Date:   Wed, 4 Sep 2019 00:59:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special
 bits at bottom of ->dynticks counter")
Message-ID: <20190904045910.GC144846@google.com>
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903200249.GD4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:02:49PM -0700, Paul E. McKenney wrote:
[snip] 
> > ---
> >  include/linux/rcutiny.h |  3 --
> >  kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
> >  2 files changed, 19 insertions(+), 66 deletions(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index b7607e2667ae..b3f689711289 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -14,9 +14,6 @@
> >  
> >  #include <asm/param.h> /* for HZ */
> >  
> > -/* Never flag non-existent other CPUs! */
> > -static inline bool rcu_eqs_special_set(int cpu) { return false; }
> > -
> >  static inline unsigned long get_state_synchronize_rcu(void)
> >  {
> >  	return 0;
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 68ebf0eb64c8..417dd00b9e87 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -69,20 +69,10 @@
> >  
> >  /* Data structures. */
> >  
> > -/*
> > - * Steal a bit from the bottom of ->dynticks for idle entry/exit
> > - * control.  Initially this is for TLB flushing.
> > - */
> > -#define RCU_DYNTICK_CTRL_MASK 0x1
> > -#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
> > -#ifndef rcu_eqs_special_exit
> > -#define rcu_eqs_special_exit() do { } while (0)
> > -#endif
> > -
> >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> >  	.dynticks_nesting = 1,
> >  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> > -	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > +	.dynticks = ATOMIC_INIT(1),
> >  };
> >  struct rcu_state rcu_state = {
> >  	.level = { &rcu_state.node[0] },
> > @@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
> >  static void rcu_dynticks_eqs_enter(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > -	int seq;
> > +	int special;
> 
> Given that we really are now loading a pure sequence number, why
> change the name to "special"?  This revert is after all removing
> the ability of ->dynticks to be special.

I have no preference for this variable name, I can call it seq. I was going
by staying close to 'git revert' to minimize any issues from reverting. I'll
change it to seq then. But we are also going to rewrite this code anyway as
we were discussing.
 
> >  	/*
> > -	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> > +	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
> >  	 * and we also must force ordering with the next RCU read-side
> >  	 * critical section.
> >  	 */
> > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > -		     !(seq & RCU_DYNTICK_CTRL_CTR));
> > -	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > -		smp_mb__after_atomic(); /* _exit after clearing mask. */
> > -		/* Prefer duplicate flushes to losing a flush. */
> > -		rcu_eqs_special_exit();
> > -	}
> > +	special = atomic_inc_return(&rdp->dynticks);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
> >  }
> >  
> >  /*
> > @@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > -	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
> > +	if (atomic_read(&rdp->dynticks) & 0x1)
> >  		return;
> > -	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > +	atomic_add(0x1, &rdp->dynticks);
> 
> This could be atomic_inc(), right?

True, again I will blame 'git revert' ;-) Will change.

> > -/*
> > - * Set the special (bottom) bit of the specified CPU so that it
> > - * will take special action (such as flushing its TLB) on the
> > - * next exit from an extended quiescent state.  Returns true if
> > - * the bit was successfully set, or false if the CPU was not in
> > - * an extended quiescent state.
> > - */
> > -bool rcu_eqs_special_set(int cpu)
> > -{
> > -	int old;
> > -	int new;
> > -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > -
> > -	do {
> > -		old = atomic_read(&rdp->dynticks);
> > -		if (old & RCU_DYNTICK_CTRL_CTR)
> > -			return false;
> > -		new = old | RCU_DYNTICK_CTRL_MASK;
> > -	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
> > -	return true;
> > -}
> > -
> >  /*
> >   * Let the RCU core know that this CPU has gone through the scheduler,
> >   * which is a quiescent state.  This is called when the need for a
> > @@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
> >   */
> >  void rcu_momentary_dyntick_idle(void)
> >  {
> > -	int special;
> > +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > +	int special = atomic_add_return(2, &rdp->dynticks);
> >  
> > -	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> > -	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
> > -				    &this_cpu_ptr(&rcu_data)->dynticks);
> >  	/* It is illegal to call this from idle state. */
> > -	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
> > +	WARN_ON_ONCE(!(special & 0x1));
> > +
> > +	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> 
> Is it really OK to clear .rcu_need_heavy_qs after the atomic_add_return()?

I think so. I reviewed other code paths and did not an issue with it. Did you
see something wrong with it?

thanks,

 - Joel

