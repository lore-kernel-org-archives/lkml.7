Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A2C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD839214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NrgmzX/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfKESBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:01:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38911 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfKESBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:01:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so1614295pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OQ2sUxRTRKakBtPYk/S8WUmT3yCnF85ytB5yNnyoq6o=;
        b=NrgmzX/TspryQwSsCOZ8C24mKqj3an0i0v8R/kjSzbmAAxcRVe143F0TPH26d8/pSo
         J3fMu08Ea+OlUPMwcNZlJGmFBYtjxQHOGMxLt1kwMAkp4CJI/ldNIaPzw1/E6IjiHIrZ
         qyFfcjJt9v2xbzi66OOCuIodX8C+F+1ndNDsw1xh465NVMiVWxLmJKk8GEXolHE4GSiP
         2GVt0NWMuTOaMM47vX8TjVO6ogYYPPnfCvFso3Zoy7NNvSNRK4cqpSdWDjNbCpyW5jqA
         D5A8/py7mOENESwUELBSwcEXofwydMUynETjQFU75yvDFh8c0i57SHxtljAkotPWWFKc
         2SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OQ2sUxRTRKakBtPYk/S8WUmT3yCnF85ytB5yNnyoq6o=;
        b=r2F0BjLQwLvdiIZ5pP3bsCNXLilVENAe/XGM8XhcEz754vzltBv/gdhOEOYT97uQRD
         9zVfoPiJQUFvce+gZihdDNyVUqVCtudtFbbTvFM+JRTj81Kuz13ZZA4H78MhunZsWhGN
         Gwry27Xo7zxCsOpbk4RSPgsLpggPO/1MykGm0Jf8ovB3bSioxMdtSz+nboLGDsOMONN0
         viNHfQPietPZjkVtpO2oong4yKJF3IyBhUI4nKG6Y5W4NsG+2lcuPIWaUCfKJA6I6RBx
         e3HmiMtwRqePu5uxAXd1HhuzUWvgpsdbtpgyVnqYlEXagbjpvuYEF8FgReyWpX/hTbtW
         huzQ==
X-Gm-Message-State: APjAAAU5CYceznY8FAOlpoYyYMVrye+wflFExyI97wUBjIqO6M1nMzrR
        cS6ZgF9GoznMg9NGYO0iLPXqQg==
X-Google-Smtp-Source: APXvYqyoY9Xi1zQEjfoRsCWnqjT8HneLboOSc9h2AeSevxie1StHTNNH11eVRYn9BpFm2nuNYWff4g==
X-Received: by 2002:a65:614a:: with SMTP id o10mr20962942pgv.219.1572976871332;
        Tue, 05 Nov 2019 10:01:11 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id n8sm62516pja.30.2019.11.05.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:01:10 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:01:10 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 06/12] riscv: add support for MMIO access to the timer
 registers
In-Reply-To: <20191028121043.22934-7-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911050958020.20606@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-7-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, Thomas,

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> When running in M-mode we can't use the SBI to set the timer, and
> don't have access to the time CSR as that usually is emulated by
> M-mode.  Instead provide code that directly accesses the MMIO for
> the timer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Care to give a quick ack to the drivers/clocksource/timer-riscv.c changes?

thanks,

- Paul

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
>  	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
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
> +#define mmio_get_cycles()	readq_relaxed(riscv_time_val)
> +#else
> +#define mmio_get_cycles()	readl_relaxed(riscv_time_val)
> +#define mmio_get_cycles_hi()	readl_relaxed(((u32 *)riscv_time_val) + 1)
> +#endif
> +
>  static inline cycles_t get_cycles(void)
>  {
> -	return csr_read(CSR_TIME);
> +	if (IS_ENABLED(CONFIG_RISCV_SBI))
> +		return csr_read(CSR_TIME);
> +	return mmio_get_cycles();
>  }
>  #define get_cycles get_cycles
>  
> @@ -24,7 +37,9 @@ static inline u64 get_cycles64(void)
>  #else /* CONFIG_64BIT */
>  static inline u32 get_cycles_hi(void)
>  {
> -	return csr_read(CSR_TIMEH);
> +	if (IS_ENABLED(CONFIG_RISCV_SBI))
> +		return csr_read(CSR_TIMEH);
> +	return mmio_get_cycles_hi();
>  }
>  
>  static inline u64 get_cycles64(void)
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index d083bfb535f6..f3eb0c04401a 100644
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
> +	writeq_relaxed(val,
> +		riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id()));
> +}
> +
>  static int riscv_clock_next_event(unsigned long delta,
>  		struct clock_event_device *ce)
>  {
>  	csr_set(CSR_IE, IE_TIE);
> -	sbi_set_timer(get_cycles64() + delta);
> +	if (IS_ENABLED(CONFIG_RISCV_SBI))
> +		sbi_set_timer(get_cycles64() + delta);
> +	else
> +		mmio_set_timer(get_cycles64() + delta);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
> 


- Paul
