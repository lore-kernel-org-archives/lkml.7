Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D199C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B128208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KTmzGyQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfLKMgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:36:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55141 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:36:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so6904805wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PzIo/7Q35YMn7hqu2gyhjmIOlK0rB4TWN3eOKjhwRgA=;
        b=KTmzGyQlhvUpLrDS1bbfx86H9uvBOJsXGBJR4vGd7i6bDMCbOCLbMQNxur5X1yVIz2
         LGCoDW3r3DDmrbEk+6mGKT1WT8yziAX2Zd9KyxSeGGe3Zna3AHiKrAsdK/xp2XKGUvAz
         SSf/Q6anG/WrR0NYryOZPvdlwBPefMuv9hGuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PzIo/7Q35YMn7hqu2gyhjmIOlK0rB4TWN3eOKjhwRgA=;
        b=fihDrtdpxZAsFCe2zg0cI6tAsuSZmTltW6ywvwyOZQw5ND2AMil8OWOiYakpwFjNnG
         MYPkgkn8ITvMJIUSCNPeVgnxuIZG6wOp3H2tsJ/OBSioQ6Zq3ttFB7klPu7DqDSbPbzS
         ++z5nhfe63HB0o67l0GYq4DYham95Wl5r0rBDsaJ/cLUS1Pcf7lvUz9u/fcXWsrC4JtY
         fNEBP+cHslU9p5S9PO/RdnKYOx+iRzAdygbOKEqS83SxXHHFtYp4Ri+1phMhh/6Xzd3M
         guQFNGLHr9uPBhNivFl+iAapKY8ykArZ3F2URSpgZLh4L//KNpPjF8uiYuaCBK3OLY7p
         LYrA==
X-Gm-Message-State: APjAAAW9nc7pUPEs7FLJFKmP69UKFllgPtvRnmAskiB8h/WVcCYjCnWs
        cLVhGMKcgOpJ2cMBjPtF3nFgmg==
X-Google-Smtp-Source: APXvYqxEXxUWDtey3eMD1EC5zrNfQYCvUKw9iVpYTScQKTexusgNyu+PW7SoKPBIjtVjbZ8r+PoRyg==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr3336357wme.22.1576067798701;
        Wed, 11 Dec 2019 04:36:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id f207sm1600141wme.9.2019.12.11.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 04:36:37 -0800 (PST)
