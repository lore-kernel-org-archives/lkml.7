Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DFDC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A22E2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjsUVC5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfECQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:41:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32862 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfECQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:41:10 -0400
Received: by mail-it1-f193.google.com with SMTP id u16so3690408itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjLoGVU1gaH6UfBmo61XmqKTUT9KNrV65aNqszwWgfM=;
        b=UjsUVC5iF4LqG2oy2Fm/ty3L+OVTzO7Q9pu8WST7JLtlmqUcvycVQaowzWwK8cBNA1
         3/cE8gzLPDRvY/Cdu/FXqVqs1fWaO7sWYqX1Zlv1W9f2TkLRuIT696Hs0aiNsE67DapD
         5LWVUIYJ9GD2e5kf5BVXRJqTlR8K30tHtJ+7VmHvjg7q7tiB7Y13GZrGiS3o5TpYNwCV
         8wPd9lsIcELP0qtfG5Jyi7bnWTmO/QFzwQKZ6GWVjHU1PFt53mB/vo0V/0hBslFfLsLR
         oVmZYAkMwI1n7BH0GYrKQAjGHJ4IOy5QA4pt9zbRrWMqbXIv7jDWlkd2SdFMkH9q3eGW
         +5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjLoGVU1gaH6UfBmo61XmqKTUT9KNrV65aNqszwWgfM=;
        b=L9U4T4uwp3J/gr5sSQrweni6GaH3Y02Az4SAdsL+vJh0HG2p8ZeBUSPml7YlbaycLQ
         nkpsMpH//kijACGbIf9p491xhuLaXtPIoh9RJhI6FMXESfXE6th9vFPnhhd/R4oFQP2D
         Tf3VqU+NHGvK4unk9cOTzKhTyUmvHq91xWPnPjG5Mwwy2CsSuWrd0GO9b6RGl4thbr8t
         1pZlz4QVoXxQ5Iq72KO0lMws5BokvTpD9S9mVGiPzan3fvXYPUGN48FZDSP5m/ahW4Bq
         hwpfNNaNi3Uu6FQVQLNofnLw9NeYyXK0SmT9PnVBDbrrxSnJ15511MP+DwR+dImtK3XP
         iRyA==
X-Gm-Message-State: APjAAAVYaf7UHC4fP8jC7DdotWnuCJ0mP/YfAML1EyB06m0oTTxKweEF
        mj3F5wy/gNRr2LK5tokSGg8eFO43o9qQFSKlj/8=
X-Google-Smtp-Source: APXvYqwlBSYQlISp0r6yiSxEkv5WvdDoLXFua6M0BKcjdBpadMAOqsRgC+U4oGHSsAWc7wjocOGcQ6Ri66hnffjOIss=
X-Received: by 2002:a24:e517:: with SMTP id g23mr7579662iti.113.1556901669124;
 Fri, 03 May 2019 09:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190503163804.31922-1-robert.foss@collabora.com>
In-Reply-To: <20190503163804.31922-1-robert.foss@collabora.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 3 May 2019 09:40:58 -0700
Message-ID: <CAPaKu7SfkUN4FBQ5Xm3zfdvvbcvBAWDz0k2FVdn8TNZWwiV-tg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Remove redundant return type
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 9:38 AM Robert Foss <robert.foss@collabora.com> wrote:
>
> virtio_gpu_fence_emit() always returns 0, since it
> has no error paths.
>
> Consequently no calls for virtio_gpu_fence_emit()
> use the return value, and it can be removed.
>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>
> This patch was suggested in this email thread:
>
> [PATCH] drm/virtio: allocate fences with GFP_KERNEL
> https://www.spinics.net/lists/dri-devel/msg208536.html
>
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_fence.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index d577cb76f5ad..9bc56887fbdb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -334,7 +334,7 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
>  /* virtio_gpu_fence.c */
>  struct virtio_gpu_fence *virtio_gpu_fence_alloc(
>         struct virtio_gpu_device *vgdev);
> -int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
> +void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
>                           struct virtio_gpu_fence *fence);
>  void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index 21bd4c4a32d1..e0744ac768cc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -81,7 +81,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
>         return fence;
>  }
>
> -int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
> +void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
>                           struct virtio_gpu_fence *fence)
>  {
> @@ -96,7 +96,6 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>
>         cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
>         cmd_hdr->fence_id = cpu_to_le64(fence->seq);
> -       return 0;
>  }
>
>  void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
> --
> 2.20.1
>
