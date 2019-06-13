Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A64C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E71208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFMVh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:37:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:44112 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfFMVhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:37:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:37:55 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2019 14:37:54 -0700
Date:   Thu, 13 Jun 2019 14:39:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20190613213915.GE32404@iweiny-DESK2.sc.intel.com>
References: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
 <1560422702-11403-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560422702-11403-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:45:01PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> can't move. It would truncate CMA permanently and should be excluded.
> 
> FOLL_LONGTERM has already been checked in the slow path, but not checked in
> the fast path, which means a possible leak of CMA page to longterm pinned
> requirement through this crack.
> 
> Place a check in gup_pte_range() in the fast path.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 766ae54..de1b03f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1757,6 +1757,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> +		/*
> +		 * FOLL_LONGTERM suggests a pin given to hardware. Prevent it
> +		 * from truncating CMA area
> +		 */
> +		if (unlikely(flags & FOLL_LONGTERM) &&
> +			is_migrate_cma_page(page))
> +			goto pte_unmap;
> +
>  		head = try_get_compound_head(page, 1);
>  		if (!head)
>  			goto pte_unmap;
> @@ -1900,6 +1908,12 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	if (unlikely(flags & FOLL_LONGTERM) &&
> +		is_migrate_cma_page(page)) {
> +		*nr -= refs;
> +		return 0;
> +	}
> +

Why can't we place this check before the while loop and skip subtracting the
page count?

Can is_migrate_cma_page() operate on any "subpage" of a compound page? 

Here this calls is_magrate_cma_page() on the tail page of the compound page.

I'm not an expert on compound pages nor cma handling so is this ok?

It seems like you need to call is_migrate_cma_page() on each page within the
while loop?

>  	head = try_get_compound_head(pmd_page(orig), refs);
>  	if (!head) {
>  		*nr -= refs;
> @@ -1941,6 +1955,12 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	if (unlikely(flags & FOLL_LONGTERM) &&
> +		is_migrate_cma_page(page)) {
> +		*nr -= refs;
> +		return 0;
> +	}
> +

Same comment here.

>  	head = try_get_compound_head(pud_page(orig), refs);
>  	if (!head) {
>  		*nr -= refs;
> @@ -1978,6 +1998,12 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  		refs++;
>  	} while (addr += PAGE_SIZE, addr != end);
>  
> +	if (unlikely(flags & FOLL_LONGTERM) &&
> +		is_migrate_cma_page(page)) {
> +		*nr -= refs;
> +		return 0;
> +	}
> +

And here.

Ira

>  	head = try_get_compound_head(pgd_page(orig), refs);
>  	if (!head) {
>  		*nr -= refs;
> -- 
> 2.7.5
> 
