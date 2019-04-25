Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31739205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDYZJv2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfDYTzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfDYTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VOZ0OpoJ76M1yqdpvv8yJsTY4zgs8X+CEIvxpLsiyZw=; b=jDYZJv2MuyVq0uDtRxHjNnk8S
        NaRI/nO6b2o8Kcb6+X+ibBTCbGIIE+WXxVtVr02NBSTJv1jQeNyRRiI3Pu8iYNtn67e6sr7n4GB7t
        6cgcyQaGVcToDPlhVM13g3PlgO+975scbyDlFmP7GdJP7RtSogv88yVQNwAQcXa4CWS2AJxz1x9Ir
        tVAQrFVz02VzxjlbnlH+1DUwAZoUZ5ELshIQ3aCK+gC3qOCetC+Gm2lKd5dFUeWSS0qo0juyv3F15
        JTkNlmPZUEAjKkWShjZu1dWPNsryC0OTt7mLrtBoowNhmLik7jGGnpdbEKE6cwxbLzk4CZLNs/r2S
        EHis7BZAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJkSj-0003L3-5L; Thu, 25 Apr 2019 19:55:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9948920288CFF; Thu, 25 Apr 2019 21:55:15 +0200 (CEST)
Date:   Thu, 25 Apr 2019 21:55:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/28] locking/lockdep: Update irqsafe lock bitmaps
Message-ID: <20190425195515.GX12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-24-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-24-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:29PM +0800, Yuyang Du wrote:
> The bitmaps keep track of which locks are irqsafe. Update the bitmaps
> when there is new irqsafe usage and when an irqsafe lock is zapped.
> 
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  kernel/locking/lockdep.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 291cc9c..1b78216 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3107,6 +3107,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
>  	int excl_bit = exclusive_bit(new_bit);
>  	int read = new_bit & LOCK_USAGE_READ_MASK;
>  	int dir = new_bit & LOCK_USAGE_DIR_MASK;
> +	struct lock_class *lock = hlock_class(this);
>  
>  	/*
>  	 * mark USED_IN has to look forwards -- to ensure no dependency
> @@ -3119,6 +3120,25 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
>  		check_usage_backwards : check_usage_forwards;
>  
>  	/*
> +	 * The bit is already marked so that we update the bitmaps
> +	 * before validation.
> +	 */
> +	if (!dir) {
> +		unsigned long *bitmaps[4] = {
> +			lock_classes_hardirq_safe,
> +			lock_classes_hardirq_safe_read,
> +			lock_classes_softirq_safe,
> +			lock_classes_softirq_safe_read

That again should be something CPP magic using lockdep_states.h.

Also, that array can be static const, right? It's just an index into the
static bitmaps.

> +		};
> +		int index = (new_bit >> 2) << 1;
> +
> +		if (read)
> +		       index += 1;
> +
> +		__set_bit(lock - lock_classes, bitmaps[index]);
> +	}
> +
> +	/*
>  	 * Validate that this particular lock does not have conflicting
>  	 * usage states.
>  	 */
> @@ -3146,7 +3166,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
>  			return 0;
>  	}
>  
> -	if (state_verbose(new_bit, hlock_class(this)))
> +	if (state_verbose(new_bit, lock))
>  		return 2;
>  
>  	return 1;
> @@ -4650,6 +4670,22 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
>  	}
>  }
>  
> +static inline void remove_irqsafe_lock_bitmap(struct lock_class *class)
> +{
> +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
> +	unsigned long usage = class->usage_mask;
> +
> +	if (usage & LOCKF_USED_IN_HARDIRQ)
> +		__clear_bit(class - lock_classes, lock_classes_hardirq_safe);
> +	if (usage & LOCKF_USED_IN_HARDIRQ_READ)
> +		__clear_bit(class - lock_classes, lock_classes_hardirq_safe_read);
> +	if (usage & LOCKF_USED_IN_SOFTIRQ)
> +		__clear_bit(class - lock_classes, lock_classes_softirq_safe);
> +	if (usage & LOCKF_USED_IN_SOFTIRQ_READ)
> +		__clear_bit(class - lock_classes, lock_classes_softirq_safe_read);

More CPP foo required here. Also, do we really need to test, we could
just unconditionally clear the bits.

> +#endif
> +}
