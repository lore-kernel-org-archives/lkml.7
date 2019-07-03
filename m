Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F8FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9394A2184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKihlh6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:02:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46264 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:02:44 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so6837529iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lGD5x0fixG7eCvn8wfznKG3XFZqIHDTN6YyrwUc2rM=;
        b=iKihlh6l1s6aC19KE31uBgziYsN9WXu+n6WlT9ZjzAHZ4SVHuBCDBhXOhvNAUqbZLT
         pRP80Lx1QFP2fg+pVhGmPiywK1bO3kKIVCxpp3ZKimuVdwbgsVkYrVgbSmOaBdiq88fC
         RGWeOE8MZFeEK8+FVZQgxWtYLP3lJYZhamHU6FTY32RqlOKiS1bM5q2UBnihIw8c6Pjy
         jHXVACNS232kKnLp2EeKqun+mQ5GWmNbF4WDKIH8HmG3v3pn0KkFDvk1b14AJBK2MQxw
         PxbHNwmDw87GzLgazKKbKTol2ZUxNaSLS1C6NYyegJE6QRDjgTF3QwY1zDW0WCv5eRHS
         FGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lGD5x0fixG7eCvn8wfznKG3XFZqIHDTN6YyrwUc2rM=;
        b=JUWP1y8Mv+KCHz0SRN5UpnzBxMqgln6C5uXcD2lLEH56OKhLh+aBaf1V5VdO1DSGqS
         O6l0yqPAXSUnKNURj2C7WQi7oGnNhpW/7m66r4nxFYhMeMqU8V0Yw4KMmH9YdT03JqVR
         9f2dPDbdVgX65isGY8cfsx5z3EhFQ5r7KgJDncIgsY6w0PZbYeSyL5ScHRYWdR7NDWuX
         hb7fTd1FB/OLkgiRbbHA4GtwkXjUs6sLSbJXRfObmSm9HjX+WO1ZwdGb0UxiEAeanX25
         PQCYldCRxw1ccxnLldt5dzAxJfgMj4TNCTz/fp+jp5SMXxVZ+Qop5oyOZ5Wy4VmnZUja
         ZDSg==
X-Gm-Message-State: APjAAAXdXH3Ky0gfKUAuqqp//O/NZ6DG1km83E+dVL9mfgGti5dxP6K/
        fikIsJX0g/Y1dihFymncKoeKSjTEQliZIvxLtj4=
X-Google-Smtp-Source: APXvYqwtsJYFM4tLDw4ftXCfYIpH9Xg25kh7AlfCvOCOFJ7kerq8S60yd5DQ+VmMExC39g3dDiCVCaM4o7CoCuOlUPI=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr38048015ios.84.1562176964009;
 Wed, 03 Jul 2019 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-7-kraxel@redhat.com>
In-Reply-To: <20190702141903.1131-7-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 3 Jul 2019 11:02:33 -0700
Message-ID: <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in virtio_gpu_object_{reserve,unreserve}
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
> Call reservation_object_* directly instead
> of using ttm_bo_{reserve,unreserve}.
>
> v4: check for EINTR only.
> v3: check for EINTR too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 06cc0e961df6..07f6001ea91e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -402,9 +402,9 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>         int r;
>
> -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
Can you elaborate a bit about how TTM keeps the BOs alive in, for
example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
ttm_bo_unreserve.  I am curious how they keep the BO alive.

>         if (unlikely(r != 0)) {
> -               if (r != -ERESTARTSYS) {
> +               if (r != -EINTR) {
>                         struct virtio_gpu_device *qdev =
>                                 bo->gem_base.dev->dev_private;
>                         dev_err(qdev->dev, "%p reserve failed\n", bo);
> @@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>
>  static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
>  {
> -       ttm_bo_unreserve(&bo->tbo);
> +       reservation_object_unlock(bo->gem_base.resv);
>  }
>
>  /* virgl debufs */
> --
> 2.18.1
>
