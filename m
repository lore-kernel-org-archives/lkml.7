Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D39DC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F22080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfDURXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:23:06 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35797 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:23:06 -0400
Received: from localhost (69.249.23.93.rev.sfr.net [93.23.249.69])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DE1BD100002;
        Sun, 21 Apr 2019 17:22:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>, arm@kernel.org
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3 4/4] ARM: mvebu: prefix coprocessor operand with p
In-Reply-To: <c398b2639f4267cd1aa8be445439e9b415121175.1554968922.git.stefan@agner.ch>
References: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch> <c398b2639f4267cd1aa8be445439e9b415121175.1554968922.git.stefan@agner.ch>
Date:   Sun, 21 Apr 2019 19:22:56 +0200
Message-ID: <87a7gj8e8f.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

> In every other instance where mrc is used the coprocessor operand
> is prefix with p (e.g. p15). Use the p prefix in this case too.
> This fixes a build issue when using LLVM's integrated assembler:
>   arch/arm/mach-mvebu/coherency_ll.S:69:6: error: invalid operand for instruction
>    mrc 15, 0, r3, cr0, cr0, 5
>        ^
>   arch/arm/mach-mvebu/pmsu_ll.S:19:6: error: invalid operand for instruction
>    mrc 15, 0, r0, cr0, cr0, 5 @ get the CPU ID
>        ^
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

Applied on mvebu/arm, as well as the previous patch.

Thanks,

Gregory

> ---
>  arch/arm/mach-mvebu/coherency_ll.S | 2 +-
>  arch/arm/mach-mvebu/pmsu_ll.S      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> index 8b2fbc8b6bc6..2d962fe48821 100644
> --- a/arch/arm/mach-mvebu/coherency_ll.S
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -66,7 +66,7 @@ ENDPROC(ll_get_coherency_base)
>   * fabric registers
>   */
>  ENTRY(ll_get_coherency_cpumask)
> -	mrc	15, 0, r3, cr0, cr0, 5
> +	mrc	p15, 0, r3, cr0, cr0, 5
>  	and	r3, r3, #15
>  	mov	r2, #(1 << 24)
>  	lsl	r3, r2, r3
> diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
> index c1fb713e9306..7aae9a25cfeb 100644
> --- a/arch/arm/mach-mvebu/pmsu_ll.S
> +++ b/arch/arm/mach-mvebu/pmsu_ll.S
> @@ -16,7 +16,7 @@
>  ENTRY(armada_38x_scu_power_up)
>  	mrc     p15, 4, r1, c15, c0	@ get SCU base address
>  	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
> -	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
> +	mrc	p15, 0, r0, cr0, cr0, 5	@ get the CPU ID
>  	and	r0, r0, #15
>  	add	r1, r1, r0
>  	mov	r0, #0x0
> -- 
> 2.21.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
