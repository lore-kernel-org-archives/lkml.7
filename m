Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7B020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDIMZq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:25:46 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:50642 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:25:45 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 953AA17C68; Tue,  9 Apr 2019 13:25:43 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: use arch_extension directive instead of arch argument
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
Date:   Tue, 09 Apr 2019 13:25:43 +0100
In-Reply-To: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
        (Stefan Agner's message of "Mon, 8 Apr 2019 22:59:53 +0200")
Message-ID: <yw1xk1g3xt4o.fsf@mansr.com>
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
> to use Clang with LLVM's integrated assembler, this leads to build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
> multi-platform kernel is being built.
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
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Changes since v1:
> - Explicitly specify assembler architecture as armv7-a to avoid
>   build issues when bulding v6/v7 multi arch kernel.
>
>  arch/arm/mach-bcm/Makefile         | 3 ---
>  arch/arm/mach-bcm/bcm_kona_smc.c   | 2 --
>  arch/arm/mach-exynos/Makefile      | 4 ----
>  arch/arm/mach-exynos/exynos-smc.S  | 3 ++-
>  arch/arm/mach-exynos/sleep.S       | 3 ++-
>  arch/arm/mach-highbank/Makefile    | 3 ---
>  arch/arm/mach-highbank/smc.S       | 3 ++-
>  arch/arm/mach-keystone/Makefile    | 3 ---
>  arch/arm/mach-keystone/smc.S       | 1 +
>  arch/arm/mach-omap2/Makefile       | 8 --------
>  arch/arm/mach-omap2/omap-headsmp.S | 2 ++
>  arch/arm/mach-omap2/omap-smc.S     | 3 ++-
>  arch/arm/mach-omap2/sleep33xx.S    | 1 +
>  arch/arm/mach-omap2/sleep34xx.S    | 2 ++
>  arch/arm/mach-omap2/sleep43xx.S    | 2 ++
>  arch/arm/mach-omap2/sleep44xx.S    | 2 ++
>  arch/arm/mach-tango/Makefile       | 3 ---
>  arch/arm/mach-tango/smc.S          | 1 +
>  18 files changed, 19 insertions(+), 30 deletions(-)

[...]

> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
> index a55a7ecf146a..541e850a736c 100644
> --- a/arch/arm/mach-bcm/bcm_kona_smc.c
> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
> @@ -125,9 +125,7 @@ static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
>  		__asmeq("%2", "r4")
>  		__asmeq("%3", "r5")
>  		__asmeq("%4", "r6")
> -#ifdef REQUIRES_SEC
>  		".arch_extension sec\n"
> -#endif
>  		"	smc    #0\n"
>  		: "=r" (ip), "=r" (r0)
>  		: "r" (r4), "r" (r5), "r" (r6)

[...]

> diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
> index d15de8179fab..ec03dc499270 100644
> --- a/arch/arm/mach-keystone/smc.S
> +++ b/arch/arm/mach-keystone/smc.S
> @@ -21,6 +21,7 @@
>   *
>   * Return: Non zero value on failure
>   */
> +	.arch_extension sec
>  ENTRY(keystone_cpu_smc)
>  	stmfd   sp!, {r4-r11, lr}
>  	smc	#0

[...]

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

Is there some reason these three don't need the .arch directive?

-- 
Måns Rullgård
