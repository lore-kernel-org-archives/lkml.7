Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D81CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A557D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DoA6IJxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404899AbfJRFt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:49:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfJRFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:49:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so4796083wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Be+nqHFdPq0NG3pyh4Rq7hQf+czCYg0L1pW1x7p+760=;
        b=DoA6IJxv26NmgWjkeJeBKv/mm4gBftt7CZNlftvhSbQVjLZT75mE7vzu4UmAD3XZPr
         MRZM0pDFz2HNMJySzUfEeVzKl1VbHaCSxmAkUVujCaolp5Wh+9U/Ly3OfHSQKuvrGup6
         17AV7GSnpvpJFD26BfqTFd0Vq4dAvC4GfuQJZvzcGAxuaYucrdMCrnPHINXF+JFR7V2G
         Jp5KD1aPBzQSYNWWB+1DBO3+Y51RVtciU2HDBz2oHOnZZnFnAxepA6Ai3+9sWhQ7eM+F
         DUpXaFYjmHize5NmajKvCdL3pkf0OuvGiewLyWcoSTIHUVbZdvAoBbsATT4micGZ7Tw1
         0Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Be+nqHFdPq0NG3pyh4Rq7hQf+czCYg0L1pW1x7p+760=;
        b=Bow/FAs7Hlf6kuZ1z0QnjcaA883H2r5r4C3l8Q1Eda/dWRU57ywN5R8bN54l6QPfps
         TeSwtu80BOO/HpD8evRX9Gj9WgUkPAe6bkCXYLJ2bYF5aAgcIO/5KJz8ad4ih3Q7jd3m
         Lu0qQQooaAhibCbbd55n/A0IXQ44wj54xlhFFk/zyy7/qYao2Q/bohmPRTAJCh43QheQ
         5eQGGXeT0/fBXKLJjx8HLbgnAajrfaJ6JltDL66pHREUx0PmGRoFUOypga8KuNBJKCCW
         nhIXmYqZdW7moj7URZHYy6z1WWZHD00sn8zXz4WwQN8Y+oGwv63ANiAotoyvvLAZBH/k
         TRKw==
X-Gm-Message-State: APjAAAUA5NX/sLEp14NL3wcTMhItWy7HYgnY9GYi003X408F/sw4a58Y
        +mHkUn06nLzCwreFGOyvDraJeVAQ9JRRRlNra+/qVZWVHwM=
X-Google-Smtp-Source: APXvYqwxdrfkpUCWZjtubzLxwgGss6R4bxw1aLLjLER8GLyL4IIeYeiFxknMdYUVFzcsXWuLWKN0LVPHIz/j2kKUtgc=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr5252538wml.177.1571367467638;
 Thu, 17 Oct 2019 19:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-9-hch@lst.de>
In-Reply-To: <20191017173743.5430-9-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:27:36 +0530
Message-ID: <CAAhSdy2Ln1H4hSbjSt30pZQpHRiP5G2rJffDXFDS6TbvBnM-vw@mail.gmail.com>
Subject: Re: [PATCH 08/15] riscv: add support for MMIO access to the timer registers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> When running in M-mode we can't use the SBI to set the timer, and
> don't have access to the time CSR as that usually is emulated by
> M-mode.  Instead provide code that directly accesses the MMIO for
> the timer.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/sbi.h      |  3 ++-
>  arch/riscv/include/asm/timex.h    | 19 +++++++++++++++++--
>  drivers/clocksource/timer-riscv.c | 21 +++++++++++++++++----
>  3 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0cb74eccc73f..a4774bafe033 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -95,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>         SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
>  }
>  #else /* CONFIG_RISCV_SBI */
> -/* stub to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> +/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> +void sbi_set_timer(uint64_t stime_value);
>  void sbi_remote_fence_i(const unsigned long *hart_mask);
>  #endif /* CONFIG_RISCV_SBI */
>  #endif /* _ASM_RISCV_SBI_H */
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index c7ef131b9e4c..e17837d61667 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -7,12 +7,25 @@
>  #define _ASM_RISCV_TIMEX_H
>
>  #include <asm/csr.h>
> +#include <asm/io.h>
>
>  typedef unsigned long cycles_t;
>
> +extern u64 __iomem *riscv_time_val;
> +extern u64 __iomem *riscv_time_cmp;
> +
> +#ifdef CONFIG_64BIT
> +#define mmio_get_cycles()      readq_relaxed(riscv_time_val)
> +#else
> +#define mmio_get_cycles()      readl_relaxed(riscv_time_val)
> +#define mmio_get_cycles_hi()   readl_relaxed(((u32 *)riscv_time_val) + 1)
> +#endif
> +
>  static inline cycles_t get_cycles(void)
>  {
> -       return csr_read(CSR_TIME);
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               return csr_read(CSR_TIME);
> +       return mmio_get_cycles();
>  }
>  #define get_cycles get_cycles
>
> @@ -24,7 +37,9 @@ static inline u64 get_cycles64(void)
>  #else /* CONFIG_64BIT */
>  static inline u32 get_cycles_hi(void)
>  {
> -       return csr_read(CSR_TIMEH);
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               return csr_read(CSR_TIMEH);
> +       return mmio_get_cycles_hi();
>  }
>
>  static inline u64 get_cycles64(void)
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 5d2fdc3e28a9..2b9fbc4ebe49 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -3,9 +3,9 @@
>   * Copyright (C) 2012 Regents of the University of California
>   * Copyright (C) 2017 SiFive
>   *
> - * All RISC-V systems have a timer attached to every hart.  These timers can be
> - * read from the "time" and "timeh" CSRs, and can use the SBI to setup
> - * events.
> + * All RISC-V systems have a timer attached to every hart.  These timers can
> + * either be read from the "time" and "timeh" CSRs, and can use the SBI to
> + * setup events, or directly accessed using MMIO registers.
>   */
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
> @@ -13,14 +13,27 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/sched_clock.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <asm/smp.h>
>  #include <asm/sbi.h>
>
> +u64 __iomem *riscv_time_cmp;
> +u64 __iomem *riscv_time_val;
> +
> +static inline void mmio_set_timer(u64 val)
> +{
> +       writeq_relaxed(val,
> +               riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id()));
> +}
> +
>  static int riscv_clock_next_event(unsigned long delta,
>                 struct clock_event_device *ce)
>  {
>         csr_set(CSR_XIE, XIE_XTIE);
> -       sbi_set_timer(get_cycles64() + delta);
> +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> +               sbi_set_timer(get_cycles64() + delta);
> +       else
> +               mmio_set_timer(get_cycles64() + delta);
>         return 0;
>  }
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
