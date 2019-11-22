Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58988C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5B820674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PuTHrRo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVJRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:17:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36641 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKVJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:17:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so5605979oto.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzjjzH4UgTeG40VA2UV6AHDBfr0Ocw4jXqlZWXYFvJ8=;
        b=PuTHrRo6gLJNu4P4PUUZivkRf9R8+X7UdnrZdLbDNmrrt/TpJ5FOmxGiHBbktnLk7p
         0L/NwFPVLdJbjnvUE+rXbTFVQk2JD4/qkscDImWPNAQqc2A2LZeJ94l8S2wH6NIG/TjM
         Lguv1/sk/Rm80MHeMl/ogckNAQlZmDWVrIRac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzjjzH4UgTeG40VA2UV6AHDBfr0Ocw4jXqlZWXYFvJ8=;
        b=TB/VgF7nKWN6SippWRWQJA5SaNJTaDGjVily4aHOprsyJAZPTHEcnif/rxICE8jQYP
         +t6+PVWnzlBdBjNz5AR1goXNQoMoCKST+gsxJZ50M/CmHgXgRbpsiBR04AupbdIYTArq
         1041VrEg3nQvuWWEOuPbEu3N0vgJ7fu9A0jetx404KJDHeBz22gawn7lkk0u4z85gsnd
         bOuBoNa4rgZUOlihSvL0zAyGTYPT7/2SWa3GOB2As8Vw/VG67o9/Efztzv4u9JzjuG3o
         ZuSATKYMDS1s3aajnL6dBxrRwHiIle7FBKXpZsX9dmwF8umDwmhR8008Ce6D2fF5App/
         DkFg==
X-Gm-Message-State: APjAAAXwaVztIGs+8Aw+PxAiktqDS4cXq/HTXZX6N7sWnusBd8zLOC3q
        0qAfUqnZYKJWpBHqs3kjrBNeQdp8wgaej/d+bKBMPA==
X-Google-Smtp-Source: APXvYqyhv427Hxx7/MmUbtqChclXEe6nJWw6xg1yaWUV406sDc3FO9lJ2GvjbigdCij390dY9m18ZCX2Ku6kj6cEKso=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr10352872otr.281.1574414257767;
 Fri, 22 Nov 2019 01:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20191122063749.27113-1-kraxel@redhat.com> <20191122063749.27113-3-kraxel@redhat.com>
In-Reply-To: <20191122063749.27113-3-kraxel@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 22 Nov 2019 10:17:27 +0100
Message-ID: <CAKMK7uFz3hmPT3OE8UtUQwmv+tXsjazUWT2RVHLxAq47X+EaXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: share address space for dma bufs
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 7:37 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use the shared address space of the drm device (see drm_open() in
> drm_file.c) for dma-bufs too.  That removes a difference betweem drm
> device mmap vmas and dma-buf mmap vmas and fixes corner cases like
> dropping ptes (using madvise(DONTNEED) for example) not working
> properly.
>
> Also remove amdgpu driver's private dmabuf update.  It is not needed
> any more now that we are doing this for everybody.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

But I think you want at least an ack from amd guys for double checking here.
-Daniel
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +---
>  drivers/gpu/drm/drm_prime.c                 | 4 +++-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index d5bcdfefbad6..586db4fb46bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -361,10 +361,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>                 return ERR_PTR(-EPERM);
>
>         buf = drm_gem_prime_export(gobj, flags);
> -       if (!IS_ERR(buf)) {
> -               buf->file->f_mapping = gobj->dev->anon_inode->i_mapping;
> +       if (!IS_ERR(buf))
>                 buf->ops = &amdgpu_dmabuf_ops;
> -       }
>
>         return buf;
>  }
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index a9633bd241bb..c3fc341453c0 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv)
>  struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>                                       struct dma_buf_export_info *exp_info)
>  {
> +       struct drm_gem_object *obj = exp_info->priv;
>         struct dma_buf *dma_buf;
>
>         dma_buf = dma_buf_export(exp_info);
> @@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>                 return dma_buf;
>
>         drm_dev_get(dev);
> -       drm_gem_object_get(exp_info->priv);
> +       drm_gem_object_get(obj);
> +       dma_buf->file->f_mapping = obj->dev->anon_inode->i_mapping;
>
>         return dma_buf;
>  }
> --
> 2.18.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
