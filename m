Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88714C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE16208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564589470;
	bh=wMw/vfv7591v5B2lTvWN47RNjbkh0FPCOeS3UTprHLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V4HyZ+2ILV18DGGKM8oc9AYy9oSVUdk70xWPFfVhB304COY8B/rIBHYLrkCkcza1Z
	 F5FrAus6pFY2zn2Mo4cvcd7Nz9iQihbf9n/ndw55aDVMouDQOBCcgL5qx1K+6NOPly
	 4lMdDT46g9Iab+9Bn60Euvq3nH5HJFU9PXvOERBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfGaQLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:11:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11533206A3;
        Wed, 31 Jul 2019 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564589468;
        bh=wMw/vfv7591v5B2lTvWN47RNjbkh0FPCOeS3UTprHLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWwb9h/LpO93Nj+dCkoUS/EpGOhXEKuyHtRHXJC6igJNZAwfQn0IYkY7GipJK9fRJ
         XReuRfvbRYRviqtwDUSADC6rOMJeYCvzl9f5WmQnPcH5pZvZXdZE4wp3fSsmA+9VBr
         U+kZr3/F/RT8+HUjng0iS0Bm/HZsFhsyWU9sfaag=
Date:   Wed, 31 Jul 2019 17:11:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 2/2] arm64/mm: Enable device memory allocation and free for
 vmemmap mapping
Message-ID: <20190731161103.kqv3v2xlq4vnyjhp@willie-the-truck>
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
 <1561697083-7329-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561697083-7329-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:14:43AM +0530, Anshuman Khandual wrote:
> This enables vmemmap_populate() and vmemmap_free() functions to incorporate
> struct vmem_altmap based device memory allocation and free requests. With
> this device memory with specific atlmap configuration can be hot plugged
> and hot removed as ZONE_DEVICE memory on arm64 platforms.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 57 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 39e18d1..8867bbd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -735,15 +735,26 @@ int kern_addr_valid(unsigned long addr)
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -static void free_hotplug_page_range(struct page *page, size_t size)
> +static void free_hotplug_page_range(struct page *page, size_t size,
> +				    struct vmem_altmap *altmap)
>  {
> -	WARN_ON(!page || PageReserved(page));
> -	free_pages((unsigned long)page_address(page), get_order(size));
> +	if (altmap) {
> +		/*
> +		 * vmemmap_populate() creates vmemmap mapping either at pte
> +		 * or pmd level. Unmapping request at any other level would
> +		 * be a problem.
> +		 */
> +		WARN_ON((size != PAGE_SIZE) && (size != PMD_SIZE));
> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +	} else {
> +		WARN_ON(!page || PageReserved(page));
> +		free_pages((unsigned long)page_address(page), get_order(size));
> +	}
>  }
>  
>  static void free_hotplug_pgtable_page(struct page *page)
>  {
> -	free_hotplug_page_range(page, PAGE_SIZE);
> +	free_hotplug_page_range(page, PAGE_SIZE, NULL);
>  }
>  
>  static void free_pte_table(pmd_t *pmdp, unsigned long addr)
> @@ -807,7 +818,8 @@ static void free_pud_table(pgd_t *pgdp, unsigned long addr)
>  }
>  
>  static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
> -				    unsigned long end, bool sparse_vmap)
> +				    unsigned long end, bool sparse_vmap,
> +				    struct vmem_altmap *altmap)

Do you still need the sparse_vmap parameter, or can you just pass a NULL
altmap pointer when sparse_vmap is false?

Will
