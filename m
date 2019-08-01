Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81E320665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfHAMnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731187AbfHAMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4DDD308FF23;
        Thu,  1 Aug 2019 12:43:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE9E960A9F;
        Thu,  1 Aug 2019 12:43:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Aug 2019 14:43:54 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:43:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190801124351.GA31538@redhat.com>
References: <20190731183331.2565608-1-songliubraving@fb.com>
 <20190731183331.2565608-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731183331.2565608-2-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 12:43:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Song Liu wrote:
>
> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long haddr)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, haddr);
> +	pmd_t *pmd = mm_find_pmd(mm, haddr);
> +	struct page *hpage = NULL;
> +	unsigned long addr;
> +	spinlock_t *ptl;
> +	int count = 0;
> +	pmd_t _pmd;
> +	int i;
> +
> +	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
> +
> +	if (!vma || !pmd || pmd_trans_huge(*pmd))
                            ^^^^^^^^^^^^^^^^^^^^

mm_find_pmd() returns NULL if pmd_trans_huge()

> +	/* step 1: check all mapped PTEs are to the right huge page */
> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +		struct page *page;
> +
> +		if (pte_none(*pte))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, *pte);
> +
> +		if (!PageCompound(page))
> +			return;
> +
> +		if (!hpage) {
> +			hpage = compound_head(page);
> +			if (hpage->mapping != vma->vm_file->f_mapping)

Hmm. But how can we know this is still the same vma ?

If nothing else, why vma->vm_file can't be NULL?

Say, a process unmaps this memory after khugepaged_add_pte_mapped_thp()
was called, then it does mmap(haddr, MAP_PRIVATE|MAP_ANONYMOUS), then
do_huge_pmd_anonymous_page() installs a huge page at the same address,
then split_huge_pmd() is called by any reason.

No?

