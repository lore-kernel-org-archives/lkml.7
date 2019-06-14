Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1701FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F572133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d8QFLc0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:22:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40177 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfFNPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:22:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so4015166eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dXndqQ1AQICqmvtwsrmWxtGA2LkxXy4opA3uGDC+gYY=;
        b=d8QFLc0X7BeHMuw1YHf2wvaXSPx8ffwCsfn7Hjqz39LN3vc4CJeI2ACBnDIX2FkzWw
         OTH8nK0RQ6od8ZYHbWp3zjNiXm+xm6eUDfn96nxnWMJzwyqBJgnxBpOAAO6uJZOr5Lp8
         q1Xk6rvZTnEUtRsYFmKR23cVC6ZYlwk9T31S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dXndqQ1AQICqmvtwsrmWxtGA2LkxXy4opA3uGDC+gYY=;
        b=sZ8Qr0wlq6pTDSWPHOyj148Wh4pXIq1ZhK7X/Hx/osdnWVUlsj7xUmXbTk7H0xAcTv
         G2dcwsh1t5jbaDetXnT2QaU6sLwM6cHzGiir8N8b79+qKrNooKxuehufFOBHClA00pnF
         g119E6H0xpuH1nKyHe5I7Id3gVaDcVLDZe21jKeVlbhB8SVpyvwd4Dgunx6AAd4kjW6K
         ei62wUjJJaoCB6nQegSzXf68vvfYes1Uh7NaxLPJGTFhWKDJuD8qu5DidajOc4xXPdJx
         HkfSSkSjtbdWuetwgQqvxho22BsnCVACOUwTe5X7g/H//erXkP/qW8H6exyNpYiiWsCb
         hu4Q==
X-Gm-Message-State: APjAAAXv/lLeB+efUd5ji1aWroEE/OU7e0fsIEMy9Gu+F2CzRdMZdFqX
        faTwt91MdJeKMx3edoF+K/9XTg==
X-Google-Smtp-Source: APXvYqxF89aMMU3nddTZFQ4L9VrL8aHf/ROCuBn3TO1QrfZw98b4GBGGD0sKAyq4iPcPF7wNLQzXUw==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr30705429edq.20.1560525766105;
        Fri, 14 Jun 2019 08:22:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x10sm972203edd.73.2019.06.14.08.22.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:22:45 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:22:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, daniel@ffwll.ch,
        l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, yuq825@gmail.com, eric@anholt.net,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Message-ID: <20190614152242.GC23020@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, yuq825@gmail.com, eric@anholt.net,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:19:16PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 14, 2019 at 02:41:22PM +0200, Christian König wrote:
