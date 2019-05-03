Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D9DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30A2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfECKL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:11:58 -0400
Received: from foss.arm.com ([217.140.101.70]:57874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfECKL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:11:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9197180D;
        Fri,  3 May 2019 03:11:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26CBF3F557;
        Fri,  3 May 2019 03:11:56 -0700 (PDT)
Date:   Fri, 3 May 2019 11:11:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: fix syscall_fn_t type
Message-ID: <20190503101153.GC47811@lakrids.cambridge.arm.com>
References: <20190501200451.255615-1-samitolvanen@google.com>
 <20190501200451.255615-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501200451.255615-2-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 01:04:50PM -0700, Sami Tolvanen wrote:
> Use const struct pt_regs * instead of struct pt_regs * as
> the argument type to fix indirect call type mismatches with
> Control-Flow Integrity checking.

It's probably worth noting that in <asm/syscall_wrapper.h> all syscall
wrappers take a const struct pt_regs *, which is where the mismatch
comes from.

> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index a179df3674a1a..6206ab9bfcfc5 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -20,7 +20,7 @@
>  #include <linux/compat.h>
>  #include <linux/err.h>
>  
> -typedef long (*syscall_fn_t)(struct pt_regs *regs);
> +typedef long (*syscall_fn_t)(const struct pt_regs *regs);

For a second I was worried that we modify the regs to assign the return
value, but I see we do that in the syscall.c wrapper, where the pt_regs
argument isn't const.

We certainly chouldn't need to modify the regs when acquiring the
arguments, and as above this matches <asm/syscall_wrapper.h>, so this
looks sound to me.

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
