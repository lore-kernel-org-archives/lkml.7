Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3A3206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564593970;
	bh=oELRU0Fx6RzT4m3ByuzMzmykJ4LlfkVxj9SOmJd+HeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2MdnhjdP0jMMkH/a4M5PiwK44GQsyRCD0fBBVD57Hj9oTswOnp3bvhKqVTTVUZoPm
	 oK7BhOnXIbzadprD0qATtUTy8kyAFvM0yn/sF4s4BsQq0+ERknyfFZeJKcJ+7AnvqA
	 sstjJkUOK+9N9PnUyAAvdHLWCUeHM/oX8K50FFbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGaR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfGaR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:26:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4506F20679;
        Wed, 31 Jul 2019 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564593968;
        bh=oELRU0Fx6RzT4m3ByuzMzmykJ4LlfkVxj9SOmJd+HeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+aVD4tLWZyYl6UDCZXR/2brEufSZdP249RJqnD8jlArFTVI/TUre1fn7uykA+bwG
         otIzSMKndxin46UKMd/OFppZfiXgHkp6ze0VzgPZyPn2zjWxQizsr47BYht8cfh6tR
         Joi0PkiHHix110PzZ5fJCj3LN41iThsGNUGkNh1g=
Date:   Wed, 31 Jul 2019 18:26:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dan Rue <dan.rue@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, Matt Hart <matthew.hart@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] arm64: Make debug exception handlers visible from
 RCU
Message-ID: <20190731172602.36hdk3yb3w6uihbu@willie-the-truck>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
 <156404257493.2020.7940525305482369976.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156404257493.2020.7940525305482369976.stgit@devnote2>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:16:15PM +0900, Masami Hiramatsu wrote:
> Make debug exceptions visible from RCU so that synchronize_rcu()
> correctly track the debug exception handler.
> 
> This also introduces sanity checks for user-mode exceptions as same
> as x86's ist_enter()/ist_exit().
> 
> The debug exception can interrupt in idle task. For example, it warns
> if we put a kprobe on a function called from idle task as below.
> The warning message showed that the rcu_read_lock() caused this
> problem. But actually, this means the RCU is lost the context which
> is already in NMI/IRQ.
> 
>   /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events
>   /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable
>   /sys/kernel/debug/tracing # [  135.122237]
>   [  135.125035] =============================
>   [  135.125310] WARNING: suspicious RCU usage
>   [  135.125581] 5.2.0-08445-g9187c508bdc7 #20 Not tainted
>   [  135.125904] -----------------------------
>   [  135.126205] include/linux/rcupdate.h:594 rcu_read_lock() used illegally while idle!
>   [  135.126839]
>   [  135.126839] other info that might help us debug this:
>   [  135.126839]
>   [  135.127410]
>   [  135.127410] RCU used illegally from idle CPU!
>   [  135.127410] rcu_scheduler_active = 2, debug_locks = 1
>   [  135.128114] RCU used illegally from extended quiescent state!
>   [  135.128555] 1 lock held by swapper/0/0:
>   [  135.128944]  #0: (____ptrval____) (rcu_read_lock){....}, at: call_break_hook+0x0/0x178
>   [  135.130499]
>   [  135.130499] stack backtrace:
>   [  135.131192] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-08445-g9187c508bdc7 #20
>   [  135.131841] Hardware name: linux,dummy-virt (DT)
>   [  135.132224] Call trace:
>   [  135.132491]  dump_backtrace+0x0/0x140
>   [  135.132806]  show_stack+0x24/0x30
>   [  135.133133]  dump_stack+0xc4/0x10c
>   [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
>   [  135.134171]  call_break_hook+0x170/0x178
>   [  135.134486]  brk_handler+0x28/0x68
>   [  135.134792]  do_debug_exception+0x90/0x150
>   [  135.135051]  el1_dbg+0x18/0x8c
>   [  135.135260]  default_idle_call+0x0/0x44
>   [  135.135516]  cpu_startup_entry+0x2c/0x30
>   [  135.135815]  rest_init+0x1b0/0x280
>   [  135.136044]  arch_call_rest_init+0x14/0x1c
>   [  135.136305]  start_kernel+0x4d4/0x500
>   [  135.136597]
> 
> So make debug exception visible to RCU can fix this warning.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Make a comment for debug_exception_enter() clearer.
> ---
>  arch/arm64/mm/fault.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9568c116ac7f..ed6c55c87fdc 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -777,6 +777,42 @@ void __init hook_debug_fault_code(int nr,
>  	debug_fault_info[nr].name	= name;
>  }
>  
> +/*
> + * In debug exception context, we explicitly disable preemption.

Maybe add "despite having interrupts disabled"?

> + * This serves two purposes: it makes it much less likely that we would
> + * accidentally schedule in exception context and it will force a warning
> + * if we somehow manage to schedule by accident.
> + */
> +static void debug_exception_enter(struct pt_regs *regs)
> +{
> +	if (user_mode(regs)) {
> +		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +	} else {
> +		/*
> +		 * We might have interrupted pretty much anything.  In
> +		 * fact, if we're a debug exception, we can even interrupt
> +		 * NMI processing. We don't want this code makes in_nmi()
> +		 * to return true, but we need to notify RCU.
> +		 */
> +		rcu_nmi_enter();
> +	}
> +
> +	preempt_disable();

If you're addingt new functions for entry/exit, maybe move the
trace_hardirqs_{on,off}() calls in here too?

Will
