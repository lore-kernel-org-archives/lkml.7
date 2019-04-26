Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC41206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XdVa/UMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:21:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36079 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDZOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:21:49 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so3105335ioc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkJyFzPG+Rri4iB7SrmxtBQEBVd3BG8Vrjj6VUTWkYA=;
        b=XdVa/UMZ+2UG5ezgRW6jI4d4YoHpC2a1yQWFMxLhp+3DzCPDHIfllBuCiApVqTp35m
         xj0CCYCwt3lXMHuFh23K2LscHxyW0fvEFZyk7pSz8rU1wooo5woV2ZP9y2K62T9WTe4u
         4HVqZBwoClJPNk9STT9DvWQ1hay3cJRZWRFMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkJyFzPG+Rri4iB7SrmxtBQEBVd3BG8Vrjj6VUTWkYA=;
        b=W481RdM16o0kH5BtXbdFbI5blr1jODlsrTwTaJuoNpGzN7ZvdOlzSdjsz7ns9HqzKq
         hf4Zvb+E2XBUMzghlvZetxrQ39UUqsHbZ4QPbZUQGQOcmNldvP0/EMf6BprYDD6dDnK0
         hb6VjzeBcqI8lS2zr/l6zgE+PFjtEp4RY/ZIoCHst0Nr3rp0WRHaV62vlOjTA6Z5YZ0F
         k7iZ3rSDtS+DXEQ8Tlr9vmftjxasJfq6Chm3YmxTqCbifyum3ewNavXoIrmKpz4F32Mu
         2J2lD7ON5qFmEtlemaBTtzsdJTQVA+inlyrgFri0mJE7B+HCo7VxErxGYl39lX2sF5qZ
         L3AQ==
X-Gm-Message-State: APjAAAXtPKULQAtZUGB6fibKH/Q7lXrwJs8xRFYjrJimq0X4blAv+vlb
        PZd5oFY753YapLR5j+X3+rDzHQiaRoCkMsbnkaPa+g==
X-Google-Smtp-Source: APXvYqz6Ch5zyVD60GP4DAl4HUmZk6GjcrmT/uENhh/KRlsF/uo1LX6FTfzvYTiI4znlMRGd18uOeYjzADIvxXaqSaU=
X-Received: by 2002:a6b:b24c:: with SMTP id b73mr19343819iof.34.1556288508516;
 Fri, 26 Apr 2019 07:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190426053324.26443-1-kraxel@redhat.com>
In-Reply-To: <20190426053324.26443-1-kraxel@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 26 Apr 2019 16:21:37 +0200
Message-ID: <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
>
> Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
> import/export callbacks".  We have to do the same with qxl,
> for the same reasons (it breaks DRI3).
>
> Drop the WARN_ON_ONCE().
>
> Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Maybe we need some helpers for virtual drivers which only allow
self-reimport and nothing else at all? I think there's qxl, virgl,
vmwgfx and maybe also vbox one who could use this ... Just a quick
idea.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c   |  4 ++++
>  drivers/gpu/drm/qxl/qxl_prime.c | 12 ++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 578d867a81d5..f33e349c4ec5 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -255,10 +255,14 @@ static struct drm_driver qxl_driver = {
>  #if defined(CONFIG_DEBUG_FS)
>         .debugfs_init = qxl_debugfs_init,
>  #endif
> +       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> +       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_prime_export = drm_gem_prime_export,
>         .gem_prime_import = drm_gem_prime_import,
>         .gem_prime_pin = qxl_gem_prime_pin,
>         .gem_prime_unpin = qxl_gem_prime_unpin,
> +       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> +       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
>         .gem_prime_vmap = qxl_gem_prime_vmap,
>         .gem_prime_vunmap = qxl_gem_prime_vunmap,
>         .gem_prime_mmap = qxl_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> index 8b448eca1cd9..114653b471c6 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -42,6 +42,18 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
>         qxl_bo_unpin(bo);
>  }
>
> +struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
> +struct drm_gem_object *qxl_gem_prime_import_sg_table(
> +       struct drm_device *dev, struct dma_buf_attachment *attach,
> +       struct sg_table *table)
> +{
> +       return ERR_PTR(-ENOSYS);
> +}
> +
>  void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
>  {
>         struct qxl_bo *bo = gem_to_qxl_bo(obj);
> --
> 2.18.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
