Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8776CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389A20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NecqHfYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCHIft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:35:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RK4A3I/JaODCZJLWZBTu0fNfPl7keAKWJzXB1KG9K+U=; b=NecqHfYlSedKV4fZHNFa3QWFr
        clJyF3iaamyKfn4ADqIsXDGuMT9Fy7ow7eMQnkWpesnmsGY17eEyrdTowWqE60ddQp7CLA60pvdK+
        auB0EqgHbfZsCeDk5tznmIbjMDR+2A9spHSnpQTi0MQjTwmOYycUxXicO/EOBeCZQYEBd0yTKCbe2
        aE3xVBaISVld6rfQ5FD8OmmRde7yj4QjK/R2O/peiHe4dUCdB5Bw5ILX4UMe69JXdI16WPWGy0grM
        Vs9Lsz0AnsKqxCuT+XoEwNcqgAi8EdqnVlIobfNW1rAsoF0Rr2JR2HBGO3y9vx5wi5Wd3sF0CCye0
        JdAjlLPag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2Aym-0007FO-89; Fri, 08 Mar 2019 08:35:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A75020281DC5; Fri,  8 Mar 2019 09:35:42 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:35:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARCv2: spinlock: remove the extra smp_mb before lock,
 after unlock
Message-ID: <20190308083542.GO32477@hirez.programming.kicks-ass.net>
References: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552008946-8008-1-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:35:46PM -0800, Vineet Gupta wrote:

>  - ARCv2 LLSC based spinlocks smp_mb() both before and after the LLSC
>    instructions, which is not required per lkmm ACQ/REL semantics.
>    smp_mb() is only needed _after_ lock and _before_ unlock.
>    So remove the extra barriers.

Right; I have memories of mentioning this earlier ;-)

> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/include/asm/spinlock.h | 45 +++++++++++------------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
> index 2ba04a7db621..be603859fb04 100644
> --- a/arch/arc/include/asm/spinlock.h
> +++ b/arch/arc/include/asm/spinlock.h
> @@ -21,8 +21,6 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
>  	unsigned int val;
>  
> -	smp_mb();
> -
>  	__asm__ __volatile__(
>  	"1:	llock	%[val], [%[slock]]	\n"
>  	"	breq	%[val], %[LOCKED], 1b	\n"	/* spin while LOCKED */
> @@ -34,6 +32,14 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  	  [LOCKED]	"r"	(__ARCH_SPIN_LOCK_LOCKED__)
>  	: "memory", "cc");
>  
> +	/*
> +	 * ACQUIRE barrier to ensure load/store after taking the lock
> +	 * don't "bleed-up" out of the critical section (leak-in is allowed)
> +	 * http://www.spinics.net/lists/kernel/msg2010409.html
> +	 *
> +	 * ARCv2 only has load-load, store-store and all-all barrier
> +	 * thus need the full all-all barrier
> +	 */
>  	smp_mb();
>  }

Two things:

 - have you considered doing a ticket lock instead of the test-and-set
   lock? Ticket locks are not particularly difficult to implement (see
   arch/arm/include/asm/spinlock.h for an example) and have much better
   worst case performance.

   (also; you can then easily convert to qrwlock, removing your custom
   rwlock implementation)

 - IFF (and please do verify this with your hardware people) the bnz
   after your scond can be considered a proper control dependency and
   thereby guarantees later stores will not bubble up, then you can get
   away with adding an smp_rmb(), see smp_acquire__after_ctrl_dep() and
   its comment.

   Your unlock will still need the smp_mb() before, such that the whole
   things will be RCsc.

> @@ -309,8 +290,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  	: "memory");
>  
>  	/*
> -	 * superfluous, but keeping for now - see pairing version in
> -	 * arch_spin_lock above
> +	 * see pairing version/comment in arch_spin_lock above
>  	 */
>  	smp_mb();
>  }


