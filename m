Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A777C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54B82082E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLIYYQBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfESX6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 19:58:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44621 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfESX6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 19:58:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so7755091qkj.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doV3v4rh7HRUjJmLbCEHgl+MmgHA5lzEGEyVEOx1UDY=;
        b=HLIYYQBC1OSzB/VEFY3lneCtGDjIBYUYBOWMow+F6FQWpZbr05UH83MoQlJX3cvlF4
         LN1OOVQ7Cfe43RWifImVn1akors29h1C1fVZWa+Iw+C5UgIAItQgUVmgrc9nJDv+4hHq
         HCx2sicJNasbOPfqz1nAvp4HxTIwyNoTIGzcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doV3v4rh7HRUjJmLbCEHgl+MmgHA5lzEGEyVEOx1UDY=;
        b=MnmegRupndRcfuvG8GNlpmFh2UZYPerQopAFOLAhwzSjfajI9lFLXFvnTTPmmQ+zgf
         Mbsje2as1S352QanY18N8C87ymmxklJIGaQKqobR++x1A2mSLY5jkGBZp/Qz6YHstWxQ
         jvsK9xHXioJQGQ7gUZM3hGSE8l14PjKfJlsDr4E91EF0FO7jMrefSXTIkv6CPDIyZltX
         UDs/J1HVtRxgv83iYm0R2bVQgniDATBgbIqw+2ljvkuzV/uZf8198BsR0kblT/QseWTB
         cF+Dqn4tuaQzcvrgcgzykl1MiNcCvkiJq3NkBURjj7vU4Pu1qe29YWonY70nTELQi7gQ
         IH1w==
X-Gm-Message-State: APjAAAUjrnrWoKZ06Bo/F+MqmHBFp1h9PgnkLfJR1TqLjubE1cfdzfxJ
        dsqBy6c7972fbsWG5XCENMyxyU0p1d8j9QtZzOClVB47
X-Google-Smtp-Source: APXvYqz+TXeYWMr7RQzoFtrV4mkErBeVaXoHL1oYIIA6PtSpcn5DA5jnt/IgKPeQCwUwN8PmuOmcCFULHhoCEqyY5NM=
X-Received: by 2002:a37:952:: with SMTP id 79mr52690407qkj.201.1558310279581;
 Sun, 19 May 2019 16:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190519160446.320-1-hsinyi@chromium.org>
In-Reply-To: <20190519160446.320-1-hsinyi@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 20 May 2019 07:57:48 +0800
Message-ID: <CANMq1KC74peKmwdHzb83n2kyXgqarAiu1PGnPCNLYtrdYJF77A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] amr64: map FDT as RW for early_init_dt_scan()
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/amr64/arm64/ in the commit title.

On Mon, May 20, 2019 at 1:09 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some code that needs
> to modify FDT during init.

I'd give a specific example (i.e. mention the next commit that
introduces rng-seed).

> Map FDT to RW until unflatten DT.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v2->v4:
> * v3 abandoned
> * add an arg pgprot_t to fixmap_remap_fdt()
> ---
>  arch/arm64/include/asm/mmu.h | 2 +-
>  arch/arm64/kernel/setup.c    | 5 ++++-
>  arch/arm64/mm/mmu.c          | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 67ef25d037ea..4499cb00ece7 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -137,7 +137,7 @@ extern void init_mem_pgprot(void);
>  extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>                                unsigned long virt, phys_addr_t size,
>                                pgprot_t prot, bool page_mappings_only);
> -extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
> +extern void *fixmap_remap_fdt(phys_addr_t dt_phys, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
>
>  #define INIT_MM_CONTEXT(name)  \
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566405d1..064df3de1d14 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -181,7 +181,7 @@ static void __init smp_build_mpidr_hash(void)
>
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
> -       void *dt_virt = fixmap_remap_fdt(dt_phys);
> +       void *dt_virt = fixmap_remap_fdt(dt_phys, PAGE_KERNEL);
>         const char *name;
>
>         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> @@ -320,6 +320,9 @@ void __init setup_arch(char **cmdline_p)
>         /* Parse the ACPI tables for possible boot-time configuration */
>         acpi_boot_table_init();
>
> +       /* remap fdt to RO */
> +       fixmap_remap_fdt(__fdt_pointer, PAGE_KERNEL_RO);
> +
>         if (acpi_disabled)
>                 unflatten_device_tree();
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a170c6369a68..29648e86f7e5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -940,12 +940,12 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>         return dt_virt;
>  }
>
> -void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
> +void *__init fixmap_remap_fdt(phys_addr_t dt_phys, pgprot_t prot)
>  {
>         void *dt_virt;
>         int size;
>
> -       dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> +       dt_virt = __fixmap_remap_fdt(dt_phys, &size, prot);
>         if (!dt_virt)
>                 return NULL;
>
> --
> 2.20.1
>
