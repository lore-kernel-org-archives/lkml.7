Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3634EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E0E2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfHHHHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:07:06 -0400
Received: from verein.lst.de ([213.95.11.211]:43827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfHHHHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:07:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3426E68B02; Thu,  8 Aug 2019 09:07:02 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:07:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau/hmm: map pages after migration
Message-ID: <20190808070701.GC29382@lst.de>
References: <20190807150214.3629-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190807150214.3629-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 08:02:14AM -0700, Ralph Campbell wrote:
> When memory is migrated to the GPU it is likely to be accessed by GPU
> code soon afterwards. Instead of waiting for a GPU fault, map the
> migrated memory into the GPU page tables with the same access permissions
> as the source CPU page table entries. This preserves copy on write
> semantics.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> ---
> 
> This patch is based on top of Christoph Hellwig's 9 patch series
> https://lore.kernel.org/linux-mm/20190729234611.GC7171@redhat.com/T/#u
> "turn the hmm migrate_vma upside down" but without patch 9
> "mm: remove the unused MIGRATE_PFN_WRITE" and adds a use for the flag.

This looks useful.  I've already dropped that patch for the pending
resend.

>  static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
> -		struct vm_area_struct *vma, unsigned long addr,
> -		unsigned long src, dma_addr_t *dma_addr)
> +		struct vm_area_struct *vma, unsigned long src,
> +		dma_addr_t *dma_addr, u64 *pfn)

I'll pick up the removal of the not needed addr argument for the patch
introducing nouveau_dmem_migrate_copy_one, thanks,

>  static void nouveau_dmem_migrate_chunk(struct migrate_vma *args,
> -		struct nouveau_drm *drm, dma_addr_t *dma_addrs)
> +		struct nouveau_drm *drm, dma_addr_t *dma_addrs, u64 *pfns)
>  {
>  	struct nouveau_fence *fence;
>  	unsigned long addr = args->start, nr_dma = 0, i;
>  
>  	for (i = 0; addr < args->end; i++) {
>  		args->dst[i] = nouveau_dmem_migrate_copy_one(drm, args->vma,
> -				addr, args->src[i], &dma_addrs[nr_dma]);
> +				args->src[i], &dma_addrs[nr_dma], &pfns[i]);

Nit: I find the &pfns[i] way to pass the argument a little weird to read.
Why not "pfns + i"?

> +u64 *
> +nouveau_pfns_alloc(unsigned long npages)
> +{
> +	struct nouveau_pfnmap_args *args;
> +
> +	args = kzalloc(sizeof(*args) + npages * sizeof(args->p.phys[0]),

Can we use struct_size here?

> +	int ret;
> +
> +	if (!svm)
> +		return;
> +
> +	mutex_lock(&svm->mutex);
> +	svmm = nouveau_find_svmm(svm, mm);
> +	if (!svmm) {
> +		mutex_unlock(&svm->mutex);
> +		return;
> +	}
> +	mutex_unlock(&svm->mutex);

Given that nouveau_find_svmm doesn't take any kind of reference, what
gurantees svmm doesn't go away after dropping the lock?

> @@ -44,5 +49,19 @@ static inline int nouveau_svmm_bind(struct drm_device *device, void *p,
>  {
>  	return -ENOSYS;
>  }
> +
> +u64 *nouveau_pfns_alloc(unsigned long npages)
> +{
> +	return NULL;
> +}
> +
> +void nouveau_pfns_free(u64 *pfns)
> +{
> +}
> +
> +void nouveau_pfns_map(struct nouveau_drm *drm, struct mm_struct *mm,
> +		      unsigned long addr, u64 *pfns, unsigned long npages)
> +{
> +}
>  #endif /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */

nouveau_dmem.c and nouveau_svm.c are both built conditional on
CONFIG_DRM_NOUVEAU_SVM, so there is no need for stubs here.
