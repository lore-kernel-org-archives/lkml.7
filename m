Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FC521882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+r2lBpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGCUFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:05:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42769 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfGCUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:05:24 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so7811977ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqEnitbCuQNTiyOagSmB9O1Jt27cbSKjL3VEQXY7Em8=;
        b=b+r2lBpF+vS1wp+p/taK6B6XjLdafrEjhJohY0axqo+JqrJWWugdMGX5Mxpmi2D2lQ
         +HpYL5SPDqvtGHfFOfXObcb8kwKPGBUvbHT4QGzY0pBCsfjp+pz9HQvoZU3AhHIX+Z0d
         UHau+sGaO1Ld8XauJEqNY8+5U05seFc0x/YF2UAzA3dJQeYFJ0T2nvjsEYH1q1WqU/bp
         4DEu9CT1dGozBWGGAyCoqDpWiv9TZLtRvnx1s24n41L9mvzHPX8AKuN7f+NtPU+zGgV6
         AX6xe5bEJKb3uwvHsRxrYckvkI7fR5/fjPzoY+CYuG32v25NhEKOHV5hluPRS47HG8eR
         J3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqEnitbCuQNTiyOagSmB9O1Jt27cbSKjL3VEQXY7Em8=;
        b=N8sTchZWrVuNMQ88I7DKl76uzv6PfU0xrgvyh7q2MZrH4xH1HZG2QAa3qGiQeXmMnB
         rvzrAJgSWeN8ty80TRBfiu/OZ3EJsdMn2w2KANnGVaTvCca87UshuNEBUugPGdbGuKAq
         QsQnVQ9xMF7SFjoKoZI1OFO9a8G2xaDf8nnAXYw1NKXvSIPd3NDj05CvChid5jC9uD3N
         rOCkYc+hhdxugcPYmEaONgIOoMd8icOivIDSEEDiOuPEcZxzpLXgAufjCYBDTj0EObkr
         DDRG/1dIE5aRLvlNPzOSE7ugQk2QfD/JDVzE4zGOoSiBjWkgzpK2uuf1bQt+ePCW/x4X
         TMlQ==
X-Gm-Message-State: APjAAAXvgW27B0Ijg315RDXLl15RhnrM8xPgZB504wqk63s8TmpVUKQ3
        xhqhUtPcIjNxrWn49EcsE1LO2QrNVW2aSaCsxfM=
X-Google-Smtp-Source: APXvYqxZ8HyHPX99/aoYvXgZb5VoZYVpGb5ESIdKjpl7055Rt2uCynd+OKBIpuA3clOgTMdVSDtSydrkWbQtwPPegI8=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr38615847ios.84.1562184323404;
 Wed, 03 Jul 2019 13:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-15-kraxel@redhat.com>
In-Reply-To: <20190702141903.1131-15-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 3 Jul 2019 13:05:12 -0700
Message-ID: <CAPaKu7T3GvYVMueYgJFhADFSFEVbHEdaupw8=mq_+i150a1mLA@mail.gmail.com>
Subject: Re: [PATCH v6 14/18] drm/virtio: rework virtio_gpu_transfer_from_host_ioctl
 fencing
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

On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Switch to the virtio_gpu_array_* helper workflow.
(just repeating my question on patch 6)

Does this fix the obj refcount issue?  When was the issue introduced?

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 ++-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 35 +++++++++++---------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    |  8 ++++--
>  3 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 78dc5a19a358..4df760ba018e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -302,9 +302,10 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            struct virtio_gpu_object_array *objs,
>                            struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
> -                                         uint32_t resource_id, uint32_t ctx_id,
> +                                         uint32_t ctx_id,
>                                           uint64_t offset, uint32_t level,
>                                           struct virtio_gpu_box *box,
> +                                         struct virtio_gpu_object_array *objs,
>                                           struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>                                         struct virtio_gpu_object *bo,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0d0acf0b85ed..56182abdbf36 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -298,8 +298,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>         struct drm_virtgpu_3d_transfer_from_host *args = data;
> -       struct drm_gem_object *gobj = NULL;
> -       struct virtio_gpu_object *qobj = NULL;
> +       struct virtio_gpu_object_array *objs;
>         struct virtio_gpu_fence *fence;
>         int ret;
>         u32 offset = args->offset;
> @@ -308,35 +307,31 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>         if (vgdev->has_virgl_3d == false)
>                 return -ENOSYS;
>
> -       gobj = drm_gem_object_lookup(file, args->bo_handle);
> -       if (gobj == NULL)
> +       objs = virtio_gpu_array_from_handles(file, &args->bo_handle, 1);
> +       if (objs == NULL)
>                 return -ENOENT;
>
> -       qobj = gem_to_virtio_gpu_obj(gobj);
> -
> -       ret = virtio_gpu_object_reserve(qobj);
> -       if (ret)
> -               goto out;
> +       ret = virtio_gpu_array_lock_resv(objs);
> +       if (ret != 0)
> +               goto err_put_free;
>
>         convert_to_hw_box(&box, &args->box);
>
>         fence = virtio_gpu_fence_alloc(vgdev);
>         if (!fence) {
>                 ret = -ENOMEM;
> -               goto out_unres;
> +               goto err_unlock;
>         }
>         virtio_gpu_cmd_transfer_from_host_3d
> -               (vgdev, qobj->hw_res_handle,
> -                vfpriv->ctx_id, offset, args->level,
> -                &box, fence);
> -       reservation_object_add_excl_fence(qobj->base.base.resv,
> -                                         &fence->f);
> -
> +               (vgdev, vfpriv->ctx_id, offset, args->level,
> +                &box, objs, fence);
>         dma_fence_put(&fence->f);
> -out_unres:
> -       virtio_gpu_object_unreserve(qobj);
> -out:
> -       drm_gem_object_put_unlocked(gobj);
> +       return 0;
> +
> +err_unlock:
> +       virtio_gpu_array_unlock_resv(objs);
> +err_put_free:
> +       virtio_gpu_array_put_free(objs);
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index fc908d5cb217..bef7036f4508 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -928,20 +928,24 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>  }
>
>  void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
> -                                         uint32_t resource_id, uint32_t ctx_id,
> +                                         uint32_t ctx_id,
>                                           uint64_t offset, uint32_t level,
>                                           struct virtio_gpu_box *box,
> +                                         struct virtio_gpu_object_array *objs,
>                                           struct virtio_gpu_fence *fence)
>  {
> +       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>         struct virtio_gpu_transfer_host_3d *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
>
>         cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>         memset(cmd_p, 0, sizeof(*cmd_p));
>
> +       vbuf->objs = objs;
> +
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
>         cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>         cmd_p->box = *box;
>         cmd_p->offset = cpu_to_le64(offset);
>         cmd_p->level = cpu_to_le32(level);
> --
> 2.18.1
>
