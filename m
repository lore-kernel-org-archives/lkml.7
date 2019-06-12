Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3361C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9783D207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408714AbfFLJZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:25:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406207AbfFLJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C883C28;
        Wed, 12 Jun 2019 02:25:23 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA1123F246;
        Wed, 12 Jun 2019 02:25:22 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:25:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Don't unconditionally add -Wno-psabi to
 KBUILD_CFLAGS
Message-ID: <20190612092519.GP28398@e103592.cambridge.arm.com>
References: <20190607161201.73430-1-natechancellor@gmail.com>
 <20190611171931.99705-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611171931.99705-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:19:32AM -0700, Nathan Chancellor wrote:
> This is a GCC only option, which warns about ABI changes within GCC, so
> unconditionally adding it breaks Clang with tons of:
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
> These failures come from the lack of -fno-stack-protector, which is
> added via cc-option in drivers/firmware/efi/libstub/Makefile. When an
> unknown flag is added to KBUILD_CFLAGS, clang will noisily warn that it
> is ignoring the option like above, unlike gcc, who will just error.
> 
> $ echo "int main() { return 0; }" > tmp.c
> 
> $ clang -Wno-psabi tmp.c; echo $?
> warning: unknown warning option '-Wno-psabi' [-Wunknown-warning-option]
> 1 warning generated.
> 0
> 
> $ gcc -Wsometimes-uninitialized tmp.c; echo $?
> gcc: error: unrecognized command line option
> ‘-Wsometimes-uninitialized’; did you mean ‘-Wmaybe-uninitialized’?
> 1
> 
> For cc-option to work properly with clang and behave like gcc, -Werror
> is needed, which was done in commit c3f0d0bc5b01 ("kbuild, LLVMLinux:
> Add -Werror to cc-option to support clang").
> 
> $ clang -Werror -Wno-psabi tmp.c; echo $?
> error: unknown warning option '-Wno-psabi'
> [-Werror,-Wunknown-warning-option]
> 1
> 
> As a consequence of this, when an unknown flag is unconditionally added
> to KBUILD_CFLAGS, it will cause cc-option to always fail and those flags
> will never get added:
> 
> $ clang -Werror -Wno-psabi -fno-stack-protector tmp.c; echo $?
> error: unknown warning option '-Wno-psabi'
> [-Werror,-Wunknown-warning-option]
> 1
> 
> This can be seen when compiling the whole kernel as some warnings that
> are normally disabled (see below) show up. The full list of flags
> missing from drivers/firmware/efi/libstub are the following (gathered
> from diffing .arm64-stub.o.cmd):
> 
> -fno-delete-null-pointer-checks
> -Wno-address-of-packed-member
> -Wframe-larger-than=2048
> -Wno-unused-const-variable
> -fno-strict-overflow
> -fno-merge-all-constants
> -fno-stack-check
> -Werror=date-time
> -Werror=incompatible-pointer-types
> -ffreestanding
> -fno-stack-protector
> 
> Use cc-disable-warning so that it gets disabled for GCC and does nothing
> for Clang.
> 
> Fixes: ebcc5928c5d9 ("arm64: Silence gcc warnings about arch ABI drift")
> Link: https://github.com/ClangBuiltLinux/linux/issues/511
> Reported-by: Qian Cai <cai@lca.pw>
> Acked-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Improve commit message explanation, I wasn't entirely happy with the
>   first one; let me know if there are any issues/questions.
> 
> * Carry forward Dave's ack and Nick's review (let me know if you
>   disagree with the commit messasge rewording).
> 
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

Looks OK to me.  Thanks for the additional explanation.

Cheers
---Dave
