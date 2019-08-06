Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B11C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C060721738
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O9b4Y0AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHFWqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:46:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38534 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:46:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so69070818oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt4aiSrkRERX1Bfp8k3z3Xn3AM67tm5WpoUKfvE2/lw=;
        b=O9b4Y0ALJLQfgNjuXwl/+eKwVHhroXtjWSmezluXfLLMNQgPp8TuqVh0vlpMLoyrrE
         /flMTEyZWMQJActUEFPwrTzmTj+dZNXTnabHvzKghqZFM4hLa2Lsib9oV2afBxCmnJ3d
         WtSZKeJhJ1YQiWQ2GhBmifWC90Bdabjk6RalM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt4aiSrkRERX1Bfp8k3z3Xn3AM67tm5WpoUKfvE2/lw=;
        b=uluVXexzMGvHBCLTtcqR3lyvEcskgXalEgsIASS0txRGAlW44Lgrci7CFlK7O49AwF
         mplJKnSZ2u6nIDxuS+gC9pN4K1noQ55Ud1KYuDwRuwo00o6vFsT5wlegjq9OJdRJ6aRR
         4qmVeV9nxj0zl3UzvS+y2iHBVVlsHQbEfBpN3dlhQBwUbmLevZCYagKkS3QTIRKaSaXK
         bUksDuSCsYY7ixSuLG4Y0Lr1l2qF0bSxz9hffPcjBOuRIRTcYPfaOqcSoQSChs4zaeeT
         H/AqRVnL03OprxqV2yoF9QDeH9xLuLdQ0Y246Q0l30LbYf/E7thCNMYlg3Craowi6Z45
         e6TQ==
X-Gm-Message-State: APjAAAVdZm3IvabxF3/mUEg/Sp7O7ywkKfSKtnOPcVk8YUM34jbjWnJJ
        exJeHb+7ReH5WNI5pkH7sFLxxm61gfg53uGeBUJeQQ==
X-Google-Smtp-Source: APXvYqxLlSOHTSyILonwS6wVkz5p/KQXRjYB80bDESDnW0Pe43KmYkFcn08gNzz1iuCYMODwuRL6JnBVVREOF+NHWXY=
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr6640136jap.103.1565131559097;
 Tue, 06 Aug 2019 15:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190806213319.19203-1-sashal@kernel.org> <20190806213319.19203-37-sashal@kernel.org>
In-Reply-To: <20190806213319.19203-37-sashal@kernel.org>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 6 Aug 2019 15:45:48 -0700
Message-ID: <CAJs_Fx5rj45yJ5kh5vLHRMWLYi=qmnMJ919LKdX8icTnvLwgoA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.2 37/59] drm/vgem: fix cache synchronization on arm/arm64
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please don't queue this one for stable branches.. it was causing
problems in intel CI

BR,
-R

