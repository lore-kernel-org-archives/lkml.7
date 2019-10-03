Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B585C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE52821D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cwcJS8Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfJCLRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:17:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36660 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJCLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:17:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so2101620edn.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GCU+79E+VhuFmZsBUjYy+yCcILJtzpwlT3Acgn/mCcs=;
        b=cwcJS8EhVKSG5jL+9Sf8z8L9Hf11l1xzCK2U5tnLSX9oLXPk9wJJMeLL5AtKGtzIX1
         AsY5qItyn3osHJP25ckZV0Qv59ZhzGyPlyZt0YUrHQp/Q4xmigfkweMUgSjBQdqCQjvY
         FiXwvkLc0kI44En8mRvtlTyO27pHBAE8CV4mCjEUxDpTS2wxUltB0Jx/ubYH8qtIlv1U
         eUtZQf+NKh6/H848T9fdQZBUUuYhQiRVneUJUGefRcqhL4t1Se4A3pJeI4Q5aO0daB41
         XckaCDlrSFFoXXn5qh6dYFH7IBAWr0ABe8dsZdXsrjHSeu1+jtoNnE/+lAzgMkYWZTt9
         WxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GCU+79E+VhuFmZsBUjYy+yCcILJtzpwlT3Acgn/mCcs=;
        b=PL0WZRaJt8CUv9evWBF7oTlvJnneMbAwwgornSVnJ3CjUSuMw+7ttQ7zb2nvVuLhyA
         3WYe4kKMrwmbuVfkVRPEpSzP33O7QHKoRd6kR0NsKqvUvalWW5NdpKFTTQjKjU5pOB6z
         nNTu65X99f4JBLqQr9ydqGCwIBYpBJiCEZsWgyrXoj8YSJZTXZF/0dJUbfYrXHwc774b
         s4JSmYI4SIP3KqAXgAjKIpC1bCFPh9wHjyO03FkK7092R67Fv9XHViB7JqgKKLQW+CQB
         5VD6f2hFTto2rov3SG98FNzlDyy2VToAM0WgAgXQO5OtgbuxBQAnX5CK14aUNGu7/H3t
         7u4g==
X-Gm-Message-State: APjAAAVeKmG6pDqVsx43UQY3cohrknSrJ/zI79hye04Yb9l23/+nbvHR
        kRCnKlbxXBHKLlrPXbVpq/f40Q==
X-Google-Smtp-Source: APXvYqymgUvk1nUrJhPNFyZrAPj5CCLBkjTYRjmLzl/bZyTcdkrN6N+EYO4/h4wRAxsL0k//pxYp7g==
X-Received: by 2002:a17:906:4a06:: with SMTP id w6mr7286226eju.214.1570101428088;
        Thu, 03 Oct 2019 04:17:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h7sm412130edn.73.2019.10.03.04.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 04:17:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 63948101174; Thu,  3 Oct 2019 14:17:08 +0300 (+03)
