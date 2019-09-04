Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A822CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="a+eSq8/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfIDNyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:54:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:54:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so6744529pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8qIRQb5mfUTqhUaKJ6oAY2DXzLeF8YIOiLQv0dRf5k=;
        b=a+eSq8/iiHifKua4tDrDwW8szoWM9lb7ok8f5YM1XmYvVAfKxpueVBysqfOhVDZykE
         1ZXktP8GafTS1alBUXL70Y7/x62zuYGhhdNllhw5EmpRK2gNqauDKk8iYUv7hYtcV5xE
         2hw9gEg7USoSJ8lMYfnOSbTHmhtSiGnohg4/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8qIRQb5mfUTqhUaKJ6oAY2DXzLeF8YIOiLQv0dRf5k=;
        b=BmB/mVHW4LlC6krH1Y7a1DKpiveNAM1QsRUVPCry9GG14yOl8Bm7tz2w1/terEMfZg
         lC5p99CqIfrqAn7ce/oL64s//qiiaLtFS/7gRDKCWp5bKtKQXYkDc3YLNgvNEjiL/vXx
         mWsfx22Wb7Z5Jqsln10z9/oYcTjlEA4Um7gQ+fVhHwNDTm92/OEODmyZ452LSwxoG+H+
         WTmemd1JIDdj7hiOpGRDfOdd/EczolYT1G1Nx8d22zxo9A0tqJDDd6cTuaTUgjsyZ1S1
         fUUw5O6KA+RMNFi42EpKCe783VZ9+jzlgjgT60thGONvhbhyKmA6aQfRQQlywM7LNkBi
         AGaw==
X-Gm-Message-State: APjAAAVpzsE/Vl34k1UpERJawx/zzjsy3NA9bMNdRIEiD5MN+KUip6gJ
        TV3ZMZoPKUoXmbUkJRAfGVVBzQ==
X-Google-Smtp-Source: APXvYqxLImnK3EF26p1W/6vfxU8X7YUhWKzO40fYg4jHF2fg5wTsVl9xpuBTovvYazfcEMHSALRF2Q==
X-Received: by 2002:a17:90a:86c3:: with SMTP id y3mr5048997pjv.66.1567605262012;
        Wed, 04 Sep 2019 06:54:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g7sm1477233pjp.32.2019.09.04.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 06:54:21 -0700 (PDT)
Date:   Wed, 4 Sep 2019 09:54:20 -0400
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
Message-ID: <20190904135420.GB240514@google.com>
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
 <20190904101210.GM4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904101210.GM4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 03:12:10AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 04, 2019 at 12:59:10AM -0400, Joel Fernandes wrote:
