Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB58C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F8520833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBZ6NnV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfDOGee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:34:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50930 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDOGed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:34:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so19153522wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gu7TwYKZ5i+nuQgrHJLLMLTcP+wKwXKCvCDklAVHyCI=;
        b=jBZ6NnV3IRNJJ0pG4wvUuKzQqBTz1c57PUDpRkFNI4Q1Gs3y8jFUDCNFjaFK78o+rI
         arKL2OUTee9ASL119zKJwuwstN6X6T6ip/4t1F9E14a8w6LVhUHDvCSkEILVcaJxzZyK
         Z8tBVpoMutFX4WArkJjLNW4xWozvmubbY3Cs/M3gsQHbBA5pQzdpgEGT+rqsJuwq9QNU
         /AvV06C/It30wH9+YWJGjcgQVRvGFrz9eHWEuBT18v6H3Ss8CVYhoQGavhhFyW2J2PPb
         ErfKoJjHE3ZjgIMl7JhUzPN7o7ieBj+e9vki4WInCrQpnNGKAvJ9L9tGb1Da0+xCY5OQ
         7+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=gu7TwYKZ5i+nuQgrHJLLMLTcP+wKwXKCvCDklAVHyCI=;
        b=D+IGy4tzvY+54vgoOQryxbArzg576uwoogBT6LAMvkxSjW7TKAyoXse1nsg5JOHonj
         NyzqnsEtp3end9krP1zF/uy+8UOoZw/L7O38IhniHHeL9k4roPwFXdo40er3O3TPliLL
         B/PIvCmoVilf2LX2+X4u8oOuoi8VB00hE6Cf4f/sQH/LX9StNNKKzBggbydZSYaUwkS9
         0uQT/9jygo9v2eY6v8sNkqtVnJONcPAceneVQBSC8/2AAhC9kGGc2s6L7cJ3Z5ays9bU
         M+Za5qzNS2YT6cXjOBGDcuJKih8egmuril6DKHN5soAyHrAM9IbKmmsIvU0f7ojzUscm
         8NNQ==
X-Gm-Message-State: APjAAAXCOaUzdyB7Po7rKEqAcuYDBdx/B1FiqTwVInWA5xR+izwm8N8S
        TmeRZBZjgAWVFe8PxhcYK+KglbqX
X-Google-Smtp-Source: APXvYqxr/QtV9qLVDk6FneQTtl8lY8hqxjwtzGAliz/a41Q48+0pmFoL7IcKoiRgEbvGSe1IMWeawg==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr19572681wmt.33.1555310070564;
        Sun, 14 Apr 2019 23:34:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id x205sm20986795wmg.9.2019.04.14.23.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 23:34:29 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 5/9] drm/ttm: TTM fault handler helpers
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190412160338.64994-1-thellstrom@vmware.com>
 <20190412160338.64994-6-thellstrom@vmware.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fe34e174-a0e2-9eb4-f05d-6797c61cf4a0@gmail.com>
Date:   Mon, 15 Apr 2019 08:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190412160338.64994-6-thellstrom@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.04.19 um 18:04 schrieb Thomas Hellstrom:
> With the vmwgfx dirty tracking, the default TTM fault handler is not
> completely sufficient (vmwgfx need to modify the vma->vm_flags member,
> and also needs to restrict the number of prefaults).
>
> We also want to replicate the new ttm_bo_vm_reserve() functionality
>
> So start turning the TTM vm code into helpers: ttm_bo_vm_fault_reserved()
> and ttm_bo_vm_reserve(), and provide a default TTM fault handler for other
> drivers to use.
>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Two nit picks below, apart from that looks good to me as well.

> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 170 ++++++++++++++++++++------------
>   include/drm/ttm/ttm_bo_api.h    |  10 ++
>   2 files changed, 116 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index bfb25b81fed7..3bd28fb97124 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -42,8 +42,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/mem_encrypt.h>
>   
> -#define TTM_BO_VM_NUM_PREFAULT 16
> -
>   static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>   				struct vm_fault *vmf)
>   {
> @@ -106,31 +104,30 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
>   		+ page_offset;
>   }
>   
> -static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
> +/**
> + * ttm_bo_vm_reserve - Reserve a buffer object in a retryable vm callback
> + * @bo: The buffer object
> + * @vmf: The fault structure handed to the callback
> + *
> + * vm callbacks like fault() and *_mkwrite() allow for the mm_sem to be dropped
> + * during long waits, and after the wait the callback will be restarted. This
> + * is to allow other threads using the same virtual memory space concurrent
> + * access to map(), unmap() completely unrelated buffer objects. TTM buffer
> + * object reservations sometimes wait for GPU and should therefore be
> + * considered long waits. This function reserves the buffer object interruptibly
> + * taking this into account. Starvation is avoided by the vm system not
> + * allowing too many repeated restarts.
> + * This function is intended to be used in customized fault() and _mkwrite()
> + * handlers.
> + *
> + * Return:
> + *    0 on success and the bo was reserved.
> + *    VM_FAULT_RETRY if blocking wait.
> + *    VM_FAULT_NOPAGE if blocking wait and retrying was not allowed.
> + */
> +vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
> +			     struct vm_fault *vmf)
>   {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> -	    vma->vm_private_data;
> -	struct ttm_bo_device *bdev = bo->bdev;
> -	unsigned long page_offset;
> -	unsigned long page_last;
> -	unsigned long pfn;
> -	struct ttm_tt *ttm = NULL;
> -	struct page *page;
> -	int err;
> -	int i;
> -	vm_fault_t ret = VM_FAULT_NOPAGE;
> -	unsigned long address = vmf->address;
> -	struct ttm_mem_type_manager *man =
> -		&bdev->man[bo->mem.mem_type];
> -	struct vm_area_struct cvma;
> -
> -	/*
> -	 * Work around locking order reversal in fault / nopfn
> -	 * between mmap_sem and bo_reserve: Perform a trylock operation
> -	 * for reserve, and if it fails, retry the fault after waiting
> -	 * for the buffer to become unreserved.
> -	 */
>   	if (unlikely(!reservation_object_trylock(bo->resv))) {
>   		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
>   			if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
> @@ -151,14 +148,56 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		return VM_FAULT_NOPAGE;
>   	}
>   
> +	return 0;
> +}
> +EXPORT_SYMBOL(ttm_bo_vm_reserve);
> +
> +/**
> + * ttm_bo_vm_fault_reserved - TTM fault helper
> + * @vmf: The struct vm_fault given as argument to the fault callback
> + * @cvma: The struct vmw_area_struct affected. Note that this may be a
> + * copy of the real vma object if the caller needs, for example, VM
> + * flags to be temporarily altered while determining the page protection.
> + * @num_prefault: Maximum number of prefault pages. The caller may want to
> + * specify this based on madvice settings and the size of the GPU object
> + * backed by the memory.
> + *
> + * This function inserts one or more page table entries pointing to the
> + * memory backing the buffer object, and then returns a return code
> + * instructing the caller to retry the page access.
> + *
> + * Return:
> + *   VM_FAULT_NOPAGE on success or pending signal
> + *   VM_FAULT_SIGBUS on unspecified error
> + *   VM_FAULT_OOM on out-of-memory
> + *   VM_FAULT_RETRY if retryable wait
> + */
> +vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
> +				    struct vm_area_struct *cvma,
> +				    pgoff_t num_prefault)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> +	    vma->vm_private_data;
> +	struct ttm_bo_device *bdev = bo->bdev;
> +	unsigned long page_offset;
> +	unsigned long page_last;
> +	unsigned long pfn;
> +	struct ttm_tt *ttm = NULL;
> +	struct page *page;
> +	int err;
> +	pgoff_t i;
> +	vm_fault_t ret = VM_FAULT_NOPAGE;
> +	unsigned long address = vmf->address;
> +	struct ttm_mem_type_manager *man =
> +		&bdev->man[bo->mem.mem_type];
> +
>   	/*
>   	 * Refuse to fault imported pages. This should be handled
>   	 * (if at all) by redirecting mmap to the exporter.
>   	 */
> -	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> -		ret = VM_FAULT_SIGBUS;
> -		goto out_unlock;
> -	}
> +	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG))
> +		return VM_FAULT_SIGBUS;
>   
>   	if (bdev->driver->fault_reserve_notify) {
>   		struct dma_fence *moving = dma_fence_get(bo->moving);
> @@ -169,11 +208,9 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   			break;
>   		case -EBUSY:
>   		case -ERESTARTSYS:
> -			ret = VM_FAULT_NOPAGE;
> -			goto out_unlock;
> +			return VM_FAULT_NOPAGE;
>   		default:
> -			ret = VM_FAULT_SIGBUS;
> -			goto out_unlock;
> +			return VM_FAULT_SIGBUS;
>   		}
>   
>   		if (bo->moving != moving) {
> @@ -189,24 +226,15 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   	 * move.
>   	 */
>   	ret = ttm_bo_vm_fault_idle(bo, vmf);
> -	if (unlikely(ret != 0)) {
> -		if (ret == VM_FAULT_RETRY &&
> -		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
> -			/* The BO has already been unreserved. */
> -			return ret;
> -		}
> -
> -		goto out_unlock;
> -	}
> +	if (unlikely(ret != 0))
> +		return ret;
>   
>   	err = ttm_mem_io_lock(man, true);
> -	if (unlikely(err != 0)) {
> -		ret = VM_FAULT_NOPAGE;
> -		goto out_unlock;
> -	}
> +	if (unlikely(err != 0))
> +		return VM_FAULT_NOPAGE;
>   	err = ttm_mem_io_reserve_vm(bo);
>   	if (unlikely(err != 0)) {
> -		ret = VM_FAULT_SIGBUS;
> +		return VM_FAULT_SIGBUS;
>   		goto out_io_unlock;

This goto is now superfluous.

>   	}
>   
> @@ -220,17 +248,11 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		goto out_io_unlock;
>   	}
>   
> -	/*
> -	 * Make a local vma copy to modify the page_prot member
> -	 * and vm_flags if necessary. The vma parameter is protected
> -	 * by mmap_sem in write mode.
> -	 */
> -	cvma = *vma;
> -	cvma.vm_page_prot = vm_get_page_prot(cvma.vm_flags);
> +	cvma->vm_page_prot = vm_get_page_prot(cvma->vm_flags);
>   
>   	if (bo->mem.bus.is_iomem) {
> -		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
> -						cvma.vm_page_prot);
> +		cvma->vm_page_prot = ttm_io_prot(bo->mem.placement,
> +						 cvma->vm_page_prot);
>   	} else {
>   		struct ttm_operation_ctx ctx = {
>   			.interruptible = false,
> @@ -240,8 +262,8 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		};
>   
>   		ttm = bo->ttm;
> -		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
> -						cvma.vm_page_prot);
> +		cvma->vm_page_prot = ttm_io_prot(bo->mem.placement,
> +						 cvma->vm_page_prot);
>   
>   		/* Allocate all page at once, most common usage */
>   		if (ttm_tt_populate(ttm, &ctx)) {
> @@ -254,10 +276,11 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   	 * Speculatively prefault a number of pages. Only error on
>   	 * first page.
>   	 */
> -	for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
> +	for (i = 0; i < num_prefault; ++i) {
>   		if (bo->mem.bus.is_iomem) {
>   			/* Iomem should not be marked encrypted */
> -			cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
> +			cvma->vm_page_prot =
> +				pgprot_decrypted(cvma->vm_page_prot);
>   			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>   		} else {
>   			page = ttm->pages[page_offset];
> @@ -273,10 +296,10 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		}
>   
>   		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed(&cvma, address,
> +			ret = vmf_insert_mixed(cvma, address,
>   					__pfn_to_pfn_t(pfn, PFN_DEV));
>   		else
> -			ret = vmf_insert_pfn(&cvma, address, pfn);
> +			ret = vmf_insert_pfn(cvma, address, pfn);
>   
>   		/*
>   		 * Somebody beat us to this PTE or prefaulting to
> @@ -295,7 +318,26 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   	ret = VM_FAULT_NOPAGE;
>   out_io_unlock:
>   	ttm_mem_io_unlock(man);
> -out_unlock:
> +	return ret;
> +}
> +EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
> +
> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct vm_area_struct cvma = *vma;
> +	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> +	    vma->vm_private_data;

That extra cast can be dropped, the vm_private_data member is a void* 
anyway.

Regards,
Christian.

> +	vm_fault_t ret;
> +
> +	ret = ttm_bo_vm_reserve(bo, vmf);
> +	if (ret)
> +		return ret;
> +
> +	ret = ttm_bo_vm_fault_reserved(vmf, &cvma, TTM_BO_VM_NUM_PREFAULT);
> +	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		return ret;
> +
>   	reservation_object_unlock(bo->resv);
>   	return ret;
>   }
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 49d9cdfc58f2..bebfa16426ca 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -768,4 +768,14 @@ int ttm_bo_swapout(struct ttm_bo_global *glob,
>   			struct ttm_operation_ctx *ctx);
>   void ttm_bo_swapout_all(struct ttm_bo_device *bdev);
>   int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo);
> +
> +/* Default number of pre-faulted pages in the TTM fault handler */
> +#define TTM_BO_VM_NUM_PREFAULT 16
> +
> +vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
> +			     struct vm_fault *vmf);
> +
> +vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
> +				    struct vm_area_struct *cvma,
> +				    pgoff_t num_prefault);
>   #endif

