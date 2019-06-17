Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651FC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFF920833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QXZd0Hes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfFQOS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:18:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42087 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:18:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so16387787edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=255cRppfmUAELVuEBOpb3q7EnIYgii6r3uBAfeCWFHg=;
        b=QXZd0Hes9umi74jp07G814dRb7D+MKScfq/PvUjRyLM3zoC9fLVKkvWV5netvsA25k
         NUIsYDd14TDgOSfnvPb2WwyUPm83bP8nmQLJSaq/NYP2ZdXgIcMHoCO2X22RiLjgNXAc
         VYe43lVvPYBw1dig7MLt4yFnORiY0r9qeYQAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=255cRppfmUAELVuEBOpb3q7EnIYgii6r3uBAfeCWFHg=;
        b=nqsYoXUuKvM11ZKGOFXSksa2GxSWV9ONMgeEA/T7R3rGcQzDj7wF4EQJ4s2d9NG6ix
         bLxKDZ/cXzOwln4nhZOv7jcRnTHMgmlDhjbVQ+3NvXGn9sWFZ5YepYu+asylEoJj5HZI
         9DnXpJAbQZ8795puDgMi+ztXSNRp4KkSxt+lNBjrFJxWFjajRDMk84UFUQP8NVjJWYgd
         NyOwbRRrVHgP6dIWsU4NCylS05kFphhKge6hv+VMjXHMT4/MZjTu0WDOptZ5YPvr6zgx
         Y8uxHMy9T+kE21WRMCl4F1Y2A3F8JwchJahen1+96Znjq/7BMwBJoYiwZafC2LvCJO27
         nM6A==
X-Gm-Message-State: APjAAAXVnWiPY4l4OUoeWR8mN1LYT3fDyCwQGZT1j1JCBPSOUNky5Wbi
        5krqKd0DmePWwDByycC6i2/qfA==
X-Google-Smtp-Source: APXvYqxDQv3y3Qn61R/NUrw/NJLZtfJcmIB9+oQ+MQzul0tqmu/Xxh75ou9bVBEZdpcSUMhFOByM5g==
X-Received: by 2002:a17:906:644c:: with SMTP id l12mr45333686ejn.199.1560781102836;
        Mon, 17 Jun 2019 07:18:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f3sm2186344ejc.15.2019.06.17.07.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:18:21 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:18:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/virtio: remove virtio_gpu_object_wait
Message-ID: <20190617141819.GH12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:14:06PM +0200, Gerd Hoffmann wrote:
> No users left.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  1 -
>  drivers/gpu/drm/virtio/virtgpu_object.c | 13 -------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9e2d3062b01d..2cd96256ba37 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -364,7 +364,6 @@ int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
>  int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  				   struct virtio_gpu_object *bo);
>  void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
> -int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>  
>  /* virtgpu_prime.c */
>  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 242766d644a7..82bfbf983fd2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -233,16 +233,3 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo)
>  	kfree(bo->pages);
>  	bo->pages = NULL;
>  }
> -
> -int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait)
> -{
> -	int r;
> -
> -	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
> -	if (unlikely(r != 0))
> -		return r;
> -	r = ttm_bo_wait(&bo->tbo, true, no_wait);
> -	ttm_bo_unreserve(&bo->tbo);
> -	return r;
> -}
> -
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
