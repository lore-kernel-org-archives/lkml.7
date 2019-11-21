Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8722070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NUEEP1oB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:53:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:53:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so4483760wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2uV87tHnIgiCiVK9tH7sB/ulKG7TgA9BdW+nsg2pQjI=;
        b=NUEEP1oBhkwjEiqtuvRUm0qG61q6F3PlYwUqK2J5ByTn5TxZ0d/Ax7oPnTAU1UMZV5
         t5MLO6lKSbZ/0WSkd151vNlW7P+IRnWI7IYkWInEmq15GIB1gKoZMGXtkEi/+MFyESVe
         dIjeAf41R3P7jWSActIRIMnpJl8aLh+qDh/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2uV87tHnIgiCiVK9tH7sB/ulKG7TgA9BdW+nsg2pQjI=;
        b=bhXYpZ/zS4ZNM0Do1r4WcYMq6NLhhL9jjupj6Br9+97SHVjppcQmZxZsMHly6an1bx
         mhylqNpjun5aBxZ82SeiWMODeCsZKSUGXn0v69Ndvy7wEKASBmpjZvBW0bJekfBPJYda
         g7LdNxP6qoE1ur0OteSaHRNcE6IvoB/S5zPd/0uP0uvTkjXAVAS0HTRXQtfmOKRDHO5P
         JbnYJl7As8pgbMqNkOTAaUhxc61/oIMxD7jrb5wnvG/g3KsD4uOWYB5ifjVrmiPaRIMp
         +xSYfdok/PwjnchhP5UL7VYiNBzPxALdXNrA+wYRHE10U7rqqBPoz5JnOKkfm4uWFGI8
         cHrQ==
X-Gm-Message-State: APjAAAXF1AWhZ9/vkSRPFMCnDEs9ocPcb7kmC7Ct3XocvuoXuB+PWXXI
        jAs0K38UtiJZyvSgmlbmJ3j66iTERBM=
X-Google-Smtp-Source: APXvYqwEA3bovHHym+mhiZDwTYwH78g+bl2IMsyxxa/rOWNOiZDxDdFMyQqVfSr1m0ndkBVvI7gs2g==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr11440009wro.355.1574344383273;
        Thu, 21 Nov 2019 05:53:03 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id y19sm3169650wmd.29.2019.11.21.05.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:53:02 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:52:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: call drm_gem_object_funcs.mmap with fake offset
Message-ID: <20191121135259.GE6236@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191121103807.18424-1-kraxel@redhat.com>
 <20191121103807.18424-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121103807.18424-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-1-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:38:06AM +0100, Gerd Hoffmann wrote:
> The fake offset is going to stay, so change the calling convention for
> drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> accordingly.

Please add to the commit message:

Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
handling for drm_gem_object_funcs.mmap") and on top then adds the fake
offset to  drm_gem_prime_mmap to make sure all paths leading to
obj->funcs->mmap are consistent.

Fixes: 83b8a6f242ea ("drm/gem: Fix mmap fake offset handling for drm_gem_object_funcs.mmap")
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>

With that also Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-Daniel
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem.h                  | 4 +---
>  drivers/gpu/drm/drm_gem.c              | 3 ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
>  drivers/gpu/drm/drm_prime.c            | 3 +++
>  drivers/gpu/drm/ttm/ttm_bo_vm.c        | 7 -------
>  5 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 97a48165642c..0b375069cd48 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -159,9 +159,7 @@ struct drm_gem_object_funcs {
>  	 *
>  	 * The callback is used by by both drm_gem_mmap_obj() and
>  	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
> -	 * used, the @mmap callback must set vma->vm_ops instead. The @mmap
> -	 * callback is always called with a 0 offset. The caller will remove
> -	 * the fake offset as necessary.
> +	 * used, the @mmap callback must set vma->vm_ops instead.
>  	 */
>  	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 2f2b889096b0..56f42e0f2584 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1106,9 +1106,6 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  		return -EINVAL;
>  
>  	if (obj->funcs && obj->funcs->mmap) {
> -		/* Remove the fake offset */
> -		vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
> -
>  		ret = obj->funcs->mmap(obj, vma);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 0810d3ef6961..a421a2eed48a 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -528,6 +528,9 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  	struct drm_gem_shmem_object *shmem;
>  	int ret;
>  
> +	/* Remove the fake offset */
> +	vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
> +
>  	shmem = to_drm_gem_shmem_obj(obj);
>  
>  	ret = drm_gem_shmem_get_pages(shmem);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 0814211b0f3f..a9633bd241bb 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -714,6 +714,9 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  	int ret;
>  
>  	if (obj->funcs && obj->funcs->mmap) {
> +		/* Add the fake offset */
> +		vma->vm_pgoff += drm_vma_node_start(&obj->vma_node);
> +
>  		ret = obj->funcs->mmap(obj, vma);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index e6495ca2630b..3e8c3de91ae4 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -514,13 +514,6 @@ EXPORT_SYMBOL(ttm_bo_mmap);
>  int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
>  {
>  	ttm_bo_get(bo);
> -
> -	/*
> -	 * FIXME: &drm_gem_object_funcs.mmap is called with the fake offset
> -	 * removed. Add it back here until the rest of TTM works without it.
> -	 */
> -	vma->vm_pgoff += drm_vma_node_start(&bo->base.vma_node);
> -
>  	ttm_bo_mmap_vma_setup(bo, vma);
>  	return 0;
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
