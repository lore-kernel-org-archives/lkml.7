Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B15BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F099020644
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfHBQVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfHBQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0611230EA1B6;
        Fri,  2 Aug 2019 16:21:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 39FD910018F9;
        Fri,  2 Aug 2019 16:21:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Aug 2019 18:21:38 +0200 (CEST)
Date:   Fri, 2 Aug 2019 18:21:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190802162136.GA2539@redhat.com>
References: <20190801184823.3184410-1-songliubraving@fb.com>
 <20190801184823.3184410-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801184823.3184410-2-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 02 Aug 2019 16:21:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Song Liu wrote:
>
> +static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +					 unsigned long addr)
> +{
> +	struct mm_slot *mm_slot;
> +	int ret = 0;
> +
> +	/* hold mmap_sem for khugepaged_test_exit() */
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
> +
> +	if (unlikely(khugepaged_test_exit(mm)))
> +		return 0;
> +
> +	if (!test_bit(MMF_VM_HUGEPAGE, &mm->flags) &&
> +	    !test_bit(MMF_DISABLE_THP, &mm->flags)) {
> +		ret = __khugepaged_enter(mm);
> +		if (ret)
> +			return ret;
> +	}

see my reply to v2

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
> +	if (!vma || !vma->vm_file || !pmd)
                    ^^^^^^^^^^^^^

I am not sure this is enough,

> +		return;
> +
> +	/* step 1: check all mapped PTEs are to the right huge page */
> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +		pte_t *pte = pte_offset_map(pmd, addr);
> +		struct page *page;
> +
> +		if (pte_none(*pte))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, *pte);

Why can't vm_normal_page() return NULL? Again, we do not if this vm_file
is the same shmem_file() or something else.

And in fact I don't think it is safe to use vm_normal_page(vma, addr)
unless you know that vma includes this addr.

to be honest, I am not even sure that unconditional mm_find_pmd() is safe
if this "something else" is really special.

Oleg.

