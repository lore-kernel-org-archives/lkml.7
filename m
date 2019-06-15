Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F9C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AC521473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eqKeNfV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfFON4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:56:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40296 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfFON4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:56:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so4336803otl.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QHCR3JSgS0RSHcF2VNdae/EolEZLrPS/qHWaU1BJy7I=;
        b=eqKeNfV0/DKNowmDgDytbRxKZe/YIBslrcI+/6UoW6VrIQ4IXERd15SuP4HEEcg941
         umwYW8yVMX0fH5rPsS/8iFnnYX4ETfea2MKPxtaeV5ezaDMj8CoGpnSE2rPwoSlgtmfb
         qGCQ6MDTBLprBStkIIHLT16NSSx+g4XaelLxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QHCR3JSgS0RSHcF2VNdae/EolEZLrPS/qHWaU1BJy7I=;
        b=IYd2AD6JKZrY+ZbHEMMFfzbG78fDcP18s9OQSQ+KlFCOOqZ/4ltZPQulNagXZ2iXlu
         vdJI4NhR5VXUGtNardXRqkgCTlJth6N+Fc2U90dbHmrpuOx7lZ8S3AJmoZcjbtX2Moo0
         BpcnregTNgFetWn6KgdDCRGGbR8mizLegxXjCbTvwYJ+O3rHNjaWcG1eDBBkZc8tZaUM
         ydFYZ42DZOtZIlyZbwYlPctc9GYgABajLkybwMNLzNJ4EM24IOotoAu7+Iczh3tKUoA1
         4wYkzekIYOdBMlEwZw6NIems/oiz/a0Qd+F8d9Yqlo3R18VWl+dW9rhNef5+5Rc3/gpt
         kIsw==
X-Gm-Message-State: APjAAAUW116yWy+r5rTM0PS1zz+PGI5yGOtrsykx89V9DtGisDS4Cjlo
        vVhg0vSG0pmrkJSMhmN4MwbzFPxu3e7zeFOUP9Giqg==
X-Google-Smtp-Source: APXvYqx/Ugw4ghpaI9BPclCunE9l+XqGUnnusYzQabQ3bRGiqNyMJGg8+HCBD7GFUGyd9Y8oSX+UvB7edg6+XiKE3Po=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr34286891oto.188.1560606998809;
 Sat, 15 Jun 2019 06:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com> <20190614131916.GQ3436@hirez.programming.kicks-ass.net>
 <20190614152242.GC23020@phenom.ffwll.local> <094da0f7-a0f0-9ed4-d2da-8c6e6d165380@gmail.com>
 <CAKMK7uFcDCJ9sozny1RqqRATwcK39doZNq+NZekvrzuO63ap-Q@mail.gmail.com>
 <d97212dc-367c-28e9-6961-9b99110a4d2e@gmail.com> <20190614203040.GE23020@phenom.ffwll.local>
In-Reply-To: <20190614203040.GE23020@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 15 Jun 2019 15:56:25 +0200
Message-ID: <CAKMK7uFzg+e315h2e5SmDTQwYTAbgAsxB_pc09ztwA1Wa-mzxw@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jun 14, 2019 at 08:51:11PM +0200, Christian K=C3=B6nig wrote:
> > Am 14.06.19 um 20:24 schrieb Daniel Vetter:
> > >
> > > On Fri, Jun 14, 2019 at 8:10 PM Christian K=C3=B6nig <ckoenig.leichtz=
umerken@gmail.com> wrote:
> > > > [SNIP]
> > > > WW_MUTEX_LOCK_BEGIN()
> > > >
> > > > lock(lru_lock);
> > > >
> > > > while (bo =3D list_first(lru)) {
> > > >   if (kref_get_unless_zero(bo)) {
> > > >           unlock(lru_lock);
> > > >           WW_MUTEX_LOCK(bo->ww_mutex);
> > > >           lock(lru_lock);
> > > >   } else {
> > > >           /* bo is getting freed, steal it from the freeing process
> > > >            * or just ignore */
> > > >   }
> > > > }
> > > > unlock(lru_lock)
> > > >
> > > > WW_MUTEX_LOCK_END;
> >
> > Ah, now I know what you mean. And NO, that approach doesn't work.
> >
> > See for the correct ww_mutex dance we need to use the iterator multiple
> > times.
> >
> > Once to give us the BOs which needs to be locked and another time to gi=
ve us
> > the BOs which needs to be unlocked in case of a contention.
> >
> > That won't work with the approach you suggest here.
>
> A right, drat.
>
> Maybe give up on the idea to make this work for ww_mutex in general, and
> just for drm_gem_buffer_object? I'm just about to send out a patch series
> which makes sure that a lot more drivers set gem_bo.resv correctly (it
> will alias with ttm_bo.resv for ttm drivers ofc). Then we could add a
> list_head to gem_bo (won't really matter, but not something we can do wit=
h
> ww_mutex really), so that the unlock walking doesn't need to reuse the
> same iterator. That should work I think ...
>
> Also, it would almost cover everything you want to do. For ttm we'd need
> to make ttm_bo a subclass of gem_bo (and maybe not initialize that
> embedded gem_bo for vmwgfx and shadow bo and driver internal stuff).
>
> Just some ideas, since copypasting the ww_mutex dance into all drivers is
> indeed not great.

Even better we don't need to force everyone to use drm_gem_object, the
hard work is already done with the reservation_object. We could add a
list_head there for unwinding, and then the locking helpers would look
a lot cleaner and simpler imo. reservation_unlock_all() would even be
a real function! And if we do this then I think we should also have a
reservation_acquire_ctx, to store the list_head and maybe anything
else.

Plus all the code you want to touch is dealing with
reservation_object, so that's all covered. And it mirros quite a bit
what we've done with struct drm_modeset_lock, to wrap ww_mutex is
something easier to deal with for kms.
-Daniel

> -Daniel
>
> >
> > Regards,
> > Christian.
> >
> > >
> > >
> > > Also I think if we allow this we could perhaps use this to implement =
the
> > > modeset macros too.
> > > -Daniel
> > >
> > >
> > >
> > >
> > > > > This is kinda what we went with for modeset locks with
> > > > > DRM_MODESET_LOCK_ALL_BEGIN/END, you can grab more locks in betwee=
n the
> > > > > pair at least. But it's a lot more limited use-cases, maybe too f=
ragile an
> > > > > idea for ww_mutex in full generality.
> > > > >
> > > > > Not going to type this out because too much w/e mode here already=
, but I
> > > > > can give it a stab next week.
> > > > > -Daniel
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > >
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
