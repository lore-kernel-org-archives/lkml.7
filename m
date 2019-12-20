Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44627C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA2227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOaH9Gox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLTBwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:52:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45080 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:52:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so6799506qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CCSISgtL7V8q9QzteOk0TtxD6M/0tQtEP4MUsyWTHdY=;
        b=gOaH9GoxzGYN498MOlNcrkcsTwVBFU5rEcYT0q8i6Gt7Xlz00HRMAfxIgfudrfEd3v
         mY/JFetkm4h7jGUNaWFVWbIt0hFRfM4oTe1FK0pgweSnospRz8tp6ZuvIUvm+Y67Zsr3
         DorRN3MY/Dn01rwI/p7EAIBQ/8MS5+MvYXVNTjNny7IpDjElbh6bR5C+uwrWOS3SC0af
         NOrONYHdm8wI6wJ4fp465deSnxdSj8yI6t1AmeIXF8mTi9xLE1lquWhIPtxhYQO8cr6c
         wFmR6NkvP1JKqfMdsuVXcymXSYzUGt7lPasrwHLQyjRcaAd8XJIet5B14Rtm+P1055aa
         yBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CCSISgtL7V8q9QzteOk0TtxD6M/0tQtEP4MUsyWTHdY=;
        b=qShGCaQdH28PspHwCdRDR5ENXeW4Skw8ErSF2IotzIwLNqwYEpJeiWtmHiMLfik3Ou
         MWTRL3djBT2I1BEuey7Iczsht9ShkW+sZ1l+3/j7dmRZg5bpbzATbl3JMVbrtD7bbdAO
         WaPv4VCGLz729ml0eRcxRp/xZamhXYtjH8IgvebjJ0R8Gp9EJuvOPx+X/5Euarorfiuv
         xQP8ZgRywjieHX68eDP2wp/P5n49/1l0mI8aReH4GmRUlOK1l8nOxHp8pwJqYAYPRoaK
         XyIV1bEO6NaqNoQPbz33Da/Tt/vhV5CWQluhWscJdcmJxLCWZ39Ykc37sxiSWd5gR8pt
         pcDg==
X-Gm-Message-State: APjAAAX4hXeHIxB4FQrjxjMisrhhQ6j/fjUOWFkbNlO/0Z0TBQuRLJqq
        5eIa+F0ujCjW9ZQXhHsMH9jmrO8ae94=
X-Google-Smtp-Source: APXvYqwZzRJYZaDplMj+cs7gO/EShqkHd/IVN0lblFKUygOJQPmh7grAKNTN8o+yJbQNopfjIqa2dg==
X-Received: by 2002:aed:2f45:: with SMTP id l63mr9965730qtd.221.1576806768487;
        Thu, 19 Dec 2019 17:52:48 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id f42sm2568030qta.0.2019.12.19.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:52:47 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:52:45 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20191220015245.GA7010@localhost.localdomain>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209231346.5602-1-Ashish.Kalra@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For SEV, all DMA to and from guest has to use shared
