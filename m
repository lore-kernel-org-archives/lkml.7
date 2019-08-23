Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C47C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E698C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfHWXaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:30:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfHWXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:30:15 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1J0O-0002Un-EM; Sat, 24 Aug 2019 01:30:04 +0200
Date:   Sat, 24 Aug 2019 01:30:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Mayr <me@sam.st>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
In-Reply-To: <20190728152617.7308-1-me@sam.st>
Message-ID: <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
References: <20190728152617.7308-1-me@sam.st>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian,

On Sun, 28 Jul 2019, Sebastian Mayr wrote:

sorry for the delay..

> 32-bit processes running on a 64-bit kernel are not always detected
> correctly, causing the process to crash when uretprobes are installed.
> The reason for the crash is that in_ia32_syscall() is used to determine
> the process's mode, which only works correctly when called from a
> syscall. In the case of uretprobes, however, the function is called from
> a software interrupt and always returns 'false' (on a 64-bit kernel). In

s/software interrupt/exception/

> consequence this leads to corruption of the process's return address.

Nice detective work and well written changelog!

> This can be fixed by using user_64bit_mode(), which should always be
> correct.

This wants to be:

  Fix this by using user_64bit_mode() which is always correct.

Be imperative, even if not entirely sure. You nicely put a disclaimer into
the discard section.

This also wants a Fixes tag and cc stable. Interestingly enough this should
have been detected by the rename with

  abfb9498ee13 ("x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()")

which states in the changelog:

    The is_ia32_task()/is_x32_task() function names are a big misnomer: they
    suggests that the compat-ness of a system call is a task property, which
    is not true, the compatness of a system call purely depends on how it
    was invoked through the system call layer.
    .....

and then it went and blindly renamed every call site ....

And sadly this was already mentioned here:

   8faaed1b9f50 ("uprobes/x86: Introduce sizeof_long(), cleanup adjust_ret_addr() and arch_uretprobe_hijack_return_addr()")

where the changelog says:

       TODO: is_ia32_task() is not what we actually want, TS_COMPAT does
       not necessarily mean 32bit. Fortunately syscall-like insns can't be
       probed so it actually works, but it would be better to rename and
       use is_ia32_frame().

and goes all the way back to:

    0326f5a94dde ("uprobes/core: Handle breakpoint and singlestep exceptions")

Oh well. 7 years until someone actually tried a uretprobe on a 32bit
process on a 64bit kernel....

> -static inline int sizeof_long(void)
> +static inline int sizeof_long(struct pt_regs *regs)
>  {
> -	return in_ia32_syscall() ? 4 : 8;

  This wants a comment.

> +	return user_64bit_mode(regs) ? 8 : 4;
>  }

No need to resend, I'll fix this up while applying.

Thank you very much for digging into this!

      tglx


