Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1FC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68022206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tSx9f2PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfIFABl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:01:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36602 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389975AbfIFABk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:01:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so2380116pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epYRiGY84qXK7GGA5K8+13R8pbG5DXRbtlScN8UK0uY=;
        b=tSx9f2PUH0CE2VSpTipizpffhVMsYtEVJotgIbdNb4zaZs2G0wsBHBYPlMn8uM3GqY
         PjpO8FBq33zk4Msd+vPYmG0ZFg452CCU+HiGo7XeSMvzPNSo6KciXQ6igGHRivwTduY6
         Kx2fxxYDxE6NBXkdEcv/IL8obcYszBGB5Cq9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epYRiGY84qXK7GGA5K8+13R8pbG5DXRbtlScN8UK0uY=;
        b=CDqI/CJQ9yk41r3gGMEtlSA37MGNxkunJWh7JUDLIZb7YYiJgkR6EBNgY+/P/rArXM
         DQYW3gjIG9gBh5i6OJkqD416xM34+gh3iVJNAU+bgrV9judLdQoA8e6qmkRHqF2wdMo3
         +2YtRbj3aX5+ZS+zo7/8KhTuwhajHoyn6oD5riqF6nSPFc6QzpLkUlxhdIqodxmDAzZq
         qG5bnVBEb30SCG/6DBE8EZSLXek0k+aPW8ajDQ8INVVgyrdR0pGRzX2w6vujWi+uofjk
         LllPmo/rS4YWcuIXdfeJP5t6IA9jeZPhoijkAr0KwrWc2a81WKmLRMWGAb/Mg+nbaaTV
         CXyw==
X-Gm-Message-State: APjAAAVTUSUNeTsJrtsHgtAoGoAnEjS7Atqmo3iJCJ2yjW2o6oTp8bAa
        mxUIK8dZsiwH0b/a9HYojEeTsA==
X-Google-Smtp-Source: APXvYqwCE57UVmIe+qdJTfI/ljoCGv7WQDe3DQb2RsRor/OsqZbObvNFP+gpLoL+1vpvanafKGjlIw==
X-Received: by 2002:a63:4823:: with SMTP id v35mr5584402pga.138.1567728099807;
        Thu, 05 Sep 2019 17:01:39 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g18sm5807819pgm.9.2019.09.05.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:01:38 -0700 (PDT)
Date:   Thu, 5 Sep 2019 20:01:37 -0400
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
Message-ID: <20190906000137.GA224720@google.com>
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
 <20190904101210.GM4125@linux.ibm.com>
 <20190904135420.GB240514@google.com>
 <20190904231308.GB4125@linux.ibm.com>
 <20190905153620.GG26466@google.com>
 <20190905164329.GT4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905164329.GT4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:43:29AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 05, 2019 at 11:36:20AM -0400, Joel Fernandes wrote:
