Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C569C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543E213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OA6eSJE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfFYOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:16:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42840 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfFYOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:16:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so27387749edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tnMBWYCVBdcpdafowMm9MFdzo2BD+6W5hnRfbxq5mek=;
        b=OA6eSJE9ecZ5NYDwIgZq8Oh8LFjsk3ysp0VIVZeK/aWqFT/M9fMXCsaU/GDJg75e8w
         Af5kWs7wvdSJAfdL8e1ibQhQCD50zx/IcMEisZZdwxM58aTvK7P37kY3X5HpPsna6fRE
         GDQr8KR+ihfZApnCzvMgwh6Qj3fdvoJVE/jtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tnMBWYCVBdcpdafowMm9MFdzo2BD+6W5hnRfbxq5mek=;
        b=p7ndbh1zM8W2I2VScbBlHwlrv00CKh7dA/DPV6oS0zoZJWpEdFdMpkXmbDBLCWhCZx
         xZFx0a2kh/a+J638DJaqom4y+uowkZQcAAo8D7PTKhEkyTJHmT4d5IE+tW7zb+TpKXaf
         YlZ7pcFkW2wONp4BL81HxwuxuKBPIV/nzMMbSfmkGdciE/fhPeDGYc0/JmGPULUXqAE2
         8b+hu2fRGuaxCQxUftTfBg5fnKn0uvoMiz1bgTOJRio9TIf6kNIGWa01cj2OCw34jx9p
         grLCavu26+IeKz+W2u0q+gCBdZcrs5p2J/IsMlrNMYAWT0b46oPDyKfwx+lIYqs+iMYN
         9cKg==
X-Gm-Message-State: APjAAAVEG7BqFEJXJkZuYJn18Ri3qxXPZB3FRaLfUdLJeplXNz2O7WJt
        uWMeAGwZ5idbDvxRUgCcNIaE15HIYSo=
X-Google-Smtp-Source: APXvYqzSeREvdGQh3y7dieGAECtpPwNQiPIMt50389kpmzj4j8CSDaYSBRez6p4tdLGR2MgczIP0EQ==
X-Received: by 2002:a17:906:2a94:: with SMTP id l20mr50848607eje.131.1561472187162;
        Tue, 25 Jun 2019 07:16:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 9sm2450886ejg.49.2019.06.25.07.16.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:16:26 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:16:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel@ffwll.ch, peterz@infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-buf: add reservation_context for deadlock
 handling
Message-ID: <20190625141624.GU12905@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        peterz@infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190625135507.80548-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625135507.80548-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 03:55:06PM +0200, Christian König wrote:
> The ww_mutex framework allows for detecting deadlocks when multiple
> threads try to acquire the same set of locks in different order.
> 
> The problem is that handling those deadlocks was the burden of the user of
> the ww_mutex implementation and at least some users didn't got that right
> on the first try.
> 
> So introduce a new reservation_context object which can be used to
> simplify the deadlock handling. This is done by tracking all locked
> reservation objects in the context as well as the last contended
> reservation object.
> 
> When a deadlock occurse we now unlock all previously locked object and
> acquire the contended lock in the slow path. After this is done -EDEADLK
> is still returned to signal that all other locks now need to be
> re-acquired again.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/reservation.c | 82 +++++++++++++++++++++++++++++++++++
>  include/linux/reservation.h   | 38 ++++++++++++++++
>  2 files changed, 120 insertions(+)
> 
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

Bunch of hyperlinks here for more consistent story would be really nice in
the kerneldoc.

