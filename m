Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468BAECE58B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179D20659
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U08PLMby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfJDOpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:45:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45808 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbfJDOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:44:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so7502154wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YL1+xzu/cZ1djhCIgv97dfpN2GQ4y52hUuut5JPL6dU=;
        b=U08PLMbyxiCY6k4xCWlu4rPa2dJk7qmmsOBF7dcvjBNjy9dgwtO7fBcvQzbaiLO7Bt
         XT1Fdzc83BUC9OOiR5lk7wVOVhzy2VXrNRc1Tr6gRlMv9FHkrZwj2LFGwnoTDiCsCaZ9
         3SWqwC3CexqunRgvoOLbXH7jM3cyflrrXMCVeA6HdlyRQrDRy+WQkjfZ2lHX3sG2G5Ou
         NWc5E0EcVZ2WYiNEs4WKYuNr7FcGNQwbpGEuSgwtxtnA4MggdjueAXoYRT7coc1vA0d6
         PKkru9cscsiHWz1hYt0AohMMKvEi0+66/jmqGC4BCzvDEwUD3ntxcJMvoUJYmfAKcnHG
         lKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YL1+xzu/cZ1djhCIgv97dfpN2GQ4y52hUuut5JPL6dU=;
        b=YHtXY12Xr5JJ+WaAuYBrG79mh5OPtno8Ecv7AnY7XEwKaJQQBA93WPXp7ti6IjrUoL
         LcqrLBo1k4JOiD119VrDwR+JzlNJKogubJvv42YTkpobFeXEQeTWUmnB8rJCdglWxQ/E
         N+CfTd1L+nv0BvJJUOqGS7oYnVrZQ74KVwa9tmZeuYCDsropuTxwNzRAVmA32D7xijD9
         c6pFVMm3RGDB/wwPQrX1emUsLFeSPpwzZCVXjtPog0403SzM9E2saqDiXXMzX9F+W1Tw
         ywEnnQZdTyKLzg94riijYV/7tZ5OIRXycZzglcUkhQC4Fa4Do2k07sAYXUt4547GDd5R
         +6WQ==
X-Gm-Message-State: APjAAAXldUAL0hSxEUQlPUvhM0yc49jyDjR7w4PZdRAJjBE1LfmQE0R4
        q+GcFHZ5KDyYQs9cI1icH/JYlmwL4E8=
X-Google-Smtp-Source: APXvYqwxPfS8/0yhOel4L1wkC6OKjnOA6TnL2eNx9+tn+rISSASvJUX7XrFJ4jtY+5c7LIBWVJTEXA==
X-Received: by 2002:a5d:6943:: with SMTP id r3mr11708214wrw.21.1570200295354;
        Fri, 04 Oct 2019 07:44:55 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id f18sm7103765wrv.38.2019.10.04.07.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:44:54 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:44:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20191004144453.GQ18429@dell>
References: <20191003095235.5158-1-tbogendoerfer@suse.de>
 <20191003095235.5158-4-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003095235.5158-4-tbogendoerfer@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Oct 2019, Thomas Bogendoerfer wrote:

> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/sgi-ip27/ip27-timer.c     |  20 --
>  drivers/mfd/Kconfig                 |  13 +
>  drivers/mfd/Makefile                |   1 +
>  drivers/mfd/ioc3.c                  | 585 ++++++++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sgi/Kconfig    |   4 +-
>  drivers/net/ethernet/sgi/ioc3-eth.c | 561 ++++++----------------------------
>  drivers/tty/serial/8250/8250_ioc3.c |  98 ++++++
>  drivers/tty/serial/8250/Kconfig     |  11 +
>  drivers/tty/serial/8250/Makefile    |   1 +
>  9 files changed, 809 insertions(+), 485 deletions(-)
>  create mode 100644 drivers/mfd/ioc3.c
>  create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
> 
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 9b4b9ac621a3..5631e93ea350 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -188,23 +188,3 @@ void hub_rtc_init(cnodeid_t cnode)
>  		LOCAL_HUB_S(PI_RT_PEND_B, 0);
>  	}
>  }
> -
> -static int __init sgi_ip27_rtc_devinit(void)
> -{
> -	struct resource res;
> -
> -	memset(&res, 0, sizeof(res));
> -	res.start = XPHYSADDR(KL_CONFIG_CH_CONS_INFO(master_nasid)->memory_base +
> -			      IOC3_BYTEBUS_DEV0);
> -	res.end = res.start + 32767;
> -	res.flags = IORESOURCE_MEM;
> -
> -	return IS_ERR(platform_device_register_simple("rtc-m48t35", -1,
> -						      &res, 1));
> -}
> -
> -/*
> - * kludge make this a device_initcall after ioc3 resource conflicts
> - * are resolved
> - */
> -late_initcall(sgi_ip27_rtc_devinit);
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae24d3ea68ea..a762342065a2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2011,5 +2011,18 @@ config RAVE_SP_CORE
>  	  Select this to get support for the Supervisory Processor
>  	  device found on several devices in RAVE line of hardware.
>  
> +config SGI_MFD_IOC3
> +	tristate "SGI IOC3 core driver"
> +	depends on PCI && MIPS && 64BIT
> +	select MFD_CORE
> +	help
> +	  This option enables basic support for the SGI IOC3-based
> +	  controller cards.  This option does not enable any specific
> +	  functions on such a card, but provides necessary infrastructure
> +	  for other drivers to utilize.
> +
> +	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
> +	  then say Y. Otherwise say N.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c1067ea46204..0d89b9e1055f 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -256,3 +256,4 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
> +obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
> new file mode 100644
> index 000000000000..889b7e7ff485
> --- /dev/null
> +++ b/drivers/mfd/ioc3.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SGI IOC3 multifunction device driver
> + *
> + * Copyright (C) 2018, 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
> + *
> + * Based on work by:
> + *   Stanislaw Skowronek <skylark@unaligned.org>
> + *   Joshua Kinard <kumba@gentoo.org>
> + *   Brent Casavant <bcasavan@sgi.com> - IOC4 master driver
> + *   Pat Gefre <pfg@sgi.com> - IOC3 serial port IRQ demuxer
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/sgi-w1.h>
> +
> +#include <asm/pci/bridge.h>
> +#include <asm/sn/ioc3.h>
> +
> +#define IOC3_IRQ_SERIAL_A	6
> +#define IOC3_IRQ_SERIAL_B	15
> +#define IOC3_IRQ_KBD		22
> +#define IOC3_IRQ_ETH_DOMAIN	23
> +
> +/* Bitmask for selecting which IRQs are level triggered */
> +#define IOC3_LVL_MASK	(BIT(IOC3_IRQ_SERIAL_A) | BIT(IOC3_IRQ_SERIAL_B))
> +
> +#define M48T35_REG_SIZE	32768	/* size of m48t35 registers */
> +
> +/* 1.2 us latency timer (40 cycles at 33 MHz) */
> +#define IOC3_LATENCY	40
> +
> +struct ioc3_priv_data {
> +	struct irq_domain *domain;
> +	struct ioc3 __iomem *regs;
> +	struct pci_dev *pdev;
> +	int domain_irq;
> +};
> +
> +static void ioc3_irq_ack(struct irq_data *d)
> +{
> +	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
> +	unsigned int hwirq = irqd_to_hwirq(d);
> +
> +	writel(BIT(hwirq), &ipd->regs->sio_ir);
> +}
> +
> +static void ioc3_irq_mask(struct irq_data *d)
> +{
> +	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
> +	unsigned int hwirq = irqd_to_hwirq(d);
> +
> +	writel(BIT(hwirq), &ipd->regs->sio_iec);
> +}
> +
> +static void ioc3_irq_unmask(struct irq_data *d)
> +{
> +	struct ioc3_priv_data *ipd = irq_data_get_irq_chip_data(d);
> +	unsigned int hwirq = irqd_to_hwirq(d);
> +
> +	writel(BIT(hwirq), &ipd->regs->sio_ies);
> +}
> +
> +static struct irq_chip ioc3_irq_chip = {
> +	.name		= "IOC3",
> +	.irq_ack	= ioc3_irq_ack,
> +	.irq_mask	= ioc3_irq_mask,
> +	.irq_unmask	= ioc3_irq_unmask,
> +};
> +
> +static int ioc3_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	/* Set level IRQs for every interrupt contained in IOC3_LVL_MASK */
> +	if (BIT(hwirq) & IOC3_LVL_MASK)
> +		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_level_irq);
> +	else
> +		irq_set_chip_and_handler(irq, &ioc3_irq_chip, handle_edge_irq);
> +
> +	irq_set_chip_data(irq, d->host_data);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ioc3_irq_domain_ops = {
> +	.map = ioc3_irq_domain_map,
> +};
> +
> +static void ioc3_irq_handler(struct irq_desc *desc)
> +{
> +	struct irq_domain *domain = irq_desc_get_handler_data(desc);
> +	struct ioc3_priv_data *ipd = domain->host_data;
> +	struct ioc3 __iomem *regs = ipd->regs;
> +	u32 pending, mask;
> +	unsigned int irq;
> +
> +	pending = readl(&regs->sio_ir);
> +	mask = readl(&regs->sio_ies);
> +	pending &= mask; /* mask off not enabled but pending irqs */
> +
> +	if (mask & BIT(IOC3_IRQ_ETH_DOMAIN))
> +		/* if eth irq is enabled we need to check in eth irq regs */

Nit: Comments should be expressive.  Please expand all of the
short-hand in this sentence.  It would also be nicer if you started
with an uppercase character.

Same with all of the other comments in this file.

Other than that, it looks like it's really coming together.  Once the
above is fixed, please re-sumbit with my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
