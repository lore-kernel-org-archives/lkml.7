Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0224C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879B9207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AaIWDuIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFFHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:49:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8o5g9BeBLZjOgBw6BUoDX0yJjbUAy3L5JjdHurjaWoY=; b=AaIWDuIu5BlKzpf5V2WAAbm4y
        T2UgRcjz2AmoeyIYIVoN1ICgEE3dGppy5UFFqw/NW2df6TeitmhEkmSSs/BcHRvuBaL3q/4bnuvjC
        J/Cy/4wC5U9s8TvGxwtU9MO521URiB1hlN7SSh8Bot38SafDMHQumbcekA0KNR1lPt0rqKUI98mPG
        UfYuoS2CokfWD9dPfLI+P7xx2Gx19igsxhW+/4uWiZno/8twNom/9DHmKpSMt6LTdz3VdxSzS3RjZ
        UbzNt+P3pDqzx11wRrl0X68IJa2AtikkB9PRtdAtY91IcxszMj9Ql+x4WuBEHkLw7o3KWE3fACq6u
        GZ1r6Wjvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYn8m-0005G3-7a; Thu, 06 Jun 2019 07:48:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A195220763536; Thu,  6 Jun 2019 09:48:49 +0200 (CEST)
Date:   Thu, 6 Jun 2019 09:48:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 6/9] rcu: Upgrade sync_exp_work_done() to
 smp_mb()
Message-ID: <20190606074849.GD3402@hirez.programming.kicks-ass.net>
References: <20190530145942.GA30318@linux.ibm.com>
 <20190530150015.30995-6-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530150015.30995-6-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 08:00:12AM -0700, Paul E. McKenney wrote:
> The sync_exp_work_done() function uses smp_mb__before_atomic(), but
> there is no obvious atomic in the ensuing code.  The ordering is
> absolutely required for grace periods to work correctly, so this
> commit upgrades the smp_mb__before_atomic() to smp_mb().
> 

Did this commit want a Fixes: line? Such that robots can find the right
kernels to backport this to?

> Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/rcu/tree_exp.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 9c990df880d1..d969650a72c6 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -259,8 +259,7 @@ static bool sync_exp_work_done(unsigned long s)
>  {
>  	if (rcu_exp_gp_seq_done(s)) {
>  		trace_rcu_exp_grace_period(rcu_state.name, s, TPS("done"));
> -		/* Ensure test happens before caller kfree(). */
> -		smp_mb__before_atomic(); /* ^^^ */
> +		smp_mb(); /* Ensure test happens before caller kfree(). */
>  		return true;
>  	}
>  	return false;
> -- 
> 2.17.1
> 