> > On Tue, Sep 03, 2019 at 01:02:49PM -0700, Paul E. McKenney wrote:
> > [snip] 
> > > > ---
> > > >  include/linux/rcutiny.h |  3 --
> > > >  kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
> > > >  2 files changed, 19 insertions(+), 66 deletions(-)
> > > > 
> > > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > > index b7607e2667ae..b3f689711289 100644
> > > > --- a/include/linux/rcutiny.h
> > > > +++ b/include/linux/rcutiny.h
> > > > @@ -14,9 +14,6 @@
> > > >  
> > > >  #include <asm/param.h> /* for HZ */
> > > >  
> > > > -/* Never flag non-existent other CPUs! */
> > > > -static inline bool rcu_eqs_special_set(int cpu) { return false; }
> > > > -
> > > >  static inline unsigned long get_state_synchronize_rcu(void)
> > > >  {
> > > >  	return 0;
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 68ebf0eb64c8..417dd00b9e87 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -69,20 +69,10 @@
> > > >  
> > > >  /* Data structures. */
> > > >  
> > > > -/*
> > > > - * Steal a bit from the bottom of ->dynticks for idle entry/exit
> > > > - * control.  Initially this is for TLB flushing.
> > > > - */
> > > > -#define RCU_DYNTICK_CTRL_MASK 0x1
> > > > -#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
> > > > -#ifndef rcu_eqs_special_exit
> > > > -#define rcu_eqs_special_exit() do { } while (0)
> > > > -#endif
> > > > -
> > > >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> > > >  	.dynticks_nesting = 1,
> > > >  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> > > > -	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > > > +	.dynticks = ATOMIC_INIT(1),
> > > >  };
> > > >  struct rcu_state rcu_state = {
> > > >  	.level = { &rcu_state.node[0] },
> > > > @@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
> > > >  static void rcu_dynticks_eqs_enter(void)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > -	int seq;
> > > > +	int special;
> > > 
> > > Given that we really are now loading a pure sequence number, why
> > > change the name to "special"?  This revert is after all removing
> > > the ability of ->dynticks to be special.
> > 
> > I have no preference for this variable name, I can call it seq. I was going
> > by staying close to 'git revert' to minimize any issues from reverting. I'll
> > change it to seq then. But we are also going to rewrite this code anyway as
> > we were discussing.
> >  
> > > >  	/*
> > > > -	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> > > > +	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
> > > >  	 * and we also must force ordering with the next RCU read-side
> > > >  	 * critical section.
> > > >  	 */
> > > > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > > -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > > > -		     !(seq & RCU_DYNTICK_CTRL_CTR));
> > > > -	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > > > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > > > -		smp_mb__after_atomic(); /* _exit after clearing mask. */
> > > > -		/* Prefer duplicate flushes to losing a flush. */
> > > > -		rcu_eqs_special_exit();
> > > > -	}
> > > > +	special = atomic_inc_return(&rdp->dynticks);
> > > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
> > > >  }
> > > >  
> > > >  /*
> > > > @@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  
> > > > -	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
> > > > +	if (atomic_read(&rdp->dynticks) & 0x1)
> > > >  		return;
> > > > -	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > > +	atomic_add(0x1, &rdp->dynticks);
> > > 
> > > This could be atomic_inc(), right?
> > 
> > True, again I will blame 'git revert' ;-) Will change.
> > 
> > > > -/*
> > > > - * Set the special (bottom) bit of the specified CPU so that it
> > > > - * will take special action (such as flushing its TLB) on the
> > > > - * next exit from an extended quiescent state.  Returns true if
> > > > - * the bit was successfully set, or false if the CPU was not in
> > > > - * an extended quiescent state.
> > > > - */
> > > > -bool rcu_eqs_special_set(int cpu)
> > > > -{
> > > > -	int old;
> > > > -	int new;
> > > > -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > > > -
> > > > -	do {
> > > > -		old = atomic_read(&rdp->dynticks);
> > > > -		if (old & RCU_DYNTICK_CTRL_CTR)
> > > > -			return false;
> > > > -		new = old | RCU_DYNTICK_CTRL_MASK;
> > > > -	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
> > > > -	return true;
> > > > -}
> > > > -
> > > >  /*
> > > >   * Let the RCU core know that this CPU has gone through the scheduler,
> > > >   * which is a quiescent state.  This is called when the need for a
> > > > @@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
> > > >   */
> > > >  void rcu_momentary_dyntick_idle(void)
> > > >  {
> > > > -	int special;
> > > > +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > +	int special = atomic_add_return(2, &rdp->dynticks);
> > > >  
> > > > -	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> > > > -	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
> > > > -				    &this_cpu_ptr(&rcu_data)->dynticks);
> > > >  	/* It is illegal to call this from idle state. */
> > > > -	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
> > > > +	WARN_ON_ONCE(!(special & 0x1));
> > > > +
> > > > +	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> > > 
> > > Is it really OK to clear .rcu_need_heavy_qs after the atomic_add_return()?
> > 
> > I think so. I reviewed other code paths and did not an issue with it. Did you
> > see something wrong with it?
> 
> If this task gets delayed betweentimes, rcu_implicit_dynticks_qs() would
> fail to set .rcu_need_heavy_qs because it saw it already being set,
> even though the corresponding ->dynticks update had already happened.
> (It might be a new grace period, given that the old grace period might
> have ended courtesy of the atomic_add_return().)

Makes sense and I agree.

Also, I would really appreciate if you can correct the nits in the above
patch we're reviewing, and apply them (if you can).
I think, there are only 2 changes left:
- rename special to seq.
- reorder the rcu_need_heavy_qs write.

 On a related point, when I was working on the NOHZ_FULL testing I noticed a
 weird issue where rcu_urgent_qs was reset but rcu_need_heavy_qs was still
 set indefinitely. I am a bit afraid our hints are not being cleared
 appropriately and I believe I fixed a similar issue a few months ago. I
 would rather have them cleared once they are no longer needed.  What do you
 think about the below patch? I did not submit it yet because I was working
 on other patches. 

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC] rcu/tree: Reset CPU hints when reporting a quiescent state

While tracing, I am seeing cases where need_heavy_qs is still set even
though urgent_qs was cleared, after a quiescent state is reported. One
such case is when the softirq reports that a CPU has passed quiescent
state.

Previously in 671a63517cf9 ("rcu: Avoid unnecessary softirq when system
is idle"), I had fixed a bug where core_needs_qs was not being cleared.
I worry we keep running into similar situations. Let us just add a
function to clear hints and call it from all relevant places to make the
code more robust and avoid such stale hints which could in theory at
least, cause false hints after the quiescent state was already reported.

Tested overnight with rcutorture running for 60 minutes on all
configurations of RCU.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4f7c3096d786..493a526b390e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1957,6 +1957,18 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 	rcu_report_qs_rnp(mask, rnp_p, gps, flags);
 }
 
+/*
+ * Helper function to reset the hints provided by RCU's grace period management
+ * system. Typically used when a quiescent state for the CPU is reported.
+ * Called with the leaf node's lock held.
+ */
+static void rcu_reset_rdp_hints(struct rcu_data *rdp)
+{
+	rdp->core_needs_qs = false;
+	rdp->rcu_urgent_qs = false;
+	rdp->rcu_need_heavy_qs = false;
+}
+
 /*
  * Record a quiescent state for the specified CPU to that CPU's rcu_data
  * structure.  This must be called from the specified CPU.
@@ -1987,7 +1999,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
-	rdp->core_needs_qs = false;
+	rcu_reset_rdp_hints(rdp);
+
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
@@ -2315,6 +2328,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			if ((rnp->qsmask & bit) != 0) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (f(rdp)) {
+					rcu_reset_rdp_hints(rdp);
 					mask |= bit;
 					rcu_disable_tick_upon_qs(rdp);
 				}
@@ -3359,6 +3373,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+		rcu_reset_rdp_hints(rdp);
 		rcu_disable_tick_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.23.0.187.g17f5b7556c-goog

