Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CCC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A799E206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFUKT8/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfDYTwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:52:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f77raPNimqC2AbXVo9+y7MCgUWwUJvpmXp/DKHn5A8k=; b=dFUKT8/yu+sy/k6BIcNFuOQyk
        X241+AVdHlQr1oL5296ANVIGjxBT5fuiprbRIR+EJYimd1UrmDtKzECRi+xHzmaGZIjXJRdrMBISo
        DvTn2Pw26f3o8O7xEKc7KwuiFodgqXlUFNw3PwRUyn55LIKtO+aFfeJx5yxEzmVZmS31kpftJIOLU
        ZyvrK4OUq5quVD3uft1J9D5m4hcXQUAv7YsTvfm8QWy5WjxBkbtWnkVXeKL46RMdtEh3m2l4Skgyi
        8z2wLAkT+BKOjOln9K1266uNiRHA+vCeb15vxrve4n6QCAWQAkxCTleULJL3xIxdgYJdW7BkC+zIN
        Nw29h1FaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJkPl-0007vx-Rq; Thu, 25 Apr 2019 19:52:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26590200D2F43; Thu, 25 Apr 2019 21:52:12 +0200 (CEST)
Date:   Thu, 25 Apr 2019 21:52:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/28] locking/lockdep: Adjust new bit cases in mark_lock
Message-ID: <20190425195212.GW12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-23-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-23-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:28PM +0800, Yuyang Du wrote:
> The new bit can be any possible lock usage except it is garbage, so the

s/except it/except when it/ ?

> cases in switch can be made simpler. Warn early on if wrong usage bit is
> passed without taking locks. No functional change.
> 
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  kernel/locking/lockdep.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c08ec88..291cc9c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3476,6 +3476,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  {
>  	unsigned int new_mask = 1 << new_bit, ret = 1;
>  
> +	if (new_bit >= LOCK_USAGE_STATES) {
> +		WARN_ON(1);

Does that want to be DEBUG_LOCKS_WARN_ON() ?

> +		return 0;
> +	}
> +
>  	/*
>  	 * If already set then do not dirty the cacheline,
>  	 * nor do any checks:
> @@ -3499,25 +3504,13 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
>  		return 0;
>  
>  	switch (new_bit) {
> -#define LOCKDEP_STATE(__STATE)			\
> -	case LOCK_USED_IN_##__STATE:		\
> -	case LOCK_USED_IN_##__STATE##_READ:	\
> -	case LOCK_ENABLED_##__STATE:		\
> -	case LOCK_ENABLED_##__STATE##_READ:
> -#include "lockdep_states.h"
> -#undef LOCKDEP_STATE
> -		ret = mark_lock_irq(curr, this, new_bit);
> -		if (!ret)
> -			return 0;
> -		break;
>  	case LOCK_USED:
>  		debug_atomic_dec(nr_unused_locks);
>  		break;
>  	default:
> -		if (!debug_locks_off_graph_unlock())
> +		ret = mark_lock_irq(curr, this, new_bit);
> +		if (!ret)
>  			return 0;
> -		WARN_ON(1);
> -		return 0;
>  	}
>  
>  	graph_unlock();
> -- 
> 1.8.3.1
> 
