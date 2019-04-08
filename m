Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59044C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0631820879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhOwJiZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDHTCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:02:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35194 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDHTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:02:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so7837068pgf.2;
        Mon, 08 Apr 2019 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gg4noTFSeFvTJ8Mo8nyOZTyHl3bO2/5vd17mquRt/iE=;
        b=OhOwJiZqmbgwO5M9Y0DF21hID22pUxzfxAo8RcJe+WJVJr8ZXvGMyDdiTKkAZyHgBc
         MBShQjuqDhGtWJgBEu8MsygsKUEtbbYsGUBY4LnpBw/MaSq/LMismlSFQ1e9/e/ulRKY
         zjIWMH89wsehW4795X5GZ3c40TSI3Okp8i/GkzG0yPtpYmRZjz8pOrOEVZseS8FTD50A
         wjljhclYp0REN03iKuuh+Xbl9pYNgZ9CzkAYgcO7vRn17qLnvhvmONBGRNOz7H5C6pIt
         iBuASOw2iLX647Cc99V08sr3iRyxHoNSqDeAM07PN9VbAU8iq0CTDt7Hwh33AatJq0Dl
         BKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gg4noTFSeFvTJ8Mo8nyOZTyHl3bO2/5vd17mquRt/iE=;
        b=ZuDhlYBUl6FptIzekKP2/W/xsyXwmyUUhXRhHW1tVgbRsQT81/linVcSvMlIihkReT
         Qtjt+ZGxga+G6JNnl5f2WsRvV6v/KHESQSzXLJX8jq++frv5Sys5Obr0BB7tEB4ohR1g
         DZI7hOZPf7OBYIgeHwUO+4RS5uoK4ZHld/yoxU/L4K8aV+ixZXrZ8HcKTSx9/J+nBNy7
         JrfX1wBZbro0zksY8k7If4gtkuv0hC7OZfX3kGpiBa3S1L+tVF7Pbp1M9nx35hjeMr9N
         56P1ku7xtFDWKmMuxIBLgf1TsXUzojevgacPSDH9Isa4QToDOfcLaHIUpdG9IbaV5qYh
         stuA==
X-Gm-Message-State: APjAAAUKfLiWsdfkWn1hPdSppH47HzAdOYMzo0uH9oG5e9YiZFonHdsL
        W5fHLBOFZWa1jGZlV2hmzva20gxr
X-Google-Smtp-Source: APXvYqw9FDOsMX1Y3Vc/Q41Voq2Y9QIGVvqRWEgamTBh70buBF2jSj7cY70kYIT/8oBUcpPMxsgM4Q==
X-Received: by 2002:a63:6786:: with SMTP id b128mr30301154pgc.318.1554750141695;
        Mon, 08 Apr 2019 12:02:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i3sm44676474pfa.90.2019.04.08.12.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 12:02:20 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:02:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Message-ID: <20190408190218.GA200740@dtor-ws>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-7-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408142100.27618-7-tbogendoerfer@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 08, 2019 at 04:20:58PM +0200, Thomas Bogendoerfer wrote:
> This patch adds a platform driver for supporting keyboard and mouse
> interface of SGI IOC3 chips.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/input/serio/Kconfig   |  12 +++
>  drivers/input/serio/Makefile  |   1 +
>  drivers/input/serio/ioc3kbd.c | 183 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/input/serio/ioc3kbd.c
> 
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index c9c7224d5ae0..ceb89d8b785d 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -164,6 +164,18 @@ config SERIO_MACEPS2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called maceps2.
>  
> +config SERIO_SGI_IOC3
> +	tristate "SGI IOC3 PS/2 controller"
> +	depends on SGI_MFD_IOC3
> +	help
> +	  Say Y here if you have an SGI Onyx2, SGI Octane or IOC3 PCI card
> +	  and you want to attach and use a keyboard, mouse, or both.
> +
> +	  Do not use on an SGI Origin 2000, as the IO6 board in those
> +	  systems lacks the necessary PS/2 ports.  You will need to add
> +	  an IOC3 PCI card (CADduo) via a PCI Shoehorn XIO card or the
> +	  PCI Cardcage (shoebox) first.

To compile this driver as a module...

