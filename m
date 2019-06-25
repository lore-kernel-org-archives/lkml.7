Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D6C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BEA20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMd9lD9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfFYOgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:36:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33809 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFYOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:36:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so18204394wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nsiDQwwlUMya2NaloHB/g19Qxbl0uFlPZzS2rBPQg0o=;
        b=FMd9lD9eHd2C7+rF9Z5/RFn3UymwzrNeQp5IKv6P1zaqVvzj68sYc4Voh5gAHtfxde
         /6H1YkcdttQ1T5VaUryqBJXX4c34dBce43gHOuIQBWOcxegzsIR5iA3QGZ/stAJaiY/v
         SfJmxDnEPHGeSCr3yRl0e82GKcey6ZCelZGchrFpA3/pwV2v9AZnX56QQpVtZXQNWnLI
         vUKnzbpWnnfwOLD4DHLzY/cJqFP6PpTEZjkRrDVyhJAQgs1boNehX56VDVPiJdSrvuHx
         WdbjlDPmYh0l0lWUFIeVYZ/rcw6b6p8zFV5SJXku4XyXGqgzJ16vqkcdkeoQb5xyuQgU
         1xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nsiDQwwlUMya2NaloHB/g19Qxbl0uFlPZzS2rBPQg0o=;
        b=b3uAba2ohuCgF86VZpj5z5wDUKfz83uIRQyvaGBCWfsKjwFE6drXmh043mtqE2V4r8
         bl6CcRnq6gFWDgkC9XZLtRCrxoLKXzKrqPG6gmC/VBL8v13jtgcNDOT3WKzwb6EEy3pp
         dICC3CGyWpAOkvWBL4QaNdaMVYrcGXf61H6WFK7Sp9szAveGYmCostv/stYTlOh6VlOb
         NaoUsv0AA3vKPan+YPHtLXWrGKh6Ahsupx3wdfK7bY4yRPX3g3VTS6v408yyNDgUPMTi
         qs64dmIHzMucf5EZTY5USyKtlV6E8/Vj8dNfrRQcyP0bpceRInGS5xtA7ZsfyJMKBHiX
         B1uQ==
X-Gm-Message-State: APjAAAUbfYDgOTU2ZaFUa0jLo2FMBC+ba/RkOcQOOqBA4JpDIfjozmaV
        yuLxUCyqQYWpxqlhlC+WNg9SCUSN
X-Google-Smtp-Source: APXvYqzE/KqmSHY/7SiUS9iovra9CVFDhj9vICfRnFQA0hPN0anCAybqfL9mPZfG6BMjXepF3DTZMA==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr18069221wrq.350.1561473392182;
        Tue, 25 Jun 2019 07:36:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id e11sm32885267wrc.9.2019.06.25.07.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:36:31 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] dma-buf: add reservation_context for deadlock
 handling
To:     peterz@infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190625135507.80548-1-christian.koenig@amd.com>
 <20190625141624.GU12905@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9d64929c-0343-e6b0-a4fe-3af541abbd6a@gmail.com>
