Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B1720828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mab1bpzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfDANHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:07:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33185 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDANHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:07:01 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so17382222itf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7nfqyavCOHYwP5bfIj4Lx+eog2sSv/F9dC/tuo3Ysg=;
        b=Mab1bpzCeid3WPDcMGc85Hx6aSDmDJ2oRWM5Vn2469/ub/av3WIdBLimt38Jh02V6h
         d5rLAwo+a+rojnLXmCp0JF4QCabTHbMq3tygfsQih4PbCLlL6kdyw5fifuNo6M6gRPg6
         NBpGHwite2rVfW6KQTjRRpJqPW1w97p676KEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7nfqyavCOHYwP5bfIj4Lx+eog2sSv/F9dC/tuo3Ysg=;
        b=Nr4Rz8brbmg/5bHnXkkz2HwNahgQX7gX4R99hfFIZyeI6t60oKTrHROiVFPe0jjHzg
         OAMYn7jSPbruV39GbQMBQIUbJkDZtfHs13jUu7hebNOxVMI2TpezIQGTiTL7MYMMMG33
         AVLLU+T+hqisuL9ASU4hbs3yksV++gnJMpcvnqSmVPngyeKfRUru9CBoRhpVUEw12dRx
         Yx7L37UAa2Us0iIpnN+PZvEfsMU20Fs28TpDDGsM8h7mf/+J+AhV9cbg6QnI35b6eg5s
         PwE+Ly0LvQiFoYP1e1xSeOpy+/9V4RbsLNXib0WGtcXRWX5NHgWh9S3KMHmel9toe6kU
         XaSA==
X-Gm-Message-State: APjAAAU9P65416016bOLIQGOM6zIIxcmDxetTHWquH0H6yRJQf9o5ZMh
        4ipHi0HVAgTGbjqaSH4Ce+oNc6r1q3iRDkKwfC2C8g==
X-Google-Smtp-Source: APXvYqzf03iLejtUCyRwLnD5MaQSvDlC1WnH6z1op2bRWKXEAF8SP0OcHnpYhSZE9YkUYq1GND9jAb7/HJabzxlglPw=
X-Received: by 2002:a24:3dc7:: with SMTP id n190mr15546962itn.62.1554124019944;
 Mon, 01 Apr 2019 06:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org>
In-Reply-To: <20190401074730.12241-3-robh@kernel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 1 Apr 2019 15:06:48 +0200
Message-ID: <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>
> Similar to the single handle drm_gem_object_lookup(),
> drm_gem_objects_lookup() takes an array of handles and returns an array
> of GEM objects.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
>  include/drm/drm_gem.h     |  2 ++
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 388b3742e562..5c9bff45e5e1 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>  }
>  EXPORT_SYMBOL(drm_gem_put_pages);
>
> +/**
> + * drm_gem_objects_lookup - look up GEM objects from an array of handles
> + * @filp: DRM file private date
> + * @handle: pointer to array of userspace handle
> + * @count: size of handle array
> + * @objs: pointer to array of drm_gem_object pointers
> + *
> + * Returns:
> + *
> + * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
> + * failure. 0 is returned on success.

Bonus points for adding references between the array and normal lookup
functions to guide people around. Also a comment that the buffers need
to be released with drm_gem_object_put().

> + */
> +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
> +                          struct drm_gem_object **objs)

With a pointer to a pointer I'd expect this function to do the
allocation, but it doesn't. Normal pointer is enough to pass an array.
Also maybe make the handle pointer
const, so it's clear that it's an input parameter.

With the bikesheds addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +{
> +       int i, ret = 0;
> +       struct drm_gem_object *obj;
> +
> +       spin_lock(&filp->table_lock);
> +
> +       for (i = 0; i < count; i++) {
> +               /* Check if we currently have a reference on the object */
> +               obj = idr_find(&filp->object_idr, handle[i]);
> +               if (!obj) {
> +                       ret = -ENOENT;
> +                       break;
> +               }
> +               drm_gem_object_get(obj);
> +               objs[i] = obj;
> +       }
> +       spin_unlock(&filp->table_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(drm_gem_objects_lookup);
> +
>  /**
>   * drm_gem_object_lookup - look up a GEM object from its handle
>   * @filp: DRM file private date
> @@ -678,15 +714,7 @@ drm_gem_object_lookup(struct drm_file *filp, u32 handle)
>  {
>         struct drm_gem_object *obj;
>
> -       spin_lock(&filp->table_lock);
> -
> -       /* Check if we currently have a reference on the object */
> -       obj = idr_find(&filp->object_idr, handle);
> -       if (obj)
> -               drm_gem_object_get(obj);
> -
> -       spin_unlock(&filp->table_lock);
> -
> +       drm_gem_objects_lookup(filp, &handle, 1, &obj);
>         return obj;
>  }
>  EXPORT_SYMBOL(drm_gem_object_lookup);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 2955aaab3dca..5404225e0194 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
>  void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>                 bool dirty, bool accessed);
>
> +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
> +                          struct drm_gem_object **objs);
>  struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
>  long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
>                                     bool wait_all, unsigned long timeout);
> --
> 2.19.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
