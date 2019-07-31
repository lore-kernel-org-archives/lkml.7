Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C6C32754
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E14214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="drOrgd3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfGaTXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:23:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35359 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbfGaTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:23:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id g19so24722204ywe.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1IhWUibDQLseDXqQpLnxa3k3fUiM7zc73BWbDzvcQ0=;
        b=drOrgd3YRAV96SUw/xjEf7sepihUrJe3swKuACxg9X+Mwa5x4uLpNFAvzAz54W4TfI
         DrKXw0IpBlgkRAm8Ub3RLGHsr/R1OdX6u1odjKcENTt72EP0JoC9WD8l15rTb9dhdgA0
         DBbQBQHQiYXjLjtsDMCznTtUWT2xJwi3pZkEuCHyLFGdHe0xUOrjQZm2QPn+1TiRuHBf
         mwZnYOy1JAJlpjYkOjmVbJZa5EBUNMXkfl9JQxNLRANGl4onKFcg9+WyPwaxMi3bfCF0
         fRr+gH74o7MoFLyoxcI7zMVz8amwDhzigA7fO3rKQttnmq6ZZFMVV824QSEa+X/OcakB
         /CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1IhWUibDQLseDXqQpLnxa3k3fUiM7zc73BWbDzvcQ0=;
        b=dHMU0DDVpX8gyhq6mb+fLtRhiz19CibcocTfjeFLOK/PI0j4UKOZ9Byydl1wrIeNJC
         3TwiLs74LachxAi6BoojhQs35DhIXD9C+twZ6k6Tpi6zixEisZLqG54zleA0/Zr2GjWi
         zaXosgl0Yr5ucsmXNB89HJlP3p4VD+zARqFRU2iGdzRliZyFV+BA17NhAPje1qifdh1g
         Ozmt2EF7U95qlQmeinpFmwV41LKXDUvkB4RIeNhJv1VYKH4PJqEAeKw44SGyMBcaIJBe
         gdZlgj4C83sAyrcAmXLFU5HkcYJW01VbRbj0xYn238myJwz3cA/Tf1R0P5XIJdBK7GdZ
         gS8w==
X-Gm-Message-State: APjAAAXEpSOW2gRE0vuuS/pTAuD+7vbm1CJiVkEdjovFNf+oylcxBl5s
        VRnvXHKJUdXxf4fIrtJRHErXKw==
X-Google-Smtp-Source: APXvYqxqsVU+Lcy5NF8fKu+R0jvX1/J9dGU5EgivyF4/o+uCQ4cvUg8bGlAA09mHRbX4C5xyGM2dkg==
X-Received: by 2002:a81:6056:: with SMTP id u83mr71593285ywb.331.1564601012296;
        Wed, 31 Jul 2019 12:23:32 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d69sm15643532ywa.29.2019.07.31.12.23.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 12:23:31 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:23:31 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Eric Anholt <eric@anholt.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Imre Deak <imre.deak@intel.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vgem: fix cache synchronization on arm/arm64
Message-ID: <20190731192331.GT104440@art_vandelay>
References: <20190717211542.30482-1-robdclark@gmail.com>
 <20190719092153.GJ15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719092153.GJ15868@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:21:53AM +0200, Daniel Vetter wrote:
> On Wed, Jul 17, 2019 at 02:15:37PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
> > dma_sync API.
> > 
> > Fixes failures w/ vgem_test.
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > An alternative approach to the series[1] I sent yesterday
> > 
> > On the plus side, it keeps the WC buffers and avoids any drm core
> > changes.  On the minus side, I don't think it will work (at least
> > on arm64) prior to v5.0[2], so the fix can't be backported very
> > far.
> 
> Yeah seems a lot more reasonable.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Applied to drm-misc-fixes, thanks!

Sean

