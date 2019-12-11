Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EEBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0583220836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/1GyM9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfLKTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:04:12 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37911 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLKTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:04:11 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so1932920ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1nlOc2n0b1t3obc3rKWIj5ixOjOEEj0+iZqrVipp9o=;
        b=D/1GyM9K41JOlRCD7lN5eU3vWpokEaPbOKAJ6/7sgnF2lgivSxP9Z7lmUx2lOjkZcu
         8jzg7Oh1qQ+jx1kIuLADi92d6wgC/Ho+yXkpv+EOzB02v3tA1EbfQSiP3ZC8yFJ1nXkc
         K6xhywDMCxsFgD/SftI9531KFjj999GO2h/5sdvutSW9i2eEXlrdUJHkZL7V65YPp6cL
         MypyIKnKw7hoh+0/isjG3MchY1pyX3aFaDRwhD720csf7KtAvEFeRmjs8lb6TDJoD19V
         PjuQdELCfa1r1/aD8M91Op+GfPLwqzlONrX3ZWrJmbL8+bAdX20m5V90dGsLIOSirdTi
         MJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1nlOc2n0b1t3obc3rKWIj5ixOjOEEj0+iZqrVipp9o=;
        b=sn3sJ0QfvhOJLCRKUVxwjseGOc/9arigDyWU6+LCcpcwr0Cq+gnZm1+f0B8H2PBLzf
         qbyaAHFPWD24/glgtAf4Ab6g7cWoUKhtTtZdeo/hIOAdfF+T6afN9mWmcME9EHQWat3r
         DUS18vTYRkzGkBD486mU6AwiJVNuWaN+Z/SkQFky6z61nTZUt0mCfarf2w4J/E7TcQkv
         dbYqKfX5M3r3v6pv9LJddoB5zRxiS6HJa5dW1EtSrU6WnhxGkqzEG9qgC+A0C+lhd4dv
         Y60s/Foda6c0186uaXhfg8ae/FLUgrXZKW2Los/HEMYNO+cF0b+2FwmStn6e3A1TM0ov
         LUTQ==
X-Gm-Message-State: APjAAAVKUk7vSSuT4eLjwAnfh12IK0StdzeX5TnxV0uE5mva0dQz9aTt
        bGatURd4amP4EpjSfqJ2NQ+wWnIW1R5L2msO2nY=
X-Google-Smtp-Source: APXvYqxPNqI/M/Od5Srqmugr+fhahB2I9e8NKlqPiAdGKQBh8UdtL9bsnU5VG3zxSSFDPjHZfJ8AxYuPb8Qe6AeW2VA=
X-Received: by 2002:a92:84ce:: with SMTP id y75mr4470966ilk.93.1576091050492;
 Wed, 11 Dec 2019 11:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20191211084216.25405-1-kraxel@redhat.com> <20191211084216.25405-4-kraxel@redhat.com>
In-Reply-To: <20191211084216.25405-4-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 11 Dec 2019 11:03:59 -0800
Message-ID: <CAPaKu7Tv2tGOW+Ns9yRQ0t9-Bk43wtV5KEh72fZuvPaX7Dy_gQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu: use damage info for display updates.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:42 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 41 +++++++++++++++-----------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 2e0d14e005db..1a0fbbb91ec7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_damage_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
>
> @@ -103,22 +104,26 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
>  }
>
>  static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
> -                                     struct virtio_gpu_object *bo,
> -                                     struct drm_plane_state *state)
> +                                     struct drm_plane_state *state,
> +                                     struct drm_rect *rect)
>  {
> +       struct virtio_gpu_object *bo =
> +               gem_to_virtio_gpu_obj(state->fb->obj[0]);
>         struct virtio_gpu_object_array *objs;
> +       uint32_t w = rect->x2 - rect->x1;
> +       uint32_t h = rect->y2 - rect->y1;
> +       uint32_t x = rect->x1 + (state->src_x >> 16);
> +       uint32_t y = rect->y1 + (state->src_y >> 16);
> +       uint32_t off = x * state->fb->format->cpp[0] +
> +               y * state->fb->pitches[0];
>
>         objs = virtio_gpu_array_alloc(1);
>         if (!objs)
>                 return;
>         virtio_gpu_array_add_obj(objs, &bo->base.base);
> -       virtio_gpu_cmd_transfer_to_host_2d
> -               (vgdev, 0,
> -                state->src_w >> 16,
> -                state->src_h >> 16,
> -                state->src_x >> 16,
> -                state->src_y >> 16,
> -                objs, NULL);
> +
> +       virtio_gpu_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
> +                                          objs, NULL);
>  }
>
>  static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
> @@ -127,8 +132,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         struct drm_device *dev = plane->dev;
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_output *output = NULL;
> -       struct virtio_gpu_framebuffer *vgfb;
>         struct virtio_gpu_object *bo;
> +       struct drm_rect rect;
>
>         if (plane->state->crtc)
>                 output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
> @@ -146,12 +151,14 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>                 return;
>         }
>
> +       if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
> +               return;
> +
>         virtio_gpu_disable_notify(vgdev);
>
> -       vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
> -       bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
> +       bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
>         if (bo->dumb)
> -               virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
> +               virtio_gpu_update_dumb_bo(vgdev, plane->state, &rect);
>
>         if (plane->state->fb != old_state->fb) {
>                 DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
> @@ -171,10 +178,10 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>         }
>
>         virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
> -                                     plane->state->src_x >> 16,
> -                                     plane->state->src_y >> 16,
> -                                     plane->state->src_w >> 16,
> -                                     plane->state->src_h >> 16);
> +                                     (plane->state->src_x >> 16) + rect.x1,
> +                                     (plane->state->src_y >> 16) + rect.y1,
Digging into drm_atomic_helper_damage_merged, it seems rect uses
absolute values and is not relative to src_{x,y}.

> +                                     rect.x2 - rect.x1,
> +                                     rect.y2 - rect.y1);
>
>         virtio_gpu_enable_notify(vgdev);
>  }
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
