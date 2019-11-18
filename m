Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A48C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1BE21823
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBUuJAHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKRQDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:03:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34596 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:03:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id 205so14884089qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWBQvoRHIiT9gfZg6X80o74ola6obCU5UQn5MoahYmQ=;
        b=BBUuJAHxnTaCQtYhWDHKIopedJ2DSxm7Mt8/YTZMNemc6ukptakR3HzKcQd36ecTV2
         cOy9ujm6taEr7B/sReTtX4PUqmCrwbX/qC90HOOlMGbA6o1UUDa4CZ17Fn2algZPmECL
         jasCucVi+dKW7hL2qAwDHd9+jDkbDJyHk+zmo1lVDeF33uSj3ZcqbcWmgbEgagaUMb/q
         A4yF4R6lyKCKdjYuTcP663Y8+qKXvYb0rnzZyIa6Wd+AglAH2U2sg00k93asYm7m3ZfR
         4LkqRizlPQe1Lxib4Md1Y3dsGc02n8p5HDScCVVBzMnD2GmkZT9NE1xWcNarlBASCiHb
         /nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWBQvoRHIiT9gfZg6X80o74ola6obCU5UQn5MoahYmQ=;
        b=dOdzx3V5wCVJqNJ+0s9tFJfTRthabY88FAtzXLq9MKqNOXgNNsBlibUWgeklHffKLX
         jv3s9g3YTftLf8+mT74olARVFcgnDXprYDdNypyjOyOE9daNqNr7qCusWGsaE9dUhYQ8
         Kyda4HN5kzxaVC5uCg5DEFetpjNOZaWfYAtRBIJMpgvieuptDq9llw26+5Y8BaXftlfp
         GisUTFUArethxCbLF9eV6KWmPNbF7YokaagtSsnyK6dmpdGtGSlmtwTCArKwC9HCPRqx
         RIPBYNA/UOfF9Z6hfEMd9NZPXTOZ0iQkBt3n/85Vg1EHhuqpV9wEa/ws7zAoYKqjLxYd
         H/pQ==
X-Gm-Message-State: APjAAAXuSHfCvKVSwB5Dv8GDx3TTxhXybOQZafnmIExE2QLuKLhW5BZR
        Fcnso8o/rp8PIBBSlfx8oYjq0Pd6vAuStsBmq8/Z3w==
X-Google-Smtp-Source: APXvYqw0WHxKwY779v2uerCDtIPo4MGiXIk3gFLMXy0WYO/5KLlBDECq8iK7ryZvL5IAFn4n0xNgVCv4SYnmk3Gxqro=
X-Received: by 2002:a05:620a:1127:: with SMTP id p7mr25770552qkk.250.1574092990186;
 Mon, 18 Nov 2019 08:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
In-Reply-To: <20191118142144.GC6363@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Nov 2019 17:02:58 +0100
Message-ID: <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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

