Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF4BC17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKLVN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:13:28 -0500
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:42918 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbfKLVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E3C03180A68D7;
        Tue, 12 Nov 2019 21:13:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: head78_1dbdc56a2c617
X-Filterd-Recvd-Size: 3277
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 21:13:24 +0000 (UTC)
Message-ID: <a7fddda6f3e47b6aeb5d6d6ea9ea28ec019d3d94.camel@perches.com>
Subject: Re: [PATCH 2/2] hugetlbfs: convert macros to static inline, fix
 sparse warning
From:   Joe Perches <joe@perches.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, kbuild@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 12 Nov 2019 13:13:07 -0800
In-Reply-To: <20191112194558.139389-3-mike.kravetz@oracle.com>
References: <20191112194558.139389-1-mike.kravetz@oracle.com>
         <20191112194558.139389-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 11:45 -0800, Mike Kravetz wrote:
> huge_pte_offset() produced a sparse warning due to an improper
> return type when the kernel was built with !CONFIG_HUGETLB_PAGE.
> Fix the bad type and also convert all the macros in this block
> to static inline wrappers.  Two existing wrappers in this block
> had lines in excess of 80 columns so clean those up as well.
> 
> No functional change.
> 
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h | 137 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 115 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53fc34f930d0..ef412fe0be3d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -164,38 +164,130 @@ static inline void adjust_range_if_pmd_sharing_possible(
>  {
>  }
>  
> -#define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
> -#define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
> -#define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
> +static inline long follow_hugetlb_page(struct mm_struct *mm,
> +			struct vm_area_struct *vma, struct page **pages,
> +			struct vm_area_struct **vmas, unsigned long *position,
> +			unsigned long *nr_pages, long i, unsigned int flags,
> +			int *nonblocking)
> +{
> +	BUG();

While this is not different from the original, perhaps this is
also an opportunity to change the BUG()s to WARN()s.

> +static inline int copy_hugetlb_page_range(struct mm_struct *dst,
> +			struct mm_struct *src, struct vm_area_struct *vma)
> +{
> +	BUG();
> +	return 0;
> +}
[]
> +static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> +				unsigned long addr, unsigned long end,
> +				unsigned long floor, unsigned long ceiling)
> +{
> +	BUG();
> +}
> +
> +static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> +						pte_t *dst_pte,
> +						struct vm_area_struct *dst_vma,
> +						unsigned long dst_addr,
> +						unsigned long src_addr,
> +						struct page **pagep)
> +{
> +	BUG();
> +	return 0;
> +}


