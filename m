Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1E20679
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ftQWZpEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKUN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:56:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42976 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:56:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so4498783wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UubM55Y2EgXgiJCPt2qtJJuRBgNrWumSBH0CC5Jm0oA=;
        b=ftQWZpErN2LjL6KC+9a4WcOLpNT2jG9JyPfAtggsGPCizPAAFJ3TjDIew5M9QF0iIg
         nEAa1EPjVexrGO7DLNdw0wUlBET9OXlGNGK+TArUybGrL6TSySVtRA/PAr/mPriUSfKm
         QGdCsf/cVfDRGBwbYoh7gNgfrv6bQkSlAst+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UubM55Y2EgXgiJCPt2qtJJuRBgNrWumSBH0CC5Jm0oA=;
        b=B3/CphnNi6+tGs/dC2Mlbe02agZ5FoR0JYDTGeDrHu5AANv0r5pegw9TnsjRUAVjLo
         l5jJsEIJTmiJJeW0sQQncje3pxUjN/LzUTO4exY3M2wpiyDgi3l0QT9e5H4MBPp4j1So
         Fl54hYbv877KpjENl0/L36PG0/QpFYiLB+f8r4Qs+nzxnAYlpf4PrUTM5CMNsphz/boR
         Q3qgeUYekX7tc8i4whahWJlH3plO5bzClKNw2PD/KNTzQiQDmKraJmjLTpHvD13AbqdI
         UKyebEVHzEo6HnU+pTSCzTsPw285ptWtiUPRgQ97Q3d2nJwfRwvC4BjYBCoxjMdZXbmR
         rXJg==
X-Gm-Message-State: APjAAAWowvhPcHTU64jdc0bRtF3ISRpjkZsnPo4IdXBP8osPSQ8di7hu
        HmHSDpnLT0Uf2Ih1bBuRyMJ/GA==
X-Google-Smtp-Source: APXvYqwPyE2J/RcbdCdVdML0zcd1qcpUV5e1LfiFukam1/WYzTdrOBF+B6EQQb5NDgqCoQE6NflWUw==
X-Received: by 2002:adf:e881:: with SMTP id d1mr11072912wrm.296.1574344589143;
        Thu, 21 Nov 2019 05:56:29 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q25sm3438463wra.3.2019.11.21.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:56:28 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:56:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: call drm_gem_object_funcs.mmap with fake offset
Message-ID: <20191121135626.GG6236@phenom.ffwll.local>
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
 <20191121135259.GE6236@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121135259.GE6236@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.3.0-1-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:52:59PM +0100, Daniel Vetter wrote:
> On Thu, Nov 21, 2019 at 11:38:06AM +0100, Gerd Hoffmann wrote:
> > The fake offset is going to stay, so change the calling convention for
> > drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> > accordingly.
> 
> Please add to the commit message:
> 
> Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> handling for drm_gem_object_funcs.mmap") and on top then adds the fake
> offset to  drm_gem_prime_mmap to make sure all paths leading to
> obj->funcs->mmap are consistent.
> 
> Fixes: 83b8a6f242ea ("drm/gem: Fix mmap fake offset handling for drm_gem_object_funcs.mmap")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Rob Herring <robh@kernel.org>
> 
> With that also Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also added Rob to cc here.

Rob, can you pls take a look an ack? The sage took another turn :-)
-Daniel

> -Daniel
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/drm/drm_gem.h                  | 4 +---
> >  drivers/gpu/drm/drm_gem.c              | 3 ---
> >  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +++
> >  drivers/gpu/drm/drm_prime.c            | 3 +++
> >  drivers/gpu/drm/ttm/ttm_bo_vm.c        | 7 -------
> >  5 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 97a48165642c..0b375069cd48 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -159,9 +159,7 @@ struct drm_gem_object_funcs {
> >  	 *
> >  	 * The callback is used by by both drm_gem_mmap_obj() and
> >  	 * drm_gem_prime_mmap().  When @mmap is present @vm_ops is not
> > -	 * used, the @mmap callback must set vma->vm_ops instead. The @mmap
> > -	 * callback is always called with a 0 offset. The caller will remove
> > -	 * the fake offset as necessary.
> > +	 * used, the @mmap callback must set vma->vm_ops instead.
> >  	 */
> >  	int (*mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
> >  
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 2f2b889096b0..56f42e0f2584 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1106,9 +1106,6 @@ int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
> >  		return -EINVAL;
> >  
> >  	if (obj->funcs && obj->funcs->mmap) {
> > -		/* Remove the fake offset */
> > -		vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
> > -
> >  		ret = obj->funcs->mmap(obj, vma);
> >  		if (ret)
> >  			return ret;
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > index 0810d3ef6961..a421a2eed48a 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -528,6 +528,9 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> >  	struct drm_gem_shmem_object *shmem;
> >  	int ret;
> >  
> > +	/* Remove the fake offset */
> > +	vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
> > +
> >  	shmem = to_drm_gem_shmem_obj(obj);
> >  
> >  	ret = drm_gem_shmem_get_pages(shmem);
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index 0814211b0f3f..a9633bd241bb 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -714,6 +714,9 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> >  	int ret;
> >  
> >  	if (obj->funcs && obj->funcs->mmap) {
> > +		/* Add the fake offset */
> > +		vma->vm_pgoff += drm_vma_node_start(&obj->vma_node);
> > +
> >  		ret = obj->funcs->mmap(obj, vma);
> >  		if (ret)
> >  			return ret;
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > index e6495ca2630b..3e8c3de91ae4 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > @@ -514,13 +514,6 @@ EXPORT_SYMBOL(ttm_bo_mmap);
> >  int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
> >  {
> >  	ttm_bo_get(bo);
> > -
> > -	/*
> > -	 * FIXME: &drm_gem_object_funcs.mmap is called with the fake offset
> > -	 * removed. Add it back here until the rest of TTM works without it.
> > -	 */
> > -	vma->vm_pgoff += drm_vma_node_start(&bo->base.vma_node);
> > -
> >  	ttm_bo_mmap_vma_setup(bo, vma);
> >  	return 0;
> >  }
> > -- 
> > 2.18.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