> > Use the provided macros instead of implementing deadlock handling on our own.
> > 
> > Signed-off-by: Christian König <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
> >  1 file changed, 12 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 50de138c89e0..6e4623d3bee2 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1307,51 +1307,26 @@ int
> >  drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
> >  			  struct ww_acquire_ctx *acquire_ctx)
> >  {
> > -	int contended = -1;
> > +	struct ww_mutex *contended;
> >  	int i, ret;
> >  
> >  	ww_acquire_init(acquire_ctx, &reservation_ww_class);
> >  
> > -retry:
> > -	if (contended != -1) {
> > -		struct drm_gem_object *obj = objs[contended];
> > -
> > -		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
> > -						       acquire_ctx);
> > -		if (ret) {
> > -			ww_acquire_done(acquire_ctx);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	for (i = 0; i < count; i++) {
> > -		if (i == contended)
> > -			continue;
> > -
> > -		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
> > -						  acquire_ctx);
> > -		if (ret) {
> > -			int j;
> > -
> > -			for (j = 0; j < i; j++)
> > -				ww_mutex_unlock(&objs[j]->resv->lock);
> > -
> > -			if (contended != -1 && contended >= i)
> > -				ww_mutex_unlock(&objs[contended]->resv->lock);
> > -
> > -			if (ret == -EDEADLK) {
> > -				contended = i;
> > -				goto retry;
> > -			}
> > -
> > -			ww_acquire_done(acquire_ctx);
> > -			return ret;
> > -		}
> > -	}
> 
> I note all the sites you use this on are simple idx iterators; so how
> about something like so:
> 
> int ww_mutex_unlock_all(int count, void *data, struct ww_mutex *(*func)(int, void *))
> {
> 	int i;
> 
> 	for (i = 0; i < count; i++) {
> 		lock = func(i, data);
> 		ww_mutex_unlock(lock);
> 	}
> }
> 
> int ww_mutex_lock_all(int count, struct ww_acquire_context *acquire_ctx, bool intr,
> 		      void *data, struct ww_mutex *(*func)(int, void *))
> {
> 	int i, ret, contended = -1;
> 	struct ww_mutex *lock;
> 
> retry:
> 	if (contended != -1) {
> 		lock = func(contended, data);
> 		if (intr)
> 			ret = ww_mutex_lock_slow_interruptible(lock, acquire_ctx);
> 		else
> 			ret = ww_mutex_lock_slow(lock, acquire_ctx), 0;
> 
> 		if (ret) {
> 			ww_acquire_done(acquire_ctx);
> 			return ret;
> 		}
> 	}
> 
> 	for (i = 0; i < count; i++) {
> 		if (i == contended)
> 			continue;
> 
> 		lock = func(i, data);
> 		if (intr)
> 			ret = ww_mutex_lock_interruptible(lock, acquire_ctx);
> 		else
> 			ret = ww_mutex_lock(lock, acquire_ctx), 0;
> 
> 		if (ret) {
> 			ww_mutex_unlock_all(i, data, func);
> 			if (contended > i) {
> 				lock = func(contended, data);
> 				ww_mutex_unlock(lock);
> 			}
> 
> 			if (ret == -EDEADLK) {
> 				contended = i;
> 				goto retry;
> 			}
> 
> 			ww_acquire_done(acquire_ctx);
> 			return ret;
> 		}
> 	}
> 
> 	ww_acquire_done(acquire_ctx);
> 	return 0;
> }
> 
> > +	ww_mutex_lock_for_each(for (i = 0; i < count; i++),
> > +			       &objs[i]->resv->lock, contended, ret, true,
> > +			       acquire_ctx)
> > +		if (ret)
> > +			goto error;
> 
> which then becomes:
> 
> struct ww_mutex *gem_ww_mutex_func(int i, void *data)
> {
> 	struct drm_gem_object **objs = data;
> 	return &objs[i]->resv->lock;
> }
> 
> 	ret = ww_mutex_lock_all(count, acquire_ctx, true, objs, gem_ww_mutex_func);
> 
> >  	ww_acquire_done(acquire_ctx);
> >  
> >  	return 0;
> > +
> > +error:
> > +	ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
> > +				 &objs[i]->resv->lock, contended);
> > +	ww_acquire_done(acquire_ctx);
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL(drm_gem_lock_reservations);

Another idea, entirely untested (I guess making sure that we can use the
same iterator for both locking and unlocking in the contended case will be
fun), but maybe something like this:

	WW_MUTEX_LOCK_BEGIN();
	driver_for_each_loop (iter, pos) {
		WW_MUTEX_LOCK(&pos->ww_mutex);
	}
	WW_MUTEX_LOCK_END();

That way we can reuse any and all iterators that'll ever show up at least.
It's still horrible because the macros need to jump around between all of
them. Would also make this useful for more cases, where maybe you need to
trylock some lru lock to get at your next ww_mutex, or do some
kref_get_unless_zero. Buffer eviction loops tend to acquire these, and
that would all get ugly real fast if we'd need to stuff it into some
iterator argument.

This is kinda what we went with for modeset locks with
DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in between the
pair at least. But it's a lot more limited use-cases, maybe too fragile an
idea for ww_mutex in full generality.

Not going to type this out because too much w/e mode here already, but I
can give it a stab next week.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
