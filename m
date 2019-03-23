Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EDF2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 18:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bz3MBBlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCWSSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 14:18:47 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:58360 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCWSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 14:18:46 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Mar 2019 14:18:46 EDT
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 987EDFAC2;
        Sat, 23 Mar 2019 14:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=UGmpSm0lKJWCOVV7sJlrEE3PltU=; b=Bz3MBB
        lNqCttOHNi1aYu4wILYTzqtvQhuN2u9/2KGgtztIvrQ046u7fzGU5TVGv8uOW5oL
        6l5PjJz8L2ksPaHhnjKG3xgCjtPB47KjzQibcvCQFihgfBG44D/MWdI3LSIwx9+6
        8ZnqD0Bsq0kaHqY3YtC5KwbBn8RYbP4D9erdU=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 7618EFAC1;
        Sat, 23 Mar 2019 14:11:18 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4580612C00B;
        Sat, 23 Mar 2019 13:56:26 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 40A2B2DA01C2;
        Sat, 23 Mar 2019 13:56:25 -0400 (EDT)
Date:   Sat, 23 Mar 2019 13:56:24 -0400 (EDT)
From:   nicolas.pitre@linaro.org
To:     Stefan Agner <stefan@agner.ch>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, mans@mansr.com,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: mvebu: prefix coprocessor operand with p
In-Reply-To: <7258b06ce7f788dd5d8eedc55855205c08068c0b.1553356359.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1903231355250.1971@knanqh.ubzr>
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch> <7258b06ce7f788dd5d8eedc55855205c08068c0b.1553356359.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FA672C9A-4D94-11E9-A4AF-DF19F34BB12D-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019, Stefan Agner wrote:

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

Acked-by: Nicolas Pitre <nico@fluxnic.net>


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
> 
