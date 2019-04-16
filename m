Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7056C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7262073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfDPLbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:31:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDPLbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:31:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46DF980D;
        Tue, 16 Apr 2019 04:31:02 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40093F68F;
        Tue, 16 Apr 2019 04:31:00 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:30:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: mm: check virtual addr in virt_to_page() if
 CONFIG_DEBUG_VIRTUAL=y
Message-ID: <20190416113057.GA28994@arrakis.emea.arm.com>
References: <1555349796-9456-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555349796-9456-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:36:36AM +0800, Miles Chen wrote:
> This change uses the original virt_to_page() (the one with __pa()) to
> check the given virtual address if CONFIG_DEBUG_VIRTUAL=y.
> 
> Recently, I worked on a bug: a driver passes a symbol address to
> dma_map_single() and the virt_to_page() (called by dma_map_single())
> does not work for non-linear addresses after commit 9f2875912dac
> ("arm64: mm: restrict virt_to_page() to the linear mapping").
> 
> I tried to trap the bug by enabling CONFIG_DEBUG_VIRTUAL but it
> did not work - bacause the commit removes the __pa() from
> virt_to_page() but CONFIG_DEBUG_VIRTUAL checks the virtual address
> in __pa()/__virt_to_phys().
> 
> A simple solution is to use the original virt_to_page()
> (the one with__pa()) if CONFIG_DEBUG_VIRTUAL=y.
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 290195168bb3..2cb8248fa2c8 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -302,7 +302,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>   */
>  #define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
>  
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_DEBUG_VIRTUAL)
>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>  #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
>  #else

IIUC, this shouldn't change the behaviour of virt_addr_valid(). The
patch looks fine to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
