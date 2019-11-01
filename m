Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66DCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FBF217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572627529;
	bh=qFRzIk9HEkD9vu8HJIyey5qv3NbMoZgsRhbnWzmVi6U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OuQEyxJ61xJhU8Sj+s24FlOhJoveYNBIyaSXBLGa9zMVaIMmzrV04+ItssU1rM16B
	 F8h5J2iFljuZwYSOoSNSi4iOVDGbthuLeS4M8VMD7yTedccbKsd1wjYsmDSu4Wv5ML
	 57x4z2ObDBR7N8Za364Ry9gOvY7ZU3cVG73xsuPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfKAQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfKAQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:58:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3BB20862;
        Fri,  1 Nov 2019 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572627526;
        bh=qFRzIk9HEkD9vu8HJIyey5qv3NbMoZgsRhbnWzmVi6U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B5LX88t0cS32gq98HP8kd6LMlJtgzwRge4/afYdAqZjUBjei53xq9b2eUeUzPtAOQ
         t2S2IrLp+1KWWnJ0NAdIu0XsTpnJrdgvOzQxs3ZRkKxtCag9QIXlF1mlfAU0BHDQsU
         OL6hQA0pmP8v8VoPnilbN2xW02Sf+d4H2OIlxbsE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 338993520744; Fri,  1 Nov 2019 09:58:46 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:58:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 06/11] rcu: clear t->rcu_read_unlock_special in one go
Message-ID: <20191101165846.GA21445@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-7-laijs@linux.alibaba.com>
 <20191101121056.GB17910@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101121056.GB17910@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 05:10:56AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:08:01AM +0000, Lai Jiangshan wrote:
> > Clearing t->rcu_read_unlock_special in one go makes the code
> > more clearly.
> > 
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Nice simplification!  I had to hand-apply it due to not having taken the
> earlier patches, plus I redid the commit log.  Could you please check
> the version shown below?

Except that this simplification depends on having moved the check of
(!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) early, and
thus results in rcutorture failures due to tasks failing to be dequeued.

From what I can see, the only early exit that matters is the first one,
so I am simply removing those within the "if" statements.

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> commit 0bef7971edbbd35ed4d1682a465f682077981e85
> Author: Lai Jiangshan <laijs@linux.alibaba.com>
> Date:   Fri Nov 1 05:06:21 2019 -0700
> 
>     rcu: Clear ->rcu_read_unlock_special only once
>     
>     In rcu_preempt_deferred_qs_irqrestore(), ->rcu_read_unlock_special is
>     cleared one piece at a time.  Given that the "if" statements in this
>     function use the copy in "special", this commit removes the clearing
>     of the individual pieces in favor of clearing ->rcu_read_unlock_special
>     in one go just after it has been determined to be non-zero.
>     
>     Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 8d0e8c1..d113923 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -444,11 +444,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		local_irq_restore(flags);
>  		return;
>  	}
> -	t->rcu_read_unlock_special.b.exp_hint = false;
> -	t->rcu_read_unlock_special.b.deferred_qs = false;
> +	t->rcu_read_unlock_special.s = 0;
>  	if (special.b.need_qs) {
>  		rcu_qs();
> -		t->rcu_read_unlock_special.b.need_qs = false;
>  		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
>  			local_irq_restore(flags);
>  			return;
> @@ -471,7 +469,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  
>  	/* Clean up if blocked during RCU read-side critical section. */
>  	if (special.b.blocked) {
> -		t->rcu_read_unlock_special.b.blocked = false;
>  
>  		/*
>  		 * Remove this task from the list it blocked on.  The task
