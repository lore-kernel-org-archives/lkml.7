Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E1DC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E5520673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCcbdXH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF3SXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 14:23:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40157 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3SXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:23:02 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so23565523ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thtzmkw13aDuZDygR3uiUylpyUs6othiMlPhmCe3nAU=;
        b=fCcbdXH9WO0fjnsX0cG4kMxd8kDGj9eP4YcIaQOOKv5Ozt5PxyEJ9hoY9qtJPyIvE0
         aZjGB9sWgGskqozbUzllzSvwa4DUEZLCWfymAoZMXW2ouFATq/2lTaFbIw7kLnFhnpzk
         V9eRCBawjO47dljbxZq0vbv0t5s10P1Xhiw0f0HHRnE43pz0VKOxNMhuA8RpUF0SOI37
         BjLZZcA99lc7C28BqRbFsGFeev9Rth5p3LfoH3pCa5upP52BFN7ysvpHqepK11WoY1TK
         IA6BA6Z6j+rjISDK5SQXLv9EQs/k7R6DulDG3DB+p39SUif2IV8lM6wvCOuJvO5PDl6x
         juhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thtzmkw13aDuZDygR3uiUylpyUs6othiMlPhmCe3nAU=;
        b=PUsulXkWTs+r/i0SSkvOimWTdE19R9wEHPVwRyO1eIA9vm8JVRZLXLGl+CI51G4EO9
         mE3FngRK0QOso6bqwLGPkVLtlmB1c9rTGg5Kd+j8RA96oiPbZL/g+v9LyH45qBFLyDU5
         BwxXWW9uST0cVFDrZeL+t+3NIdS0KxXe9D8+HmT2/GZc5VPfGp8p8eeqBvRnyc6g1ceS
         y8v9TD/8LCeuNrqkNY/zV3t9mhdIQkihABUKj66P8yFQ11FlGQXN8k3ENZw53VqKV/6c
         GxpEHC8OoqfMfOIy1AwazIwj7XwQ7rvWsokPwMtaJ1VB4+r2xY6bdnQ7JPX8/FilD1Dt
         3plA==
X-Gm-Message-State: APjAAAXJyoY+QhCqP5EsSgyqfhJd6bNkKOPQVv+H7NwzjWaku1JEPtAX
        0xd99PPtHlu+a0o2hM1zhyMW5JRLdMenC0qUA2g=
X-Google-Smtp-Source: APXvYqyjDNYRK/s9/BxWAEOavJrJdn2pveXoixy7KR63PBJct6zgL0JmPikVQ1pnvsc/XbBtBVyLkxFPxtoujjrrQEc=
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr23366852iod.139.1561918981319;
 Sun, 30 Jun 2019 11:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190628121338.24398-1-kraxel@redhat.com> <20190628121338.24398-10-kraxel@redhat.com>
In-Reply-To: <20190628121338.24398-10-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 30 Jun 2019 11:22:50 -0700
Message-ID: <CAPaKu7T0fv08oVbyYLcpaHomB0w-ZbF4mKGsgt7ObziQxk3YNQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] drm/virtio: rework virtio_gpu_object_create fencing
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

