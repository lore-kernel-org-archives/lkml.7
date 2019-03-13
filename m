Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D523C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10B214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCMLpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:45:04 -0400
Received: from foss.arm.com ([217.140.101.70]:56582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfCMLpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:45:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF5E380D;
        Wed, 13 Mar 2019 04:45:03 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8D73F71D;
        Wed, 13 Mar 2019 04:45:02 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     pierre Kuo <vichy.kuo@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190312031720.6263-1-vichy.kuo@gmail.com>
Message-ID: <2515fbe8-1fc8-3ee4-716b-c2a7eb4ea824@arm.com>
Date:   Wed, 13 Mar 2019 11:45:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312031720.6263-1-vichy.kuo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 03:17, pierre Kuo wrote:
> in the previous case, initrd_start and initrd_end can be successfully
> returned even (base < memblock_start_of_DRAM()) or (base + size >
> memblock_start_of_DRAM() + linear_region_size).
> 
> That means even linear mapping range check fail for initrd_start and
> initrd_end, it still can get virtual address. Here we put
> initrd_start/initrd_end to be calculated only when linear mapping check
> pass.

From what I can see this was broken in commit c756c592e442ba101c91daed3524ba5b3a784ba6 ("arm64: Utilize phys_initrd_start/phys_initrd_size") which switched the condition for setting initrd_start/initrd_end to depending on phys_initrd_size (rather than initrd_start). This means that when the code detects the initrd is not fully accessible sets initrd_start = 0 it no longer has the desired effect.

So you might want to add a Fixes tag. Otherwise FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  arch/arm64/mm/init.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..1adf418de685 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -425,6 +425,9 @@ void __init arm64_memblock_init(void)
>  			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>  			memblock_add(base, size);
>  			memblock_reserve(base, size);
> +			/* the generic initrd code expects virtual addresses */
> +			initrd_start = __phys_to_virt(phys_initrd_start);
> +			initrd_end = initrd_start + phys_initrd_size;
>  		}
>  	}
>  
> @@ -450,11 +453,6 @@ void __init arm64_memblock_init(void)
>  	 * pagetables with memblock.
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
> -		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(phys_initrd_start);
> -		initrd_end = initrd_start + phys_initrd_size;
> -	}
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> 

