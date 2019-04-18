Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EEEC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="y691J5tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfDRGNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:13:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39945 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfDRGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:13:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so1367247wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5gAVwPf4LXwi3q6cSJA3lDZFQJ3pBlHI2tkW6FRt4k=;
        b=y691J5tmvg28X5D2wpDYc0Ew89GB+xnBAqxtwmHhLhh0QF4SDBBcPOHGJdpMqPDB6j
         dxQxQs2gf6/ZRObZK3+qKtPTxOWPbvfWaJQ8SOLuFNHfI8NtrZ2RPZqU7fSf+/fMdfxM
         51IhXflHFE8fJDzFFZYTJ29sqBunJSG+Xj4Hd4dENht2fHXgvG0NkGPL6Pa1QLy73S2p
         BkYOTIbkKyfLnhshuVXnz0ea8nb5A+aY0MGGykEFauQW7Cw51yPJELe0VjZM8mV+SyiO
         1GchVq70CVrUjGKg/TqMu5FYNt7lz0Hle1i8u9S6QQOQFHv/qAopYjS4ybSYhFyAXf/u
         eGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5gAVwPf4LXwi3q6cSJA3lDZFQJ3pBlHI2tkW6FRt4k=;
        b=txqveRJ5Ais3MZBDevfgFvhoICCGeCcIYAX6Bl4OQxBeJESMw0+NtAvfukAORSxv/H
         YLYNlI26clH+v+16dcOo/q9qJvfNPncf/HlAwr5AB9CMFg0MMP2BAwcof2d0hV7ovSAS
         l+YYFobPhEJWVYRxQajx0684n0IIL0ehHWBz8o9SdiEzWmmz5MRBndiQ84HVjz3fBplw
         GJcPZYqTtQrEWCnjEQyMSswewXRhpuYNUyZ6HUR5KU0FKqBm/Q4AiSfrSfuz9AyZoxdx
         NzSGEk1P7Tc+ClAU1hlSqdF1uRQpg4WpWir1BwzcN3yHR9mTYIkTXHS0u2NTCQyO7boO
         uDEg==
X-Gm-Message-State: APjAAAUwHl1De/SMeAnOjwG4ZlB9ir1qTRy01Fdq+VRf0bbLSXej7QAg
        QmZBXmR8NCKJhWHcnMfT5bo8Qr9388qNlC0qgH+dQg==
X-Google-Smtp-Source: APXvYqwAvyA1bcQzgSrkX12V9qt+Chzj+JKaZJECqLPoel5VVl5MhfA6uwQwlxmhcdySHtVEKdsTAgzdC6VBcJJaaiA=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr1550265wmg.132.1555568018924;
 Wed, 17 Apr 2019 23:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <1555548975-7011-1-git-send-email-liush.damon@gmail.com>
In-Reply-To: <1555548975-7011-1-git-send-email-liush.damon@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 18 Apr 2019 11:43:27 +0530
Message-ID: <CAAhSdy1ra-khBQU2s14StbiojFMk4tokGqAbp-u3j51bksbjQA@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 6:26 AM damon <liush.damon@gmail.com> wrote:
>
> Use the number of addresses to define the relevant macros.
>
> Signed-off-by: damon <liush.damon@gmail.com>
> ---
>  arch/riscv/include/asm/pgtable-32.h | 2 ++
>  arch/riscv/include/asm/pgtable-64.h | 3 ++-
>  arch/riscv/include/asm/pgtable.h    | 4 ++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index d61974b7..93607f6 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -17,8 +17,10 @@
>  #include <asm-generic/pgtable-nopmd.h>
>  #include <linux/const.h>
>
> +#define MAX_USER_VA_BITS       32
>  /* Size of region mapped by a page global directory */
>  #define PGDIR_SHIFT     22
> +#define PMD_SHIFT       PGDIR_SHIFT

We don't have PMD in RV32. We have only two level page table
for RV32 so defining PMD_SHIFT is misleading and in-correct.

I suggest you drop PMD_SHIFT here instead look at below
suggestion for defining PTRS_PER_PTE  in asm/pgtable.h

>  #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
>  #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
>
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
> index 1141364..d9cb3c8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -33,9 +33,9 @@
>  #endif /* CONFIG_64BIT */
>
>  /* Number of entries in the page global directory */
> -#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> +#define PTRS_PER_PGD (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>  /* Number of entries in the page table */
> -#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
> +#define PTRS_PER_PTE   (1 << (PMD_SHIFT - PAGE_SHIFT))

Instead of defining PTRS_PER_PTD using PMD_SHIFT for both RV32
and RV64, do the following:

#ifdef __PAGETABLE_PMD_FOLDED
#define PTRS_PER_PTE   (1 << (PGDIR_SHIFT - PAGE_SHIFT))
#else
#define PTRS_PER_PTE   (1 << (PMD_SHIFT - PAGE_SHIFT))
#endif

>
>  /* Number of PGD entries that a user-mode program can use */
>  #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
> --
> 1.9.1
>

Regards,
Anup
