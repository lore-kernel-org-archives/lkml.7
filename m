Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5FECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9A920679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="b6eo6v+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfJIP2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:28:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45319 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbfJIP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:27:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so1970622lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iQQlvVf1KnrDupGieXQiT31DlPt7ngRIn+oWlntJbrA=;
        b=b6eo6v+rJT+f5py5qdHxkFUU24IJk6MDtdyK7QsLn5YNoKS2Io8CSF0unhd5MezXos
         Zcuj2GnoBTJD8FPhZkv6DgFglV++T/ayZ7WfL5L/JCfX8hi4+TFrRhJtoe8aioxyRDC8
         8R1TGet8cI2X4kMc9Rp2nDGt0wlPtuBiAC5QaDp2Gw0riGJYv9trGOuAejkpce1fjL7m
         eCQH6ukjMWp9Q3WJELgsKxfUS7ETB6y4Hb1KuzPPpY8yCj+FwgltC+wQgNo7Qt4xUKQ5
         tpy+fcFouWSBQE+IzBCPJDBGo/dfFbpXZ1m/UiXErfewbR48Bge918/6LA9Uvr/NQ0/Y
         +4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iQQlvVf1KnrDupGieXQiT31DlPt7ngRIn+oWlntJbrA=;
        b=XlHcD2gpvpf3gRDDmH9dXOUEfa10KbR8m6ujyx0cd16oytECjJfgYZGksFazuzGYfP
         bzVmPms94onNQeibodD8YQGQDojn/AwQvR6hcGhO0X2tUD4AjDy6VAUgNmyf9q152H4i
         nI4/FSzMk58QCLBZfpC9W2ubVx1jCiDzcqSYcw7c0goa+rGNuQ5NDV6uIUz8PFrNbhvi
         veZzsRiUuIYZNHCTrBtaynRvM5X+LAbJolp2TqEa1U+FgiWx+c4mWYfZFpr1JcNqzKcM
         EYfFURXFzjOpu5lSWQtdla7JchAK2S3I3kxiTW+zhFL1MFWE99yzPjRRJp8rqD4iBktD
         pMXw==
X-Gm-Message-State: APjAAAWVfad82pgejrbb5peCpy/+3wU2gQKri/A/HLcfkVW2RzP7f2sP
        WqrVT4n3GZeKxFEsIwVW8F8vMw==
X-Google-Smtp-Source: APXvYqyAYIbpIxwbWzio0EZMQsTyoULCSbdhI02dK/m5+S3lmVAsOItzeHSa2fMvA22WHbAMrkXg9Q==
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr2521837lfp.18.1570634858609;
        Wed, 09 Oct 2019 08:27:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t27sm542192lfl.48.2019.10.09.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C2409102BFA; Wed,  9 Oct 2019 18:27:37 +0300 (+03)
Date:   Wed, 9 Oct 2019 18:27:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
Message-ID: <20191009152737.p42w7w456zklxz72@box>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008091508.2682-4-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:15:02AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The pagewalk code was unconditionally splitting transhuge pmds when a
> pte_entry was present. However ideally we'd want to handle transhuge pmds
> in the pmd_entry function and ptes in pte_entry function. So don't split
> huge pmds when there is a pmd_entry function present, but let the callback
> take care of it if necessary.

Do we have any current user that expect split_huge_pmd() in this scenario.

> 
> In order to make sure a virtual address range is handled by one and only
> one callback, and since pmd entries may be unstable, we introduce a
> pmd_entry return code that tells the walk code to continue processing this
> pmd entry rather than to move on. Since caller-defined positive return
> codes (up to 2) are used by current callers, use a high value that allows a
> large range of positive caller-defined return codes for future users.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  include/linux/pagewalk.h |  8 ++++++++
>  mm/pagewalk.c            | 28 +++++++++++++++++++++-------
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index bddd9759bab9..c4a013eb445d 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -4,6 +4,11 @@
>  
>  #include <linux/mm.h>
>  
> +/* Highest positive pmd_entry caller-specific return value */
> +#define PAGE_WALK_CALLER_MAX     (INT_MAX / 2)
> +/* The handler did not handle the entry. Fall back to the next level */
> +#define PAGE_WALK_FALLBACK       (PAGE_WALK_CALLER_MAX + 1)
> +

That's hacky.

Maybe just use an error code for this? -EAGAIN?

>  struct mm_walk;
>  
>  /**
> @@ -16,6 +21,9 @@ struct mm_walk;
>   *			this handler is required to be able to handle
>   *			pmd_trans_huge() pmds.  They may simply choose to
>   *			split_huge_page() instead of handling it explicitly.
> + *                      If the handler did not handle the PMD, or split the
> + *                      PMD and wants it handled by the PTE handler, it
> + *                      should return PAGE_WALK_FALLBACK.

Indentation is broken. Use tabs.

>   * @pte_entry:		if set, called for each non-empty PTE (4th-level) entry
>   * @pte_hole:		if set, called for each hole at all levels
>   * @hugetlb_entry:	if set, called for each hugetlb entry
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 83c0b78363b4..f844c2a2aa60 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -50,10 +50,18 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  		 * This implies that each ->pmd_entry() handler
>  		 * needs to know about pmd_trans_huge() pmds
>  		 */
> -		if (ops->pmd_entry)
> +		if (ops->pmd_entry) {
>  			err = ops->pmd_entry(pmd, addr, next, walk);
> -		if (err)
> -			break;
> +			if (!err)
> +				continue;
> +			else if (err <= PAGE_WALK_CALLER_MAX)
> +				break;
> +			WARN_ON(err != PAGE_WALK_FALLBACK);
> +			err = 0;
> +			if (pmd_trans_unstable(pmd))
> +				goto again;
> +			/* Fall through */
> +		}
>  
>  		/*
>  		 * Check this here so we only break down trans_huge
> @@ -61,8 +69,8 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  		 */
>  		if (!ops->pte_entry)
>  			continue;
> -
> -		split_huge_pmd(walk->vma, pmd, addr);
> +		if (!ops->pmd_entry)
> +			split_huge_pmd(walk->vma, pmd, addr);
>  		if (pmd_trans_unstable(pmd))
>  			goto again;
>  		err = walk_pte_range(pmd, addr, next, walk);
> @@ -281,11 +289,17 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>   *
>   *  - 0  : succeeded to handle the current entry, and if you don't reach the
>   *         end address yet, continue to walk.
> - *  - >0 : succeeded to handle the current entry, and return to the caller
> - *         with caller specific value.
> + *  - >0, and <= PAGE_WALK_CALLER_MAX : succeeded to handle the current entry,
> + *         and return to the caller with caller specific value.
>   *  - <0 : failed to handle the current entry, and return to the caller
>   *         with error code.
>   *
> + * For pmd_entry(), a value <= PAGE_WALK_CALLER_MAX indicates that the entry
> + * was handled by the callback. PAGE_WALK_FALLBACK indicates that the entry
> + * could not be handled by the callback and should be re-checked. If the
> + * callback needs the entry to be handled by the next level, it should
> + * split the entry and then return PAGE_WALK_FALLBACK.
> + *
>   * Before starting to walk page table, some callers want to check whether
>   * they really want to walk over the current vma, typically by checking
>   * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
