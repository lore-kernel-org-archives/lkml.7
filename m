Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C763C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1E21823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920947;
	bh=7GFp+EbyWmYurQDv+T49zggTrgHydUT8pa/zUfGkjr8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Hi7ySW3ym4ekBDyXY+WnIGJCiSt9w5zDLt/nbFo/ITdTzzldce/mn1sCyq0jgsoQn
	 MvVgyfR1kDNmrI9eugP1T8VGALFEvIsywMDXBuMWlv//6Vul7hELrhMHGx1qMXEDiH
	 bV38UDiSadFijCZYAJOzl8nRD70qBt8mXwoyMitc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfKPPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfKPPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:39 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AEE9206C0;
        Sat, 16 Nov 2019 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919199;
        bh=7GFp+EbyWmYurQDv+T49zggTrgHydUT8pa/zUfGkjr8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vPhGJSFFQQ6w1PJw7x3ARlFXMiCLYq4f8jxbFTW43pIqkBVSKaCymtNTGymgrk0y7
         fAMlubwbKF8YER2QP64Qqu6LELDfafQdrQx/6PkJE1nOBZJhKZmReLEbATg5BIqXGl
         Gy3xg5V7pHMNxTAhzseJ4ns2QsOJSMoITtXQRBqk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DE05335227AD; Sat, 16 Nov 2019 07:46:38 -0800 (PST)
Date:   Sat, 16 Nov 2019 07:46:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 6/7] rcu: clear the special.b.need_qs in
 rcu_note_context_switch()
Message-ID: <20191116154638.GD2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-7-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-7-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:58PM +0000, Lai Jiangshan wrote:
> It is better to clear the special.b.need_qs when it is
> replaced by special.b.blocked or it is really fulfill its
> goal in rcu_preempt_deferred_qs_irqrestore().
> 
> It makes rcu_qs() easier to be understood, and also prepares for
> the percpu rcu_preempt_depth patch, which reqires rcu_special
> bits to be clearred in irq-disable context.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

This one is a (possible) optimization.

Right now, when the CPU actually passes through the quiescent state,
we clear this field.  The quiescent state is not reported until later.
Waiting to clear it until later might cause extra unneeded quiescent-state
work to happen.  But your point is that the current code might leave
->rcu_read_unlock_special momentarily zero, causing possible trouble
with the remainder of this series, right?

Hmmm...

The "right" way to do this would be to have another flag saying
"quiescent state encountered but not yet reported".  This would keep
->rcu_read_unlock_special non-zero throughout, and would avoid useless
work looking for additional unneeded quiescent states.  Or perhaps have
need_qs be zero for don't need, one for need, and two for have but not
yet reported.

Thoughts?  Other approaches?

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index eb5906c55c8d..e16c3867d2ff 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -264,8 +264,6 @@ static void rcu_qs(void)
>  				       __this_cpu_read(rcu_data.gp_seq),
>  				       TPS("cpuqs"));
>  		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
> -		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
> -		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
>  	}
>  }
>  
> @@ -297,6 +295,7 @@ void rcu_note_context_switch(bool preempt)
>  		/* Possibly blocking in an RCU read-side critical section. */
>  		rnp = rdp->mynode;
>  		raw_spin_lock_rcu_node(rnp);
> +		t->rcu_read_unlock_special.b.need_qs = false;
>  		t->rcu_read_unlock_special.b.blocked = true;
>  		t->rcu_blocked_node = rnp;
>  
> -- 
> 2.20.1
> 
