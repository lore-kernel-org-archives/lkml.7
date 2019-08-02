Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133921726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua5jLx3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405020AbfHBR1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:27:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34584 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404771AbfHBR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:27:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so5535442qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAgJ8NtyM6KHFbQkJ8tXJFeRK1KfMV+A92hOUXvjUKw=;
        b=Ua5jLx3VmFlpfORDOllmcvV1vmWtUcYadHba+Zsc4jxnSCNlFrc8zW4NUJEGqozjU7
         4BXuEflPgBRu4UQySegLJN6k3drmlnFBxzWuGfFk5eVXYJbMuA/vLlH+ebgb0Os9qot8
         /3VGGd5qRAKZtiT9RKApCOxktxcW7S5ckTRcuIwrRU4tlrp1khzS22xm+dx3V5dA0vKQ
         PzQWZ8qIQo5Z87w/RHEn5bhCydy64rLNyeZLvG0e+VwoNWYe81sla+xo9YPYZnV6uDyM
         dEFiFAWxS2cRffb+zzSFI8+vmrGYhZ8j4QFKI+GcqE74fYfMZrZbl7ymmbx1cWbMZlP0
         BeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAgJ8NtyM6KHFbQkJ8tXJFeRK1KfMV+A92hOUXvjUKw=;
        b=BCQ868Qzs9g2rGYwDmnkTCosKFREeg2RzkF7grF0w9kgPHMFRjtD28vOWh3hA6gbje
         JbhI0C1klTr4H4ZIN7YwtBB9AAGVEta22J3p1lmQKCQpTRyucHGZJt4BVdeqCF3UCqQ3
         wn2oNmTfqJsdx7vqKjCmnR+GE0LVVlAtTzxtCRrXvMabSBr+vmjAKaBfraKx+EY6udly
         ng6nWOqQz5cCHZkurPB8uVUvCatClDenj+bDO1pulPiSYPkz13sVts8VBSxkGGlSUFdT
         H7AWatXfLO8L0hpivVP0Zo+pHhHetKvB0XHuKp/TdlxYnwrPQ8WSdK3yYawNEeksrFLg
         Hx0g==
X-Gm-Message-State: APjAAAV4EqVKvkC3N0zH9EK/JsP/NN1f47EkWvwu0iNM5NU2EcSeQ89r
        gydF7dPBeml6pfYsB+qRZDCMxrLq2ucSsStIFrjw4g==
X-Google-Smtp-Source: APXvYqyP4g5M7ZlyCKWvLsYo05LnvG0Set3TVWk5sqFm1oy5tghXCmwGHEywbUn3xge/h93pPbbOSNtE/iP7Vk7Y8HM=
X-Received: by 2002:ac8:25c2:: with SMTP id f2mr97462220qtf.164.1564766861594;
 Fri, 02 Aug 2019 10:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190801231046.105022-1-nhuck@google.com> <01222982-4206-9925-0482-639a79384451@arm.com>
In-Reply-To: <01222982-4206-9925-0482-639a79384451@arm.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Fri, 2 Aug 2019 10:27:30 -0700
Message-ID: <CAJkfWY6StuyMuKG7XdEJrqMsA_Xy02QZKp8r0K2jwSZwBCt+9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux@armlinux.org.uk,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tri Vo <trong@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're right. Would pushing an extra register be an adequate fix?

