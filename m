Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5476021019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbwabKem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEIQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:49:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hQaRECmt2AGJ9aBav/iTahs8q1TjZtUATP8Rg6+p5qQ=; b=kbwabKemhEMe3Qd0HRGkq86z0
        WCRMv9pONFR5eLR3jkRng5smxUZiSToxzOrVGELxt6RuUAwHVW7m4raETMZcF29WFCzUC9cZiKtkc
        uRhKAOpjkt7X9EN6nykBig8wIxxih1GUb0z3iREcTGWRdndvPGPCCV83G98eGGGae3ROiYyVh4/xv
        x2VL4rGbj0sgt709HSAI8uPx0uqOD13x65oJjp+iSh+JaKA+4yjUtgpjG+sP28xcnTsUDii3Ri/UR
        XTsPQAyNarJzDM95Zf0nAnzIhD08e9Jr/rU28C32bhfzpAL8qr0GpvuIdzS5T4Synpl+wOEULF5BX
        FKGxAQgaw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOmEM-0004xN-Cr; Thu, 09 May 2019 16:49:14 +0000
Date:   Thu, 9 May 2019 09:49:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     mike.kravetz@oracle.com, dan.j.williams@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190509164914.GA3862@bombadil.infradead.org>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
> This is based on (but somewhat different from) what hugetlbfs
> does to share/unshare page tables.

Wow, that worked out far more cleanly than I was expecting to see.

> @@ -4763,6 +4763,19 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
>  }
> +
> +unsigned long page_table_shareable(struct vm_area_struct *svma,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr, pgoff_t idx)
> +{
> +	return 0;
> +}
> +
> +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return false;
> +}

I don't think you need these stubs, since the only caller of them is
also gated by MAY_SHARE_FSDAX_PMD ... right?

> +	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> +		if (svma == vma)
> +			continue;
> +
> +		saddr = page_table_shareable(svma, vma, addr, idx);
> +		if (saddr) {
> +			spmd = huge_pmd_offset(svma->vm_mm, saddr,
> +					       vma_mmu_pagesize(svma));
> +			if (spmd) {
> +				get_page(virt_to_page(spmd));
> +				break;
> +			}
> +		}
> +	}

I'd be tempted to reduce the indentation here:

	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
		if (svma == vma)
			continue;

		saddr = page_table_shareable(svma, vma, addr, idx);
		if (!saddr)
			continue;

		spmd = huge_pmd_offset(svma->vm_mm, saddr,
					vma_mmu_pagesize(svma));
		if (spmd)
			break;
	}


> +	if (!spmd)
> +		goto out;

... and move the get_page() down to here, so we don't split the
"when we find it" logic between inside and outside the loop.

	get_page(virt_to_page(spmd));

> +
> +	ptl = pmd_lockptr(mm, spmd);
> +	spin_lock(ptl);
> +
> +	if (pud_none(*pud)) {
> +		pud_populate(mm, pud,
> +			    (pmd_t *)((unsigned long)spmd & PAGE_MASK));
> +		mm_inc_nr_pmds(mm);
> +	} else {
> +		put_page(virt_to_page(spmd));
> +	}
> +	spin_unlock(ptl);
> +out:
> +	pmd = pmd_alloc(mm, pud, addr);
> +	i_mmap_unlock_write(mapping);

I would swap these two lines.  There's no need to hold the i_mmap_lock
while allocating this PMD, is there?  I mean, we don't for the !may_share
case.

