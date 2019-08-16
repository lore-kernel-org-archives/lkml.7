Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7654C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85332171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oaP05HQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfHPRHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:07:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46273 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:07:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so3395794pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpUuiFdJ32bsLuaVeOaUL0Sj18GW8SOj2J5Gd+ou2Cw=;
        b=oaP05HQi1/o/sS5vyxx+usc0U+bhRSL/a0YiS/kKGOh0mjRXmh0AwvW10N5DkvNgBg
         E/1Z2bYOSj2WVy+3EMKNmnqor/mF4ltvwR0TMhCOZWrYDHws4CSU3Hsj9cYmKx6qk8ww
         Ux5GaggXWtGv1olsSkZGo5zrZWsa2FeMDJ0Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpUuiFdJ32bsLuaVeOaUL0Sj18GW8SOj2J5Gd+ou2Cw=;
        b=AV/pmstojmN/SzEcYWUGiz/QFVxSl6kcRczzKXQLPEc4pdjDWskychku6vopB6Y7w7
         Y78Q1UcMlSABh3TgtHiv7/IzdgWRzLTdNGzrDsvjMN1TEfZpWHON06Jny+RKuiiWe65W
         a35e8sQ+FcfR5Q48mFZBTg0QEs/5o1aLjlCIIxV9fgF+D3TtucdZrI+Ub6RpnquoZKgI
         yVBVigq5J/AW0aLqlJRFwatHddGmZsZRaAAQUKBMVszn6orgS7LwsbKSr6K/EijRnPb7
         Ay7raB6ABj2d4UXsG3J1TS1ti99sRdsxswEaX7yaOgKDS1gjGm7XeTl4noNTSSW0wTI0
         L/ww==
X-Gm-Message-State: APjAAAUdihgfT1TBMlHHhXD0yGDu5/DjOl8Ax/48DQ9yCTJsR00opHM8
        LXC2VzTTf3BujST/JBBYmc6yPg==
X-Google-Smtp-Source: APXvYqxVrg/FHaQvo7mLZvQMUh944RBZY/Sl56B9/+Ut1+dVPizUCesG/xf6x2ApBTRXSvXuam0GFA==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr12164537pfa.90.1565975238300;
        Fri, 16 Aug 2019 10:07:18 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id w9sm6699237pfn.19.2019.08.16.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 10:07:17 -0700 (PDT)
Date:   Fri, 16 Aug 2019 13:07:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190816170700.GC10481@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165242.GS28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > I really cannot explain this patch, but without it, the "else if" block
> > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > causes the tick to be turned off.
> > > 
> > > I tried various _ONCE() macros but the only thing that works is this
> > > patch.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  	long incby = 2;
> > > +	int dnn = rdp->dynticks_nmi_nesting;
> > 
> > I believe the accidental sign extension / conversion from long to int was
> > giving me an illusion since things started working well. Changing the 'int
> > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > know now. Please feel free to ignore this particular RFC patch while I debug
> > this more (over the weekend or early next week). The first 2 patches are
> > good, just ignore this one.
> 
> Ah, good point on the type!  So you were ending up with zero due to the
> low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> it is actually worse then the earlier comparison against the constant 2.
> 
> Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> nohz_full tick on upon irq enter instead of exit").

I think just using doing " == DYNTICK_IRQ_NONIDLE" as you mentioned should
make it work. I'll test that soon, thanks!

I would prefer not to revert that commit, and just make the above change.
Just because I feel this is safer. Since the tick is turned off in the IRQ
exit path, I am a bit worried about timing (does the tick turn off before RCU
sees the IRQ exit, or after it?). Either way, doing it on IRQ entry makes the
question irrelevant and immune to future changes in the timing.

Would you think the check for the nesting variable is more expensive to do on
IRQ entry than exit? If so, we could discuss doing it in the exit path,
otherwise we could doing on entry with just the above change in the equality
condition.

thanks,

 - Joel

> 
> 								Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > >  
> > >  	/* Complain about underflow. */
> > >  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> > > @@ -826,7 +827,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > >  
> > >  		incby = 1;
> > >  	} else if (tick_nohz_full_cpu(rdp->cpu) &&
> > > -		   !rdp->dynticks_nmi_nesting &&
> > > +		   !dnn &&
> > >  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > >  		rdp->rcu_forced_tick = true;
> > >  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > > -- 
> > > 2.23.0.rc1.153.gdeed80330f-goog
> > > 
> > 
