Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46373C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E720693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cM/NTp5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbfGPSQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:16:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43890 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbfGPSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:16:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so3565399pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSeAdagU7W3Xk/XctIsQGB1aBkM519mtSgLxURxSTvo=;
        b=cM/NTp5LNfxfvRk8rUYTWF/W5fD1/ExKHYYQMlLje6L4CfkKVq/mbEduwad2kSNvPI
         6OzAeK9VUkrlbfSoBJicw6b+0pP7YnGMXfZ6fivEOz0OsI6yLFkTA3g2JP9MdKvbkm59
         aj/yPlctOKdmquCVbSYCT4R3RbcB8S5CC70nz6MknV0v+ZiG+xuro6ktIsyh1oMVMTgD
         Y3iG9CSB1Zxyp4dhubAnad9GvCsNj/M5U3EYZvfLmNnPzwf+V1X6WzIrgnaWdPtcDXU+
         wHQmA0545aMX9Dsvf2e5QCb9gr+on5wDYSAhxm9FhAd0CbGIAWIVKNMZTviChgxl2dic
         uONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSeAdagU7W3Xk/XctIsQGB1aBkM519mtSgLxURxSTvo=;
        b=fK+SnjDYBffEkt7P79WPu/D2XjsDAPqLxZhCWPfI3DPCB9V3slOM7vCknFOqRY1Rdx
         9fRUeFB+P3yD+crzNXSmyXTKg6yhLdaBsTH/dSFiWq565VrSUHidAEzAhywCak2zCwH/
         t4DS70V47H97RA6Cl5PyfX1YgZdJEZfYF8Z/BdjeX27qJnSfpHD8/rJ85swAByKXWdPF
         qkTbyC0AKKHK7glimuYxi0V7+HHoH2CQ38Lw/uBeDeppZcNELuzymkdxNllOsgnuJ9M1
         BPHPI35b4Z3badoSksLqJhT8N07aZ7IHihjCjMDIFl2TROou6S0u1nJMzWThx7jiDeCU
         qsAQ==
X-Gm-Message-State: APjAAAVW6di1wbEDVutRIzaJLB/+DxgeJxlnoaZlgDuv+JZpb5fxJIjf
        mTt0cZcbM3r0WgCKS5kjKkKU7Gd3TUzHzMo2Sm9VBw==
X-Google-Smtp-Source: APXvYqxdDahY9o7Gz9BbN2FGiRjjIsxxIpSbCNWzGbt6agI+IBN12KYeOgsVdI4KysI5xhWEakEiUjYthAkPY1Z4KKE=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr37135682plq.223.1563300965899;
 Tue, 16 Jul 2019 11:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <1044b4ced755cc3d1d32030cfcf2064f06a9e639.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <1044b4ced755cc3d1d32030cfcf2064f06a9e639.1563150885.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 11:15:54 -0700
Message-ID: <CAKwvOdmUfAg9cP4tHV7tXC8PtcumehZ99+wqdcmkTR5a6LORrw@mail.gmail.com>
Subject: Re: [PATCH 10/22] bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On x86-64, with CONFIG_RETPOLINE=n, GCC's "global common subexpression
> elimination" optimization results in ___bpf_prog_run()'s jumptable code
> changing from this:
>
>         select_insn:
>                 jmp *jumptable(, %rax, 8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>         ALU_ADD_X:
>                 ...
>                 jmp *jumptable(, %rax, 8)
>
> to this:
>
>         select_insn:
>                 mov jumptable, %r12
>                 jmp *(%r12, %rax, 8)
>                 ...
>         ALU64_ADD_X:
>                 ...
>                 jmp *(%r12, %rax, 8)
>         ALU_ADD_X:
>                 ...
>                 jmp *(%r12, %rax, 8)
>
> The jumptable address is placed in a register once, at the beginning of
> the function.  The function execution can then go through multiple
> indirect jumps which rely on that same register value.  This has a few
> issues:
>
> 1) Objtool isn't smart enough to be able to track such a register value
>    across multiple recursive indirect jumps through the jump table.
>
> 2) With CONFIG_RETPOLINE enabled, this optimization actually results in
>    a small slowdown.  I measured a ~4.7% slowdown in the test_bpf
>    "tcpdump port 22" selftest.
>
>    This slowdown is actually predicted by the GCC manual:
>
>      Note: When compiling a program using computed gotos, a GCC
>      extension, you may get better run-time performance if you
>      disable the global common subexpression elimination pass by
>      adding -fno-gcse to the command line.
>
> So just disable the optimization for this function.
>
> Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> ---
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/compiler-gcc.h   | 2 ++
>  include/linux/compiler_types.h | 4 ++++
>  kernel/bpf/core.c              | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index e8579412ad21..d7ee4c6bad48 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -170,3 +170,5 @@
>  #else
>  #define __diag_GCC_8(s)
>  #endif
> +
> +#define __no_fgcse __attribute__((optimize("-fno-gcse")))

+ Miguel, maintainer of compiler_attributes.h
I wonder if the optimize attributes can be feature detected?
Is -fno-gcse supported all the way back to GCC 4.6?

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 095d55c3834d..599c27b56c29 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -189,6 +189,10 @@ struct ftrace_likely_data {
>  #define asm_volatile_goto(x...) asm goto(x)
>  #endif
>
> +#ifndef __no_fgcse
> +# define __no_fgcse
> +#endif
> +
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7e98f36a14e2..8191a7db2777 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1295,7 +1295,7 @@ bool bpf_opcode_in_insntable(u8 code)
>   *
>   * Decode and execute eBPF instructions.
>   */
> -static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> +static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>  {
>  #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
>  #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