Date:   Tue, 25 Jun 2019 16:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625141624.GU12905@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.06.19 um 16:16 schrieb Daniel Vetter:
> On Tue, Jun 25, 2019 at 03:55:06PM +0200, Christian König wrote:
>> The ww_mutex framework allows for detecting deadlocks when multiple
>> threads try to acquire the same set of locks in different order.
>>
>> The problem is that handling those deadlocks was the burden of the user of
>> the ww_mutex implementation and at least some users didn't got that right
>> on the first try.
>>
>> So introduce a new reservation_context object which can be used to
>> simplify the deadlock handling. This is done by tracking all locked
>> reservation objects in the context as well as the last contended
>> reservation object.
>>
>> When a deadlock occurse we now unlock all previously locked object and
>> acquire the contended lock in the slow path. After this is done -EDEADLK
>> is still returned to signal that all other locks now need to be
>> re-acquired again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/dma-buf/reservation.c | 82 +++++++++++++++++++++++++++++++++++
>>   include/linux/reservation.h   | 38 ++++++++++++++++
>>   2 files changed, 120 insertions(+)
>>
>> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
>> index 4d32e2c67862..9e53e42b053a 100644
>> --- a/drivers/dma-buf/reservation.c
>> +++ b/drivers/dma-buf/reservation.c
>> @@ -55,6 +55,88 @@ EXPORT_SYMBOL(reservation_seqcount_class);
>>   const char reservation_seqcount_string[] = "reservation_seqcount";
>>   EXPORT_SYMBOL(reservation_seqcount_string);
>>   
>> +/**
>> + * reservation_context_init - initialize a reservation context
>> + * @ctx: the context to initialize
>> + *
>> + * Start using this reservation context to lock reservation objects for update.
> Bunch of hyperlinks here for more consistent story would be really nice in
> the kerneldoc.
>
>> + */
>> +void reservation_context_init(struct reservation_context *ctx)
>> +{
>> +	ww_acquire_init(&ctx->ctx, &reservation_ww_class);
>> +	init_llist_head(&ctx->locked);
>> +	ctx->contended = NULL;
>> +}
>> +EXPORT_SYMBOL(reservation_context_init);
>> +
>> +/**
>> + * reservation_context_unlock_all - unlock all reservation objects
>> + * @ctx: the context which holds the reservation objects
>> + *
>> + * Unlocks all reservation objects locked with this context.
>> + */
>> +void reservation_context_unlock_all(struct reservation_context *ctx)
> I'd just call this reservation_unlock_all or so. Feel free to ignore the
> bikeshed.
>
>> +{
>> +	struct reservation_object *obj, *next;
>> +
>> +	if (ctx->contended)
>> +		ww_mutex_unlock(&ctx->contended->lock);
>> +	ctx->contended = NULL;
>> +
>> +	llist_for_each_entry_safe(obj, next, ctx->locked.first, locked)
>> +		ww_mutex_unlock(&obj->lock);
>> +	init_llist_head(&ctx->locked);
>> +}
>> +EXPORT_SYMBOL(reservation_context_unlock_all);
>> +
>> +/**
>> + * reservation_context_lock - lock a reservation object with deadlock handling
>> + * @ctx: the context which should be used to lock the object
>> + * @obj: the object which needs to be locked
>> + * @interruptible: if we should wait interruptible or not
>> + *
>> + * Use @ctx to lock the reservation object. If a deadlock is detected we backoff
>> + * by releasing all locked objects and use the slow path to lock the reservation
>> + * object. After successfully locking in the slow path -EDEADLK is returned to
>> + * signal that all other locks must be re-taken as well.
>> + */
>> +int reservation_context_lock(struct reservation_context *ctx,
>> +			     struct reservation_object *obj,
>> +			     bool interruptible)
> reservation_lock_ctx is what we generally used in drm_modeset_lock, I like
> that bikeshed a bit better.

Actually doesn't sound that good if you ask me.

Is reservation_lock_ctx the name of the function or the name of the 
structure?

> Also to stay in style I think the explicit set of functions is much
> better, i.e. reservation_lock_ctx, reservation_lock_interruptible_ctx and
> reservation_trylock_ctx (later useful for lru applications where you still
> want to drop the entire pile with resrvation_unlock_ctx).

The problem is that I then will duplicate a lot of logic between 
reservation_lock_ctx and reservation_lock_interruptible_ctx.

> That's what all the other locking things do. ttm_bo_reserve has a long
> list of parameters, and I can never remember which is which. I don't think
> that's a great style.

Yeah, I don't really like that either. It is one of the reasons why I 
want to get rid of it.

But duplicating implementations is not a good idea either. We could go 
down the wait_event_* wait of doing thins and implement everything in 
macros, but I don't really like that either.

