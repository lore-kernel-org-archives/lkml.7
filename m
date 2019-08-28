Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6206C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA99233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K48LnXHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfH1Vmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:42:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40131 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfH1Vmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:42:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so403774pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VHj/7Xc7AZNEtqOsbdv6KAsLFQaEQgnNcSSw1bNmvu8=;
        b=K48LnXHoeU/Up/JMswu2L8t1RmfEP+y4NouF8fvesMwB6bm0RrUwkGSNzSs5BcLyuo
         nL1yy+LvneGE27b/JU9hlBesZcsD95pzgt8gaTPYvtHPeHDHMnVii7DOY1Fo5g5uhGlh
         5ZXEy2eURhdOh5cA9c8l29SK9HcFF3qXaGqNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VHj/7Xc7AZNEtqOsbdv6KAsLFQaEQgnNcSSw1bNmvu8=;
        b=A4DeK2TnBB0zXrH371JuOTX2O5qRSA+4BmHHBDb7zt2G/ZpgJ74WmxcGb/bL9r28sh
         U7rFAFnO73rWGCEaBBfpO6WPHqRP7tbRu8owdNpQmb/l+cJ6nWgWKWGIgr6hGDiiU6di
         xXX//b9E2BJQINvEmStBrVibljfYGAVQbV/wVALYTK0x6g6eA4NivK95R3WBQDjoXvIH
         5fIcwIllfoasF0ldWUOXppnf1JLBC/pCxPXy8LUuEIkFXV3aZjc9/PrwEpO6vhkKY5c4
         BarUb8LaQJrNRNn9ax0NJnt6rSIDi0SrXMwkLXP9/2pX9eD8b6coVqJ5zoy15RTBz5lD
         5Vbw==
X-Gm-Message-State: APjAAAXcfIghDoroWqrqAletCsMPe0kMDs2gBqwCyN+8MNuGuuRrtfxQ
        mtIMaBOxB2tDJ7QE/7kqT+ZnPg==
X-Google-Smtp-Source: APXvYqwXUU+GV69dbCTTy88wZb4JUL8Ck6An9gAIkhF3gZBR/nsSnBOcwR8JRO+BofqEZ3y9RwTkLA==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr5183303pgd.394.1567028563099;
        Wed, 28 Aug 2019 14:42:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l68sm369626pfl.11.2019.08.28.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:42:42 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:42:41 -0400
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
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190828214241.GD75931@google.com>
References: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
 <20190828202330.GS26530@linux.ibm.com>
 <20190828210525.GB75931@google.com>
 <20190828211904.GX26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828211904.GX26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:19:04PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 28, 2019 at 05:05:25PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 28, 2019 at 01:23:30PM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 26, 2019 at 09:33:54PM -0400, Joel Fernandes (Google) wrote:
