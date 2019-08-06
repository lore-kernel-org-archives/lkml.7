Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A31C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2589020651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfHFKDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFKDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:03:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FE4230EA1B1;
        Tue,  6 Aug 2019 10:03:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 16ECB60610;
        Tue,  6 Aug 2019 10:02:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Aug 2019 12:02:59 +0200 (CEST)
Date:   Tue, 6 Aug 2019 12:02:57 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v4 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Message-ID: <20190806100256.GA21454@redhat.com>
References: <20190802231817.548920-1-songliubraving@fb.com>
 <20190802231817.548920-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802231817.548920-2-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 06 Aug 2019 10:03:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Song Liu wrote:
>
> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> +{
> +	unsigned long haddr = addr & HPAGE_PMD_MASK;
> +	struct vm_area_struct *vma = find_vma(mm, haddr);
> +	pmd_t *pmd = mm_find_pmd(mm, haddr);
> +	struct page *hpage = NULL;
> +	spinlock_t *ptl;
> +	int count = 0;
> +	pmd_t _pmd;
> +	int i;
> +
> +	if (!vma || !vma->vm_file || !pmd ||
> +	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
> +		return;

I still can't understand why is it safe to blindly use mm_find_pmd().

Say, what pmd_offset(pud, address) will return to this function if
pud_huge() == T? IIUC, this is possible if is_file_hugepages(vm_file).
How the code below can use this result?

I think you need something like hugepage_vma_check() or even
hugepage_vma_revalidate().

Oleg.