Date:   Thu, 3 Oct 2019 14:17:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
Message-ID: <20191003111708.sttkkrhiidleivc6@box>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002134730.40985-3-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:47:25PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> For users that want to travers all page table entries pointing into a
> region of a struct address_space mapping, introduce a walk_page_mapping()
> function.
> 
> The walk_page_mapping() function will be initially be used for dirty-
> tracking in virtual graphics drivers.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  include/linux/pagewalk.h |  9 ++++
>  mm/pagewalk.c            | 99 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index bddd9759bab9..6ec82e92c87f 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -24,6 +24,9 @@ struct mm_walk;
>   *			"do page table walk over the current vma", returning
>   *			a negative value means "abort current page table walk
>   *			right now" and returning 1 means "skip the current vma"
> + * @pre_vma:            if set, called before starting walk on a non-null vma.
> + * @post_vma:           if set, called after a walk on a non-null vma, provided
> + *                      that @pre_vma and the vma walk succeeded.
>   */
>  struct mm_walk_ops {
>  	int (*pud_entry)(pud_t *pud, unsigned long addr,
> @@ -39,6 +42,9 @@ struct mm_walk_ops {
>  			     struct mm_walk *walk);
>  	int (*test_walk)(unsigned long addr, unsigned long next,
>  			struct mm_walk *walk);
> +	int (*pre_vma)(unsigned long start, unsigned long end,
> +		       struct mm_walk *walk);
> +	void (*post_vma)(struct mm_walk *walk);
>  };
>  
>  /**
> @@ -62,5 +68,8 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>  		void *private);
>  int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		void *private);
> +int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
> +		      pgoff_t nr, const struct mm_walk_ops *ops,
> +		      void *private);
>  
>  #endif /* _LINUX_PAGEWALK_H */
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d48c2a986ea3..658d1e5ec428 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -253,13 +253,23 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>  {
>  	int err = 0;
>  	struct vm_area_struct *vma = walk->vma;
> +	const struct mm_walk_ops *ops = walk->ops;
> +
> +	if (vma && ops->pre_vma) {
> +		err = ops->pre_vma(start, end, walk);
> +		if (err)
> +			return err;
> +	}
>  
>  	if (vma && is_vm_hugetlb_page(vma)) {
> -		if (walk->ops->hugetlb_entry)
> +		if (ops->hugetlb_entry)
>  			err = walk_hugetlb_range(start, end, walk);
>  	} else
>  		err = walk_pgd_range(start, end, walk);
>  
> +	if (vma && ops->post_vma)
> +		ops->post_vma(walk);
> +
>  	return err;
>  }
>  
> @@ -285,11 +295,17 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>   *  - <0 : failed to handle the current entry, and return to the caller
>   *         with error code.
>   *
> + *
>   * Before starting to walk page table, some callers want to check whether
>   * they really want to walk over the current vma, typically by checking
>   * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
>   * purpose.
>   *
> + * If operations need to be staged before and committed after a vma is walked,
> + * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
> + * since it is intended to handle commit-type operations, can't return any
> + * errors.
> + *
>   * struct mm_walk keeps current values of some common data like vma and pmd,
>   * which are useful for the access from callbacks. If you want to pass some
>   * caller-specific data to callbacks, @private should be helpful.
> @@ -376,3 +392,84 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		return err;
>  	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
>  }
> +
> +/**
> + * walk_page_mapping - walk all memory areas mapped into a struct address_space.
> + * @mapping: Pointer to the struct address_space
> + * @first_index: First page offset in the address_space
> + * @nr: Number of incremental page offsets to cover
> + * @ops:	operation to call during the walk
> + * @private:	private data for callbacks' usage
> + *
> + * This function walks all memory areas mapped into a struct address_space.
> + * The walk is limited to only the given page-size index range, but if
> + * the index boundaries cross a huge page-table entry, that entry will be
> + * included.
> + *
> + * Also see walk_page_range() for additional information.
> + *
> + * Locking:
> + *   This function can't require that the struct mm_struct::mmap_sem is held,
> + *   since @mapping may be mapped by multiple processes. Instead
> + *   @mapping->i_mmap_rwsem must be held. This might have implications in the
> + *   callbacks, and it's up tho the caller to ensure that the
> + *   struct mm_struct::mmap_sem is not needed.
> + *
> + *   Also this means that a caller can't rely on the struct
> + *   vm_area_struct::vm_flags to be constant across a call,
> + *   except for immutable flags. Callers requiring this shouldn't use
> + *   this function.
> + *
> + *   If @mapping allows faulting of huge pmds and puds, it is desirable
> + *   that its huge_fault() handler blocks while this function is running on
> + *   @mapping. Otherwise a race may occur where the huge entry is split when
> + *   it was intended to be handled in a huge entry callback. This requires an
> + *   external lock, for example that @mapping->i_mmap_rwsem is held in
> + *   write mode in the huge_fault() handlers.

Em. No. We have ptl for this. It's the only lock required (plus mmap_sem
on read) to split PMD entry into PTE table. And it can happen not only
from fault path.

If you care about splitting compound page under you, take a pin or lock a
page. It will block split_huge_page().

Suggestion to block fault path is not viable (and it will not happen
magically just because of this comment).

> + */
> +int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
> +		      pgoff_t nr, const struct mm_walk_ops *ops,
> +		      void *private)
> +{
> +	struct mm_walk walk = {
> +		.ops		= ops,
> +		.private	= private,
> +	};
> +	struct vm_area_struct *vma;
> +	pgoff_t vba, vea, cba, cea;
> +	unsigned long start_addr, end_addr;
> +	int err = 0;
> +
> +	lockdep_assert_held(&mapping->i_mmap_rwsem);
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
> +				  first_index + nr - 1) {
> +		/* Clip to the vma */
> +		vba = vma->vm_pgoff;
> +		vea = vba + vma_pages(vma);
> +		cba = first_index;
> +		cba = max(cba, vba);
> +		cea = first_index + nr;
> +		cea = min(cea, vea);
> +
> +		start_addr = ((cba - vba) << PAGE_SHIFT) + vma->vm_start;
> +		end_addr = ((cea - vba) << PAGE_SHIFT) + vma->vm_start;
> +		if (start_addr >= end_addr)
> +			continue;
> +
> +		walk.vma = vma;
> +		walk.mm = vma->vm_mm;
> +
> +		err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
> +		if (err > 0) {
> +			err = 0;
> +			break;
> +		} else if (err < 0)
> +			break;
> +
> +		err = __walk_page_range(start_addr, end_addr, &walk);
> +		if (err)
> +			break;
> +	}
> +
> +	return err;
> +}
> -- 
> 2.20.1
> 

-- 
 Kirill A. Shutemov
