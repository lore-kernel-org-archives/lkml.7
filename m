Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B13C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF7024672
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576806613;
	bh=ilkLnoHo7EaGLJaUaoTKqHyZz38N26PazO3SkXo3GyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IJutcfQY5w3nbbHrAuS0Xbwc0+D7HJWne3OJhnp0Xj9Fqc8lo8IQQt5AySWmV0kha
	 sZtQ5Y3TkXcvVyBBomlFWBYPzVF6axi/CFiWYHSePRrX46GpE++0vnOumipqaw17yV
	 Ddwgzj5LR7AuJbwL4i6sMc7B4f7CpKnMylhxdE0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLTBuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfLTBuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:50:12 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8BD2467F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576806611;
        bh=ilkLnoHo7EaGLJaUaoTKqHyZz38N26PazO3SkXo3GyM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EMNBjmsJ4KtzjViKtGv8WXocxETJgyqaCSQSMhLeUoiFxNtfRU58/IEz2WBkl3f1m
         DlxLqxIambbcM0teSXlU2u3yWBojSizgIWpGRIJIUx34J5AMiPfc3JJ5iATvIwyokO
         MVmEpEcX/hl06FdObWRTALir4GNudUz0DEMdJZ3M=
Received: by mail-wr1-f48.google.com with SMTP id z7so7818949wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:50:10 -0800 (PST)
X-Gm-Message-State: APjAAAVJwfUaC/8cKM7rliH0wdGzWrgqOhbaWcijgpZMpF9weld7sTAG
        qC7dlTALidSj4pxeNz7i4ZY+wXOMG8mVWsI2Eai35w==
X-Google-Smtp-Source: APXvYqwqz1lP8dteMiGFgB803NjS2+zXu6rXOGofAhHN0J2BXqlKcx84b1BZi/xfgxKsJI3TR0quGVQhWU+JOaDiJFE=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr12764126wrs.106.1576806609240;
 Thu, 19 Dec 2019 17:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20191219115812.102620-1-brgerst@gmail.com>
In-Reply-To: <20191219115812.102620-1-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Dec 2019 17:49:58 -0800
X-Gmail-Original-Message-ID: <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
Message-ID: <CALCETrW1zE0Uufrg_UG4JNQKMy3UFxnd+XmZye2gdTV36C-yTw@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove force_iret()
To:     Brian Gerst <brgerst@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 3:58 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> force_iret() was originally intended to prevent the return to user mode with
> the SYSRET or SYSEXIT instructions, in cases where the register state could
> have been changed to be incompatible with those instructions.

It's more than that.  Before the big syscall rework, we didn't restore
the caller-saved regs.  See:

commit 21d375b6b34ff511a507de27bf316b3dde6938d9
Author: Andy Lutomirski <luto@kernel.org>
Date:   Sun Jan 28 10:38:49 2018 -0800

    x86/entry/64: Remove the SYSCALL64 fast path

So if you changed r12, for example, the change would get lost.

 The entry code
> has been significantly reworked since then, and register state is validated
> before SYSRET or SYSEXIT are used.  force_iret() no longer serves its original
> purpose and can be eliminated.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/ia32/ia32_signal.c        |  2 --
>  arch/x86/include/asm/ptrace.h      | 16 ----------------
>  arch/x86/include/asm/thread_info.h |  9 ---------
>  arch/x86/kernel/process_32.c       |  1 -
>  arch/x86/kernel/process_64.c       |  1 -
>  arch/x86/kernel/signal.c           |  2 --
>  arch/x86/kernel/vm86_32.c          |  1 -
>  7 files changed, 32 deletions(-)
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 30416d7f19d4..a3aefe9b9401 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -114,8 +114,6 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
>
>         err |= fpu__restore_sig(buf, 1);
>
> -       force_iret();
> -
>         return err;
>  }
>
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 5057a8ed100b..78897a8da01f 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -339,22 +339,6 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
>
>  #define ARCH_HAS_USER_SINGLE_STEP_REPORT
>
> -/*
> - * When hitting ptrace_stop(), we cannot return using SYSRET because
> - * that does not restore the full CPU state, only a minimal set.  The
> - * ptracer can change arbitrary register values, which is usually okay
> - * because the usual ptrace stops run off the signal delivery path which
> - * forces IRET; however, ptrace_event() stops happen in arbitrary places
> - * in the kernel and don't force IRET path.
> - *
> - * So force IRET path after a ptrace stop.
> - */
> -#define arch_ptrace_stop_needed(code, info)                            \
> -({                                                                     \
> -       force_iret();                                                   \
> -       false;                                                          \
> -})
> -
>  struct user_desc;
>  extern int do_get_thread_area(struct task_struct *p, int idx,
>                               struct user_desc __user *info);
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index d779366ce3f8..cf4327986e98 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -239,15 +239,6 @@ static inline int arch_within_stack_frames(const void * const stack,
>                            current_thread_info()->status & TS_COMPAT)
>  #endif
>
> -/*
> - * Force syscall return via IRET by making it look as if there was
> - * some work pending. IRET is our most capable (but slowest) syscall
> - * return path, which is able to restore modified SS, CS and certain
> - * EFLAGS values that other (fast) syscall return instructions
> - * are not able to restore properly.
> - */
> -#define force_iret() set_thread_flag(TIF_NOTIFY_RESUME)
> -
>  extern void arch_task_cache_init(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  extern void arch_release_task_struct(struct task_struct *tsk);
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 323499f48858..5052ced43373 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -124,7 +124,6 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
>         regs->ip                = new_ip;
>         regs->sp                = new_sp;
>         regs->flags             = X86_EFLAGS_IF;
> -       force_iret();
>  }
>  EXPORT_SYMBOL_GPL(start_thread);
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 506d66830d4d..ffd497804dbc 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -394,7 +394,6 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
>         regs->cs                = _cs;
>         regs->ss                = _ss;
>         regs->flags             = X86_EFLAGS_IF;
> -       force_iret();
>  }
>
>  void
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 8eb7193e158d..8a29573851a3 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -151,8 +151,6 @@ static int restore_sigcontext(struct pt_regs *regs,
>
>         err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
>
> -       force_iret();
> -
>         return err;
>  }
>
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index a76c12b38e92..91d55454e702 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -381,7 +381,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>                 mark_screen_rdonly(tsk->mm);
>
>         memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
> -       force_iret();
>         return regs->ax;
>  }
>
> --
> 2.23.0
>
