Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97394C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708192075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfDORGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:06:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39300 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDORGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:06:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E55080D;
        Mon, 15 Apr 2019 10:06:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7543F68F;
        Mon, 15 Apr 2019 10:06:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 18:06:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190415170604.GA44415@lakrids.cambridge.arm.com>
References: <20190415143821.GA46880@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415143821.GA46880@beast>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 07:38:21AM -0700, Kees Cook wrote:
> From: Alex Matveev <alxmtvv@gmail.com>
> 
> Clang's integrated assembler does not allow assembly macros defined
> in one inline asm block using the .macro directive to be used across
> separate asm blocks. LLVM developers consider this a feature and not a
> bug, recommending code refactoring:
> 
>   https://bugs.llvm.org/show_bug.cgi?id=19749
> 
> As binutils doesn't allow macros to be redefined, this change uses
> UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> in-place and workaround gcc and clang limitations on redefining macros
> across different assembler blocks.
> 
> Specifically, the current state after preprocessing looks like this:
> 
> asm volatile(".macro mXX_s ... .endm");
> void f()
> {
> 	asm volatile("mXX_s a, b");
> }
> 
> With GCC, it gives macro redefinition error because sysreg.h is included
> in multiple source files, and assembler code for all of them is later
> combined for LTO (I've seen an intermediate file with hundreds of
> identical definitions).
> 
> With clang, it gives macro undefined error because clang doesn't allow
> sharing macros between inline asm statements.
> 
> I also seem to remember catching another sort of undefined error with
> GCC due to reordering of macro definition asm statement and generated
> asm code for function that uses the macro.
> 
> The solution with defining and undefining for each use, while certainly
> not elegant, satisfies both GCC and clang, LTO and non-LTO.
> 
> Signed-off-by: Alex Matveev <alxmtvv@gmail.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: split out patch as stand-alone, added more uses in irqflags,
>     updated commit log, based on discussion in
>     https://lore.kernel.org/patchwork/patch/851580/
> ---
>  arch/arm64/include/asm/irqflags.h | 12 +++++--
>  arch/arm64/include/asm/kvm_hyp.h  |  8 +++--
>  arch/arm64/include/asm/sysreg.h   | 55 +++++++++++++++++++++----------
>  3 files changed, 53 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 43d8366c1e87..06d3987d1546 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -43,7 +43,9 @@ static inline void arch_local_irq_enable(void)
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>  		"nop",
> +		DEFINE_MSR_S
>  		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		UNDEFINE_MSR_S

If we do need this, can we wrap this in a larger CPP macro that does the
whole sequence of defining, using, and undefining the asm macros?

It would be nice if we could simply rely on a more recent binutils these
days, which supports the generic S<op0>_<op1>_<cn>_<Cm>_<op2> sysreg
definition. That would mean we could get rid of the whole msr_s/mrs_s
hack by turning that into a CPP macro which built that name.

It looks like binutils has been able to do that since September 2014...

Are folk using toolchains older than that to compile kernels?

Thanks,
Mark.
