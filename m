Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5910EC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF321852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UbPZ2T4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfIQN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:27:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35823 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIQN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:27:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so3346519eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6eMqyOrmPwOUbtSC5Cc7xqlKaVVcnN5VbQ6V4ue2nE=;
        b=UbPZ2T4TyN3TAMpujFnS01GCrYifUgvZufAG3WDvbLOcf++VejVa2rDDtLne6+Y0Fe
         UtVopVzB0GYZFIzq76jjc6YvV2JCZBWVWKem4zOv/bYq9fv7oX8VX4vH524ht5SIhMoc
         fXsQRI7AcZFdKArsrUr2icGOAHokN3DRVfAAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=O6eMqyOrmPwOUbtSC5Cc7xqlKaVVcnN5VbQ6V4ue2nE=;
        b=gLRDcI46IKQ6u86axQ1jErvSsODA8L6kUXXbpPXWYQ/m2ITQ4WlsREpVVko1mWBHTF
         CR5occuLnJ/S5BDCD0Ij0JcyjF0LC2Y7mG5BWpPRZnAogU8aGM2ku8KCzAA1EwDE09OP
         W7CGxa8op7YCCRbRYkvPBhaXgy50w7FELEu2Z18c3MnNCJB5vODR9Y5u7m2L1y24M0Nw
         hMwZ9SS/3mDFClO7LpqJjbvr/ErYrRRF4FlsaVajhpP1UsdVjoippkPKyIKhiF/czvvv
         zmh9I49ccPeytN7QEXxJJ/rw0PD1p3hCvTG7WTYzOrD80fq47WEg3BHet9Ocj6rw2kKR
         6k2A==
X-Gm-Message-State: APjAAAVF1Uhe+AUzwi1X3SoSS1vxRlsMqn3O4C23WoTDMppUnGFj9C0+
        tw4dNjQV+mY1BoO5LLideH9TrA==
X-Google-Smtp-Source: APXvYqzmF8qSqPVqVRnbhohxsJoNzNouEfGMD8JAe/nPED9ctPiNhZDWRc46BFU9ZBiWPQBM1jMXRA==
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr4775483ejy.183.1568726824012;
        Tue, 17 Sep 2019 06:27:04 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l7sm433594edv.84.2019.09.17.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 06:27:03 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:27:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] drm: add mmap() to drm_gem_object_funcs
Message-ID: <20190917132701.GW3958@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913122908.784-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:29:01PM +0200, Gerd Hoffmann wrote:
> drm_gem_object_funcs->vm_ops alone can't handle everything which needs
> to be done for mmap(), tweaking vm_flags for example.  So add a new
> mmap() callback to drm_gem_object_funcs where this code can go to.
> 
> Note that the vm_ops field is not used in case the mmap callback is
> presnt, it is expected that the callback sets vma->vm_ops instead.
> 
> drm_gem_mmap_obj() will use the new callback for object specific mmap
> setup.  With this in place the need for driver-speific fops->mmap
> callbacks goes away, drm_gem_mmap can be hooked instead.
> 
> drm_gem_prime_mmap() will use the new callback too to just mmap gem
> objects directly instead of jumping though loops to make
> drm_gem_object_lookup() and fops->mmap work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem.h       | 14 ++++++++++++++
>  drivers/gpu/drm/drm_gem.c   | 27 ++++++++++++++++++---------
>  drivers/gpu/drm/drm_prime.c |  9 +++++++++
>  3 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 6aaba14f5972..e71f75a2ab57 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -150,6 +150,20 @@ struct drm_gem_object_funcs {
>  	 */
>  	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
>  
> +	/**
> +	 * @mmap:
> +	 *
> +	 * Handle mmap() of the gem object, setup vma accordingly.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * The callback is used by by both drm_gem_mmap_obj() and
> +	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
> +	 * used, the @mmap callback must set vma->vm_ops instead.
> +	 *
> +	 */
> +	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
> +
>  	/**
>  	 * @vm_ops:
>  	 *
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6854f5867d51..56f42e0f2584 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1099,22 +1099,31 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  		     struct vm_area_struct *vma)
>  {
>  	struct drm_device *dev = obj->dev;
> +	int ret;
>  
>  	/* Check for valid size. */
>  	if (obj_size < vma->vm_end - vma->vm_start)
>  		return -EINVAL;
>  
> -	if (obj->funcs && obj->funcs->vm_ops)
> -		vma->vm_ops = obj->funcs->vm_ops;
> -	else if (dev->driver->gem_vm_ops)
> -		vma->vm_ops = dev->driver->gem_vm_ops;
> -	else
> -		return -EINVAL;
> +	if (obj->funcs && obj->funcs->mmap) {
> +		ret = obj->funcs->mmap(obj, vma);
> +		if (ret)
> +			return ret;
> +		WARN_ON(!(vma->vm_flags & VM_DONTEXPAND));

Yeah I think checking for VM_DONTEXPAND is even better than checking for
just VM_SPECIAL.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +	} else {
> +		if (obj->funcs && obj->funcs->vm_ops)
> +			vma->vm_ops = obj->funcs->vm_ops;
> +		else if (dev->driver->gem_vm_ops)
> +			vma->vm_ops = dev->driver->gem_vm_ops;
> +		else
> +			return -EINVAL;
> +
> +		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> +		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +	}
>  
> -	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
>  	vma->vm_private_data = obj;
> -	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> -	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>  
>  	/* Take a ref for this mapping of the object, so that the fault
>  	 * handler can dereference the mmap offset's pointer to the object.
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 0a2316e0e812..0814211b0f3f 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -713,6 +713,15 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  	struct file *fil;
>  	int ret;
>  
> +	if (obj->funcs && obj->funcs->mmap) {
> +		ret = obj->funcs->mmap(obj, vma);
> +		if (ret)
> +			return ret;
> +		vma->vm_private_data = obj;
> +		drm_gem_object_get(obj);
> +		return 0;
> +	}
> +
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	fil = kzalloc(sizeof(*fil), GFP_KERNEL);
>  	if (!priv || !fil) {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
