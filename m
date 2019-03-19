Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77315C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287720811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfCSPbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:31:18 -0400
Received: from foss.arm.com ([217.140.101.70]:53938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfCSPbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:31:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E212C1650;
        Tue, 19 Mar 2019 08:31:17 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22D03F614;
        Tue, 19 Mar 2019 08:31:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:31:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     pierre Kuo <vichy.kuo@gmail.com>
Cc:     steven.price@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
Message-ID: <20190319153114.GI59586@arrakis.emea.arm.com>
References: <20190314032047.15790-1-vichy.kuo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314032047.15790-1-vichy.kuo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:20:47AM +0800, pierre Kuo wrote:
> in the previous case, initrd_start and initrd_end can be successfully
> returned either (base < memblock_start_of_DRAM()) or (base + size >
> memblock_start_of_DRAM() + linear_region_size).
> 
> That means even linear mapping range check fail for initrd_start and
> initrd_end, it still can get virtual address. Here we put
> initrd_start/initrd_end to be calculated only when linear mapping check
> pass.
> 
> Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")

For future versions, please also cc the author of the original commit
you are fixing.

> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
> Changes in v2:
> - add Fixes tag
> 
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

With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
after the place where you moved the initrd_{start,end} setting, which
would result in a different value for __phys_to_virt(phys_initrd_start).

-- 
Catalin
