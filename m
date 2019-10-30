Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AECA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B83D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJ3IOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfJ3IOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7637B1F2;
        Wed, 30 Oct 2019 08:14:06 +0000 (UTC)
Date:   Wed, 30 Oct 2019 09:14:04 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
Message-ID: <20191030081359.GA11931@linux>
References: <20191028165549.14478-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028165549.14478-1-iii@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:55:49PM +0100, Ilya Leoshkevich wrote:
> Building the kernel on s390 with -Og produces the following warning:
> 
> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
> The function populate_section_memmap() references
> the function __meminit __populate_section_memmap().
> This is often because populate_section_memmap lacks a __meminit
> annotation or the annotation of __populate_section_memmap is wrong.
> 
> While -Og is not supported, in theory this might still happen with
> another compiler or on another architecture. So fix this by using the
> correct section annotations.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/sparse.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..0f1f36443a96 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
>  	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>  }
>  
> -struct page __init *__populate_section_memmap(unsigned long pfn,
> +struct page __meminit *__populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	unsigned long size = section_map_size();
> @@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  #endif
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static struct page *populate_section_memmap(unsigned long pfn,
> +static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
> @@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
>  	vmemmap_free(start, end, NULL);
>  }
>  #else
> -struct page *populate_section_memmap(unsigned long pfn,
> +struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	struct page *page, *ret;

I did not really check deep, but I __think__ you only need to add __meminit in
populate_section_memmap functions.

__populate_section_memmap for SPARSE case is only used at init phase.


-- 
Oscar Salvador
SUSE L3
