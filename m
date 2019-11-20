Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F38C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D45224E9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCWKJcxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfKTMPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:15:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43558 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfKTMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:15:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so22253464oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrG1MrWdrTxQ+fEkYluZ+Amp57CnVbQolCFc6b0yOMw=;
        b=BCWKJcxliVFECs22XPYdzmCfq6UxJ+r0A2hwPCG3UgTsrNykDlCYRwjboF61Sqo9zp
         +PbHVMiM3o+Il5mXnT4AU67wqndSCGbFFaWWne6Gg4O7FZS9wMcJ36OLjuWxu7976ii7
         wvr6EQv0SNgr0jwbH3WIuZBUZhIU+W0p0OZvxvqtNGHL47oe3K5xS0d+dGbB1+TP2Axv
         orlljVQfXprgUb+124aL1U67hFss5nkgcuhCWAi4c1n3hIQ7jy2cYiaTOUGVXkF59A5w
         v7j+nF9ufNoSPgulO+dmQ/EqLId4xkKOpsZDhHKyG2ZzBSvtd+x3f9DO21bU6O7X/v3T
         xB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrG1MrWdrTxQ+fEkYluZ+Amp57CnVbQolCFc6b0yOMw=;
        b=FAoXWY63CbUNJBcqF2hIpYSIpjrXG19ymWkXL+1psU6FwNMLdpH07DoyrF6g1DCQwr
         yW0Vd8cNT134TroCXZzHQq3lNvhBtMb7JP4LzxM99E8cu7IVtX6lHXOA+grHNdAVKY4O
         JS3jcG+vMMcJAk1s6EF7FG3VquewNTkEqUJaVRLHgb7GPcaC73G8itA+qFldg+95tt89
         WXpVjjhcB6UlktI5VttCNW0QWS2EP0ogVfq6NctI6+D2pibmu/q72WV6UEkI9BZz+Ik3
         hmO3Ov9dF4++TPNqxiLdgJ0n0Q9uQ8gPvD2Ukh78N8ZlSndIcAdvs+l7maRS4BtoEFXq
         i46w==
X-Gm-Message-State: APjAAAWFKNYhPvchRYhksiGeeC9kWdVOT/vRJ8fInTr/iGlM029H/wm4
        Xd8isHx2V8E7NQJSDgIyum8yX95Kr1uBqZhIJTWhsQ==
X-Google-Smtp-Source: APXvYqxcPlxqj8J0oyKwlKXufQPJJz14mykqw4atAAEyEapumzz65ppRIjkCe1QaxKwYx0HcOa1j2M5szNrBXtznssg=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr2558098oib.68.1574252113967;
 Wed, 20 Nov 2019 04:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com> <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
In-Reply-To: <20191120111859.GA115930@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 13:14:47 +0100
Message-ID: <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:19 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Jann Horn <jannh@google.com> wrote:
>
> > A frequent cause of #GP exceptions are memory accesses to non-canonical
> > addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> > the kernel doesn't currently print the fault address for #GP.
> > Luckily, we already have the necessary infrastructure for decoding X86
> > instructions and computing the memory address that is being accessed;
> > hook it up to the #GP handler so that we can figure out whether the #GP
> > looks like it was caused by a non-canonical address, and if so, print
> > that address.
[...]
> > +/*
> > + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> > + * address, return that address.
> > + */
> > +static unsigned long get_kernel_gp_address(struct pt_regs *regs)
> > +{
> > +#ifdef CONFIG_X86_64
> > +     u8 insn_bytes[MAX_INSN_SIZE];
> > +     struct insn insn;
> > +     unsigned long addr_ref;
> > +
> > +     if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> > +             return 0;
> > +
> > +     kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> > +     insn_get_modrm(&insn);
> > +     insn_get_sib(&insn);
> > +     addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
>
> I had to look twice to realize that the 'insn_bytes' isn't an integer
> that shows the number of bytes in the instruction, but the instruction
> buffer itself.
>
> Could we please do s/insn_bytes/insn_buf or such?

Will change it.

> > +
> > +     /* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
> > +     if (addr_ref >= ~__VIRTUAL_MASK)
> > +             return 0;
> > +
> > +     /* Bail out if the entire operand is in the canonical user half. */
> > +     if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
> > +             return 0;
>
> BTW., it would be nice to split this logic in two: return the faulting
> address to do_general_protection(), and print it out both for
> non-canonical and canonical addresses as well -and use the canonical
> check to *additionally* print out a short note when the operand is
> non-canonical?

You mean something like this?

========================
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9b23c4bda243..16a6bdaccb51 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -516,32 +516,36 @@ dotraplinkage void do_bounds(struct pt_regs
*regs, long error_code)
  * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
  * address, return that address.
  */
-static unsigned long get_kernel_gp_address(struct pt_regs *regs)
+static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
+                                          bool *non_canonical)
 {
 #ifdef CONFIG_X86_64
        u8 insn_buf[MAX_INSN_SIZE];
        struct insn insn;
-       unsigned long addr_ref;

        if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
-               return 0;
+               return false;

        kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
        insn_get_modrm(&insn);
        insn_get_sib(&insn);
-       addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
+       *addr = (unsigned long)insn_get_addr_ref(&insn, regs);

-       /* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
-       if (addr_ref >= ~__VIRTUAL_MASK)
-               return 0;
+       if (*addr == (unsigned long)-1L)
+               return false;

-       /* Bail out if the entire operand is in the canonical user half. */
-       if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
-               return 0;
+       /*
+        * Check that:
+        *  - the address is not in the kernel half or -1 (which means the
+        *    decoder failed to decode it)
+        *  - the last byte of the address is not in the user canonical half
+        */
+       *non_canonical = *addr < ~__VIRTUAL_MASK &&
+                        *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK;

-       return addr_ref;
+       return true;
 #else
-       return 0;
+       return false;
 #endif
 }

@@ -569,8 +573,10 @@ do_general_protection(struct pt_regs *regs, long
error_code)

        tsk = current;
        if (!user_mode(regs)) {
-               unsigned long non_canonical_addr = 0;
+               bool addr_resolved = false;
+               unsigned long gp_addr;
                unsigned long flags;
+               bool non_canonical;
                int sig;

                if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
@@ -595,18 +601,19 @@ do_general_protection(struct pt_regs *regs, long
error_code)
                if (error_code)
                        snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
                else
-                       non_canonical_addr = get_kernel_gp_address(regs);
+                       addr_resolved = get_kernel_gp_address(regs, &gp_addr,
+                                                             &non_canonical);

-               if (non_canonical_addr)
+               if (addr_resolved)
                        snprintf(desc, sizeof(desc),
-                           GPFSTR " probably for non-canonical address 0x%lx",
-                           non_canonical_addr);
+                           GPFSTR " probably for %saddress 0x%lx",
+                           non_canonical ? "non-canonical " : "", gp_addr);

                flags = oops_begin();
                sig = SIGSEGV;
                __die_header(desc, regs, error_code);
-               if (non_canonical_addr)
-                       kasan_non_canonical_hook(non_canonical_addr);
+               if (addr_resolved && non_canonical)
+                       kasan_non_canonical_hook(gp_addr);
                if (__die_body(desc, regs, error_code))
                        sig = 0;
                oops_end(flags, regs, sig);
========================

I guess that could potentially be useful if a #GP is triggered by
something like an SSE alignment error? I'll add it in unless someone
else complains.

> > +#define GPFSTR "general protection fault"
> >  dotraplinkage void
>
> Please separate macro and function definitions by an additional newline.

Will change it.
