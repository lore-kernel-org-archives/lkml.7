Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7DA21726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWXBSs+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIDXKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:10:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32826 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIDXKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:10:42 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so403275ioo.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB1rbzm8PF8Bwfs8Jp/tKsNhJPofsXR23GDzMzgP/Zo=;
        b=TWXBSs+rssh2KOR8Br4xQVWj2yPdts1caiQ8YeGZCkLygQUi3QXTp7bXtG8avLPfoY
         FU0qWwBUSFqJQ11YlGcYAyCc1LuOHBkMXnenhqK6bcrkpT40+xQVdSKLzHma7+CFHsNH
         DZE2H4wNyGmxrNjxgvrV/PEFzx79oncEEh/D3bItyY1amR4GCh4qqWlRADRT5zCrS1xz
         v9RL7oWNP1ZGT3CoxK7EoA/Xh83edIeMEIwa2Q5LX2O+a5xbwE8I0aEm9ioQHvqkHV6F
         cx90+SxExNmT98lEpdrmmEC1UE3oSt/btorqGtDplYJGoFnrKoF6bjyDNR9WrI8DSxLl
         l/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB1rbzm8PF8Bwfs8Jp/tKsNhJPofsXR23GDzMzgP/Zo=;
        b=nSlGclLHSgYBX1bn+O28BONuJU56YE01zzpeQhTPjL5UUa9dXjMbGrdewflJi7tATk
         W2W722khCCLZcGQdCY6uGzOQp43ihXedXr36khI96XNrxCxibggVB/KW5paMkh4rblJt
         iROYlK6gPX2xAAjb3gK6tL9Y3GThZPxMypl+D55bx30QiUC7HJtdyPOLsxULj6AeyTwb
         QteRUqffWueDhROdt/dnoi5hXK+Qpagb6lf5uZ95rMBD1elQQ+0LaWvnilBKilskJ913
         9Ja885f39Zo8VYG2Xm4qBG5skHLXuATt4bwK23UPUFw4xHYPYZWgutizXQsWA15kP2ow
         6FkQ==
X-Gm-Message-State: APjAAAVgWDgXH9RxA0ykke5rz+YOg6bcs2IYc3rKlpSdqhIf5zAZkHIt
        bN0c9fTFcJlDku1E0dbvDS2l7z8DEyvP21hY+w2Z1g==
X-Google-Smtp-Source: APXvYqy0jYg/Z8XA/MeoEAwnqZjsjs0eFej+KYg1PPMJWO6JB9B1AVaOVDMkjRWEP7D3sv6xexnbd1n0FFsKarY4fh4=
X-Received: by 2002:a6b:db0e:: with SMTP id t14mr546846ioc.93.1567638641383;
 Wed, 04 Sep 2019 16:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190904074828.32502-1-kraxel@redhat.com>
In-Reply-To: <20190904074828.32502-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 4 Sep 2019 16:10:30 -0700
Message-ID: <CAPaKu7RWiEr5n_DWcg0H2PPnRs9CUn-ZgQV3NYe8VrdZgEAhTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix command submission with objects but
 without fence.
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

On Wed, Sep 4, 2019 at 12:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Only call virtio_gpu_array_add_fence if we actually have a fence.
>
> Fixes: da758d51968a ("drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 595fa6ec2d58..7fd2851f7b97 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -339,11 +339,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                 goto again;
>         }
>
> -       if (fence)
> +       if (fence) {
>                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> -       if (vbuf->objs) {
> -               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> -               virtio_gpu_array_unlock_resv(vbuf->objs);
> +               if (vbuf->objs) {
> +                       virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> +                       virtio_gpu_array_unlock_resv(vbuf->objs);
> +               }
This leaks when fence == NULL and vbuf->objs != NULL (which can really
happen IIRC... not at my desk to check).


>         }
>         notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> --
> 2.18.1
>
