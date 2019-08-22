Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FA233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wA70pSly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbfHVUCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:02:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45752 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389234AbfHVUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:02:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so4062817plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6M0MCfExdShtaBNC5rUsoqRluAjvGaMj1xK+AyvQMYQ=;
        b=wA70pSlyGS3xgLPfhfiwGb0w/uRVfR15xemS5RDPcnl/8GpoFcuwlN0PCp/SEaEnpo
         mEHpTymSCekh6celiS+enQkRXEBgPXV7kcSj9oHk//cMuLPJulR9GY0I4d4ZXJNNsSv6
         aR5eS3Wwm3Q494wldXv44AnZt66FrkAEvjNx6FxFMGqR28hbsoQ0hDc3q3zmHbyy4pof
         rdlq2pAQOi02JdewYeXI6x6yTkCURuQydiWxtVJH5a1QK+8nHTG89xKaEuTMyvnNzdKy
         QcFZkYwm3hMOBfPsNhfI3IrpyxAZnhJpDX+SimVFZyLYJeRzJUURphgkEXFWVdao1TUM
         +W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6M0MCfExdShtaBNC5rUsoqRluAjvGaMj1xK+AyvQMYQ=;
        b=C+nedkbNkvui9H6nBJ9fCcpQbTyEDNhkR0aNt3N14xFz0K9g0cQcsUbm00pz7ggcO+
         2zsWq3uIzs0HwT3zK12llih6k25TMUm2tOUUY+53jtiuQELvrgQbO8Enf4yESPOfz1Ps
         Bb3sSNVS+GL7xw9LWUbZY6Kik9dEtGWDNGER2tj7m9epyUhFK1GRaMbA8zK9wCHME3d/
         FsUoKbcVyIljUzF62yq1loFLD77IxtylTyts4OyZSav74L4fD7irBYM4SsvVkgHRdYq2
         5kXRHgfsPBg6OQQA9PN1A0BnZCdJt408Am60fy0qRLc94kpbOk4I+enEvxpUbtLk+CWQ
         uIfQ==
X-Gm-Message-State: APjAAAXhXtgvdARiv2SMTFyX3AZDpizQuTkSCL5as/prJGjr5+kDZaPR
        zgrjMy0vwD1uq4gffuP1PstnjrzjAr9wg21GEcRT3w==
X-Google-Smtp-Source: APXvYqx3e5m9jsrDl6BgfUIB+8APB2djIY7vDgQy/jsFhzhsM2f1gsybya3+Zu7fin3SzbJZ83BqJnNE4rwu0WVhAyQ=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr569679plo.223.1566504137158;
 Thu, 22 Aug 2019 13:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=wKUhnWr4UhVvgn6NYh+=zQOpMmKG9d_zEqaKLa4_9FA@mail.gmail.com>
 <20190822183022.130790-1-nhuck@google.com>
In-Reply-To: <20190822183022.130790-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Aug 2019 13:02:05 -0700
Message-ID: <CAKwvOdn6av8bX4xUtuuKeJQdiQU+_Ty2aM8wtjP9+teU0Gt6Yg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: UNWINDER_FRAME_POINTER implementation for Clang
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>, Tri Vo <trong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:30 AM Nathan Huckleberry <nhuck@google.com> wrote:
>
> The stackframe setup when compiled with clang is different.
> Since the stack unwinder expects the gcc stackframe setup it
> fails to print backtraces. This patch adds support for the
> clang stackframe setup.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/35
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Tri Vo <trong@google.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Great, thanks for following up on the suggestions from code review.
Since this is going to go up via the arm tree, which has its own
process, please add my:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
to the commit message, then submit the patch to the maintainer's patch
tracking system:
https://www.armlinux.org.uk/developer/patches/info.php
(create a login, sign in, then visit:
https://www.armlinux.org.uk/developer/patches/add.php . I think the
correct thing is to put the first line of the commit in the summary
field, next/master as the kernel version (I applied/tested off of
-next), then the rest of the commit message body in the Patch Notes
field.  Make sure to attach the patch file.  Finally, it should appear
at https://www.armlinux.org.uk/developer/patches/section.php?section=0
I think within 24hrs).

