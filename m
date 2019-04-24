Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2139C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D06D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fZm/mIR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfDXIOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:14:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35907 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfDXIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:14:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so3663319wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CiGHCAKatf4kNBt0YMVwMSFYBbcXaklFVv/SSVvxcOU=;
        b=fZm/mIR1WzmM7VHB9v+sy1F9NYu0FQse6CdMo7LM/go+9NRrtXwiqVB+huVDiQxTCr
         DL/Vpj82t1EeJFa3H+blI0PnDBX+ISFey09idiEOcSUPohGzj8QH1B/hd9B8sXD3kgVU
         rOonZV2dbIbz/IFqEMhAaADlQ52EIZ7OVmTDZJSMEFr4Uhx022H8HHegwKn3beFuBapH
         2o5isqGyFqt+Ig/SALbeGGW3J/3cHhRA6QowTnpmSroM+zy8gVgMfOZhzfU609zbVJ8j
         pMI1ZSV61/rf8KUxpTcPjTlEApnxE5hIkM3sOpnsCuzOsiccDbjH4fAEphX/2nvjad9x
         3urQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiGHCAKatf4kNBt0YMVwMSFYBbcXaklFVv/SSVvxcOU=;
        b=Dr9JnhcdDXXAsY662LO6RjIvB9aTSo5jT2vaUkmhjbLutblarpqUBVt2Svl/fFKqOV
         zA13Xa2Abxe8sN7I3V/IdnvaQALTRjKmp/ALBB4l4FJTsq76Ota70/0Mo5r4jrPYLzvR
         MSDOl/uAnuMEiP9tf8PLIN4l9vrfdVRO6dz6Lu1xwqQRcD5EGWRWWVxsv5R5dyYeN4C0
         Rb5HDNZgY2GU/An4/p4PsCXSzy9cnBW5wA4sHsWuG+QE+7tm47L38n3RcVjBtwIqqDVo
         klBE/rAr3hfmOHCsXsil40uADJqYxtJQ+97Cz4Namib+J79Yrq6OMpR/QoJlvtZ/t+g2
         G1RQ==
X-Gm-Message-State: APjAAAW6PEeeeaJoxcXayBGTXRCUgVv1qGOrMRDF/s5wuIHOPk5c52VS
        iXildqb9G5FL/Jv6PNQTyYgMS/79FBFnuZ07+bRf2A==
X-Google-Smtp-Source: APXvYqwXbtV4U4CykIgfkPgsoEEUYYYmr76i1L1smAsmZgLvHMi2zqQeELl0BXguQuKMh2mmZqL2wyF59YjeDw6UPPQ=
X-Received: by 2002:a1c:7610:: with SMTP id r16mr5145006wmc.21.1556093644902;
 Wed, 24 Apr 2019 01:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <1556093512-5006-1-git-send-email-liush.damon@gmail.com>
In-Reply-To: <1556093512-5006-1-git-send-email-liush.damon@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Apr 2019 13:43:53 +0530
Message-ID: <CAAhSdy1O9LLezMxJ0zBNYRMtS69k1GmGFhMRR4PCtUd44-fbhg@mail.gmail.com>
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

On Wed, Apr 24, 2019 at 1:42 PM damon <liush.damon@gmail.com> wrote:
>
> Use the number of addresses to define the relevant macros.
>
> Signed-off-by: damon <liush.damon@gmail.com>
> ---
>  arch/riscv/include/asm/pgtable-32.h | 1 +
>  arch/riscv/include/asm/pgtable-64.h | 3 ++-
>  arch/riscv/include/asm/pgtable.h    | 8 ++++++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index d61974b7..c9c8ca8 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -17,6 +17,7 @@
>  #include <asm-generic/pgtable-nopmd.h>
>  #include <linux/const.h>
>
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

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
