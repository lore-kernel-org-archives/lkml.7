Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14288C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C8D20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfFGQYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:24:05 -0400
Received: from foss.arm.com ([217.140.110.172]:44006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbfFGQYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2F02B;
        Fri,  7 Jun 2019 09:24:03 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFE553F71A;
        Fri,  7 Jun 2019 09:24:02 -0700 (PDT)
Date:   Fri, 7 Jun 2019 17:24:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Don't unconditionally add -Wno-psabi to
 KBUILD_CFLAGS
Message-ID: <20190607162400.GI28398@e103592.cambridge.arm.com>
References: <20190607161201.73430-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607161201.73430-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 09:12:01AM -0700, Nathan Chancellor wrote:
> This is a GCC only option, which warns about ABI changes within GCC, so
> unconditionally adding breaks Clang with tons of:
> 
> warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]
> 
> and link time failures:
> 
> ld.lld: error: undefined symbol: __efistub___stack_chk_guard
> >>> referenced by arm-stub.c:73
> (/home/nathan/cbl/linux/drivers/firmware/efi/libstub/arm-stub.c:73)
> >>>               arm-stub.stub.o:(__efistub_install_memreserve_table)
> in archive ./drivers/firmware/efi/libstub/lib.a
> 
> I suspect the link time failure comes from some flags not being added
> via cc-option, which will always fail when an unknown flag is
> unconditionally added to KBUILD_CFLAGS because -Werror is added after
> commit c3f0d0bc5b01 ("kbuild, LLVMLinux: Add -Werror to cc-option to
> support clang").
> 
> $ echo "int main() { return 0; }" | clang -Wno-psabi -o /dev/null -x c -
> warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]
> 1 warning generated.
> 
> $ echo $?
> 0
> 
> $ echo "int main() { return 0; }" | clang -Werror -Wno-psabi -o /dev/null -x c -
> error: unknown warning option '-Wno-psabi' [-Werror,-Wunknown-warning-option]
> 
> $ echo $?
> 1
> 
> This side effect is user visible (aside from the inordinate amount of
> -Wunknown-warning-option and build failure), as some warnings that are
> normally disabled like -Waddress-of-packed-member or
> -Wunused-const-variable show up.
> 
> Use cc-disable-warning so that it gets disabled for GCC and does nothing
> for Clang.
> 
> Fixes: ebcc5928c5d9 ("arm64: Silence gcc warnings about arch ABI drift")
> Link: https://github.com/ClangBuiltLinux/linux/issues/511
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

FWIW,
Acked-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave

> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 8fbd583b18e1..e9d2e578cbe6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -51,7 +51,7 @@ endif
>  
>  KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> -KBUILD_CFLAGS	+= -Wno-psabi
> +KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>  
>  KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
> -- 
> 2.22.0.rc3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
