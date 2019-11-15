Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBEC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D4520740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573836935;
	bh=JwmTtgTdpzqkRqSYYY977gdsPXkgEyQ8SYEGJsHifzE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fXH+dqDuUnprJeDoHFI+QpJo2IHHYOKw1ZYS4euy4nToJ+2VBfdaz1fXV2Tjv0GzM
	 rgjEM54flccim0rcj3nMuvsm4uDcE4G4/YxXEHqHu++Lz8vMfbBUqD6G9hQ3QXxjuH
	 FOmQlFOggurrKmJNOqQAjfGfwi6PdoUz6fr3FQPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKOQzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfKOQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:55:33 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CDF20730;
        Fri, 15 Nov 2019 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573836932;
        bh=JwmTtgTdpzqkRqSYYY977gdsPXkgEyQ8SYEGJsHifzE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zYR8sZLbjZRYzSHuTsPRIvU9WS3cB/r97043HkewttwdIUSC0b4Aedur/qexHj9QB
         sSmVA1YBj1k2w4mX1PyjgY+INtUOjFUNMRlGdi7hMlXdYVkzlNGA/ZWJ8FxGoKkKnf
         Jn8Z/UPQq2xZ0ZbpQNxcVAEFiFNWyebQKqGtMU0o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 72A4235207BD; Fri, 15 Nov 2019 08:55:32 -0800 (PST)
Date:   Fri, 15 Nov 2019 08:55:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191115165532.GW2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-3-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
> Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> rcu_preempt_deferred_qs_irqrestore() doesn't expect
> ->rcu_read_lock_nesting to be negative to work, it even
> doesn't access to ->rcu_read_lock_nesting any more.
> 
> It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> may access to ->rcu_read_lock_nesting, but it is still safe
> since rcu_read_unlock_special() can protect itself from NMI.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

And given some form of patch #1, this one should be fine.  But some
long-term maintainable form of patch #1 clearly must come first.

						Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index aba5896d67e3..2fab8be2061f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  static void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
> -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
>  
>  	if (!rcu_preempt_need_deferred_qs(t))
>  		return;
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
>  	local_irq_save(flags);
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
> -	if (couldrecurse)
> -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
>  }
>  
>  /*
> -- 
> 2.20.1
> 