> +
>  config SERIO_LIBPS2
>  	tristate "PS/2 driver library"
>  	depends on SERIO_I8042 || SERIO_I8042=n
> diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
> index 67950a5ccb3f..6d97bad7b844 100644
> --- a/drivers/input/serio/Makefile
> +++ b/drivers/input/serio/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_HIL_MLC)		+= hp_sdc_mlc.o hil_mlc.o
>  obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
>  obj-$(CONFIG_SERIO_PS2MULT)	+= ps2mult.o
>  obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
> +obj-$(CONFIG_SERIO_SGI_IOC3)	+= ioc3kbd.o
>  obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
>  obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
>  obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
> diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
> new file mode 100644
> index 000000000000..8ff46a9f3d98
> --- /dev/null
> +++ b/drivers/input/serio/ioc3kbd.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SGI IOC3 PS/2 controller driver for linux
> + *
> + * Copyright (C) 2019 Thomas Bogendoerfer <tbogendoerfer@suse.de>
> + *
> + * Based on code Copyright (C) 2005 Stanislaw Skowronek <skylark@unaligned.org>
> + *               Copyright (C) 2009 Johannes Dickgreber <tanzy@gmx.de>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/serio.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/sn/ioc3.h>
> +
> +struct ioc3kbd_data {
> +	struct ioc3_serioregs __iomem *regs;
> +	struct serio *kbd, *aux;
> +};
> +
> +static int ioc3kbd_write(struct serio *dev, u8 val)
> +{
> +	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(dev->port_data);

serio->port_data is void pointer, no need to cast.

> +	unsigned long timeout = 0;
> +	u32 mask;
> +
> +	mask = (dev == d->aux) ? KM_CSR_M_WRT_PEND : KM_CSR_K_WRT_PEND;
> +	while ((readl(&d->regs->km_csr) & mask) && (timeout < 1000)) {
> +		udelay(100);
> +		timeout++;
> +	}
> +
> +	if (dev == d->aux)
> +		writel(((u32)val) & 0x000000ff, &d->regs->m_wd);
> +	else
> +		writel(((u32)val) & 0x000000ff, &d->regs->k_wd);

Why do you need to mask the upper bits if you start with u8? Can you
just say:

	writel(val, dev == d->aux ? &d->regs->m_wd, &d->regs->k_wd);


> +
> +	if (timeout >= 1000)
> +		return -1;

So you attempt to write even if controller indicates that it is busy?

> +	return 0;
> +}
> +
> +static irqreturn_t ioc3kbd_intr(int itq, void *dev_id)
> +{
> +	struct ioc3kbd_data *d = dev_id;
> +	u32 data_k, data_m;
> +
> +	data_k = readl(&d->regs->k_rd);
> +	data_m = readl(&d->regs->m_rd);
> +
> +	if (data_k & KM_RD_VALID_0)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
> +	if (data_k & KM_RD_VALID_1)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
> +	if (data_k & KM_RD_VALID_2)
> +		serio_interrupt(d->kbd,
> +		(data_k >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_0)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_0_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_1)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_1_SHIFT) & 0xff, 0);
> +	if (data_m & KM_RD_VALID_2)
> +		serio_interrupt(d->aux,
> +		(data_m >> KM_RD_DATA_2_SHIFT) & 0xff, 0);
> +
> +	return 0;
> +}
> +
> +static int ioc3kbd_open(struct serio *dev)
> +{
> +	return 0;
> +}
> +
> +static void ioc3kbd_close(struct serio *dev)
> +{
> +	/* Empty */
> +}

You do not need empty stubs.

> +
> +static struct ioc3kbd_data *ioc3kbd_alloc_port(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ioc3_serioregs __iomem *regs;
> +	struct ioc3kbd_data *d;
> +	struct serio *sk, *sa;
> +	struct resource *mem;
> +	int irq;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return NULL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return NULL;
> +
> +	regs = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
> +	if (!regs)
> +		return NULL;
> +
> +	sk = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!sk)
> +		return NULL;
> +
> +	sa = devm_kzalloc(dev, sizeof(struct serio), GFP_KERNEL);
> +	if (!sa)
> +		return NULL;

serio ports are refcounted, they must not be allocated with devm_* API
as their lifetime may extend past the remove() time.

> +
> +	d = devm_kzalloc(dev, sizeof(struct ioc3kbd_data),
> +			 GFP_KERNEL);
> +	if (!d)
> +		return NULL;
> +
> +	if (request_irq(irq, ioc3kbd_intr, IRQF_SHARED, "ioc3-kbd", d))
> +		return NULL;

This is unfortunate that you lose error code. You also fail to handle
-EPROPE_DEFER from request_irq().

> +
> +	sk->id.type = SERIO_8042;
> +	sk->write = ioc3kbd_write;
> +	sk->open = ioc3kbd_open;
> +	sk->close = ioc3kbd_close;
> +	snprintf(sk->name, sizeof(sk->name), "IOC3 keyboard %d", pdev->id);
> +	snprintf(sk->phys, sizeof(sk->phys), "ioc3/serio%dkbd", pdev->id);
> +	sk->port_data = d;
> +	sk->dev.parent = &pdev->dev;
> +
> +	sa->id.type = SERIO_8042;
> +	sa->write = ioc3kbd_write;
> +	sa->open = ioc3kbd_open;
> +	sa->close = ioc3kbd_close;
> +	snprintf(sa->name, sizeof(sa->name), "IOC3 auxiliary %d", pdev->id);
> +	snprintf(sa->phys, sizeof(sa->phys), "ioc3/serio%daux", pdev->id);
> +	sa->port_data = d;
> +	sa->dev.parent = dev;
> +
> +	d->regs = regs;
> +	d->kbd = sk;
> +	d->aux = sa;
> +	return d;
> +}
> +
> +static int ioc3kbd_probe(struct platform_device *pdev)
> +{
> +	struct ioc3kbd_data *d;
> +
> +	d = ioc3kbd_alloc_port(pdev);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, d);
> +	serio_register_port(d->kbd);
> +	serio_register_port(d->aux);
> +
> +	return 0;
> +}
> +
> +static int ioc3kbd_remove(struct platform_device *pdev)
> +{
> +	struct ioc3kbd_data *d = platform_get_drvdata(pdev);
> +
> +	serio_unregister_port(d->kbd);
> +	serio_unregister_port(d->aux);
> +	return 0;
> +}
> +
> +static struct platform_driver ioc3kbd_driver = {
> +	.probe          = ioc3kbd_probe,
> +	.remove         = ioc3kbd_remove,
> +	.driver = {
> +		.name = "ioc3-kbd",
> +	},
> +};
> +module_platform_driver(ioc3kbd_driver);
> +
> +MODULE_AUTHOR("Stanislaw Skowronek <skylark@unaligned.org>");
> +MODULE_DESCRIPTION("SGI IOC3 serio driver");
> +MODULE_LICENSE("GPL");

"GPL v2" to match SPDX header?

> -- 
> 2.13.7
> 

Thanks.

-- 
Dmitry
