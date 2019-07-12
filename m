Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA83EC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CF521019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 02:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfGLCgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:36:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfGLCgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 22:36:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94C912B;
        Thu, 11 Jul 2019 19:36:17 -0700 (PDT)
Received: from [10.162.41.115] (p8cg001049571a15.blr.arm.com [10.162.41.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6334B3F71F;
        Thu, 11 Jul 2019 19:36:12 -0700 (PDT)
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
To:     KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <14f02e29-77b2-29d9-a9f4-7f89ad0194f6@arm.com>
Date:   Fri, 12 Jul 2019 08:06:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2019 03:51 AM, KarimAllah Ahmed wrote:
> Some valid RAM can live outside kernel control (e.g. using mem= kernel
> command-line). For these regions, pfn_valid would return "false" causing
> system RAM to be mapped as uncached. Use memblock instead to identify RAM.

Once the remaining memory is outside of the kernel (as the admin would have
intended with mem= command line) what is the particular concern regarding
the way those get mapped (cached or not) ? It is not to be used any way.

> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Enrico Weigelt <info@metux.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Jun Yao <yaojun8558363@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/arm/mm/mmu.c   | 2 +-
>  arch/arm64/mm/mmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 1aa2586..492774b 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -705,7 +705,7 @@ static void __init build_mem_type_table(void)
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> -	if (!pfn_valid(pfn))
> +	if (!memblock_is_memory(__pfn_to_phys(pfn)))
>  		return pgprot_noncached(vma_prot);
>  	else if (file->f_flags & O_SYNC)
>  		return pgprot_writecombine(vma_prot);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3645f29..cdc3e8e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -78,7 +78,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> -	if (!pfn_valid(pfn))
> +	if (!memblock_is_memory(__pfn_to_phys(pfn)))

pfn_valid() on arm64 checks if the memblock region is mapped i.e does it have
a linear mapping or not. If a segment of RAM is outside linear mapping due to
mem= directive and lacks a linear mapping then why should it be mapped similarly
like system RAM on this path ?
