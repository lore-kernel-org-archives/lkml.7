Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC10C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12620803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575467544;
	bh=V6Gj/Ytw+aNJbwrZb5FlzVR9x/kwppVvvzKUaj1C5X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLbjz02cLEu9V4ATVijO/a+EmKc3aemwCpx9aoPXDt/DH8YFAbPpT96tehbfGuuED
	 1c2X9EhYfwCKg6P6x+zWQO2MLe7ahuwotqBrV7rk+j8qyEmrkRpGHn5cPhl02RcpgF
	 GU//RM5tIxEVdvHbz2RXOPCtnQxkw9tKNErJsfiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfLDNwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:52:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52218 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfLDNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:52:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so7089711wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=An6Y7n87V4cec/ZG6X9jG6nGGaBG7D9uoUb5EJBRrQA=;
        b=UaKiZtstJ1osZaQ6Q5EdGjkBXgHwl6QTE8aFiUKuypLHNVG1JJqToPTHQYvMzYp9MW
         C1PyH4l3BuWKlk+66vfpK8GnFmQY5aAUilyaGGh2+MIG4D0A1Y4XRd+oD+xr8rf2a80y
         bV9HkRtua9/5qI1Sq87+vYYDprU16ECbflU+xIYOuyjxaH0OXisZ6YD2QDvBmBFFpzdk
         MpxwnsGHDFi5VSBG35BFNLnfi4dJ48i0y8HslQqV9Y8tUC0pZapfX0N/RwvB8QDqkHBl
         D14lYo9ULq5XyPUUxAk70lFDWThXPLhU0EJP/sXNIx8Wl8ISCXSfUlpa9p5/AvErhG9H
         4q+w==
X-Gm-Message-State: APjAAAUGfzxNhwLIuM/u1hjrrxdGJonVcFndnJv8nLNpAe4krTERfHDd
        jxIZOPskQz1OjFlpkBj/TOU=
X-Google-Smtp-Source: APXvYqwf4epbEO4cSbnKP1ihntMY5E8nPmRKTpkePIJQuwds3Lx4tk/ZGOCpzc9XmafoGcaajIJcCQ==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr27505155wma.162.1575467540467;
        Wed, 04 Dec 2019 05:52:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z11sm8279399wrt.82.2019.12.04.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:52:19 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:52:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
Message-ID: <20191204135219.GH25242@dhcp22.suse.cz>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203104853.4378-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-12-19 11:48:53, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> TTM graphics buffer objects may, transparently to user-space,  move
> between IO and system memory. When that happens, all PTEs pointing to the
> old location are zapped before the move and then faulted in again if
> needed. When that happens, the page protection caching mode- and
> encryption bits may change and be different from those of
> struct vm_area_struct::vm_page_prot.
> 
> We were using an ugly hack to set the page protection correctly.
> Fix that and instead use vmf_insert_mixed_prot() and / or
> vmf_insert_pfn_prot().
> Also get the default page protection from
> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
> This way we catch modifications done by the vm system for drivers that
> want write-notification.

So essentially this should have any new side effect on functionality it
is just making a hacky/ugly code less so? In other words what are the
consequences of having page protection inconsistent from vma's?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index e6495ca2630b..2098f8d4dfc5 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -173,7 +173,6 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  				    pgoff_t num_prefault)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> -	struct vm_area_struct cvma = *vma;
>  	struct ttm_buffer_object *bo = vma->vm_private_data;
>  	struct ttm_bo_device *bdev = bo->bdev;
>  	unsigned long page_offset;
> @@ -244,7 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		goto out_io_unlock;
>  	}
>  
> -	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
> +	prot = ttm_io_prot(bo->mem.placement, prot);
>  	if (!bo->mem.bus.is_iomem) {
>  		struct ttm_operation_ctx ctx = {
>  			.interruptible = false,
> @@ -260,7 +259,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		}
>  	} else {
>  		/* Iomem should not be marked encrypted */
> -		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
> +		prot = pgprot_decrypted(prot);
>  	}
>  
>  	/*
> @@ -284,10 +283,11 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		}
>  
>  		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed(&cvma, address,
> -					__pfn_to_pfn_t(pfn, PFN_DEV));
> +			ret = vmf_insert_mixed_prot(vma, address,
> +						    __pfn_to_pfn_t(pfn, PFN_DEV),
> +						    prot);
>  		else
> -			ret = vmf_insert_pfn(&cvma, address, pfn);
> +			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>  
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -319,7 +319,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>  	if (ret)
>  		return ret;
>  
> -	prot = vm_get_page_prot(vma->vm_flags);
> +	prot = vma->vm_page_prot;
>  	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
>  	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>  		return ret;
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
