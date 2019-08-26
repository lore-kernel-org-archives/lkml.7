Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F031C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BEB21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQSN7pQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfHZWGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:06:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40793 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfHZWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:06:19 -0400
Received: by mail-io1-f66.google.com with SMTP id t6so41306688ios.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2+X7ZLdUUxNkcBQNBfyLlM7Bq5bjsdY0IjjmtqCq8s=;
        b=lQSN7pQhTCM28br9rSgxowCmfZmsljVskLhGMUN8q9JRAPHK5tkMcdA4AhKA+ezKGf
         qcEEG70QEoiTsJhZkfOW57KexZaK/Np9tIm3WFU1t0QflRoTMSSWKK6EKoa/oeZECM9v
         fgpa1tg+tGUUhSa43lab1By1HWWM78GpZ1C8BjBzh9x6I0UTiFwAHzrUCuxuNCjvJSLn
         vn+AI5TRT8NmBBGBr8ySszqREymrYNaOgZp5QoY5dt7BZKnH361RVhA5ON3uoxJSEwV8
         Nb/+SsuAVFcRCdMd9bkdDoor3f5LDZapyZbl7ErJI+Gvy8Uqa29OSSHCZ3EjSRZ8QJdd
         q4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2+X7ZLdUUxNkcBQNBfyLlM7Bq5bjsdY0IjjmtqCq8s=;
        b=omovXBtgUJZmCvb38Y81dIVwRiWJRNHsNhW7kfHaFaB/jB6ImjAp4R+TkAnoXpyely
         jkOuFdvUVI8GxWhZI4aw/4ZHwx9t8bwTg/sxZevbfhBw4zOH8Hd6HBDvkWWiLROeW8TD
         a9hOx0qY9AmJYeFsRZMx16bny8loIk952rIoz8oAQkQqIdAqHQxf0yQ04N2mQkpZ6Hk/
         BD138oPxMy6iRHDI+BfYiOFShZfGQaIdsxMjaguKYuwIUpjC2UXHR+7NWWrwkPc5TMAg
         yaFR7oZYyFnEb7Bzbn1E6THE+AxwBsXzjc6i9KKF1xlIicPqTX1RioE2mEe2fTUnSVpK
         5I+w==
X-Gm-Message-State: APjAAAV+Jju8CznZxZdIFw93yDBMG0gdX0LhTLdeMbbktdvpCi9Xr5GP
        RkeLe01+XfYduPbY8fZyv/E+b3lajJRlApoZmRjZaxEu
X-Google-Smtp-Source: APXvYqwcYevweKqMNjHTJ83mj+kVwgsdYNMqCFj1IF88/5p1L/AzW1r6mX95/4ulDgCHTIUECfPGxzod9HEYB/twqAs=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr16773354ioq.93.1566857178737;
 Mon, 26 Aug 2019 15:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190822102614.18164-1-kraxel@redhat.com>
In-Reply-To: <20190822102614.18164-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Mon, 26 Aug 2019 15:06:07 -0700
Message-ID: <CAPaKu7Q+T1qf4jboXSV-jsXHrvqSxG+MrJGJzFf7qNisaZj3Wg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: make resource id workaround runtime switchable.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 3:26 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also update the comment with a reference to the virglrenderer fix.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 44 ++++++++++++++-----------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index b2da31310d24..e98aaa00578d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -27,34 +27,38 @@
>
>  #include "virtgpu_drv.h"
>
> +static int virtio_gpu_virglrenderer_workaround = 1;
> +module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> +
>  static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
>                                        uint32_t *resid)
>  {
> -#if 0
> -       int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
> -
> -       if (handle < 0)
> -               return handle;
> -#else
> -       static int handle;
> -
> -       /*
> -        * FIXME: dirty hack to avoid re-using IDs, virglrenderer
> -        * can't deal with that.  Needs fixing in virglrenderer, also
> -        * should figure a better way to handle that in the guest.
> -        */
> -       handle++;
> -#endif
> -
> -       *resid = handle + 1;
> +       if (virtio_gpu_virglrenderer_workaround) {
> +               /*
> +                * Hack to avoid re-using resource IDs.
> +                *
> +                * virglrenderer versions up to (and including) 0.7.0
> +                * can't deal with that.  virglrenderer commit
> +                * "f91a9dd35715 Fix unlinking resources from hash
> +                * table." (Feb 2019) fixes the bug.
> +                */
> +               static int handle;
> +               handle++;
> +               *resid = handle + 1;
> +       } else {
> +               int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
> +               if (handle < 0)
> +                       return handle;
> +               *resid = handle + 1;
> +       }
>         return 0;
>  }
>
>  static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
>  {
> -#if 0
> -       ida_free(&vgdev->resource_ida, id - 1);
> -#endif
> +       if (!virtio_gpu_virglrenderer_workaround) {
> +               ida_free(&vgdev->resource_ida, id - 1);
> +       }
>  }
>
>  static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
