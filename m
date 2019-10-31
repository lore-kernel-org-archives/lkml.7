Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6D4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F862086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572529434;
	bh=WqBmGuQ22zyx3KiRZwkz6aUzuxvyUDv0RjHtVTHbCYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vESbdTobH6EgjP1ChQVFFxt5ThMO1WxF+ScwCxAuePXk4deTsXbek0XzFphMxH7uK
	 Aaa0HflshPbqKvw6Lwfpd5GKX1G5ljlUKvit5VDAuog2cVsbT/KsWYFsAjTeNUbmjy
	 UD3y4bOoD11AuDZgTIZZP457iwphqpNubuj+RkzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfJaNnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJaNnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:43:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B462080F;
        Thu, 31 Oct 2019 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572529431;
        bh=WqBmGuQ22zyx3KiRZwkz6aUzuxvyUDv0RjHtVTHbCYo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bmZAcj9oPoAQd05R+j8ST5/4cXbkHNbls6hUEH+DRpmUQstOea5TGHZZS2iEyYiY4
         Tq75B0aS18/eseStHZgggTuUDJ1vYeyLDhW1lCreOeXpu75WW8d0YG84H1yXcqOSjq
         LgBWSqO82qNM/VM4zhotVcxTZ6PlBSJL66SnonSg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 654ED352041F; Thu, 31 Oct 2019 06:43:51 -0700 (PDT)
Date:   Thu, 31 Oct 2019 06:43:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 01/11] rcu: avoid leaking exp_deferred_qs into next GP
Message-ID: <20191031134351.GO20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031100806.1326-2-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:07:56AM +0000, Lai Jiangshan wrote:
> If exp_deferred_qs is incorrectly set and leaked to the next
> exp GP, it may cause the next GP to be incorrectly prematurely
> completed.

Could you please provide the sequence of events leading to a such a
failure?

Also, did you provoke such a failure in testing?  If so, an upgrade
to rcutorture would be good, so please tell me what you did to make
the failure happen.

I do like the reduction in state space, but I am a bit concerned about
the potential increase in contention on rnp->lock.  Thoughts?

							Thanx, Paul

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_exp.h | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index a0e1e51c51c2..6dec21909b30 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -603,6 +603,18 @@ static void rcu_exp_handler(void *unused)
>  	struct rcu_node *rnp = rdp->mynode;
>  	struct task_struct *t = current;
>  
> +	/*
> +	 * Note that there is a large group of race conditions that
> +	 * can have caused this quiescent state to already have been
> +	 * reported, so we really do need to check ->expmask first.
> +	 */
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	if (!(rnp->expmask & rdp->grpmask)) {
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +		return;
> +	}
> +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
>  	/*
>  	 * First, the common case of not being in an RCU read-side
>  	 * critical section.  If also enabled or idle, immediately
> @@ -628,17 +640,10 @@ static void rcu_exp_handler(void *unused)
>  	 * a future context switch.  Either way, if the expedited
>  	 * grace period is still waiting on this CPU, set ->deferred_qs
>  	 * so that the eventual quiescent state will be reported.
> -	 * Note that there is a large group of race conditions that
> -	 * can have caused this quiescent state to already have been
> -	 * reported, so we really do need to check ->expmask.
>  	 */
>  	if (t->rcu_read_lock_nesting > 0) {
> -		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -		if (rnp->expmask & rdp->grpmask) {
> -			rdp->exp_deferred_qs = true;
> -			t->rcu_read_unlock_special.b.exp_hint = true;
> -		}
> -		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +		rdp->exp_deferred_qs = true;
> +		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
>  		return;
>  	}
>  
> -- 
> 2.20.1
> 
