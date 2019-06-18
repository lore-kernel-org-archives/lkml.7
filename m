Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E91C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="acF128CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfFROY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:24:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34230 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:24:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so22085764edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHnXFlY19ajG5XeU4b9Sa8dKBSgR+uGugZ79Ne3Ctiw=;
        b=acF128CBhxF2kvltkkX7fAoQeLnvbBcYHTDB+c8gopqzYOIsw9tTUJ9TFqlQIBtdsI
         zQ7Uznscg2mpVIHwI3qm21u+gRcRbt8R0sFUeDu8Ycy0Bvx2MmgX11qp5AOMBLjPvlfX
         rGEIWltU5HEOeqcOVjNzNnEtGRD6vsJyhCDrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uHnXFlY19ajG5XeU4b9Sa8dKBSgR+uGugZ79Ne3Ctiw=;
        b=gc14Zdq9dXTfGX5nygSUcBNqBhkBgwtp29/QSpA+hlU1bEdHYvA2y5+SyjNKQH9e8V
         xhYqwbbca+DuOI8FvSB4Up1LXbEDmC+bNSehteIrbFNjWz9il6Z0sTg9dy3nQrZYt6+T
         6J4FDSHDskHDY/NMlYi+CHIi3MgfWN24RQSLGu6ebIeRz++p/z/zubu08oVpiE3RSWcx
         UYAzF5CPINALPhULWL0D7Ooq06Db/wzPfx8nt+qdW77sdu8wmlwgqlCl9T/RLLnceu0e
         QXxAOb/YXIRaMoAdCMY+idQIy2Tp47EJ3VrKuk5GXkw/7mvbk5eCHQ7xRtdDCHs/YAHB
         Si/Q==
X-Gm-Message-State: APjAAAUid6W+m6MNVw3Qf2cp1ETQjU5/tDMu8NJCC44oRWVbs+hZnGh1
        rPkRLU1RjX9+K4QSqnVRE82MvQ==
X-Google-Smtp-Source: APXvYqxx5Ar/sJIj7A18c3YwjZinSwD1QAHaWKUNoAbyM4MPKWCKRVpPSd25DOefwPVv3Oq0Yp24Jw==
X-Received: by 2002:a17:906:924c:: with SMTP id c12mr37650490ejx.60.1560867866173;
        Tue, 18 Jun 2019 07:24:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w35sm2253983edd.32.2019.06.18.07.24.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:24:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:24:23 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/12] drm/virtio: rework virtio_gpu_object_create
 fencing
Message-ID: <20190618142423.GE12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190618135821.8644-1-kraxel@redhat.com>
 <20190618135821.8644-9-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-9-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:58:16PM +0200, Gerd Hoffmann wrote:
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 28 +++++++------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 82bfbf983fd2..461f15f26517 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,34 +141,22 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  
>  	if (fence) {
>  		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> -		struct list_head validate_list;
> -		struct ttm_validate_buffer mainbuf;
> +		struct drm_gem_object *obj = &bo->gem_base;
>  		struct ww_acquire_ctx ticket;
>  		unsigned long irq_flags;
> -		bool signaled;
>  
> -		INIT_LIST_HEAD(&validate_list);
> -		memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
> -
> -		/* use a gem reference since unref list undoes them */
> -		drm_gem_object_get(&bo->gem_base);
> -		mainbuf.bo = &bo->tbo;
> -		list_add(&mainbuf.head, &validate_list);
> -
> -		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> +		drm_gem_object_get(obj);
> +		ret = drm_gem_lock_reservations(&obj, 1, &ticket);
>  		if (ret == 0) {
>  			spin_lock_irqsave(&drv->lock, irq_flags);
> -			signaled = virtio_fence_signaled(&fence->f);
> -			if (!signaled)
> +			if (!virtio_fence_signaled(&fence->f))
>  				/* virtio create command still in flight */
> -				ttm_eu_fence_buffer_objects(&ticket, &validate_list,
> -							    &fence->f);

Same issue with the refcounting gone wrong here as in the previous patch.
-Daniel

> +				reservation_object_add_excl_fence(obj->resv,
> +								  &fence->f);
>  			spin_unlock_irqrestore(&drv->lock, irq_flags);
> -			if (signaled)
> -				/* virtio create command finished */
> -				ttm_eu_backoff_reservation(&ticket, &validate_list);
>  		}
> -		virtio_gpu_unref_list(&validate_list);
> +		drm_gem_unlock_reservations(&obj, 1, &ticket);
> +		drm_gem_object_put_unlocked(obj);
>  	}
>  
>  	*bo_ptr = bo;
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
