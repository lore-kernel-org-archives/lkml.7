Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF355C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1002339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567591976;
	bh=fIttGiPYpPvyNt6eCgrCgal3iE8DEpBFN3ZI+iQ6nuY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=IZTkaFevXnTInIRf+2xi+8fiSTmGGwRHqzQ/DUM4jUb+jbN+0/plQdrvsAw2Et6+e
	 c9TYIpK9r4nrVwjaphfrqK296IoXpacdGd39aLUl2wiAG+VduP+IfQ9alLP/eHA/b9
	 OlGyYM4nmG8Xgc9VcUPD2lAHmkNqK2VdgCBK3VVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfIDKMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:12:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbfIDKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:12:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84ABtFT014337;
        Wed, 4 Sep 2019 06:12:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utaxp0uaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 06:12:12 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x84AC2eZ014855;
        Wed, 4 Sep 2019 06:12:12 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utaxp0u9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 06:12:12 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x84A9m38017711;
        Wed, 4 Sep 2019 10:12:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2uqgh76c50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 10:12:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84ACAvH14812158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 10:12:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A126BB205F;
        Wed,  4 Sep 2019 10:12:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A029B2066;
        Wed,  4 Sep 2019 10:12:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.159.175])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 10:12:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B586116C1B20; Wed,  4 Sep 2019 03:12:10 -0700 (PDT)
Date:   Wed, 4 Sep 2019 03:12:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20190904101210.GM4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190830162348.192303-1-joel@joelfernandes.org>
 <20190903200249.GD4125@linux.ibm.com>
 <20190904045910.GC144846@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904045910.GC144846@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:59:10AM -0400, Joel Fernandes wrote:
> On Tue, Sep 03, 2019 at 01:02:49PM -0700, Paul E. McKenney wrote:
> [snip] 
> > > ---
> > >  include/linux/rcutiny.h |  3 --
> > >  kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
> > >  2 files changed, 19 insertions(+), 66 deletions(-)
> > > 
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index b7607e2667ae..b3f689711289 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -14,9 +14,6 @@
> > >  
> > >  #include <asm/param.h> /* for HZ */
> > >  
> > > -/* Never flag non-existent other CPUs! */
> > > -static inline bool rcu_eqs_special_set(int cpu) { return false; }
> > > -
> > >  static inline unsigned long get_state_synchronize_rcu(void)
> > >  {
> > >  	return 0;
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 68ebf0eb64c8..417dd00b9e87 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -69,20 +69,10 @@
> > >  
> > >  /* Data structures. */
> > >  
> > > -/*
> > > - * Steal a bit from the bottom of ->dynticks for idle entry/exit
> > > - * control.  Initially this is for TLB flushing.
> > > - */
> > > -#define RCU_DYNTICK_CTRL_MASK 0x1
> > > -#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
> > > -#ifndef rcu_eqs_special_exit
> > > -#define rcu_eqs_special_exit() do { } while (0)
> > > -#endif
> > > -
> > >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> > >  	.dynticks_nesting = 1,
> > >  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
> > > -	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > > +	.dynticks = ATOMIC_INIT(1),
> > >  };
> > >  struct rcu_state rcu_state = {
> > >  	.level = { &rcu_state.node[0] },
> > > @@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
> > >  static void rcu_dynticks_eqs_enter(void)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > -	int seq;
> > > +	int special;
> > 
> > Given that we really are now loading a pure sequence number, why
> > change the name to "special"?  This revert is after all removing
> > the ability of ->dynticks to be special.
> 
> I have no preference for this variable name, I can call it seq. I was going
> by staying close to 'git revert' to minimize any issues from reverting. I'll
> change it to seq then. But we are also going to rewrite this code anyway as
> we were discussing.
>  
> > >  	/*
> > > -	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> > > +	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
> > >  	 * and we also must force ordering with the next RCU read-side
> > >  	 * critical section.
> > >  	 */
> > > -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > -	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> > > -		     !(seq & RCU_DYNTICK_CTRL_CTR));
> > > -	if (seq & RCU_DYNTICK_CTRL_MASK) {
> > > -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> > > -		smp_mb__after_atomic(); /* _exit after clearing mask. */
> > > -		/* Prefer duplicate flushes to losing a flush. */
> > > -		rcu_eqs_special_exit();
> > > -	}
> > > +	special = atomic_inc_return(&rdp->dynticks);
> > > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
> > >  }
> > >  
> > >  /*
> > > @@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
> > >  {
> > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > >  
> > > -	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
> > > +	if (atomic_read(&rdp->dynticks) & 0x1)
> > >  		return;
> > > -	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> > > +	atomic_add(0x1, &rdp->dynticks);
> > 
> > This could be atomic_inc(), right?
> 
> True, again I will blame 'git revert' ;-) Will change.
> 
> > > -/*
> > > - * Set the special (bottom) bit of the specified CPU so that it
> > > - * will take special action (such as flushing its TLB) on the
> > > - * next exit from an extended quiescent state.  Returns true if
> > > - * the bit was successfully set, or false if the CPU was not in
> > > - * an extended quiescent state.
> > > - */
> > > -bool rcu_eqs_special_set(int cpu)
> > > -{
> > > -	int old;
> > > -	int new;
> > > -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > > -
> > > -	do {
> > > -		old = atomic_read(&rdp->dynticks);
> > > -		if (old & RCU_DYNTICK_CTRL_CTR)
> > > -			return false;
> > > -		new = old | RCU_DYNTICK_CTRL_MASK;
> > > -	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
> > > -	return true;
> > > -}
> > > -
> > >  /*
> > >   * Let the RCU core know that this CPU has gone through the scheduler,
> > >   * which is a quiescent state.  This is called when the need for a
> > > @@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
> > >   */
> > >  void rcu_momentary_dyntick_idle(void)
> > >  {
> > > -	int special;
> > > +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > +	int special = atomic_add_return(2, &rdp->dynticks);
> > >  
> > > -	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> > > -	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
> > > -				    &this_cpu_ptr(&rcu_data)->dynticks);
> > >  	/* It is illegal to call this from idle state. */
> > > -	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
> > > +	WARN_ON_ONCE(!(special & 0x1));
> > > +
> > > +	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
> > 
> > Is it really OK to clear .rcu_need_heavy_qs after the atomic_add_return()?
> 
> I think so. I reviewed other code paths and did not an issue with it. Did you
> see something wrong with it?

If this task gets delayed betweentimes, rcu_implicit_dynticks_qs() would
fail to set .rcu_need_heavy_qs because it saw it already being set,
even though the corresponding ->dynticks update had already happened.
(It might be a new grace period, given that the old grace period might
have ended courtesy of the atomic_add_return().)

							Thanx, Paul