Date:   Wed, 11 Dec 2019 13:36:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
Message-ID: <20191211123635.GY624164@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:07:25AM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 11.12.19 um 10:58 schrieb Thomas Zimmermann:
> > Hi Gerd
> > 
> > Am 11.12.19 um 09:18 schrieb Gerd Hoffmann:
> >> Add caching field to drm_gem_shmem_object to specify the cachine
> >> attributes for mappings.  Add helper function to tweak pgprot
> >> accordingly.  Switch vmap and mmap functions to the new helper.
> >>
> >> Set caching to write-combine when creating the object so behavior
> >> doesn't change by default.  Drivers can override that later if
> >> needed.
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > If you want to merge this patch, you have my
> > 
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > 
> > Please see my comment below.
> > 
> >> ---
> >>  include/drm/drm_gem_shmem_helper.h     | 12 ++++++++++++
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c | 24 +++++++++++++++++++++---
> >>  2 files changed, 33 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> >> index 6748379a0b44..9d6e02c6205f 100644
> >> --- a/include/drm/drm_gem_shmem_helper.h
> >> +++ b/include/drm/drm_gem_shmem_helper.h
> >> @@ -17,6 +17,11 @@ struct drm_mode_create_dumb;
> >>  struct drm_printer;
> >>  struct sg_table;
> >>  
> >> +enum drm_gem_shmem_caching {
> >> +	DRM_GEM_SHMEM_CACHED = 1,
> >> +	DRM_GEM_SHMEM_WC,
> >> +};
> >> +
> >>  /**
> >>   * struct drm_gem_shmem_object - GEM object backed by shmem
> >>   */
> >> @@ -83,6 +88,11 @@ struct drm_gem_shmem_object {
> >>  	 * The address are un-mapped when the count reaches zero.
> >>  	 */
> >>  	unsigned int vmap_use_count;
> >> +
> >> +	/**
> >> +	 * @caching: caching attributes for mappings.
> >> +	 */
> >> +	enum drm_gem_shmem_caching caching;
> >>  };
> >>  
> >>  #define to_drm_gem_shmem_obj(obj) \
> >> @@ -130,6 +140,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
> >>  
> >>  struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_object *obj);
> >>  
> >> +pgprot_t drm_gem_shmem_caching(struct drm_gem_shmem_object *shmem, pgprot_t prot);
> >> +
> >>  /**
> >>   * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
> >>   *
> >> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> index a421a2eed48a..5bb94e130a50 100644
> >> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> @@ -76,6 +76,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
> >>  	mutex_init(&shmem->pages_lock);
> >>  	mutex_init(&shmem->vmap_lock);
> >>  	INIT_LIST_HEAD(&shmem->madv_list);
> >> +	shmem->caching = DRM_GEM_SHMEM_WC;
> >>  
> >>  	/*
> >>  	 * Our buffers are kept pinned, so allocating them
> >> @@ -256,9 +257,11 @@ static void *drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem)
> >>  
> >>  	if (obj->import_attach)
> >>  		shmem->vaddr = dma_buf_vmap(obj->import_attach->dmabuf);
> >> -	else
> >> +	else {
> >> +		pgprot_t prot = drm_gem_shmem_caching(shmem, PAGE_KERNEL);
> >>  		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
> >> -				    VM_MAP, pgprot_writecombine(PAGE_KERNEL));
> >> +				    VM_MAP, prot);
> >> +	}
> >>  
> >>  	if (!shmem->vaddr) {
> >>  		DRM_DEBUG_KMS("Failed to vmap pages\n");
> >> @@ -540,7 +543,8 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> >>  	}
> >>  
> >>  	vma->vm_flags |= VM_MIXEDMAP | VM_DONTEXPAND;
> >> -	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> >> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> >> +	vma->vm_page_prot = drm_gem_shmem_caching(shmem, vma->vm_page_prot);
> >>  	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> >>  	vma->vm_ops = &drm_gem_shmem_vm_ops;
> >>  
> >> @@ -683,3 +687,17 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
> >>  	return ERR_PTR(ret);
> >>  }
> >>  EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
> >> +
> >> +pgprot_t drm_gem_shmem_caching(struct drm_gem_shmem_object *shmem, pgprot_t prot)
> >> +{
> >> +	switch (shmem->caching) {
> >> +	case DRM_GEM_SHMEM_CACHED:
> >> +		return prot;
> >> +	case DRM_GEM_SHMEM_WC:
> >> +		return pgprot_writecombine(prot);
> >> +	default:
> >> +		WARN_ON_ONCE(1);
> >> +		return prot;
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL_GPL(drm_gem_shmem_caching);
> > 
> > Two reason why I'd reconsider this design.
> > 
> > I don't like switch statements new the bottom of the call graph. The
> > code ends up with default warnings, such as this one.
> > 
> > Udl has different caching flags for imported and 'native' buffers. This
> > would require a new constant and additional code here.
> > 
> > What do you think about turning this function into a callback in struct
> > shmem_funcs? The default implementation would be for WC, virtio would
> > use CACHED. The individual implementations could still be located in the
> > shmem code. Udl would later provide its own code.
> 
> On a second thought, all this might be over-engineered and v1 of the
> patchset was the correct approach. You can add my

The udl use-case should be covered already, simply set the flag correctly
at create/import time? It's per-object ...

btw on why udl does this: Imported bo are usually rendered by real hw, and
reading it uncached/wc is the more defensive setting. It would be kinda
nice if dma-buf would expose this, but I fear dma-api maintainers would
murder us if we even just propose that ... so it's a mess right now.

btw the issue extends to dma access by devices too, e.g. both i915 and
amdgpu can select the coherency mode at runtime (using e.g. the pcie
no-snoop transaction mode), and we have similar uncoordinated hacks in
there too, like in udl.
-Daniel

> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> if you prefer to merge v1.
> 
> > 
> > Best regards
> > Thomas
> > 
> >>
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
> 




> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
