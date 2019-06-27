Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2D4C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB667208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fHtdK+0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF0Vfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:35:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41633 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Vfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:35:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so8503350eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z97Q4/dPPEZVULQCHeK9Jwk8nEp0usx/tIRiKgg3S/o=;
        b=fHtdK+0Iz5BpxJTNhE0M6EeK8ymj5N+P4i2+okX37sxS/JuGr3t1WawA7o74mrLsaO
         0HtUGIJnR3GNf+OYA0GVQyPcyPbNBPq7vWJX71IEaBigp2VA7eWMsiAq9JK7eZVffPRE
         Hg3dz7Cs/L7TKp6bHuiovXEs+WNSkiWnGJJ2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=z97Q4/dPPEZVULQCHeK9Jwk8nEp0usx/tIRiKgg3S/o=;
        b=Q1NLwc1zEtNu3IeXHmlQxbTOMSiZqdiT5EGBzfO8u5CbIWex9ySfq6/MOI5YkT/ss+
         mE3V70vBPsBqxPPyTowZqEX4ZQ5dEKEOOcnqTyJBUyaI+3Q46g//o/6EnASOCEwMD2dA
         3XxG91rnjBV/Jjdg66m0IvqUyzEpuq5bsJLru4WRxKaUUqFAfkYalTfte5p5WdzwdJs3
         ncpGirh2vgkDm8qmGZnkF8A6D5xpmBvOnchr/tfAmkeWvvZzZ8vnM6hmHDyyvIVo6ijG
         ELpZeVDXel5uF05lVnOfbH3lBqPCyuyf2vXaEHqi1J9VQH1hiNnLOCTNH/aAFca+p5wQ
         kDyw==
X-Gm-Message-State: APjAAAXqzGwL4/coCLHBQ6VB9DIZEXxwNZnGs/YaevHn3EYbwk/FFL/m
        qNWV3LmzfRGG+YhG1KgBxdoftQ==
X-Google-Smtp-Source: APXvYqxUl2o9fIUhCbc0U24E3jiq6RImW+9Bw0yC9BiTGXIfS3t2VkxKjlHXyVAo6I7HdYeYTsNPFg==
X-Received: by 2002:a17:906:944f:: with SMTP id z15mr5371429ejx.137.1561671330715;
        Thu, 27 Jun 2019 14:35:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z9sm44187edd.53.2019.06.27.14.35.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:35:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:35:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] drm/gem: Rename drm_gem_dumb_map_offset() to
 drm_gem_map_offset()
Message-ID: <20190627213527.GQ12905@phenom.ffwll.local>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190627155318.38053-1-steven.price@arm.com>
 <20190627155318.38053-2-steven.price@arm.com>
 <CAL_JsqJ5ebyrvapvOSvg1ejgkbqEZyYh2AWAbO0UE=DssKtW1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ5ebyrvapvOSvg1ejgkbqEZyYh2AWAbO0UE=DssKtW1Q@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:57:34AM -0600, Rob Herring wrote:
> On Thu, Jun 27, 2019 at 9:53 AM Steven Price <steven.price@arm.com> wrote:
> >
> > drm_gem_dumb_map_offset() is a useful helper for non-dumb clients, so
> > rename it to remove the _dumb and add a comment that it can be used by
> > shmem clients.
> >
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> >  drivers/gpu/drm/drm_dumb_buffers.c      | 4 ++--
> >  drivers/gpu/drm/drm_gem.c               | 9 ++++++---
> >  drivers/gpu/drm/exynos/exynos_drm_gem.c | 3 +--
> >  include/drm/drm_gem.h                   | 4 ++--
> >  4 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> > index d18a740fe0f1..b55cfc9e8772 100644
> > --- a/drivers/gpu/drm/drm_dumb_buffers.c
> > +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> > @@ -48,7 +48,7 @@
> >   * To support dumb objects drivers must implement the &drm_driver.dumb_create
> >   * operation. &drm_driver.dumb_destroy defaults to drm_gem_dumb_destroy() if
> >   * not set and &drm_driver.dumb_map_offset defaults to
> > - * drm_gem_dumb_map_offset(). See the callbacks for further details.
> > + * drm_gem_map_offset(). See the callbacks for further details.
> >   *
> >   * Note that dumb objects may not be used for gpu acceleration, as has been
> >   * attempted on some ARM embedded platforms. Such drivers really must have
> > @@ -127,7 +127,7 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
> >                                                     args->handle,
> >                                                     &args->offset);
> >         else
> > -               return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> > +               return drm_gem_map_offset(file_priv, dev, args->handle,
> >                                                &args->offset);
> >  }
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index a8c4468f03d9..62842b7701bb 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -298,7 +298,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
> >  EXPORT_SYMBOL(drm_gem_handle_delete);
> >
> >  /**
> > - * drm_gem_dumb_map_offset - return the fake mmap offset for a gem object
> > + * drm_gem_map_offset - return the fake mmap offset for a gem object
> >   * @file: drm file-private structure containing the gem object
> >   * @dev: corresponding drm_device
> >   * @handle: gem object handle
> > @@ -307,10 +307,13 @@ EXPORT_SYMBOL(drm_gem_handle_delete);
> >   * This implements the &drm_driver.dumb_map_offset kms driver callback for
> >   * drivers which use gem to manage their backing storage.
> >   *
> > + * It can also be used by drivers using the shmem backend as they have the
> > + * same restriction that imported objects cannot be mapped.
> 
> Maybe better not to say 'shmem' explicitly or just mention it as an
> example so when we have a 2nd case we don't have to update the
> comment.
> 
> ...drivers with GEM BO implementations which have the same...
> 
> I can fix up and apply. Some other acks would be nice first.

Yeah kerneldoc is a bit suboptimal, with that polished, a-b: me. Yours
should be good enough though.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
