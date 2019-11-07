Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215FC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073622084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1n5mZQR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbfKGJi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:38:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1BNGU8Je06pHaDCPvMWPgMGKRnIKHd1zkRfKCYgi8Yw=; b=1n5mZQR05hFiSJiILoYH7b4Yw
        x4pvZm3CmP42TYeEJI4nG5s85/xm8UrMAKBB53EJs7EbedNco3LpyecdG3J9xdiuwY+IVKah1Y4eH
        1sup1dGHvxPrdR1b6vHsV5iL1Nl2NFv2+lUiIZFOs/0FKTJkspVzfdEFa4g4wD2qCevORTDndqOf6
        mUv2rd75RjFbdtXt1U76bQDz5j/Xe2P4qRo/L6QK0ljy5v0IGN1phuPlb5lKtAsH2PwywbiEiyvQ8
        RAkeYxV2hvxwZzhrhbtCFzqZlUeQ2vP2DDTbEVgTbix2xt9458SOt1h/UNJ4nKTFHVJgSYQi3P6FF
        KWd6CWTEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSeFE-0002q4-E1; Thu, 07 Nov 2019 09:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D39E300692;
        Thu,  7 Nov 2019 10:37:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBBBB203C2B8B; Thu,  7 Nov 2019 10:38:22 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:38:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 08/12] futex: Sanitize exit state handling
Message-ID: <20191107093822.GD4131@hirez.programming.kicks-ass.net>
References: <20191106215534.241796846@linutronix.de>
 <20191106224556.645603214@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106224556.645603214@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 10:55:42PM +0100, Thomas Gleixner wrote:
> Instead of having a smp_mb() and an empty lock/unlock of task::pi_lock move
> the state setting into to the lock section.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/futex.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3703,16 +3703,19 @@ void futex_exit_done(struct task_struct
>  
>  void futex_exit_release(struct task_struct *tsk)
>  {
> -	tsk->futex_state = FUTEX_STATE_EXITING;
> -	/*
> -	 * Ensure that all new tsk->pi_lock acquisitions must observe
> -	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
> -	 */
> -	smp_mb();
>  	/*
> -	 * Ensure that we must observe the pi_state in exit_pi_state_list().
> +	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
> +	 *
> +	 * This ensures that all subsequent checks of tsk->futex_state in
> +	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
> +	 * tsk->pi_lock held.
> +	 *
> +	 * It guarantees also that a pi_state which was queued right before
> +	 * the state change under tsk->pi_lock by a concurrent waiter must
> +	 * be observed in exit_pi_state_list().
>  	 */
>  	raw_spin_lock_irq(&tsk->pi_lock);
> +	tsk->futex_state = FUTEX_STATE_EXITING;
>  	raw_spin_unlock_irq(&tsk->pi_lock);

Right, much saner.

So this used to be:

	exit_signals(tsk) /* sets PF_EXITING */
	smp_mb();
	raw_spin_unlock_wait(&tsk->pi_lock);

Which is in fact (possibly) faster than the new sane code, since
unlock_wait() only has to wait for any current lock holder to complete.

However due to terrible semantics and implementation issues we got rid
of *spin_unlock_wait() and well.. lets all forget this :-)
