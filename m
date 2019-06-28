Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBC5206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T5j70Eo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF1HvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:51:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40083 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1HvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:51:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so3610117oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtEeeslQGtSEA9L6niIK/BiiKT9ny7fWORJgUMeGMeM=;
        b=T5j70Eo4vp8nN+Svf88JQpEcxGjOkbz23tiEnT7qrDiszCiSqmelKH+f6fBQ/MAf9j
         gt56mV6PN6Bcg/epHs4JZymlfn8piiQStw/8xsAIP6Gi2J2KMkllwj78FWKCrfYgJzPA
         31XI50kNydlAEA0qL64xKa6CIRwQAAhvgLAJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtEeeslQGtSEA9L6niIK/BiiKT9ny7fWORJgUMeGMeM=;
        b=QBTTq9MNVbU05K9yrJmLzySorlzAZ/hnd2tLJ/aq5BtS1WONjbitynA8QVLbpbQ0Ok
         JyqqNFkHy85V1/pSxIV+eStfDgUxx7XpBA9lIu+LW9wXuIzN5SiikEUbon2CzACg/845
         qiMCwwohQA5++Mu52O9F/Hz7yuSDOo4IB4ehGxDbu5XfEKlEgkk01GPllL385b6nEPFX
         ZC3OehVVlPOUW9mRuGvsJCYpG8cqvVEUvGC6+kFQayEwFcJTamiNACx9l2NLU3CwnbqJ
         D346HFE9hr82IyaK+QZdnQiLXw5n/ZGhrY4kj6HSIXyJ408Yq5wHqqZXjXSatLryYjio
         +pNA==
X-Gm-Message-State: APjAAAXXi24b9NzcxQdb3UQYt3Z5JrraABRuSScoOassWq6yH1P7n2R8
        QuzPw4jQuve65K00YepcKsBZghyXKWjv4B/cf+31TA==
X-Google-Smtp-Source: APXvYqyk8bRZ5DrMcNPTQLIz0eecXfgskTMeKRlhIPO1v1UMKP/TvAGHP8JcOmbE44QLXsNbe1bQh8L6hk5XcGONS5o=
X-Received: by 2002:aca:5403:: with SMTP id i3mr910923oib.132.1561708261619;
 Fri, 28 Jun 2019 00:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190621115755.8481-1-kraxel@redhat.com> <20190621115755.8481-3-kraxel@redhat.com>
 <e3d8d1ee-c033-0402-6058-7c2410cc250b@suse.de>
In-Reply-To: <e3d8d1ee-c033-0402-6058-7c2410cc250b@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 28 Jun 2019 09:50:49 +0200
Message-ID: <CAKMK7uFwsQ4pVpAtsP4RBCY2RNkvcnc+QqTkEX5VT+pkJ-kLVA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] drm/vram: use embedded gem object
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 9:30 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 21.06.19 um 13:57 schrieb Gerd Hoffmann:
> > Drop drm_gem_object from drm_gem_vram_object, use the
> > ttm_buffer_object.base instead.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/drm/drm_gem_vram_helper.h           |  3 +--
> >  drivers/gpu/drm/ast/ast_main.c              |  2 +-
> >  drivers/gpu/drm/drm_gem_vram_helper.c       | 16 ++++++++--------
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |  2 +-
> >  drivers/gpu/drm/mgag200/mgag200_main.c      |  2 +-
> >  drivers/gpu/drm/vboxvideo/vbox_main.c       |  2 +-
> >  6 files changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> > index 9581ea0a4f7e..7b9f50ba3fce 100644
> > --- a/include/drm/drm_gem_vram_helper.h
> > +++ b/include/drm/drm_gem_vram_helper.h
> > @@ -36,7 +36,6 @@ struct vm_area_struct;
> >   * video memory becomes scarce.
> >   */
> >  struct drm_gem_vram_object {
> > -     struct drm_gem_object gem;
> >       struct ttm_buffer_object bo;
> >       struct ttm_bo_kmap_obj kmap;
> >
> > @@ -68,7 +67,7 @@ static inline struct drm_gem_vram_object *drm_gem_vram_of_bo(
> >  static inline struct drm_gem_vram_object *drm_gem_vram_of_gem(
> >       struct drm_gem_object *gem)
>
> To avoid ambiguities, I used the form <destination type name>_of_<field
> name>() to name these cast functions. The canonical name here would now
> be drm_gem_vram_of_bo_base(). But that's just nitpicking. If you don't
> want to change the name (and all its callers), maybe leave a FIXME comment.

Bikeshed: I think generally we call these
<source_type>_to_<destination_type>, with the source type left out if
you cast from the most generic version. E.g. this one here would just
be

static inline struct drm_gem_vram_object *drm_gem_to_vram_bo(struct
drm_gem_object *gem)

or something like that. I don't remember having seen the *_of_*
pattern anywhere.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
