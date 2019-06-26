Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500DFC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2242E20815
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkdsB900"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFZXzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:55:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45001 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfFZXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:55:33 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so642478iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFOmBfL98emh/MYkHT7m04HAElQFNQEeVW5ROqlJL+Y=;
        b=WkdsB90003wZlIbZPOM6yLKQ8fZBLPGqZD10BWCj96jgkU45YwHT5zGBlN5RrS2PjH
         pieBPX2NOzAKAgDARKZwvKO71cNZl1UlkkjYQCJ8lj0+qHwNg2VtG2cJECKc5bjHTmwr
         Dg2ykRz1tGxTbqn45qfr393V2c2KX0AW7GsXwEdu8Q6I8bmrjyz6wikBj4K0vP3QtNDL
         jZOKCHdQbEhllLoUcNHcFkD+UjcVIANEc6MnGoYQIwF0nMdBe1+OFnWXoxpXl1QQf8x0
         Qi/y2bncdtk52+xsoJb4kKI+4BKc8ZN8XP0Ag9T+uKf8XV9Lhwtg4+3bygxI5ufL+jnq
         +uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFOmBfL98emh/MYkHT7m04HAElQFNQEeVW5ROqlJL+Y=;
        b=lMWUt3A1+xLCNtwfz2H8bHzHvbBAr6ujqro8HbZh5eiLLJTrJNTxPjKSKJhxq5tc7K
         DH4R5FNLDgWryTNJfPl8ezzfRuGP7cjY+SUGSga5zWgmYeu9TShAOzJ/98XWoMsiGH9n
         zwVpQ+ID3YZiqHq06BvGryV/m5U7Rd0B7ZTFm6LCIFZNngh5m+pnakuoBsKYy9Xu9BLm
         Vg91ofNUjWtisbgUgHo7Db3gyznKPneHTn+pRb7+tl9/D8/c3KJGwu2VXW2b8D6Ks84K
         HClvDdsdmElyLFvb+okafGT1Mc7PeVg6gE8sXUE1r6dT2m5ioGYnDaiXhL+KgaiYIw1O
         aYIQ==
X-Gm-Message-State: APjAAAXEYSiOrUSMqlGXCvFK5TOYibIi0ynlpdrhDnec+5cHay3mNHZo
        3tC9TdKKjWauU7RURQSiFsJoC12JM1/MXPhMvOs=
X-Google-Smtp-Source: APXvYqxJskAboHi/EJpGElxVyZ0pbUBPtkqfxFuTpUiQaqkNzIP0fuT6ddNPHhSVOlefT8unJ7Gyt/hPlYS+l8eheig=
X-Received: by 2002:a02:b10b:: with SMTP id r11mr836507jah.140.1561593331304;
 Wed, 26 Jun 2019 16:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-3-kraxel@redhat.com>
In-Reply-To: <20190620060726.926-3-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 26 Jun 2019 16:55:20 -0700
Message-ID: <CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
 gem helper.
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

On Wed, Jun 19, 2019 at 11:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> This also makes the ioctl run lockless.
The userspace has a BO cache to avoid freeing BOs immediately but to
reuse them on next allocations.  The BO cache checks if a BO is busy
before reuse, and I am seeing a big negative perf impact because of
slow virtio_gpu_wait_ioctl.  I wonder if this helps.


>
> v2: use reservation_object_test_signaled_rcu for VIRTGPU_WAIT_NOWAIT.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index ac60be9b5c19..313c770ea2c5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -464,23 +464,19 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *file)
>  {
>         struct drm_virtgpu_3d_wait *args = data;
> -       struct drm_gem_object *gobj = NULL;
> -       struct virtio_gpu_object *qobj = NULL;
> +       struct drm_gem_object *obj;
> +       long timeout = 15 * HZ;
>         int ret;
> -       bool nowait = false;
>
> -       gobj = drm_gem_object_lookup(file, args->handle);
> -       if (gobj == NULL)
> -               return -ENOENT;
> +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> +               obj = drm_gem_object_lookup(file, args->handle);
Don't we need a NULL check here?
> +               ret = reservation_object_test_signaled_rcu(obj->resv, true);
> +               drm_gem_object_put_unlocked(obj);
> +               return ret ? 0 : -EBUSY;
> +       }
>
> -       qobj = gem_to_virtio_gpu_obj(gobj);
> -
> -       if (args->flags & VIRTGPU_WAIT_NOWAIT)
> -               nowait = true;
> -       ret = virtio_gpu_object_wait(qobj, nowait);
> -
> -       drm_gem_object_put_unlocked(gobj);
> -       return ret;
> +       return drm_gem_reservation_object_wait(file, args->handle,
> +                                              true, timeout);
>  }
>
>  static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
