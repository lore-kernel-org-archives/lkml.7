Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BA32089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfDXHdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:33:07 -0400
Received: from foss.arm.com ([217.140.101.70]:38972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbfDXHdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:33:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC5980D;
        Wed, 24 Apr 2019 00:33:06 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87ED53F238;
        Wed, 24 Apr 2019 00:33:03 -0700 (PDT)
Date:   Wed, 24 Apr 2019 08:33:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: sysreg: Make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190424073258.d5gv7s7ij5zujd2l@blommer>
References: <20190423232622.GA11776@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423232622.GA11776@beast>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Apr 23, 2019 at 04:26:22PM -0700, Kees Cook wrote:
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

[...]

> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 43d8366c1e87..d359f28765cb 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -43,7 +43,7 @@ static inline void arch_local_irq_enable(void)
>  	asm volatile(ALTERNATIVE(
>  		"msr	daifclr, #2		// arch_local_irq_enable\n"
>  		"nop",
> -		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +		__msr_s(SYS_ICC_PMR_EL1)

Seeing the __stringify() go is nice!

Our assembly happens to use argument 0 by coincidence rather than by deliberate
design, so please have the macro take the template, e.g.

	__msr_s(SYS_ICC_PMR_EL1, "%x0")

... that ways it's obvious as to which asm parameter is used, and this won't
complicate refactoring of the assembly (which may shuffle or rename the
parameters).

Likewise for __mrs_s(), e.g.

	__mrs_s("%x[va]", SYS_WHATEVER);

[...]

> +#define __mrs_s(r)						\
> +	DEFINE_MRS_S						\
> +"	mrs_s %0, " __stringify(r) "\n"				\
> +	UNDEFINE_MRS_S
> +
> +#define __msr_s(r)						\
> +	DEFINE_MSR_S						\
> +"	msr_s " __stringify(r) ", %0\n"				\
> +	UNDEFINE_MSR_S

These can be:

#define __mrs_s(v, r)						\
	DEFINE_MRS_S						\
"	mrs_s " v ", " __stringify(r) "\n"			\
	UNDEFINE_MRS_S


#define __msr_s(r, v)						\
	DEFINE_MSR_S						\
"	msr_s " __stringify(r) ", " v "\n"			\
	UNDEFINE_MSR_S


> +
> +/* For use with "rZ" constraints. */
> +#define __msr_s_x0(r)						\
> +	DEFINE_MSR_S						\
> +"	msr_s " __stringify(r) ", %x0\n"			\
> +	UNDEFINE_MSR_S

I don't think we need this. If we pass the template in, this is solved by the
caller, and we could consistently use the x form regardless.

Otherwise, I think this is as clean as we can make this short of bumping our
minimum binutils version and using the S<Op0>_<...> names.

Thanks,
Mark.
