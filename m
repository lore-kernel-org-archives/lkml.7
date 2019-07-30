Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04AFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E60020644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfG3QLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:11:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfG3QLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:11:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A55481F25;
        Tue, 30 Jul 2019 16:11:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B4561001938;
        Tue, 30 Jul 2019 16:11:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jul 2019 18:11:16 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:11:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 3/4] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190730161113.GC18501@redhat.com>
References: <20190730052305.3672336-1-songliubraving@fb.com>
 <20190730052305.3672336-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730052305.3672336-4-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 16:11:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand this code, so I can't review, but.

On 07/29, Song Liu wrote:
>
> This patches introduces a new foll_flag: FOLL_SPLIT_PMD. As the name says
> FOLL_SPLIT_PMD splits huge pmd for given mm_struct, the underlining huge
> page stays as-is.
>
> FOLL_SPLIT_PMD is useful for cases where we need to use regular pages,
> but would switch back to huge page and huge pmd on. One of such example
> is uprobe. The following patches use FOLL_SPLIT_PMD in uprobe.

So after the next patch we have a single user of FOLL_SPLIT_PMD (uprobes)
and a single user of FOLL_SPLIT: arch/s390/mm/gmap.c:thp_split_mm().

Hmm.

> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  		spin_unlock(ptl);
>  		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>  	}
> -	if (flags & FOLL_SPLIT) {
> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>  		int ret;
>  		page = pmd_page(*pmd);
>  		if (is_huge_zero_page(page)) {
> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, pmd, address);
>  			if (pmd_trans_unstable(pmd))
>  				ret = -EBUSY;
> -		} else {
> +		} else if (flags & FOLL_SPLIT) {
>  			if (unlikely(!try_get_page(page))) {
>  				spin_unlock(ptl);
>  				return ERR_PTR(-ENOMEM);
> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  			put_page(page);
>  			if (pmd_none(*pmd))
>  				return no_page_table(vma, flags);
> +		} else {  /* flags & FOLL_SPLIT_PMD */
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, address);
> +			ret = pte_alloc(mm, pmd);

I fail to understand why this differs from the is_huge_zero_page() case above.

Anyway, ret = pte_alloc(mm, pmd) can't be correct. If __pte_alloc() fails pte_alloc()
will return 1. This will fool the IS_ERR(page) check in __get_user_pages().

Oleg.

