Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C60CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640E217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572611606;
	bh=655oP4EcLo1bTQpP1velcNHS7UmLoENn3nPbnIRZ0WE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YwwZNDkA9XgMTNphgoZj30cutnsxzDygVm/LZbaM6r2ZAxCKOLDPv6FaDW1lmmx2J
	 tNTu1j06HeouagO40shPcEA4OvN0HDaYpwf9sgz2nHiHoe1mru0qQxd9/9F/YQ0Amc
	 QVO5KWxs63DCQy0XE4bqRQ8rYRg3faTHEUqMAXmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfKAMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfKAMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:33:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67462067D;
        Fri,  1 Nov 2019 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572611603;
        bh=655oP4EcLo1bTQpP1velcNHS7UmLoENn3nPbnIRZ0WE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sP38mqAoM8SXz9neSyycjsVBSuXKFmNVooL2T/T3dR12CLTAnzRiNply+FsxwSTrQ
         uWa5alKKp40v8CyC97lCKRqKpBotwWM6gWEDjSadbi3gKYZXGhbeF+NhdBYIIP0CMd
         zoBba/XCkFkUKaCX6tqDJq0zivuK5V6EB7NMgwTc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 77B413522AF9; Fri,  1 Nov 2019 05:33:23 -0700 (PDT)
Date:   Fri, 1 Nov 2019 05:33:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 08/11] rcu: don't use negative ->rcu_read_lock_nesting
Message-ID: <20191101123323.GC17910@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-9-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031100806.1326-9-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:08:03AM +0000, Lai Jiangshan wrote:
> Negative ->rcu_read_lock_nesting was introduced to prevent
> scheduler deadlock which was just prevented by deferred qs.
> So negative ->rcu_read_lock_nesting is useless now and
> rcu_read_unlock() can be simplified.
> 
> And negative ->rcu_read_lock_nesting is bug-prone,
> it is good to kill it.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_exp.h    | 30 ++----------------------------
>  kernel/rcu/tree_plugin.h | 21 +++++----------------
>  2 files changed, 7 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c0d06bce35ea..9dcbd2734620 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -621,11 +621,11 @@ static void rcu_exp_handler(void *unused)
>  	 * report the quiescent state, otherwise defer.
>  	 */
>  	if (!t->rcu_read_lock_nesting) {
> +		rdp->exp_deferred_qs = true;
>  		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
>  		    rcu_dynticks_curr_cpu_in_eqs()) {
> -			rcu_report_exp_rdp(rdp);
> +			rcu_preempt_deferred_qs(t);
>  		} else {
> -			rdp->exp_deferred_qs = true;
>  			set_tsk_need_resched(t);
>  			set_preempt_need_resched();
>  		}
> @@ -646,32 +646,6 @@ static void rcu_exp_handler(void *unused)
>  		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
>  		return;
>  	}
> -
> -	/*
> -	 * The final and least likely case is where the interrupted
> -	 * code was just about to or just finished exiting the RCU-preempt
> -	 * read-side critical section, and no, we can't tell which.
> -	 * So either way, set ->deferred_qs to flag later code that
> -	 * a quiescent state is required.
> -	 *
> -	 * If the CPU is fully enabled (or if some buggy RCU-preempt
> -	 * read-side critical section is being used from idle), just
> -	 * invoke rcu_preempt_deferred_qs() to immediately report the
> -	 * quiescent state.  We cannot use rcu_read_unlock_special()
> -	 * because we are in an interrupt handler, which will cause that
> -	 * function to take an early exit without doing anything.
> -	 *
> -	 * Otherwise, force a context switch after the CPU enables everything.
> -	 */
> -	rdp->exp_deferred_qs = true;
> -	if (rcu_preempt_need_deferred_qs(t) &&
> -	    (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> -	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))) {
> -		rcu_preempt_deferred_qs(t);
> -	} else {
> -		set_tsk_need_resched(t);
> -		set_preempt_need_resched();
> -	}
>  }
>  
>  /* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dbded2b8c792..c62631c79463 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -344,8 +344,6 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>  }
>  
>  /* Bias and limit values for ->rcu_read_lock_nesting. */
> -#define RCU_NEST_BIAS INT_MAX
> -#define RCU_NEST_NMAX (-INT_MAX / 2)
>  #define RCU_NEST_PMAX (INT_MAX / 2)
>  
>  /*
> @@ -373,21 +371,15 @@ void __rcu_read_unlock(void)
>  {
>  	struct task_struct *t = current;
>  
> -	if (t->rcu_read_lock_nesting != 1) {
> -		--t->rcu_read_lock_nesting;
> -	} else {
> +	if (--t->rcu_read_lock_nesting == 0) {
>  		barrier();  /* critical section before exit code. */
> -		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
> -		barrier();  /* assign before ->rcu_read_unlock_special load */

But if we take an interrupt here, and the interrupt handler contains
an RCU read-side critical section, don't we end up in the same hole
that resulted in this article when the corresponding rcu_read_unlock()
executes?  https://lwn.net/Articles/453002/

							Thanx, Paul

>  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>  			rcu_read_unlock_special(t);
> -		barrier();  /* ->rcu_read_unlock_special load before assign */
> -		t->rcu_read_lock_nesting = 0;
>  	}
>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
>  		int rrln = t->rcu_read_lock_nesting;
>  
> -		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
> +		WARN_ON_ONCE(rrln < 0);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_unlock);
> @@ -535,12 +527,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>   */
>  static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
> -	return (__this_cpu_read(rcu_data.exp_deferred_qs) &&
> -		(!t->rcu_read_lock_nesting ||
> -		 t->rcu_read_lock_nesting == -RCU_NEST_BIAS))
> -		||
> -		(READ_ONCE(t->rcu_read_unlock_special.s) &&
> -		 t->rcu_read_lock_nesting <= 0);
> +	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
> +		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> +	       !t->rcu_read_lock_nesting;
>  }
>  
>  /*
> -- 
> 2.20.1
> 
