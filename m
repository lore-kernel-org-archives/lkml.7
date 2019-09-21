Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C69C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6AB217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cDd0OVme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407487AbfIUKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 06:07:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38528 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407448AbfIUKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 06:07:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id m16so3849432oic.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q28F24xv9t76PXlL9UOYHP9IP5vFDqVp5ZAksX0BNbE=;
        b=cDd0OVmejdLKlV2PZdG18nFyRW7nybK9TRGsyVcX9DHGDrbm9IEv2MdU1uVeh9yNzp
         5MFj6/qy7dyMEKta/CPPGhZywidrrI8HE0IbbrOKdI55ya6N6vllOffgTWPyHXCAU4X8
         wjHbA7MDg56aMOukFF92q+UjdcsHFag1AMJueoyKLEByyXsWEYkvqoH6DNzUWzLJ4Ulu
         po8vwvnbkUaW9dWZGnOgWApEtFTyvt4eO7Xj3B5ygK7ml8Wii2GMQgVgnORczbhTh+Po
         0bi/zMiv3wf7hMIn+VD4EDJa4w9IoXsD/9UT/x46ov2BcK9OMjuMfoAjxA7M7hfafr6S
         TjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q28F24xv9t76PXlL9UOYHP9IP5vFDqVp5ZAksX0BNbE=;
        b=AFJdBC/HnKV3y9NJLpRWMl44/AxxtPrkGn7r7x+W92LZI4YR3q5uitm1AKO222oZX6
         /QaiwpRr0ztqVwNK4jvUU5JbhO0lxj1pEJWHAq0xTooSyCoxFnuijKFS1d5f/upXHWCs
         qBt+6TVJs1Sj8FpQL1ILc2fuqlaR1KsUn7ecQPnEnmH8mnmi6c1xk6qKzX/WhBtCgdJa
         Omzp8+ut6KD2NNmJ8/mGlD9p6wJsq4QlOFdLwYZMtseEMmjXy3KfF2EHh9pIcKAoMfP5
         wX3XVDNylEBZ+8SwKDbBpAbIypYH2qmLWn2cnFrJGUsRbM8A61rSCRRCncd39oQIKe7T
         Ni4Q==
X-Gm-Message-State: APjAAAXOz/R5YOo9FRf2/nkzIXtLzd/FxKuTDf1Ho+AUXg8YmVK0b2+7
        /tErE/l533O7CqTnLUQcktE2Og==
X-Google-Smtp-Source: APXvYqwoE0py97QUrvqBS/mq5xzW9rS86oL4ZbBn9QhAv61E1kyEn/zv/fXJ2qOOXGOdMY4/wXvM7A==
X-Received: by 2002:aca:540a:: with SMTP id i10mr6141687oib.108.1569060451309;
        Sat, 21 Sep 2019 03:07:31 -0700 (PDT)
Received: from localhost (184.sub-174-206-23.myvzw.com. [174.206.23.184])
        by smtp.gmail.com with ESMTPSA id 67sm1566624otj.21.2019.09.21.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 03:07:30 -0700 (PDT)
Date:   Sat, 21 Sep 2019 03:07:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: resolve most warnings from sparse
In-Reply-To: <20190919173142.GA26224@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1909210301470.2030@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1909190125400.13510@viisi.sifive.com> <20190919173142.GA26224@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, 19 Sep 2019, Christoph Hellwig wrote:

> On Thu, Sep 19, 2019 at 01:26:38AM -0700, Paul Walmsley wrote:
> > 
> > Resolve most of the warnings emitted by sparse.  The objective here is
> > to keep arch/riscv as clean as possible with regards to sparse warnings,
> > and to maintain this bar for subsequent patches.
> 
> I think this patch does just way to many different things and needs
> to be split up into one patch per issue / code module.

I agree that it's hard to review as it is, and will split it up into a few 
smaller patches.

> 
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/entry.h
> 
> For example adding this file should be a patch on its own.  It can
> also move to arch/riscv/kernel/ instead of polluting the <asm/*.h>
> namespace.  That being said I'm not sure I like this and the
> head.h patches.  Just adding a header for entry points used from
> aseembly only seems rather pointless, I wonder if there is a way
> to just shut up sparse on them.  Same for most of head.h.

If you have another suggestion, please let me know.  Adding this 
prototypes is perhaps not ideal, but I personally don't see any downside, 
aside from aesthetics.  Several other architectures have either asm/ or 
kernel/entry.h, and a few others have head.h, so it's at least in line 
with existing practice.

> 
> > @@ -61,6 +61,9 @@
> >  
> >  #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
> >  
> > +extern pgd_t swapper_pg_dir[];
> > +extern pgd_t trampoline_pg_dir[];
> > +extern pgd_t early_pg_dir[];
> >  extern pgd_t swapper_pg_dir[];
> 
> This seems to add a duplicate definition of swapper_pg_dir.
> 
> > +extern asmlinkage void __init smp_callin(void);
> 
> No nee for the extern.
> 
> > index 905372d7eeb8..d0d980d99019 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -58,6 +58,8 @@ struct thread_info {
> >  	.addr_limit	= KERNEL_DS,		\
> >  }
> >  
> > +extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
> 
> This really needs to move to a header outside of arch/.  Also no need
> for the extern and as-is this adds a line > 80 chars.
> 
> > +#ifdef CONFIG_PROFILING
> >  /* Unsupported */
> >  int setup_profiling_timer(unsigned int multiplier)
> >  {
> >  	return -EINVAL;
> >  }
> > +#endif
> 
> Yikes.  All architectures either just return 0 or -EINVAL here,
> and the caller has a spurious extern for it.  Please just remove
> this arch hook and add a Kconfig variable that the few architectures
> currently returning 0 select insted.
> 
> > +static void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> 
> This adds an > 80 char line.
> 
> > -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> > +static pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
> 
> Another one.

Thanks, will review the above issues.

> > --- a/arch/riscv/mm/sifive_l2_cache.c
> > +++ b/arch/riscv/mm/sifive_l2_cache.c
> > @@ -142,7 +142,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -int __init sifive_l2_init(void)
> > +static int __init sifive_l2_init(void)
> >  {
> >  	struct device_node *np;
> >  	struct resource res;
> 
> And this needs to be applied after this file moves to the right place
> and isn't completely bogusly built into every RISC-V kernel.  Not all
> the world is a SiFive..

Once you can get the ack from the EDAC maintainers, I'll most likely apply 
your previous patch.  In the meantime I'm planning to get the sparse fixes 
in early, since they are long overdue.


Thanks for the review,

- Paul
