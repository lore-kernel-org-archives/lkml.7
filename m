Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5AECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBFB2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571198051;
	bh=gNHAvwMGTCIlJRAkHuI/y+TtL9M1c/JkjdEvh8RVg74=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Js2PX8FZkHQjvhmckL5gcoTOz4zS2BIAJxTJFBYibUUqFK1/2YEldSeJo2c1+e1TS
	 LQArzR54dRTpOlujPm1yy1hRvN1YJeQwRuiUav+VbQjgF8LFYOskbupY2AK8d1f5Gv
	 gFxnZ4x5IpNID2aTfidsUzOhrRzzSdmnshkRYrMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbfJPDyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbfJPDyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:54:09 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E88020854;
        Wed, 16 Oct 2019 03:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571198048;
        bh=gNHAvwMGTCIlJRAkHuI/y+TtL9M1c/JkjdEvh8RVg74=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lCpxWjrx8I0qfzTWDbLV87Ai4upvnEMtF/O+Ef+/DdlABn8ypKShlTKxCoI/T6kZC
         /FdIkrhmHl+BK13RwMnTi1HKrxKq6pjlXTu/dk62Sk0kYx1l11+xVJ7WBFY9yFia+C
         IjWkp65lTvPH/gUDGdlCS5MfVjkgTiBCN/kA2BBI=
Date:   Tue, 15 Oct 2019 20:54:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     20191015102402.1978-1-laijs@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 6/7] rcu: rename some CONFIG_PREEMPTION to
 CONFIG_PREEMPT_RCU
Message-ID: <20191016035407.GB2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
 <20191015102850.2079-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102850.2079-4-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:28:48AM +0000, Lai Jiangshan wrote:
> CONFIG_PREEMPTION and CONFIG_PREEMPT_RCU are always identical,
> but some code depends on CONFIG_PREEMPTION to access to
> rcu_preempt functionalitis. This patch changes CONFIG_PREEMPTION
> to CONFIG_PREEMPT_RCU in these cases.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

I believe that this does not cause problems with Sebastian's patch
"[PATCH 27/34] rcu: Use CONFIG_PREEMPTION where appropriate", but could
you please check?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c       | 4 ++--
>  kernel/rcu/tree_stall.h | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7db5ea06a9ed..81eb64fcf5ab 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1926,7 +1926,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
>  	struct rcu_node *rnp_p;
>  
>  	raw_lockdep_assert_held_rcu_node(rnp);
> -	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
>  	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
>  	    rnp->qsmask != 0) {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> @@ -2294,7 +2294,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>  		mask = 0;
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		if (rnp->qsmask == 0) {
> -			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
> +			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
>  			    rcu_preempt_blocked_readers_cgp(rnp)) {
>  				/*
>  				 * No point in scanning bits because they
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 0b75426ebb3e..55f9b84790d3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
>  //
>  // Printing RCU CPU stall warnings
>  
> -#ifdef CONFIG_PREEMPTION
> +#ifdef CONFIG_PREEMPT_RCU
>  
>  /*
>   * Dump detailed information for all tasks blocking the current RCU
> @@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
>  	return ndetected;
>  }
>  
> -#else /* #ifdef CONFIG_PREEMPTION */
> +#else /* #ifdef CONFIG_PREEMPT_RCU */
>  
>  /*
>   * Because preemptible RCU does not exist, we never have to check for
> @@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
>  {
>  	return 0;
>  }
> -#endif /* #else #ifdef CONFIG_PREEMPTION */
> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
>  /*
>   * Dump stacks of all tasks running on stalled CPUs.  First try using
> -- 
> 2.20.1
> 