> > > > The dynticks_nmi_nesting counter serves 4 purposes:
> > > > 
> > > >       (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
> > > >           interrupt nesting level.
> > > > 
> > > >       (b) We need to detect half-interrupts till we are sure they're not an
> > > >           issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.
> > > > 
> > > >       (c) When a quiescent state report is needed from a nohz_full CPU.
> > > >           The nesting counter detects we are a first level interrupt.
> > > > 
> > > > For (a) we can just use dyntick_nesting == 1 to determine this. Only the
> > > > outermost interrupt that interrupted an RCU-idle state can set it to 1.
> > > > 
> > > > For (b), this warning condition has not occurred for several kernel
> > > > releases.  But we still keep the warning but change it to use
> > > > in_interrupt() instead of the nesting counter. In a later year, we can
> > > > remove the warning.
> > > > 
> > > > For (c), the nest check is not really necessary since forced_tick would
> > > > have been set to true in the outermost interrupt, so the nested/NMI
> > > > interrupts will check forced_tick anyway, and bail.
> > > 
> > > Skipping the commit log and documentation for this pass.
> > [snip] 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 255cd6835526..1465a3e406f8 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -81,7 +81,6 @@
> > > >  
> > > >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> > > >  	.dynticks_nesting = 1,
> > > > -	.dynticks_nmi_nesting = 0,
> > > 
> > > This should be in the previous patch, give or take naming.
> > 
> > Done.
> > 
> > > >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > > >  };
> > > >  struct rcu_state rcu_state = {
> > > > @@ -392,15 +391,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > > >  	/* Check for counter underflows */
> > > >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > > >  			 "RCU dynticks_nesting counter underflow!");
> > > > -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> > > > -			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> > > >  
> > > > -	/* Are we at first interrupt nesting level? */
> > > > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > > > -		return false;
> > > > -
> > > > -	/* Does CPU appear to be idle from an RCU standpoint? */
> > > > -	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> > > > +	/* Are we the outermost interrupt that arrived when RCU was idle? */
> > > > +	return __this_cpu_read(rcu_data.dynticks_nesting) == 1;
> > > >  }
> > > >  
> > > >  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
> > > > @@ -564,11 +557,10 @@ static void rcu_eqs_enter(bool user)
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  
> > > >  	/* Entering usermode/idle from interrupt is not handled. These would
> > > > -	 * mean usermode upcalls or idle entry happened from interrupts. But,
> > > > -	 * reset the counter if we warn.
> > > > +	 * mean usermode upcalls or idle exit happened from interrupts. Remove
> > > > +	 * the warning by 2020.
> > > >  	 */
> > > > -	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> > > > -		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> > > > +	WARN_ON_ONCE(in_interrupt());
> > > 
> > > And this is a red flag.  Bad things happen should some common code
> > > that disables BH be invoked from the idle loop.  This might not be
> > > happening now, but we need to avoid this sort of constraint.
> > > How about instead merging ->dyntick_nesting into the low-order bits
> > > of ->dyntick_nmi_nesting?
> > > 
> > > Yes, this assumes that we don't enter process level twice, but it should
> > > be easy to add a WARN_ON() to test for that.  Except that we don't have
> > > to because there is already this near the end of rcu_eqs_exit():
> > > 
> > > 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > > 
> > > So the low-order bit of the combined counter could indicate process-level
> > > non-idle, the next three bits could be unused to make interpretation
> > > of hex printouts easier, and then the rest of the bits could be used in
> > > the same way as currently.
> > > 
> > > This would allow a single read to see the full state, so that 0x1 means
> > > at process level in the kernel, 0x11 is interrupt (or NMI) from process
> > > level, 0x10 is interrupt/NMI from idle/user, and so on.
> > > 
> > > What am I missing here?  Why wouldn't this work, and without adding yet
> > > another RCU-imposed constraint on some other subsystem?
> > 
> > What about replacing the warning with a WARN_ON_ONCE(in_irq()), would that
> > address your concern?
> > 
> > Also, considering this warning condition is most likely never occurring as we
> > know it, and we are considering deleting it soon enough, is it really worth
> > reimplementing the whole mechanism with a complex bit-sharing scheme just
> > because of the BH-disable condition you mentioned, which likely doesn't
> > happen today? In my implementation, this is just a simple counter. I feel
> > combining bits in the same counter will just introduce more complexity that
> > this patch tries to address/avoid.
> > 
> > OTOH, I also don't mind with just deleting the warning altogether if you are
> > Ok with that.
> 
> The big advantage of combining the counters is that all of the state is
> explicit and visible in one place.  Plus it can be accessed atomically.
> And it avoids setting a time bomb for some poor guys just trying to get
> their idle-loop jobs done some time in the dim distant future.

I could try the approach you're suggesting but I didn't actually see an issue
with the patch in its current state other than the WARN_ON_ONCE which I could
change to WARN_ON_ONCE(in_irq()) to remove the concern. AFAICS, we don't
detect "half soft-interrupts" in this code in anyway.

I do feel the approach you're suggesting can be a follow up, these 2 patches
just focus on deleting dynticks_nmi_nesting counter and we can test this
approach thoroughly for a release or so.

> Besides, this pair of patches already makes a large change from a
> conceptual viewpoint.  If we are going to make a large change, let's
> get our money's worth out of that change!

IMHO, most of the changes are to code comments, the actual code change is
very little and is just removal of dynticks_nmi_nesting and simplification;
its not really an introduction of a new mechanism.

thanks,

 - Joel

