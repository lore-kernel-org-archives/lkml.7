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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77D20665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beyZvOpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfF0AtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:49:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36727 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfF0AtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:49:18 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so945415ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnuQP7CTcbJye7wkfnNka2bWrrxEpDeN1sGJnHRjqmw=;
        b=beyZvOpIoSnCiVUg3YQYCGXioF/dyxle9eDYc/zWVKmJCbs27jCH009EwTbRKHLTou
         cVQhkKfw0ZS43zSlmtqoFOoQ2oxY/xV6BXq7e9uT98Fag+EEx17DrFjsNGQKlTY7zczB
         3njyfFCt8K+Z4uBOJHEv02y2R21GVOsUeD+xk4Ny5/Dt2CZ8bs2s5SdBf00OQIJTsTrw
         /7RqtCzM+S8vEz99lQul2d9fheRAQucnLsy4i5eWDhwWYo47zbuZBFpcQF2cFQrFBaus
         1LFkn9tcjwldGgIW3KJtGM//tMgEt9bkTuGP6/6eQexPpO+V7QEp/PR28DJAjKr6sKq0
         PwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnuQP7CTcbJye7wkfnNka2bWrrxEpDeN1sGJnHRjqmw=;
        b=WcMjB4NiZOU2pKyZy9nrpAqLO04Sae5ZBQTZIQDihDIqEgFD4iGQElYOx5S7aTUndU
         Yo/tEP7FE+z5mruzXUSVLy/vZhrDkVJpJLbv+q2DY/EVh6YvzX5WJOgBTKSK9OSHo5zu
         0IBKhDiL3oY+yapOU6SSbHbEJrG79Zn8HPjbhM6dDFQLdcgFtVSrhFZuY/1u2JO3H/sh
         NV0b/a5+mguduIvrL6kK/G9qH07hlJ2HfLVcdtRUOYQyI5x9hPJcrVO2JndFDimH/HAt
         Do5gGdD2xMKOC7ca/WniOjoEoFDKI4IzE2fwbRFKmy0kxpao2JErvn7z3I8jXWJ0FthK
         +f3A==
X-Gm-Message-State: APjAAAUs7S14/mEOykuC9xTtm2vBMdsDy4bg87us+BP7C05qMMY16zAi
        QM7ggJoL6+2lfXzKVMuUbGqOqEeJX3pkcMOJRzRNPDc3
X-Google-Smtp-Source: APXvYqzVlHJw5tL36/rn9Qjl/0Q9Vf2GB+usOUX6IiDa54+5zwayzncbpLfYPkKaUkSvv1Vo6TLxRYG5GYVer4iwUEQ=
X-Received: by 2002:a6b:9257:: with SMTP id u84mr1277575iod.278.1561596557688;
 Wed, 26 Jun 2019 17:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-8-kraxel@redhat.com>
In-Reply-To: <20190620060726.926-8-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 26 Jun 2019 17:49:06 -0700
Message-ID: <CAPaKu7RwVC3p=K0gxy=NfJaCJd_RkRc1vCKH4e7oS8rn-6wyOQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] drm/virtio: add virtio_gpu_object_array & helpers
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
> Some helper functions to manage an array of gem objects.
>
> v4: make them virtio-private instead of generic helpers.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 50 ++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 07f6001ea91e..98d646789d23 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -84,6 +84,11 @@ struct virtio_gpu_object {
>  #define gem_to_virtio_gpu_obj(gobj) \
>         container_of((gobj), struct virtio_gpu_object, gem_base)
>
> +struct virtio_gpu_object_array {
> +       u32 nents;
> +       struct drm_gem_object *objs[];
> +};
> +
>  struct virtio_gpu_vbuffer;
>  struct virtio_gpu_device;
>
> @@ -251,6 +256,11 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
>                               struct drm_device *dev,
>                               uint32_t handle, uint64_t *offset_p);
>
> +struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents);
> +struct virtio_gpu_object_array*
> +virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
> +void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
> +
>  /* virtio vg */
>  int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 9c9ad3b14080..456cc382ce68 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -169,3 +169,53 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>                                                 qobj->hw_res_handle);
>         virtio_gpu_object_unreserve(qobj);
>  }
> +
> +struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
> +{
> +       struct virtio_gpu_object_array *objs;
> +       size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
> +
> +       objs = kzalloc(size, GFP_KERNEL);
It seems unlikely to get wrong.  Use kmalloc instead?
> +       if (!objs)
> +               return NULL;
> +
> +       objs->nents = nents;
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
> +                       virtio_gpu_array_put_free(objs);
Set objs->nents to i before calling i915_gem_object_lookup;
> +                       return NULL;
Should we distinguish ENOMEM and ENOENT?
> +               }
> +       }
> +       return objs;
> +}
> +
> +void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < objs->nents; i++) {
> +               if (!objs->objs[i])
> +                       continue;
The check can be removed if the change in virtio_gpu_array_from_handles.
> +               drm_gem_object_put_unlocked(objs->objs[i]);
> +       }
> +       virtio_gpu_array_free(objs);
> +}
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
