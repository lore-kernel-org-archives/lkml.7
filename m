Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC1C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CDB21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHm1ahO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfIIG7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:59:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfIIG7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:59:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id l16so12443573wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uPb7ZUb8kECFK5vFQJ+UGqGz0n2kxO9qQItYwAt4gFY=;
        b=DHm1ahO5q654Gu/6Vd7heKonLzVNGhmts5Gw+GY4zikwM9j0Qv0vZMNqgqhPhlM32l
         mTk3Jxrv5U9JewLXC7NZmjZ8kQ/Qj0x8vtbuwEd9I3C1NncdXA5XxRO9xvFOLfva+OUJ
         BdMIjfPrAJCTDzCWtu1ysbUe89Iogc3N+RRYq414Jj9a1voUWEK4sxl0IhQImQkW+UTI
         QcahwVn9F28k6+H9NMBA/n1bD9AWlIVCGHc8GJZzpqLFFs2c5smia0qwWphPiwfvSAyu
         BgI5E99u53IAwobj8OlzRT9q3Clv4aJJRaxhMIgRq3fCAJLHFIrLesixzwdag37MKwJd
         mA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=uPb7ZUb8kECFK5vFQJ+UGqGz0n2kxO9qQItYwAt4gFY=;
        b=mAeFKaMyRs8k+/0w6SwrCS3e0yDRicpRkMpn0IbIRyIsVmrS2CvS9wbqif/sQ9qC57
         CNDZwFG9Remo1zWT3h+8EX0/QIdqUxmcNd5uzBfbghrV1/O56jEjgSu7W59+6fHQZXJC
         yxQGyp4OHH4nIdsoDjfTTQDO7UgVacBt9GPyK6pLAfT7At8w+1vbHk7EQeD8jL8AdZ89
         ipKz/cvVHNyMv5pG/RBxXAy20D4UFssG9F6l6c1fLdJknDx0416lrsGNpBCh5kx4I3+2
         CHBs+v2/A4OygztPsK3u9twQs4LyEo/R9l9qMZnxTNs3woaqiq0SvREIUDDMkLocUPzf
         67mQ==
X-Gm-Message-State: APjAAAUFkEjzvZ0A/eHN0fl3HFkeMaSnnJiLtmJpdWc9IsSPEHeAOps8
        BmrI/JDQyMZ7EU5P0ur0iyY=
X-Google-Smtp-Source: APXvYqw/C6I8CzsT9UGXJlxxLpdeCtDXrqqzvRbYoW4dVD4JuyoSQaL05Is8JEnR4Ta69DMV7MaNPg==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr14297307wra.203.1568012354232;
        Sun, 08 Sep 2019 23:59:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id n30sm8600164wmd.15.2019.09.08.23.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 23:59:13 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/8] drm/ttm: turn ttm_bo_device.vma_manager into a
 pointer
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Huang Rui <ray.huang@amd.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
 <20190905070509.22407-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <851d89ec-968f-2209-91d2-29ec0b083e0b@gmail.com>
