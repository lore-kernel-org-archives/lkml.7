Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1623AC76196
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F4218B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+41nzxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfGQToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:44:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41582 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:44:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so12452024pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gvjPZWoufoHncj5iyWeqiWRKnFrwf8zGjNBYtpZ6tKQ=;
        b=V+41nzxSMtHHtuKjjlYe2GfJUL8OkwTW54lqpP4dzM4zgY3shyyLaX0K65MjCbgkMA
         JbEoFVMktVLB3yjSnRHiCY/QGDeT/Ry1EtepMiiQZBtORT4LcsanPu+wmDHPU5A8ImJZ
         ldVpzOO2iZ7YzyDbWT2fLzrjfofjjisJtzT8oJ+LheNWez/iuEh8rIrXccIbc6wOmENU
         bymQc2QANDdpuvEugqEqUY33+9C5zNaq8aNQvWYnJfl2VIYp+NDrL1dmaf/yoMoe+wia
         PQa0y1K4sc3F7Xf58nEjx6tNNBQQWv75mlgYI1ha4k6Jhx5wCMoMPtZyRCR9AsEli8l9
         8+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gvjPZWoufoHncj5iyWeqiWRKnFrwf8zGjNBYtpZ6tKQ=;
        b=JTas0zq+PDTkv8X8qXf881rjYKIvKC95jEuHmDQPsnSaXSzab9FlGZpQAIXU30Jxqx
         LL9JNyZnRe77A5k8Hf+dDXUJSnzhIrRm5RlaxP8HicV3Ux7iqhiRKM7azpSQU20sVQ+F
         q99IOLbOxRjxT+ej5bVpmLMhhYBGG4GLMZBAjszK3jDyqud5xCNVc3LetTN861rURg3D
         9ldka5jxc7kgSOch1qz1FQMuae1Q6n8j9jg4ppSJSOeTqbBDsDN6t7rT6brlLPM7fmzQ
         L1/u07A0VotsL3/3Ujmp+fOeHqo9r+Qg9HEBRuJ37sqLj1H6kBLMsjRCIp1o3p5BQJZZ
         LIRg==
X-Gm-Message-State: APjAAAWWTjMwsidL/USsLb39hOGH+Yal716Vcs7JBBB+IuQC3esL2BDU
        8UIuZO04upkqks9hbkEm2QYBfQ==
X-Google-Smtp-Source: APXvYqxyIhVLV3+xZdZyruXl0Q+nykHdkO769WGjExr3291Arvp8ld8l1OClYHmZUBHqkGiwRJjaKw==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr46275249plz.132.1563392672552;
        Wed, 17 Jul 2019 12:44:32 -0700 (PDT)
Received: from [100.112.64.100] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id 14sm24016805pfy.40.2019.07.17.12.44.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jul 2019 12:44:31 -0700 (PDT)
Date:   Wed, 17 Jul 2019 12:44:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/2] mm: thp: fix false negative of shmem vma's THP
 eligibility
In-Reply-To: <1560401041-32207-3-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1907171243400.1177@eggly.anvils>
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com> <1560401041-32207-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Yang Shi wrote:

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
> This doesn't make too much sense.  The shmem objects should be treated
> separately from anonymous THP.  Calling shmem_huge_enabled() with checking
> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
> dax vma check since we already checked if the vma is shmem already.
> 
> Also check if vma is suitable for THP by calling
> transhuge_vma_suitable().
> 
> And minor fix to smaps output format and documentation.
> 
> Fixes: 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each vma")
> Cc: Hugh Dickins <hughd@google.com>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>

> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  Documentation/filesystems/proc.txt | 4 ++--
>  fs/proc/task_mmu.c                 | 3 ++-
>  mm/huge_memory.c                   | 9 +++++++--
>  mm/shmem.c                         | 3 +++
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 66cad5c..b0ded06 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -477,8 +477,8 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
>  "SwapPss" shows proportional swap share of this mapping. Unlike "Swap", this
>  does not take into account swapped out page of underlying shmem objects.
>  "Locked" indicates whether the mapping is locked in memory or not.
> -"THPeligible" indicates whether the mapping is eligible for THP pages - 1 if
> -true, 0 otherwise.
> +"THPeligible" indicates whether the mapping is eligible for allocating THP
> +pages - 1 if true, 0 otherwise. It just shows the current status.
>  
>  "VmFlags" field deserves a separate description. This member represents the kernel
>  flags associated with the particular virtual memory area in two letter encoded
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0..6a13882 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -796,7 +796,8 @@ static int show_smap(struct seq_file *m, void *v)
>  
>  	__show_smap(m, &mss);
>  
> -	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
> +	seq_printf(m, "THPeligible:		%d\n",
> +		   transparent_hugepage_enabled(vma));
>  
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4bc2552..36f0225 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -65,10 +65,15 @@
>  
>  bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
> +	/* The addr is used to check if the vma size fits */
> +	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> +
> +	if (!transhuge_vma_suitable(vma, addr))
> +		return false;
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
> index 1bb3b8d..a807712 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3872,6 +3872,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
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
