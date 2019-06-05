Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C72C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29B120866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559769731;
	bh=luabeSBI+NDeNNs1bPDzPXdc1KFEqX8vdPe4qbBqNw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FmSASiS/cFyeRqgc/sA1pi5vgcleck/ryyVYxunIkfyhygqyLcpFAvgDQwkhF4U5S
	 2ZIPq3T5ig2+r/unKMcyLSxPs+bMJSpySmKWww5CiAEbNSj/UroKFvaIHN3f76dKOr
	 wp/b440dE1gKYdg5Wkud6HCjY7DxxBVbvG05cMiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFEVWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEVWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:22:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D082075B;
        Wed,  5 Jun 2019 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559769729;
        bh=luabeSBI+NDeNNs1bPDzPXdc1KFEqX8vdPe4qbBqNw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YTPX8cvxxCwoAex7vw0g8JtLmES94g7PgiPnJqkHt+xe1ONHDWZQSrXJ0FrCk8JrB
         ClmBf9NGKwpyxdLDZUg2It7G8FXCiHmxhwgASh6NXp9Ta8kOt2xt5cTpTObU4Nyc04
         aB1mUL1Kw6LQuqVep2fbOKyNKktXJB+HYgP0zcJw=
Date:   Wed, 5 Jun 2019 14:22:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
Message-Id: <20190605142209.eb30cd883551a5bd81b09f00@linux-foundation.org>
In-Reply-To: <20190605144814.29319-1-npiggin@gmail.com>
References: <20190605144814.29319-1-npiggin@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jun 2019 00:48:13 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> The kernel currently clamps large system hashes to MAX_ORDER when
> hashdist is not set, which is rather arbitrary.
> 
> vmalloc space is limited on 32-bit machines, but this shouldn't
> result in much more used because of small physical memory limiting
> system hash sizes.
> 
> Include "vmalloc" or "linear" in the kernel log message.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> This is a better solution than the previous one for the case of !NUMA
> systems running on CONFIG_NUMA kernels, we can clear the default
> hashdist early and have everything allocated out of the linear map.
> 
> The hugepage vmap series I will post later, but it's quite
> independent from this improvement.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7966,6 +7966,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	unsigned long log2qty, size;
>  	void *table = NULL;
>  	gfp_t gfp_flags;
> +	bool virt;
>  
>  	/* allow the kernel cmdline to have a say */
>  	if (!numentries) {
> @@ -8022,6 +8023,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  
>  	gfp_flags = (flags & HASH_ZERO) ? GFP_ATOMIC | __GFP_ZERO : GFP_ATOMIC;
>  	do {
> +		virt = false;
>  		size = bucketsize << log2qty;
>  		if (flags & HASH_EARLY) {
>  			if (flags & HASH_ZERO)
> @@ -8029,26 +8031,26 @@ void *__init alloc_large_system_hash(const char *tablename,
>  			else
>  				table = memblock_alloc_raw(size,
>  							   SMP_CACHE_BYTES);
> -		} else if (hashdist) {
> +		} else if (get_order(size) >= MAX_ORDER || hashdist) {
>  			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
> +			virt = true;
>  		} else {
>  			/*
>  			 * If bucketsize is not a power-of-two, we may free
>  			 * some pages at the end of hash table which
>  			 * alloc_pages_exact() automatically does
>  			 */
> -			if (get_order(size) < MAX_ORDER) {
> -				table = alloc_pages_exact(size, gfp_flags);
> -				kmemleak_alloc(table, size, 1, gfp_flags);
> -			}
> +			table = alloc_pages_exact(size, gfp_flags);
> +			kmemleak_alloc(table, size, 1, gfp_flags);
>  		}
>  	} while (!table && size > PAGE_SIZE && --log2qty);
>  
>  	if (!table)
>  		panic("Failed to allocate %s hash table\n", tablename);
>  
> -	pr_info("%s hash table entries: %ld (order: %d, %lu bytes)\n",
> -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size);
> +	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> +		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> +		virt ? "vmalloc" : "linear");

Could remove `bool virt' and use is_vmalloc_addr() in the printk?
