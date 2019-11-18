Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B2EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574089072;
	bh=dVMj3sNdLu46zkru4/35D/k4NS2DvsYVm9DckYRiBpY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cm++C0py2qss3Q0RYhxntSfhyqcfM1KYk7wT8rQAyYvi3cVFoFIfA2TG+Jp8C8gyc
	 z0ADURJXp7vFJclyUv/bKL5Gh0ZY9WcdgWxKSe3JF058q5snNVbax1Akij/JN8FmrZ
	 MHmzG5wGdGXgle5O0qcWsUXwPAAgkR7uEguHwGuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKRO5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfKRO5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:57:50 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC7A2084D;
        Mon, 18 Nov 2019 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574089069;
        bh=dVMj3sNdLu46zkru4/35D/k4NS2DvsYVm9DckYRiBpY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=19dMZqonLwHlA/SopweVNyxqO6PGXdNDAPzehIEnEipWsXaSbnHF7L7BHgxKvjLYg
         wqesHg3V/Cy44MWYzUVjs6/H2Z2VTNEnjwYJIqkKRF1AuKXiJh22nWjTgNnhUweeOf
         YTr21GkvJwcm8ErR82Fo8Tm5LeiozRVBeEhL9HNw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 289B03520BE9; Mon, 18 Nov 2019 06:57:49 -0800 (PST)
Date:   Mon, 18 Nov 2019 06:57:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 08/11] rcu: don't use negative ->rcu_read_lock_nesting
Message-ID: <20191118145749.GJ2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-9-laijs@linux.alibaba.com>
 <20191101123323.GC17910@paulmck-ThinkPad-P72>
 <3437ee3f-2807-16eb-5e9b-77189fa31cdf@linux.alibaba.com>
 <20191117215339.GD2889@paulmck-ThinkPad-P72>
 <77222fe8-db55-d09f-e8fd-e6f1a10f9dc3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77222fe8-db55-d09f-e8fd-e6f1a10f9dc3@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:54:29AM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/11/18 5:53 上午, Paul E. McKenney wrote:
