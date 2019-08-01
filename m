Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B7CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CC620665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfHAOuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731148AbfHAOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:50:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F8822D0FC7;
        Thu,  1 Aug 2019 14:50:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5531B5C207;
        Thu,  1 Aug 2019 14:50:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Aug 2019 16:50:34 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:50:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190801145032.GB31538@redhat.com>
References: <20190731183331.2565608-1-songliubraving@fb.com>
 <20190731183331.2565608-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731183331.2565608-2-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 01 Aug 2019 14:50:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Song Liu wrote:
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

could you explain why do we need mm->mmap_sem, khugepaged_test_exit() check
and __khugepaged_enter() ?


> +	spin_lock(&khugepaged_mm_lock);
> +	mm_slot = get_mm_slot(mm);
> +	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
> +		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;

if get_mm_slot() returns mm_slot != NULL we can safely modify ->pte_mapped_thp.
We do not care even if this task has already passed __mmput/__khugepaged_exit,
this slot can't go away.

No?

Oleg.

