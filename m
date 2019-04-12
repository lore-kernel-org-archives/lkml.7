Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04CBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A103E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDLOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:52:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51632 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:52:28 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so1397972itk.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKKTWdo63weVkoc/E3/wKZUmkzk9PduzeoVonxM7Nno=;
        b=JRPVL+KLCtMTMEl7aQNUyZnZ4pXOYNW8hzQlUoEBAcGGXn7V7jO6c3M5bgqLCBDQfu
         yOlqfp8xyU808ro8PfcJH4XX5bDE7iH5C4BMWnqhqflRg2fGZhJieTGxygO1XtzO5h54
         NwdSDC0M/Ga2P4sa4pkEKrmZdYLf1UO1kLe2thLtrqJRjme92AwDpR1h7zdn+nri5woi
         onWzyMZB9s2ujF01e+q6yDwVX4fLbgxmUX3N3AYzeIbbsLEnpBPkRmDxPbCSNmLXb9+n
         ZaFwTPBzvfsvKRZA8OKPaK622QnlcJYijwCYHvgOZrB5tXJLF1Rpfha6GNclUOc9+S92
         7q8w==
X-Gm-Message-State: APjAAAWKMz43PLavDd0odElCL8kv0/vqM6URTKE1VnrZZJTdsX3nc/pX
        kqjgr/iIJMkflJsQ2vm1XFSNVsPzQPVZtbGm//I=
X-Google-Smtp-Source: APXvYqzE6tLPgrUxXWvkMcxgSqKLKmRCw2jXk6p6G7JV8stlruNsGgasfO7PeI8Eg1AkH1gG6g5gFfrkxOsUcUQr7Do=
X-Received: by 2002:a24:6583:: with SMTP id u125mr11854013itb.151.1555080746701;
 Fri, 12 Apr 2019 07:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190409205427.6943-1-robh@kernel.org> <20190409205427.6943-3-robh@kernel.org>
In-Reply-To: <20190409205427.6943-3-robh@kernel.org>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Fri, 12 Apr 2019 16:52:15 +0200
Message-ID: <CAAObsKA_5URjKzi--uQu=AV=DZtJOuVjX2cbga+syHQUnsjsjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm: Add a drm_gem_objects_lookup helper
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Tue, 9 Apr 2019 at 22:54, Rob Herring <robh@kernel.org> wrote:
>
> Similar to the single handle drm_gem_object_lookup(),
> drm_gem_objects_lookup() takes an array of handles and returns an array
> of GEM objects.
>
> v2:
> - Take the userspace pointer directly and allocate the array.
> - Expand the function documentation.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/drm_gem.c | 93 ++++++++++++++++++++++++++++++++++-----
>  include/drm/drm_gem.h     |  2 +
>  2 files changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 388b3742e562..faa2718e85e8 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -663,6 +663,85 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>  }
>  EXPORT_SYMBOL(drm_gem_put_pages);
>
> +static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
> +                         struct drm_gem_object **objs)
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
> +
> +/**
> + * drm_gem_objects_lookup - look up GEM objects from an array of handles
> + * @filp: DRM file private date
> + * @bo_handles: user pointer to array of userspace handle
> + * @count: size of handle array
> + * @objs_out: returned pointer to array of drm_gem_object pointers
> + *
> + * Takes an array of userspace handles and returns a newly allocated array of
> + * GEM objects.
> + *
> + * For a single handle lookup, use drm_gem_object_lookup().
> + *
> + * Returns:
> + *
> + * @objs filled in with GEM object pointers. Returned GEM objects need to be
> + * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> + * failure. 0 is returned on success.
> + *
> + */
> +int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> +                          int count, struct drm_gem_object ***objs_out)
> +{
> +       int ret;
> +       u32 *handles;
> +       struct drm_gem_object **objs;
> +
> +       if (!count)
> +               return 0;
> +
> +       objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
> +                            GFP_KERNEL | __GFP_ZERO);
> +       if (!objs)
> +               return -ENOMEM;
> +
> +       handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
> +       if (!handles) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
> +               ret = -EFAULT;
> +               DRM_DEBUG("Failed to copy in GEM handles\n");
> +               goto out;
> +       }
> +
> +       ret = objects_lookup(filp, handles, count, objs);
> +       *objs_out = objs;
> +
> +out:
> +       kvfree(handles);
> +       return ret;
> +
> +}
> +EXPORT_SYMBOL(drm_gem_objects_lookup);
> +
>  /**
>   * drm_gem_object_lookup - look up a GEM object from its handle
>   * @filp: DRM file private date
> @@ -672,21 +751,15 @@ EXPORT_SYMBOL(drm_gem_put_pages);
>   *
>   * A reference to the object named by the handle if such exists on @filp, NULL
>   * otherwise.
> + *
> + * If looking up an array of handles, use drm_gem_objects_lookup().
>   */
>  struct drm_gem_object *
>  drm_gem_object_lookup(struct drm_file *filp, u32 handle)
>  {
> -       struct drm_gem_object *obj;
> -
> -       spin_lock(&filp->table_lock);
> -
> -       /* Check if we currently have a reference on the object */
> -       obj = idr_find(&filp->object_idr, handle);
> -       if (obj)
> -               drm_gem_object_get(obj);
> -
> -       spin_unlock(&filp->table_lock);
> +       struct drm_gem_object *obj = NULL;
>
> +       objects_lookup(filp, &handle, 1, &obj);
>         return obj;
>  }
>  EXPORT_SYMBOL(drm_gem_object_lookup);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 2955aaab3dca..5ee85c9eaa9d 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
>  void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>                 bool dirty, bool accessed);
>
> +int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> +                          int count, struct drm_gem_object ***objs_out);
>  struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
>  long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
>                                     bool wait_all, unsigned long timeout);
> --
> 2.19.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
