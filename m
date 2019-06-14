Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63502177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bVmkBS2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFNSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:24:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46016 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFNSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:24:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so4720430edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bik4fyHxboBXR92RW9HCfZ7+c9s6bxmlh2Q2rMmWiHw=;
        b=bVmkBS2jisCkHksnNDuo09tYLsagcC/ctzMSXA3UCuSrjIuhuBBItZI7cWiacVOuJS
         HMeDeOXj2H3fMcK1H50lBYTCXtZsqQ3PlTOz++l6OFe81ryzf6Cy9Za3bAlkclBr7gMr
         cC2GVq5e0kEpm/pDsmZFay84KlJES3Im2Ise4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bik4fyHxboBXR92RW9HCfZ7+c9s6bxmlh2Q2rMmWiHw=;
        b=eEFgnC61hv9fspnB+wYIA/iWLLi2iOBCGoCIokSHdLtkEgDnNgcJqLYSk+MCeh3gX4
         4mO4LSHD6pP6d+MYnVdSDT9XInBsjtkQbOu+ReggJ1x8SN6zPXZT9mUJA9mmmZds1gT7
         Hh/ssCYOtPS3sZ4R2wSBC4d+it7vhTAOrHrIqva+n1QHqoy22zxptagSWVzyd0hTc+F7
         5JHI4MhawQOdz1NkwLKRNK5/etzXfvLSiRq6q7Fu2B1fQDEArKG+6D6jEpAwjALFQfrZ
         RCM8016sDjqRw7bohWJ+U4A1LoX53gRjIPvc+iHGOYs4gFIABzVtzVxJywwgRPan/Erw
         2EfA==
X-Gm-Message-State: APjAAAWpqOdpLs6oT27z39zG5OZeElpaMElGA3+iAkWliyE6DAjPyc7e
        e88fJ3pheG0/Jjz1Z0q3PzX5iQ==
X-Google-Smtp-Source: APXvYqxu2G4yQDUtjpvg6r9kNR1LFXoiZ6I4EhpXDYO3aBnyr6O8u5qqbMKQ2cU2Lyap9yA9fp+YKw==
X-Received: by 2002:a17:907:20db:: with SMTP id qq27mr63221217ejb.30.1560536670462;
        Fri, 14 Jun 2019 11:24:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d5sm717021ejk.71.2019.06.14.11.24.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 11:24:29 -0700 (PDT)
Date:   Fri, 14 Jun 2019 20:24:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, "Anholt, Eric" <eric@anholt.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        lima@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Message-ID: <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, "Anholt, Eric" <eric@anholt.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local>
 <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jun 14, 2019 at 8:10 PM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.06.19 um 17:22 schrieb Daniel Vetter:
