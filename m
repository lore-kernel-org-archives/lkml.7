Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72458208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMa5u7Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfKACmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:42:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33649 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfKACmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:42:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id t5so8779034ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PASzEIpgisfcWQDC8L4j4ToQF0VbheMgpqommbfd01k=;
        b=IMa5u7AoWjoY3hOc6/1R23WCdWnSJ75sDfC11wdE4mIpvGhrgdZk3d+y7s5qEobOqu
         ij0slq22e6xXJxcuQX0gUbMmvJWv8itNUCGtrK6pmkvA6uP1lx1aA7PZKXbZ/sxhBniz
         f+mY2ZAPZWkwIEUOY+jfXu4WypHEVWDJFVHf0jR0vmvcJ2pvDteJzDN3kCfplasV5wBg
         aAH24j8rLbzUD6d0ZMDUYDCv3E5SU0WRZMESfrDw1aydHJe/+xgH9pCEhn858YHzHfrT
         nnFNIQm16ZNyeYXVvjUDruqEL0S+8B3yMEWDo5DO3tuRPr2Z1cCOH+L535XgeU+DU0lN
         28zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PASzEIpgisfcWQDC8L4j4ToQF0VbheMgpqommbfd01k=;
        b=sEH7tnow6iMIhdFrLowRiE7WQT0wdzo2qhtPZ7H1sNqxv/4RoyZCStWzt+eFfsWEbz
         eb6PzCzipEhrET1SIiXfsh5Pz6+wVemNvJTXKXPJN8qdAeuVzAHdAC9tU9McuWXFoYaQ
         fW6XBAvasklRFPOOuOxOjaa3yoz/WtEZoU35liOWzk+UcAHySsQe4pMdgf+UfLtumoUH
         LxtQ4T5KLkjjLjUu8f6W27MNwV0xKRFSjyJ5avJJoOUgp3FIl5Xic6DsvvZ8zuUslTgK
         zuSq+hkPRwOangkG1e0IYqy7IiUoqyyn3w8tnN58aqYupBXLm2ItMJAD77eaiqqQnsrk
         TP4Q==
X-Gm-Message-State: APjAAAVtuH/8XblEQBst8MO282kAs7mnupuf7+kQoR3GtNO1Pg1Rsyma
        YXxRBgP6jdijXfx9nKsUc+te/YOJJiCGIg2Xq6E=
X-Google-Smtp-Source: APXvYqxCQJmg76DTsmub5138VbTiILnGPxk9iG6MGyvjslofZPaI43c0sAjNotk7JflRDBvVc1W+qJTYE8tOovXlJ6M=
X-Received: by 2002:a2e:814b:: with SMTP id t11mr6600766ljg.20.1572576132633;
 Thu, 31 Oct 2019 19:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <1572574830-11181-1-git-send-email-zong.li@sifive.com>
In-Reply-To: <1572574830-11181-1-git-send-email-zong.li@sifive.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Fri, 1 Nov 2019 10:42:01 +0800
Message-ID: <CA+ZOyajsnoN8KdvqFi9dvgC1s-1Zs7kE-s7-jFhYr0WHejSkQA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Use PMD_SIZE to repalce PTE_PARENT_SIZE
To:     Zong Li <zong.li@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zong.li@sifive.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=881=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The PMD_SIZE is equal to PGDIR_SIZE when __PAGETABLE_PMD_FOLDED is
> defined.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 573463d..9a9b01a 100644
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
> @@ -317,9 +315,9 @@ static uintptr_t __init best_map_size(phys_addr_t bas=
e, phys_addr_t size)
>         uintptr_t map_size =3D PAGE_SIZE;
>
>         /* Upgrade to PMD/PGDIR mappings whenever possible */

This comment should be fixed also. this patch needs the next version.

> -       if (!(base & (PTE_PARENT_SIZE - 1)) &&
> -           !(size & (PTE_PARENT_SIZE - 1)))
> -               map_size =3D PTE_PARENT_SIZE;
> +       if (!(base & (PMD_SIZE - 1)) &&
> +           !(size & (PMD_SIZE - 1)))
> +               map_size =3D PMD_SIZE;
>
>         return map_size;
>  }
> --
> 2.7.4
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
