Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA06FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C9120820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571300632;
	bh=Z5yjauImfj0e76CyWFKn/Cdoc3wH1qjxtlUVZvM7T/A=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=mfPS/S5oQXr3kg3HX1+gitFSzVmXE3MD7Y8SOJRilmj0hP8iww0Xxn4JGZByp5XLD
	 B9jK7QvE1iRaTzQdERgwP/YP98S8/BR0/kwdwBDEM94Yi/OKZMZekxn+/q11OSbYjE
	 09TwppKyeyzlw9+YfIRnMqnWyq37Fn7nqJZ6qy94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408208AbfJQIXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:23:51 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:39140 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389953AbfJQIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:23:50 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iL14J-0002NX-Lg; Thu, 17 Oct 2019 10:23:35 +0200
To:     Daode Huang <huangdaode@hisilicon.com>
Subject: Re: [PATCH] use =?UTF-8?Q?devm=5Fplatform=5Fioremap=5Fresource=28?=  =?UTF-8?Q?=29=20for=20irqchip=20drivers?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Oct 2019 09:23:34 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <tglx@linutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
In-Reply-To: <1571296423-208359-1-git-send-email-huangdaode@hisilicon.com>
References: <1571296423-208359-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <9bbcce19c777583815c92ce3c2ff2586@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: huangdaode@hisilicon.com, jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, tglx@linutronix.de, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, nm@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-17 08:13, Daode Huang wrote:
> From: Daode Huang <huangdaode@hislicon.com>
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together
>
> Signed-off-by: Daode Huang <huangdaode@hislicon.com>
> ---
>  drivers/irqchip/irq-mvebu-icu.c   | 3 +--
>  drivers/irqchip/irq-mvebu-pic.c   | 3 +--
>  drivers/irqchip/irq-stm32-exti.c  | 3 +--
>  drivers/irqchip/irq-ti-sci-inta.c | 3 +--
>  drivers/irqchip/irq-ts4800.c      | 3 +--
>  5 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mvebu-icu.c
> b/drivers/irqchip/irq-mvebu-icu.c
> index 547045d..ddf9b0d 100644
> --- a/drivers/irqchip/irq-mvebu-icu.c
> +++ b/drivers/irqchip/irq-mvebu-icu.c
> @@ -357,8 +357,7 @@ static int mvebu_icu_probe(struct platform_device 
> *pdev)
>
>  	icu->dev = &pdev->dev;
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	icu->base = devm_ioremap_resource(&pdev->dev, res);
> +	icu->base = devm_platform_ioremap_resource(pdev, res);

void __iomem *devm_platform_ioremap_resource(struct platform_device 
*pdev,
                                              unsigned int index)

What could possibly go wrong? I'd suggest you start compiling (and 
possibly
testing) the code you change before sending patches...

         M.
-- 
Jazz is not dead. It just smells funny...
