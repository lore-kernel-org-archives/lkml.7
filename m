Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C86F20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lhvXYLjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDIIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:40:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIIkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lacHWlCx5ytgox4JLsXW5Q6SwzY5b3yqibU9d2knw0I=; b=lhvXYLjqNNEbiT3kLHTdp3XKI
        ASSOv8ODxIXKQUX/xoJ/aVwyTitaWIPrvB5Sk4HEti2Jrg11MZ7v4HWuVGs2KIPc9+D/7psxqKxiP
        aDOxGb5uUSO0Z/UUZmyrHyQsydJdoHWoLiwgiVGaM2O9fj5mhXKJVxM6JvBUeoQyeaaYPy2Q2ZBMM
        dtVMSoebu6HpZHDqq1fK9pRaYIL7BVuD6VEpDLqxSIXFr1UNgZQU6chQipXQAxy43Bf+ZTqCaHjVX
        yHNPORoplXsJvCHiYFeC8Fd7xoWx8p0MXTFkeF/uklaKPwhLAYHOBFdN4DjrsvZhqQKKU81XKsOXz
        ZDImuaCxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDmIz-0006gc-0m; Tue, 09 Apr 2019 08:40:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5901E20CE1DC1; Tue,  9 Apr 2019 10:40:31 +0200 (CEST)
Date:   Tue, 9 Apr 2019 10:40:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Message-ID: <20190409084031.GO4038@hirez.programming.kicks-ass.net>
References: <20190408191103.13501-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408191103.13501-1-brijesh.singh@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:11:21PM +0000, Singh, Brijesh wrote:
> The following commit 0a9fe8ca844d ("x86/mm: Validate kernel_physical_mapping_init()
> PTE population") triggers the below warning in the SEV guest.
> 
> WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgalloc.h:87 phys_pmd_init+0x30d/0x386
> Call Trace:
>  kernel_physical_mapping_init+0xce/0x259
>  early_set_memory_enc_dec+0x10f/0x160
>  kvm_smp_prepare_boot_cpu+0x71/0x9d
>  start_kernel+0x1c9/0x50b
>  secondary_startup_64+0xa4/0xb0
> 
> The SEV guest calls kernel_physical_mapping_init() to clear the encryption
> mask from an existing mapping. While clearing the encryption mask
> kernel_physical_mapping_init() splits the large pages into the smaller.
> To split the page, the kernel_physical_mapping_init() allocates a new page
> and updates the existing entry. The set_{pud,pmd}_safe triggers warning
> when updating the entry with page in the present state. We should use the
> set_{pud,pmd} when updating an existing entry with the new entry.
> 
> Updating an entry will also requires a TLB flush. Currently the caller
> (early_set_memory_enc_dec()) is taking care of issuing the TLB flushes.

I'm not entirely sure I like this, this means all users of
kernel_physical_mapping_init() now need to be aware and careful.

That said; the alternative is adding an argument to the function and
propagating it through the callchain and dynamically switching between
_safe and not. Which doesn't sound ideal either.

Anybody else got clever ideas?

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Fixes: 0a9fe8ca844d (x86/mm: Validate kernel_physical_mapping_init() ...)
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> ---
>  arch/x86/mm/init_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index bccff68e3267..0a26b64a99b9 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -536,7 +536,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
>  		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot);
>  
>  		spin_lock(&init_mm.page_table_lock);
> -		pmd_populate_kernel_safe(&init_mm, pmd, pte);
> +		pmd_populate_kernel(&init_mm, pmd, pte);
>  		spin_unlock(&init_mm.page_table_lock);
>  	}
>  	update_page_count(PG_LEVEL_2M, pages);
> @@ -623,7 +623,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
>  					   page_size_mask, prot);
>  
>  		spin_lock(&init_mm.page_table_lock);
> -		pud_populate_safe(&init_mm, pud, pmd);
> +		pud_populate(&init_mm, pud, pmd);
>  		spin_unlock(&init_mm.page_table_lock);
>  	}
>  
> -- 
> 2.17.1
> 