> > On Sat, Nov 16, 2019 at 09:04:56PM +0800, Lai Jiangshan wrote:
> > > On 2019/11/1 8:33 下午, Paul E. McKenney wrote:
> > > > On Thu, Oct 31, 2019 at 10:08:03AM +0000, Lai Jiangshan wrote:
> > > > > Negative ->rcu_read_lock_nesting was introduced to prevent
> > > > > scheduler deadlock which was just prevented by deferred qs.
> > > > > So negative ->rcu_read_lock_nesting is useless now and
> > > > > rcu_read_unlock() can be simplified.
> > > > > 
> > > > > And negative ->rcu_read_lock_nesting is bug-prone,
> > > > > it is good to kill it.
> > > > > 
> > > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > > ---
> > > > >    kernel/rcu/tree_exp.h    | 30 ++----------------------------
> > > > >    kernel/rcu/tree_plugin.h | 21 +++++----------------
> > > > >    2 files changed, 7 insertions(+), 44 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > > index c0d06bce35ea..9dcbd2734620 100644
> > > > > --- a/kernel/rcu/tree_exp.h
> > > > > +++ b/kernel/rcu/tree_exp.h
> > > > > @@ -621,11 +621,11 @@ static void rcu_exp_handler(void *unused)
> > > > >    	 * report the quiescent state, otherwise defer.
> > > > >    	 */
> > > > >    	if (!t->rcu_read_lock_nesting) {
> > > > > +		rdp->exp_deferred_qs = true;
> > > > >    		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> > > > >    		    rcu_dynticks_curr_cpu_in_eqs()) {
> > > > > -			rcu_report_exp_rdp(rdp);
> > > > > +			rcu_preempt_deferred_qs(t);
> > > > >    		} else {
> > > > > -			rdp->exp_deferred_qs = true;
> > > > >    			set_tsk_need_resched(t);
> > > > >    			set_preempt_need_resched();
> > > > >    		}
> > > > > @@ -646,32 +646,6 @@ static void rcu_exp_handler(void *unused)
> > > > >    		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > > > >    		return;
> > > > >    	}
> > > > > -
> > > > > -	/*
> > > > > -	 * The final and least likely case is where the interrupted
> > > > > -	 * code was just about to or just finished exiting the RCU-preempt
> > > > > -	 * read-side critical section, and no, we can't tell which.
> > > > > -	 * So either way, set ->deferred_qs to flag later code that
> > > > > -	 * a quiescent state is required.
> > > > > -	 *
> > > > > -	 * If the CPU is fully enabled (or if some buggy RCU-preempt
> > > > > -	 * read-side critical section is being used from idle), just
> > > > > -	 * invoke rcu_preempt_deferred_qs() to immediately report the
> > > > > -	 * quiescent state.  We cannot use rcu_read_unlock_special()
> > > > > -	 * because we are in an interrupt handler, which will cause that
> > > > > -	 * function to take an early exit without doing anything.
> > > > > -	 *
> > > > > -	 * Otherwise, force a context switch after the CPU enables everything.
> > > > > -	 */
> > > > > -	rdp->exp_deferred_qs = true;
> > > > > -	if (rcu_preempt_need_deferred_qs(t) &&
> > > > > -	    (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> > > > > -	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))) {
> > > > > -		rcu_preempt_deferred_qs(t);
> > > > > -	} else {
> > > > > -		set_tsk_need_resched(t);
> > > > > -		set_preempt_need_resched();
> > > > > -	}
> > > > >    }
> > > > >    /* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index dbded2b8c792..c62631c79463 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -344,8 +344,6 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
> > > > >    }
> > > > >    /* Bias and limit values for ->rcu_read_lock_nesting. */
> > > > > -#define RCU_NEST_BIAS INT_MAX
> > > > > -#define RCU_NEST_NMAX (-INT_MAX / 2)
> > > > >    #define RCU_NEST_PMAX (INT_MAX / 2)
> > > > >    /*
> > > > > @@ -373,21 +371,15 @@ void __rcu_read_unlock(void)
> > > > >    {
> > > > >    	struct task_struct *t = current;
> > > > > -	if (t->rcu_read_lock_nesting != 1) {
> > > > > -		--t->rcu_read_lock_nesting;
> > > > > -	} else {
> > > > > +	if (--t->rcu_read_lock_nesting == 0) {
> > > > >    		barrier();  /* critical section before exit code. */
> > > > > -		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
> > > > > -		barrier();  /* assign before ->rcu_read_unlock_special load */
> > > > 
> > > > But if we take an interrupt here, and the interrupt handler contains
> > > > an RCU read-side critical section, don't we end up in the same hole
> > > > that resulted in this article when the corresponding rcu_read_unlock()
> > > > executes?  https://lwn.net/Articles/453002/
> > > 
> > > Hello, Paul
> > > 
> > > I'm replying the email of V1, which is relying on deferred_qs changes
> > > in [PATCH 07/11] (V1).
> > > ([PATCH 04/11](V1) relies on it too as you pointed out)
> > > 
> > > I hope I can answer the question wrt https://lwn.net/Articles/453002/
> > > maybe partially.
> > > 
> > > With the help of deferred_qs mechanism and the special.b.deferred_qs
> > > bit, I HOPED rcu_read_unlock_special() can find if itself is
> > > risking in scheduler locks via special.b.deferred_qs bit.
> > > 
> > > --t->rcu_read_lock_nesting;
> > > //outmost rcu c.s, rcu_read_lock_nesting is 0. but special is not zero
> > > INTERRUPT
> > >   // the fallowing code will normally be in_interrupt()
> > >   // or NOT in_interrupt() when wakeup_softirqd() in invoke_softirq()
> > >   // or NOT in_interrupt() when preempt_shedule_irq()
> > >   // or other cases I missed.
> > >   scheduler_lock()
> > >   rcu_read_lock()
> > >   rcu_read_unlock()
> > >    // special has been set but with no special.b.deferred_qs
> > >    rcu_read_unlock_special()
> > >     raise_softirq_irqoff()
> > >      wake_up() when !in_interrupt() // dead lock
> > > 
> > > preempt_shedule_irq() is guaranteed to clear rcu_read_unlock_special
> > > when rcu_read_lock_nesting = 0 before calling into scheduler locks.
> > > 
> > > But, at least, what caused my hope to be failed was the case
> > > wakeup_softirqd() in invoke_softirq() (which was once protected by
> > > softirq in about 2 years between ec433f0c5152 and facd8b80c67a).
> > > I don't think it is hard to fix it if we keep using
> > > special.b.deferred_qs as this V1 series.
> > 
> > It is quite possible that special.b.deferred_qs might be useful
> > for debugging.  But it should now be possible to take care of the
> > nohz_full issue for expedited grace periods, which might in turn allow
> > rcu_read_unlock_special() to avoid acquiring scheduler locks.
> > 
> > This could avoid the need for negative ->rcu_read_lock_nesting,
> > in turn allowing your simplified _rcu_read_unlock().
> > 
> > Would you like to do the expedited grace-period modifications, or
> > would you rather that I do so?
> 
> Hello, Paul
> 
> To be honest, I didn't known there was special issue about
> nohz_full with expedited grace periods until several days before
> you told me. I just thought that it is requested to be expedited
> so that we need to wake up something to handle it ASAP.
> 
> IOW, I'm not in a position to do the expedited grace-period
> modifications before I learnt enough about it. I would be very
> obliged that you do so. I believe it will be a better solution
> than this one or the one in V2 relying on preempt_count.

OK, let me see what I can come up with.  No guarantees for this week, but
it will have priority next week.  I would of course very much appreciate
your careful review of the resulting commit(s).

							Thanx, Paul

