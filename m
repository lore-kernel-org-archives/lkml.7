Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCCB20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfDVOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfDVOzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 704A881F0F;
        Mon, 22 Apr 2019 14:55:51 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 401B7608E4;
        Mon, 22 Apr 2019 14:55:50 +0000 (UTC)
Date:   Mon, 22 Apr 2019 10:55:48 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] mm/hmm: Fix initial PFN for hugetlbfs pages
Message-ID: <20190422145548.GC3450@redhat.com>
References: <20190419233536.8080-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190419233536.8080-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 22 Apr 2019 14:55:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:35:36PM -0700, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> The mmotm patch [1] adds hugetlbfs support for HMM but the initial
> PFN used to fill the HMM range->pfns[] array doesn't properly
> compute the starting PFN offset.
> This can be tested by running test-hugetlbfs-read from [2].
> 
> Fix the PFN offset by adjusting the page offset by the device's
> page size.
> 
> Andrew, this should probably be squashed into Jerome's patch.
> 
> [1] https://marc.info/?l=linux-mm&m=155432003506068&w=2
> ("mm/hmm: mirror hugetlbfs (snapshoting, faulting and DMA mapping)")
> [2] https://gitlab.freedesktop.org/glisse/svm-cl-tests
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Good catch.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index def451a56c3e..fcf8e4fb5770 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -868,7 +868,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  		goto unlock;
>  	}
>  
> -	pfn = pte_pfn(entry) + (start & mask);
> +	pfn = pte_pfn(entry) + ((start & mask) >> range->page_shift);
>  	for (; addr < end; addr += size, i++, pfn += pfn_inc)
>  		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
>  				 cpu_flags;
> -- 
> 2.20.1
> 
