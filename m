Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDAC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A3218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576662068;
	bh=c6QqVLkaKqU5NilW1dTDhS9yushZREm/CbjJxAnLpfk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=QF5RQtbDSkHWLO/oaUvhPiRv8iL2s3zYIpCIAZRH/tUSko36UZt0/HZ4fkjyvVTur
	 8OBLdDFpfSSSAQb0L7IzB8zlzviwSBIhNS3yVGsh5hfDE8j1dnrLSoeGJs9wFJ9eLD
	 LjLbUKdiZy+fJq6PUAeYczG+dWk79JoZXzHiNxNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLRJlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:41:07 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:59461 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:41:07 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihVpB-0004Mi-LQ; Wed, 18 Dec 2019 10:40:57 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 3/3] drivers/irqchip: enable INTMUX interrupt controller  driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 09:40:57 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <shengjiu.wang@nxp.com>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fugang.duan@nxp.com>,
        <aisheng.dong@nxp.com>
In-Reply-To: <1576653615-27954-4-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576653615-27954-4-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <30431cce4c9e59ab11043c991493c368@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com, aisheng.dong@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 07:20, Joakim Zhang wrote:
> Enable INTMUX interrupt controller driver for i.MX platforms.
>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/irqchip/Kconfig  | 6 ++++++
>  drivers/irqchip/Makefile | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ba152954324b..7e2b1e9d0b45 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -457,6 +457,12 @@ config IMX_IRQSTEER
>  	help
>  	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
>
> +config IMX_INTMUX
> +	def_bool y if ARCH_MXC
> +	select IRQ_DOMAIN
> +	help
> +	  Support for the i.MX INTMUX interrupt multiplexer.
> +
>  config LS1X_IRQ
>  	bool "Loongson-1 Interrupt Controller"
>  	depends on MACH_LOONGSON32
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e806dda690ea..af976a79d1fb 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
> +obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
>  obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o

Please merge this with the previous patch, it doesn't really warrant
a separate patch.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
