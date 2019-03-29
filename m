Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1B72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfC2RPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfC2RPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:15:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37D23218A2;
        Fri, 29 Mar 2019 17:15:17 +0000 (UTC)
Date:   Fri, 29 Mar 2019 13:15:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190329131514.3e4ec93e@gandalf.local.home>
In-Reply-To: <20190329171221.GA32456@altlinux.org>
References: <20190329171221.GA32456@altlinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 20:12:21 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> of struct pt_regs.
> 
> Due to an off-by-one bug and a bug in pointer arithmetic
> syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> Likewise, syscall_set_arguments() was writing s3..s7 fields
> instead of a1..a5.

Should I add this to my series? And then rebase on top of it?

-- Steve

> 
> Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/riscv/include/asm/syscall.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index bba3da6ef157..6ea9e1804233 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -79,10 +79,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  	if (i == 0) {
>  		args[0] = regs->orig_a0;
>  		args++;
> -		i++;
>  		n--;
> +	} else {
> +		i--;
>  	}
> -	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
> +	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
>  }
>  
>  static inline void syscall_set_arguments(struct task_struct *task,
> @@ -94,10 +95,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
>          if (i == 0) {
>                  regs->orig_a0 = args[0];
>                  args++;
> -                i++;
>                  n--;
> -        }
> -	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> +	} else {
> +		i--;
> +	}
> +	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
>  }
>  
>  static inline int syscall_get_arch(void)

