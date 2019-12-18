Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D674821D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbRmJLXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLRWeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:34:46 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33881 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:34:46 -0500
Received: by mail-il1-f193.google.com with SMTP id s15so3133542iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oB3C/amjaPaUoFd3WkaUwk7Puy42NPe+srnuJ0tvf1c=;
        b=hbRmJLXew0YwGinXhZPGdP7G2Wo3vDuXm7EkUeYMjef16hIFBOPvla45pmB4Eups5P
         0Mo+F1RpvpiZv3geo5TxZVFxO7LD2JkKe9eAUh0SbN5YE3BItjALIyYbgxAanIF9geSc
         0z593n+diWeftkY2MuJoTfGlTH+tiDaHZ+yXgNCjki9NGOkR+jF1pk6+WshLm0M6WLX8
         +1mywMg9JSmK5HPq2dAoRBI8bN4r3IN6iP79XRkaP3QfTsOK2Pnc42YhkRJpq3iAw/zV
         dZ/IrNrh3M5KDoJsBSBCyHhlNRls2bCc53/rlCEYX+UUNQTWx7dD9uwvDtr9BzNWIrEQ
         VGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oB3C/amjaPaUoFd3WkaUwk7Puy42NPe+srnuJ0tvf1c=;
        b=MCociDy9HnrLlJ6CeWiZlZvPIP7go2AY5Ky4BEQWj98Ui8nRmPbGbfmeqiT+oKZVX/
         D64yLcRkFUlsNX8Vf7cTKsZ4FUEAAAFgqXY1uoVI4a76ZAS09DywhSUb0Oy9i5uQPNAD
         xEwk9d8Z6vSHwVtLlnCvFWtyUlcIc4W5k1H93WoNM45HQC12+d6C2nX/92agjbK7Lggx
         tnoCNJ0WE2utxwnKVIgI6Jwe+8R7OlUvI47NT96+OJzU/W2X1Hj84miDgXHGFO8V+J3N
         43b3ED3/BfuLhjn3N3oNL5Tp9Az8O9covxYsxvd5uBm+1gCqbCufRij1hsfCZae2c/Q4
         fxtA==
X-Gm-Message-State: APjAAAX5wu6lmOLNZnAlCPX5gWUDveXypp4hM+MR4R3oChM7FDlJ7S9/
        cYvrVHEt/IUjaYBVYsOfd2uwWYVt77MdhZIJNqE=
X-Google-Smtp-Source: APXvYqzbXsO71rLtp1FSjeCcYbAsLuT54QDwOPuwFtllLBf/IaluI6ARmSGaz1wD6bQn2OuLqLqlYLUprnz5H/5roJo=
X-Received: by 2002:a92:9e97:: with SMTP id s23mr4461314ilk.139.1576708485032;
 Wed, 18 Dec 2019 14:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20191218125645.9211-1-kraxel@redhat.com> <20191218125645.9211-4-kraxel@redhat.com>
In-Reply-To: <20191218125645.9211-4-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 18 Dec 2019 14:34:34 -0800
Message-ID: <CAPaKu7RyFjYCxuCVF7aBMfs4UdNwWahoh3Jg67sb2nOeyH+9Zg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/udl: simplify gem object mapping.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        tzimmermann@suse.de, Dave Airlie <airlied@redhat.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:56 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> With shmem helpers allowing to update pgprot caching flags via
> drm_gem_shmem_object.map_cached we can just use that and ditch
> our own implementations of mmap() and vmap().
>
> We also don't need a special case for imported objects, any map
> requests are handled by the exporter not udl.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/udl/udl_gem.c | 62 ++---------------------------------
>  1 file changed, 3 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
> index b6e26f98aa0a..7e3a88b25b6b 100644
> --- a/drivers/gpu/drm/udl/udl_gem.c
> +++ b/drivers/gpu/drm/udl/udl_gem.c
> @@ -17,72 +17,15 @@
>   * GEM object funcs
>   */
>
> -static int udl_gem_object_mmap(struct drm_gem_object *obj,
> -                              struct vm_area_struct *vma)
> -{
> -       int ret;
> -
> -       ret = drm_gem_shmem_mmap(obj, vma);
> -       if (ret)
> -               return ret;
> -
> -       vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -       if (obj->import_attach)
> -               vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> -       vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> -
> -       return 0;
> -}
> -
> -static void *udl_gem_object_vmap(struct drm_gem_object *obj)
> -{
> -       struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> -       int ret;
> -
> -       ret = mutex_lock_interruptible(&shmem->vmap_lock);
> -       if (ret)
> -               return ERR_PTR(ret);
> -
> -       if (shmem->vmap_use_count++ > 0)
> -               goto out;
> -
> -       ret = drm_gem_shmem_get_pages(shmem);
> -       if (ret)
> -               goto err_zero_use;
> -
> -       if (obj->import_attach)
> -               shmem->vaddr = dma_buf_vmap(obj->import_attach->dmabuf);
> -       else
> -               shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
> -                                   VM_MAP, PAGE_KERNEL);
> -
> -       if (!shmem->vaddr) {
> -               DRM_DEBUG_KMS("Failed to vmap pages\n");
> -               ret = -ENOMEM;
> -               goto err_put_pages;
> -       }
> -
> -out:
> -       mutex_unlock(&shmem->vmap_lock);
> -       return shmem->vaddr;
> -
> -err_put_pages:
> -       drm_gem_shmem_put_pages(shmem);
> -err_zero_use:
> -       shmem->vmap_use_count = 0;
> -       mutex_unlock(&shmem->vmap_lock);
> -       return ERR_PTR(ret);
> -}
> -
>  static const struct drm_gem_object_funcs udl_gem_object_funcs = {
>         .free = drm_gem_shmem_free_object,
>         .print_info = drm_gem_shmem_print_info,
>         .pin = drm_gem_shmem_pin,
>         .unpin = drm_gem_shmem_unpin,
>         .get_sg_table = drm_gem_shmem_get_sg_table,
> -       .vmap = udl_gem_object_vmap,
> +       .vmap = drm_gem_shmem_vmap,
>         .vunmap = drm_gem_shmem_vunmap,
> -       .mmap = udl_gem_object_mmap,
> +       .mmap = drm_gem_shmem_mmap,
>  };
It looks like we can just use the default ops (drm_gem_shmem_funcs).

With that, this series is

  Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.

>
>  /*
> @@ -101,6 +44,7 @@ struct drm_gem_object *udl_driver_gem_create_object(struct drm_device *dev,
>
>         obj = &shmem->base;
>         obj->funcs = &udl_gem_object_funcs;
> +       shmem->map_cached = true;
>
>         return obj;
>  }
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
