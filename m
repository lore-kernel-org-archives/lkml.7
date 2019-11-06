Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E7CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A84217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PGPKVKzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfKFJNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:13:17 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60362 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfKFJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TOdQALz0m5WieFGaUz1ns1b04RuCs9AC7LJ76ZAlU8g=; b=PGPKVKzClKmB52+NYumu5YW9W
        qaQh7cG1XxzG/gZCfo8c9ti5kC2wGTkEM0az9+JS/AXaVOkSVT9GmSCnFaC7W3cA28LorvRuwp9kz
        8lX0gcWRcunHPEjyFl0t86cTDsP5e8+KM/4p+jMf9xRp3hcUL6e++GHkF09LwV8Hyp+J8elBt8t0U
        y7LrZ5nRNjRNeX7ttzWtY9MmFEro+7gmTzbsYha4tuUExMFolPfzeN7RmvP0u+NvJN7xTWWUMmhzA
        iu5jqDK47hh3s/ozrCQCbbpTtTsxZKBuWN36bA80rgkpTc5z+xuUIlrNdF0FTifarInFQi1YQVesa
        tNbH0EjvA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:52522)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iSHNB-0003vt-DG; Wed, 06 Nov 2019 09:13:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iSHN5-0003wB-1z; Wed, 06 Nov 2019 09:12:59 +0000
Date:   Wed, 6 Nov 2019 09:12:59 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 05/50] arm: Add loglvl to unwind_backtrace()
Message-ID: <20191106091258.GS25745@shell.armlinux.org.uk>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-6-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106030542.868541-6-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:04:56AM +0000, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Add log level argument to unwind_backtrace() as a preparation for
> introducing show_stack_loglvl().
> 
> As a good side-effect arm_syscall() is now printing errors with the same
> log level as the backtrace.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: clang-built-linux@googlegroups.com
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/arm/include/asm/unwind.h | 3 ++-
>  arch/arm/kernel/traps.c       | 6 +++---
>  arch/arm/kernel/unwind.c      | 7 ++++---
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
> index 6e282c33126b..0f8a3439902d 100644
> --- a/arch/arm/include/asm/unwind.h
> +++ b/arch/arm/include/asm/unwind.h
> @@ -36,7 +36,8 @@ extern struct unwind_table *unwind_table_add(unsigned long start,
>  					     unsigned long text_addr,
>  					     unsigned long text_size);
>  extern void unwind_table_del(struct unwind_table *tab);
> -extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk);
> +extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
> +			     const char *loglvl);
>  
>  #endif	/* !__ASSEMBLY__ */
>  
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 7c3f32b26585..69e35462c9e9 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -202,7 +202,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  #ifdef CONFIG_ARM_UNWIND
>  static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
> -	unwind_backtrace(regs, tsk);
> +	unwind_backtrace(regs, tsk, KERN_DEBUG);

Why demote this to debug level?  This is used as part of the kernel
panic message, surely we don't want this at debug level?  What about
the non-unwind version?

>  }
>  #else
>  static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> @@ -660,10 +660,10 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
>  	if (user_debug & UDBG_SYSCALL) {
>  		pr_err("[%d] %s: arm syscall %d\n",
>  		       task_pid_nr(current), current->comm, no);
> -		dump_instr("", regs);
> +		dump_instr(KERN_ERR, regs);
>  		if (user_mode(regs)) {
>  			__show_regs(regs);
> -			c_backtrace(frame_pointer(regs), processor_mode(regs), NULL);
> +			c_backtrace(frame_pointer(regs), processor_mode(regs), KERN_ERR);
>  		}
>  	}
>  #endif
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 0a65005e10f0..caaae1b6f721 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -455,11 +455,12 @@ int unwind_frame(struct stackframe *frame)
>  	return URC_OK;
>  }
>  
> -void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> +void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
> +		      const char *loglvl)
>  {
>  	struct stackframe frame;
>  
> -	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
> +	printk("%s%s(regs = %p tsk = %p)\n", loglvl, __func__, regs, tsk);

Clearly, this isn't supposed to be part of the normal backtrace output...

Overall impression at this point is really not good.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