> > On Wed, Sep 04, 2019 at 04:13:08PM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 04, 2019 at 09:54:20AM -0400, Joel Fernandes wrote:
> > > > On Wed, Sep 04, 2019 at 03:12:10AM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Sep 04, 2019 at 12:59:10AM -0400, Joel Fernandes wrote:
> > > > > > On Tue, Sep 03, 2019 at 01:02:49PM -0700, Paul E. McKenney wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > If this task gets delayed betweentimes, rcu_implicit_dynticks_qs() would
> > > > > fail to set .rcu_need_heavy_qs because it saw it already being set,
> > > > > even though the corresponding ->dynticks update had already happened.
> > > > > (It might be a new grace period, given that the old grace period might
> > > > > have ended courtesy of the atomic_add_return().)
> > > > 
> > > > Makes sense and I agree.
> > > > 
> > > > Also, I would really appreciate if you can correct the nits in the above
> > > > patch we're reviewing, and apply them (if you can).
> > > > I think, there are only 2 changes left:
> > > > - rename special to seq.
> > > > - reorder the rcu_need_heavy_qs write.
> > > > 
> > > >  On a related point, when I was working on the NOHZ_FULL testing I noticed a
> > > >  weird issue where rcu_urgent_qs was reset but rcu_need_heavy_qs was still
> > > >  set indefinitely. I am a bit afraid our hints are not being cleared
> > > >  appropriately and I believe I fixed a similar issue a few months ago. I
> > > >  would rather have them cleared once they are no longer needed.  What do you
> > > >  think about the below patch? I did not submit it yet because I was working
> > > >  on other patches. 
> > > > 
> > > > ---8<-----------------------
> > > > 
> > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > Subject: [RFC] rcu/tree: Reset CPU hints when reporting a quiescent state
> > > > 
> > > > While tracing, I am seeing cases where need_heavy_qs is still set even
> > > > though urgent_qs was cleared, after a quiescent state is reported. One
> > > > such case is when the softirq reports that a CPU has passed quiescent
> > > > state.
> > > > 
> > > > Previously in 671a63517cf9 ("rcu: Avoid unnecessary softirq when system
> > > > is idle"), I had fixed a bug where core_needs_qs was not being cleared.
> > > > I worry we keep running into similar situations. Let us just add a
> > > > function to clear hints and call it from all relevant places to make the
> > > > code more robust and avoid such stale hints which could in theory at
> > > > least, cause false hints after the quiescent state was already reported.
> > > > 
> > > > Tested overnight with rcutorture running for 60 minutes on all
> > > > configurations of RCU.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > Excellent point!  But how about if we combine it with the existing
> > > disabling of the scheduler tick, perhaps something like the following?
> > > 
> > > Note that the FQS clearing can come from some other CPU, hence the added
> > > {READ,WRITE}_ONCE() calls.  The call is moved down in rcu_report_qs_rdp()
> > > because something would have had to clear the bit to prevent execution
> > > from getting there, and I believe that the other bit-clearing events
> > > have calls to rcu_disable_urgency_upon_qs().  (But I easily could have
> > > missed something!)
> > 
> > Is there any harm just clearing it earlier in rcu_report_qs_rdp()? If no,
> > then let us just play it safe and do it that way (clear earlier in
> > rcu_report_qs_rdp())?
> 
> Maybe...
> 
> But given that missing a path doesn't cause a major failure (too-short
> grace period, for example), I am more inclined to find the paths and
> fix them as needed.  Especially given that my ignorance of any path to
> a quiescent state likely hides a serious bug.

Ok that's fine.

> > And I am guessing the __this_cpu_read(rcu_data.core_needs_qs) in
> > rcu_flavor_sched_clock_irq() implies READ_ONCE() so no need READ_ONCE()
> > there right?
> 
> Assembly in x86.  Not so much on other architectures, though.  ;-)
> See raw_cpu_generic_read().

Interesting. That one seems like a plain access, I wonder why it does not use
READ_ONCE() in there or volatile accesses.

> > > @@ -3004,7 +3007,7 @@ static int rcu_pending(void)
> > >  		return 0;
> > >  
> > >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > > -	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
> > > +	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
> > >  		return 1;
> > >  
> > >  	/* Does this CPU have callbacks ready to invoke? */
> > > @@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > >  	rdp->gp_seq = rnp->gp_seq;
> > >  	rdp->gp_seq_needed = rnp->gp_seq;
> > >  	rdp->cpu_no_qs.b.norm = true;
> > > -	rdp->core_needs_qs = false;
> > 
> > How about calling the new hint-clearing function here as well? Just for
> > robustness and consistency purposes?
> 
> This and the next function are both called during a CPU-hotplug online
> operation, so there is little robustness or consistency to be had by
> doing it twice.

Ok, sorry I missed you are clearing it below in the next function. That's
fine with me.

This patch looks good to me and I am Ok with merging of these changes into
the original patch with my authorship as you mentioned. Or if you wanted to
be author, that's fine too :)

Let me know anything else needed with it, thanks!

 - Joel


> > thanks,
> > 
> >  - Joel
> > 
> > >  	rdp->rcu_iw_pending = false;
> > >  	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
> > >  	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
> > > @@ -3359,7 +3361,7 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > >  	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > > -		rcu_disable_tick_upon_qs(rdp);
> > > +		rcu_disable_urgency_upon_qs(rdp);
> > >  		/* Report QS -after- changing ->qsmaskinitnext! */
> > >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > >  	} else {
