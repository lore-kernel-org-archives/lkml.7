Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880F2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53053217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571199293;
	bh=e/E4kkV5ycoPrGw7zxsaaMf/4y8AK02ks2QgDtotsY4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OFOyKFdgeSTT04kQf21dcgf2N7YFTslsOlJimodF5pUEaaNIyGOtJdHh7AsucglZe
	 yT2+fxRlg/tGnLBv57nkpLeO2dz/33x0Y++Zvck11aH/HFtZLd6dAtcDY0jinFXk5U
	 IG4aPgDnExOKfgOp+5LxuovfmAWWj74JX+mC3rho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfJPEOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbfJPEOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:14:44 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39D82086A;
        Wed, 16 Oct 2019 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571199283;
        bh=e/E4kkV5ycoPrGw7zxsaaMf/4y8AK02ks2QgDtotsY4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qoI1XXzdGaIJAChY34+aO82pnTSIaKPxw+rNN+LkETAgAsAYz5BRh0Ll+G6k0ftIp
         RX5aFFkkhwelUriYIZA4bo/oO133bfvDqjrcxC9gfBzshNjjj+45SWicmsUg9IHNSr
         /LIp9ODXxRYJcT4CSZASLoi1dq4WIpGwbhoTsh5Q=
Date:   Tue, 15 Oct 2019 21:14:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: Re: [PATCH 27/34] rcu: Use CONFIG_PREEMPTION where appropriate
Message-ID: <20191016041441.GG2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-28-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015191821.11479-28-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> The config option `CONFIG_PREEMPT' is used for the preemption model
> "Low-Latency Desktop". The config option `CONFIG_PREEMPTION' is enabled
> when kernel preemption is enabled which is true for the preemption model
> `CONFIG_PREEMPT' and `CONFIG_PREEMPT_RT'.
> 
> Use `CONFIG_PREEMPTION' if it applies to both preemption models and not
> just to `CONFIG_PREEMPT'.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This one does apply, so I have queued it for review and testing, thank you!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 4 ++--
>  kernel/rcu/Kconfig       | 4 ++--
>  kernel/rcu/rcutorture.c  | 2 +-
>  kernel/rcu/srcutiny.c    | 2 +-
>  kernel/rcu/tree.c        | 4 ++--
>  kernel/rcu/tree_exp.h    | 2 +-
>  kernel/rcu/tree_plugin.h | 4 ++--
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 75a2eded7aa2c..1e3dad252d61f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -154,7 +154,7 @@ static inline void exit_tasks_rcu_finish(void) { }
>   *
>   * This macro resembles cond_resched(), except that it is defined to
>   * report potential quiescent states to RCU-tasks even if the cond_resched()
> - * machinery were to be shut off, as some advocate for PREEMPT kernels.
> + * machinery were to be shut off, as some advocate for PREEMPTION kernels.
>   */
>  #define cond_resched_tasks_rcu_qs() \
>  do { \
> @@ -580,7 +580,7 @@ do {									      \
>   *
>   * You can avoid reading and understanding the next paragraph by
>   * following this rule: don't put anything in an rcu_read_lock() RCU
> - * read-side critical section that would block in a !PREEMPT kernel.
> + * read-side critical section that would block in a !PREEMPTION kernel.
>   * But if you want the full story, read on!
>   *
>   * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 7644eda17d624..01b56177464d8 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -200,8 +200,8 @@ config RCU_NOCB_CPU
>  	  specified at boot time by the rcu_nocbs parameter.  For each
>  	  such CPU, a kthread ("rcuox/N") will be created to invoke
>  	  callbacks, where the "N" is the CPU being offloaded, and where
> -	  the "p" for RCU-preempt (PREEMPT kernels) and "s" for RCU-sched
> -	  (!PREEMPT kernels).  Nothing prevents this kthread from running
> +	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
> +	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
>  	  on the specified CPUs, but (1) the kthreads may be preempted
>  	  between each callback, and (2) affinity or cgroups can be used
>  	  to force the kthreads to run on whatever set of CPUs is desired.
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 3c9feca1eab17..c070d103f34d6 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1725,7 +1725,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
>  // Give the scheduler a chance, even on nohz_full CPUs.
>  static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
>  {
> -	if (IS_ENABLED(CONFIG_PREEMPT) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +	if (IS_ENABLED(CONFIG_PREEMPTION) && IS_ENABLED(CONFIG_NO_HZ_FULL)) {
>  		// Real call_rcu() floods hit userspace, so emulate that.
>  		if (need_resched() || (iter & 0xfff))
>  			schedule();
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 44d6606b83257..6208c1dae5c95 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>  
>  /*
>   * Workqueue handler to drive one grace period and invoke any callbacks
> - * that become ready as a result.  Single-CPU and !PREEMPT operation
> + * that become ready as a result.  Single-CPU and !PREEMPTION operation
>   * means that we get away with murder on synchronization.  ;-)
>   */
>  void srcu_drive_gp(struct work_struct *wp)
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 81105141b6a82..1c5de816ae9e5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2667,9 +2667,9 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu);
>  
>  /*
>   * During early boot, any blocking grace-period wait automatically
> - * implies a grace period.  Later on, this is never the case for PREEMPT.
> + * implies a grace period.  Later on, this is never the case for PREEMPTION.
>   *
> - * Howevr, because a context switch is a grace period for !PREEMPT, any
> + * Howevr, because a context switch is a grace period for !PREEMPTION, any
>   * blocking grace-period wait automatically implies a grace period if
>   * there is only one CPU online at any point time during execution of
>   * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index d632cd0195975..98d078cafa5a6 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -670,7 +670,7 @@ static void rcu_exp_handler(void *unused)
>  	}
>  }
>  
> -/* PREEMPT=y, so no PREEMPT=n expedited grace period to clean up after. */
> +/* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
>  static void sync_sched_exp_online_cleanup(int cpu)
>  {
>  }
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 2defc7fe74c39..e6c987d171cbe 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -788,7 +788,7 @@ static void __init rcu_bootup_announce(void)
>  }
>  
>  /*
> - * Note a quiescent state for PREEMPT=n.  Because we do not need to know
> + * Note a quiescent state for PREEMPTION=n.  Because we do not need to know
>   * how many quiescent states passed, just if there was at least one since
>   * the start of the grace period, this just sets a flag.  The caller must
>   * have disabled preemption.
> @@ -838,7 +838,7 @@ void rcu_all_qs(void)
>  EXPORT_SYMBOL_GPL(rcu_all_qs);
>  
>  /*
> - * Note a PREEMPT=n context switch.  The caller must have disabled interrupts.
> + * Note a PREEMPTION=n context switch. The caller must have disabled interrupts.
>   */
>  void rcu_note_context_switch(bool preempt)
>  {
> -- 
> 2.23.0
> 
