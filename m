Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E82A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbfHHQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:33:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CD3BCF22;
        Thu,  8 Aug 2019 16:33:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id A42CE19C69;
        Thu,  8 Aug 2019 16:33:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Aug 2019 18:33:06 +0200 (CEST)
Date:   Thu, 8 Aug 2019 18:33:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Message-ID: <20190808163303.GB7934@redhat.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807233729.3899352-6-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 08 Aug 2019 16:33:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07, Song Liu wrote:
>
> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned long haddr = addr & HPAGE_PMD_MASK;
> +	struct vm_area_struct *vma = find_vma(mm, haddr);
> +	struct page *hpage = NULL;
> +	pmd_t *pmd, _pmd;
> +	spinlock_t *ptl;
> +	int count = 0;
> +	int i;
> +
> +	if (!vma || !vma->vm_file ||
> +	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
> +		return;
> +
> +	/*
> +	 * This vm_flags may not have VM_HUGEPAGE if the page was not
> +	 * collapsed by this mm. But we can still collapse if the page is
> +	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
> +	 * will not fail the vma for missing VM_HUGEPAGE
> +	 */
> +	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
> +		return;
> +
> +	pmd = mm_find_pmd(mm, haddr);

OK, I do not see anything really wrong...

a couple of questions below.

> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +		struct page *page;
> +
> +		if (pte_none(*pte))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, *pte);
> +
> +		if (!page || !PageCompound(page))
> +			return;
> +
> +		if (!hpage) {
> +			hpage = compound_head(page);

OK,

> +			if (hpage->mapping != vma->vm_file->f_mapping)
> +				return;

is it really possible? May be WARN_ON(hpage->mapping != vm_file->f_mapping)
makes more sense ?

> +		if (hpage + i != page)
> +			return;

ditto.

Oleg.

