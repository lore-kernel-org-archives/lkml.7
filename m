Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577720716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757679;
	bh=rOy4ek2mgV1L24thicn9UdoOkf1ZoHaqk5jMo3PJzgw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=zm1aDI6l6vhxD2z0al4c4bfmhIXVSjJxXBeuSc9y7ObvdrxnXNqq/HB4EwuXwp76q
	 FJFeoXsJ5UGONzSM5ujyoWixmzuyUCzdstv5dqPG3GnWGvB3PRXmsFN3gFRBAQKebU
	 kGjBGBWj8PEGP4uiafKByLNKF6bvwziQKYLxFm80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:14:38 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39231 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfLSMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:14:37 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihuhJ-00076z-VD; Thu, 19 Dec 2019 13:14:29 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH V2 0/2] irqchip: add NXP INTMUX interrupt controller
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Dec 2019 12:14:29 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <fugang.duan@nxp.com>, <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <f80a236884aeba78dfa45596dcb20255@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, fugang.duan@nxp.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 10:21, Joakim Zhang wrote:
> Hi Marc,
>
>    Registering domain for each channel is indeed a bit unreasonable, 
> I have
> changed the driver to support only one channel (channel 0 by default) 
> as
> muti-channels is designed to route interrupt to different cores. The 
> fixed
> channel is enough for us.

But that's not what the HW does, right? Next time, you will post
the patches that enabled multiple channels, and the interrupt specifier
will have to change, which will impact all existing DTs.

So please do the right thing from the start. Add channel selection to
the interrupt specifier. Pick the right irq domain with a .select()
callback, and your driver will magically work.

Thanks,

         M.

>   Thanks for your kindly review.
>
> ChangeLog:
> V1->V2:	*squash patches:
> 		drivers/irqchip: enable INTMUX interrupt controller driver
>  		drivers/irqchip: add NXP INTMUX interrupt multiplexer support
> 	*remove properity "fsl,intmux_chans", only support channel 0 by
> 	default.
> 	*delete two unused macros.
> 	*align the various field in struct intmux_data.
> 	*turn to spin lock _irqsave version.
> 	*delete struct intmux_irqchip_data
> 	*disable interrupt in probe stage and clear pending status in remove
> 	stage
>
> Joakim Zhang (2):
>   dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
>   drivers/irqchip: add NXP INTMUX interrupt multiplexer support
>
>  .../interrupt-controller/fsl,intmux.txt       |  28 ++
>  drivers/irqchip/Kconfig                       |   6 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-imx-intmux.c              | 240 
> ++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>  create mode 100644 drivers/irqchip/irq-imx-intmux.c

-- 
Jazz is not dead. It just smells funny...