> + */
> +void reservation_context_init(struct reservation_context *ctx)
> +{
> +	ww_acquire_init(&ctx->ctx, &reservation_ww_class);
> +	init_llist_head(&ctx->locked);
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

I'd just call this reservation_unlock_all or so. Feel free to ignore the
bikeshed.

> +{
> +	struct reservation_object *obj, *next;
> +
> +	if (ctx->contended)
> +		ww_mutex_unlock(&ctx->contended->lock);
> +	ctx->contended = NULL;
> +
> +	llist_for_each_entry_safe(obj, next, ctx->locked.first, locked)
> +		ww_mutex_unlock(&obj->lock);
> +	init_llist_head(&ctx->locked);
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

reservation_lock_ctx is what we generally used in drm_modeset_lock, I like
that bikeshed a bit better.

Also to stay in style I think the explicit set of functions is much
better, i.e. reservation_lock_ctx, reservation_lock_interruptible_ctx and
reservation_trylock_ctx (later useful for lru applications where you still
want to drop the entire pile with resrvation_unlock_ctx).

That's what all the other locking things do. ttm_bo_reserve has a long
list of parameters, and I can never remember which is which. I don't think
that's a great style.

Another option for interruptible vs. not is to store that in the
reservation_context and dtrt. Since generally interruptible or not is a
propery of the top-level handler - you need be able to pass EDEADLCK all
the way up anyway.

> +{
> +	int ret = 0;
> +
> +	if (unlikely(ctx->contended == obj))
> +		ctx->contended = NULL;

Imo cleaner to handle that with EALREADY filtering from the ww_mutex_lock.

> +	else if (interruptible)
> +		ret = ww_mutex_lock_interruptible(&obj->lock, &ctx->ctx);
> +	else
> +		ret = ww_mutex_lock(&obj->lock, &ctx->ctx);
> +
> +	if (likely(!ret)) {
> +		/* don't use llist_add here, we have separate locking */
> +		obj->locked.next = ctx->locked.first;
> +		ctx->locked.first = &obj->locked;
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
> +
>  /**
>   * reservation_object_reserve_shared - Reserve space to add shared fences to
>   * a reservation_object.
> diff --git a/include/linux/reservation.h b/include/linux/reservation.h
> index ee750765cc94..a8a52e5d3e80 100644
> --- a/include/linux/reservation.h
> +++ b/include/linux/reservation.h
> @@ -44,11 +44,48 @@
>  #include <linux/slab.h>
>  #include <linux/seqlock.h>
>  #include <linux/rcupdate.h>
> +#include <linux/llist.h>
>  
>  extern struct ww_class reservation_ww_class;
>  extern struct lock_class_key reservation_seqcount_class;
>  extern const char reservation_seqcount_string[];
>  
> +/**
> + * struct reservation_context - context to lock reservation objects
> + * @ctx: ww_acquire_ctx used for deadlock detection
> + * @locked: list of reservation objects locked in this context
> + * @contended: contended reservation object
> + */
> +struct reservation_context {
> +	struct ww_acquire_ctx ctx;
> +	struct llist_head locked;
> +	struct reservation_object *contended;
> +};
> +
> +/**
> + * reservation_context_done - wrapper for ww_acquire_done
> + * @ctx: the reservation context which is done with locking
> + */
> +static inline void reservation_context_done(struct reservation_context *ctx)
> +{
> +	ww_acquire_done(&ctx->ctx);
> +}
> +
> +/**
> + * reservation_context_fini - wrapper for ww_acquire_fini
> + * @ctx: the reservation context which is finished
> + */
> +static inline void reservation_context_fini(struct reservation_context *ctx)
> +{
> +	ww_acquire_fini(&ctx->ctx);
> +}
> +
> +void reservation_context_init(struct reservation_context *ctx);
> +void reservation_context_unlock_all(struct reservation_context *ctx);
> +int reservation_context_lock(struct reservation_context *ctx,
> +			     struct reservation_object *obj,
> +			     bool interruptible);

Needs a __must_check.

> +
>  /**
>   * struct reservation_object_list - a list of shared fences
>   * @rcu: for internal use
> @@ -71,6 +108,7 @@ struct reservation_object_list {
>   */
>  struct reservation_object {
>  	struct ww_mutex lock;
> +	struct llist_node locked;
>  	seqcount_t seq;
>  
>  	struct dma_fence __rcu *fence_excl;

Aside from the nits&bikesheds, I like.
-Daniel

> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
