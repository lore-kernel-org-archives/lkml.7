Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E41C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5A620815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570540381;
	bh=6C1HT7Hwuk66VyyK5prFO+ijNSykLia8L0KvWsOuPnQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KJarlUuvshyW6sC+QGbPNP9ql+fmbNj089xu1Be2+kyw1h/F2NlFJqfOAIOkiF6+c
	 5D4oLfl5LHOUS0RHVwQgkgd0DWfvCVVObD/feJOyizEjV5O3PgystAWzQmmTwtmg7e
	 dtMj9GwMAQackG+UkBXXoYKaiNeqgDZPCdPTLFJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfJHNNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHNNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:13:00 -0400
Received: from paulmck-ThinkPad-P72 (unknown [12.12.162.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3C42070B;
        Tue,  8 Oct 2019 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570540379;
        bh=6C1HT7Hwuk66VyyK5prFO+ijNSykLia8L0KvWsOuPnQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WaJCh8iLf0y38iGS1Bc0RD4wGkA3zVBPwAK95dw1l9/1dJExMQFOjl+5FkRdYBOn6
         DiTPS8Q8vTg4aggaRMlZDx0O6DbH4X8+xOYeOgXYksFIgxoFyIIKg2O2QiCdEvRgDt
         e4fymIVKS3db8QWsMAQ4LXcDnq8EyPGmer1uLcJ8=
Date:   Tue, 8 Oct 2019 06:12:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, elver@google.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid to modify mask_ofl_ipi in
 sync_rcu_exp_select_node_cpus()
Message-ID: <20191008131258.GU2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191008050145.4041702-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008050145.4041702-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:01:40PM +0800, Boqun Feng wrote:
> "mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
> to, however in the IPI sending loop, "mask_ofl_ipi" along with another
> variable "mask_ofl_test" might also get modified to record which CPU's
> quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
> variables seems to be redundant for such a propose, so this patch clean
> things a little by solely using "mask_ofl_test" for recording and
> "mask_ofl_ipi" for iteration. This would improve the readibility of the
> IPI sending loop in sync_rcu_exp_select_node_cpus().
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Queued for further review and testing, thank you!!!

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 69c5aa64fcfd..212470018752 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  		}
>  		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
>  		put_cpu();
> -		if (!ret) {
> -			mask_ofl_ipi &= ~mask;
> +		/* The CPU responses the IPI, and will report QS itself */
> +		if (!ret)
>  			continue;
> -		}
> +
>  		/* Failed, raced with CPU hotplug operation. */
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		if ((rnp->qsmaskinitnext & mask) &&
> @@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  			schedule_timeout_uninterruptible(1);
>  			goto retry_ipi;
>  		}
> -		/* CPU really is offline, so we can ignore it. */
> -		if (!(rnp->expmask & mask))
> -			mask_ofl_ipi &= ~mask;
> +		/* CPU really is offline, and we need its QS to pass GP. */
> +		if (rnp->expmask & mask)
> +			mask_ofl_test |= mask;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
>  	/* Report quiescent states for those that went offline. */
> -	mask_ofl_test |= mask_ofl_ipi;
>  	if (mask_ofl_test)
>  		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
>  }
> -- 
> 2.23.0
> 
