Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0DFCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CA320818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="tO/w9J5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfKEDVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 22:21:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbfKEDVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:21:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so19070579wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 19:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAiMHQsOuI6hnngn6+5CXNDYY+Zdldt5dUW/4rLN07w=;
        b=tO/w9J5+r4DEJmrnMm3ifg3uO8ptXHzrnI6zja/xK4eHep7B+AAjX+LZAEQ1b7e9Rj
         PlvGJ+8LHgZc7RzsKDGJsu7aCHWeNzVKMuyDvMLR4Csz8sXaeMsujCSW8wb3rJuflg/F
         9pSp9tz1VeQQorsBT31aOi7DdqviWdTUGL/WMGFhaAsxl34SgqSBOHO2HKSkkiK3YM69
         VWi6JT4IWGyCxOObusEIvQcwzTDC3hjaBy9TFBNkcd6cDpYp/TgMvIlUzgpYaYciLXng
         yilVpU4ig1m41sqRHfGExoZJIjzSk3RZYQoD8E1+kY732qewJ8ntGf2ZX/lefqpCGiDi
         E8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAiMHQsOuI6hnngn6+5CXNDYY+Zdldt5dUW/4rLN07w=;
        b=D2wy2/llfPOvbBmdb2K4uV7uGyQefmXFs9wqVchK5aeIWTQZcaiZ+OVlerqHEnU+m3
         r4exU6UPB7NHDdwRl8yfpVM2vXx3+I+d9RCxrQOdpLRjStg1Z4TUJrHeF1PPGmlVU8T4
         jXp2GpbPKklZwtQ06mCb7mlg/dcXPBmtcHviYMD7XaV9jeRrXpc04WZNp5vV3A97cppo
         CPTFZoo2U9sTZlQZcHnri11oR0XXvOqC5eRB7ZpJo8IL6I+x7K5xOdhs6gVDJ6C57CUA
         wLZAamp3a5VOCO626EEwJnKy0n4YwJz0S/9lVdb7vkQZfFgxux6Xqqi5/t36T8p8H+zy
         PfDw==
X-Gm-Message-State: APjAAAXXoef/hyWqDzMdY6ZtQWrckNNHPDBlTGJqzgVmd5tQHP9LacRV
        EuqsVDgSqpctFW9ySN9VpEfpF3kJFu6KQ3oxnOBpkWTw
X-Google-Smtp-Source: APXvYqz8SNF/4Hb4TkDt7a0lWTBr/B5XYCNv1Hg9vWdWC5a3G9WlPoJUaOOfv0Mhu8kB+wQtLGzerp13KfwzRHQAvps=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1833021wmf.24.1572924100474;
 Mon, 04 Nov 2019 19:21:40 -0800 (PST)
MIME-Version: 1.0
References: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
In-Reply-To: <1572920412-15661-1-git-send-email-zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 5 Nov 2019 08:51:29 +0530
Message-ID: <CAAhSdy2FkTqbYzP9naeUeOR+pW5-GphCR118D63Oy5C8UyQwhA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
To:     Zong Li <zong.li@sifive.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 7:50 AM Zong Li <zong.li@sifive.com> wrote:
>
> The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
> defined.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 573463d..642b330 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -273,7 +273,6 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>  #define get_pgd_next_virt(__pa)        get_pmd_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)     \
>         create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
> -#define PTE_PARENT_SIZE                PMD_SIZE
>  #define fixmap_pgd_next                fixmap_pmd
>  #else
>  #define pgd_next_t             pte_t
> @@ -281,7 +280,6 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>  #define get_pgd_next_virt(__pa)        get_pte_virt(__pa)
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)     \
>         create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
> -#define PTE_PARENT_SIZE                PGDIR_SIZE
>  #define fixmap_pgd_next                fixmap_pte
>  #endif
>
> @@ -316,10 +314,10 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>  {
>         uintptr_t map_size = PAGE_SIZE;
>
> -       /* Upgrade to PMD/PGDIR mappings whenever possible */
> -       if (!(base & (PTE_PARENT_SIZE - 1)) &&
> -           !(size & (PTE_PARENT_SIZE - 1)))
> -               map_size = PTE_PARENT_SIZE;
> +       /* Upgrade to PMD_SIZE mappings whenever possible */
> +       if (!(base & (PMD_SIZE - 1)) &&
> +           !(size & (PMD_SIZE - 1)))
> +               map_size = PMD_SIZE;
>
>         return map_size;
>  }
> --
> 2.7.4
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