On Mon, Nov 18, 2019 at 3:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 15, 2019 at 08:17:27PM +0100, Jann Horn wrote:
> >  dotraplinkage void
> >  do_general_protection(struct pt_regs *regs, long error_code)
> >  {
> > @@ -547,8 +581,15 @@ do_general_protection(struct pt_regs *regs, long error_code)
> >                       return;
> >
> >               if (notify_die(DIE_GPF, desc, regs, error_code,
> > -                            X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
> > -                     die(desc, regs, error_code);
> > +                            X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
> > +                     return;
> > +
> > +             if (error_code)
> > +                     pr_alert("GPF is segment-related (see error code)\n");
> > +             else
> > +                     print_kernel_gp_address(regs);
> > +
> > +             die(desc, regs, error_code);
>
> Right, this way, those messages appear before the main "general
> protection ..." message:
>
> [    2.434372] traps: probably dereferencing non-canonical address 0xdfff000000000001
> [    2.442492] general protection fault: 0000 [#1] PREEMPT SMP
>
> Can we glue/merge them together? Or is this going to confuse tools too much:
>
> [    2.542218] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
>
> (and that sentence could be shorter too:
>
>         "general protection fault for non-canonical address 0xdfff000000000001"
>
> looks ok to me too.)

This exact form will confuse syzkaller crash parsing for Linux kernel:
https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L1347
It expects a "general protection fault:" line for these crashes.

A graceful way to update kernel crash messages would be to add more
tests with the new format here:
https://github.com/google/syzkaller/tree/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/testdata/linux/report
Update parsing code. Roll out new version. Update all other testing
systems that detect and parse kernel crashes. Then commit kernel
changes.

An unfortunate consequence of offloading testing to third-party systems...



> Here's a dirty diff together with a reproducer ontop of yours:
>
> ---
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index bf796f8c9998..dab702ba28a6 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -515,7 +515,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>   * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
>   * address, print that address.
>   */
> -static void print_kernel_gp_address(struct pt_regs *regs)
> +static unsigned long get_kernel_gp_address(struct pt_regs *regs)
>  {
>  #ifdef CONFIG_X86_64
>         u8 insn_bytes[MAX_INSN_SIZE];
> @@ -523,7 +523,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
>         unsigned long addr_ref;
>
>         if (probe_kernel_read(insn_bytes, (void *)regs->ip, MAX_INSN_SIZE))
> -               return;
> +               return 0;
>
>         kernel_insn_init(&insn, insn_bytes, MAX_INSN_SIZE);
>         insn_get_modrm(&insn);
> @@ -532,22 +532,22 @@ static void print_kernel_gp_address(struct pt_regs *regs)
>
>         /* Bail out if insn_get_addr_ref() failed or we got a kernel address. */
>         if (addr_ref >= ~__VIRTUAL_MASK)
> -               return;
> +               return 0;
>
>         /* Bail out if the entire operand is in the canonical user half. */
>         if (addr_ref + insn.opnd_bytes - 1 <= __VIRTUAL_MASK)
> -               return;
> +               return 0;
>
> -       pr_alert("probably dereferencing non-canonical address 0x%016lx\n",
> -                addr_ref);
> +       return addr_ref;
>  #endif
>  }
>
> +#define GPFSTR "general protection fault"
>  dotraplinkage void
>  do_general_protection(struct pt_regs *regs, long error_code)
>  {
> -       const char *desc = "general protection fault";
>         struct task_struct *tsk;
> +       char desc[90];
>
>         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>         cond_local_irq_enable(regs);
> @@ -584,12 +584,18 @@ do_general_protection(struct pt_regs *regs, long error_code)
>                                X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
>                         return;
>
> -               if (error_code)
> -                       pr_alert("GPF is segment-related (see error code)\n");
> -               else
> -                       print_kernel_gp_address(regs);
> +               if (error_code) {
> +                       snprintf(desc, 90, "segment-related " GPFSTR);
> +               } else {
> +                       unsigned long addr_ref = get_kernel_gp_address(regs);
> +
> +                       if (addr_ref)
> +                               snprintf(desc, 90, GPFSTR " while derefing a non-canonical address 0x%lx", addr_ref);
> +                       else
> +                               snprintf(desc, 90, GPFSTR);
> +               }
>
> -               die(desc, regs, error_code);
> +               die((const char *)desc, regs, error_code);
>                 return;
>         }
>
> diff --git a/init/main.c b/init/main.c
> index 91f6ebb30ef0..7acc7e660be9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1124,6 +1124,9 @@ static int __ref kernel_init(void *unused)
>
>         rcu_end_inkernel_boot();
>
> +       asm volatile("mov $0xdfff000000000001, %rax\n\t"
> +                    "jmpq *%rax\n\t");
> +
>         if (ramdisk_execute_command) {
>                 ret = run_init_process(ramdisk_execute_command);
>                 if (!ret)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191118142144.GC6363%40zn.tnic.
