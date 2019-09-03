Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266472087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CrmQncz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfICJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:49:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42272 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfICJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:49:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so5987771ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLcQOot9GdKqXYO6fhYKSeZ7HqaIU2YpPDjXsGcAvU0=;
        b=CrmQncz1FCiE3DaF8A2LAEjZMALNs1KCHon23f8MQJIGeyi6g4pYpUbvKdMuwrNTlE
         HQeBZ5XEUBmqPMzDddNr9SV/dLnqCZA1MNwVHMCBueME0s8e7uJbqt6MLbonJerbpIan
         e0jBv4PrOhm2NENTxz6UMtvGzTE1R8r2H2dew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jLcQOot9GdKqXYO6fhYKSeZ7HqaIU2YpPDjXsGcAvU0=;
        b=l23FE6vQ469En2zowU6pi0ithtRlM4PjQ4WyL2BMlrNBvubf/BUXgc8q24POVD5Oqo
         sSsRy0Y/99Wvs3hB3xtOYUk/FT1KkRHazsw4OGwc+x4rbMdwFmlRq/6cNR55gujTB10v
         u1B9FtuiG8fIVzZAXCYhEwL7rKvDLFnaFtX/g4XTCKi58ImhLgKf8JnTkRe5WzFVwIGZ
         p4BRV4WCGnVaeQ5MTjamfd4DVzxlQWaJYKWg82bcjoRRCaMayYQeUb0Kui/8ix7S7eSF
         aphsoXRoM7lYDoMnX9yyon7iV4S0wtFwnevOuScxIKU3xjgCG3hNUcRitE/fXQln3s3Q
         ztVQ==
X-Gm-Message-State: APjAAAWPtt1PweYg1ej3Ceq7FUzwUFFAYIIkfoWvWmlVRRh+3Zr8VOi9
        N9UWKu8TKiRonIDnE8HUSWYU8w==
X-Google-Smtp-Source: APXvYqwwWVog1noytlBhfYNIVapYScGvOz1JmwK9UQ6cIHb8v2kyeG73ZD31j1kKrDLcB4SxQ3fv5w==
X-Received: by 2002:a50:b885:: with SMTP id l5mr34180216ede.190.1567504179249;
        Tue, 03 Sep 2019 02:49:39 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id c6sm3447641edx.20.2019.09.03.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:49:38 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:49:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] drm/ttm: turn ttm_bo_device.vma_manager into a
 pointer
Message-ID: <20190903094936.GR2112@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190808134417.10610-1-kraxel@redhat.com>
 <20190808134417.10610-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808134417.10610-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:44:01PM +0200, Gerd Hoffmann wrote:
> Rename the embedded struct vma_offset_manager, it is named _vma_manager
> now.  ttm_bo_device.vma_manager is a pointer now, pointing to the
> embedded ttm_bo_device._vma_manager by default.
> 
> Add ttm_bo_device_init_with_vma_manager() function which allows to
> initialize ttm with a different vma manager.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I think a todo to convert all other ttm drivers over and then move
_vma_manager into vmwgfx would be nice. If you're not volunteering
yourself for this ofc.
-Daniel

