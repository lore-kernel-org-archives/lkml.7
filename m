Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA214C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1987218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eSQsKxtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDXH7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:59:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDXH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:59:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so3601842wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyTsqy7X1JazJUQoVEjyllLP8FDd9yEAFMHRETlOF2g=;
        b=eSQsKxtSjfDf4N3PhAMrQfz4dP/T/6tIiJMoVr2kiUc86ErKN77c4CapAEg+Wpl3tU
         6FAS3TTMBZeNE86LuGJMy88vP95qJgi48b+HQ/c0DJByLwepKXxOC73LXibEatbCNd6m
         MZf6irgEk31upC72RuOK7rrs7N3FUhsvWId6fWVxUxYpTv07fxRK0gdX/92SnbcvMHp/
         t84Xj+RnxASHhApaA++Fqc09m+DrX41TgC3nHlnLBpeT+wHIhBDGxX/KuvJubmDZeaon
         iyrdJsiCGY2ATnMQvs2SpB0HS2jHfqyh7GofnPvAe3sTGDELXK1niripoEXgPlgNDOV6
         h4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyTsqy7X1JazJUQoVEjyllLP8FDd9yEAFMHRETlOF2g=;
        b=TybEiKsXu12ErUL/MGZ5lhMI43mcuG7VMmiUzSrstf3dEP88ysVe7Q/WzNSo5peSkw
         IL2/h2/llD/LRgYvnMEVATaaIZZGMeda9ithBF73OhLfb/4Pn6uyznqDLSpUNq/fefgO
         0Hzsqe8oa0TH0fGoZS181W7tBBn+Tcl4hsahTKWdndmGdYVteRGmexdagb8RuvUYkRhe
         uZtIb7D1dgmay72rOr0G+fJbOUK7CWzRpKxNh/iEkzW8zxfp939m7MC+eG0fsW7ECQf1
         2/FmNfrEeirgLIi4xkGT+y9bk3Tc0dmEVBScAJLSoHuhb0hY1KcRyhZjablctJonG+HX
         Gduw==
X-Gm-Message-State: APjAAAVrqVPECjaWgozbRonfYcju58K3BLmaFHbSa7uFJ3j+lNIafYW4
        EEh4gUQ5Zl7QET5T8Q9Hr0kWvboEexgChUszwhsGhQ==
X-Google-Smtp-Source: APXvYqwvnlBkuWUrsASv3lFrwcbt/gOEnzvkEKWlrG6yE0gONqTMH9/IPWsCm++w9fEHJWrMp9HGE96CecL41KbRg1Y=
X-Received: by 2002:a1c:7610:: with SMTP id r16mr5090269wmc.21.1556092789784;
 Wed, 24 Apr 2019 00:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <1556092268-4646-1-git-send-email-liush.damon@gmail.com>
In-Reply-To: <1556092268-4646-1-git-send-email-liush.damon@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Apr 2019 13:29:38 +0530
Message-ID: <CAAhSdy0yB7iPgZXKu0DpBh_8kgH2xrpSK1aGuOrLkBto3=qC0g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: redefine PTRS_PER_PGD/PTRS_PER_PMD/PTRS_PER_PTE
To:     damon <liush.damon@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>, sorear2@gmail.com,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:21 PM damon <liush.damon@gmail.com> wrote:
>
> Use the number of addresses to define the relevant macros.
>
> Signed-off-by: damon <liush.damon@gmail.com>
> ---
>  arch/riscv/include/asm/pgtable-32.h | 2 ++
>  arch/riscv/include/asm/pgtable-64.h | 3 ++-
>  arch/riscv/include/asm/pgtable.h    | 8 ++++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index d61974b7..433886b 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -17,6 +17,8 @@
>  #include <asm-generic/pgtable-nopmd.h>
>  #include <linux/const.h>
>
> +#define __PAGETABLE_PMD_FOLDED    1

The __PAGETABLE_PMD_FOLDED is already defined in
asm-generic/pgtable-nopmd.h so we don't need to define it here.

> +#define MAX_USER_VA_BITS       32
>  /* Size of region mapped by a page global directory */
>  #define PGDIR_SHIFT     22
>  #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7aa0ea9..a56d4d0 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -16,6 +16,7 @@
>
>  #include <linux/const.h>
>
> +#define MAX_USER_VA_BITS       39
>  #define PGDIR_SHIFT     30
>  /* Size of region mapped by a page global directory */
>  #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
> @@ -34,7 +35,7 @@
>  #define pmd_val(x)      ((x).pmd)
>  #define __pmd(x)        ((pmd_t) { (x) })
>
> -#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
> +#define PTRS_PER_PMD    (1 << (PGDIR_SHIFT - PMD_SHIFT))
>
>  static inline int pud_present(pud_t pud)
>  {
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 1141364..9148043 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -33,9 +33,13 @@
>  #endif /* CONFIG_64BIT */
>
>  /* Number of entries in the page global directory */
> -#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> +#define PTRS_PER_PGD (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>  /* Number of entries in the page table */
> -#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
> +#ifdef __PAGETABLE_PMD_FOLDED
> +#define PTRS_PER_PTE   (1 << (PGDIR_SHIFT - PAGE_SHIFT))
> +#else
> +#define PTRS_PER_PTE   (1 << (PMD_SHIFT - PAGE_SHIFT))
> +#endif
>
>  /* Number of PGD entries that a user-mode program can use */
>  #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
> --
> 1.9.1
>

Apart from above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
