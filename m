Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31980C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A712184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZjHqBp9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfGSJJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:09:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33115 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:09:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so33845405edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtZzlBozAbYs33LVUIdgRKWQT4+nE9KuwH2UHVZgB3w=;
        b=ZjHqBp9zPU97B6yu0PFP+IpJnNJhqSs8dAS/qOWxv7eQ+p+CLwdbOkJtg1AXn9QviR
         u70ayX/AeTUZCV4FUoyqg4/z3MvcNG0xlQyaVtc5baUN/RgkJZq6j8tHA32joQx0H/fh
         3FSXEXO0gR2Pu3A3WYc2oGTCZ5i1qL60fG3MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QtZzlBozAbYs33LVUIdgRKWQT4+nE9KuwH2UHVZgB3w=;
        b=eNp6ECg++CmNNLs+Ogma+Yfu6XF102NTqTiryH0q22aolrLRQHavxzI44ZLXfUvAKL
         tPNPeGSwUyuuHKryYnhD+wWJRoDteskrKJfALnBq/tcr6AQ9lMq+AoQM3cKB4cU92qzO
         K5CIxAd7cEy3CjaEwHBY2/GU4roOGm5MRsxEOyMab7bG1SLwxLwAze8Xd2uHuKghRY41
         hY2P/BkwBcpF/3jhLTL0Cjb133xSBaXePGf8cATB9kDZ7ffttp82uj1WmZdQdk2jl0LO
         XBqwkiATKxjpaKkg03m2Ua9EwR0rhkx/symEnpiYvHN4k/X93mUuO4w5CvQKwbw0gM96
         p0zQ==
X-Gm-Message-State: APjAAAUal2stZUadaBNryiXBDFPtN731L5hF33ebL/gNijoAxcaiJZ7q
        BgmR4Elj4SN5x6iTFT0iTGM=
X-Google-Smtp-Source: APXvYqz8f63eAZPRL6XnHtE9vjjY4sAq26Cn1bxQCf8vHh8X+UCGguYSp3llWAL+UCehKz+PuPqgWQ==
X-Received: by 2002:a17:906:2599:: with SMTP id m25mr39234387ejb.177.1563527393135;
        Fri, 19 Jul 2019 02:09:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b25sm8484369eda.38.2019.07.19.02.09.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 02:09:51 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:09:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/vgem: use normal cached mmap'ings
Message-ID: <20190719090949.GG15868@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>, Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>, linux-kernel@vger.kernel.org
References: <20190716164221.15436-1-robdclark@gmail.com>
 <20190716164221.15436-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716164221.15436-2-robdclark@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 09:42:15AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Since there is no real device associated with vgem, it is impossible to
> end up with appropriate dev->dma_ops, meaning that we have no way to
> invalidate the shmem pages allocated by vgem.  So, at least on platforms
> without drm_cflush_pages(), we end up with corruption when cache lines
> from previous usage of vgem bo pages get evicted to memory.
> 
> The only sane option is to use cached mappings.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Possibly we could dma_sync_*_for_{device,cpu}() on dmabuf attach/detach,
> although the ->gem_prime_{pin,unpin}() API isn't quite ideal for that as
> it is.  And that doesn't really help for drivers that don't attach/
> detach for each use.
> 
> But AFAICT vgem is mainly used for dmabuf testing, so maybe we don't
> need to care too much about use of cached mmap'ings.

Isn't this going to horribly break testing buffer sharing with SoC
devices? I'd assume they all expect writecombining mode to make sure stuff
is coherent?

Also could we get away with this by simply extending drm_cflush_pages for
those arm platforms where we do have a clflush instruction? Yes I know
that'll get people screaming, I'll shrug :-)

If all we need patch 1/2 for is this vgem patch then the auditing needed for
patch 1 doesn't look appealing ...
-Daniel

> 
>  drivers/gpu/drm/vgem/vgem_drv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 11a8f99ba18c..ccf0c3fbd586 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -259,9 +259,6 @@ static int vgem_mmap(struct file *filp, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
>  
> -	/* Keep the WC mmaping set by drm_gem_mmap() but our pages
> -	 * are ordinary and not special.
> -	 */
>  	vma->vm_flags = flags | VM_DONTEXPAND | VM_DONTDUMP;
>  	return 0;
>  }
> @@ -382,7 +379,7 @@ static void *vgem_prime_vmap(struct drm_gem_object *obj)
>  	if (IS_ERR(pages))
>  		return NULL;
>  
> -	return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
> +	return vmap(pages, n_pages, 0, PAGE_KERNEL);
>  }
>  
>  static void vgem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
> @@ -411,7 +408,7 @@ static int vgem_prime_mmap(struct drm_gem_object *obj,
>  	fput(vma->vm_file);
>  	vma->vm_file = get_file(obj->filp);
>  	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
> -	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