On Fri, Aug 2, 2019 at 7:24 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 02/08/2019 00:10, Nathan Huckleberry wrote:
> > The stackframe setup when compiled with clang is different.
> > Since the stack unwinder expects the gcc stackframe setup it
> > fails to print backtraces. This patch adds support for the
> > clang stackframe setup.
> >
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Tri Vo <trong@google.com>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >   arch/arm/Kconfig.debug   |   4 +-
> >   arch/arm/Makefile        |   2 +-
> >   arch/arm/lib/backtrace.S | 134 ++++++++++++++++++++++++++++++++++++---
> >   3 files changed, 128 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 85710e078afb..92fca7463e21 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -56,7 +56,7 @@ choice
> >
> >   config UNWINDER_FRAME_POINTER
> >       bool "Frame pointer unwinder"
> > -     depends on !THUMB2_KERNEL && !CC_IS_CLANG
> > +     depends on !THUMB2_KERNEL
> >       select ARCH_WANT_FRAME_POINTERS
> >       select FRAME_POINTER
> >       help
> > @@ -1872,7 +1872,7 @@ config DEBUG_UNCOMPRESS
> >         When this option is set, the selected DEBUG_LL output method
> >         will be re-used for normal decompressor output on multiplatform
> >         kernels.
> > -
> > +
> >
> >   config UNCOMPRESS_INCLUDE
> >       string
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index c3624ca6c0bc..a593d9c4e18a 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -36,7 +36,7 @@ KBUILD_CFLAGS       += $(call cc-option,-mno-unaligned-access)
> >   endif
> >
> >   ifeq ($(CONFIG_FRAME_POINTER),y)
> > -KBUILD_CFLAGS        +=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
> > +KBUILD_CFLAGS        +=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
> >   endif
> >
> >   ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
> > diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
> > index 1d5210eb4776..fd64eec9f6ae 100644
> > --- a/arch/arm/lib/backtrace.S
> > +++ b/arch/arm/lib/backtrace.S
> > @@ -14,10 +14,7 @@
> >   @ fp is 0 or stack frame
> >
> >   #define frame       r4
> > -#define sv_fp        r5
> > -#define sv_pc        r6
> >   #define mask        r7
> > -#define offset       r8
> >
> >   ENTRY(c_backtrace)
> >
> > @@ -25,7 +22,8 @@ ENTRY(c_backtrace)
> >               ret     lr
> >   ENDPROC(c_backtrace)
> >   #else
> > -             stmfd   sp!, {r4 - r8, lr}      @ Save an extra register so we have a location...
> > +             stmfd   sp!, {r4 - r8, fp, lr}  @ Save an extra register
>
> Note that the Procedure Call Standard for EABI requires that SP be
> 8-byte-aligned at a public interface. Pushing an odd number of registers
> here looks like it will make the subsequent calls to dump_backtrace_*
> and printk violate that condition.
>
> Robin.
>
> > +                                             @ so we have a location..
> >               movs    frame, r0               @ if frame pointer is zero
> >               beq     no_frame                @ we have no stack frames
> >
> > @@ -35,11 +33,119 @@ ENDPROC(c_backtrace)
> >    THUMB(             orreq   mask, #0x03             )
> >               movne   mask, #0                @ mask for 32-bit
> >
> > -1:           stmfd   sp!, {pc}               @ calculate offset of PC stored
> > -             ldr     r0, [sp], #4            @ by stmfd for this CPU
> > -             adr     r1, 1b
> > -             sub     offset, r0, r1
> >
> > +#if defined(CONFIG_CC_IS_CLANG)
> > +/*
> > + * Clang does not store pc or sp in function prologues
> > + *           so we don't know exactly where the function
> > + *           starts.
> > + * We can treat the current frame's lr as the saved pc and the
> > + *           preceding frame's lr as the lr, but we can't
> > + *           trace the most recent call.
> > + * Inserting a false stack frame allows us to reference the
> > + *           function called last in the stacktrace.
> > + * If the call instruction was a bl we can look at the callers
> > + *           branch instruction to calculate the saved pc.
> > + * We can recover the pc in most cases, but in cases such as
> > + *           calling function pointers we cannot. In this
> > + *           case, default to using the lr. This will be
> > + *           some address in the function, but will not
> > + *           be the function start.
> > + * Unfortunately due to the stack frame layout we can't dump
> > + *              r0 - r3, but these are less frequently saved.
> > + *
> > + * Stack frame layout:
> > + *             <larger addresses>
> > + *             saved lr
> > + *    frame => saved fp
> > + *             optionally saved caller registers (r4 - r10)
> > + *             optionally saved arguments (r0 - r3)
> > + *             <top of stack frame>
> > + *             <smaller addressses>
> > + *
> > + * Functions start with the following code sequence:
> > + * corrected pc =>  stmfd sp!, {..., fp, lr}
> > + *               add fp, sp, #x
> > + *               stmfd sp!, {r0 - r3} (optional)
> > + */
> > +#define sv_fp        r5
> > +#define sv_pc        r6
> > +#define sv_lr   r8
> > +             add     frame, sp, #20          @ switch to false frame
> > +for_each_frame:      tst     frame, mask             @ Check for address exceptions
> > +             bne     no_frame
> > +
> > +1001:                ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> > +1002:                ldr     sv_fp, [frame, #0]      @ get saved fp
> > +
> > +             teq     sv_fp, #0               @ make sure next frame exists
> > +             beq     no_frame
> > +
> > +1003:                ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> > +
> > +             //try to find function start
> > +             ldr     r0, [sv_lr, #-4]        @ get call instruction
> > +             ldr     r3, .Ldsi+8
> > +             and     r2, r3, r0              @ is this a bl call
> > +             teq     r2, r3
> > +             bne     finished_setup          @ give up if it's not
> > +             and     r0, #0xffffff           @ get call offset 24-bit int
> > +             lsl     r0, r0, #8              @ sign extend offset
> > +             asr     r0, r0, #8
> > +             ldr     sv_pc, [sv_fp, #4]      @ get lr address
> > +             add     sv_pc, sv_pc, #-4       @ get call instruction address
> > +             add     sv_pc, sv_pc, #8        @ take care of prefetch
> > +             add     sv_pc, sv_pc, r0, lsl #2 @ find function start
> > +             b       finished_setup
> > +
> > +finished_setup:
> > +
> > +             bic     sv_pc, sv_pc, mask      @ mask PC/LR for the mode
> > +
> > +1004:                mov     r0, sv_pc
> > +
> > +             mov     r1, sv_lr
> > +             mov     r2, frame
> > +             bic     r1, r1, mask            @ mask PC/LR for the mode
> > +             bl      dump_backtrace_entry
> > +
> > +1005:                ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> > +             ldr     r3, .Ldsi               @ instruction exists,
> > +             teq     r3, r1, lsr #11
> > +             ldr     r0, [frame]             @ locals are stored in
> > +                                             @ the preceding frame
> > +             subeq   r0, r0, #4
> > +             bleq    dump_backtrace_stm      @ dump saved registers
> > +
> > +             teq     sv_fp, #0               @ zero saved fp means
> > +             beq     no_frame                @ no further frames
> > +
> > +             cmp     sv_fp, frame            @ next frame must be
> > +             mov     frame, sv_fp            @ above the current frame
> > +             bhi     for_each_frame
> > +
> > +1006:                adr     r0, .Lbad
> > +             mov     r1, frame
> > +             bl      printk
> > +no_frame:    ldmfd   sp!, {r4 - r8, fp, pc}
> > +ENDPROC(c_backtrace)
> > +             .pushsection __ex_table,"a"
> > +             .align  3
> > +             .long   1001b, 1006b
> > +             .long   1002b, 1006b
> > +             .long   1003b, 1006b
> > +             .long   1004b, 1006b
> > +             .popsection
> > +
> > +.Lbad:               .asciz  "Backtrace aborted due to bad frame pointer <%p>\n"
> > +             .align
> > +.Ldsi:               .word   0xe92d4800 >> 11        @ stmfd sp!, {... fp, lr}
> > +             .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> > +             .word   0x0b000000              @ bl if these bits are set
> > +
> > +ENDPROC(c_backtrace)
> > +
> > +#else
> >   /*
> >    * Stack frame layout:
> >    *             optionally saved caller registers (r4 - r10)
> > @@ -55,6 +161,15 @@ ENDPROC(c_backtrace)
> >    *                  stmfd sp!, {r0 - r3} (optional)
> >    * corrected pc =>  stmfd sp!, {..., fp, ip, lr, pc}
> >    */
> > +#define sv_fp        r5
> > +#define sv_pc        r6
> > +#define offset       r8
> > +
> > +1:           stmfd   sp!, {pc}               @ calculate offset of PC stored
> > +             ldr     r0, [sp], #4            @ by stmfd for this CPU
> > +             adr     r1, 1b
> > +             sub     offset, r0, r1
> > +
> >   for_each_frame:     tst     frame, mask             @ Check for address exceptions
> >               bne     no_frame
> >
> > @@ -98,7 +213,7 @@ for_each_frame:    tst     frame, mask             @ Check for address exceptions
> >   1006:               adr     r0, .Lbad
> >               mov     r1, frame
> >               bl      printk
> > -no_frame:    ldmfd   sp!, {r4 - r8, pc}
> > +no_frame:    ldmfd   sp!, {r4 - r8, fp, pc}
> >   ENDPROC(c_backtrace)
> >
> >               .pushsection __ex_table,"a"
> > @@ -115,3 +230,4 @@ ENDPROC(c_backtrace)
> >               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> >
> >   #endif
> > +#endif
> >