> (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> without requiring changes to device drivers. However,
> depending on workload being run, the default 64MB of SWIOTLB
> might not be enough and SWIOTLB may run out of buffers to
> use for DMA, resulting in I/O errors.
> 
> Increase the default size of SWIOTLB for SEV guests using
> a minimum value of 128MB and a maximum value of 512MB,
> determining on amount of provisioned guest memory.
> 
> The SWIOTLB default size adjustment is added as an
> architecture specific interface/callback to allow
> architectures such as those supporting memory encryption
> to adjust/expand SWIOTLB size for their use.

What if this was made dynamic? That is if there is a memory
pressure you end up expanding the SWIOTLB dynamically?

Also is it worth doing this calculation based on memory or
more on the # of PCI devices + their MMIO ranges size?

> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
> Changes in v2:
>  - Fix compile errors as
> Reported-by: kbuild test robot <lkp@intel.com>
> 
>  arch/x86/Kconfig           |  1 +
>  arch/x86/mm/mem_encrypt.c  | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/dma-direct.h | 10 ++++++++++
>  kernel/dma/Kconfig         |  3 +++
>  kernel/dma/swiotlb.c       | 14 ++++++++++++--
>  5 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..e75622e58d34 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1522,6 +1522,7 @@ config AMD_MEM_ENCRYPT
>  	select DYNAMIC_PHYSICAL_MASK
>  	select ARCH_USE_MEMREMAP_PROT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
>  	---help---
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index a03614bd3e1a..f4bd4b431ba1 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -376,6 +376,42 @@ bool force_dma_unencrypted(struct device *dev)
>  	return false;
>  }
>  
> +#define TOTAL_MEM_1G	0x40000000U
> +#define TOTAL_MEM_4G	0x100000000U
> +
> +/*
> + * Override for SWIOTLB default size adjustment -
> + * ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> + */
> +unsigned long adjust_swiotlb_default_size(unsigned long default_size)
> +{
> +	/*
> +	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> +	 * SEV uses SWOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
> +	 * run out of buffers for using DMA, resulting in I/O errors.
> +	 * Increase the default size of SWIOTLB for SEV guests using
> +	 * a minimum value of 128MB and a maximum value of 512GB,
> +	 * depending on amount of provisioned guest memory.
> +	 */
> +	if (sev_active()) {
> +		unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
> +
> +		if (total_mem <= TOTAL_MEM_1G)
> +			default_size = default_size * 2;
> +		else if (total_mem <= TOTAL_MEM_4G)
> +			default_size = default_size * 4;
> +		else
> +			default_size = default_size * 8;
> +
> +		pr_info_once("SEV is active, SWIOTLB default size set to %luMB\n",
> +			     default_size >> 20);
> +	}
> +
> +	return default_size;
> +}
> +
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_free_decrypted_mem(void)
>  {
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 24b8684aa21d..85507d21493f 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -35,6 +35,16 @@ static inline bool force_dma_unencrypted(struct device *dev)
>  }
>  #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  
> +#ifdef CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> +unsigned long adjust_swiotlb_default_size(unsigned long default_size);
> +#else
> +static inline unsigned long adjust_swiotlb_default_size
> +		(unsigned long default_size)
> +{
> +	return default_size;
> +}
> +#endif	/* CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT */
> +
>  /*
>   * If memory encryption is supported, phys_to_dma will set the memory encryption
>   * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 4c103a24e380..851c4500ff88 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -54,6 +54,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
>  config ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	bool
>  
> +config ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
> +	bool
> +
>  config DMA_NONCOHERENT_CACHE_SYNC
>  	bool
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9280d6f8271e..7dd72bd88f1c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -155,11 +155,21 @@ void swiotlb_set_max_segment(unsigned int val)
>  #define IO_TLB_DEFAULT_SIZE (64UL<<20)
>  unsigned long swiotlb_size_or_default(void)
>  {
> +	unsigned long default_size = IO_TLB_DEFAULT_SIZE;
>  	unsigned long size;
>  
> +	/*
> +	 * If swiotlb size/amount of slabs are not defined on kernel command
> +	 * line, then give a chance to architectures to adjust swiotlb
> +	 * size, this may be required by some architectures such as those
> +	 * supporting memory encryption.
> +	 */
> +	if (!io_tlb_nslabs)
> +		default_size = adjust_swiotlb_default_size(default_size);
> +
>  	size = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> -	return size ? size : (IO_TLB_DEFAULT_SIZE);
> +	return size ? size : default_size;
>  }
>  
>  void swiotlb_print_info(void)
> @@ -245,7 +255,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  void  __init
>  swiotlb_init(int verbose)
>  {
> -	size_t default_size = IO_TLB_DEFAULT_SIZE;
> +	unsigned long default_size = swiotlb_size_or_default();
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> -- 
> 2.17.1
> 
