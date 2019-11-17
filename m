Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D151FC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C03E206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573988540;
	bh=LPcvXNw1mLuXrOg82i2tbZ63dHq4jTPmRO2gOYtV0Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1yL8LPPBJEIJQ62mFALT94tpBBgzDB2We3d2/CYp1UFZ37qAPyS8wMJ8l660H5k+o
	 qo/lwLHl+c//Px7tc+uldn9+Lxthu53LK7kyN0ju646JZlEsU84deVhPyWLeg8qo4r
	 AGHMYjpr+zMoa+P9YHAX1xsXRLOECxGcXaF9A4/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfKQLCT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 06:02:19 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54195 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfKQLCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 06:02:19 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iWIJs-0002Zx-8i; Sun, 17 Nov 2019 12:02:16 +0100
Date:   Sun, 17 Nov 2019 11:02:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Andreas =?UTF-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
Message-ID: <20191117110214.6b160b2e@why>
In-Reply-To: <20191117072109.20402-9-afaerber@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
        <20191117072109.20402-9-afaerber@suse.de>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019 08:21:09 +0100
Andreas Färber <afaerber@suse.de> wrote:

> Without this magic write the timer doesn't work and boot gets stuck.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  What is the name of the register 0xff018000?
>  Is 0x1 a BIT(0) write, or how are the register bits defined?
>  Is this a reset or a clock gate? How should we model it in DT?
>  
>  v2 -> v3: Unchanged
>  
>  v2: New
>  
>  arch/arm/mach-realtek/rtd1195.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/mach-realtek/rtd1195.c b/arch/arm/mach-realtek/rtd1195.c
> index b31a4066be87..0532379c74f5 100644
> --- a/arch/arm/mach-realtek/rtd1195.c
> +++ b/arch/arm/mach-realtek/rtd1195.c
> @@ -5,6 +5,9 @@
>   * Copyright (c) 2017-2019 Andreas Färber
>   */
>  
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +#include <linux/io.h>
>  #include <linux/memblock.h>
>  #include <asm/mach/arch.h>
>  
> @@ -24,6 +27,18 @@ static void __init rtd1195_reserve(void)
>  	rtd1195_memblock_remove(0x18100000, 0x01000000);
>  }
>  
> +static void __init rtd1195_init_time(void)
> +{
> +	void __iomem *base;
> +
> +	base = ioremap(0xff018000, 4);
> +	writel(0x1, base);
> +	iounmap(base);
> +
> +	of_clk_init(NULL);
> +	timer_probe();
> +}

Gawd... Why isn't this set from the bootloader? By the time the kernel
starts, everything should be up and running. What is it going to do
when you kexec? Shouldn't this be a read/modify/write sequence?

	M.
-- 
Jazz is not dead. It just smells funny...
