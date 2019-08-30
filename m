Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC5C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4762342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nENiS/Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfH3QTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:19:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35845 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfH3QTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:19:04 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so15181591iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1VMMJco1uH+7gtFzOB5by83AjJIvFL4o3Apj5/YJNA=;
        b=nENiS/VyEXHRx025qwtDHC7B40vtQACA9DwtXk0kv/9FwF3AeOgBJkq77x6jvmFvjs
         bzYNPzc77nwvLjvFPgWyFkX65UjwnlXMJLH6pO+I70ZfO3Z0KxkH8jWuB74LYSwacHt/
         2YfBOcJEPhu38TtqAUMXbf26f0dhW3qrFMyZqlsXfSpc4JJv0+uFiQIXZpVVmk9fdhll
         kR1Y6Ba8jCK+zD7ytmPJ7xj3Y+8Tr34tYJbXXyTLWsoAH99ow9nUzlfDM8GsCLuNII+0
         2+5adZQysZ7Tsjp0lDwyhA7VflExbg89vt+28XZVguYweHu6usRoe+RgfuyorRroZzNz
         377A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1VMMJco1uH+7gtFzOB5by83AjJIvFL4o3Apj5/YJNA=;
        b=X69/P5jZVsC127/VvblnuYNUXUpvJLbWkqB83NJ2E36HrC2+/90W7EVyS9O/0v6iKv
         hIvm3GnllZfm1TXcSv5R8tE8XApkD2B9HK72KG6m6SXv7WxLXaTKYs+r/hDHy6zaJG82
         jQKh5A0g/sdxDs1r4BPK5G7vnX/OqI3zYv4cVOSL8e+I7Yt7AVyR1J2q1uD1rvTDNAXX
         4lfEGvCDgDZ06uJCKExIcHDEzCLLMCtR52Pn62NYoFrR3z1lGzHbbYJQ5xJPN82L8FW3
         lbdqXDofIOqlgzQm45pQsXAk2pzuW1oX9LPOitXHmjveipYjjE6/O9L93xJB/y6qTpJ7
         onUg==
X-Gm-Message-State: APjAAAWSt87wsoRtX5mKRO7HpdtNKJxT10OX+eD0VshL0j5CGKA2MXMF
        oGYP7ZNr89GWePYsJAaVK5rJ2A4QPKeQfDxcod2n5w==
X-Google-Smtp-Source: APXvYqznvBs3CPYadMdSVgMstRD/pTLJfgKeJkhXf83rAqLkjY03PW4FaWCTI+kNt47Vz4JhZouA4qHik7exlVpZG9s=
X-Received: by 2002:a6b:db0e:: with SMTP id t14mr14719253ioc.93.1567181943233;
 Fri, 30 Aug 2019 09:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 30 Aug 2019 09:18:52 -0700
Message-ID: <CAPaKu7SmqNLNDNNZr7c7gEi+ypAKdXJ3z5oYZFppk+53rsTygA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
To:     David Riley <davidriley@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 2:24 PM David Riley <davidriley@chromium.org> wrote:
>
> Userspace requested command buffer allocations could be too large
> to make as a contiguous allocation.  Use vmalloc if necessary to
> satisfy those allocations.
>
> Signed-off-by: David Riley <davidriley@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  4 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 74 ++++++++++++++++++++++++--
>  2 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index ac60be9b5c19..a8732a8af766 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -195,7 +195,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         if (ret)
>                 goto out_free;
>
> -       buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
> +       buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
>         if (IS_ERR(buf)) {
>                 ret = PTR_ERR(buf);
>                 goto out_unresv;
> @@ -230,7 +230,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         return 0;
>
>  out_memdup:
> -       kfree(buf);
> +       kvfree(buf);
>  out_unresv:
>         ttm_eu_backoff_reservation(&ticket, &validate_list);
>  out_free:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 981ee16e3ee9..bcbc48b7284f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -154,7 +154,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
>  {
>         if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
>                 kfree(vbuf->resp_buf);
> -       kfree(vbuf->data_buf);
> +       kvfree(vbuf->data_buf);
>         kmem_cache_free(vgdev->vbufs, vbuf);
>  }
>
> @@ -251,6 +251,59 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
>         wake_up(&vgdev->cursorq.ack_queue);
>  }
>
> +/* How many bytes left in this page. */
> +static unsigned int rest_of_page(void *data)
> +{
> +       return PAGE_SIZE - offset_in_page(data);
> +}
> +
> +/* Create sg_table from a vmalloc'd buffer. */
> +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size)
> +{
> +       int nents, ret, s, i;
> +       struct sg_table *sgt;
> +       struct scatterlist *sg;
> +       struct page *pg;
> +
> +       sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> +       if (!sgt)
> +               return NULL;
> +
> +       nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
> +       ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> +       if (ret) {
> +               kfree(sgt);
> +               return NULL;
> +       }
> +
> +       for_each_sg(sgt->sgl, sg, nents, i) {
> +               pg = vmalloc_to_page(data);
> +               if (!pg) {
> +                       sg_free_table(sgt);
> +                       kfree(sgt);
> +                       return NULL;
> +               }
> +
> +               s = rest_of_page(data);
> +               if (s > size)
> +                       s = size;
> +
> +               sg_set_page(sg, pg, s, offset_in_page(data));
> +
> +               size -= s;
> +               data += s;
> +
> +               if (size) {
> +                       sg_unmark_end(sg);
> +               } else {
> +                       sg_mark_end(sg);
> +                       break;
> +               }
> +       }
> +
> +       return sgt;
> +}
> +
>  static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                                                struct virtio_gpu_vbuffer *vbuf)
>                 __releases(&vgdev->ctrlq.qlock)
> @@ -260,6 +313,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>         struct scatterlist *sgs[3], vcmd, vout, vresp;
>         int outcnt = 0, incnt = 0;
>         int ret;
> +       struct sg_table *sgt = NULL;
>
>         if (!vgdev->vqs_ready)
>                 return -ENODEV;
> @@ -269,8 +323,17 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>         outcnt++;
>
>         if (vbuf->data_size) {
> -               sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
> -               sgs[outcnt + incnt] = &vout;
> +               if (is_vmalloc_addr(vbuf->data_buf)) {
> +                       spin_unlock(&vgdev->ctrlq.qlock);
> +                       sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size);
> +                       spin_lock(&vgdev->ctrlq.qlock);
> +                       if (!sgt)
> +                               return -ENOMEM;
> +                       sgs[outcnt + incnt] = sgt->sgl;
If the construction of sgs is no longer atomic, it should be moved out
of the critical section.
> +               } else {
> +                       sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
> +                       sgs[outcnt + incnt] = &vout;
> +               }
>                 outcnt++;
>         }
>
> @@ -294,6 +357,11 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                 virtqueue_kick(vq);
>         }
>
> +       if (sgt) {
> +               sg_free_table(sgt);
> +               kfree(sgt);
> +       }
> +
>         if (!ret)
>                 ret = vq->num_free;
>         return ret;
> --
> 2.23.0.187.g17f5b7556c-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
