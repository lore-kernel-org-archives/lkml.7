Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3709D20409
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ek02E4S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfKMQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:33:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKMQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:33:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so2691888wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UeCgLesamDTUsDPPV6ZtQD74frhXEKTdzsqtnT1K74E=;
        b=ek02E4S88ezVo5r3GsFDdmDoSP4U21NdmJasFqGC0n17Noz8o7rg/mNxpIL44gVsRL
         cVsOxqMmDDaNOgrCj3tl2sAtxILqzcQxQKQAHzxtWz/C97RkQwVWE59oukKBcumN40TD
         spVPS/mI/THKvYhUoG31Aw3CFMquMxsvqP9+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UeCgLesamDTUsDPPV6ZtQD74frhXEKTdzsqtnT1K74E=;
        b=BBdJHl5NBRT4AIi/SWN1LmjVx7LqCt3zKKnaHICVgB+PwdV4xEVvJsUrpD10YCwq4P
         Aawqyjyc3kjC8bhRGfg0+5NHFrPwkITZXvGsW7XvTOPATRlQ58Gt1zAtcqrHz2JBxfWW
         dW6YVr6rYHnKyuwoKFhIKT85AnjRWsYFhpZXqdibIkaTV2+dHHx2OutmHlYY4MJCd415
         NrtNP1DBWoyb722FzVLfrytEz2IS/vZSCL8VV/8vCXcqRO4GmQz5HGITkHETb0mUjgFT
         VxcIS/Y5RNU4kmovHdzi31T2QfZolYi3tKLntog1khoKQFH4f9NqiTuHnsIvVOFgPhML
         25ow==
X-Gm-Message-State: APjAAAXnJXq3ovvR//bySZg97/fWN9XiNxs2XAUl+f6avpvHP01/xPj1
        VZETqZlxB+1jciSs91KwoRv5jA==
X-Google-Smtp-Source: APXvYqw2/nDqQyepkb4kR7SVsSAZUW7SvsXxh+2chPgZTCPmhzlIyS69PbSrFUkGklpg3CpALDkTcQ==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr3653834wmg.117.1573662783863;
        Wed, 13 Nov 2019 08:33:03 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j22sm4202715wrd.41.2019.11.13.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 08:33:02 -0800 (PST)
Date:   Wed, 13 Nov 2019 17:33:00 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     drm@redhat.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: fix mmap refcounting
Message-ID: <20191113163300.GS23790@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>, drm@redhat.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191113135612.19679-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113135612.19679-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:56:12PM +0100, Gerd Hoffmann wrote:
> When mapping ttm objects via drm_gem_ttm_mmap() helper
> drm_gem_mmap_obj() will take an object reference.  That gets
> never released due to ttm having its own reference counting.
> 
> Fix that by dropping the gem object reference once the ttm mmap
> completed (and ttm refcount got bumped).
> 
> For that to work properly the drm_gem_object_get() call in
> drm_gem_ttm_mmap() must be moved so it happens before calling
> obj->funcs->mmap(), otherwise the gem refcount would go down
> to zero.
> 
> Fixes: 231927d939f0 ("drm/ttm: add drm_gem_ttm_mmap()")

Since the offending patch is in drm-next and we're in the merge window
freeze past -rc6 please remember to apply this to drm-misc-next-fixes.
Otherwise it'll miss the merge window.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I was wondering whether we'd need a cc: stable, in case someone is really
fast and gets the vm_close in before we finish the mmap. But I think we
should be serialized by mmap_sem here enough ...

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_gem.c            | 24 ++++++++++++++----------
>  drivers/gpu/drm/drm_gem_ttm_helper.c | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 2f2b889096b0..000fa4a1899f 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1105,21 +1105,33 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  	if (obj_size < vma->vm_end - vma->vm_start)
>  		return -EINVAL;
>  
> +	/* Take a ref for this mapping of the object, so that the fault
> +	 * handler can dereference the mmap offset's pointer to the object.
> +	 * This reference is cleaned up by the corresponding vm_close
> +	 * (which should happen whether the vma was created by this call, or
> +	 * by a vm_open due to mremap or partial unmap or whatever).
> +	 */
> +	drm_gem_object_get(obj);
> +
>  	if (obj->funcs && obj->funcs->mmap) {
>  		/* Remove the fake offset */
>  		vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
>  
>  		ret = obj->funcs->mmap(obj, vma);
> -		if (ret)
> +		if (ret) {
> +			drm_gem_object_put_unlocked(obj);
>  			return ret;
> +		}
>  		WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));
>  	} else {
>  		if (obj->funcs && obj->funcs->vm_ops)
>  			vma->vm_ops = obj->funcs->vm_ops;
>  		else if (dev->driver->gem_vm_ops)
>  			vma->vm_ops = dev->driver->gem_vm_ops;
> -		else
> +		else {
> +			drm_gem_object_put_unlocked(obj);
>  			return -EINVAL;
> +		}
>  
>  		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
>  		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> @@ -1128,14 +1140,6 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  
>  	vma->vm_private_data = obj;
>  
> -	/* Take a ref for this mapping of the object, so that the fault
> -	 * handler can dereference the mmap offset's pointer to the object.
> -	 * This reference is cleaned up by the corresponding vm_close
> -	 * (which should happen whether the vma was created by this call, or
> -	 * by a vm_open due to mremap or partial unmap or whatever).
> -	 */
> -	drm_gem_object_get(obj);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_gem_mmap_obj);
> diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
> index 7412bfc5c05a..605a8a3da7f9 100644
> --- a/drivers/gpu/drm/drm_gem_ttm_helper.c
> +++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
> @@ -64,8 +64,19 @@ int drm_gem_ttm_mmap(struct drm_gem_object *gem,
>  		     struct vm_area_struct *vma)
>  {
>  	struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
> +	int ret;
>  
> -	return ttm_bo_mmap_obj(vma, bo);
> +	ret = ttm_bo_mmap_obj(vma, bo);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * ttm has its own object refcounting, so drop gem reference
> +	 * to avoid double accounting counting.
> +	 */
> +	drm_gem_object_put_unlocked(gem);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(drm_gem_ttm_mmap);
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
