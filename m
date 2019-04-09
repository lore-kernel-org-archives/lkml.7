Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71319C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E0D2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HpebeSCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDIQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:47:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36052 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDIQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:47:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so9750463plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6aIEQqr4R4gOfrOi3rct1WB74s6+yXjXiuBb4szBCf4=;
        b=HpebeSCYawoEcbMN+6QuFlLUe77fo+zVLwaoDIZOLV+pPN4YfcP9AzhfgGYU2mcOD8
         c7KwNSsgVqIAsT8WBXXBHXQ8P5hFLRZKKnaYmSR7RWSA0vcFfb3+riseNRcWNcpwdvmd
         ku4Ex83SjfDt9OBKo/+Sn7z8zJzUXd1i9ltsT1BtRzt4ocNr0L8mAX70oOFbPzUWylPg
         2bAnmw4w7TOCbvikHk8bSL8bKdntRAwqiko9ks3/XQWw+4q2sanBI7dikOfaPcrSomhY
         XO1mpUSde4fHQQ5nLdAdC8YqCGYprmM3WcgY40ZBomdQcpTnIf2n2n8G29yr3Eq0rjE/
         hCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6aIEQqr4R4gOfrOi3rct1WB74s6+yXjXiuBb4szBCf4=;
        b=antGjnsxA60RGAWr8M8DbvH/25HNWLm2WBGnMEMROxyiMyCzZtWTF5DX/OX/l9XCgs
         4Sogg302mXmIRo6QN5e/18uDt+tP4wKV9Y/Ijq0m6+VEER+HPiMdQqj2hEGp+d+glxDE
         r5bYmczeShagNffoU1d+yuAd3wQxjdolydM+/7Y1CXzBOwUanxeiFxWtDfgeroGttpr6
         aHRXU3ohsqNfh2tGoafVZ0/h45e3AFF53UQR3slKXkDpoStK+FRWxKC2Y91Nd17CFC9d
         ahaMmnWE6N+ncd24cB4UbP9jkXYrTkeC0YJDzdpXwplGSUyA8LwBiAnSipAt3hbViTyZ
         mj8g==
X-Gm-Message-State: APjAAAXsutCVU4TaG1QagWnVQP1AUGFdfzvVG8ORFfRuBG7DwxFkntv1
        VGMIQELevawWdpdcKF2mxrNsS0IEq0Fn4w==
X-Google-Smtp-Source: APXvYqzLaQ6c4Z/yB7ObwPHC6aofumcMt318eZxT1bLBkiWxy6ZlT7XyuFIjaba5ff7kYfl+ke8SjQ==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr4403219plm.3.1554828464064;
        Tue, 09 Apr 2019 09:47:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b13sm26527071pfd.12.2019.04.09.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:47:43 -0700 (PDT)
Date:   Tue, 09 Apr 2019 09:47:43 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2019 09:47:31 PDT (-0700)
Subject:     Re: [PATCH 2/3] RISC-V: Make setup_vm() independent of GCC code model
In-Reply-To: <20190312220752.128141-3-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-3d9a3b8a-2d5d-4db8-b8b0-4ef410a9ad52@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 15:08:16 PDT (-0700), Anup Patel wrote:
> The setup_vm() must access kernel symbols in a position independent way
> because it will be called from head.S with MMU off.
>
> If we compile kernel with cmodel=medany then PC-relative addressing will
> be used in setup_vm() to access kernel symbols so it works perfectly fine.
>
> Although, if we compile kernel with cmodel=medlow then either absolute
> addressing or PC-relative addressing (based on whichever requires fewer
> instructions) is used to access kernel symbols in setup_vm(). This can
> break setup_vm() whenever any absolute addressing is used to access
> kernel symbols.
>
> With the movement of setup_vm() from kernel/setup.c to mm/init.c, the
> setup_vm() is now broken for cmodel=medlow but it works perfectly fine
> for cmodel=medany.
>
> This patch fixes setup_vm() and makes it independent of GCC code model
> by accessing kernel symbols relative to kernel load address instead of
> assuming PC-relative addressing.

