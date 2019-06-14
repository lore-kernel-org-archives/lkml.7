Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88042064A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TadOisdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNSK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:10:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54737 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:10:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so3247017wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wv3HlZE6g6Wbt/9LonLwc2WUphexFVDz/Zzmtp0xCh0=;
        b=TadOisdUxkOC30jJ5+SAjB2Q4OdxZ72lyXUD+L1zNmks23TX94oXMXSD4Kg0lPS7op
         2Zmc9ILAKHo4qQ4ncxmd8MuqHOmer5nTFh0hrmzSoagGqJ9osGD0Vbu0yHC2Hk5yNGLX
         d1mmQU1DgS6Ab8CQmhka9TAaoFmpD2gFMLRSWd247KoVyM8F7aorRVLOh2cE4fwbzINe
         EP5bAz8ilkI4bpbc4v+zLdOZIkQGHL9y2Pn12ElzS5uJIbqWwNqhxRdUIAnCX+okK3jj
         er1fxa7LUi3caRmidv3PFW+P+HiqH525n61zkV48v/qHPY86xkj41p3QWoPMTspvExES
         tx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wv3HlZE6g6Wbt/9LonLwc2WUphexFVDz/Zzmtp0xCh0=;
        b=G6QnlTXwMG2GtsM3+ipc2XzQk15vG/7oac+fVPnHxLNm/xCOQ6cHfa3QxGEPG3wn3n
         TTQOL1b8GVspIu3puv37f7En3+7ymwKoUuJ7xC6I+NZ0m6VkpTcyVqGm+9keHECfYQIs
         DJluaLkQtOrQ8oFsjyuJpHbHDbbJ/TCajpbcdjsa2sR6DUBw+Vq61NCdFg53olGc/tIY
         F7NiZScy2i/TCZ2i48f7gO1qUngc16VI3fLoCF5NnL2H8kA+JldWCyijU4qBlKGKPjM1
         uYVhvhQWlTnzDhXy3EISmzIte+GDmJSgCEz37KOQ3HRK1H2RxIkDUAxb23hDGYsonJMO
         tehw==
X-Gm-Message-State: APjAAAWgTRo6cn93D8igJotN3gg4y4VdgLpN5Tr9CoRf/Dmdzh0yL7up
        SAYBbRTcAVBD1ZW8Fx1nVcs=
X-Google-Smtp-Source: APXvYqxdgGizGEmUlwXfBiUohUwqgavOTNPadW15sO7251QU0fzCKqt++6/MN5hlLBR0NjYQRCb4wg==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr8791094wmf.139.1560535822572;
        Fri, 14 Jun 2019 11:10:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id h14sm3959664wrs.66.2019.06.14.11.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:10:22 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
