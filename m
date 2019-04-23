Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B26C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5980D21850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556041977;
	bh=tH7MbWcDlPbniLes5zWx2RRDS3Lukvx4Wrw2vYkj4LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emupwJwyGAquQbHccZ+NcRwyudr5tY3dQkYP2EyYZFIx3xFhzFlQMgNEeXhIYnJiR
	 4AbzraQmFnPdFoB+Hw0Deu+yw3rCa+778RCljI3HavGYT6xy6fIX3Ws+ywJ/lz0YmP
	 mvRkSSioxom5e9S8amcMNidXDiM9t+pptps1EfRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfDWRwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbfDWRwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:52:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 009C3AF92;
        Tue, 23 Apr 2019 17:52:53 +0000 (UTC)
Date:   Tue, 23 Apr 2019 19:52:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
Message-ID: <20190423175252.GP25106@dhcp22.suse.cz>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-04-19 00:43:01, Yang Shi wrote:
> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
> vma") introduced THPeligible bit for processes' smaps. But, when checking
> the eligibility for shmem vma, __transparent_hugepage_enabled() is
> called to override the result from shmem_huge_enabled().  It may result
> in the anonymous vma's THP flag override shmem's.  For example, running a
> simple test which create THP for shmem, but with anonymous THP disabled,
> when reading the process's smaps, it may show:
> 
> 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
> Size:               4096 kB
> ...
> [snip]
> ...
> ShmemPmdMapped:     4096 kB
> ...
> [snip]
> ...
> THPeligible:    0
> 
> And, /proc/meminfo does show THP allocated and PMD mapped too:
> 
> ShmemHugePages:     4096 kB
> ShmemPmdMapped:     4096 kB
> 
> This doesn't make too much sense.  The anonymous THP flag should not
> intervene shmem THP.  Calling shmem_huge_enabled() with checking
> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
> dax vma check since we already checked if the vma is shmem already.

Kirill, can we get a confirmation that this is really intended behavior
rather than an omission please? Is this documented? What is a global
knob to simply disable THP system wise?

I have to say that the THP tuning API is one giant mess :/

Btw. this patch also seem to fix khugepaged behavior because it previously
ignored both VM_NOHUGEPAGE and MMF_DISABLE_THP.

> Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each vma")
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: Check VM_NOHUGEPAGE per Michal Hocko
> 
>  mm/huge_memory.c | 4 ++--
>  mm/shmem.c       | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 165ea46..5881e82 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -67,8 +67,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
>  	if (vma_is_anonymous(vma))
>  		return __transparent_hugepage_enabled(vma);
> -	if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
> -		return __transparent_hugepage_enabled(vma);
> +	if (vma_is_shmem(vma))
> +		return shmem_huge_enabled(vma);
>  
>  	return false;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2275a0f..6f09a31 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3873,6 +3873,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>  	loff_t i_size;
>  	pgoff_t off;
>  
> +	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +		return false;
>  	if (shmem_huge == SHMEM_HUGE_FORCE)
>  		return true;
>  	if (shmem_huge == SHMEM_HUGE_DENY)
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
