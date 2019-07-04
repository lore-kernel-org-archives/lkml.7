Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9EC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C2521850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562277294;
	bh=lRjRvVHZ7EpfKqY2a/4bKH1fFBqDXgCn1dKbN8QnVkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bwOIcNxaCM1zOzhKaP24TCZZoq9nV38KYaQcyaBQifTDUbyLTbW/dnyeMnicIi6N6
	 l3PkuQ3XSY3Lp+d7vBSADoYGEdB7NBEZ+jYlrZ0Q7gkO/3bsOBU6Bl6WpFYfx4LjRu
	 GS22u4VEWTJLN3xbjJhl63+C5+UHRw1VSEXLftpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGDVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfGDVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:54:52 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD3E21850
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2019 21:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562277291;
        bh=lRjRvVHZ7EpfKqY2a/4bKH1fFBqDXgCn1dKbN8QnVkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UB8I6lgPTInGtGwuNaYws+mO2HSQ21+HLpPkeMS6/nnDL63nPnJmSCxFn7iFnlJUE
         19/jmPQpUMsB3ytg6uFK/Pz8FYpi4e5Y62gvCYWZA4b2hGqNrOuJgFU6JoDYeKmQoj
         /Nuk7yMruvO4eDQAA/gsv1w+0/znELlfcPwpxRHo=
Received: by mail-wr1-f51.google.com with SMTP id p11so2405995wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 14:54:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUgOUbDG7TRDhXVfTKXsjxzxFkTaGC4i8YxT4/ABuJmcOljZqje
        v6vsqqW556VwNn4UDwt+Q0AijKhEld2us/vbINtdOQ==
X-Google-Smtp-Source: APXvYqzzIZAX+ThOoqWdfFnIHebWZtoIelxuWFt3ixmEGTmr/xhCyQtcjyaeVhwPPuDHJWMDduXK7TlHPb9+Dcu/4Qo=
X-Received: by 2002:adf:a143:: with SMTP id r3mr416035wrr.352.1562277290017;
 Thu, 04 Jul 2019 14:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.420328531@infradead.org>
In-Reply-To: <20190704200050.420328531@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Jul 2019 14:54:37 -0700
X-Gmail-Original-Message-ID: <CALCETrV1VV5QY_bdNPpPH9woMBox-cS4aHZJgafZtwbODp4V_Q@mail.gmail.com>
Message-ID: <CALCETrV1VV5QY_bdNPpPH9woMBox-cS4aHZJgafZtwbODp4V_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] x86/entry/64: Simplify idtentry a little
To:     Peter Zijlstra <peterz@infradead.org>
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

On Thu, Jul 4, 2019 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> There's a bunch of duplication in idtentry, namely the
> .Lfrom_usermode_switch_stack is a paranoid=0 copy of the normal flow.
>
> Make this explicit by creating a idtentry_part helper macro.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S |  100 +++++++++++++++++++++-------------------------
>  1 file changed, 47 insertions(+), 53 deletions(-)
>
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -865,6 +865,51 @@ apicinterrupt IRQ_WORK_VECTOR                      irq_work
>   */
>  #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
>
> +.macro idtentry_part do_sym, has_error_code:req, paranoid:req, shift_ist=-1, ist_offset=0
> +
> +       .if \paranoid
> +       call    paranoid_entry
> +       /* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
> +       .else
> +       call    error_entry
> +       .endif
> +       UNWIND_HINT_REGS
> +
> +       .if \paranoid
> +       .if \shift_ist != -1
> +       TRACE_IRQS_OFF_DEBUG                    /* reload IDT in case of recursion */
> +       .else
> +       TRACE_IRQS_OFF
> +       .endif
> +       .endif
> +
> +       movq    %rsp, %rdi                      /* pt_regs pointer */
> +
> +       .if \has_error_code
> +       movq    ORIG_RAX(%rsp), %rsi            /* get error code */
> +       movq    $-1, ORIG_RAX(%rsp)             /* no syscall to restart */
> +       .else
> +       xorl    %esi, %esi                      /* no error code */
> +       .endif
> +
> +       .if \shift_ist != -1
> +       subq    $\ist_offset, CPU_TSS_IST(\shift_ist)
> +       .endif
> +
> +       call    \do_sym
> +
> +       .if \shift_ist != -1
> +       addq    $\ist_offset, CPU_TSS_IST(\shift_ist)
> +       .endif
> +
> +       .if \paranoid
> +       jmp     paranoid_exit
> +       .else
> +       jmp     error_exit
> +       .endif
> +
> +.endm
> +
>  /**
>   * idtentry - Generate an IDT entry stub
>   * @sym:               Name of the generated entry point
> @@ -935,46 +980,7 @@ ENTRY(\sym)
>  .Lfrom_usermode_no_gap_\@:
>         .endif
>
> -       .if \paranoid
> -       call    paranoid_entry
> -       .else
> -       call    error_entry
> -       .endif
> -       UNWIND_HINT_REGS
> -       /* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
> -
> -       .if \paranoid
> -       .if \shift_ist != -1
> -       TRACE_IRQS_OFF_DEBUG                    /* reload IDT in case of recursion */
> -       .else
> -       TRACE_IRQS_OFF
> -       .endif
> -       .endif
> -
> -       movq    %rsp, %rdi                      /* pt_regs pointer */
> -
> -       .if \has_error_code
> -       movq    ORIG_RAX(%rsp), %rsi            /* get error code */
> -       movq    $-1, ORIG_RAX(%rsp)             /* no syscall to restart */
> -       .else
> -       xorl    %esi, %esi                      /* no error code */
> -       .endif
> -
> -       .if \shift_ist != -1
> -       subq    $\ist_offset, CPU_TSS_IST(\shift_ist)
> -       .endif
> -
> -       call    \do_sym
> -
> -       .if \shift_ist != -1
> -       addq    $\ist_offset, CPU_TSS_IST(\shift_ist)
> -       .endif
> -
> -       .if \paranoid
> -       jmp     paranoid_exit
> -       .else
> -       jmp     error_exit
> -       .endif
> +       idtentry_part \do_sym, \has_error_code, \paranoid, \shift_ist, \ist_offset
>
>         .if \paranoid == 1
>         /*
> @@ -983,21 +989,9 @@ ENTRY(\sym)
>          * run in real process context if user_mode(regs).
>          */
>  .Lfrom_usermode_switch_stack_\@:
> -       call    error_entry
> -
> -       movq    %rsp, %rdi                      /* pt_regs pointer */
> -
> -       .if \has_error_code
> -       movq    ORIG_RAX(%rsp), %rsi            /* get error code */
> -       movq    $-1, ORIG_RAX(%rsp)             /* no syscall to restart */
> -       .else
> -       xorl    %esi, %esi                      /* no error code */
> +       idtentry_part \do_sym, \has_error_code, 0

Nice!  You are adding an extra UNWIND_HINT_REGS that wasn't here
before, but I think that's fine.  However, can you pleace make it
paranoid=0 instead of just 0?  You could go all the way verbose and
say do_sym=\do_sym, etc, but that seems like overkill.

Other than that nitpick, Acked-by: Andy Lutomirski <luto@kernel.org>

--Andy
