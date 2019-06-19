Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1848C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BF521479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TG/JK0xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfFSKzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:55:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45267 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:55:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so26501363edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdKjQFlqc/Q5NG+TosVNuzBQ5q1pFNnMu9irob0Brm0=;
        b=TG/JK0xKXjriwqgBw8cF41pSSLLme+TnHnULLKVFltVObM+DBW7ii5OQBU587ewcUL
         CekLOuXDtRbkH2jrQPgPrFxp6hh5nzpM/EndSk/C4/eNmNj/3t3FnYKFGwkks9eDwAWb
         XBruiYUUm9LC06kmZZ3Nc6S8HcC7B1c6XJ+ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XdKjQFlqc/Q5NG+TosVNuzBQ5q1pFNnMu9irob0Brm0=;
        b=U5C5c+MGglyAav4yqFa5SUS6TbGTBfvKgGCeLv6Odwpkium09C7w2bUSZncDUUfbGy
         xD4E6GDe08a4l3/6hQw1obn5OFSPW3AsuoZH8A6wdMRsFEOfRz4rQDymAOCyN3ngI2OP
         TQ0DK+RzP/npGL70Cpa9Y5temeieQsdaWa6r/3ajrFI1vFNv3uzih8R7vvJyErSvuAPf
         Grgk6ycjBMAz9pr+qGR6GzPHU83OwnlkWE8eUXPJjNfUovL2x8dFh21spJ4a0bTfcn/5
         fRokxzcPxSWWSCLQVyL11ZXCYpxXUNXXjPqjXKAh43s8ocZQeQK6d4XBdq4nbsOlHFyX
         qzSA==
X-Gm-Message-State: APjAAAXYS6bUVaxEOLsWJD4nEKfY9gTrNhOL6k+iR+gcVESy6k3bxSZV
        ClTgNC8+gbgCJgjT4a+S5PB7vg==
X-Google-Smtp-Source: APXvYqxbjH7iT/XwqoXc7vNkC8vrzVel8iukb4rPT+Y5xARzuliTDpYTj3ZbNZYgkEs3Hvc6tZtY2A==
X-Received: by 2002:a05:6402:6cb:: with SMTP id n11mr17462574edy.101.1560941748065;
        Wed, 19 Jun 2019 03:55:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l50sm5687128edb.77.2019.06.19.03.55.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:55:47 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:55:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/12] drm/virtio: drop no_wait argument from
 virtio_gpu_object_reserve
Message-ID: <20190619105543.GN12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-7-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:04:14AM +0200, Gerd Hoffmann wrote:
> All callers pass no_wait = false.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 5 ++---
>  drivers/gpu/drm/virtio/virtgpu_gem.c   | 4 ++--
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 2cd96256ba37..06cc0e961df6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -398,12 +398,11 @@ static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
>  	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
>  }
>  
> -static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo,
> -					 bool no_wait)
> +static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>  	int r;
>  
> -	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
> +	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
>  	if (unlikely(r != 0)) {
>  		if (r != -ERESTARTSYS) {
>  			struct virtio_gpu_device *qdev =
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 1e49e08dd545..9c9ad3b14080 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -140,7 +140,7 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return 0;
>  
> -	r = virtio_gpu_object_reserve(qobj, false);
> +	r = virtio_gpu_object_reserve(qobj);
>  	if (r)
>  		return r;
>  
> @@ -161,7 +161,7 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;
>  
> -	r = virtio_gpu_object_reserve(qobj, false);
> +	r = virtio_gpu_object_reserve(qobj);
>  	if (r)
>  		return;
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 313c770ea2c5..5cffd2e54c04 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -375,7 +375,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>  
>  	qobj = gem_to_virtio_gpu_obj(gobj);
>  
> -	ret = virtio_gpu_object_reserve(qobj, false);
> +	ret = virtio_gpu_object_reserve(qobj);
>  	if (ret)
>  		goto out;
>  
> @@ -425,7 +425,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
>  
>  	qobj = gem_to_virtio_gpu_obj(gobj);
>  
> -	ret = virtio_gpu_object_reserve(qobj, false);
> +	ret = virtio_gpu_object_reserve(qobj);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
