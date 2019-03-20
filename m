Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A196C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17A62186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj4zuUr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCTFxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:53:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43186 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfCTFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:53:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so905584lfh.10;
        Tue, 19 Mar 2019 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrhmhnerAXj/SZsxSHirvl1vkT1GSqQY7yzk8uh02jY=;
        b=Xj4zuUr98OpasG7ah5S6m/IZLTrbkieWNTt5llwR10nog7jZETfbKKdqVAN4z2OxzI
         RTA/9KsUysn39iuVosElnuKvmZQPT5+EPwRRmV6OcR4Bu+kGORCBqlMwYOIm+QqKIoVE
         iVU4ERm38j9Q6qAL/f1RFYy3Rsqvo9xTKQ4d3T74w4DZoabdl9VBaYobqIaBfxfII1tO
         3awZpxOsPG6Dw0tQuNorv8/OhmYlSK7OHzdP9n5vWr0p6zO3JkjEn0+cWqmfcIK0FMPq
         j1kDzh5x9+bSzb1fY11jRhz9bhscFcJfDkZE70MdcvOMAyTdKHSlGCZ1cwrcOLMqzxNp
         CbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrhmhnerAXj/SZsxSHirvl1vkT1GSqQY7yzk8uh02jY=;
        b=Mw90PauC/sRT5XLKQYwB5kZ3cFUyXTHytfZJ8ELxQIuFWGnL9lwZRuVLPWB0ySkT17
         Nf7JY0rz2YNHPin0+BbECrYK4xp5NE9yJS8X5MyjclUQJKUdZlPg5sWZdvzSt1nFEO2/
         TjjKgN+bn1PWoUzXOEEeMLORaAMGqIbaRZAuUeyo5cFckOuveXicqucEMshMiJ0d8iiT
         ucvddCg9lXjVy7MyJrjySvRmO5bPHOIqhdvKjPwdpK3qXhwYuXkehvTopXyubSBsuRsF
         /QbF8Tf7HmMpg5hgi83Hzir4HddjrekGgx95NMkKvfNJOKsmliLRSMN8GniuwrewbUYe
         e/TA==
X-Gm-Message-State: APjAAAXUS4htg+38snJ16690V+vCHltKpclOrhcGXD2Y+X5K3bohz42Z
        dyb8LYmYPrMkpFxaWnityh7+sb2isiDxNIOLCXc=
X-Google-Smtp-Source: APXvYqxgqzV3haY+bjC0EJsuQF2V4L7AiGTBk+6GIup+L1XXx4Zbko4sL98kKqS34vkUcJOBPbm1cpOF3Cle54Dvd8Q=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr10371452lfm.14.1553061196224;
 Tue, 19 Mar 2019 22:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 20 Mar 2019 11:23:03 +0530
Message-ID: <CAFqt6zbqYyzVB3HbYXv19jo8=3hGC=XZAkwvE8PCVdLOKTeG1g@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     chrubis@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        kirill@shutemov.name, osalvador@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:06 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> When MPOL_MF_STRICT was specified and an existing page was already
> on a node that does not follow the policy, mbind() should return -EIO.
> But commit 6f4576e3687b ("mempolicy: apply page table walker on
> queue_pages_range()") broke the rule.
>
> And, commit c8633798497c ("mm: mempolicy: mbind and migrate_pages
> support thp migration") didn't return the correct value for THP mbind()
> too.
>
> If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it reaches
> queue_pages_to_pte_range() or queue_pages_pmd() to check if an existing
> page was already on a node that does not follow the policy.  And,
> non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
> MPOL_MF_MOVE_ALL was specified.
>
> Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
>
> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: stable@vger.kernel.org
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/mempolicy.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index abe7a67..401c817 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -447,6 +447,13 @@ static inline bool queue_pages_required(struct page *page,
>         return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>  }
>
> +/*
> + * The queue_pages_pmd() may have three kind of return value.
> + * 1 - pages are placed on he right node or queued successfully.

Minor typo -> s/he/the ?

> + * 0 - THP get split.
> + * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
> + *        page was already on a node that does not follow the policy.
> + */
>  static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>                                 unsigned long end, struct mm_walk *walk)
>  {
> @@ -456,7 +463,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>         unsigned long flags;
>
>         if (unlikely(is_pmd_migration_entry(*pmd))) {
> -               ret = 1;
> +               ret = -EIO;
>                 goto unlock;
>         }
>         page = pmd_page(*pmd);
> @@ -473,8 +480,15 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>         ret = 1;
>         flags = qp->flags;
>         /* go to thp migration */
> -       if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> +       if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> +               if (!vma_migratable(walk->vma)) {
> +                       ret = -EIO;
> +                       goto unlock;
> +               }
> +
>                 migrate_page_add(page, qp->pagelist, flags);
> +       } else
> +               ret = -EIO;
>  unlock:
>         spin_unlock(ptl);
>  out:
> @@ -499,8 +513,10 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>         ptl = pmd_trans_huge_lock(pmd, vma);
>         if (ptl) {
>                 ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -               if (ret)
> +               if (ret > 0)
>                         return 0;
> +               else if (ret < 0)
> +                       return ret;
>         }
>
>         if (pmd_trans_unstable(pmd))
> @@ -521,11 +537,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>                         continue;
>                 if (!queue_pages_required(page, qp))
>                         continue;
> -               migrate_page_add(page, qp->pagelist, flags);
> +               if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> +                       if (!vma_migratable(vma))
> +                               break;
> +                       migrate_page_add(page, qp->pagelist, flags);
> +               } else
> +                       break;
>         }
>         pte_unmap_unlock(pte - 1, ptl);
>         cond_resched();
> -       return 0;
> +       return addr != end ? -EIO : 0;
>  }
>
>  static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
> @@ -595,7 +616,12 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>         unsigned long endvma = vma->vm_end;
>         unsigned long flags = qp->flags;
>
> -       if (!vma_migratable(vma))
> +       /*
> +        * Need check MPOL_MF_STRICT to return -EIO if possible
> +        * regardless of vma_migratable
> +        */
> +       if (!vma_migratable(vma) &&
> +           !(flags & MPOL_MF_STRICT))
>                 return 1;
>
>         if (endvma > end)
> @@ -622,7 +648,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>         }
>
>         /* queue pages from current vma */
> -       if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> +       if (flags & MPOL_MF_VALID)
>                 return 0;
>         return 1;
>  }
> --
> 1.8.3.1
>
