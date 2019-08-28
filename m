Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15C8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2122DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIWG1PDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfH1VN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:13:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39880 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1VN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:13:56 -0400
Received: by mail-io1-f66.google.com with SMTP id l7so2475734ioj.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0DnwMkmLDWIJwSrLn8Xo+nBrgU3ut606yiaW7tsLmw=;
        b=WIWG1PDkVbjjjFnFPpFLjjxtVTRsYeL9XpsAkGxaDEIeAhcAamyPp68HluklgS3rQP
         C/5rt0po7h3H6Gf7/im0mdsHGo5rDctWgkNhkR9SFFcQ2giiCAvnQpbxtThQwkTa2htt
         hneadVzJncluLhLJBw/BMR67x6jSeSdegdVE2VtCwK/A96Wy7RvcQ6zKIeW4w0MQjz+9
         V4TWU2h4v0uKER3nm8/QWp7fJL2RYZHn+WvCAvu+lohvWO3gIKITjl9Bc7jM6BAWZgiU
         XiXVu9u9PfxR+WU3CUEBQFMiZj6jvaeMqaxYXRE+Q7tKwepQ0RWM3k/Bg5iAWg/1eUIv
         ihWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0DnwMkmLDWIJwSrLn8Xo+nBrgU3ut606yiaW7tsLmw=;
        b=STl7CzogCoB/LrFwMhSo3JmcktUH95I4Wt96pWxIZoWiXBs0O8SZeayBdjCuJwPBWA
         JxYqJOwGY2q1yoUluR8UtKxqaNNTyYqQCXxEDmxvRqlJvGxvMSc3sgseQOHk1CMI+PS3
         0ay4rtkRamkEylOCv/lwjnwDffMQQ07KfMl5xxqf32EXGTX7CK2lp2/rmQYuh7PNwCo3
         n2M4Y7m9yXOCu90LFuw6Q3xVRhoucwkZjylV78O8PaIERYcvFDrxC2eDJkYckGcyX1Gr
         4+5QiidVLXwuhPSrcNbvvZz46l2Q6my9ZlkrA56KdaOXp5GGF/tOACp0gZj/WR4d8qhB
         N+pQ==
X-Gm-Message-State: APjAAAVjEUdkM7c/Z3WdVswD2beYBVs2c5PSxiNei0Lamx3g41oD5PWX
        b3nHWyBNjCalOe8oQhdOH/h4XRh84n4xVZAPPEU=
X-Google-Smtp-Source: APXvYqzMB/toxRqCkJ9PWvyQnMavsuq5vQlvJoKHZy+zVMpOjz1ploNu5L7LA5sr0YhCp5g4o3nI4y7/qsa67W4ChIM=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr1919196ioc.232.1567026835236;
 Wed, 28 Aug 2019 14:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190823095503.2261-1-kraxel@redhat.com> <20190823095503.2261-3-kraxel@redhat.com>
In-Reply-To: <20190823095503.2261-3-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 28 Aug 2019 14:13:44 -0700
Message-ID: <CAPaKu7Tbv+JgPLy4GLDU8qwx-X7mA0eFT-Sjxb4CaV5Zr4beXA@mail.gmail.com>
Subject: Re: [PATCH v8 02/18] drm/virtio: switch virtio_gpu_wait_ioctl() to
 gem helper.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
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

On Fri, Aug 23, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> This also makes the ioctl run lockless.
>
> v5: handle lookup failure.
> v2: use reservation_object_test_signaled_rcu for VIRTGPU_WAIT_NOWAIT.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0a88ef11b9d3..74b6bad01d7f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -466,23 +466,20 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
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
> +               if (obj == NULL)
> +                       return -ENOENT;
> +               ret = dma_resv_test_signaled_rcu(obj->resv, true);
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
> +       return drm_gem_dma_resv_wait(file, args->handle, true, timeout);
This changes the return value from -EBUSY to -ETIME when the wait
times out.  I think we can use dma_resv_wait_timeout_rcu directly
here.



>  }
>
>  static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
> --
> 2.18.1
>
