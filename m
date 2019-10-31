Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D9D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572529956;
	bh=IvK8ua/CzhbWFAV9u+JUslEhWgIdcSDnR6QJTc4yF1o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jwnnvs+h9/foL90xequHgdI9JNWWkLTc4kSzRwpr9rpzcGOWbmQoZNumklpwmEc6G
	 4eMm9VmDyb6020SWP9rg3tBB2CMvuojOahEy8QXb4q232WTEgc2p+eigGHaocLNh7a
	 dIK+5zuKjfHq2AQ0wrRDBpt1tefPDV1WqD2zOzwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfJaNwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfJaNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:52:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4475E2080F;
        Thu, 31 Oct 2019 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572529954;
        bh=IvK8ua/CzhbWFAV9u+JUslEhWgIdcSDnR6QJTc4yF1o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sczk0SXkjh6o9TdylfsUT5/fq9kZJTYsTwsemViasT9SJvcMMm4ks90PFHKeGKZf7
         aV7BCUOpL3f9vUEMR/Awm6EOBSXrQRx5aac9Mj7Io85yWYsGTBDUTXsHRyWxAsRrPl
         W/nMs6JctRxlVN8VLUooacTM9cXb3Vn/E+TY2WgA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 14399352041F; Thu, 31 Oct 2019 06:52:34 -0700 (PDT)
Date:   Thu, 31 Oct 2019 06:52:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu: clean up rcu_preempt_deferred_qs_irqrestore()
Message-ID: <20191031135234.GQ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-4-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031100806.1326-4-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:07:58AM +0000, Lai Jiangshan wrote:
> Remove several unneeded return.
> 
> It doesn't need to return earlier after every code block.
> The code protects itself and be safe to fall through because
> every code block has its own condition tests.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_plugin.h | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 59ef10da1e39..82595db04eec 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -439,19 +439,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> -	rdp = this_cpu_ptr(&rcu_data);
> -	if (!special.s && !rdp->exp_deferred_qs) {
> -		local_irq_restore(flags);
> -		return;
> -	}

The point of this check is the common case of this function being invoked
when both fields are zero, avoiding the below redundant store and all the
extra checks of subfields of special.

Or are you saying that current compilers figure all this out?

							Thanx, Paul

>  	t->rcu_read_unlock_special.b.deferred_qs = false;
>  	if (special.b.need_qs) {
>  		rcu_qs();
>  		t->rcu_read_unlock_special.b.need_qs = false;
> -		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
> -			local_irq_restore(flags);
> -			return;
> -		}
>  	}
>  
>  	/*
> @@ -460,12 +451,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	 * tasks are handled when removing the task from the
>  	 * blocked-tasks list below.
>  	 */
> +	rdp = this_cpu_ptr(&rcu_data);
>  	if (rdp->exp_deferred_qs) {
>  		rcu_report_exp_rdp(rdp);
> -		if (!t->rcu_read_unlock_special.s) {
> -			local_irq_restore(flags);
> -			return;
> -		}
>  	}
>  
>  	/* Clean up if blocked during RCU read-side critical section. */
> -- 
> 2.20.1
> 
