Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A2206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCWQC7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:02:59 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:41680 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfCWQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:02:58 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id EDF2114CEA; Sat, 23 Mar 2019 16:02:49 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: use arch_extension directive instead of arch argument
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
Date:   Sat, 23 Mar 2019 16:02:49 +0000
In-Reply-To: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
        (Stefan Agner's message of "Sat, 23 Mar 2019 16:52:56 +0100")
Message-ID: <yw1xa7hlzihi.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Agner <stefan@agner.ch> writes:

> The LLVM Target parser currently does not allow to specify the security
> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> to use Clang with LLVM's integrated assembler, this leads to a build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion.
>
> Note that this is technically not exactly the same as the old code
> checked for availabilty of the security extension by calling as-instr.
> However, there are already other sites which use ".arch_extension sec"
> unconditionally, hence de-facto we need an assembler capable of
> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> arch extension "sec" is available since binutils 2.21 according to
> its documentation [1].
>
> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mach-bcm/Makefile         | 3 ---
>  arch/arm/mach-bcm/bcm_kona_smc.c   | 2 --
>  arch/arm/mach-exynos/Makefile      | 4 ----
>  arch/arm/mach-exynos/exynos-smc.S  | 2 +-
>  arch/arm/mach-exynos/sleep.S       | 2 +-
>  arch/arm/mach-highbank/Makefile    | 3 ---
>  arch/arm/mach-highbank/smc.S       | 2 +-
>  arch/arm/mach-keystone/Makefile    | 3 ---
>  arch/arm/mach-keystone/smc.S       | 1 +
>  arch/arm/mach-omap2/Makefile       | 8 --------
>  arch/arm/mach-omap2/omap-headsmp.S | 1 +
>  arch/arm/mach-omap2/omap-smc.S     | 2 +-
>  arch/arm/mach-omap2/sleep34xx.S    | 1 +
>  arch/arm/mach-omap2/sleep43xx.S    | 1 +
>  arch/arm/mach-omap2/sleep44xx.S    | 1 +
>  arch/arm/mach-tango/Makefile       | 3 ---
>  arch/arm/mach-tango/smc.S          | 1 +
>  17 files changed, 10 insertions(+), 30 deletions(-)

[...]

> diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
> index da6c633d3cc0..97cd04508fa1 100644
> --- a/arch/arm/mach-tango/Makefile
> +++ b/arch/arm/mach-tango/Makefile
> @@ -1,7 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -plus_sec := $(call as-instr,.arch_extension sec,+sec)
> -AFLAGS_smc.o := -Wa,-march=armv7-a$(plus_sec)
> -
>  obj-y += setup.o smc.o
>  obj-$(CONFIG_SMP) += platsmp.o
>  obj-$(CONFIG_SUSPEND) += pm.o
> diff --git a/arch/arm/mach-tango/smc.S b/arch/arm/mach-tango/smc.S
> index 361a8dc89804..cf2d21e5226c 100644
> --- a/arch/arm/mach-tango/smc.S
> +++ b/arch/arm/mach-tango/smc.S
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/linkage.h>
>
> +	.arch_extension sec
>  ENTRY(tango_smc)
>  	push	{lr}
>  	mov	ip, r1

For Tango:

Acked-by: Mans Rullgard <mans@mansr.com>

-- 
Måns Rullgård
