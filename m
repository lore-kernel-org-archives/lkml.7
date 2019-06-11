Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CBAC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4386B205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405393AbfFKKT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:19:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404766AbfFKKT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8662337;
        Tue, 11 Jun 2019 03:19:26 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6DF3F557;
        Tue, 11 Jun 2019 03:21:07 -0700 (PDT)
Subject: Re: [PATCH 03/17] mm/nommu: fix the MAP_UNINITIALIZED flag
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190610221621.10938-1-hch@lst.de>
 <20190610221621.10938-4-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <c902f38f-071d-cc83-801d-04d600f5ec12@arm.com>
Date:   Tue, 11 Jun 2019 11:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610221621.10938-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 11:16 PM, Christoph Hellwig wrote:
> We can't expose UAPI symbols differently based on CONFIG_ symbols, as
> userspace won't have them available.  Instead always define the flag,
> but only repsect it based on the config option.
           ^^^^^^^
           respect
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/xtensa/include/uapi/asm/mman.h    | 6 +-----
>  include/uapi/asm-generic/mman-common.h | 8 +++-----
>  mm/nommu.c                             | 4 +++-
>  3 files changed, 7 insertions(+), 11 deletions(-)

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> 
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index be726062412b..ebbb48842190 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -56,12 +56,8 @@
>  #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
>  #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
> -#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
> -# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> +#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> -#else
> -# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
> -#endif
>  
>  /*
>   * Flags for msync
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index abd238d0f7a4..cb556b430e71 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -19,15 +19,13 @@
>  #define MAP_TYPE	0x0f		/* Mask for type of mapping */
>  #define MAP_FIXED	0x10		/* Interpret addr exactly */
>  #define MAP_ANONYMOUS	0x20		/* don't use a file */
> -#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
> -# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
> -#else
> -# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
> -#endif
>  
>  /* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
>  
> +#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
> +					 * uninitialized */
> +
>  /*
>   * Flags for mlock
>   */
> diff --git a/mm/nommu.c b/mm/nommu.c
> index d8c02fbe03b5..ec75a0dffd4f 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1349,7 +1349,9 @@ unsigned long do_mmap(struct file *file,
>  	add_nommu_region(region);
>  
>  	/* clear anonymous mappings that don't ask for uninitialized data */
> -	if (!vma->vm_file && !(flags & MAP_UNINITIALIZED))
> +	if (!vma->vm_file &&
> +	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
> +	     !(flags & MAP_UNINITIALIZED)))
>  		memset((void *)region->vm_start, 0,
>  		       region->vm_end - region->vm_start);
>  
> 

