Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9573EC2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6984D208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5p8cM1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLKBG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:06:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34533 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLKBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:06:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so15315691lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3U5Ton5GkI2QD9NYugFaf5BRq2pqUxCkGGQRfb840Q=;
        b=R5p8cM1REpNhwNG/S5JozlDrfWJgObKwfHJFLWfvYis1Ng08mRoAMlI0ycQSAeEcd6
         zeaPJeZGj7VhZvnEdIa+scrFuK0MppI/lpyBTfgIMcgTtliSBQrIhjZP5YFFE3kQCxWM
         fnMjAPdttTJzRAwTscCs7zhgii0RJlQ54lIy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3U5Ton5GkI2QD9NYugFaf5BRq2pqUxCkGGQRfb840Q=;
        b=t12dWmNEzeZmmp5e5p1BmTs2Sy5J/snYMzhiatejVRECYig9j5dL2+0WjbKhcJRN0l
         5/D5fhlkc8D84aO8MPOC65hTdF5j1vVquDy73TtZsL5XS7GOlIeo8/kmOVgHF3EaN/5d
         N9+XkXD+9Jk0TfDeoBtp4ltyxwWK3/vestJznfRQxvFa1h9SFAPxLt0lazrRXGn2/qIP
         47sk49BBhqoGKIFjwOwXSTiSmVK+anSyduHr6ZqOg5XIK0aeRZXwAKcAA03zneGwxbQY
         eeCeUiGzkshi+lOL+Lw/AO9M0ghqNp1L2gu33QdiC0ZMYBqoHZXVL/7VMdB9/kde4/bI
         b2WA==
X-Gm-Message-State: APjAAAUSoUsA+BUmZRLGxRxV65Li2+mFzZiE+54qL5KoQY2VKlfFqhS1
        6ZLBr6AVj+p5bgjTJcJjgJydYWFT6wc=
X-Google-Smtp-Source: APXvYqxPXnq+5qLS4xw5ZkJ5K4eoEEuEBCrc7EfTDvgcMoD8oxKyQn6W2dWR7ota5s7jnjgAmCUW0Q==
X-Received: by 2002:ac2:465e:: with SMTP id s30mr473363lfo.134.1576026414509;
        Tue, 10 Dec 2019 17:06:54 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j19sm235378lfb.90.2019.12.10.17.06.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 17:06:54 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 9so15283580lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 17:06:53 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr478455lfp.106.1576026413534;
 Tue, 10 Dec 2019 17:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20191210085759.14763-1-kraxel@redhat.com>
In-Reply-To: <20191210085759.14763-1-kraxel@redhat.com>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Tue, 10 Dec 2019 17:06:42 -0800
X-Gmail-Original-Message-ID: <CAAfnVB=prUDgkPjZdB9QcA9XHdcBCQSPcf4mBL75LG8QJ4D=0Q@mail.gmail.com>
Message-ID: <CAAfnVB=prUDgkPjZdB9QcA9XHdcBCQSPcf4mBL75LG8QJ4D=0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:58 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> virtio-gpu uses cached mappings.  shmem helpers use writecombine though.
> So roll our own mmap function, wrapping drm_gem_shmem_mmap(), to tweak
> vm_page_prot accordingly.
>
> Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 017a9e0fc3bb..158610902054 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -75,6 +75,22 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>         drm_gem_shmem_free_object(obj);
>  }
>
> +static int virtio_gpu_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> +{
> +       pgprot_t prot;
> +       int ret;
> +
> +       ret = drm_gem_shmem_mmap(obj, vma);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* virtio-gpu needs normal caching, so clear writecombine */
> +       prot = vm_get_page_prot(vma->vm_flags);
> +       prot = pgprot_decrypted(prot);
> +       vma->vm_page_prot = prot;
> +       return 0;
> +}
> +
>  static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
>         .free = virtio_gpu_free_object,
>         .open = virtio_gpu_gem_object_open,
> @@ -86,7 +102,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
>         .get_sg_table = drm_gem_shmem_get_sg_table,
>         .vmap = drm_gem_shmem_vmap,

Do we need vmap/vmunap?  It seems optionable and also uses non-cacheable memory?

>         .vunmap = drm_gem_shmem_vunmap,
> -       .mmap = &drm_gem_shmem_mmap,
> +       .mmap = &virtio_gpu_gem_mmap,

Why the &virtio_gpu_gem_mmap?  Shouldn't just virtio_gpu_gem_mmap work?



>  };
>
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
> --
> 2.18.1
>
