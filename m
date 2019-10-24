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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839FCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C0920663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5TAheGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393522AbfJXNHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:07:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36783 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJXNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:07:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so24977510ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tkk6G5aHv6FVuWM741oKE389BRFXRaj6IbXbEW6yA1Y=;
        b=n5TAheGlAHyqwUFch1gDhnr7YjBFCO1Wk56bpymnySGUNJ3WfCvdDHuboiKcMLQb03
         exkAUP0/TUfc1Jl1ZJCgn3dDFQ1DhlaF3mDeu/CLPPluUcMVLAyNVCpeNyrzBpsO4vF/
         cVUkbHTKHKfV2Bv+s14y50GtUjXSCwmI8wz5pxmcBb8eYC3ur8o5dIgFlf2ZPkzw532K
         Kep1ZzfRHm3cY/zfGx2nIBzyUjOPHKZ5oZg7ZkcA3pAr9Sl12cV03Y1cupWc1fwDsvTu
         L7g8XjIgybiySuSzD7LZXc+Bc7zrDeL+gBhlkrcxCtrsVtq5TkpYqDETZLk77gNl5CXS
         FLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tkk6G5aHv6FVuWM741oKE389BRFXRaj6IbXbEW6yA1Y=;
        b=ms2Jqp033AfLNnYIUb9TJvbil1Apa8wvmvbCzByIgCESlRuEtQx5A1ryda0485vj3Z
         h91EbGs6WzD4AmOd/HBXdSFd8Bxe67SS6mOzE8MWK4mMON9+F1XXA3n4sOZumKL4fq5q
         uHX0T4uGDlzifkW8AjZN7eSsocEIzBCv/BMD5yD0KLCHmCQgG4F1yrs0lSv/kKpSHSSV
         xoUwRsHMYfB3TiDQNREmN9dcn1wkSd/yUqXnzugm3haoVvHqIyCCbFiiQIkFJeQKIKpu
         XAd8sTIS8SD123YZdomHMIp1BkGKs4CAJzIknW4Wq8JvWJXNzhAwZWpoCbwrZKoeIYes
         T4WA==
X-Gm-Message-State: APjAAAWEdf8rtbfNC5laS6ckQs3eOjHiJdvWpHJq3EwWJqGF7THJV24d
        AZTRdDOYLi+0I2tt16y//1nzIWMhaBEtvjp+fZ0=
X-Google-Smtp-Source: APXvYqwKbGmB3fZE31Be7iKOqtLOx2kBt/iIU4EzatUeJ/XuUjsrMJXzEx7sWNPPbTCPFOfdQZVsoTbIcyjaEJ7/0eo=
X-Received: by 2002:a2e:970b:: with SMTP id r11mr9317177lji.56.1571922426444;
 Thu, 24 Oct 2019 06:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101248.33727-1-steven.price@arm.com> <20191018101248.33727-12-steven.price@arm.com>
