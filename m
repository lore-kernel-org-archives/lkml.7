Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9566E215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570113254;
	bh=RTqX+z8cK5xl0X0+RctzLgiGkQhX4jb6+xWRVlGYfmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oYB0UEGzUB2Babyt9HCAarpMhxya+kz/FG1n3vrjSq8scawYVqABEWMCss0zii0BR
	 xdeAO4j5tz58vexKTiCA6C+dtWXhmvsmHXaOLk5m9WsThjhkq5n+COVGJr7yDCenAF
	 xSEE4bzD1ulLlONVSekIry5sU3csQkW2Qe+lCDTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfJCOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfJCOeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:34:13 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF0F20865;
        Thu,  3 Oct 2019 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570113252;
        bh=RTqX+z8cK5xl0X0+RctzLgiGkQhX4jb6+xWRVlGYfmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTIWKN7eurciMaxsQofTPkH+gqI2KSwXrfFsPCnyliJ2Z98E8OyfqEzk48loIsQMV
         q8MTuH8Z67Wjg60lxgpVF7jLRoxNFhHdFpGQXTOQGuWvifQw8+u5CdkKDQHGYGcXqP
         6WnxMmkN3WbnSf1qUo5xBdNgIzEme2QuVxo9jl50=
Date:   Thu, 3 Oct 2019 16:34:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 06/12] rcu: Make CPU-hotplug removal
 operations enable tick
Message-ID: <20191003143408.GB27555@lenoir>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003013903.13079-6-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:38:57PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> CPU-hotplug removal operations run the multi_cpu_stop() function, which
> relies on the scheduler to gain control from whatever is running on the
> various online CPUs, including any nohz_full CPUs running long loops in
> kernel-mode code.  Lack of the scheduler-clock interrupt on such CPUs
> can delay multi_cpu_stop() for several minutes and can also result in
> RCU CPU stall warnings.  This commit therefore causes CPU-hotplug removal
> operations to enable the scheduler-clock interrupt on all online CPUs.

So, like Peter said back then, there must be an issue in the scheduler
such as a missing or mishandled preemption point.

> 
> [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/rcu/tree.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f708d54..74bf5c65 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2091,6 +2091,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
>   */
>  int rcutree_dead_cpu(unsigned int cpu)
>  {
> +	int c;
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
>  
> @@ -2101,6 +2102,10 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	rcu_boost_kthread_setaffinity(rnp, -1);
>  	/* Do any needed no-CB deferred wakeups from this CPU. */
>  	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
> +
> +	// Stop-machine done, so allow nohz_full to disable tick.
> +	for_each_online_cpu(c)
> +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);

Just use tick_dep_clear() without for_each_online_cpu().

>  	return 0;
>  }
>  
> @@ -3074,6 +3079,7 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
>   */
>  int rcutree_online_cpu(unsigned int cpu)
>  {
> +	int c;
>  	unsigned long flags;
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
> @@ -3087,6 +3093,10 @@ int rcutree_online_cpu(unsigned int cpu)
>  		return 0; /* Too early in boot for scheduler work. */
>  	sync_sched_exp_online_cleanup(cpu);
>  	rcutree_affinity_setting(cpu, -1);
> +
> +	// Stop-machine done, so allow nohz_full to disable tick.
> +	for_each_online_cpu(c)
> +		tick_dep_clear_cpu(c, TICK_DEP_BIT_RCU);

Same here.

>  	return 0;
>  }
>  
> @@ -3096,6 +3106,7 @@ int rcutree_online_cpu(unsigned int cpu)
>   */
>  int rcutree_offline_cpu(unsigned int cpu)
>  {
> +	int c;
>  	unsigned long flags;
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
> @@ -3107,6 +3118,10 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
>  	rcutree_affinity_setting(cpu, cpu);
> +
> +	// nohz_full CPUs need the tick for stop-machine to work quickly
> +	for_each_online_cpu(c)
> +		tick_dep_set_cpu(c, TICK_DEP_BIT_RCU);

And here you only need tick_dep_set() without for_each_online_cpu().

Thanks.

>  	return 0;
>  }
>  
> -- 
> 2.9.5
> 
