Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF1CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745620659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUrpbdi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502346AbfJXNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:07:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32937 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502315AbfJXNHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:07:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so24962117ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FOM7ndVHXZYwpn+oC9FBYu9U1A1waA78aHf4RJR9TG4=;
        b=tUrpbdi8Eq04JfJSCU2ivYJh7UkVx4nqIXjqa8J9drpcNlEVXcNo4a9YwE/JAmjIyu
         TRDJxWh5NoPsRPbYJHYEXSJmYcAvR1763uPXPh7WDgnuz8axippQY0aZ5jphZUvKJOUq
         ezEU+BUHXhPAWfutE/aUnkq1vAUfYqjsQy1OzzXrf9Ah2vlUA1EzIyvQIJcjMTBPEuM+
         GcE2jhkR1lGAVhjvtZD4gE5xQ5WHb30S1lFUeq30zGi8KzCyo95piwJ590DLLGjrn+v9
         FxaPlAT75rgyIg4RKDfXjskQSEOiA1ihxXAVaXK0TjbMhSVvAT4EzHb0mCAYRYcN9/Pk
         +VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FOM7ndVHXZYwpn+oC9FBYu9U1A1waA78aHf4RJR9TG4=;
        b=fy+bcAUvLvA2bgPKXJJVDEPfGjd1muHvfzoFaq4c50Rtk1i85bkt/BkTTw/LoZsnTa
         gH1badlvdvsYOAj6JLg8qIqnDlmDH3rlQ+OfcMgqFhu2+13Sg2PS7hmvQ8yxUq8lDk7I
         NOyAEa3rhSi3GvtmiA5XTe627eIHIxWkJJ6fHQEPPe/2E7pWFASGPVBPRgFARdHkhoH7
         oolpemesZfA/nQ8W67CYVcWV2HjMCsnCeRujlOVTqkNkeDrJhzOzTk+x1l1ALLgn/M70
         Gh+VKXgZrZQv5JS2vrrDeZgRMco8LqDB3N7UF1qCzLP0jnH1s5jDoQgSn1Rebwe+bk7N
         YzKA==
X-Gm-Message-State: APjAAAWn7hNvRSV2mLfdNQkRmPAM6VeosSlpF597mta4Pl+EOj17S1i5
        N3kB+b9OKskpu8dzWKKi809PV/UsrWoXgXquoiM=
X-Google-Smtp-Source: APXvYqw5KIftPmypxtxt7CnPqUUFBNnsiv5OeK7obTXadnJ3YzS5IG8h5KuyUgciUiVK1/xe2qKna7NwxkamCsQRO6s=
X-Received: by 2002:a2e:3617:: with SMTP id d23mr4728822lja.169.1571922452313;
 Thu, 24 Oct 2019 06:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101248.33727-1-steven.price@arm.com> <20191018101248.33727-15-steven.price@arm.com>
