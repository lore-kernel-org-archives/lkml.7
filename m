Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855CC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4184221850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfC2CFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:05:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:55750 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfC2CFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:05:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 19:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="138333451"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 19:05:32 -0700
Date:   Thu, 28 Mar 2019 11:04:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/11] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem v2
Message-ID: <20190328180425.GI31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-10-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325144011.10560-10-jglisse@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:40:09AM -0400, Jerome Glisse wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> HMM mirror is a device driver helpers to mirror range of virtual address.
> It means that the process jobs running on the device can access the same
> virtual address as the CPU threads of that process. This patch adds support
> for mirroring mapping of file that are on a DAX block device (ie range of
> virtual address that is an mmap of a file in a filesystem on a DAX block
> device). There is no reason to not support such case when mirroring virtual
> address on a device.
> 
> Note that unlike GUP code we do not take page reference hence when we
> back-off we have nothing to undo.
> 
> Changes since v1:
>     - improved commit message
>     - squashed: Arnd Bergmann: fix unused variable warning in hmm_vma_walk_pud
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/hmm.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 111 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 64a33770813b..ce33151c6832 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -325,6 +325,7 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
>  
>  struct hmm_vma_walk {
>  	struct hmm_range	*range;
> +	struct dev_pagemap	*pgmap;
>  	unsigned long		last;
>  	bool			fault;
>  	bool			block;
> @@ -499,6 +500,15 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
>  				range->flags[HMM_PFN_VALID];
>  }
>  
> +static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
> +{
> +	if (!pud_present(pud))
> +		return 0;
> +	return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
> +				range->flags[HMM_PFN_WRITE] :
> +				range->flags[HMM_PFN_VALID];
> +}
> +
>  static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  			      unsigned long addr,
>  			      unsigned long end,
> @@ -520,8 +530,19 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
>  
>  	pfn = pmd_pfn(pmd) + pte_index(addr);
> -	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
> +	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +		if (pmd_devmap(pmd)) {
> +			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
> +					      hmm_vma_walk->pgmap);
> +			if (unlikely(!hmm_vma_walk->pgmap))
> +				return -EBUSY;
> +		}
>  		pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
> +	}
> +	if (hmm_vma_walk->pgmap) {
> +		put_dev_pagemap(hmm_vma_walk->pgmap);
> +		hmm_vma_walk->pgmap = NULL;
> +	}
>  	hmm_vma_walk->last = end;
>  	return 0;
>  }
> @@ -608,10 +629,24 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  	if (fault || write_fault)
>  		goto fault;
>  
> +	if (pte_devmap(pte)) {
> +		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
> +					      hmm_vma_walk->pgmap);
> +		if (unlikely(!hmm_vma_walk->pgmap))
> +			return -EBUSY;
> +	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
> +		*pfn = range->values[HMM_PFN_SPECIAL];
> +		return -EFAULT;
> +	}
> +
>  	*pfn = hmm_pfn_from_pfn(range, pte_pfn(pte)) | cpu_flags;

	<tag>

>  	return 0;
>  
>  fault:
> +	if (hmm_vma_walk->pgmap) {
> +		put_dev_pagemap(hmm_vma_walk->pgmap);
> +		hmm_vma_walk->pgmap = NULL;
> +	}
>  	pte_unmap(ptep);
>  	/* Fault any virtual address we were asked to fault */
>  	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> @@ -699,12 +734,83 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  			return r;
>  		}
>  	}
> +	if (hmm_vma_walk->pgmap) {
> +		put_dev_pagemap(hmm_vma_walk->pgmap);
> +		hmm_vma_walk->pgmap = NULL;
> +	}


Why is this here and not in hmm_vma_handle_pte()?  Unless I'm just getting
tired this is the corresponding put when hmm_vma_handle_pte() returns 0 above
at <tag> above.

Ira