> Another option for interruptible vs. not is to store that in the
> reservation_context and dtrt. Since generally interruptible or not is a
> propery of the top-level handler - you need be able to pass EDEADLCK all
> the way up anyway.
>
>> +{
>> +	int ret = 0;
>> +
>> +	if (unlikely(ctx->contended == obj))
>> +		ctx->contended = NULL;
> Imo cleaner to handle that with EALREADY filtering from the ww_mutex_lock.

How do you want to do this? EALREADY handling is different for different 
users of this API.

Christian.

>
>> +	else if (interruptible)
>> +		ret = ww_mutex_lock_interruptible(&obj->lock, &ctx->ctx);
>> +	else
>> +		ret = ww_mutex_lock(&obj->lock, &ctx->ctx);
>> +
>> +	if (likely(!ret)) {
>> +		/* don't use llist_add here, we have separate locking */
>> +		obj->locked.next = ctx->locked.first;
>> +		ctx->locked.first = &obj->locked;
>> +		return 0;
>> +	}
>> +	if (unlikely(ret != -EDEADLK))
>> +		return ret;
>> +
>> +	reservation_context_unlock_all(ctx);
>> +
>> +	if (interruptible) {
>> +		ret = ww_mutex_lock_slow_interruptible(&obj->lock, &ctx->ctx);
>> +		if (unlikely(ret))
>> +			return ret;
>> +	} else {
>> +		ww_mutex_lock_slow(&obj->lock, &ctx->ctx);
>> +	}
>> +
>> +	ctx->contended = obj;
>> +	return -EDEADLK;
>> +}
>> +EXPORT_SYMBOL(reservation_context_lock);
>> +
>>   /**
>>    * reservation_object_reserve_shared - Reserve space to add shared fences to
>>    * a reservation_object.
>> diff --git a/include/linux/reservation.h b/include/linux/reservation.h
>> index ee750765cc94..a8a52e5d3e80 100644
>> --- a/include/linux/reservation.h
>> +++ b/include/linux/reservation.h
>> @@ -44,11 +44,48 @@
>>   #include <linux/slab.h>
>>   #include <linux/seqlock.h>
>>   #include <linux/rcupdate.h>
>> +#include <linux/llist.h>
>>   
>>   extern struct ww_class reservation_ww_class;
>>   extern struct lock_class_key reservation_seqcount_class;
>>   extern const char reservation_seqcount_string[];
>>   
>> +/**
>> + * struct reservation_context - context to lock reservation objects
>> + * @ctx: ww_acquire_ctx used for deadlock detection
>> + * @locked: list of reservation objects locked in this context
>> + * @contended: contended reservation object
>> + */
>> +struct reservation_context {
>> +	struct ww_acquire_ctx ctx;
>> +	struct llist_head locked;
>> +	struct reservation_object *contended;
>> +};
>> +
>> +/**
>> + * reservation_context_done - wrapper for ww_acquire_done
>> + * @ctx: the reservation context which is done with locking
>> + */
>> +static inline void reservation_context_done(struct reservation_context *ctx)
>> +{
>> +	ww_acquire_done(&ctx->ctx);
>> +}
>> +
>> +/**
>> + * reservation_context_fini - wrapper for ww_acquire_fini
>> + * @ctx: the reservation context which is finished
>> + */
>> +static inline void reservation_context_fini(struct reservation_context *ctx)
>> +{
>> +	ww_acquire_fini(&ctx->ctx);
>> +}
>> +
>> +void reservation_context_init(struct reservation_context *ctx);
>> +void reservation_context_unlock_all(struct reservation_context *ctx);
>> +int reservation_context_lock(struct reservation_context *ctx,
>> +			     struct reservation_object *obj,
>> +			     bool interruptible);
> Needs a __must_check.
>
>> +
>>   /**
>>    * struct reservation_object_list - a list of shared fences
>>    * @rcu: for internal use
>> @@ -71,6 +108,7 @@ struct reservation_object_list {
>>    */
>>   struct reservation_object {
>>   	struct ww_mutex lock;
>> +	struct llist_node locked;
>>   	seqcount_t seq;
>>   
>>   	struct dma_fence __rcu *fence_excl;
> Aside from the nits&bikesheds, I like.
> -Daniel
>
>> -- 
>> 2.17.1
>>

