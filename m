Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CB820857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfCADYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:24:23 -0500
Received: from ozlabs.org ([203.11.71.1]:59607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfCADYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:24:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 449ZXN0wlkz9sCJ;
        Fri,  1 Mar 2019 14:24:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] powerpc: fix "sz" set but not used
In-Reply-To: <20190228023505.80092-1-cai@lca.pw>
References: <20190228023505.80092-1-cai@lca.pw>
Date:   Fri, 01 Mar 2019 14:24:16 +1100
Message-ID: <87ef7rjmzj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> arch/powerpc/mm/hugetlbpage-hash64.c: In function '__hash_page_huge':
> arch/powerpc/mm/hugetlbpage-hash64.c:29:28: warning: variable 'sz' set
> but not used [-Wunused-but-set-variable]

It's always nice to know *why* it's not used.

It's unlikely, but not impossible, that it's a bug that the variable is
not used.

To find out why:

  $ git log --oneline -S sz arch/powerpc/mm/hugetlbpage-hash64.c
  0895ecda7942 powerpc/mm: Bring hugepage PTE accessor functions back into sync with normal accessors
  883a3e523672 powerpc/mm: Split hash MMU specific hugepage code into a new file

Then we look at those, and see the the first one did:

@@ -89,8 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
        if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
                /* No CPU has hugepages but lacks no execute, so we
                 * don't need to worry about that case */
-               rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
-                                                      trap, sz);
+               rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);


And if you read the commit log it's pretty clear the change was
deliberate and so sz should indeed be removed.

I've applied this as-is, no need to send a v2.

cheers

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 2e6a8f9345d3..f6b09edc5e6e 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -26,7 +26,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	real_pte_t rpte;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
> -	unsigned long rflags, pa, sz;
> +	unsigned long rflags, pa;
>  	long slot, offset;
>  
>  	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
> @@ -73,7 +73,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		offset = PTRS_PER_PMD;
>  	rpte = __real_pte(__pte(old_pte), ptep, offset);
>  
> -	sz = ((1UL) << shift);
>  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>  		/* No CPU has hugepages but lacks no execute, so we
>  		 * don't need to worry about that case */
> -- 
> 2.17.2 (Apple Git-113)
