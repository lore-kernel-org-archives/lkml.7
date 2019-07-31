Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78D6206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfGaPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:01:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387946AbfGaPBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:01:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496FD344;
        Wed, 31 Jul 2019 08:01:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BC443F694;
        Wed, 31 Jul 2019 08:01:40 -0700 (PDT)
Date:   Wed, 31 Jul 2019 16:01:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Move TIF_* documentation to individual definitions
Message-ID: <20190731150137.GE39768@lakrids.cambridge.arm.com>
References: <20190731133520.17939-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731133520.17939-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:35:20PM +0200, Geert Uytterhoeven wrote:
> Some TIF_* flags are documented in the comment block at the top, some
> next to their definitions, some in both places.
> 
> Move all documentation to the individual definitions for consistency,
> and for easy lookup.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The alternative is to move all of them to the comment block, and using
> linuxdoc style.
> 
>  arch/arm64/include/asm/thread_info.h | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 180b34ec59650a9b..cb3eb1ccccc4116b 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -60,28 +60,20 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #endif
>  
>  /*
> - * thread information flags:
> - *  TIF_SYSCALL_TRACE	- syscall trace active
> - *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
> - *  TIF_SYSCALL_AUDIT	- syscall auditing
> - *  TIF_SECCOMP		- syscall secure computing
> - *  TIF_SYSCALL_EMU     - syscall emulation active
> - *  TIF_SIGPENDING	- signal pending
> - *  TIF_NEED_RESCHED	- rescheduling necessary
> - *  TIF_NOTIFY_RESUME	- callback before returning to user
> + * thread information flags
>   */

We can probably just get rid of the this comment block at this point. :)

> -#define TIF_SIGPENDING		0
> -#define TIF_NEED_RESCHED	1
> +#define TIF_SIGPENDING		0	/* signal pending */
> +#define TIF_NEED_RESCHED	1	/* rescheduling necessary */
>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>  #define TIF_NOHZ		7
> -#define TIF_SYSCALL_TRACE	8
> -#define TIF_SYSCALL_AUDIT	9
> -#define TIF_SYSCALL_TRACEPOINT	10
> -#define TIF_SECCOMP		11
> -#define TIF_SYSCALL_EMU		12
> +#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> +#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> +#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> +#define TIF_SECCOMP		11	/* syscall secure computing */
> +#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20

FWIW this looks sane to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> -- 
> 2.17.1
> 