> ---
>  include/drm/ttm/ttm_bo_driver.h | 11 +++++++++--
>  drivers/gpu/drm/ttm/ttm_bo.c    | 29 +++++++++++++++++++++--------
>  drivers/gpu/drm/ttm/ttm_bo_vm.c |  6 +++---
>  3 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index 3f1935c19a66..2f84d6bcd1a7 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -441,7 +441,8 @@ extern struct ttm_bo_global {
>   *
>   * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
>   * @man: An array of mem_type_managers.
> - * @vma_manager: Address space manager
> + * @vma_manager: Address space manager (pointer)
> + * @_vma_manager: Address space manager (enbedded)
>   * lru_lock: Spinlock that protects the buffer+device lru lists and
>   * ddestroy lists.
>   * @dev_mapping: A pointer to the struct address_space representing the
> @@ -464,7 +465,8 @@ struct ttm_bo_device {
>  	/*
>  	 * Protected by internal locks.
>  	 */
> -	struct drm_vma_offset_manager vma_manager;
> +	struct drm_vma_offset_manager *vma_manager;
> +	struct drm_vma_offset_manager _vma_manager;
>  
>  	/*
>  	 * Protected by the global:lru lock.
> @@ -597,6 +599,11 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  		       struct ttm_bo_driver *driver,
>  		       struct address_space *mapping,
>  		       bool need_dma32);
> +int ttm_bo_device_init_with_vma_manager(struct ttm_bo_device *bdev,
> +					struct ttm_bo_driver *driver,
> +					struct address_space *mapping,
> +					struct drm_vma_offset_manager *vma_manager,
> +					bool need_dma32);
>  
>  /**
>   * ttm_bo_unmap_virtual
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 10a861a1690c..0ed1a1182962 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -672,7 +672,7 @@ static void ttm_bo_release(struct kref *kref)
>  	struct ttm_bo_device *bdev = bo->bdev;
>  	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
>  
> -	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
> +	drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
>  	ttm_mem_io_lock(man, false);
>  	ttm_mem_io_free_vm(bo);
>  	ttm_mem_io_unlock(man);
> @@ -1353,7 +1353,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
>  	 */
>  	if (bo->type == ttm_bo_type_device ||
>  	    bo->type == ttm_bo_type_sg)
> -		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->base.vma_node,
> +		ret = drm_vma_offset_add(bdev->vma_manager, &bo->base.vma_node,
>  					 bo->mem.num_pages);
>  
>  	/* passed reservation objects should already be locked,
> @@ -1704,7 +1704,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
>  			pr_debug("Swap list %d was clean\n", i);
>  	spin_unlock(&glob->lru_lock);
>  
> -	drm_vma_offset_manager_destroy(&bdev->vma_manager);
> +	drm_vma_offset_manager_destroy(&bdev->_vma_manager);
>  
>  	if (!ret)
>  		ttm_bo_global_release();
> @@ -1713,10 +1713,11 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
>  }
>  EXPORT_SYMBOL(ttm_bo_device_release);
>  
> -int ttm_bo_device_init(struct ttm_bo_device *bdev,
> -		       struct ttm_bo_driver *driver,
> -		       struct address_space *mapping,
> -		       bool need_dma32)
> +int ttm_bo_device_init_with_vma_manager(struct ttm_bo_device *bdev,
> +					struct ttm_bo_driver *driver,
> +					struct address_space *mapping,
> +					struct drm_vma_offset_manager *vma_manager,
> +					bool need_dma32)
>  {
>  	struct ttm_bo_global *glob = &ttm_bo_glob;
>  	int ret;
> @@ -1737,7 +1738,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  	if (unlikely(ret != 0))
>  		goto out_no_sys;
>  
> -	drm_vma_offset_manager_init(&bdev->vma_manager,
> +	bdev->vma_manager = vma_manager;
> +	drm_vma_offset_manager_init(&bdev->_vma_manager,
>  				    DRM_FILE_PAGE_OFFSET_START,
>  				    DRM_FILE_PAGE_OFFSET_SIZE);
>  	INIT_DELAYED_WORK(&bdev->wq, ttm_bo_delayed_workqueue);
> @@ -1754,6 +1756,17 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  	ttm_bo_global_release();
>  	return ret;
>  }
> +EXPORT_SYMBOL(ttm_bo_device_init_with_vma_manager);
> +
> +int ttm_bo_device_init(struct ttm_bo_device *bdev,
> +		       struct ttm_bo_driver *driver,
> +		       struct address_space *mapping,
> +		       bool need_dma32)
> +{
> +	return ttm_bo_device_init_with_vma_manager(bdev, driver, mapping,
> +						   &bdev->_vma_manager,
> +						   need_dma32);
> +}
>  EXPORT_SYMBOL(ttm_bo_device_init);
>  
>  /*
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 85f5bcbe0c76..d4eecde8d050 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -409,16 +409,16 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
>  	struct drm_vma_offset_node *node;
>  	struct ttm_buffer_object *bo = NULL;
>  
> -	drm_vma_offset_lock_lookup(&bdev->vma_manager);
> +	drm_vma_offset_lock_lookup(bdev->vma_manager);
>  
> -	node = drm_vma_offset_lookup_locked(&bdev->vma_manager, offset, pages);
> +	node = drm_vma_offset_lookup_locked(bdev->vma_manager, offset, pages);
>  	if (likely(node)) {
>  		bo = container_of(node, struct ttm_buffer_object,
>  				  base.vma_node);
>  		bo = ttm_bo_get_unless_zero(bo);
>  	}
>  
> -	drm_vma_offset_unlock_lookup(&bdev->vma_manager);
> +	drm_vma_offset_unlock_lookup(bdev->vma_manager);
>  
>  	if (!bo)
>  		pr_err("Could not find buffer object to map\n");
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