On Fri, Jun 28, 2019 at 5:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
>
> v5: fix fencing (Chia-I Wu).
> v3: Due to using the gem reservation object it is initialized and ready
> for use before calling ttm_bo_init, so we can also drop the tricky fence
> logic which checks whenever the command is in flight still.  We can
> simply fence our object before submitting the virtio command and be done
> with it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 +
>  drivers/gpu/drm/virtio/virtgpu_object.c | 55 ++++++++++---------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c     |  4 ++
>  3 files changed, 27 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 356d27132388..c4b266b6f731 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -267,6 +267,7 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>                                     struct virtio_gpu_object *bo,
>                                     struct virtio_gpu_object_params *params,
> +                                   struct virtio_gpu_object_array *objs,
>                                     struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>                                    uint32_t resource_id);
> @@ -329,6 +330,7 @@ void
>  virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>                                   struct virtio_gpu_object *bo,
>                                   struct virtio_gpu_object_params *params,
> +                                 struct virtio_gpu_object_array *objs,
>                                   struct virtio_gpu_fence *fence);
>  void virtio_gpu_ctrl_ack(struct virtqueue *vq);
>  void virtio_gpu_cursor_ack(struct virtqueue *vq);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 82bfbf983fd2..fa0ea22c68b0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -97,7 +97,9 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                              struct virtio_gpu_object **bo_ptr,
>                              struct virtio_gpu_fence *fence)
>  {
> +       struct virtio_gpu_object_array *objs = NULL;
>         struct virtio_gpu_object *bo;
> +       struct ww_acquire_ctx ticket;
>         size_t acc_size;
>         int ret;
>
> @@ -123,12 +125,29 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>         }
>         bo->dumb = params->dumb;
>
> +       if (fence) {
> +               objs = virtio_gpu_array_alloc(1);
> +               objs->objs[0] = &bo->gem_base;
> +               drm_gem_object_get(objs->objs[0]);
> +
> +               ret = drm_gem_lock_reservations(objs->objs, objs->nents,
> +                                               &ticket);
We can use virtio_gpu_object_reserve when there is only one object.

> +               if (ret == 0)
> +                       reservation_object_add_excl_fence(objs->objs[0]->resv,
> +                                                         &fence->f);
Similar to in execbuffer, this might need to be moved to after
virtio_gpu_cmd_resource_create_*.
> +       }
> +
>         if (params->virgl) {
> -               virtio_gpu_cmd_resource_create_3d(vgdev, bo, params, fence);
> +               virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
> +                                                 objs, fence);
>         } else {
> -               virtio_gpu_cmd_create_resource(vgdev, bo, params, fence);
> +               virtio_gpu_cmd_create_resource(vgdev, bo, params,
> +                                              objs, fence);
>         }
>
> +       if (fence)
> +               drm_gem_unlock_reservations(objs->objs, objs->nents, &ticket);
objs might have been freed.
> +
>         virtio_gpu_init_ttm_placement(bo);
>         ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
>                           ttm_bo_type_device, &bo->placement, 0,
> @@ -139,38 +158,6 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>         if (ret != 0)
>                 return ret;
>
> -       if (fence) {
> -               struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> -               struct list_head validate_list;
> -               struct ttm_validate_buffer mainbuf;
> -               struct ww_acquire_ctx ticket;
> -               unsigned long irq_flags;
> -               bool signaled;
> -
> -               INIT_LIST_HEAD(&validate_list);
> -               memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
> -
> -               /* use a gem reference since unref list undoes them */
> -               drm_gem_object_get(&bo->gem_base);
> -               mainbuf.bo = &bo->tbo;
> -               list_add(&mainbuf.head, &validate_list);
> -
> -               ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> -               if (ret == 0) {
> -                       spin_lock_irqsave(&drv->lock, irq_flags);
> -                       signaled = virtio_fence_signaled(&fence->f);
> -                       if (!signaled)
> -                               /* virtio create command still in flight */
> -                               ttm_eu_fence_buffer_objects(&ticket, &validate_list,
> -                                                           &fence->f);
> -                       spin_unlock_irqrestore(&drv->lock, irq_flags);
> -                       if (signaled)
> -                               /* virtio create command finished */
> -                               ttm_eu_backoff_reservation(&ticket, &validate_list);
> -               }
> -               virtio_gpu_unref_list(&validate_list);
> -       }
> -
>         *bo_ptr = bo;
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 0c87c3e086f8..0a735e51a803 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -391,6 +391,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>                                     struct virtio_gpu_object *bo,
>                                     struct virtio_gpu_object_params *params,
> +                                   struct virtio_gpu_object_array *objs,
>                                     struct virtio_gpu_fence *fence)
>  {
>         struct virtio_gpu_resource_create_2d *cmd_p;
> @@ -398,6 +399,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>
>         cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>         memset(cmd_p, 0, sizeof(*cmd_p));
> +       vbuf->objs = objs;
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
>         cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> @@ -864,6 +866,7 @@ void
>  virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>                                   struct virtio_gpu_object *bo,
>                                   struct virtio_gpu_object_params *params,
> +                                 struct virtio_gpu_object_array *objs,
>                                   struct virtio_gpu_fence *fence)
>  {
>         struct virtio_gpu_resource_create_3d *cmd_p;
> @@ -871,6 +874,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>
>         cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>         memset(cmd_p, 0, sizeof(*cmd_p));
> +       vbuf->objs = objs;
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D);
>         cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> --
> 2.18.1
>