To:     Peter Zijlstra <peterz@infradead.org>, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
Date:   Fri, 14 Jun 2019 20:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614152242.GC23020@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 17:22 schrieb Daniel Vetter:
> On Fri, Jun 14, 2019 at 03:19:16PM +0200, Peter Zijlstra wrote:
>> On Fri, Jun 14, 2019 at 02:41:22PM +0200, Christian König wrote:
>>> Use the provided macros instead of implementing deadlock handling on our own.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
>>>   1 file changed, 12 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>>> index 50de138c89e0..6e4623d3bee2 100644
>>> --- a/drivers/gpu/drm/drm_gem.c
>>> +++ b/drivers/gpu/drm/drm_gem.c
>>> @@ -1307,51 +1307,26 @@ int
>>>   drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
>>>   			  struct ww_acquire_ctx *acquire_ctx)
>>>   {
>>> -	int contended = -1;
>>> +	struct ww_mutex *contended;
>>>   	int i, ret;
>>>   
>>>   	ww_acquire_init(acquire_ctx, &reservation_ww_class);
>>>   
>>> -retry:
>>> -	if (contended != -1) {
>>> -		struct drm_gem_object *obj = objs[contended];
>>> -
>>> -		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
>>> -						       acquire_ctx);
>>> -		if (ret) {
>>> -			ww_acquire_done(acquire_ctx);
>>> -			return ret;
>>> -		}
>>> -	}
>>> -
>>> -	for (i = 0; i < count; i++) {
>>> -		if (i == contended)
>>> -			continue;
>>> -
>>> -		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
>>> -						  acquire_ctx);
>>> -		if (ret) {
>>> -			int j;
>>> -
>>> -			for (j = 0; j < i; j++)
>>> -				ww_mutex_unlock(&objs[j]->resv->lock);
>>> -
>>> -			if (contended != -1 && contended >= i)
>>> -				ww_mutex_unlock(&objs[contended]->resv->lock);
>>> -
>>> -			if (ret == -EDEADLK) {
>>> -				contended = i;
>>> -				goto retry;
>>> -			}
>>> -
>>> -			ww_acquire_done(acquire_ctx);
>>> -			return ret;
>>> -		}
>>> -	}
>> I note all the sites you use this on are simple idx iterators; so how
>> about something like so:
>>
>> int ww_mutex_unlock_all(int count, void *data, struct ww_mutex *(*func)(int, void *))
>> {
>> 	int i;
>>
>> 	for (i = 0; i < count; i++) {
>> 		lock = func(i, data);
>> 		ww_mutex_unlock(lock);
>> 	}
>> }
>>
>> int ww_mutex_lock_all(int count, struct ww_acquire_context *acquire_ctx, bool intr,
>> 		      void *data, struct ww_mutex *(*func)(int, void *))
>> {
>> 	int i, ret, contended = -1;
>> 	struct ww_mutex *lock;
>>
>> retry:
>> 	if (contended != -1) {
>> 		lock = func(contended, data);
>> 		if (intr)
>> 			ret = ww_mutex_lock_slow_interruptible(lock, acquire_ctx);
>> 		else
>> 			ret = ww_mutex_lock_slow(lock, acquire_ctx), 0;
>>
>> 		if (ret) {
>> 			ww_acquire_done(acquire_ctx);
>> 			return ret;
>> 		}
>> 	}
>>
>> 	for (i = 0; i < count; i++) {
>> 		if (i == contended)
>> 			continue;
>>
>> 		lock = func(i, data);
>> 		if (intr)
>> 			ret = ww_mutex_lock_interruptible(lock, acquire_ctx);
>> 		else
>> 			ret = ww_mutex_lock(lock, acquire_ctx), 0;
>>
>> 		if (ret) {
>> 			ww_mutex_unlock_all(i, data, func);
>> 			if (contended > i) {
>> 				lock = func(contended, data);
>> 				ww_mutex_unlock(lock);
>> 			}
>>
>> 			if (ret == -EDEADLK) {
>> 				contended = i;
>> 				goto retry;
>> 			}
>>
>> 			ww_acquire_done(acquire_ctx);
>> 			return ret;
>> 		}
>> 	}
>>
>> 	ww_acquire_done(acquire_ctx);
>> 	return 0;
>> }
>>
>>> +	ww_mutex_lock_for_each(for (i = 0; i < count; i++),
>>> +			       &objs[i]->resv->lock, contended, ret, true,
>>> +			       acquire_ctx)
>>> +		if (ret)
>>> +			goto error;
>> which then becomes:
>>
>> struct ww_mutex *gem_ww_mutex_func(int i, void *data)
>> {
>> 	struct drm_gem_object **objs = data;
>> 	return &objs[i]->resv->lock;
>> }
>>
>> 	ret = ww_mutex_lock_all(count, acquire_ctx, true, objs, gem_ww_mutex_func);
>>
>>>   	ww_acquire_done(acquire_ctx);
>>>   
>>>   	return 0;
>>> +
>>> +error:
>>> +	ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
>>> +				 &objs[i]->resv->lock, contended);
>>> +	ww_acquire_done(acquire_ctx);
>>> +	return ret;
>>>   }
>>>   EXPORT_SYMBOL(drm_gem_lock_reservations);
> Another idea, entirely untested (I guess making sure that we can use the
> same iterator for both locking and unlocking in the contended case will be
> fun), but maybe something like this:
>
> 	WW_MUTEX_LOCK_BEGIN();
> 	driver_for_each_loop (iter, pos) {
> 		WW_MUTEX_LOCK(&pos->ww_mutex);
> 	}
> 	WW_MUTEX_LOCK_END();
>
> That way we can reuse any and all iterators that'll ever show up at least.
> It's still horrible because the macros need to jump around between all of
> them.

Yeah, I tried this as well and that's exactly the reason why I discarded 
this approach.

There is this hack with goto *void we could use, but I'm pretty sure 
that is actually not part of any C standard.

> Would also make this useful for more cases, where maybe you need to
> trylock some lru lock to get at your next ww_mutex, or do some
> kref_get_unless_zero. Buffer eviction loops tend to acquire these, and
> that would all get ugly real fast if we'd need to stuff it into some
> iterator argument.

Well I don't see a use case with eviction in general. The dance there 
requires something different as far as I can see.

Christian.

> This is kinda what we went with for modeset locks with
> DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in between the
> pair at least. But it's a lot more limited use-cases, maybe too fragile an
> idea for ww_mutex in full generality.
>
> Not going to type this out because too much w/e mode here already, but I
> can give it a stab next week.
> -Daniel

