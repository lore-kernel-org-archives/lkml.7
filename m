Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2372C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F83020818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551474596;
	bh=nlkMewMz0qAEgjKrUhDUDxY8LMfcqRB0ad3+SqMqqHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bY/NYGmAnKfU8iK2/XUCt4TDN4ypw5gSUOMN+hKV27jsiDuEP5XyvuewZRzV4Gg+9
	 d18ELxtKYDd8P8PeRVn+dR0nbCu3lZ3ovpdeZ5FrqbJMUORiolDm8WwLI6+YX1NB2C
	 7k8ixneIlOQawQM1pR+4kdtjzXwzHaJmgVJJa8i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCAVJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:09:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCAVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:09:54 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 826EFDD20;
        Fri,  1 Mar 2019 21:09:53 +0000 (UTC)
Date:   Fri, 1 Mar 2019 13:09:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugepages: fix "orig_pud" set but not used
Message-Id: <20190301130951.67f419011da93265d36226cc@linux-foundation.org>
In-Reply-To: <20190301004903.89514-1-cai@lca.pw>
References: <20190301004903.89514-1-cai@lca.pw>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 19:49:03 -0500 Qian Cai <cai@lca.pw> wrote:

> The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
> hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
> its return code, so just make it void.
> 
> mm/huge_memory.c: In function 'zap_huge_pud':
> mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
> [-Wunused-but-set-variable]
>   pud_t orig_pud;
>         ^~~~~~~~
> 
> ...
>
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -167,11 +167,11 @@ static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *mm,
>  #endif
>  
>  #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR_FULL
> -static inline pud_t pudp_huge_get_and_clear_full(struct mm_struct *mm,
> -					    unsigned long address, pud_t *pudp,
> -					    int full)
> +static inline void pudp_huge_get_and_clear_full(struct mm_struct *mm,
> +						unsigned long address,
> +						pud_t *pudp, int full)
>  {
> -	return pudp_huge_get_and_clear(mm, address, pudp);
> +	pudp_huge_get_and_clear(mm, address, pudp);
>  }

Not sure this is a good change.  Future callers might want that return
value.

> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1979,7 +1979,6 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>  int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 pud_t *pud, unsigned long addr)
>  {
> -	pud_t orig_pud;
>  	spinlock_t *ptl;
>  
>  	ptl = __pud_trans_huge_lock(pud, vma);
> @@ -1991,8 +1990,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	 * pgtable_trans_huge_withdraw after finishing pudp related
>  	 * operations.
>  	 */
> -	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
> -			tlb->fullmm);
> +	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);

In fact this code perhaps should be passing orig_pud into
pudp_huge_get_and_clear_full().  That could depend on what future
per-arch implementations of pudp_huge_get_and_clear_full() choose to
do.

Anyway, I'll await Matthew's feedback.
