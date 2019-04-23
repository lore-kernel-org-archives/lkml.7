Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736AEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4E217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfDWLbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:31:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWLbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:31:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55D9B374;
        Tue, 23 Apr 2019 04:31:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C28F3F557;
        Tue, 23 Apr 2019 04:31:45 -0700 (PDT)
Date:   Tue, 23 Apr 2019 12:31:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com
Subject: Re: [RESEND PATCH v3 02/11] arm64: mark (__)cpus_have_const_cap as
 __always_inline
Message-ID: <20190423113142.GB56999@lakrids.cambridge.arm.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-3-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423034959.13525-3-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding relevant arm64 folk to Cc]

On Tue, Apr 23, 2019 at 12:49:50PM +0900, Masahiro Yamada wrote:
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
> 
> If it is enabled for arm64, the following errors are reported:
> 
> In file included from ././include/linux/compiler_types.h:68,
>                  from <command-line>:
> ./arch/arm64/include/asm/jump_label.h: In function 'cpus_have_const_cap':
> ./include/linux/compiler-gcc.h:120:38: warning: asm operand 0 probably doesn't match constraints
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler-gcc.h:120:38: error: impossible constraint in 'asm'
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This looks sound to me, and from a quick scan of v5.1-rc6 with:

$ git grep -wW inline -- arch/arm64

... I didn't spot any other sites which obviously needed to be made
__always_inline.

I've built and booted this atop of defconfig and my usual suite of debug
options for fuzzing, at EL1 under QEMU/KVM, and at EL2 under QEMU/TCG,
with no issues in either case, so FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
> 
> Changes in v3: None
> Changes in v2:
>   - split into a separate patch
> 
>  arch/arm64/include/asm/cpufeature.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e505e1fbd2b9..77d1aa57323e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -406,7 +406,7 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>  
>  /* System capability check for constant caps */
> -static inline bool __cpus_have_const_cap(int num)
> +static __always_inline bool __cpus_have_const_cap(int num)
>  {
>  	if (num >= ARM64_NCAPS)
>  		return false;
> @@ -420,7 +420,7 @@ static inline bool cpus_have_cap(unsigned int num)
>  	return test_bit(num, cpu_hwcaps);
>  }
>  
> -static inline bool cpus_have_const_cap(int num)
> +static __always_inline bool cpus_have_const_cap(int num)
>  {
>  	if (static_branch_likely(&arm64_const_caps_ready))
>  		return __cpus_have_const_cap(num);
> -- 
> 2.17.1
> 
