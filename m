Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8459620883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="aGF0m5qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408465AbfFLCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:33:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406202AbfFLCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:33:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id g13so23150629edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAd9VAiJz95Llz8BbTxV4sHt55dwKHdH+hoX3bTDkOM=;
        b=aGF0m5qDaDj87qvNo5iPDYjLHNHkvWmDaEpCNpwbFSa4HzQDh4bwYk/ghq2akBh7gf
         mvYvGFQKDZIuN9zsuuccUcDr6CwuBRbat9mNrwjJNqAHXk5LoA66Npn1J32iT2rcDfpw
         f+i5zMYkljrX+ld9mYuVrJTtg30/15VL5s9Sh6uBssTfZ57JtMnhkfDzQKGLfLD7rQjV
         yZWlPSz0HiFXV9SmWRGoEhN14rWIRN5p0NtTtgElcRvgA+7FrrckEiVoMyoE3ze2sQbQ
         dYnPsIewsFSO+WvWMcODJaKcHE2ujN58RlX4DWlbu9H2vKMtJdLSA9GH2kSSCsbTERm9
         IihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAd9VAiJz95Llz8BbTxV4sHt55dwKHdH+hoX3bTDkOM=;
        b=WM+aUL+goIGGpUPIvFHbyWY7KEv9ertfg/gpblz84mX6ZnBcRWs+ULa8Qhy6ntcu5z
         u/lIEfrQrzcBwgWpkMbLLGz5TM2LJyTL9Y36tpN3Xk7VCFxUNRcBM9ZPwutdma2ouwfC
         LeBL98I09q5hAzNJZ7Nc06SS++tXvFUc6UJY11/1jgLNbOP2s46U2jru+66pfmrxfd4r
         BzeRHEiYKNwvsjqzRL8ptqhUXQeHsRHXF8fdFpF3iSaCVusztPnVHxQ/9k2Ug+0BIqEL
         DINkBAF4jmSrszyr+barkZPqCFDGTjKUZ5LX3Q7x7TEUmUyDPgkku4j5ZS5uiCZ/0Upe
         WAAw==
X-Gm-Message-State: APjAAAWhP4brdKav6z3m2YhGDHf6+FnXrakaDr9S7t7yszLN3XUU6lFb
        mCjKt2iPrS/u/aqUlQ1odHAfkw==
X-Google-Smtp-Source: APXvYqyhtZl/3SjW+LtLwuO7S7BeZoKmz1DOjU/1ktZsjjlPzNNDP6SQvVctNXiGwdDMlV9oY2pG6A==
X-Received: by 2002:a17:906:53c1:: with SMTP id p1mr5138534ejo.241.1560306817323;
        Tue, 11 Jun 2019 19:33:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i31sm4161836edd.90.2019.06.11.19.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:33:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C01BA10081B; Wed, 12 Jun 2019 05:33:36 +0300 (+03)
Date:   Wed, 12 Jun 2019 05:33:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [RFC PATCH v2 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190612023336.hbqs2ag4bv2qv2eh@box>
References: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
 <1559937063-8323-3-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559937063-8323-3-git-send-email-larry.bassel@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 12:51:03PM -0700, Larry Bassel wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3a54c9d..1c1ed4e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4653,9 +4653,9 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
> -static unsigned long page_table_shareable(struct vm_area_struct *svma,
> -				struct vm_area_struct *vma,
> -				unsigned long addr, pgoff_t idx)
> +unsigned long page_table_shareable(struct vm_area_struct *svma,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr, pgoff_t idx)
>  {
>  	unsigned long saddr = ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
>  				svma->vm_start;
> @@ -4678,7 +4678,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
>  
> -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;

This is going to be build error. mm/hugetlb.o doesn't build unlessp CONFIG_HUGETLBFS=y.

And I think both functions doesn't cover all DAX cases: VMA can be not
aligned (due to vm_start and/or vm_pgoff) to 2M even if the file has 2M
ranges allocated. See transhuge_vma_suitable().

And as I said before, nothing guarantees contiguous 2M ranges on backing
storage.

And in general I found piggybacking on hugetlb hacky.

The solution has to stand on its own with own justification. Saying it
worked for hugetlb and it has to work here would not fly. hugetlb is much
more restrictive on use cases. THP has more corner cases.

> diff --git a/mm/memory.c b/mm/memory.c
> index ddf20bd..1ca8f75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3932,6 +3932,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_HUGE_PMD_SHARE
> +static pmd_t *huge_pmd_offset(struct mm_struct *mm,
> +			      unsigned long addr, unsigned long sz)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (!pgd_present(*pgd))
> +		return NULL;
> +	p4d = p4d_offset(pgd, addr);
> +	if (!p4d_present(*p4d))
> +		return NULL;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (sz != PUD_SIZE && pud_none(*pud))
> +		return NULL;
> +	/* hugepage or swap? */
> +	if (pud_huge(*pud) || !pud_present(*pud))
> +		return (pmd_t *)pud;

So do we or do we not support PUD pages? This is just broken.
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (sz != PMD_SIZE && pmd_none(*pmd))
> +		return NULL;
> +	/* hugepage or swap? */
> +	if (pmd_huge(*pmd) || !pmd_present(*pmd))
> +		return pmd;
> +
> +	return NULL;
> +}
> +

-- 
 Kirill A. Shutemov
