Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972F321929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHUX+BD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390909AbfISRbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AQOZjwcoqaVn82G0FfSuJ2KmD6bdtToACyqb2iajctY=; b=EHUX+BD8HLgR7ssqxL5471sNr
        bQ6Q592RJERAGuxaMnsztT96IkLDOsemKT0JGHCzQPPlzkPHcCY/vymRNRmyLDCsYnqlxPZFCAR1W
        RV2gxMvJ7+lHyMEphrd4eHtUvuvCNiAaWxU25/X03kbI2XHEhhEW8lxrLCU8xvr+XxBFaqPMZJ07K
        RK8JgHLZmJSnxDqU5gRUKSdI79N4FOLqmltBXKfznZyws1dP1bo/BI6Ade+gZVuoRxFYdx4oVdjbA
        EqBiF7uEl/ZuJTOou8x2B6UXNcd7QSQBWIkDDbnq0JjDRLXYZ+UvBu59fjDxisUc2EYxwQuiC4JOp
        9W0TVw9Aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB0HO-0002Lj-CC; Thu, 19 Sep 2019 17:31:42 +0000
Date:   Thu, 19 Sep 2019 10:31:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: resolve most warnings from sparse
Message-ID: <20190919173142.GA26224@infradead.org>
References: <alpine.DEB.2.21.9999.1909190125400.13510@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909190125400.13510@viisi.sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:26:38AM -0700, Paul Walmsley wrote:
> 
> Resolve most of the warnings emitted by sparse.  The objective here is
> to keep arch/riscv as clean as possible with regards to sparse warnings,
> and to maintain this bar for subsequent patches.

I think this patch does just way to many different things and needs
to be split up into one patch per issue / code module.

> --- /dev/null
> +++ b/arch/riscv/include/asm/entry.h

For example adding this file should be a patch on its own.  It can
also move to arch/riscv/kernel/ instead of polluting the <asm/*.h>
namespace.  That being said I'm not sure I like this and the
head.h patches.  Just adding a header for entry points used from
aseembly only seems rather pointless, I wonder if there is a way
to just shut up sparse on them.  Same for most of head.h.

> @@ -61,6 +61,9 @@
>  
>  #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
>  
> +extern pgd_t swapper_pg_dir[];
> +extern pgd_t trampoline_pg_dir[];
> +extern pgd_t early_pg_dir[];
>  extern pgd_t swapper_pg_dir[];

This seems to add a duplicate definition of swapper_pg_dir.

> +extern asmlinkage void __init smp_callin(void);

No nee for the extern.

> index 905372d7eeb8..d0d980d99019 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -58,6 +58,8 @@ struct thread_info {
>  	.addr_limit	= KERNEL_DS,		\
>  }
>  
> +extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);

This really needs to move to a header outside of arch/.  Also no need
for the extern and as-is this adds a line > 80 chars.

> +#ifdef CONFIG_PROFILING
>  /* Unsupported */
>  int setup_profiling_timer(unsigned int multiplier)
>  {
>  	return -EINVAL;
>  }
> +#endif

Yikes.  All architectures either just return 0 or -EINVAL here,
and the caller has a spurious extern for it.  Please just remove
this arch hook and add a Kconfig variable that the few architectures
currently returning 0 select insted.

> +static void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,

This adds an > 80 char line.

> -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> +static pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);

Another one.

> --- a/arch/riscv/mm/sifive_l2_cache.c
> +++ b/arch/riscv/mm/sifive_l2_cache.c
> @@ -142,7 +142,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
>  	return IRQ_HANDLED;
>  }
>  
> -int __init sifive_l2_init(void)
> +static int __init sifive_l2_init(void)
>  {
>  	struct device_node *np;
>  	struct resource res;

And this needs to be applied after this file moves to the right place
and isn't completely bogusly built into every RISC-V kernel.  Not all
the world is a SiFive..
