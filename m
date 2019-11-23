Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8BC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCB62070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574550501;
	bh=hI60mFmeNURJlV87kKA4zetms7sVC99iKsf0b+qp8zE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tLD40hGYfQmF62XugopPpM/urBBtelfxxQGaF+B3Jz9DQmXzTLcwe/h+EmwTWgAtr
	 3qXoBuUdVZBnQRIlo8qSqC3k+fXVmEujBjs1+DbdYwAGj2eT+Nr5ptwGvqu8ijHR9S
	 YpmnV3IBKnZypK7NmE5WAsO0WpybImi5rrQHWfOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKWXH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfKWXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 18:07:58 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DEAB2070E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574550477;
        bh=hI60mFmeNURJlV87kKA4zetms7sVC99iKsf0b+qp8zE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=juPH+U2Uf8cD96sbedsh5RHGozPsz/wQTjsRnuXOiZF9Sd55S4YKWLJsmHaBMOCo/
         JCj9JwDu046Pc8JvaZr0WLvCpML6LLsTH49Rn1gjZspTdHPv7w8lSSSugW4mfY1s+O
         0/qmYe3Ki7/hujOSiIjmM7HOeLTAdUUbjG2V0IjY=
Received: by mail-wm1-f45.google.com with SMTP id b11so11316247wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 15:07:56 -0800 (PST)
X-Gm-Message-State: APjAAAUD6qyJNqLbW3RQ1V1VL8oIvjQm6pKprAD0qgHykgWdEv47QUN2
        bLLgbCNV96KhKskFPVY6kEAhkBA9ahbAzw2ZOqdmyw==
X-Google-Smtp-Source: APXvYqwpdaFnWBQuDWJd8TEpDxwmhLvEU3QFtNbAwKhcTfgSz4TA+yCtIs7PHs2P9yVpRUIMXRCbI4emay6x3MTLD/0=
X-Received: by 2002:a1c:1f8d:: with SMTP id f135mr11373714wmf.79.1574550475449;
 Sat, 23 Nov 2019 15:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
In-Reply-To: <20191115191728.87338-2-jannh@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 23 Nov 2019 15:07:43 -0800
X-Gmail-Original-Message-ID: <CALCETrVQ2NqPnED_E6Y6EsCOEJJcz8GkQhgcKHk7JVAyykq06A@mail.gmail.com>
Message-ID: <CALCETrVQ2NqPnED_E6Y6EsCOEJJcz8GkQhgcKHk7JVAyykq06A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:17 AM Jann Horn <jannh@google.com> wrote:
>
> A frequent cause of #GP exceptions are memory accesses to non-canonical
> addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> the kernel doesn't currently print the fault address for #GP.
> Luckily, we already have the necessary infrastructure for decoding X86
> instructions and computing the memory address that is being accessed;
> hook it up to the #GP handler so that we can figure out whether the #GP
> looks like it was caused by a non-canonical address, and if so, print
> that address.
>
> While it is already possible to compute the faulting address manually by
> disassembling the opcode dump and evaluating the instruction against the
> register dump, this should make it slightly easier to identify crashes
> at a glance.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>
> Notes:
>     v2:
>      - print different message for segment-related GP (Borislav)
>      - rewrite check for non-canonical address (Sean)
>      - make it clear we don't know for sure why the GP happened (Andy)
>
>  arch/x86/kernel/traps.c | 45 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c90312146da0..12d42697a18e 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -56,6 +56,8 @@
>  #include <asm/mpx.h>
>  #include <asm/vm86.h>
>  #include <asm/umip.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -509,6 +511,38 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>         do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
>  }
>
> +/*
> + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> + * address, print that address.
> + */
> +static void print_kernel_gp_address(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_X86_64
> +       u8 insn_bytes[MAX_INSN_SIZE];
> +       struct insn insn;
> +       unsigned long addr_ref;
> +
> +       if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> +               return;
> +
> +       kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
> +       insn_get_modrm(&insn);
> +       insn_get_sib(&insn);
> +       addr_ref = (unsigned long)insn_get_addr_ref(&insn, regs);
> +
> +       /* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
> +       if (addr_ref >= ~__VIRTUAL_MASK)
> +               return;
> +
> +       /* Bail out if the entire operand is in the canonical user half. */
> +       if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
> +               return;
> +
> +       pr_alert("probably dereferencing non-canonical address 0x%016lx\n",
> +                addr_ref);
> +#endif
> +}

Could you refactor this a little bit so that we end up with a helper
that does the computation?  Something like:

int probe_insn_get_memory_ref(void **addr, size_t *len, void *insn_addr);

returns 1 if there was a memory operand and fills in addr and len,
returns 0 if there was no memory operand, and returns a negative error
on error.

I think we're going to want this for #AC handling, too :)
