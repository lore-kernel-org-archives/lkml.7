Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890482189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/v42Aqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfH1V2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:28:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45227 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1V2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:28:04 -0400
Received: by mail-io1-f68.google.com with SMTP id t3so2466293ioj.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJSmOOGXQE2jhcsJ3xN49XimOe54yldyhDrabvf9aK8=;
        b=k/v42AqaHAf/iP3wyYv0z3pbHwt5b1AktZJOvBGpVZzLU5pAf1sRIix5Q9+UZAHhBP
         ec/9luZcCMy4SV8B3JVvtzJaqGHhfVe5lt/BADb1OE5gs1ObEQ7gdUtQTL6gl7QBNP5R
         KDKVhF0Esxkhid2Ru74RVTOeRLHStIpvI2eJXxKzmfnFpAZL++DyY8q2ZAj9RwHk90Q4
         SpsqUyu9e0pKnIpFr4HHCWpUBea7ACexvG0wSyQs5iIEGVfVK9CxWxuMmMIFAIDavMR1
         W5fcsm23La8kSlSWi9s0zeo9y5Snp3kdgKxisPfuDaZjCkAAp7EP1TxgHYuupkg1/915
         cl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJSmOOGXQE2jhcsJ3xN49XimOe54yldyhDrabvf9aK8=;
        b=naNZHBMQ0cusFj4rO8c61uootjiFTX0k0PFwCjsu9n7UqG3Jg5mCQxvuoaCz6sCHC5
         I0cMDtFVbLTUotOzWS3UUnAA5bqH7GBjjoI48m7KuQsUHWhtceoYRlusWP8JUCIhSCFV
         IDwpTrlAcb5yLQ1vdzVMvmlUM21Y4vJQnXCgPBLj4wMAg8cTF50CWFfGjwH4adqpDX54
         v/9+07lK+aoWkp29E17NPVJdbB4upPGkIQHxJNFp2X1TYIt/ORzr2AArAxLduPffWaKb
         60uxqmy4SWPZf+fNs/ao4IIIkJfzZ4RKvntQzxj+4PHpJEAA27czAZntN7INTJOoN58v
         uPYA==
X-Gm-Message-State: APjAAAUxlduL51vkWJw9pZxgHF7AeKIUdnXNnkndLLx5fVvoKcUkyPKz
        BR5y1WF0VorTWmQIIysDD5MZpct1GBshg1PFq+0=
X-Google-Smtp-Source: APXvYqxkKCeT4BaeHP6brbncMHNHe9V9f4UosnXis3x+V0ZD1tdls9NsC/dLZHd1Qosy/ywgq9p4AsGnl/r013yo7p0=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr1998685ioc.232.1567027683094;
 Wed, 28 Aug 2019 14:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190823095503.2261-1-kraxel@redhat.com> <20190823095503.2261-8-kraxel@redhat.com>
In-Reply-To: <20190823095503.2261-8-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 28 Aug 2019 14:27:52 -0700
Message-ID: <CAPaKu7QbPeSMQGm+37hUVcSMyjjgYTs5YPKLZtoTn_J13WCeVQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/18] drm/virtio: add virtio_gpu_object_array & helpers
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
> Some helper functions to manage an array of gem objects.
>
> v6:
>  - add ticket to struct virtio_gpu_object_array.
>  - add virtio_gpu_array_{lock,unlock}_resv helpers.
>  - add virtio_gpu_array_add_fence helper.
> v5: some small optimizations (Chia-I Wu).
> v4: make them virtio-private instead of generic helpers.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 17 +++++
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 93 ++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index db57bbb36216..b6bd2b1141fb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -84,6 +84,12 @@ struct virtio_gpu_object {
>  #define gem_to_virtio_gpu_obj(gobj) \
>         container_of((gobj), struct virtio_gpu_object, gem_base)
>
> +struct virtio_gpu_object_array {
> +       struct ww_acquire_ctx ticket;
> +       u32 nents, total;
> +       struct drm_gem_object *objs[];
> +};
> +
>  struct virtio_gpu_vbuffer;
>  struct virtio_gpu_device;
>
> @@ -251,6 +257,17 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
>                               struct drm_device *dev,
>                               uint32_t handle, uint64_t *offset_p);
>
> +struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents);
> +struct virtio_gpu_object_array*
> +virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
> +void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
> +                             struct drm_gem_object *obj);
> +int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
> +void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
> +void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
> +                               struct dma_fence *fence);
> +void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
> +
>  /* virtio vg */
>  int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 6fe6f72f64d1..f3799f2e97cb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -171,3 +171,96 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>                                                 qobj->hw_res_handle);
>         virtio_gpu_object_unreserve(qobj);
>  }
> +
> +struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
> +{
> +       struct virtio_gpu_object_array *objs;
> +       size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
> +
> +       objs = kmalloc(size, GFP_KERNEL);
> +       if (!objs)
> +               return NULL;
> +
> +       objs->nents = 0;
> +       objs->total = nents;
> +       return objs;
> +}
> +
> +static void virtio_gpu_array_free(struct virtio_gpu_object_array *objs)
> +{
> +       kfree(objs);
> +}
> +
> +struct virtio_gpu_object_array*
> +virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
> +{
> +       struct virtio_gpu_object_array *objs;
> +       u32 i;
> +
> +       objs = virtio_gpu_array_alloc(nents);
> +       if (!objs)
> +               return NULL;
> +
> +       for (i = 0; i < nents; i++) {
> +               objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
> +               if (!objs->objs[i]) {
> +                       objs->nents = i;
> +                       virtio_gpu_array_put_free(objs);
> +                       return NULL;
> +               }
> +       }
> +       objs->nents = i;
> +       return objs;
> +}
> +
> +void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
> +                             struct drm_gem_object *obj)
> +{
> +       if (WARN_ON_ONCE(objs->nents == objs->total))
> +               return;
> +
> +       drm_gem_object_get(obj);
> +       objs->objs[objs->nents] = obj;
> +       objs->nents++;
> +}
> +
> +int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
> +{
> +       int ret;
> +
> +       if (objs->nents == 1) {
> +               ret = dma_resv_lock(objs->objs[0]->resv, NULL);
dma_resv_lock_interruptible to match what drm_gem_lock_reservations uses.
> +       } else {
> +               ret = drm_gem_lock_reservations(objs->objs, objs->nents,
> +                                               &objs->ticket);
> +       }
> +       return ret;
> +}
> +
> +void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
> +{
> +       if (objs->nents == 1) {
> +               dma_resv_unlock(objs->objs[0]->resv);
> +       } else {
> +               drm_gem_unlock_reservations(objs->objs, objs->nents,
> +                                           &objs->ticket);
> +       }
> +}
> +
> +void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
> +                               struct dma_fence *fence)
> +{
> +       int i;
> +
> +       for (i = 0; i < objs->nents; i++)
> +               dma_resv_add_excl_fence(objs->objs[i]->resv, fence);
> +}
> +
> +void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < objs->nents; i++)
> +               drm_gem_object_put_unlocked(objs->objs[i]);
> +       virtio_gpu_array_free(objs);
> +}
> --
> 2.18.1
>
