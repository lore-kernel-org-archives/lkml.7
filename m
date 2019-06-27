Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99C5C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB39217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKGxxlrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfF0BdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:33:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36437 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF0BdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:33:10 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so1121818ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 18:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZogRr2EBu+1m923ifEoDqvQCpyj7+EI0wqHn3aRB44=;
        b=cKGxxlrP+ukoth4289HEWH7g9Ws3BMTPxYjebaKo0dY1w2lBNYYa2MBC0kxcaUhM7m
         RKq2bLZHCWXGYVmaxQju0LpWt4taKscNRB/xRspide7269gs1sfkvvI5+1NoovIfrX7T
         2kBZnXsVbx9IbKbJYnZIlrYq9EJwiiRh78i+djCESrvTEvhQCNrjVsVkeaz5cBvNmiXZ
         wPOzQaxshY2diBQQCyxfDCpAtepal5pdOrrMrRlVyw9iRwc3gRqVVb92mdiaPQgrlNyo
         SQtwlScIEOP+kj3VoaZXi+viTUHuEU0KClbyyrW9q7P5Y1ZG5HB2EcYCT5F5Wee19Z9B
         JGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZogRr2EBu+1m923ifEoDqvQCpyj7+EI0wqHn3aRB44=;
        b=UoIbRNn9U1Hst8B9xgHHL/UMzrCdsICIgYAPdJjZnlFpvNRp6hdw601uIoXsdDs4l7
         t5fjcbjqBGXn1wh6lCt+h1Dt6Qt6TJAflv/ngrQL5mPnYAjUPcaCoFJ3D6fVkXXID9VQ
         ZNH9YeebXc0OOYQ5qsxB0+ST3i/ZmQQesVzpIyXE0Na7fIKLpM4kQ+75Yyu5YSvyIfFE
         H7VeXQDdPpzTTU3uXmtcFu15cvDo4CNFUaH5Bp7Nv3rU9pt5XnUwOT2D1XbA5mt974Bb
         YKW24wQ5O/W1R3upftKAdkmbYhb5lO5jrDG1l/G58W/PIatbw56ET4x66Lnd6LPqYnR2
         2ElQ==
X-Gm-Message-State: APjAAAXLPSin5r7HFUntesinZ6CrWUHtmU6UuD212LKOK7hK0YitJ4bs
        Mw0nLU2hQihTZqn3o0CbyrcqVPMi9btHmmx0Gzo=
X-Google-Smtp-Source: APXvYqzXlkQi43eEmZx4veNTJdbtZaN7YI/bz8RMmLtiro9vL8rNPdnc0Z+aO0Vl7GivKmo8XkncLttYWM7k5u/owfA=
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr1515842iot.200.1561599188807;
 Wed, 26 Jun 2019 18:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-9-kraxel@redhat.com>
In-Reply-To: <20190620060726.926-9-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 26 Jun 2019 18:32:57 -0700
Message-ID: <CAPaKu7QjuKMJfhTVOzBsUb8cT9cGgesG_-skQeBO8hL8UqcAzw@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
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