> > 
> > [1] https://patchwork.freedesktop.org/series/63771/
> > [2] depends on 356da6d0cde3323236977fce54c1f9612a742036
> > 
> >  drivers/gpu/drm/vgem/vgem_drv.c | 130 ++++++++++++++++++++------------
> >  1 file changed, 83 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> > index 76d95b5e289c..6c9b5e20b3d4 100644
> > --- a/drivers/gpu/drm/vgem/vgem_drv.c
> > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> > @@ -47,10 +47,16 @@ static struct vgem_device {
> >  	struct platform_device *platform;
> >  } *vgem_device;
> >  
> > +static void sync_and_unpin(struct drm_vgem_gem_object *bo);
> > +static struct page **pin_and_sync(struct drm_vgem_gem_object *bo);
> > +
> >  static void vgem_gem_free_object(struct drm_gem_object *obj)
> >  {
> >  	struct drm_vgem_gem_object *vgem_obj = to_vgem_bo(obj);
> >  
> > +	if (!obj->import_attach)
> > +		sync_and_unpin(vgem_obj);
> > +
> >  	kvfree(vgem_obj->pages);
> >  	mutex_destroy(&vgem_obj->pages_lock);
> >  
> > @@ -78,40 +84,15 @@ static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
> >  		return VM_FAULT_SIGBUS;
> >  
> >  	mutex_lock(&obj->pages_lock);
> > +	if (!obj->pages)
> > +		pin_and_sync(obj);
> >  	if (obj->pages) {
> >  		get_page(obj->pages[page_offset]);
> >  		vmf->page = obj->pages[page_offset];
> >  		ret = 0;
> >  	}
> >  	mutex_unlock(&obj->pages_lock);
> > -	if (ret) {
> > -		struct page *page;
> > -
> > -		page = shmem_read_mapping_page(
> > -					file_inode(obj->base.filp)->i_mapping,
> > -					page_offset);
> > -		if (!IS_ERR(page)) {
> > -			vmf->page = page;
> > -			ret = 0;
> > -		} else switch (PTR_ERR(page)) {
> > -			case -ENOSPC:
> > -			case -ENOMEM:
> > -				ret = VM_FAULT_OOM;
> > -				break;
> > -			case -EBUSY:
> > -				ret = VM_FAULT_RETRY;
> > -				break;
> > -			case -EFAULT:
> > -			case -EINVAL:
> > -				ret = VM_FAULT_SIGBUS;
> > -				break;
> > -			default:
> > -				WARN_ON(PTR_ERR(page));
> > -				ret = VM_FAULT_SIGBUS;
> > -				break;
> > -		}
> >  
> > -	}
> >  	return ret;
> >  }
> >  
> > @@ -277,32 +258,93 @@ static const struct file_operations vgem_driver_fops = {
> >  	.release	= drm_release,
> >  };
> >  
> > -static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
> > +/* Called under pages_lock, except in free path (where it can't race): */
> > +static void sync_and_unpin(struct drm_vgem_gem_object *bo)
> >  {
> > -	mutex_lock(&bo->pages_lock);
> > -	if (bo->pages_pin_count++ == 0) {
> > -		struct page **pages;
> > +	struct drm_device *dev = bo->base.dev;
> > +
> > +	if (bo->table) {
> > +		dma_sync_sg_for_cpu(dev->dev, bo->table->sgl,
> > +				bo->table->nents, DMA_BIDIRECTIONAL);
> > +		sg_free_table(bo->table);
> > +		kfree(bo->table);
> > +		bo->table = NULL;
> > +	}
> > +
> > +	if (bo->pages) {
> > +		drm_gem_put_pages(&bo->base, bo->pages, true, true);
> > +		bo->pages = NULL;
> > +	}
> > +}
> > +
> > +static struct page **pin_and_sync(struct drm_vgem_gem_object *bo)
> > +{
> > +	struct drm_device *dev = bo->base.dev;
> > +	int npages = bo->base.size >> PAGE_SHIFT;
> > +	struct page **pages;
> > +	struct sg_table *sgt;
> > +
> > +	WARN_ON(!mutex_is_locked(&bo->pages_lock));
> > +
> > +	pages = drm_gem_get_pages(&bo->base);
> > +	if (IS_ERR(pages)) {
> > +		bo->pages_pin_count--;
> > +		mutex_unlock(&bo->pages_lock);
> > +		return pages;
> > +	}
> >  
> > -		pages = drm_gem_get_pages(&bo->base);
> > -		if (IS_ERR(pages)) {
> > -			bo->pages_pin_count--;
> > -			mutex_unlock(&bo->pages_lock);
> > -			return pages;
> > -		}
> > +	sgt = drm_prime_pages_to_sg(pages, npages);
> > +	if (IS_ERR(sgt)) {
> > +		dev_err(dev->dev,
> > +			"failed to allocate sgt: %ld\n",
> > +			PTR_ERR(bo->table));
> > +		drm_gem_put_pages(&bo->base, pages, false, false);
> > +		mutex_unlock(&bo->pages_lock);
> > +		return ERR_CAST(bo->table);
> > +	}
> > +
> > +	/*
> > +	 * Flush the object from the CPU cache so that importers
> > +	 * can rely on coherent indirect access via the exported
> > +	 * dma-address.
> > +	 */
> > +	dma_sync_sg_for_device(dev->dev, sgt->sgl,
> > +			sgt->nents, DMA_BIDIRECTIONAL);
> > +
> > +	bo->pages = pages;
> > +	bo->table = sgt;
> > +
> > +	return pages;
> > +}
> > +
> > +static struct page **vgem_pin_pages(struct drm_vgem_gem_object *bo)
> > +{
> > +	struct page **pages;
> >  
> > -		bo->pages = pages;
> > +	mutex_lock(&bo->pages_lock);
> > +	if (bo->pages_pin_count++ == 0 && !bo->pages) {
> > +		pages = pin_and_sync(bo);
> > +	} else {
> > +		WARN_ON(!bo->pages);
> > +		pages = bo->pages;
> >  	}
> >  	mutex_unlock(&bo->pages_lock);
> >  
> > -	return bo->pages;
> > +	return pages;
> >  }
> >  
> >  static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
> >  {
> > +	/*
> > +	 * We shouldn't hit this for imported bo's.. in the import
> > +	 * case we don't own the scatter-table
> > +	 */
> > +	WARN_ON(bo->base.import_attach);
> > +
> >  	mutex_lock(&bo->pages_lock);
> >  	if (--bo->pages_pin_count == 0) {
> > -		drm_gem_put_pages(&bo->base, bo->pages, true, true);
> > -		bo->pages = NULL;
> > +		WARN_ON(!bo->table);
> > +		sync_and_unpin(bo);
> >  	}
> >  	mutex_unlock(&bo->pages_lock);
> >  }
> > @@ -310,18 +352,12 @@ static void vgem_unpin_pages(struct drm_vgem_gem_object *bo)
> >  static int vgem_prime_pin(struct drm_gem_object *obj)
> >  {
> >  	struct drm_vgem_gem_object *bo = to_vgem_bo(obj);
> > -	long n_pages = obj->size >> PAGE_SHIFT;
> >  	struct page **pages;
> >  
> >  	pages = vgem_pin_pages(bo);
> >  	if (IS_ERR(pages))
> >  		return PTR_ERR(pages);
> >  
> > -	/* Flush the object from the CPU cache so that importers can rely
> > -	 * on coherent indirect access via the exported dma-address.
> > -	 */
> > -	drm_clflush_pages(pages, n_pages);
> > -
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