In-Reply-To: <20191018101248.33727-12-steven.price@arm.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 24 Oct 2019 21:06:55 +0800
Message-ID: <CA+ZOyahf-G6Mzr0eF9YA0=HTtKPk+vJpSr3wFtKf_VZHbb-HRg@mail.gmail.com>
Subject: Re: [PATCH v12 11/22] mm: pagewalk: Add p4d_entry() and pgd_entry()
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
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
> no users. We're about to add users so reintroduce them, along with
> p4d_entry() as we now have 5 levels of tables.
>
> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
> PUD-sized transparent hugepages") already re-added pud_entry() but with
> different semantics to the other callbacks. Since there have never
> been upstream users of this, revert the semantics back to match the
> other callbacks. This means pud_entry() is called for all entries, not
> just transparent huge pages.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/pagewalk.h | 19 +++++++++++++------
>  mm/pagewalk.c            | 27 ++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index bddd9759bab9..12004b097eae 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -8,15 +8,15 @@ struct mm_walk;
>
>  /**
>   * mm_walk_ops - callbacks for walk_page_range
> - * @pud_entry:         if set, called for each non-empty PUD (2nd-level)=
 entry
> - *                     this handler should only handle pud_trans_huge() =
puds.
> - *                     the pmd_entry or pte_entry callbacks will be used=
 for
> - *                     regular PUDs.
> - * @pmd_entry:         if set, called for each non-empty PMD (3rd-level)=
 entry
> + * @pgd_entry:         if set, called for each non-empty PGD (top-level)=
 entry
> + * @p4d_entry:         if set, called for each non-empty P4D entry
> + * @pud_entry:         if set, called for each non-empty PUD entry
> + * @pmd_entry:         if set, called for each non-empty PMD entry
>   *                     this handler is required to be able to handle
>   *                     pmd_trans_huge() pmds.  They may simply choose to
>   *                     split_huge_page() instead of handling it explicit=
ly.
> - * @pte_entry:         if set, called for each non-empty PTE (4th-level)=
 entry
> + * @pte_entry:         if set, called for each non-empty PTE (lowest-lev=
el)
> + *                     entry
>   * @pte_hole:          if set, called for each hole at all levels
>   * @hugetlb_entry:     if set, called for each hugetlb entry
>   * @test_walk:         caller specific callback function to determine wh=
ether
> @@ -24,8 +24,15 @@ struct mm_walk;
>   *                     "do page table walk over the current vma", return=
ing
>   *                     a negative value means "abort current page table =
walk
>   *                     right now" and returning 1 means "skip the curren=
t vma"
> + *
> + * p?d_entry callbacks are called even if those levels are folded on a
> + * particular architecture/configuration.
>   */
>  struct mm_walk_ops {
> +       int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
> +                        unsigned long next, struct mm_walk *walk);
> +       int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
> +                        unsigned long next, struct mm_walk *walk);
>         int (*pud_entry)(pud_t *pud, unsigned long addr,
>                          unsigned long next, struct mm_walk *walk);
>         int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d48c2a986ea3..fc4d98a3a5a0 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -93,15 +93,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long ad=
dr, unsigned long end,
>                 }
>
>                 if (ops->pud_entry) {
> -                       spinlock_t *ptl =3D pud_trans_huge_lock(pud, walk=
->vma);
> -
> -                       if (ptl) {
> -                               err =3D ops->pud_entry(pud, addr, next, w=
alk);
> -                               spin_unlock(ptl);
> -                               if (err)
> -                                       break;
> -                               continue;
> -                       }
> +                       err =3D ops->pud_entry(pud, addr, next, walk);
> +                       if (err)
> +                               break;
>                 }
>
>                 split_huge_pud(walk->vma, pud, addr);
> @@ -135,7 +129,12 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long =
addr, unsigned long end,
>                                 break;
>                         continue;
>                 }
> -               if (ops->pmd_entry || ops->pte_entry)
> +               if (ops->p4d_entry) {
> +                       err =3D ops->p4d_entry(p4d, addr, next, walk);
> +                       if (err)
> +                               break;
> +               }
> +               if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
>                         err =3D walk_pud_range(p4d, addr, next, walk);
>                 if (err)
>                         break;
> @@ -162,7 +161,13 @@ static int walk_pgd_range(unsigned long addr, unsign=
ed long end,
>                                 break;
>                         continue;
>                 }
> -               if (ops->pmd_entry || ops->pte_entry)
> +               if (ops->pgd_entry) {
> +                       err =3D ops->pgd_entry(pgd, addr, next, walk);
> +                       if (err)
> +                               break;
> +               }
> +               if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
> +                   ops->pte_entry)
>                         err =3D walk_p4d_range(pgd, addr, next, walk);
>                 if (err)
>                         break;
> --
> 2.20.1
>

It's good to me.

Tested-by: Zong Li <zong.li@sifive.com>