On Wed, Jun 19, 2019 at 11:08 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
>
> v3: Also attach the array of gem objects to the virtio command buffer,
> so we can drop the object references in the completion callback.  Needed
> because ttm fence helpers grab a reference for us, but gem helpers
> don't.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  5 ++-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 62 +++++++++++---------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 16 ++++---
>  3 files changed, 40 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 98d646789d23..65f5ce41c341 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -120,9 +120,9 @@ struct virtio_gpu_vbuffer {
>
>         char *resp_buf;
>         int resp_size;
> -
>         virtio_gpu_resp_cb resp_cb;
>
> +       struct virtio_gpu_object_array *objs;
This can use a comment (e.g., objects referenced by the vbuffer)
>         struct list_head list;
>  };
>
> @@ -311,7 +311,8 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
>                                             uint32_t resource_id);
>  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            void *data, uint32_t data_size,
> -                          uint32_t ctx_id, struct virtio_gpu_fence *fence);
> +                          uint32_t ctx_id, struct virtio_gpu_fence *fence,
> +                          struct virtio_gpu_object_array *objs);
Can we keep fence, which is updated, as the last parameter?
>  void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
>                                           uint32_t resource_id, uint32_t ctx_id,
>                                           uint64_t offset, uint32_t level,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 5cffd2e54c04..c3901c397b8a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -105,14 +105,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct drm_virtgpu_execbuffer *exbuf = data;
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
> -       struct drm_gem_object *gobj;
>         struct virtio_gpu_fence *out_fence;
> -       struct virtio_gpu_object *qobj;
>         int ret;
>         uint32_t *bo_handles = NULL;
>         void __user *user_bo_handles = NULL;
> -       struct list_head validate_list;
> -       struct ttm_validate_buffer *buflist = NULL;
> +       struct virtio_gpu_object_array *buflist = NULL;
>         int i;
>         struct ww_acquire_ctx ticket;
>         struct sync_file *sync_file;
> @@ -155,15 +152,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                         return out_fence_fd;
>         }
>
> -       INIT_LIST_HEAD(&validate_list);
>         if (exbuf->num_bo_handles) {
> -
>                 bo_handles = kvmalloc_array(exbuf->num_bo_handles,
> -                                          sizeof(uint32_t), GFP_KERNEL);
> -               buflist = kvmalloc_array(exbuf->num_bo_handles,
> -                                          sizeof(struct ttm_validate_buffer),
> -                                          GFP_KERNEL | __GFP_ZERO);
> -               if (!bo_handles || !buflist) {
> +                                           sizeof(uint32_t), GFP_KERNEL);
> +               if (!bo_handles) {
>                         ret = -ENOMEM;
>                         goto out_unused_fd;
>                 }
> @@ -175,25 +167,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                         goto out_unused_fd;
>                 }
>
> -               for (i = 0; i < exbuf->num_bo_handles; i++) {
> -                       gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
> -                       if (!gobj) {
> -                               ret = -ENOENT;
> -                               goto out_unused_fd;
> -                       }
> -
> -                       qobj = gem_to_virtio_gpu_obj(gobj);
> -                       buflist[i].bo = &qobj->tbo;
> -
> -                       list_add(&buflist[i].head, &validate_list);
> +               buflist = virtio_gpu_array_from_handles(drm_file, bo_handles,
> +                                                       exbuf->num_bo_handles);
> +               if (!buflist) {
> +                       ret = -ENOENT;
> +                       goto out_unused_fd;
>                 }
>                 kvfree(bo_handles);
>                 bo_handles = NULL;
>         }
>
> -       ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> -       if (ret)
> -               goto out_free;
> +       if (buflist) {
> +               ret = drm_gem_lock_reservations(buflist->objs, buflist->nents,
> +                                               &ticket);
> +               if (ret)
> +                       goto out_unused_fd;
> +       }
>
>         buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
>         if (IS_ERR(buf)) {
> @@ -219,25 +208,26 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 fd_install(out_fence_fd, sync_file->file);
>         }
>
> +       if (buflist) {
> +               for (i = 0; i < exbuf->num_bo_handles; i++)
> +                       reservation_object_add_excl_fence(buflist->objs[i]->resv,
> +                                                         &out_fence->f);
> +               drm_gem_unlock_reservations(buflist->objs, buflist->nents,
> +                                           &ticket);
> +       }
We used to unlock after virtio_gpu_cmd_submit.

I guess, the fence is considered signaled (because its seqno is still
0) until after virtio_gpu_cmd_submit.  We probably don't want other
processes to see the semi-initialized fence.


> +
>         virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
> -                             vfpriv->ctx_id, out_fence);
> -
> -       ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
> -
> -       /* fence the command bo */
> -       virtio_gpu_unref_list(&validate_list);
> -       kvfree(buflist);
> +                             vfpriv->ctx_id, out_fence, buflist);
>         return 0;
>
>  out_memdup:
>         kfree(buf);
>  out_unresv:
> -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> -out_free:
> -       virtio_gpu_unref_list(&validate_list);
Keeping out_free to free buflist seems just fine.
> +       drm_gem_unlock_reservations(buflist->objs, buflist->nents, &ticket);
>  out_unused_fd:
>         kvfree(bo_handles);
> -       kvfree(buflist);
> +       if (buflist)
> +               virtio_gpu_array_put_free(buflist);
>
>         if (out_fence_fd >= 0)
>                 put_unused_fd(out_fence_fd);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 6c1a90717535..dc2c2c003200 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -191,7 +191,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>         } while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
>         spin_unlock(&vgdev->ctrlq.qlock);
>
> -       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> +       list_for_each_entry(entry, &reclaim_list, list) {
>                 resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
>
>                 trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
> @@ -218,14 +218,18 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>                 }
>                 if (entry->resp_cb)
>                         entry->resp_cb(vgdev, entry);
> -
> -               list_del(&entry->list);
> -               free_vbuf(vgdev, entry);
>         }
>         wake_up(&vgdev->ctrlq.ack_queue);
>
>         if (fence_id)
>                 virtio_gpu_fence_event_process(vgdev, fence_id);
> +
> +       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> +               if (entry->objs)
> +                       virtio_gpu_array_put_free(entry->objs);
> +               list_del(&entry->list);
We are clearing the list.  I guess list_del is not needed.
> +               free_vbuf(vgdev, entry);
> +       }
>  }
>
>  void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
> @@ -939,7 +943,8 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
>
>  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            void *data, uint32_t data_size,
> -                          uint32_t ctx_id, struct virtio_gpu_fence *fence)
> +                          uint32_t ctx_id, struct virtio_gpu_fence *fence,
> +                          struct virtio_gpu_object_array *objs)
>  {
>         struct virtio_gpu_cmd_submit *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
> @@ -949,6 +954,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>
>         vbuf->data_buf = data;
>         vbuf->data_size = data_size;
> +       vbuf->objs = objs;
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_SUBMIT_3D);
>         cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