> > On Fri, Jun 14, 2019 at 03:19:16PM +0200, Peter Zijlstra wrote:
> >> On Fri, Jun 14, 2019 at 02:41:22PM +0200, Christian König wrote:
> >>> Use the provided macros instead of implementing deadlock handling on our own.
> >>>
> >>> Signed-off-by: Christian König <christian.koenig@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
> >>>   1 file changed, 12 insertions(+), 37 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> >>> index 50de138c89e0..6e4623d3bee2 100644
> >>> --- a/drivers/gpu/drm/drm_gem.c
> >>> +++ b/drivers/gpu/drm/drm_gem.c
> >>> @@ -1307,51 +1307,26 @@ int
> >>>   drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
> >>>                       struct ww_acquire_ctx *acquire_ctx)
> >>>   {
> >>> -   int contended = -1;
> >>> +   struct ww_mutex *contended;
> >>>     int i, ret;
> >>>  
> >>>     ww_acquire_init(acquire_ctx, &reservation_ww_class);
> >>>  
> >>> -retry:
> >>> -   if (contended != -1) {
> >>> -           struct drm_gem_object *obj = objs[contended];
> >>> -
> >>> -           ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
> >>> -                                                  acquire_ctx);
> >>> -           if (ret) {
> >>> -                   ww_acquire_done(acquire_ctx);
> >>> -                   return ret;
> >>> -           }
> >>> -   }
> >>> -
> >>> -   for (i = 0; i < count; i++) {
> >>> -           if (i == contended)
> >>> -                   continue;
> >>> -
> >>> -           ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
> >>> -                                             acquire_ctx);
> >>> -           if (ret) {
> >>> -                   int j;
> >>> -
> >>> -                   for (j = 0; j < i; j++)
> >>> -                           ww_mutex_unlock(&objs[j]->resv->lock);
> >>> -
> >>> -                   if (contended != -1 && contended >= i)
> >>> -                           ww_mutex_unlock(&objs[contended]->resv->lock);
> >>> -
> >>> -                   if (ret == -EDEADLK) {
> >>> -                           contended = i;
> >>> -                           goto retry;
> >>> -                   }
> >>> -
> >>> -                   ww_acquire_done(acquire_ctx);
> >>> -                   return ret;
> >>> -           }
> >>> -   }
> >> I note all the sites you use this on are simple idx iterators; so how
> >> about something like so:
> >>
> >> int ww_mutex_unlock_all(int count, void *data, struct ww_mutex *(*func)(int, void *))
> >> {
> >>      int i;
> >>
> >>      for (i = 0; i < count; i++) {
> >>              lock = func(i, data);
> >>              ww_mutex_unlock(lock);
> >>      }
> >> }
> >>
> >> int ww_mutex_lock_all(int count, struct ww_acquire_context *acquire_ctx, bool intr,
> >>                    void *data, struct ww_mutex *(*func)(int, void *))
> >> {
> >>      int i, ret, contended = -1;
> >>      struct ww_mutex *lock;
> >>
> >> retry:
> >>      if (contended != -1) {
> >>              lock = func(contended, data);
> >>              if (intr)
> >>                      ret = ww_mutex_lock_slow_interruptible(lock, acquire_ctx);
> >>              else
> >>                      ret = ww_mutex_lock_slow(lock, acquire_ctx), 0;
> >>
> >>              if (ret) {
> >>                      ww_acquire_done(acquire_ctx);
> >>                      return ret;
> >>              }
> >>      }
> >>
> >>      for (i = 0; i < count; i++) {
> >>              if (i == contended)
> >>                      continue;
> >>
> >>              lock = func(i, data);
> >>              if (intr)
> >>                      ret = ww_mutex_lock_interruptible(lock, acquire_ctx);
> >>              else
> >>                      ret = ww_mutex_lock(lock, acquire_ctx), 0;
> >>
> >>              if (ret) {
> >>                      ww_mutex_unlock_all(i, data, func);
> >>                      if (contended > i) {
> >>                              lock = func(contended, data);
> >>                              ww_mutex_unlock(lock);
> >>                      }
> >>
> >>                      if (ret == -EDEADLK) {
> >>                              contended = i;
> >>                              goto retry;
> >>                      }
> >>
> >>                      ww_acquire_done(acquire_ctx);
> >>                      return ret;
> >>              }
> >>      }
> >>
> >>      ww_acquire_done(acquire_ctx);
> >>      return 0;
> >> }
> >>
> >>> +   ww_mutex_lock_for_each(for (i = 0; i < count; i++),
> >>> +                          &objs[i]->resv->lock, contended, ret, true,
> >>> +                          acquire_ctx)
> >>> +           if (ret)
> >>> +                   goto error;
> >> which then becomes:
> >>
> >> struct ww_mutex *gem_ww_mutex_func(int i, void *data)
> >> {
> >>      struct drm_gem_object **objs = data;
> >>      return &objs[i]->resv->lock;
> >> }
> >>
> >>      ret = ww_mutex_lock_all(count, acquire_ctx, true, objs, gem_ww_mutex_func);
> >>
> >>>     ww_acquire_done(acquire_ctx);
> >>>  
> >>>     return 0;
> >>> +
> >>> +error:
> >>> +   ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
> >>> +                            &objs[i]->resv->lock, contended);
> >>> +   ww_acquire_done(acquire_ctx);
> >>> +   return ret;
> >>>   }
> >>>   EXPORT_SYMBOL(drm_gem_lock_reservations);
> > Another idea, entirely untested (I guess making sure that we can use the
> > same iterator for both locking and unlocking in the contended case will be
> > fun), but maybe something like this:
> >
> >       WW_MUTEX_LOCK_BEGIN();
> >       driver_for_each_loop (iter, pos) {
> >               WW_MUTEX_LOCK(&pos->ww_mutex);
> >       }
> >       WW_MUTEX_LOCK_END();
> >
> > That way we can reuse any and all iterators that'll ever show up at least.
> > It's still horrible because the macros need to jump around between all of
> > them.
>
> Yeah, I tried this as well and that's exactly the reason why I discarded
> this approach.
>
> There is this hack with goto *void we could use, but I'm pretty sure
> that is actually not part of any C standard.

Nah, just invisible jump labels + the all uppercase macro names to scream
that into your face. You essentially trade one set of horrors for another,
and this one allows you to open-code any kind of loop or other algorithim
to find all the ww_mutexes you need.

> > Would also make this useful for more cases, where maybe you need to
> > trylock some lru lock to get at your next ww_mutex, or do some
> > kref_get_unless_zero. Buffer eviction loops tend to acquire these, and
> > that would all get ugly real fast if we'd need to stuff it into some
> > iterator argument.
>
> Well I don't see a use case with eviction in general. The dance there
> requires something different as far as I can see.

Current ttm doesn't really bother with multi-threaded contention for all
of memory. You're fixing that, but I think in the end we need a
slow-reclaim which eats up the entire lru using the full ww_mutex dance.
Rougly

WW_MUTEX_LOCK_BEGIN()

lock(lru_lock);

while (bo = list_first(lru)) {
	if (kref_get_unless_zero(bo)) {
		unlock(lru_lock);
		WW_MUTEX_LOCK(bo->ww_mutex);
		lock(lru_lock);
	} else {
		/* bo is getting freed, steal it from the freeing process
		 * or just ignore */
	}
}
unlock(lru_lock)

WW_MUTEX_LOCK_END;


Also I think if we allow this we could perhaps use this to implement the
modeset macros too.
-Daniel




> > This is kinda what we went with for modeset locks with
> > DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in between the
> > pair at least. But it's a lot more limited use-cases, maybe too fragile an
> > idea for ww_mutex in full generality.
> >
> > Not going to type this out because too much w/e mode here already, but I
> > can give it a stab next week.
> > -Daniel
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
