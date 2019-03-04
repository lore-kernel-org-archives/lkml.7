Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CDC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEEC20645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPLxhhUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCDMCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:02:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43462 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:02:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id p73so2713180lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guNt41lbGYnWxFVBh6b7n+727OGehx1dipKcWFoG7GU=;
        b=ZPLxhhUGFE6sMjm3CSX4MszZlekzYseSBuXShoSJEbve7Xpt+HQY7w3aeVVyLg4Q0E
         rz7SXNHehlssV433+XEAIW+tp2lSezTqc63anXsa40gxQxPKcIq0TAONzL0VJ9OskPbj
         cW9TXVBRh4OsrAbIh/rubW5G2pUGiuBhpaaI8DCsn1cPa94gFdXHKiOs2tk9j2Vs5UD/
         uCaUrU4iFVtcw6CzLfZz++4nKr1QmZM8aNt4MW5ACPNOBmdSQBZx4rqcM0LExoa5rwmF
         AvM1oSs13MP69AGzes7Y+Hro3O0a6R+ve/0ZfnI3ZQ/LLFc0W1qDaDpeMudvr0MEYGWP
         H66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guNt41lbGYnWxFVBh6b7n+727OGehx1dipKcWFoG7GU=;
        b=UQBddc6GFLKsz6wP8YxqWjHC4qvmRELOJFTQoT8ty0mvKq4J+B4bl9fpwATQakWLxH
         0pMvCa3aNHzoyMtAElCzIYfX5ANYMlF2Pn5tgo01lJiOs7Bt8Ha//AdmQanDoOIwbnLM
         ftQX0QPupGkffs15ozk4xwdWnMENZsIwCRFrptrUpBIGzhz6UN6zMzOUN7TOznbS7xb3
         WCR4aIpeoDFpwJ2ArMs5oe59QtOzdEOGa9xPGplEqAN9lIRmN/0QK26c8tYO0+UfSJvi
         haO0eebUJtIIfFnu0jLhnnFTkzugLv/skdraMqIdVGB3qKYDsHRKiNxJblwXoGJsy4r8
         aE3g==
X-Gm-Message-State: APjAAAX5wSo/fbr32uVdX7QvzdFkj7v2XT1fFLnipTqooOuUvl3zRiVd
        dRXybbGFw5FSlgY+Pv10aSvAjHAuYZTIxKPH91g=
X-Google-Smtp-Source: APXvYqwTv7X0l7CJX5Q+fwXLGzCLGVXxXCL2whRIaEOeg66goYUFjExi/LN7QkAWUW581E0nKcG2hg5XtTmEUY4VBZk=
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr1046951lfa.64.1551700955508;
 Mon, 04 Mar 2019 04:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20190301221956.97493-1-cai@lca.pw>
In-Reply-To: <20190301221956.97493-1-cai@lca.pw>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 4 Mar 2019 17:32:23 +0530
Message-ID: <CAFqt6zZr8ZCM6_7QDzDEf=5gH=+EkaumXk86X35dGTdn_SLvvA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugepages: fix "orig_pud" set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 3:50 AM Qian Cai <cai@lca.pw> wrote:
>
> The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
> hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
> its return code. In order to not diverge from
> pmdp_huge_get_and_clear_full(), just change zap_huge_pud() to not assign
> the return value from pudp_huge_get_and_clear_full().
>
> mm/huge_memory.c: In function 'zap_huge_pud':
> mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
> [-Wunused-but-set-variable]
>   pud_t orig_pud;
>         ^~~~~~~~
>

4th argument passed to pudp_huge_get_and_clear_full() is not used.
Is it fine to remove *int full * in  pudp_huge_get_and_clear_full() if
there is no plan to use it in future ?

This is applicable to below functions as well -
pmdp_huge_get_and_clear_full()
ptep_get_and_clear_full()
pte_clear_not_present_full()




> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: keep returning a code from pudp_huge_get_and_clear_full() for possible
>     future uses.
>
>  mm/huge_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index faf357eaf0ce..9f57a1173e6a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1979,7 +1979,6 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>  int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                  pud_t *pud, unsigned long addr)
>  {
> -       pud_t orig_pud;
>         spinlock_t *ptl;
>
>         ptl = __pud_trans_huge_lock(pud, vma);
> @@ -1991,8 +1990,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>          * pgtable_trans_huge_withdraw after finishing pudp related
>          * operations.
>          */
> -       orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
> -                       tlb->fullmm);
> +       pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
>         tlb_remove_pud_tlb_entry(tlb, pud, addr);
>         if (vma_is_dax(vma)) {
>                 spin_unlock(ptl);
> --
> 2.17.2 (Apple Git-113)
>
