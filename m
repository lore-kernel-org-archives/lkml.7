Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B8C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FDA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfFJJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:53:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54218 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfFJJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:53:31 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so12275316ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP+U4owfQx+AxiXAq571meL0GzDGTRsnhiqrLs/D2hU=;
        b=ARGbZevxq0VLOmsQdM8PXUBDpmVT7rXJyatFJGHpRE4GKI4CJvGR4YeFxg0ePeWqLL
         1EsUcodJN7qSqVqil143kwVUevPmHgFRjaJtUY/q7edwyyGJfAmKaOHdWlEtGo6gqMzN
         J+IV6tRYpMvXr0O8HJexiJW/JJjzB/PZ35yJJtPRapqZHaxqS+icRru7cXUJj/f/QlbO
         jaWWt0Ljfaukj/q6Q1O/P2s47yqbc/rlkf69bAEaaiizB2anOJcVahs90NHyE4hrdVUn
         teLQwpiB/Nz20l/LI82UAvwUngpZ7SyPpTVG1GWhF1O3aHlSgZyyGq5xqr/PhxLdU1XA
         xwaA==
X-Gm-Message-State: APjAAAVIaQ5f9qf5ZBAWbYB0BCvPiCt1RmMLb+fDSpi8eUw3ufG8Osaa
        O5WksPfLzDaQrpZEn9pIZMfvNP+IaxOYvHDzrZ0LEw==
X-Google-Smtp-Source: APXvYqxiB6IGg45gdK2p5guuqIhLLseg3VCwZw7cBiPX4uxiDiO6qRniP/UJNrbg/+4SuYQ5kw8sqXpkJ7a5PA1Wl8Q=
X-Received: by 2002:a02:7b2d:: with SMTP id q45mr41554211jac.127.1560160410784;
 Mon, 10 Jun 2019 02:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190610073617.19767-1-kasong@redhat.com>
In-Reply-To: <20190610073617.19767-1-kasong@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 10 Jun 2019 17:53:19 +0800
Message-ID: <CACPcB9cRjPPMkC7+yToCZ_MoVw8McMcycRQ6tZT3yjD6pi4-NA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 3:37 PM Kairui Song <kasong@redhat.com> wrote:
>
> With the recent addition of RSDP parsing in decompression stage, kexec
> kernel now needs ACPI tables to be covered by the identity mapping.
> And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
> ACPI tables to the ident map"), ACPI tables memory region was added to
> the ident map.
>
> But on some machines, there is only ACPI NVS memory region, and the ACPI
> tables is located in the NVS region instead. In such case second kernel
> will still fail when trying to access ACPI tables.
>
> So, to fix the problem, add NVS memory region in the ident map as well.
>
> Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
> Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>
> Tested with my laptop and VM, on top of current tip:x86/boot.
>
>  arch/x86/kernel/machine_kexec_64.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 3c77bdf7b32a..a406602fdb3c 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -54,14 +54,26 @@ static int mem_region_callback(struct resource *res, void *arg)
>  static int
>  map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
>  {
> -       unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +       int ret;
> +       unsigned long flags;
>         struct init_pgtable_data data;
>
>         data.info = info;
>         data.level4p = level4p;
>         flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> -       return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> -                                  &data, mem_region_callback);
> +
> +       ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> +                                 &data, mem_region_callback);
> +       if (ret && ret != -EINVAL)
> +               return ret;
> +
> +       /* ACPI tables could be located in ACPI Non-volatile Storage region */
> +       ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
> +                                 &data, mem_region_callback);
> +       if (ret && ret != -EINVAL)
> +               return ret;
> +
> +       return 0;
>  }
>  #else
>  static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
> --
> 2.21.0
>

Hi, could you help test the tip branch with this applied? This should
fix all the issues, I can't find any other issues now. Thanks.


--
Best Regards,
Kairui Song
