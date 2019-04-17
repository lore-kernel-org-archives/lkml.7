Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1405206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foqLK7hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfDQN5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:57:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BOrf+QF7nvh2oh+rkaLqk3HF+Je7cpTcZQWan29hzUA=; b=foqLK7hG6sfTn2tW5K0HB6C3E
        nojUivmtotAkbQ4ZwbVMm4VrzADCJTB5iBn8pIcK5dv5CO4AO0vlCXxXdcGfpj7A2svPl3FAYIXA9
        2PmX2egOjIlwazYBI7Gb5sWAyCyuuJqAFXzgJp547hbmeLl3FJuDApD84G+y8bS2Kpmq35V/Mrw/L
        8M/6vOPGueWbm+vdzkawKkPK3K2dRyobg7Cla0f3Aglv+STd9BbBW/VjtuKDkbJ9c8xxeypR3psxu
        oF+t/MwtcxaYgyFL+1OoZx+O41n17wxX1QHwuSAY5L1ifVeuuVFezcJX6E4ShSktFOQWEiulpNGpa
        WXLgHGwPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGl3e-0003QQ-29; Wed, 17 Apr 2019 13:57:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AB0929B5292B; Wed, 17 Apr 2019 15:56:59 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:56:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer
Message-ID: <20190417135659.GH4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-12-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> @@ -549,7 +582,7 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>  	return !owner ? OWNER_NULL : OWNER_READER;
>  }
>  
> -static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> +static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>  {
>  	bool taken = false;
>  	bool is_rt_task = rt_task(current);
> @@ -558,9 +591,6 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  	preempt_disable();
>  
>  	/* sem->wait_lock should not be held when doing optimistic spinning */
> -	if (!rwsem_can_spin_on_owner(sem))
> -		goto done;
> -
>  	if (!osq_lock(&sem->osq))
>  		goto done;
>  
> @@ -580,10 +610,11 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  		/*
>  		 * Try to acquire the lock
>  		 */
> -		if (rwsem_try_write_lock_unqueued(sem)) {
> -			taken = true;
> +		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
> +			      : rwsem_try_read_lock_unqueued(sem);
> +
> +		if (taken)
>  			break;
> -		}
>  
>  		/*
>  		 * An RT task cannot do optimistic spinning if it cannot

Alternatively you pass the trylock function as an argument:

static bool rwsem_optimistic_spin(struct rw_semaphore *sem,
				  bool (*trylock)(struct rw_semaphore *sem))
{
	...
		if (trylock(sem)) {
			taken = true;
			goto unlock;
		}
	...
}

