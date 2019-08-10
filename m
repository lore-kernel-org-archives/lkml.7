Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA7C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9C20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnqIjeWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfHJBZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 21:25:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32962 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfHJBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 21:25:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so33457238edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDyGTNUlAIJSsd2gHGS97/3RJOYDdm2ReyWWRSQNAzg=;
        b=rnqIjeWamgRoNEkmSdp39pB4BHD1ZMt45SlShR8HNFjMDhN+EjIZH1x028jBcpwUZ6
         nLlNFlMHMSmS09IR7hdl4AwWuxn2f9bznUcheJibNXsHTnIPa5U1ZnYDe5ZhsHaG2g0/
         QrjOwGHUGFrU7n5Ql8hjNRdhxosQw6mXCZTobGXWy3uL8PEvoeTagZpF/z7265RjkQY8
         +48uZNT0js6SJ6a9DZ+P03EMdxBDq8PghuHSRJ5m1wG3LFSWCf2qnGw8KR5lMA+swFeh
         Mg8qAgV32mMdpMrXPhIzqOKGMvQT9EFULGegNcmGFzuCKNkEfuinPRrZr2vIfo80Gssz
         l8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDyGTNUlAIJSsd2gHGS97/3RJOYDdm2ReyWWRSQNAzg=;
        b=b0P3LU0NRizcHlb7gNt4HkIqYYjjHrKg2busmCVJNtnseVxXUIt29dJnji+hF+tRJs
         ehv3qwb2k1TKqlBTc/dIRYRGsFt5jBpdui1CJBaaa7BLV9uPmY3nrShNb5KTtsdyiYVZ
         Zjdslugt/m3xb7VxxuDnmgC8H/ktw4tkLyBe4fam4FKV1ttbj94rPjftHFbw771nQggB
         gSxcUUFFMYfU6I+qXt5TRJNNzKkF8ZIrZuj2xg1ezhxq29K8Hne9AbyU9M2zHehqyx6q
         8WZj8k3J2d/d3JzFS93Mua7f31Hx8/gpBLl3cMm+A2d1nwVMRQ2BNEXQoxq7HeAqm11U
         PigA==
X-Gm-Message-State: APjAAAVjLOz2DgB4CqORfuhM6oxFXssBnE7lSPYNqf4s//tx9WO2BXLt
        yz6K03Y5qj7pJ1wrntvMrNCXBYl1K1uw4Tr7elc=
X-Google-Smtp-Source: APXvYqzWyFYDx6zcjLqAejhETmd/jBdE6rJma6bcs3NyI8MGZ5uR1f65UlvFOn7nFq6uMf2yTdb4UOQup4s6tdjBgOU=
X-Received: by 2002:aa7:cf8e:: with SMTP id z14mr25154937edx.40.1565400330482;
 Fri, 09 Aug 2019 18:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190808071808.6531-1-hslester96@gmail.com> <87y302segw.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y302segw.fsf@concordia.ellerman.id.au>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sat, 10 Aug 2019 09:25:19 +0800
Message-ID: <CANhBUQ3VpwxyMpQ29kphcowgmpPPTBLtBV19tBGVX82uUs=Wmw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Use refcount_t for refcount
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Chuhong Yuan <hslester96@gmail.com> writes:
> > Reference counters are preferred to use refcount_t instead of
> > atomic_t.
> > This is because the implementation of refcount_t can prevent
> > overflows and detect possible use-after-free.
> > So convert atomic_t ref counters to refcount_t.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> Thanks.
>
> We don't have a fast implementation of refcount_t, so I'm worried this
> could cause a measurable performance regression.
>
> Did you benchmark it at all?
>

I did not benchmark it and I don't have the testing environment...

> cheers
>
> > diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
> > index 2d0cb5ba9a47..f836fd5a6abc 100644
> > --- a/arch/powerpc/mm/book3s64/mmu_context.c
> > +++ b/arch/powerpc/mm/book3s64/mmu_context.c
> > @@ -231,7 +231,7 @@ static void pmd_frag_destroy(void *pmd_frag)
> >       /* drop all the pending references */
> >       count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
> >       /* We allow PTE_FRAG_NR fragments from a PTE page */
> > -     if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
> > +     if (refcount_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
> >               pgtable_pmd_page_dtor(page);
> >               __free_page(page);
> >       }
> > diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> > index 7d0e0d0d22c4..40056896ce4e 100644
> > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > @@ -277,7 +277,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
> >               return NULL;
> >       }
> >
> > -     atomic_set(&page->pt_frag_refcount, 1);
> > +     refcount_set(&page->pt_frag_refcount, 1);
> >
> >       ret = page_address(page);
> >       /*
> > @@ -294,7 +294,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
> >        * count.
> >        */
> >       if (likely(!mm->context.pmd_frag)) {
> > -             atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
> > +             refcount_set(&page->pt_frag_refcount, PMD_FRAG_NR);
> >               mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
> >       }
> >       spin_unlock(&mm->page_table_lock);
> > @@ -317,8 +317,7 @@ void pmd_fragment_free(unsigned long *pmd)
> >  {
> >       struct page *page = virt_to_page(pmd);
> >
> > -     BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> > -     if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> > +     if (refcount_dec_and_test(&page->pt_frag_refcount)) {
> >               pgtable_pmd_page_dtor(page);
> >               __free_page(page);
> >       }
> > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > index a7b05214760c..4ef8231b677f 100644
> > --- a/arch/powerpc/mm/pgtable-frag.c
> > +++ b/arch/powerpc/mm/pgtable-frag.c
> > @@ -24,7 +24,7 @@ void pte_frag_destroy(void *pte_frag)
> >       /* drop all the pending references */
> >       count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
> >       /* We allow PTE_FRAG_NR fragments from a PTE page */
> > -     if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> > +     if (refcount_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> >               pgtable_page_dtor(page);
> >               __free_page(page);
> >       }
> > @@ -71,7 +71,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> >                       return NULL;
> >       }
> >
> > -     atomic_set(&page->pt_frag_refcount, 1);
> > +     refcount_set(&page->pt_frag_refcount, 1);
> >
> >       ret = page_address(page);
> >       /*
> > @@ -87,7 +87,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> >        * count.
> >        */
> >       if (likely(!pte_frag_get(&mm->context))) {
> > -             atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> > +             refcount_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> >               pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
> >       }
> >       spin_unlock(&mm->page_table_lock);
> > @@ -110,8 +110,7 @@ void pte_fragment_free(unsigned long *table, int kernel)
> >  {
> >       struct page *page = virt_to_page(table);
> >
> > -     BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> > -     if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> > +     if (refcount_dec_and_test(&page->pt_frag_refcount)) {
> >               if (!kernel)
> >                       pgtable_page_dtor(page);
> >               __free_page(page);
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 3a37a89eb7a7..7fe23a3faf95 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/uprobes.h>
> >  #include <linux/page-flags-layout.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/refcount.h>
> >
> >  #include <asm/mmu.h>
> >
> > @@ -147,7 +148,7 @@ struct page {
> >                       unsigned long _pt_pad_2;        /* mapping */
> >                       union {
> >                               struct mm_struct *pt_mm; /* x86 pgds only */
> > -                             atomic_t pt_frag_refcount; /* powerpc */
> > +                             refcount_t pt_frag_refcount; /* powerpc */
> >                       };
> >  #if ALLOC_SPLIT_PTLOCKS
> >                       spinlock_t *ptl;
> > --
> > 2.20.1
