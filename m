Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E832C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F97D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHZXxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:53:36 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D9CA62E9A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 23:53:36 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id g23so24688555ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 16:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUy8IQkLWHyZcMH4PEM2ASO/7vnmsTkom2iuDIVyNsw=;
        b=HTBOrluJrX6bvkDW0h6SBOJDyEzBq7bC9nwZXx6+Rr2vX/Q77BEJ4r7LHAjKVN5cxb
         Sp4jFNy+tl7YuASc+FAIO54+g5R9E97mvYfGuLyDRQfN5jX9rzE8rm/bYUoLRBJsANc3
         u28NFVdqFXsdnSVXAjcHsTbljks5KT9RXmKR0uAXbQngW8czMQu+h9+AxqdoliBROj2d
         raHWilNIdkzOrfqD/ovMjmBMSah0qMrwvB47zhZXEOp4X6Tke4DomuAjLYn+j8ZYIBot
         bxyCXX+uRKTxkjv4/nIai5dL6B3iWNnCyQnvRtfn4zXdHxxw8aaDmyqk0eyVfH2FZcmR
         BnJQ==
X-Gm-Message-State: APjAAAXx8CEGjKLDMcMq5f6RubfqU5zL/faQ45NDapuXNYUtWb/hI9tS
        BG4k2/i36+VrINR6DL6BvdVeNu5ByRvP5CMQ+zny7iAw2TbY4i+Bds1LY047TdeOxFHY9Cd4YVQ
        lo5LqbsGPOTfwEQTc5g6MgywIyz7uaHSLeUdgJDFY
X-Received: by 2002:a05:6602:186:: with SMTP id m6mr5089809ioo.162.1566863615923;
        Mon, 26 Aug 2019 16:53:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxp65RT3kx5pWF8+TR9ZeUjiMm6hteJQtckN/2nOu85Zner4eS4Jr8EXGxOmWRWrqpOypvmyg1BQMzaKMGp+o=
X-Received: by 2002:a05:6602:186:: with SMTP id m6mr5089784ioo.162.1566863615664;
 Mon, 26 Aug 2019 16:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190826044535.9646-1-kasong@redhat.com>
In-Reply-To: <20190826044535.9646-1-kasong@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 27 Aug 2019 07:53:23 +0800
Message-ID: <CACPcB9cULwH1B6Um9TXnbgu2GuYBQ9yZ0OKKu9yMdBmhDdNp8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is active
To:     Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:46 PM Kairui Song <kasong@redhat.com> wrote:
>
> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> SWIOTLB will be enabled even if there is less than 4G of memory when SME
> is active, to support DMA of devices that not support address with the
> encrypt bit.
>
> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
>
> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> encryption") will always force SWIOTLB to be enabled when SEV is active
> in all cases.
>
> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> and this is also true for kdump kernel. As a result kdump kernel will
> run out of already scarce pre-reserved memory easily.
>
> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> is specified or any offset is used. As for the high reservation case, an
> extra low memory region will always be reserved and that is enough for
> SWIOTLB. Else if the offset format is used, user should be fully aware
> of any possible kdump kernel memory requirement and have to organize the
> memory usage carefully.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
>
> ---
> Update from V1:
> - Use mem_encrypt_active() instead of "sme_active() || sev_active()"
> - Don't reserve extra memory when ",high" or "@offset" is used, and
>   don't print redundant message.
> - Fix coding style problem
>
>  arch/x86/kernel/setup.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bbe35bf879f5..221beb10c55d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
>
>  static void __init reserve_crashkernel(void)
>  {
> -       unsigned long long crash_size, crash_base, total_mem;
> +       unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
>         bool high = false;
>         int ret;
>
> @@ -550,6 +550,15 @@ static void __init reserve_crashkernel(void)
>                 return;
>         }
>
> +       /*
> +        * When SME/SEV is active, it will always required an extra SWIOTLB
> +        * region.
> +        */
> +       if (mem_encrypt_active())
> +               mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +       else
> +               mem_enc_req = 0;
> +
>         /* 0 means: find the address automatically */
>         if (!crash_base) {
>                 /*
> @@ -563,11 +572,19 @@ static void __init reserve_crashkernel(void)
>                 if (!high)
>                         crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                 CRASH_ADDR_LOW_MAX,
> -                                               crash_size, CRASH_ALIGN);
> -               if (!crash_base)
> +                                               crash_size + mem_enc_req,
> +                                               CRASH_ALIGN);
> +               /*
> +                * For high reservation, an extra low memory for SWIOTLB will
> +                * always be reserved later, so no need to reserve extra
> +                * memory for memory encryption case here.
> +                */
> +               if (!crash_base) {
> +                       mem_enc_req = 0;
>                         crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                 CRASH_ADDR_HIGH_MAX,
>                                                 crash_size, CRASH_ALIGN);
> +               }
>                 if (!crash_base) {
>                         pr_info("crashkernel reservation failed - No suitable area found.\n");
>                         return;
> @@ -575,6 +592,7 @@ static void __init reserve_crashkernel(void)
>         } else {
>                 unsigned long long start;
>
> +               mem_enc_req = 0;
>                 start = memblock_find_in_range(crash_base,
>                                                crash_base + crash_size,
>                                                crash_size, 1 << 20);
> @@ -583,6 +601,13 @@ static void __init reserve_crashkernel(void)
>                         return;
>                 }
>         }
> +
> +       if (mem_enc_req) {
> +               pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +                       (unsigned long)(mem_enc_req >> 20));
> +               crash_size += mem_enc_req;
> +       }
> +
>         ret = memblock_reserve(crash_base, crash_size);
>         if (ret) {
>                 pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> --
> 2.21.0
>

Hi Tom, any comment about V2?

--
Best Regards,
Kairui Song
