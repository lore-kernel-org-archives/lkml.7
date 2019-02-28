Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE6C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1EF2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbfB1JkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:40:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfB1JkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:40:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AC1DAD36;
        Thu, 28 Feb 2019 09:40:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 764DB1E4263; Thu, 28 Feb 2019 10:40:11 +0100 (CET)
Date:   Thu, 28 Feb 2019 10:40:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>, mpe@ellerman.id.au,
        Ross Zwisler <zwisler@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Message-ID: <20190228094011.GB22210@quack2.suse.cz>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-02-19 14:05:22, Aneesh Kumar K.V wrote:
> Add a flag to indicate the ability to do huge page dax mapping. On architecture
> like ppc64, the hypervisor can disable huge page support in the guest. In
> such a case, we should not enable huge page dax mapping. This patch adds
> a flag which the architecture code will update to indicate huge page
> dax mapping support.
> 
> Architectures mostly do transparent_hugepage_flag = 0; if they can't
> do hugepages. That also takes care of disabling dax hugepage mapping
> with this change.
> 
> Without this patch we get the below error with kvm on ppc64.
> 
> [  118.849975] lpar: Failed hash pte insert with error -4
> 
> NOTE: The patch also use
> 
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> to disable dax huge page mapping.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Added Dan to CC for opinion. I kind of fail to see why you don't use
TRANSPARENT_HUGEPAGE_FLAG for this. I know that technically DAX huge pages
and normal THPs are different things but so far we've tried to avoid making
that distinction visible to userspace.

								Honza
> ---
> TODO:
> * Add Fixes: tag
> 
>  include/linux/huge_mm.h | 4 +++-
>  mm/huge_memory.c        | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 381e872bfde0..01ad5258545e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  			pud_t *pud, pfn_t pfn, bool write);
>  enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_DAX_FLAG,
>  	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>  		return true;
>  
> -	if (vma_is_dax(vma))
> +	if (vma_is_dax(vma) &&
> +	    (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
>  		return true;
>  
>  	if (transparent_hugepage_flags &
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index faf357eaf0ce..43d742fe0341 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -53,6 +53,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
>  	(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
>  #endif
> +	(1 << TRANSPARENT_HUGEPAGE_DAX_FLAG) |
>  	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
>  	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>  	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
> @@ -475,6 +476,8 @@ static int __init setup_transparent_hugepage(char *str)
>  			  &transparent_hugepage_flags);
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>  			  &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DAX_FLAG,
> +			  &transparent_hugepage_flags);
>  		ret = 1;
>  	}
>  out:
> @@ -753,6 +756,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_lock(mm, pmd);
> +	/* should we check for none here again? */
>  	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>  	if (pfn_t_devmap(pfn))
>  		entry = pmd_mkdevmap(entry);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
