Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A79C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD192133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jvc8lgVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfFYOWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:22:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfFYOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TeTpjKWd461qmBPHaiV1+2YHstOBlkUWCmJFPzdC/eM=; b=Jvc8lgVhpv+7qNBW0oEsTZYf67
        UfeCCAixLzwmnboBD8nA8yplOy4PbCUKZzyGe1p7Q8mnvjxFgCHXlMEQsxTSv2YW0n8+LbWtdOJVD
        fWyI7eI40l1TftNhNp1n4AFNBb5LaGrO9gwFX0ItnzEuDthYd+B/UDHWaE32oxlplLh/5IpdG2huQ
        TG3mYh+zhu+SWm8LpLD0dh+/EQOfDM30tOFRQVy5DrQRMQ73XxOeyRYKLRt/8xD6cuABbepDuoeuV
        6NDhEEpHOWtuXi8hkoGUbcgoy2rg9ESDT5RRohyDl665Qz3ieakd5ZLECi/4zYszmIvF1mDnAn35u
        ce7f0qWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfmKt-0001oV-SU; Tue, 25 Jun 2019 14:22:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1FCE209FD685; Tue, 25 Jun 2019 16:22:14 +0200 (CEST)
Date:   Tue, 25 Jun 2019 16:22:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-buf: add reservation_context for deadlock
 handling
Message-ID: <20190625142214.GD3419@hirez.programming.kicks-ass.net>
References: <20190625135507.80548-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625135507.80548-1-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:55:06PM +0200, Christian König wrote:

> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
> index 4d32e2c67862..9e53e42b053a 100644
> --- a/drivers/dma-buf/reservation.c
> +++ b/drivers/dma-buf/reservation.c
> @@ -55,6 +55,88 @@ EXPORT_SYMBOL(reservation_seqcount_class);
>  const char reservation_seqcount_string[] = "reservation_seqcount";
>  EXPORT_SYMBOL(reservation_seqcount_string);
>  
> +/**
> + * reservation_context_init - initialize a reservation context
> + * @ctx: the context to initialize
> + *
> + * Start using this reservation context to lock reservation objects for update.
> + */
> +void reservation_context_init(struct reservation_context *ctx)
> +{
> +	ww_acquire_init(&ctx->ctx, &reservation_ww_class);
> +	init_llist_head(&ctx->locked);

	ctx->locked = NULL;

> +	ctx->contended = NULL;
> +}
> +EXPORT_SYMBOL(reservation_context_init);
> +
> +/**
> + * reservation_context_unlock_all - unlock all reservation objects
> + * @ctx: the context which holds the reservation objects
> + *
> + * Unlocks all reservation objects locked with this context.
> + */
> +void reservation_context_unlock_all(struct reservation_context *ctx)
> +{
> +	struct reservation_object *obj, *next;
> +
> +	if (ctx->contended)
> +		ww_mutex_unlock(&ctx->contended->lock);
> +	ctx->contended = NULL;
> +
> +	llist_for_each_entry_safe(obj, next, ctx->locked.first, locked)
> +		ww_mutex_unlock(&obj->lock);

	for (obj = ctx->locked; obj && (next = obj->locked, true); obj = next)

> +	init_llist_head(&ctx->locked);

	ctx->locked = NULL;
> +}
> +EXPORT_SYMBOL(reservation_context_unlock_all);
> +
> +/**
> + * reservation_context_lock - lock a reservation object with deadlock handling
> + * @ctx: the context which should be used to lock the object
> + * @obj: the object which needs to be locked
> + * @interruptible: if we should wait interruptible or not
> + *
> + * Use @ctx to lock the reservation object. If a deadlock is detected we backoff
> + * by releasing all locked objects and use the slow path to lock the reservation
> + * object. After successfully locking in the slow path -EDEADLK is returned to
> + * signal that all other locks must be re-taken as well.
> + */
> +int reservation_context_lock(struct reservation_context *ctx,
> +			     struct reservation_object *obj,
> +			     bool interruptible)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(ctx->contended == obj))
> +		ctx->contended = NULL;
> +	else if (interruptible)
> +		ret = ww_mutex_lock_interruptible(&obj->lock, &ctx->ctx);
> +	else
> +		ret = ww_mutex_lock(&obj->lock, &ctx->ctx);
> +
> +	if (likely(!ret)) {
> +		/* don't use llist_add here, we have separate locking */
> +		obj->locked.next = ctx->locked.first;
> +		ctx->locked.first = &obj->locked;

Since you're not actually using llist, could you then maybe open-code
the whole thing and not rely on its implementation?

That is, it hardly seems worth the trouble, as shown the bits you do use
are hardly longer than just writing it out. Also, I was confused by the
use of llist, as I wondered where the concurrency came from.

> +		return 0;
> +	}
> +	if (unlikely(ret != -EDEADLK))
> +		return ret;
> +
> +	reservation_context_unlock_all(ctx);
> +
> +	if (interruptible) {
> +		ret = ww_mutex_lock_slow_interruptible(&obj->lock, &ctx->ctx);
> +		if (unlikely(ret))
> +			return ret;
> +	} else {
> +		ww_mutex_lock_slow(&obj->lock, &ctx->ctx);
> +	}
> +
> +	ctx->contended = obj;
> +	return -EDEADLK;
> +}
> +EXPORT_SYMBOL(reservation_context_lock);

> diff --git a/include/linux/reservation.h b/include/linux/reservation.h
> index ee750765cc94..a8a52e5d3e80 100644
> --- a/include/linux/reservation.h
> +++ b/include/linux/reservation.h

> +struct reservation_context {
> +	struct ww_acquire_ctx ctx;
> +	struct llist_head locked;

	struct reservation_object *locked;

> +	struct reservation_object *contended;
> +};

> @@ -71,6 +108,7 @@ struct reservation_object_list {
>   */
>  struct reservation_object {
>  	struct ww_mutex lock;
> +	struct llist_node locked;

	struct reservation_object *locked;

>  	seqcount_t seq;
>  
>  	struct dma_fence __rcu *fence_excl;
> -- 
> 2.17.1
> 