> ---
> Changes from v2->v3
> * Fix indentation on code
> * Fix comment formatting
>
>  arch/arm/Kconfig.debug         |   2 +-
>  arch/arm/Makefile              |   5 +-
>  arch/arm/lib/Makefile          |   8 +-
>  arch/arm/lib/backtrace-clang.S | 217 +++++++++++++++++++++++++++++++++
>  4 files changed, 229 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/lib/backtrace-clang.S
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 85710e078afb..b9c674ec19e0 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -56,7 +56,7 @@ choice
>
>  config UNWINDER_FRAME_POINTER
>         bool "Frame pointer unwinder"
> -       depends on !THUMB2_KERNEL && !CC_IS_CLANG
> +       depends on !THUMB2_KERNEL
>         select ARCH_WANT_FRAME_POINTERS
>         select FRAME_POINTER
>         help
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c3624ca6c0bc..6f251c201db0 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -36,7 +36,10 @@ KBUILD_CFLAGS        += $(call cc-option,-mno-unaligned-access)
>  endif
>
>  ifeq ($(CONFIG_FRAME_POINTER),y)
> -KBUILD_CFLAGS  +=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
> +KBUILD_CFLAGS  +=-fno-omit-frame-pointer
> +ifeq ($(CONFIG_CC_IS_GCC),y)
> +KBUILD_CFLAGS += -mapcs -mno-sched-prolog
> +endif
>  endif
>
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index b25c54585048..6d2ba454f25b 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -5,7 +5,7 @@
>  # Copyright (C) 1995-2000 Russell King
>  #
>
> -lib-y          := backtrace.o changebit.o csumipv6.o csumpartial.o   \
> +lib-y          := changebit.o csumipv6.o csumpartial.o               \
>                    csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
>                    delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
>                    memmove.o memset.o setbit.o                        \
> @@ -19,6 +19,12 @@ lib-y                := backtrace.o changebit.o csumipv6.o csumpartial.o   \
>  mmu-y          := clear_user.o copy_page.o getuser.o putuser.o       \
>                    copy_from_user.o copy_to_user.o
>
> +ifdef CONFIG_CC_IS_CLANG
> +  lib-y        += backtrace-clang.o
> +else
> +  lib-y        += backtrace.o
> +endif
> +
>  # using lib_ here won't override already available weak symbols
>  obj-$(CONFIG_UACCESS_WITH_MEMCPY) += uaccess_with_memcpy.o
>
> diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
> new file mode 100644
> index 000000000000..2ff375144b55
> --- /dev/null
> +++ b/arch/arm/lib/backtrace-clang.S
> @@ -0,0 +1,217 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *  linux/arch/arm/lib/backtrace-clang.S
> + *
> + *  Copyright (C) 2019 Nathan Huckleberry
> + *
> + */
> +#include <linux/kern_levels.h>
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +               .text
> +
> +/* fp is 0 or stack frame */
> +
> +#define frame  r4
> +#define sv_fp  r5
> +#define sv_pc  r6
> +#define mask   r7
> +#define sv_lr  r8
> +
> +ENTRY(c_backtrace)
> +
> +#if !defined(CONFIG_FRAME_POINTER) || !defined(CONFIG_PRINTK)
> +               ret     lr
> +ENDPROC(c_backtrace)
> +#else
> +
> +
> +/*
> + * Clang does not store pc or sp in function prologues so we don't know exactly
> + * where the function starts.
> + *
> + * We can treat the current frame's lr as the saved pc and the preceding
> + * frame's lr as the current frame's lr, but we can't trace the most recent
> + * call.  Inserting a false stack frame allows us to reference the function
> + * called last in the stacktrace.
> + *
> + * If the call instruction was a bl we can look at the callers branch
> + * instruction to calculate the saved pc.  We can recover the pc in most cases,
> + * but in cases such as calling function pointers we cannot. In this case,
> + * default to using the lr. This will be some address in the function, but will
> + * not be the function start.
> + *
> + * Unfortunately due to the stack frame layout we can't dump r0 - r3, but these
> + * are less frequently saved.
> + *
> + * Stack frame layout:
> + *             <larger addresses>
> + *             saved lr
> + *     frame=> saved fp
> + *             optionally saved caller registers (r4 - r10)
> + *             optionally saved arguments (r0 - r3)
> + *             <top of stack frame>
> + *             <smaller addresses>
> + *
> + * Functions start with the following code sequence:
> + * corrected pc =>  stmfd sp!, {..., fp, lr}
> + *             add fp, sp, #x
> + *             stmfd sp!, {r0 - r3} (optional)
> + *
> + *
> + *
> + *
> + *
> + *
> + * The diagram below shows an example stack setup for dump_stack.
> + *
> + * The frame for c_backtrace has pointers to the code of dump_stack. This is
> + * why the frame of c_backtrace is used to for the pc calculation of
> + * dump_stack. This is why we must move back a frame to print dump_stack.
> + *
> + * The stored locals for dump_stack are in dump_stack's frame. This means that
> + * to fully print dump_stack's frame we need both the frame for dump_stack (for
> + * locals) and the frame that was called by dump_stack (for pc).
> + *
> + * To print locals we must know where the function start is. If we read the
> + * function prologue opcodes we can determine which variables are stored in the
> + * stack frame.
> + *
> + * To find the function start of dump_stack we can look at the stored LR of
> + * show_stack. It points at the instruction directly after the bl dump_stack.
> + * We can then read the offset from the bl opcode to determine where the branch
> + * takes us.  The address calculated must be the start of dump_stack.
> + *
> + * c_backtrace frame           dump_stack:
> + * {[LR]    }  ============|   ...
> + * {[FP]    }  =======|    |   bl c_backtrace
> + *                    |    |=> ...
> + * {[R4-R10]}         |
> + * {[R0-R3] }         |        show_stack:
> + * dump_stack frame   |        ...
> + * {[LR]    } =============|   bl dump_stack
> + * {[FP]    } <=======|    |=> ...
> + * {[R4-R10]}
> + * {[R0-R3] }
> + */
> +
> +               stmfd   sp!, {r4 - r9, fp, lr}  @ Save an extra register
> +                                               @ to ensure 8 byte alignment
> +               movs    frame, r0               @ if frame pointer is zero
> +               beq     no_frame                @ we have no stack frames
> +               tst     r1, #0x10               @ 26 or 32-bit mode?
> +               moveq   mask, #0xfc000003
> +               movne   mask, #0                @ mask for 32-bit
> +
> +/*
> + * Switches the current frame to be the frame for dump_stack.
> + */
> +               add     frame, sp, #24          @ switch to false frame
> +for_each_frame:        tst     frame, mask             @ Check for address exceptions
> +               bne     no_frame
> +
> +/*
> + * sv_fp is the stack frame with the locals for the current considered
> + * function.
> + *
> + * sv_pc is the saved lr frame the frame above. This is a pointer to a code
> + * address within the current considered function, but it is not the function
> + * start. This value gets updated to be the function start later if it is
> + * possible.
> + */
> +1001:          ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> +1002:          ldr     sv_fp, [frame, #0]      @ get saved fp
> +
> +               teq     sv_fp, mask             @ make sure next frame exists
> +               beq     no_frame
> +
> +/*
> + * sv_lr is the lr from the function that called the current function. This is
> + * a pointer to a code address in the current function's caller.  sv_lr-4 is
> + * the instruction used to call the current function.
> + *
> + * This sv_lr can be used to calculate the function start if the function was
> + * called using a bl instruction. If the function start can be recovered sv_pc
> + * is overwritten with the function start.
> + *
> + * If the current function was called using a function pointer we cannot
> + * recover the function start and instead continue with sv_pc as an arbitrary
> + * value within the current function. If this is the case we cannot print
> + * registers for the current function, but the stacktrace is still printed
> + * properly.
> + */
> +1003:          ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> +
> +               ldr     r0, [sv_lr, #-4]        @ get call instruction
> +               ldr     r3, .Lopcode+4
> +               and     r2, r3, r0              @ is this a bl call
> +               teq     r2, r3
> +               bne     finished_setup          @ give up if it's not
> +               and     r0, #0xffffff           @ get call offset 24-bit int
> +               lsl     r0, r0, #8              @ sign extend offset
> +               asr     r0, r0, #8
> +               ldr     sv_pc, [sv_fp, #4]      @ get lr address
> +               add     sv_pc, sv_pc, #-4       @ get call instruction address
> +               add     sv_pc, sv_pc, #8        @ take care of prefetch
> +               add     sv_pc, sv_pc, r0, lsl #2@ find function start
> +
> +finished_setup:
> +
> +               bic     sv_pc, sv_pc, mask      @ mask PC/LR for the mode
> +
> +/*
> + * Print the function (sv_pc) and where it was called from (sv_lr).
> + */
> +1004:          mov     r0, sv_pc
> +
> +               mov     r1, sv_lr
> +               mov     r2, frame
> +               bic     r1, r1, mask            @ mask PC/LR for the mode
> +               bl      dump_backtrace_entry
> +
> +/*
> + * Test if the function start is a stmfd instruction to determine which
> + * registers were stored in the function prologue.
> + *
> + * If we could not recover the sv_pc because we were called through a function
> + * pointer the comparison will fail and no registers will print. Unwinding will
> + * continue as if there had been no registers stored in this frame.
> + */
> +1005:          ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> +               ldr     r3, .Lopcode            @ instruction exists,
> +               teq     r3, r1, lsr #11
> +               ldr     r0, [frame]             @ locals are stored in
> +                                               @ the preceding frame
> +               subeq   r0, r0, #4
> +               bleq    dump_backtrace_stm      @ dump saved registers
> +
> +/*
> + * If we are out of frames or if the next frame is invalid.
> + */
> +               teq     sv_fp, #0               @ zero saved fp means
> +               beq     no_frame                @ no further frames
> +
> +               cmp     sv_fp, frame            @ next frame must be
> +               mov     frame, sv_fp            @ above the current frame
> +               bhi     for_each_frame
> +
> +1006:          adr     r0, .Lbad
> +               mov     r1, frame
> +               bl      printk
> +no_frame:      ldmfd   sp!, {r4 - r9, fp, pc}
> +ENDPROC(c_backtrace)
> +               .pushsection __ex_table,"a"
> +               .align  3
> +               .long   1001b, 1006b
> +               .long   1002b, 1006b
> +               .long   1003b, 1006b
> +               .long   1004b, 1006b
> +               .long   1005b, 1006b
> +               .popsection
> +
> +.Lbad:         .asciz  "Backtrace aborted due to bad frame pointer <%p>\n"
> +               .align
> +.Lopcode:      .word   0xe92d4800 >> 11        @ stmfd sp!, {... fp, lr}
> +               .word   0x0b000000              @ bl if these bits are set
> +
> +#endif
> --
> 2.23.0.187.g17f5b7556c-goog
>


-- 
Thanks,
~Nick Desaulniers
