Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE980C46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pRicru75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfFMPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:20:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38839 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732115AbfFMM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:57:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id g13so31092929edu.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PruHJEAd43s3ggOTnMzet1lV7DtMDpoeu7PcAsCFkak=;
        b=pRicru75HQz8P0ztPvmuz8OLLx5i1d89FQf/NJ8QyFA4UPL1WUtJXejMEw3UjJh6yZ
         MI0F7BQn4Qwi6YjSd50X5wHiKv2YsvZ9XVlTp7+y9GR5aJHpFxwIQS66n/wt3oWxK5LI
         8MR0zpPHWaoQgLbMrp7Ov77SpY5jOKCsGKuEbqcD2RD1bMpmATlgyCLfVaSqktmQ/DXZ
         KMFraWOmvQggZ6z6DHL6l9oLgjmAhsXGN3OdRHLJBiV2nLjmDVgUKwvCQSDHg9wLU/bx
         fJBg+3D0aJFHjlHfT/dCLGspS50bjsls7KzGN7Sj1Mj3IjRcthoRmICbob0gK+5B7hGv
         1nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PruHJEAd43s3ggOTnMzet1lV7DtMDpoeu7PcAsCFkak=;
        b=THH2edDhZveAi36K9dQrvfLdanO17J0zVIU1FNEe8IHsWXt1ZVdPS4H7Z6NlNrg+Gy
         YDxEZRKutxaDN8AqEn4Gtk6CEWcXw3PXqJQv3EhPTBR2qPHkKwDb2iYVSg1dVMI2JikZ
         vJNnuxt+FRNGYdfKXud+suL8Nln82+NeX9c7+Qyd2FmeXrmcfqcSN2ZpPCB+s5VQy8xB
         97DItxAVqBnK7d62nFfXXzDB0fLRc3Dsn1TJzCP3+QyuZFPp1v8iuyfnVWbEPyxGJVOR
         Bb17qKy0K2mnOeH2l6d5gD9JLh3tRZV3TS1a3MuHExujyFVC5HAvzBGxaPw+kEjBHYLb
         GuBw==
X-Gm-Message-State: APjAAAWdB66i5JxXQ12KS6aimVYWq/y+qMDwhGITW/+bmawxzCSmlgGc
        Iw4PwTclsDI/Iie8qQplOgyKRQ==
X-Google-Smtp-Source: APXvYqwaPdrxqPdk41JYSAspvta0fe4hbUpWsJIy2RI0GMnAq0RwwCA1hQJA8N/J6NC0v1BUO/XvGA==
X-Received: by 2002:a50:974b:: with SMTP id d11mr57999294edb.24.1560430640131;
        Thu, 13 Jun 2019 05:57:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e23sm550814ejj.13.2019.06.13.05.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 05:57:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 692681008A9; Thu, 13 Jun 2019 15:57:18 +0300 (+03)
Date:   Thu, 13 Jun 2019 15:57:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com
Subject: Re: [PATCH v3 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190613125718.tgplv5iqkbfhn6vh@box>
References: <20190612220320.2223898-1-songliubraving@fb.com>
 <20190612220320.2223898-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612220320.2223898-4-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:03:17PM -0700, Song Liu wrote:
> This patches introduces a new foll_flag: FOLL_SPLIT_PMD. As the name says
> FOLL_SPLIT_PMD splits huge pmd for given mm_struct, the underlining huge
> page stays as-is.
> 
> FOLL_SPLIT_PMD is useful for cases where we need to use regular pages,
> but would switch back to huge page and huge pmd on. One of such example
> is uprobe. The following patches use FOLL_SPLIT_PMD in uprobe.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ab8c7d84cd0..e605acc4fc81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2642,6 +2642,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>  #define FOLL_COW	0x4000	/* internal GUP flag */
>  #define FOLL_ANON	0x8000	/* don't do file mappings */
>  #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
> +#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
>  
>  /*
>   * NOTE on FOLL_LONGTERM:
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..3d05bddb56c9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -398,7 +398,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  		spin_unlock(ptl);
>  		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>  	}
> -	if (flags & FOLL_SPLIT) {
> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>  		int ret;
>  		page = pmd_page(*pmd);
>  		if (is_huge_zero_page(page)) {
> @@ -407,7 +407,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, pmd, address);
>  			if (pmd_trans_unstable(pmd))
>  				ret = -EBUSY;
> -		} else {
> +		} else if (flags & FOLL_SPLIT) {
>  			if (unlikely(!try_get_page(page))) {
>  				spin_unlock(ptl);
>  				return ERR_PTR(-ENOMEM);
> @@ -419,8 +419,40 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  			put_page(page);
>  			if (pmd_none(*pmd))
>  				return no_page_table(vma, flags);
> -		}
> +		} else {  /* flags & FOLL_SPLIT_PMD */
> +			unsigned long addr;
> +			pgprot_t prot;
> +			pte_t *pte;
> +			int i;
> +
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, address);

All the code below is only relevant for file-backed THP. It will break for
anon-THP.

And I'm not convinced that it belongs here at all. User requested PMD
split and it is done after split_huge_pmd(). The rest can be handled by
the caller as needed.

> +			lock_page(page);
> +			pte = get_locked_pte(mm, address, &ptl);
> +			if (!pte) {
> +				unlock_page(page);
> +				return no_page_table(vma, flags);

Or should it be -ENOMEM?

> +			}
>  
> +			/* get refcount for every small page */
> +			page_ref_add(page, HPAGE_PMD_NR);
> +
> +			prot = READ_ONCE(vma->vm_page_prot);
> +			for (i = 0, addr = address & PMD_MASK;
> +			     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> +				struct page *p = page + i;
> +
> +				pte = pte_offset_map(pmd, addr);
> +				VM_BUG_ON(!pte_none(*pte));
> +				set_pte_at(mm, addr, pte, mk_pte(p, prot));
> +				page_add_file_rmap(p, false);
> +			}
> +
> +			spin_unlock(ptl);
> +			unlock_page(page);
> +			add_mm_counter(mm, mm_counter_file(page), HPAGE_PMD_NR);
> +			ret = 0;
> +		}
>  		return ret ? ERR_PTR(ret) :
>  			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>  	}
> -- 
> 2.17.1
> 

-- 
 Kirill A. Shutemov
