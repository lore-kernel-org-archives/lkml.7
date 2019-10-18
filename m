Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FBBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E78A2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6tZs0VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409341AbfJRPy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:54:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJRPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5P2/Q5uNdWC7gPxFG0sFJVyz5bFotTHqNeNc806Tbx8=; b=E6tZs0VB5iwu/Zvl8DwieKUif
        XJKZ9+LBDZOf8rVgUxTadQFoywPH5MKT3g0FcWmAXLHi5MInDNOgK28BhdSvSXBDafev4ZiuN9geE
        JiGz+mVyd3Rp9M7Po2T/TUZ9OfMTpmi8mM44/jx5B1jBGbHppXfSWS1Xor1MVd4c8P99ycOyU0mJj
        MzcuhweeSqpTFvin1o+IGoNNw9bb1axpQwb2m4tHEnmiT0FuSpNow2WLV3cUMOOfpVbnFUZAkVzpZ
        aBbtSDN+okX29UiX26OywSv6tCruqYcLcSkmUTu0tAqvFzR+3+eutXwYJxgCBuxXzmM+Yh5rk0x+1
        iT5Roon+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLUag-0004VQ-CV; Fri, 18 Oct 2019 15:54:58 +0000
Date:   Fri, 18 Oct 2019 08:54:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] riscv: add missing prototypes
Message-ID: <20191018155458.GB25386@infradead.org>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
 <20191018080841.26712-5-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018080841.26712-5-paul.walmsley@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:08:37AM -0700, Paul Walmsley wrote:
> 
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 75576424c0f7..589e2d9fb2a6 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -12,6 +12,9 @@
>  void riscv_timer_interrupt(void);
>  void riscv_software_interrupt(void);
>  
> +asmlinkage void do_IRQ(struct pt_regs *regs);

This is another __visible candidate.

> +void __init init_IRQ(void);

This one is called by the core kernel.  Please instead lift the
extern in init/main.c to include/linux/irq.h or some other suitable
header insted of working around the issue in arch code.

> index f539149d04c2..ab56435de629 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -78,6 +78,10 @@ int riscv_of_processor_hartid(struct device_node *node);
>  
>  extern void riscv_fill_hwcap(void);
>  
> +extern const struct seq_operations cpuinfo_op;

Another generic issue, Ben Dooks has started looking into it already.

> +
> +void time_init(void);

And another one that needs to be solved globally and not worked around
in the architecture.

> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index d48d1e13973c..c851c095b674 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -101,6 +101,8 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->a0;
>  }
>  
> +void show_regs(struct pt_regs *regs);

Again, this needs to go into a common header, no arch code.

> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index a83451d73a4e..d19dd2e2e1da 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -15,6 +15,8 @@
>  struct seq_file;
>  extern unsigned long boot_cpu_hartid;
>  
> +asmlinkage void __init smp_callin(void);

One more __visible candidate.
