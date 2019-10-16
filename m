Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB259ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D12082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391312AbfJPHsr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:48:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfJPHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:48:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKe31-0007jH-2v; Wed, 16 Oct 2019 09:48:43 +0200
Date:   Wed, 16 Oct 2019 09:48:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 03/34] powerpc: Use CONFIG_PREEMPTION
Message-ID: <20191016074842.6acrlzbmgb5bx4pm@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-4-bigeasy@linutronix.de>
 <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 06:57:48 [+0200], Christophe Leroy wrote:
> 
> 
> Le 15/10/2019 à 21:17, Sebastian Andrzej Siewior a écrit :
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> > Both PREEMPT and PREEMPT_RT require the same functionality which today
> > depends on CONFIG_PREEMPT.
> > 
> > Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
> > output in __die().
> 
> powerpc doesn't select ARCH_SUPPORTS_RT, so this change is useless as
> CONFIG_PREEMPT_RT cannot be selected.

No it is not. It makes it possible for PowerPC to select it one day and
I have patches for it today. Also, if other ARCH copies code from
PowerPC it will copy the correct thing (as in distinguish between the
flavour PREEMPT and the functionality PREEMPTION).

> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 82f43535e6867..23d2f20be4f2e 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -252,14 +252,19 @@ NOKPROBE_SYMBOL(oops_end);
> >   static int __die(const char *str, struct pt_regs *regs, long err)
> >   {
> > +	const char *pr = "";
> > +
> 
> Please follow the same approach as already existing. Don't add a local var
> for that.

I would leave it to the maintainer to comment on that and decide which
one they want. My eyes find it more readable and the compiles does not
create more code.

> >   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
> > +	if (IS_ENABLED(CONFIG_PREEMPTION))
> > +		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
> > +
> 
> drop
> 
> >   	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
> 
> Add one %s
> 
> >   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
> >   	       PAGE_SIZE / 1024,
> >   	       early_radix_enabled() ? " MMU=Radix" : "",
> >   	       early_mmu_has_feature(MMU_FTR_HPTE_TABLE) ? " MMU=Hash" : "",
> > -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> 
> Replace by: 	IS_ENABLED(CONFIG_PREEMPTION) ? " PREEMPT" : ""
> 
> > +	       pr,
> 
> add something like: IS_ENABLED(CONFIG_PREEMPT_RT) ? "_RT" : ""

this on the other hand will create more code which is not strictly
required.

> >   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
> >   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
> >   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> > 
> 
> Christophe

Sebastian