Date:   Mon, 9 Sep 2019 08:59:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905070509.22407-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.09.19 um 09:05 schrieb Gerd Hoffmann:
> Rename the embedded struct vma_offset_manager, new name is _vma_manager.
> ttm_bo_device.vma_manager changed to a pointer.
>
> The ttm_bo_device_init() function gets an additional vma_manager
> argument which allows to initialize ttm with a different vma manager.
> When passing NULL the embedded _vma_manager is used.
>
> All callers are updated to pass NULL, so the behavior doesn't change.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/drm/ttm/ttm_bo_driver.h         |  8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  1 +
>   drivers/gpu/drm/drm_vram_mm_helper.c    |  1 +
>   drivers/gpu/drm/nouveau/nouveau_ttm.c   |  1 +
>   drivers/gpu/drm/qxl/qxl_ttm.c           |  1 +
>   drivers/gpu/drm/radeon/radeon_ttm.c     |  1 +
>   drivers/gpu/drm/ttm/ttm_bo.c            | 13 +++++++++----
>   drivers/gpu/drm/ttm/ttm_bo_vm.c         |  6 +++---
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 +
>   9 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index e88e00c6cbf2..e365434f92b3 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -441,7 +441,8 @@ extern struct ttm_bo_global {
>    *
>    * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
>    * @man: An array of mem_type_managers.
> - * @vma_manager: Address space manager
> + * @vma_manager: Address space manager (pointer)
> + * @_vma_manager: Address space manager (enbedded)
>    * lru_lock: Spinlock that protects the buffer+device lru lists and
>    * ddestroy lists.
>    * @dev_mapping: A pointer to the struct address_space representing the
> @@ -464,7 +465,8 @@ struct ttm_bo_device {
>   	/*
>   	 * Protected by internal locks.
>   	 */
> -	struct drm_vma_offset_manager vma_manager;
> +	struct drm_vma_offset_manager *vma_manager;
> +	struct drm_vma_offset_manager _vma_manager;
>   
>   	/*
>   	 * Protected by the global:lru lock.
> @@ -585,6 +587,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev);
>    * @glob: A pointer to an initialized struct ttm_bo_global.
>    * @driver: A pointer to a struct ttm_bo_driver set up by the caller.
>    * @mapping: The address space to use for this bo.
> + * @vma_manager: A pointer to a vma manager or NULL.
>    * @file_page_offset: Offset into the device address space that is available
>    * for buffer data. This ensures compatibility with other users of the
>    * address space.
> @@ -596,6 +599,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev);
>   int ttm_bo_device_init(struct ttm_bo_device *bdev,
>   		       struct ttm_bo_driver *driver,
>   		       struct address_space *mapping,
> +		       struct drm_vma_offset_manager *vma_manager,
>   		       bool need_dma32);
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index fb09314bcfd4..34ee5d725faf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1728,6 +1728,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	r = ttm_bo_device_init(&adev->mman.bdev,
>   			       &amdgpu_bo_driver,
>   			       adev->ddev->anon_inode->i_mapping,
> +			       NULL,
>   			       adev->need_dma32);
>   	if (r) {
>   		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
> index c911781d6728..56fd1519eb35 100644
> --- a/drivers/gpu/drm/drm_vram_mm_helper.c
> +++ b/drivers/gpu/drm/drm_vram_mm_helper.c
> @@ -172,6 +172,7 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
>   
>   	ret = ttm_bo_device_init(&vmm->bdev, &bo_driver,
>   				 dev->anon_inode->i_mapping,
> +				 NULL,
>   				 true);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index f0daf958e03a..e67eb10843d1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -236,6 +236,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>   	ret = ttm_bo_device_init(&drm->ttm.bdev,
>   				  &nouveau_bo_driver,
>   				  dev->anon_inode->i_mapping,
> +				 NULL,
>   				  drm->client.mmu.dmabits <= 32 ? true : false);
>   	if (ret) {
>   		NV_ERROR(drm, "error initialising bo driver, %d\n", ret);
> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
> index 9b24514c75aa..69da0eea6e4c 100644
> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
> @@ -325,6 +325,7 @@ int qxl_ttm_init(struct qxl_device *qdev)
>   	r = ttm_bo_device_init(&qdev->mman.bdev,
>   			       &qxl_bo_driver,
>   			       qdev->ddev.anon_inode->i_mapping,
> +			       NULL,
>   			       false);
>   	if (r) {
>   		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 35ac75a11d38..e2c12e59704d 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -794,6 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
>   	r = ttm_bo_device_init(&rdev->mman.bdev,
>   			       &radeon_bo_driver,
>   			       rdev->ddev->anon_inode->i_mapping,
> +			       NULL,
>   			       rdev->need_dma32);
>   	if (r) {
>   		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 58d1f2b28132..8dc26babc5cb 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -672,7 +672,7 @@ static void ttm_bo_release(struct kref *kref)
>   	struct ttm_bo_device *bdev = bo->bdev;
>   	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
>   
> -	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
> +	drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
>   	ttm_mem_io_lock(man, false);
>   	ttm_mem_io_free_vm(bo);
>   	ttm_mem_io_unlock(man);
> @@ -1353,7 +1353,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
>   	 */
>   	if (bo->type == ttm_bo_type_device ||
>   	    bo->type == ttm_bo_type_sg)
> -		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->base.vma_node,
> +		ret = drm_vma_offset_add(bdev->vma_manager, &bo->base.vma_node,
>   					 bo->mem.num_pages);
>   
>   	/* passed reservation objects should already be locked,
> @@ -1704,7 +1704,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
>   			pr_debug("Swap list %d was clean\n", i);
>   	spin_unlock(&glob->lru_lock);
>   
> -	drm_vma_offset_manager_destroy(&bdev->vma_manager);
> +	drm_vma_offset_manager_destroy(&bdev->_vma_manager);
>   
>   	if (!ret)
>   		ttm_bo_global_release();
> @@ -1716,11 +1716,15 @@ EXPORT_SYMBOL(ttm_bo_device_release);
>   int ttm_bo_device_init(struct ttm_bo_device *bdev,
>   		       struct ttm_bo_driver *driver,
>   		       struct address_space *mapping,
> +		       struct drm_vma_offset_manager *vma_manager,
>   		       bool need_dma32)
>   {
>   	struct ttm_bo_global *glob = &ttm_bo_glob;
>   	int ret;
>   
> +	if (!vma_manager)
> +		vma_manager = &bdev->_vma_manager;
> +
>   	ret = ttm_bo_global_init();
>   	if (ret)
>   		return ret;
> @@ -1737,7 +1741,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>   	if (unlikely(ret != 0))
>   		goto out_no_sys;
>   
> -	drm_vma_offset_manager_init(&bdev->vma_manager,
> +	bdev->vma_manager = vma_manager;
> +	drm_vma_offset_manager_init(&bdev->_vma_manager,
>   				    DRM_FILE_PAGE_OFFSET_START,
>   				    DRM_FILE_PAGE_OFFSET_SIZE);
>   	INIT_DELAYED_WORK(&bdev->wq, ttm_bo_delayed_workqueue);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 76eedb963693..4aa007edffb0 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -409,16 +409,16 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
>   	struct drm_vma_offset_node *node;
>   	struct ttm_buffer_object *bo = NULL;
>   
> -	drm_vma_offset_lock_lookup(&bdev->vma_manager);
> +	drm_vma_offset_lock_lookup(bdev->vma_manager);
>   
> -	node = drm_vma_offset_lookup_locked(&bdev->vma_manager, offset, pages);
> +	node = drm_vma_offset_lookup_locked(bdev->vma_manager, offset, pages);
>   	if (likely(node)) {
>   		bo = container_of(node, struct ttm_buffer_object,
>   				  base.vma_node);
>   		bo = ttm_bo_get_unless_zero(bo);
>   	}
>   
> -	drm_vma_offset_unlock_lookup(&bdev->vma_manager);
> +	drm_vma_offset_unlock_lookup(bdev->vma_manager);
>   
>   	if (!bo)
>   		pr_err("Could not find buffer object to map\n");
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index cd0d49d8a8da..20bc91214e75 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -830,6 +830,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
>   	ret = ttm_bo_device_init(&dev_priv->bdev,
>   				 &vmw_bo_driver,
>   				 dev->anon_inode->i_mapping,
> +				 NULL,
>   				 false);
>   	if (unlikely(ret != 0)) {
>   		DRM_ERROR("Failed initializing TTM buffer object driver.\n");