In-Reply-To: <20191018101248.33727-15-steven.price@arm.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 24 Oct 2019 21:07:20 +0800
Message-ID: <CA+ZOyaij0A3XCDNSYxp9a3bKO8TVkxCTkQpcCBfiBo_hRszc6g@mail.gmail.com>
Subject: Re: [PATCH v12 14/22] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Price <steven.price@arm.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The pte_hole() callback is called at multiple levels of the page tables.
> Code dumping the kernel page tables needs to know what at what depth
> the missing entry is. Add this is an extra parameter to pte_hole().
> When the depth isn't know (e.g. processing a vma) then -1 is passed.
>
> The depth that is reported is the actual level where the entry is
> missing (ignoring any folding that is in place), i.e. any levels where
> PTRS_PER_P?D is set to 1 are ignored.
>
> Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
> natural numbers as levels 2/3/4.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  fs/proc/task_mmu.c       |  4 ++--
>  include/linux/pagewalk.h |  7 +++++--
>  mm/hmm.c                 |  8 ++++----
>  mm/migrate.c             |  5 +++--
>  mm/mincore.c             |  1 +
>  mm/pagewalk.c            | 31 +++++++++++++++++++++++++------
>  6 files changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9442631fd4af..3ba9ae83bff5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -505,7 +505,7 @@ static void smaps_account(struct mem_size_stats *mss,=
 struct page *page,
>
>  #ifdef CONFIG_SHMEM
>  static int smaps_pte_hole(unsigned long addr, unsigned long end,
> -               struct mm_walk *walk)
> +                         __always_unused int depth, struct mm_walk *walk=
)
>  {
>         struct mem_size_stats *mss =3D walk->private;
>
> @@ -1282,7 +1282,7 @@ static int add_to_pagemap(unsigned long addr, pagem=
ap_entry_t *pme,
>  }
>
>  static int pagemap_pte_hole(unsigned long start, unsigned long end,
> -                               struct mm_walk *walk)
> +                           __always_unused int depth, struct mm_walk *wa=
lk)
>  {
>         struct pagemapread *pm =3D walk->private;
>         unsigned long addr =3D start;
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index df424197a25a..90466d60f87a 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -17,7 +17,10 @@ struct mm_walk;
>   *                     split_huge_page() instead of handling it explicit=
ly.
>   * @pte_entry:         if set, called for each non-empty PTE (lowest-lev=
el)
>   *                     entry
> - * @pte_hole:          if set, called for each hole at all levels
> + * @pte_hole:          if set, called for each hole at all levels,
> + *                     depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:=
PMD
> + *                     4:PTE. Any folded depths (where PTRS_PER_P?D is e=
qual
> + *                     to 1) are skipped.
>   * @hugetlb_entry:     if set, called for each hugetlb entry
>   * @test_walk:         caller specific callback function to determine wh=
ether
>   *                     we walk over the current vma or not. Returning 0 =
means
> @@ -45,7 +48,7 @@ struct mm_walk_ops {
>         int (*pte_entry)(pte_t *pte, unsigned long addr,
>                          unsigned long next, struct mm_walk *walk);
>         int (*pte_hole)(unsigned long addr, unsigned long next,
> -                       struct mm_walk *walk);
> +                       int depth, struct mm_walk *walk);
>         int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
>                              unsigned long addr, unsigned long next,
>                              struct mm_walk *walk);
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 902f5fa6bf93..df3d531c8f2d 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -376,7 +376,7 @@ static void hmm_range_need_fault(const struct hmm_vma=
_walk *hmm_vma_walk,
>  }
>
>  static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
> -                            struct mm_walk *walk)
> +                            __always_unused int depth, struct mm_walk *w=
alk)
>  {
>         struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>         struct hmm_range *range =3D hmm_vma_walk->range;
> @@ -564,7 +564,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  again:
>         pmd =3D READ_ONCE(*pmdp);
>         if (pmd_none(pmd))
> -               return hmm_vma_walk_hole(start, end, walk);
> +               return hmm_vma_walk_hole(start, end, -1, walk);
>
>         if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
>                 bool fault, write_fault;
> @@ -666,7 +666,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned lon=
g start, unsigned long end,
>  again:
>         pud =3D READ_ONCE(*pudp);
>         if (pud_none(pud))
> -               return hmm_vma_walk_hole(start, end, walk);
> +               return hmm_vma_walk_hole(start, end, -1, walk);
>
>         if (pud_huge(pud) && pud_devmap(pud)) {
>                 unsigned long i, npages, pfn;
> @@ -674,7 +674,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned lon=
g start, unsigned long end,
>                 bool fault, write_fault;
>
>                 if (!pud_present(pud))
> -                       return hmm_vma_walk_hole(start, end, walk);
> +                       return hmm_vma_walk_hole(start, end, -1, walk);
>
>                 i =3D (addr - range->start) >> PAGE_SHIFT;
>                 npages =3D (end - addr) >> PAGE_SHIFT;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fe45d1428c8..435258df9a36 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2123,6 +2123,7 @@ int migrate_misplaced_transhuge_page(struct mm_stru=
ct *mm,
>  #ifdef CONFIG_DEVICE_PRIVATE
>  static int migrate_vma_collect_hole(unsigned long start,
>                                     unsigned long end,
> +                                   __always_unused int depth,
>                                     struct mm_walk *walk)
>  {
>         struct migrate_vma *migrate =3D walk->private;
> @@ -2167,7 +2168,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>
>  again:
>         if (pmd_none(*pmdp))
> -               return migrate_vma_collect_hole(start, end, walk);
> +               return migrate_vma_collect_hole(start, end, -1, walk);
>
>         if (pmd_trans_huge(*pmdp)) {
>                 struct page *page;
> @@ -2200,7 +2201,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>                                 return migrate_vma_collect_skip(start, en=
d,
>                                                                 walk);
>                         if (pmd_none(*pmdp))
> -                               return migrate_vma_collect_hole(start, en=
d,
> +                               return migrate_vma_collect_hole(start, en=
d, -1,
>                                                                 walk);
>                 }
>         }
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 49b6fa2f6aa1..0e6dd9948f1a 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -112,6 +112,7 @@ static int __mincore_unmapped_range(unsigned long add=
r, unsigned long end,
>  }
>
>  static int mincore_unmapped_range(unsigned long addr, unsigned long end,
> +                                  __always_unused int depth,
>                                    struct mm_walk *walk)
>  {
>         walk->private +=3D __mincore_unmapped_range(addr, end,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 43acffefd43f..b67400dc1def 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -4,6 +4,22 @@
>  #include <linux/sched.h>
>  #include <linux/hugetlb.h>
>
> +/*
> + * We want to know the real level where a entry is located ignoring any
> + * folding of levels which may be happening. For example if p4d is folde=
d then
> + * a missing entry found at level 1 (p4d) is actually at level 0 (pgd).
> + */
> +static int real_depth(int depth)
> +{
> +       if (depth =3D=3D 3 && PTRS_PER_PMD =3D=3D 1)
> +               depth =3D 2;
> +       if (depth =3D=3D 2 && PTRS_PER_PUD =3D=3D 1)
> +               depth =3D 1;
> +       if (depth =3D=3D 1 && PTRS_PER_P4D =3D=3D 1)
> +               depth =3D 0;
> +       return depth;
> +}
> +
>  static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long =
end,
>                           struct mm_walk *walk)
>  {
> @@ -33,6 +49,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long add=
r, unsigned long end,
>         unsigned long next;
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
> +       int depth =3D real_depth(3);
>
>         if (ops->test_pmd) {
>                 err =3D ops->test_pmd(addr, end, pmd_offset(pud, 0UL), wa=
lk);
> @@ -48,7 +65,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long add=
r, unsigned long end,
>                 next =3D pmd_addr_end(addr, end);
>                 if (pmd_none(*pmd)) {
>                         if (ops->pte_hole)
> -                               err =3D ops->pte_hole(addr, next, walk);
> +                               err =3D ops->pte_hole(addr, next, depth, =
walk);
>                         if (err)
>                                 break;
>                         continue;
> @@ -92,6 +109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long ad=
dr, unsigned long end,
>         unsigned long next;
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
> +       int depth =3D real_depth(2);
>
>         if (ops->test_pud) {
>                 err =3D ops->test_pud(addr, end, pud_offset(p4d, 0UL), wa=
lk);
> @@ -107,7 +125,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long a=
ddr, unsigned long end,
>                 next =3D pud_addr_end(addr, end);
>                 if (pud_none(*pud)) {
>                         if (ops->pte_hole)
> -                               err =3D ops->pte_hole(addr, next, walk);
> +                               err =3D ops->pte_hole(addr, next, depth, =
walk);
>                         if (err)
>                                 break;
>                         continue;
> @@ -143,6 +161,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long a=
ddr, unsigned long end,
>         unsigned long next;
>         const struct mm_walk_ops *ops =3D walk->ops;
>         int err =3D 0;
> +       int depth =3D real_depth(1);
>
>         if (ops->test_p4d) {
>                 err =3D ops->test_p4d(addr, end, p4d_offset(pgd, 0UL), wa=
lk);
> @@ -157,7 +176,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long a=
ddr, unsigned long end,
>                 next =3D p4d_addr_end(addr, end);
>                 if (p4d_none_or_clear_bad(p4d)) {
>                         if (ops->pte_hole)
> -                               err =3D ops->pte_hole(addr, next, walk);
> +                               err =3D ops->pte_hole(addr, next, depth, =
walk);
>                         if (err)
>                                 break;
>                         continue;
> @@ -189,7 +208,7 @@ static int walk_pgd_range(unsigned long addr, unsigne=
d long end,
>                 next =3D pgd_addr_end(addr, end);
>                 if (pgd_none_or_clear_bad(pgd)) {
>                         if (ops->pte_hole)
> -                               err =3D ops->pte_hole(addr, next, walk);
> +                               err =3D ops->pte_hole(addr, next, 0, walk=
);
>                         if (err)
>                                 break;
>                         continue;
> @@ -236,7 +255,7 @@ static int walk_hugetlb_range(unsigned long addr, uns=
igned long end,
>                 if (pte)
>                         err =3D ops->hugetlb_entry(pte, hmask, addr, next=
, walk);
>                 else if (ops->pte_hole)
> -                       err =3D ops->pte_hole(addr, next, walk);
> +                       err =3D ops->pte_hole(addr, next, -1, walk);
>
>                 if (err)
>                         break;
> @@ -280,7 +299,7 @@ static int walk_page_test(unsigned long start, unsign=
ed long end,
>         if (vma->vm_flags & VM_PFNMAP) {
>                 int err =3D 1;
>                 if (ops->pte_hole)
> -                       err =3D ops->pte_hole(start, end, walk);
> +                       err =3D ops->pte_hole(start, end, -1, walk);
>                 return err ? err : 1;
>         }
>         return 0;
> --
> 2.20.1
>

It's good to me.

Tested-by: Zong Li <zong.li@sifive.com>
