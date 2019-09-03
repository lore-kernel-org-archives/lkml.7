Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF5CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77C52087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WahOyVBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfICJtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:49:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36347 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfICJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:49:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so17933886edu.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEls2kUVvBcaBZpvYEuQESBA2MX/ZhbqTw7OA+f9Nbs=;
        b=WahOyVBEl0OVaAAIgzp1mXqBhNiSKi1rS1iYLd8wycHTbKi9/P+SA0o2wH8J4y5QPR
         e6OiZXQUwJKelCzLkw5rPDo2/QvL+Dd4Ih+zYTNICr6DnqQDCFNDX/UxfyFVlF2AMTJ4
         u7rovqA4TvuCbkOQOZXKzTLg9rORSmdP27cXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mEls2kUVvBcaBZpvYEuQESBA2MX/ZhbqTw7OA+f9Nbs=;
        b=M60q/hx21zbBSkmAFLkkfG0lR6sUIiYnPZU5mnx49/wpBa3ooIpF2q2shSVtLdq0aQ
         T7VXrYfp/A7vlwHFO1QKx7sKTNdOIn2zOoaqJp5LYnoOZENmNPXvoOklpPrYyEcnY7Y2
         mc6ZouEF03k/u9ymqa0uluwLue9TAhaHJFJFbuHI9IQXXPGhcnGqSLKdLLBd4/T9Dsrz
         kpnzKqiczAd2mRT0LfWP5Td4kuNPvQtRRHVKNsskDhVvAyeHmJdXNKuvwSLKrc7ZAeCR
         r1fQTADjFDWrBsHsSLf6BKv/2ZiDILwVWZpgsIC5iVYUPzpqeE4byRgbvpQvEHHIWn7b
         2f/A==
X-Gm-Message-State: APjAAAUC0jwlusWxxCkODtC/P3uoMndUe9JMYrt3NiMlPLnKdZj6I5UK
        8XiJ6/UHlqMAqdhddhnq4FlY4Q==
X-Google-Smtp-Source: APXvYqxY0hmUni95XwccqU3GO7ZXnZTxf/p+ya82BW6ix0VT35ImlZc/up0XizPcjgRP0ff5z5gp6Q==
X-Received: by 2002:a17:906:74d4:: with SMTP id z20mr16917924ejl.191.1567504142161;
        Tue, 03 Sep 2019 02:49:02 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id k16sm1860071ejv.87.2019.09.03.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:49:01 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:48:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/17] drm: add mmap() to drm_gem_object_funcs
Message-ID: <20190903094859.GQ2112@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190808134417.10610-1-kraxel@redhat.com>
 <20190808134417.10610-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808134417.10610-6-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:44:05PM +0200, Gerd Hoffmann wrote:
> drm_gem_object_funcs->vm_ops alone can't handle
> everything mmap() needs.  Add a new callback for it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem.h     | 9 +++++++++
>  drivers/gpu/drm/drm_gem.c | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index ae693c0666cd..ee3c4ad742c6 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -150,6 +150,15 @@ struct drm_gem_object_funcs {
>  	 */
>  	void (*vunmap)(struct drm_gem_object *obj, void *vaddr);
>  
> +	/**
> +	 * @mmap:
> +	 *
> +	 * Called by drm_gem_mmap() for additional checks/setup.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);

I think if we do an mmap callback, it should replace all the mmap handling
(except the drm_gem_object_get) that drm_gem_mmap_obj does. So maybe
something like the below:


diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6854f5867d51..e8b7779633dd 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1104,17 +1104,22 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 	if (obj_size < vma->vm_end - vma->vm_start)
 		return -EINVAL;
 
-	if (obj->funcs && obj->funcs->vm_ops)
-		vma->vm_ops = obj->funcs->vm_ops;
-	else if (dev->driver->gem_vm_ops)
-		vma->vm_ops = dev->driver->gem_vm_ops;
-	else
-		return -EINVAL;
-
-	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = obj;
-	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
-	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+
+	if (obj->funcs && obj->funcs->mmap)
+		obj->funcs->mmap(obj, vma);
+	else {
+		if (obj->funcs && obj->funcs->vm_ops)
+			vma->vm_ops = obj->funcs->vm_ops;
+		else if (dev->driver->gem_vm_ops)
+			vma->vm_ops = dev->driver->gem_vm_ops;
+		else
+			return -EINVAL;
+
+		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
+		vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	}
 
 	/* Take a ref for this mapping of the object, so that the fault
 	 * handler can dereference the mmap offset's pointer to the object.

Since I remember quite a few discussions where the default vma flag
wrangling we're doing is seriously getting in the way of things too.

I think even better would be if this new ->mmap hook could also be used
directly by the dma-buf mmap code, without having to jump through hoops
creating a fake file and fake vma offset and everything. I think with that
we'd have a really solid case to add this ->mmap hook.
-Daniel


> +
>  	/**
>  	 * @vm_ops:
>  	 *
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index afc38cece3f5..84db8de217e1 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1105,6 +1105,8 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  		vma->vm_ops = obj->funcs->vm_ops;
>  	else if (dev->driver->gem_vm_ops)
>  		vma->vm_ops = dev->driver->gem_vm_ops;
> +	else if (obj->funcs && obj->funcs->mmap)
> +		/* obj->funcs->mmap must set vma->vm_ops */;
>  	else
>  		return -EINVAL;
>  
> @@ -1192,6 +1194,10 @@ int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  	ret = drm_gem_mmap_obj(obj, drm_vma_node_size(node) << PAGE_SHIFT,
>  			       vma);
>  
> +	if (ret == 0)
> +		if (obj->funcs->mmap)
> +			ret = obj->funcs->mmap(obj, vma);
> +
>  	drm_gem_object_put_unlocked(obj);
>  
>  	return ret;
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