I think we ended up with a cleaner solution as 387181dcdb6c ("RISC-V: Always 
compile mm/init.c with cmodel=medany and notrace"), but let me know if I missed 
something here.

>
> Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/head.S |  1 +
>  arch/riscv/mm/init.c     | 71 ++++++++++++++++++++++++++--------------
>  2 files changed, 47 insertions(+), 25 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fe884cd69abd..7966262b4f9d 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -62,6 +62,7 @@ clear_bss_done:
>  
>  	/* Initialize page tables and relocate to virtual addresses */
>  	la sp, init_thread_union + THREAD_SIZE
> +	la a0, _start
>  	call setup_vm
>  	call relocate
>  
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b379a75ac6a6..f35299f2f3d5 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -172,55 +172,76 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  	}
>  }
>  
> -asmlinkage void __init setup_vm(void)
> +static inline void *__early_va(void *ptr, uintptr_t load_pa)
>  {
>  	extern char _start;
> +	uintptr_t va = (uintptr_t)ptr;
> +	uintptr_t sz = (uintptr_t)(&_end) - (uintptr_t)(&_start);
> +
> +	if (va >= PAGE_OFFSET && va < (PAGE_OFFSET + sz))
> +		return (void *)(load_pa + (va - PAGE_OFFSET));
> +	return (void *)va;
> +}
> +
> +asmlinkage void __init setup_vm(uintptr_t load_pa)
> +{
>  	uintptr_t i;
> -	uintptr_t pa = (uintptr_t) &_start;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pmd_t *pmdp;
> +#endif
> +	pgd_t *pgdp;
> +	phys_addr_t map_pa;
> +	pgprot_t tableprot = __pgprot(_PAGE_TABLE);
>  	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
>  
> -	va_pa_offset = PAGE_OFFSET - pa;
> -	pfn_base = PFN_DOWN(pa);
> +	va_pa_offset = PAGE_OFFSET - load_pa;
> +	pfn_base = PFN_DOWN(load_pa);
>  
>  	/* Sanity check alignment and size */
>  	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
> -	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
> +	BUG_ON((load_pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> -	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
> -			__pgprot(_PAGE_TABLE));
> -	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
> +	pgdp = __early_va(trampoline_pg_dir, load_pa);
> +	map_pa = (uintptr_t)__early_va(trampoline_pmd, load_pa);
> +	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> +		pfn_pgd(PFN_DOWN(map_pa), tableprot);
> +	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(load_pa), prot);
> +
> +	pgdp = __early_va(swapper_pg_dir, load_pa);
>  
>  	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
>  		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
>  
> -		swapper_pg_dir[o] =
> -			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
> -				__pgprot(_PAGE_TABLE));
> +		map_pa = (uintptr_t)__early_va(swapper_pmd, load_pa);
> +		pgdp[o] = pfn_pgd(PFN_DOWN(map_pa) + i, tableprot);
>  	}
> +	pmdp = __early_va(swapper_pmd, load_pa);
>  	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
> -		swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
> +		pmdp[i] = pfn_pmd(PFN_DOWN(load_pa + i * PMD_SIZE), prot);
>  
> -	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pmd),
> -				__pgprot(_PAGE_TABLE));
> +	map_pa = (uintptr_t)__early_va(fixmap_pmd, load_pa);
> +	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> +		pfn_pgd(PFN_DOWN(map_pa), tableprot);
> +	pmdp = __early_va(fixmap_pmd, load_pa);
> +	map_pa = (uintptr_t)__early_va(fixmap_pte, load_pa);
>  	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =
> -		pfn_pmd(PFN_DOWN((uintptr_t)fixmap_pte),
> -				__pgprot(_PAGE_TABLE));
> +		pfn_pmd(PFN_DOWN(map_pa), tableprot);
>  #else
> -	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN(pa), prot);
> +	pgdp = __early_va(trampoline_pg_dir, load_pa);
> +	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> +		pfn_pgd(PFN_DOWN(load_pa), prot);
> +
> +	pgdp = __early_va(swapper_pg_dir, load_pa);
>  
>  	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
>  		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
>  
> -		swapper_pg_dir[o] =
> -			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
> +		pgdp[o] = pfn_pgd(PFN_DOWN(load_pa + i * PGDIR_SIZE), prot);
>  	}
>  
> -	swapper_pg_dir[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN((uintptr_t)fixmap_pte),
> -				__pgprot(_PAGE_TABLE));
> +	map_pa = (uintptr_t)__early_va(fixmap_pte, load_pa);
> +	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> +		pfn_pgd(PFN_DOWN(map_pa), tableprot);
>  #endif
>  }
> -- 
> 2.17.1
