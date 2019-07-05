Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E1C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A2E216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfGEPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:11:09 -0400
Received: from foss.arm.com ([217.140.110.172]:41416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfGEPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:11:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BDE28;
        Fri,  5 Jul 2019 08:11:08 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DEBB3F246;
        Fri,  5 Jul 2019 08:11:05 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: free the initrd reserved memblock in a aligned
 manner
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        f.fainelli@gmail.com, logang@deltatee.com, robin.murphy@arm.com,
        ghackmann@android.com, hannes@cmpxchg.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, jiang.xuexin@zte.com.cn,
        Junhua Huang <huang.junhua@zte.com.cn>
References: <1562198340-19089-1-git-send-email-wang.yi59@zte.com.cn>
From:   James Morse <james.morse@arm.com>
Message-ID: <079e43f4-fa25-98fc-835d-c3f9b96cb14f@arm.com>
Date:   Fri, 5 Jul 2019 16:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562198340-19089-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/07/2019 00:59, Yi Wang wrote:
> From: Junhua Huang <huang.junhua@zte.com.cn>
> 
> We should free the reserved memblock in an aligned manner 
> because the initrd reserves the memblock in an aligned manner 
> in arm64_memblock_init(). 
> Otherwise there are some fragments in memblock_reserved regions. e.g.:
> /sys/kernel/debug/memblock # cat reserved 
>    0: 0x0000000080080000..0x00000000817fafff
>    1: 0x0000000083400000..0x0000000083ffffff
>    2: 0x0000000090000000..0x000000009000407f
>    3: 0x00000000b0000000..0x00000000b000003f
>    4: 0x00000000b26184ea..0x00000000b2618fff
> The fragments like the ranges from b0000000 to b000003f and 
> from b26184ea to b2618fff should be freed.
> 
> And we can do free_reserved_area() after memblock_free(),
> as free_reserved_area() calls __free_pages(), once we've done 
> that it could be allocated somewhere else, 
> but memblock and iomem still say this is reserved memory.
> 
> Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>

You need to add your own Signed-off-by after Junhua Huang's. This tells the maintainer
that you're providing the patch with the 'Developer's Certificate of Origin'. Details in
/Documentation/process/submitting-patches.rst.


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d2adffb81b5d..03774b8bd364 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -580,8 +580,13 @@ void free_initmem(void)
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +	unsigned long aligned_start, aligned_end;
> +
> +	aligned_start = __virt_to_phys(start) & PAGE_MASK;
> +	aligned_end = PAGE_ALIGN(__virt_to_phys(end));

> +	memblock_free(aligned_end, aligned_end - aligned_start);

We're not free-ing the same memory as we reserved here!
(start/end typo)

>  	free_reserved_area((void *)start, (void *)end, 0, "initrd");
> -	memblock_free(__virt_to_phys(start), end - start);
> +

(stray newline)

>  }
>  #endif


Thanks,

James
