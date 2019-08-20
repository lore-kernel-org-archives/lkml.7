Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E39C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522522DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="VzunMJle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfHTIvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:51:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:51:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so1872291wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+zMdfxIJC6szl/s3F3QtV0vZKEEjr7EvMl1gxJ6Wko=;
        b=VzunMJleY9TwC0oBKPWz1G/teeRWt/mJNGQ8Yt6ooyD9ildZ6hLc9QhAL7zBcNN8UG
         oh/J3pynXQS3grHkDGYn3Y95nrQhenrNUzQRyawsmRS9zkCJBiiioN4uvrDxauZdGkPP
         GCBcAP1W4msKzzcI8n/V7wvKnOkSNp+yMDgyNOgHxDqanJEGAyz+Z5O9Z4Ipw3ieRlHV
         IjKmb7YMU4LdsIDki1fgr8GCSgL9+ykmI2Po/TSHNWPp3cGh09m+JZuUaIGxEaICaHED
         cxFCroQ5qHLcNRix6HfQQJtfqiHzVeMVNRzR5MoHLDVPXB6hBCK2fUEhfyW/dJPKShKm
         e+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+zMdfxIJC6szl/s3F3QtV0vZKEEjr7EvMl1gxJ6Wko=;
        b=FLgGlYHwLZSmcrp427Ce/KoqW0pzSpQfDy4JnpA12r40t1oGlq1UIfXSdb7KPT0+3j
         pox7OVLeZgQsVXYMJNqrjHakPbCF0aZFnX0BVZQQXl29C9rc5gc8BB0eOy6EgAcYnTZV
         lEH/QEak+mChw2pcHCyBSbyFFu5Y/7z12esS80F1N16TaZAQ15UMCMUDIc5a8sTHoSYM
         vdQ8lrkcN3AM977XkdcEXA3r5XOnFU47tXa7oVA8R9PditiYGhhhsYos0hp3Hah9AKVt
         xTyuNNeiBuPA8Z+eg6iEha4QGToQ/CaU60ufpK4X6p3/SJ8KSiF6wW3wR80H66ytzFyg
         +TXg==
X-Gm-Message-State: APjAAAVBY2Bl+XLxCwCqB7GLUDqJSkD/L+SWp7uN6+SHEFThjnSlgq42
        M59YdKc5U1Cp7aQwRIWa/TnT6GGClewoDXCtGZS7jg==
X-Google-Smtp-Source: APXvYqy8V5DPpUJexEYPlMqitRub8PR3y6aNCqaicw9koTGcTSjg2cVbFm0nu895bhfqr35b1qTsh1ChBfSggX68vPQ=
X-Received: by 2002:a7b:c933:: with SMTP id h19mr4236338wml.177.1566291106225;
 Tue, 20 Aug 2019 01:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190820004735.18518-1-atish.patra@wdc.com>
In-Reply-To: <20190820004735.18518-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 20 Aug 2019 14:21:34 +0530
Message-ID: <CAAhSdy3uQ=CSg4pHb_BYCEOh_MMTyLf8SW2o9SCn0UZDYwgGpg@mail.gmail.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 6:17 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> In RISC-V, tlb flush happens via SBI which is expensive.
> If the target cpumask contains a local hartid, some cost
> can be saved by issuing a local tlb flush as we do that
> in OpenSBI anyways. There is also no need of SBI call if
> cpumask is empty.
>
> Do a local flush first if current cpu is present in cpumask.
> Invoke SBI call only if target cpumask contains any cpus
> other than local cpu.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/tlbflush.h | 37 ++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index b5e64dc19b9e..3f9cd17b5402 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -8,6 +8,7 @@
>  #define _ASM_RISCV_TLBFLUSH_H
>
>  #include <linux/mm_types.h>
> +#include <linux/sched.h>
>  #include <asm/smp.h>
>
>  /*
> @@ -42,20 +43,44 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>
>  #include <asm/sbi.h>
>
> -static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
> -                                    unsigned long size)
> +static void __riscv_flush_tlb(struct cpumask *cmask, unsigned long start,
> +                             unsigned long size)
>  {
>         struct cpumask hmask;
> +       unsigned int hartid;
> +       unsigned int cpuid;
>
>         cpumask_clear(&hmask);
> +
> +       if (!cmask) {
> +               riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> +               goto issue_sfence;
> +       }
> +
> +       cpuid = get_cpu();
> +       if (cpumask_test_cpu(cpuid, cmask)) {
> +               /* Save trap cost by issuing a local tlb flush here */
> +               if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +                       local_flush_tlb_all();
> +               else if (size == PAGE_SIZE)
> +                       local_flush_tlb_page(start);
> +       }
> +       if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids)
> +               goto done;
> +
>         riscv_cpuid_to_hartid_mask(cmask, &hmask);
> +       hartid = cpuid_to_hartid_map(cpuid);
> +       cpumask_clear_cpu(hartid, &hmask);
> +
> +issue_sfence:
>         sbi_remote_sfence_vma(hmask.bits, start, size);
> +done:
> +       put_cpu();
>  }
>
> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
> -
> +#define flush_tlb_all() __riscv_flush_tlb(NULL, 0, -1)
>  #define flush_tlb_range(vma, start, end) \
> -       remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
> +       __riscv_flush_tlb(mm_cpumask((vma)->vm_mm), start, (end) - (start))
>
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>                                   unsigned long addr) {
> @@ -63,7 +88,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  }
>
>  #define flush_tlb_mm(mm)                               \
> -       remote_sfence_vma(mm_cpumask(mm), 0, -1)
> +       __riscv_flush_tlb(mm_cpumask(mm), 0, -1)
>
>  #endif /* CONFIG_SMP */
>
> --
> 2.21.0
>

I think we should move __riscv_flush_tlb() to mm/tlbflush.c because it's quite
big now.

In future, we will also have __riscv_flush_tlb_asid() which will flush TLB based
on ASID.

Regards,
Anup
