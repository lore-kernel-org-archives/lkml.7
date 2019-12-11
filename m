Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1474C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEDC208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KJqVnq80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfLKMik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:38:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41053 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLKMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:38:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so23874529wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oilqMrWOmUSWqLKTGEJQYVnIb6Khy8rZQCIwVkV2EgI=;
        b=KJqVnq80OYD3nHpLiKB4RCWguQxg3gbAVtmRJIBQyahJ2cRtyqyDo24gpCh3PvkZOx
         6a8X1IW2qjx02ByMsUMiXPy8XLnFUMVkQWttRFIURRebr1Gin1WWVnxvmX3RkhXVr8NA
         u+L8IgnOyLqjKoBcQNBX5FpGthRxI5USPeFLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oilqMrWOmUSWqLKTGEJQYVnIb6Khy8rZQCIwVkV2EgI=;
        b=QWCUUGOIgbeE2PDV/LcQMFRjilzvT3Qgvg4I/XB8RgnXcV1K8DJkIQ8QUUeE4JPQn6
         D985adp8Ov771G4OYG3ZqSyX36HqrvCUyJ9vs4mCqmyaZvUKh6ZJOafU/YgCJwBQlKf/
         WphJvtsEWVdeUZsSF3RYXmVhOKi8KVMUUz4rleuagituWS8SIIwgmxNVJ6SZRQLOYPGF
         jVnljvO/Xiijxz2L3WKKYTcrUTWchKIdJ8NXPcY80axrQhf3TvMTrcvQPfxnhvtMs37Z
         vJ8VAwZZzdKZp1L1WoV7nINwmqhFKFH0Zg7vGn495lszpHglDD7wjkky6LKGKfhUKYT4
         l8nA==
X-Gm-Message-State: APjAAAUr/0FrwmOFaAG1VpEECFvGSX0m472hfo9qXuYD357TERkg1ttX
        3HuK36fsNWJ0fXc9JfEB9t+G2gG/mZs=
X-Google-Smtp-Source: APXvYqxNEgdkHL4Hk1D8WjL8Exvt/tX0nokfJtSU3/y8Vl7lUKInCWQgPwwg8G6SR3+J2hh8OSF6KQ==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr3767933wrj.357.1576067917745;
        Wed, 11 Dec 2019 04:38:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id n12sm2200963wmd.1.2019.12.11.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 04:38:37 -0800 (PST)
Date:   Wed, 11 Dec 2019 13:38:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        gurchetansingh@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] drm: add pgprot callback to drm_gem_object_funcs
Message-ID: <20191211123835.GZ624164@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        gurchetansingh@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20191211121957.18637-1-kraxel@redhat.com>
 <20191211121957.18637-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211121957.18637-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 01:19:53PM +0100, Gerd Hoffmann wrote:
> The callback allows drivers and helpers to tweak pgprot for mappings.
> This is especially helpful when using shmem helpers.  It allows drivers
> to switch mappings from writecombine (default) to something else (cached
> for example) on a per-object base without having to supply their own
> mmap() and vmap() functions.
> 
> The patch also adds two implementations for the callback, for cached and
> writecombine mappings, and the drm_gem_pgprot() function to update
> pgprot for a given object, using the new &drm_gem_object_funcs.pgprot
> callback if available.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem.h     | 15 +++++++++++++
>  drivers/gpu/drm/drm_gem.c | 46 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 0b375069cd48..5beef7226e69 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -163,6 +163,17 @@ struct drm_gem_object_funcs {
>  	 */
>  	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  
> +	/**
> +	 * @pgprot:
> +	 *
> +	 * Tweak pgprot as needed, typically used to set cache bits.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * If unset drm_gem_pgprot_wc() will be used.
> +	 */
> +	pgprot_t (*pgprot)(struct drm_gem_object *obj, pgprot_t prot);

I kinda prefer v1, mostly because this is a huge can of worms, and solving
this properly is going to be real hard (and will necessarily involve
dma-buf and dma-api and probably more). Charging ahead here just risks
that we dig ourselves into a corner. You're v1 is maybe not the most
clean, but just a few code bits here&there should be more flexible and
easier to hack on and experiment around with.
-Daniel

> +
>  	/**
>  	 * @vm_ops:
>  	 *
> @@ -350,6 +361,10 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  		     struct vm_area_struct *vma);
>  int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>  
> +pgprot_t drm_gem_pgprot_cached(struct drm_gem_object *obj, pgprot_t prot);
> +pgprot_t drm_gem_pgprot_wc(struct drm_gem_object *obj, pgprot_t prot);
> +pgprot_t drm_gem_pgprot(struct drm_gem_object *obj, pgprot_t prot);
> +
>  /**
>   * drm_gem_object_get - acquire a GEM buffer object reference
>   * @obj: GEM buffer object
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 56f42e0f2584..1c468fe8e342 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1119,7 +1119,8 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  			return -EINVAL;
>  
>  		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> -		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +		vma->vm_page_prot = drm_gem_pgprot(obj, vma->vm_page_prot);
>  		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>  	}
>  
> @@ -1210,6 +1211,49 @@ int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  }
>  EXPORT_SYMBOL(drm_gem_mmap);
>  
> +/**
> + * drm_gem_mmap - update pgprot for objects needing a cachable mapping.
> + * @obj: the GEM object.
> + * @prot: page attributes.
> + *
> + * This function can be used as &drm_gem_object_funcs.pgprot callback.
> + */
> +pgprot_t drm_gem_pgprot_cached(struct drm_gem_object *obj, pgprot_t prot)
> +{
> +	return prot;
> +}
> +EXPORT_SYMBOL(drm_gem_pgprot_cached);
> +
> +/**
> + * drm_gem_mmap - update pgprot for objects needing a wc mapping.
> + * @obj: the GEM object.
> + * @prot: page attributes.
> + *
> + * This function can be used as &drm_gem_object_funcs.pgprot callback.
> + */
> +pgprot_t drm_gem_pgprot_wc(struct drm_gem_object *obj, pgprot_t prot)
> +{
> +	return pgprot_writecombine(prot);
> +}
> +EXPORT_SYMBOL(drm_gem_pgprot_wc);
> +
> +/**
> + * drm_gem_mmap - update pgprot for a given gem object.
> + * @obj: the GEM object.
> + * @prot: page attributes.
> + *
> + * This function updates pgprot according to the needs of the given
> + * object.  If present &drm_gem_object_funcs.pgprot callback will be
> + * used, otherwise drm_gem_pgprot_wc() is called.
> + */
> +pgprot_t drm_gem_pgprot(struct drm_gem_object *obj, pgprot_t prot)
> +{
> +	if (obj->funcs->pgprot)
> +		return obj->funcs->pgprot(obj, prot);
> +	return drm_gem_pgprot_wc(obj, prot);
> +}
> +EXPORT_SYMBOL(drm_gem_pgprot);
> +
>  void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>  			const struct drm_gem_object *obj)
>  {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
