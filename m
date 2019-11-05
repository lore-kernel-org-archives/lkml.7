Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F986C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1135F20656
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfKEUO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:14:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfKEUO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:14:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A5727B9;
        Tue,  5 Nov 2019 12:14:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BC003FBF5;
        Tue,  5 Nov 2019 01:37:10 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:37:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: simplify the page end calculation in
 __create_pgd_mapping()
Message-ID: <20191105093708.GE4743@lakrids.cambridge.arm.com>
References: <20191103123559.8866-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103123559.8866-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 09:35:58PM +0900, Masahiro Yamada wrote:
> Calculate the page-aligned end address more simply.
> 
> The local variable, "length" is unneeded.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/mm/mmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 60c929f3683b..a9f541912289 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -338,7 +338,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  				 phys_addr_t (*pgtable_alloc)(int),
>  				 int flags)
>  {
> -	unsigned long addr, length, end, next;
> +	unsigned long addr, end, next;
>  	pgd_t *pgdp = pgd_offset_raw(pgdir, virt);
>  
>  	/*
> @@ -350,9 +350,8 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  
>  	phys &= PAGE_MASK;
>  	addr = virt & PAGE_MASK;
> -	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
> +	end = PAGE_ALIGN(virt + size);
>  
> -	end = addr + length;

While looking at this, I got confused by the old code and thought that
there was an existing bug, but I now see that's not the case, and the
old and new code are equivalent.

The new code looks cleaner, and leaves less room for confusion, so I
think that's preferable:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	do {
>  		next = pgd_addr_end(addr, end);
>  		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
> -- 
> 2.17.1
> 
