Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D5C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87921743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="J5PTbOEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfHJDam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 23:30:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfHJDam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:30:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so99894233wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pI294dVKjBseXZ5d+Q9IVYt0QRka2gVN/5uVW6i/NR0=;
        b=J5PTbOEBgIKGa91XI8KrCeqtVkQDuGjs7vraImHqT8kgRrlykP4s4YYx4ReuuE7kOy
         cozMiwvKqevnP2ilsTl2/bG1Q6YauFFcfgbB+0CbUJ80YGpfbVvi4xdJY7AVw+bqwmkn
         9Wt8jiZFeRxeztak/hhCM6pDlwtJXBC0Y7+nWkXJWCLmfMFPTyUtXfos1Y/hgtJvuazT
         XRijkkIvmKiTPjUeqTxL+rJZqrk3Zcny9cnMbiZ/AG/mbncKQmCL9fBHoF+33VTU0Xnz
         lJoSqwG/fwKpAJ5j4mGzGXCuRAL9z3pGVsOKHrgEaqVUMBsuUatch+aaNJGaot4P2gw+
         SD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pI294dVKjBseXZ5d+Q9IVYt0QRka2gVN/5uVW6i/NR0=;
        b=VMmuDBfivoP0h4rH4bHQDYmT5Rglw1XtOukx2ihJCkZo9ZAFslPJsBtVRO8tvChGJ1
         QUXYZSJwsogStI/58cEwU1XKoPoR7F6uxf9+dATwkftwvDsAbhaD9YQWuAJF8TzknzMo
         FbNIQQ9m6P8F/Tq4z+uDHZG2CYwOtStkMUGBnY/LvM2q33zRpLpkpXlSHszvkjDa7mEQ
         rXzeyWdA1fuTTSI5ZnHwZWLpc6std5oz9SAhshxgFK2rXxzuCI6pW4be8aNhNPxxAT3K
         R0CUodK+z3rcePdqCxMo/GBTLDJ5Cre2XCiZrrwQJM353b5saA+P7HkEoL11+vYc/7Qu
         7Ziw==
X-Gm-Message-State: APjAAAUHoRX+xRggjVLBYtRhA1LW2RlV8me8HQHXBqZCLaNek3xhCwUT
        nsrKQAD4E4pQAGlIaBr2Pj2KDPccQXg/KauQR8AcRg==
X-Google-Smtp-Source: APXvYqypoCZzcXQ8FotgjqFU5vd3tD3fOzGH1wJC5U9mOtgWpem3CLtHEq+cy2ZxQ6HRWkE7vE59MPaAjnpzgtOFChI=
X-Received: by 2002:adf:f641:: with SMTP id x1mr24936115wrp.179.1565407840017;
 Fri, 09 Aug 2019 20:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190810014309.20838-1-atish.patra@wdc.com>
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 10 Aug 2019 09:00:29 +0530
Message-ID: <CAAhSdy1bnBoOdYJHm97JyG5oiY6PuLqamedx4BnfbrhVvmv6Xw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 7:13 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> In RISC-V, tlb flush happens via SBI which is expensive.
> If the target cpumask contains a local hartid, some cost
> can be saved by issuing a local tlb flush as we do that
> in OpenSBI anyways.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/tlbflush.h | 33 +++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 687dd19735a7..b32ba4fa5888 100644
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
> @@ -46,14 +47,38 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
>                                      unsigned long size)
>  {
>         struct cpumask hmask;
> +       struct cpumask tmask;
> +       int cpuid = smp_processor_id();
>
>         cpumask_clear(&hmask);
> -       riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -       sbi_remote_sfence_vma(hmask.bits, start, size);
> +       cpumask_clear(&tmask);
> +
> +       if (cmask)
> +               cpumask_copy(&tmask, cmask);
> +       else
> +               cpumask_copy(&tmask, cpu_online_mask);

This can be further simplified.

We can totally avoid tmask, cpumask_copy(), and cpumask_clear()
by directly updating hmask.

In addition to this patch, we should also handle the case of
empty hart mask in OpenSBI.

> +
> +       if (cpumask_test_cpu(cpuid, &tmask)) {
> +               /* Save trap cost by issuing a local tlb flush here */
> +               if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +                       local_flush_tlb_all();
> +               else if (size == PAGE_SIZE)
> +                       local_flush_tlb_page(start);
> +               cpumask_clear_cpu(cpuid, &tmask);
> +       } else if (cpumask_empty(&tmask)) {
> +               /* cpumask is empty. So just do a local flush */
> +               local_flush_tlb_all();
> +               return;
> +       }
> +
> +       if (!cpumask_empty(&tmask)) {
> +               riscv_cpuid_to_hartid_mask(&tmask, &hmask);
> +               sbi_remote_sfence_vma(hmask.bits, start, size);
> +       }
>  }
>
> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
> -#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
> +#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, (addr) + PAGE_SIZE)
>  #define flush_tlb_range(vma, start, end) \
>         remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
>  #define flush_tlb_mm(mm) \
> --
> 2.21.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
