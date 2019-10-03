Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC01FC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28B520865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570114259;
	bh=wRqbdcrf0rnfiN6mrTwsskpm9lQvm61M7oJkAHs3Jqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fF/1dLJrd2W8NtQrcVwjUIYXmfOg1ZIes2LhQwiQxoXltnbu/i4Ah50n4tLzwmTEh
	 7S+tYQD6KhKYMBtYta6JGhh/WQanh6KOM0Cq2O37ije9OxrHE2bp4OFPsB4TIwouBT
	 g2XQQ7OFD1t/7F63LxK889kws7pHUzGzXvnOekIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfJCOu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJCOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:50:58 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F0420700;
        Thu,  3 Oct 2019 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570114257;
        bh=wRqbdcrf0rnfiN6mrTwsskpm9lQvm61M7oJkAHs3Jqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvZkjw0px41D/3NTC7ETAemJGv+eQex3aapC+SdEXgEMwZqJYPJpy1BNNA6py40xp
         g21fRvN87l+nqPMIdhddXy0kZ2ZFunloZaZOVlUfDGGcteZb2fK8EnTUv3wUvU+6Ae
         dAUxQZWQOqevKwkknB9BI33g7ETUEPKnvEgB3sZs=
Date:   Thu, 3 Oct 2019 16:50:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 08/12] rcu: Force tick on for nohz_full CPUs
 not reaching quiescent states
Message-ID: <20191003145054.GC27555@lenoir>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-8-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003013903.13079-8-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:38:59PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> 
> CPUs running for long time periods in the kernel in nohz_full mode
> might leave the scheduling-clock interrupt disabled for then full
> duration of their in-kernel execution.  This can (among other things)
> delay grace periods.  This commit therefore forces the tick back on
> for any nohz_full CPU that is failing to pass through a quiescent state
> upon return from interrupt, which the resched_cpu() will induce.
> 
> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> [ paulmck: Clear ->rcu_forced_tick as reported by Joel Fernandes testing. ]
> [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 74bf5c65..621cc06 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -650,6 +650,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>  	 */
>  	if (rdp->dynticks_nmi_nesting != 1) {
>  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> +		if (tick_nohz_full_cpu(rdp->cpu) &&
> +		    rdp->dynticks_nmi_nesting == 2 &&
> +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +			rdp->rcu_forced_tick = true;
> +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);

I understand rdp->cpu is always smp_processor_id() here, right? Because calling
tick_dep_set_cpu() to a remote CPU while in NMI wouldn't be safe. It would warn anyway.