On Tue, Aug 6, 2019 at 2:34 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> [ Upstream commit 7e9e5ead55beacc11116b3fb90b0de6e7cf55a69 ]
>
> drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
> dma_sync API.
>
> Fixes failures w/ vgem_test.
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20190717211542.30482-1-robdclark@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 130 ++++++++++++++++++++------------
>  1 file changed, 83 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 11a8f99ba18c5..fc04803ff4035 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -47,10 +47,16 @@ static struct vgem_device {
>         struct platform_device *platform;
>  } *vgem_device;
>
> +static void sync_and_unpin(struct drm_vgem_gem_object *bo);
> +static struct page **pin_and_sync(struct drm_vgem_gem_object *bo);
> +
>  static void vgem_gem_free_object(struct drm_gem_object *obj)
>  {
>         struct drm_vgem_gem_object *vgem_obj = to_vgem_bo(obj);
>
> +       if (!obj->import_attach)
> +               sync_and_unpin(vgem_obj);
> +
>         kvfree(vgem_obj->pages);
>         mutex_destroy(&vgem_obj->pages_lock);
>
> @@ -78,40 +84,15 @@ static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>                 return VM_FAULT_SIGBUS;
>
>         mutex_lock(&obj->pages_lock);
> +       if (!obj->pages)
> +               pin_and_sync(obj);
>         if (obj->pages) {
>                 get_page(obj->pages[page_offset]);
>                 vmf->page = obj->pages[page_offset];
>                 ret = 0;
>         }
>         mutex_unlock(&obj->pages_lock);
> -       if (ret) {
> -               struct page *page;
> -
> -               page = shmem_read_mapping_page(
> -                                       file_inode(obj->base.filp)->i_mapping,
> -                                       page_offset);
> -               if (!IS_ERR(page)) {
> -                       vmf->page = page;
> -                       ret = 0;
> -               } else switch (PTR_ERR(page)) {
> -                       case -ENOSPC:
> -                       case -ENOMEM:
> -                               ret = VM_FAULT_OOM;
> -                               break;
> -                       case -EBUSY:
> -                               ret = VM_FAULT_RETRY;
> -                               break;
> -                       case -EFAULT:
> -                       case -EINVAL:
> -                               ret = VM_FAULT_SIGBUS;
> -                               break;
> -                       default:
> -                               WARN_ON(PTR_ERR(page));
> -                               ret = VM_FAULT_SIGBUS;
> -                               break;
> -               }
>
> -       }
>         return ret;
>  }
>
> @@ -277,32 +258,93 @@ static const struct file_operations vgem_driver_fops = {
>         .release        = drm_release,
>  };
>
> -static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
> +/* Called under pages_lock, except in free path (where it can't race): */
> +static void sync_and_unpin(struct drm_vgem_gem_object *bo)
>  {
> -       mutex_lock(&bo->pages_lock);
> -       if (bo->pages_pin_count++ == 0) {
> -               struct page **pages;
> +       struct drm_device *dev = bo->base.dev;
> +
> +       if (bo->table) {
> +               dma_sync_sg_for_cpu(dev->dev, bo->table->sgl,
> +                               bo->table->nents, DMA_BIDIRECTIONAL);
> +               sg_free_table(bo->table);
> +               kfree(bo->table);
> +               bo->table = NULL;
> +       }
> +
> +       if (bo->pages) {
> +               drm_gem_put_pages(&bo->base, bo->pages, true, true);
> +               bo->pages = NULL;
> +       }
> +}
> +
> +static struct page **pin_and_sync(struct drm_vgem_gem_object *bo)
> +{
> +       struct drm_device *dev = bo->base.dev;
> +       int npages = bo->base.size >> PAGE_SHIFT;
> +       struct page **pages;
> +       struct sg_table *sgt;
> +
> +       WARN_ON(!mutex_is_locked(&bo->pages_lock));
> +
> +       pages = drm_gem_get_pages(&bo->base);
> +       if (IS_ERR(pages)) {
> +               bo->pages_pin_count--;
> +               mutex_unlock(&bo->pages_lock);
> +               return pages;
> +       }
>
> -               pages = drm_gem_get_pages(&bo->base);
> -               if (IS_ERR(pages)) {
> -                       bo->pages_pin_count--;
> -                       mutex_unlock(&bo->pages_lock);
> -                       return pages;
> -               }
> +       sgt = drm_prime_pages_to_sg(pages, npages);
> +       if (IS_ERR(sgt)) {
> +               dev_err(dev->dev,
> +                       "failed to allocate sgt: %ld\n",
> +                       PTR_ERR(bo->table));
> +               drm_gem_put_pages(&bo->base, pages, false, false);
> +               mutex_unlock(&bo->pages_lock);
> +               return ERR_CAST(bo->table);
> +       }
> +
> +       /*
> +        * Flush the object from the CPU cache so that importers
> +        * can rely on coherent indirect access via the exported
> +        * dma-address.
> +        */
> +       dma_sync_sg_for_device(dev->dev, sgt->sgl,
> +                       sgt->nents, DMA_BIDIRECTIONAL);
> +
> +       bo->pages = pages;
> +       bo->table = sgt;
> +
> +       return pages;
> +}
> +
> +static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
> +{
> +       struct page **pages;
>
> -               bo->pages = pages;
> +       mutex_lock(&bo->pages_lock);
> +       if (bo->pages_pin_count++ == 0 && !bo->pages) {
> +               pages = pin_and_sync(bo);
> +       } else {
> +               WARN_ON(!bo->pages);
> +               pages = bo->pages;
>         }
>         mutex_unlock(&bo->pages_lock);
>
> -       return bo->pages;
> +       return pages;
>  }
>
>  static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
>  {
> +       /*
> +        * We shouldn't hit this for imported bo's.. in the import
> +        * case we don't own the scatter-table
> +        */
> +       WARN_ON(bo->base.import_attach);
> +
>         mutex_lock(&bo->pages_lock);
>         if (--bo->pages_pin_count == 0) {
> -               drm_gem_put_pages(&bo->base, bo->pages, true, true);
> -               bo->pages = NULL;
> +               WARN_ON(!bo->table);
> +               sync_and_unpin(bo);
>         }
>         mutex_unlock(&bo->pages_lock);
>  }
> @@ -310,18 +352,12 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
>  static int vgem_prime_pin(struct drm_gem_object *obj)
>  {
>         struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
> -       long n_pages = obj->size >> PAGE_SHIFT;
>         struct page **pages;
>
>         pages = vgem_pin_pages(bo);
>         if (IS_ERR(pages))
>                 return PTR_ERR(pages);
>
> -       /* Flush the object from the CPU cache so that importers can rely
> -        * on coherent indirect access via the exported dma-address.
> -        */
> -       drm_clflush_pages(pages, n_pages);
> -
>         return 0;
>  }
>
> --
> 2.20.1
>
