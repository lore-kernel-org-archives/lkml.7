Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD08C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2816E218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562185645;
	bh=90lPrn9FCOvmaMGoRmz2Ce+oqF+p+Sz/GvLhh72WwM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sFOq2NfAIRiKtzZmfWH+5HNadZlMwUsJsfx7uzqzMXNEhyz1Fchg6VLcR+qSV1Pnt
	 UXeIhdvl1Kp2xiRqth0NFKpIlNy1WpbXUn2LjE1OFS2NkNp6TZVqkA38vK50G7sUQW
	 mf4ShS62/XTLwCA9rJGeXSLe5CUkGKHP6t9uM06I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGCU1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:27:23 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DFF218BA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2019 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562185642;
        bh=90lPrn9FCOvmaMGoRmz2Ce+oqF+p+Sz/GvLhh72WwM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mB/Tx34FI8qtSy4nSC82hSafhYohmLQCmPf3uWeb9TPQGmWYQ200lA00jpIlcfn16
         w30Cf/YTFXZerZNF1CE3ickBkGXYqYpklhOAOBrj+3jMGctEfri1V+y/aqdy5XBVCU
         O79OBXS7mwNdJOE6dDFpjAUmKX4qfNJ1Ay12Tfa8=
Received: by mail-wm1-f53.google.com with SMTP id s3so3506828wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:27:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWJ8XO4VV9s0RAb6L71mdSOpAkovtm+xQB9+Qs6VgrRcaxvupx2
        ZCZW9wAMcDUIv5deLncZDaHOSVljOsRBthZafwqi/A==
X-Google-Smtp-Source: APXvYqxprk8oXGyeht1meo5mZFa2/qRdrSo5hhi/DQIMSl6vgSpNK1o584zTmfiTUO9E2JF8TNnvkuKR/H4lnh1fQ7o=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr9131647wme.76.1562185640630;
 Wed, 03 Jul 2019 13:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190703102731.236024951@infradead.org> <20190703102807.588906400@infradead.org>
In-Reply-To: <20190703102807.588906400@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Jul 2019 13:27:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
Message-ID: <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
To:     root <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:28 AM root <peterz@infradead.org> wrote:
>
> Despire the current efforts to read CR2 before tracing happens there
> still exist a number of possible holes:
>
>   idtentry page_fault             do_page_fault           has_error_code=1
>     call error_entry
>       TRACE_IRQS_OFF
>         call trace_hardirqs_off*
>           #PF // modifies CR2
>
>       CALL_enter_from_user_mode
>         __context_tracking_exit()
>           trace_user_exit(0)
>             #PF // modifies CR2
>
>     call do_page_fault
>       address = read_cr2(); /* whoopsie */
>
> And similar for i386.
>
> Fix it by pulling the CR2 read into the entry code, before any of that
> stuff gets a chance to run and ruin things.
>
> Ideally we'll clean up the entry code by moving this tracing and
> context tracking nonsense into C some day, but let's not delay fixing
> this longer.
>
> Reported-by: He Zhe <zhe.he@windriver.com>
> Reported-by: Eiichi Tsukata <devel@etsukata.com>
> Debugged-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_32.S       |   25 ++++++++++++++++++++++---
>  arch/x86/entry/entry_64.S       |   28 ++++++++++++++--------------
>  arch/x86/include/asm/kvm_para.h |    2 +-
>  arch/x86/include/asm/traps.h    |    2 +-
>  arch/x86/kernel/kvm.c           |    8 ++++----
>  arch/x86/mm/fault.c             |   28 ++++++++++------------------
>  6 files changed, 52 insertions(+), 41 deletions(-)
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1443,9 +1443,28 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vec
>
>  ENTRY(page_fault)
>         ASM_CLAC
> -       pushl   $do_page_fault
> -       ALIGN
> -       jmp common_exception
> +       pushl   $0; /* %gs's slot on the stack */
> +
> +       SAVE_ALL switch_stacks=1 skip_gs=1
> +
> +       ENCODE_FRAME_POINTER
> +       UNWIND_ESPFIX_STACK
> +
> +       /* fixup %gs */
> +       GS_TO_REG %ecx
> +       REG_TO_PTGS %ecx
> +       SET_KERNEL_GS %ecx
> +
> +       GET_CR2_INTO(%ecx)                      # might clobber %eax
> +
> +       /* fixup orig %eax */
> +       movl    PT_ORIG_EAX(%esp), %edx         # get the error code
> +       movl    $-1, PT_ORIG_EAX(%esp)          # no syscall to restart
> +
> +       TRACE_IRQS_OFF
> +       movl    %esp, %eax                      # pt_regs pointer
> +       call    do_page_fault
> +       jmp     ret_from_exception
>  END(page_fault)
>
>  common_exception:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -901,7 +901,7 @@ apicinterrupt IRQ_WORK_VECTOR                       irq_work
>   * @paranoid == 2 is special: the stub will never switch stacks.  This is for
>   * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
>   */
> -.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
> +.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
>  ENTRY(\sym)
>         UNWIND_HINT_IRET_REGS offset=\has_error_code*8
>
> @@ -937,18 +937,27 @@ ENTRY(\sym)
>
>         .if \paranoid
>         call    paranoid_entry
> +       /* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
>         .else
>         call    error_entry
>         .endif
>         UNWIND_HINT_REGS
> -       /* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
>
> -       .if \paranoid
> +       .if \read_cr2
> +       GET_CR2_INTO(%rdx);                     /* can clobber %rax */
> +       .endif
> +
>         .if \shift_ist != -1
>         TRACE_IRQS_OFF_DEBUG                    /* reload IDT in case of recursion */
>         .else
>         TRACE_IRQS_OFF
>         .endif
> +
> +       .if \paranoid == 0
> +       testb   $3, CS(%rsp)
> +       jz      .Lfrom_kernel_no_context_tracking_\@
> +       CALL_enter_from_user_mode
> +.Lfrom_kernel_no_context_tracking_\@:
>         .endif
>
>         movq    %rsp, %rdi                      /* pt_regs pointer */
> @@ -1180,10 +1189,10 @@ idtentry xenint3                do_int3                 has_error_co
>  #endif
>
>  idtentry general_protection    do_general_protection   has_error_code=1
> -idtentry page_fault            do_page_fault           has_error_code=1
> +idtentry page_fault            do_page_fault           has_error_code=1        read_cr2=1
>
>  #ifdef CONFIG_KVM_GUEST
> -idtentry async_page_fault      do_async_page_fault     has_error_code=1
> +idtentry async_page_fault      do_async_page_fault     has_error_code=1        read_cr2=1
>  #endif
>
>  #ifdef CONFIG_X86_MCE
> @@ -1338,18 +1347,9 @@ ENTRY(error_entry)
>         movq    %rax, %rsp                      /* switch stack */
>         ENCODE_FRAME_POINTER
>         pushq   %r12
> -
> -       /*
> -        * We need to tell lockdep that IRQs are off.  We can't do this until
> -        * we fix gsbase, and we should do it before enter_from_user_mode
> -        * (which can take locks).
> -        */
> -       TRACE_IRQS_OFF

This hunk looks wrong.  Am I missing some other place that handles the
case where we enter from kernel mode and IRQs were on?
