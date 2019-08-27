Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24DB21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6sitAXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfH0Qpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:45:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34377 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfH0Qpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:45:39 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so47921651ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgEZL7FHXVC38tkVb8BiSRS9kzc42h1C+rKp2AsOFAo=;
        b=T6sitAXXsulHPQdxWkBxQoQ5ma3ksEOLb1V/hrE/6RubIs6kJkFPQSGzCSYd/uGPXe
         rgQU8z5g7+cFRG1QF7yW25qsZURMuJMXmyb9xujtNB8s3WQe1gVLdlRtRfNRyOCg75iu
         Rti4wabkh6aPySTaup/hsr7t4vvn0h5ZHCRepu/NOuHzMVwVRuJ25j0lSKQevAVXEoJ7
         ewe34JV3U7tris/s7XI2ZwwfYV3drOlobjk0Kf86c0BDwMmsN1akmTeeUjv8ZMLks6re
         8SWY68KxAnL5hZADc6L82KxM9iSsdCaIIsTFwC+bvxjIhnzKtigG2D/6woMhYUs7FAl8
         KHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgEZL7FHXVC38tkVb8BiSRS9kzc42h1C+rKp2AsOFAo=;
        b=mjnN1K5g0sHA+kk5HyyoijPa5i3c63Zy4bapx5aB7SrivfvxeP4JpGlxu2d7lxn4FX
         ssLRw9K4mgWZoWt8lQqFXr+mZ4LT2eomxI5K2MgPKWqvnowY+bxc1q5y0ZXgWKSSTXcY
         4pvOpvop6e3YQn1GcBYXd8tLLPIRqfbkRTMoERHJPFOMUJMUqPuL59kaSu4Zbzv7XFef
         fLA07O+e1F5YSKmUktNx5J9EzKA8HIfBKCo20atNDhKaQoivg4BJ8c94YjarlotxIiTL
         TGbKUJVTo8kWPbUJG2U1PB3BNw0K2FxO8gd4PX6bBXm7lpfVRb7eZ2/R8ecaanwC5W/5
         QuOA==
X-Gm-Message-State: APjAAAVhEe18xXjlr47NAU0JIwAzlNSYjnhZaNSsqZ+n+7i7bPfd0CTQ
        MCS65zGq+2rGis6IjujmUskAPPTbiCISeWPFWog=
X-Google-Smtp-Source: APXvYqwMDuQ1qPyVS6ef0qkkeTM17FDw8fs2kRk6HNwsBmCQAJLs9dkPFKkpzSV5F8vJTpvLB0sUGUBT0Atm2qMcXC0=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr33986129ioc.232.1566924338329;
 Tue, 27 Aug 2019 09:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190813082509.29324-1-kraxel@redhat.com> <20190813082509.29324-3-kraxel@redhat.com>
In-Reply-To: <20190813082509.29324-3-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Tue, 27 Aug 2019 09:45:27 -0700
Message-ID: <CAPaKu7T2AA83wLchMDmLEEb-VgvdfCP3_Dz8drrH9hptgXPn9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/virtio: notify virtqueues without holding spinlock
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

On Tue, Aug 13, 2019 at 1:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Split virtqueue_kick() call into virtqueue_kick_prepare(), which
> requires serialization, and virtqueue_notify(), which does not.  Move
> the virtqueue_notify() call out of the critical section protected by the
> queue lock.  This avoids triggering a vmexit while holding the lock and
> thereby fixes a rather bad spinlock contention.
>
> Suggested-by: Chia-I Wu <olvaffe@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Series is

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index ca91e83ffaef..e41c96143342 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -252,7 +252,7 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
>         wake_up(&vgdev->cursorq.ack_queue);
>  }
>
> -static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
> +static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                                                 struct virtio_gpu_vbuffer *vbuf)
>                 __releases(&vgdev->ctrlq.qlock)
>                 __acquires(&vgdev->ctrlq.qlock)
> @@ -260,10 +260,11 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>         struct virtqueue *vq = vgdev->ctrlq.vq;
>         struct scatterlist *sgs[3], vcmd, vout, vresp;
>         int outcnt = 0, incnt = 0;
> +       bool notify = false;
>         int ret;
>
>         if (!vgdev->vqs_ready)
> -               return;
> +               return notify;
>
>         sg_init_one(&vcmd, vbuf->buf, vbuf->size);
>         sgs[outcnt + incnt] = &vcmd;
> @@ -292,16 +293,21 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                 trace_virtio_gpu_cmd_queue(vq,
>                         (struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>
> -               virtqueue_kick(vq);
> +               notify = virtqueue_kick_prepare(vq);
>         }
> +       return notify;
>  }
>
>  static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                                          struct virtio_gpu_vbuffer *vbuf)
>  {
> +       bool notify;
> +
>         spin_lock(&vgdev->ctrlq.qlock);
> -       virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
> +       notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> +       if (notify)
> +               virtqueue_notify(vgdev->ctrlq.vq);
>  }
>
>  static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> @@ -310,6 +316,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                                                 struct virtio_gpu_fence *fence)
>  {
>         struct virtqueue *vq = vgdev->ctrlq.vq;
> +       bool notify;
>
>  again:
>         spin_lock(&vgdev->ctrlq.qlock);
> @@ -330,8 +337,10 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>
>         if (fence)
>                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> -       virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
> +       notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> +       if (notify)
> +               virtqueue_notify(vgdev->ctrlq.vq);
>  }
>
>  static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
> @@ -339,6 +348,7 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  {
>         struct virtqueue *vq = vgdev->cursorq.vq;
>         struct scatterlist *sgs[1], ccmd;
> +       bool notify;
>         int ret;
>         int outcnt;
>
> @@ -361,10 +371,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>                 trace_virtio_gpu_cmd_queue(vq,
>                         (struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>
> -               virtqueue_kick(vq);
> +               notify = virtqueue_kick_prepare(vq);
>         }
>
>         spin_unlock(&vgdev->cursorq.qlock);
> +
> +       if (notify)
> +               virtqueue_notify(vq);
>  }
>
>  /* just create gem objects for userspace and long lived objects,
> --
> 2.18.1
>
