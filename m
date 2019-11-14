Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC662C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC9220748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573754453;
	bh=OrDHpYW8CPkJTzqzEitqU/kQKjnkCFdHpJIw1KXWBHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0LSW0hCizZ4AeJ7chho4t17UDFasqPdfEMOe53j26jS25jKMi5V10r7ZSlMTpcVK7
	 5US8jLU53zycVmyIcAyTdn/Wqwne5+wwkHtY3mtp+M9aM5DJrHuAmRTFyp5mY8uUYK
	 r6CIrEllTpse1LI/hm0C3XsD/Re7a0t8Tw+DDNko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKNSAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfKNSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:00:51 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C03920740
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573754449;
        bh=OrDHpYW8CPkJTzqzEitqU/kQKjnkCFdHpJIw1KXWBHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ax+5fcJFX6sDWkTcXpbVSl8tH2Mr1j9e/Evf2yQ1uCk+/4y3mO1x25mzw28KC6uTr
         E2YVK+dqMZz+JDttM44XH/q1NT0t2sxzuJxW0Zi7RGBwIvp+b6vgKk/NZ39Fl/EJwV
         XZLq8i5T82Wu4DmdTCruU0l47Ya7bTgTlsh2VdWk=
Received: by mail-wr1-f50.google.com with SMTP id z10so7493911wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:00:49 -0800 (PST)
X-Gm-Message-State: APjAAAW/JbOeinzZfijJRDv3Y7QF+8tIbqnA3jxqTrU2ovq1Fx4sP7yb
        3G1H013vyXpFFO1y1FJm7noweTL0zJgKPmiAtIggxg==
X-Google-Smtp-Source: APXvYqwvxWKtAO05IGaOJwLPT40OSpxrM7xjfVevDP3iP9s+WqBZJHu9cdqk2ze40GmwUROHa4B6/6dZKMITnacdYnU=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr9138534wru.195.1573754446679;
 Thu, 14 Nov 2019 10:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com>
In-Reply-To: <20191114174630.GF24045@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 Nov 2019 10:00:35 -0800
X-Gmail-Original-Message-ID: <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
Message-ID: <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 9:46 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Nov 12, 2019 at 10:10:01PM +0100, Jann Horn wrote:
> > A frequent cause of #GP exceptions are memory accesses to non-canonical
> > addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> > the kernel doesn't currently print the fault address for #GP.
> > Luckily, we already have the necessary infrastructure for decoding X86
> > instructions and computing the memory address that is being accessed;
> > hook it up to the #GP handler so that we can figure out whether the #GP
> > looks like it was caused by a non-canonical address, and if so, print
> > that address.
> >
> > While it is already possible to compute the faulting address manually by
> > disassembling the opcode dump and evaluating the instruction against the
> > register dump, this should make it slightly easier to identify crashes
> > at a glance.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/kernel/traps.c | 45 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index c90312146da0..479cfc6e9507 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -56,6 +56,8 @@
> >  #include <asm/mpx.h>
> >  #include <asm/vm86.h>
> >  #include <asm/umip.h>
> > +#include <asm/insn.h>
> > +#include <asm/insn-eval.h>
> >
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -509,6 +511,42 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> >       do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
> >  }
> >
> > +/*
> > + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> > + * address, print that address.
> > + */
> > +static void print_kernel_gp_address(struct pt_regs *regs)
> > +{
> > +#ifdef CONFIG_X86_64
> > +     u8 insn_bytes[MAX_INSN_SIZE];
> > +     struct insn insn;
> > +     unsigned long addr_ref;
> > +
> > +     if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> > +             return;
> > +
> > +     kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> > +     insn_get_modrm(&insn);
> > +     insn_get_sib(&insn);
> > +     addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
> > +
> > +     /*
> > +      * If insn_get_addr_ref() failed or we got a canonical address in the
> > +      * kernel half, bail out.
> > +      */
> > +     if ((addr_ref | __VIRTUAL_MASK) == ~0UL)
> > +             return;
> > +     /*
> > +      * For the user half, check against TASK_SIZE_MAX; this way, if the
> > +      * access crosses the canonical address boundary, we don't miss it.
> > +      */
> > +     if (addr_ref <= TASK_SIZE_MAX)
>
> Any objection to open coding the upper bound instead of using
> TASK_SIZE_MASK to make the threshold more obvious?
>
> > +             return;
> > +
> > +     pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
>
> Printing the raw address will confuse users in the case where the access
> straddles the lower canonical boundary.  Maybe combine this with open
> coding the straddle case?  With a rough heuristic to hedge a bit for
> instructions whose operand size isn't accurately reflected in opnd_bytes.
>
>         if (addr_ref > __VIRTUAL_MASK)
>                 pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
>         else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
>                 pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
>                          addr_ref, addr_ref + insn->opnd_bytes - 1);
>         else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
>                 pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
>                          addr_ref, addr_ref + PAGE_SIZE - 1);

This is unnecessarily complicated, and I suspect that Jann had the
right idea but just didn't quite explain it enough.  The secret here
is that TASK_SIZE_MAX is a full page below the canonical boundary
(thanks, Intel, for screwing up SYSRET), so, if we get #GP for an
address above TASK_SIZE_MAX, then it's either a #GP for a different
reason or it's a genuine non-canonical access.

So I think that just a comment about this would be enough.

*However*, the printout should at least hedge a bit and say something
like "probably dereferencing non-canonical address", since there are
plenty of ways to get #GP with an operand that is nominally
non-canonical but where the actual cause of #GP is different.  And I
think this code should be skipped entirely if error_code != 0.

--Andy
