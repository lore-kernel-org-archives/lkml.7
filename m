Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8492C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540D8206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVZ1TpAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEGLtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:49:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54367 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGLtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:49:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id b10so20130796wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WaB9FrChMlT+hKDw9IPExf1c79Rgm6Ezzn05/0LC6oE=;
        b=HVZ1TpAkoj5uGcpHvFQuMURkx8qCxk33cIXBSrUp/e84yoTlMW1DQA2+i49XI5z5k/
         vGUG7FCrQvQokOBOeXJHMHDKPgNKQO/vK2Teod7QHyjeljZmNLHyA3jQasizRcTTXvH5
         tcZxFanueqsTeA+Ja0eKZSOzvfVMlvrbxLywb5Bx/g5aSYFh+6f/V+HmZvcsZQ2+HLV9
         KxLYHD8LqtPgTuAWrNQlQa7mxcf8j0Rblg5JudPGg9zkxcfwMr2xYa9eaaekSpTMDmos
         X0TqTcLCD70wLg09+AMnwFyG0M98dZCrn/e1uLBvg2NqNIZxT2iYjjYIOgAIS66t8Ogt
         zjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WaB9FrChMlT+hKDw9IPExf1c79Rgm6Ezzn05/0LC6oE=;
        b=ZHHlLAiu+gVLA2vmWSg/hExUYO5L7e/rz0bBfjZpKJ3KwFEc3L50hpVpopdMYQVGo/
         9YognQ1eNddJpZz0Qntk3EuPxbNULMGP/HBYxxCvAqypf46TpuRxkYodm4md774FVOeZ
         HvnRDVfkn61keVxDIdhF+TD7fpT8JxKtyYlfnGGUqH626CtcdP8tG9Jt3rqc+ndUZ5dK
         QTwNul7D3cOACwRPXRh+QRlu05ucoUo3PT65iEnpZY4BlWfllq5zZrKGl0DEs2EyJboy
         zHp7wbvEscTLkECr+c/QbEdGq0aFjWNem5obetr/EOWFC5Si3MD07ZulTqw6b070j7OP
         a1qw==
X-Gm-Message-State: APjAAAX1HHzHFe+ucbl2kxHNSmgzQVEA9Y18FFuJ/vUWvRLH34ItIhUp
        31mnMFmnp436jq/WKSaHzKVvKg==
X-Google-Smtp-Source: APXvYqzoS0C54HO6RQmx/tdz86kSEEnHfi+Bn9M5bbK4QmlFjUCeFT/JMmBPVDeRAe1LtkX1D6dKdg==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr12726066wmb.101.1557229747724;
        Tue, 07 May 2019 04:49:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d14sm11395878wre.78.2019.05.07.04.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 04:49:07 -0700 (PDT)
Date:   Tue, 7 May 2019 12:49:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Esben Haabendal <esben@geanix.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190507114905.GB29524@dell>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-3-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426084038.6377-3-esben@geanix.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Esben Haabendal wrote:

> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
> to an MFD driver.
> 
> When calling mfd_add_device(), platform_data should be a pointer to a
> struct plat_serial8250_port, with proper settings like .flags, .type,
> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
> passed as cell resources.

What?  No, please!

If you *must* create a whole driver just to be able to use
platform_*() helpers (which I don't think you should), then please
call it something else.  This doesn't have anything to do with MFD.

> Do not include UPF_BOOT_AUTOCONF in platform_data.flags.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/tty/serial/8250/8250_mfd.c | 119 +++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |  12 ++++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_mfd.c
> 
> diff --git a/drivers/tty/serial/8250/8250_mfd.c b/drivers/tty/serial/8250/8250_mfd.c
> new file mode 100644
> index 0000000..eae1566
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_mfd.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Serial Port driver for 8250/16550-type MFD sub devices
> + *
> + *  This mimics the serial8250_probe of 8250_core.c, while allowing
> + *  use without UPF_BOOT_AUTOCONF, which is problematic for MFD, as
> + *  the request_mem_region() will typically fail as the region is
> + *  already requested by the MFD device.
> + *
> + *  Memory and irq are passed as platform resources, which allows easy
> + *  use together with (devm_)mfd_add_devices().
> + *
> + *  Other parameters are passed as struct plat_serial8250_port in
> + *  device platform_data.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/serial_8250.h>
> +
> +struct serial8250_mfd_data {
> +	int			line;
> +};
> +
> +static int serial8250_mfd_probe(struct platform_device *pdev)
> +{
> +	struct plat_serial8250_port *pdata = dev_get_platdata(&pdev->dev);
> +	struct serial8250_mfd_data *data;
> +	struct uart_8250_port up;
> +	struct resource *r;
> +	void __iomem *membase;
> +
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	memset(&up, 0, sizeof(up));
> +
> +	switch (pdata->iotype) {
> +	case UPIO_AU:
> +	case UPIO_TSI:
> +	case UPIO_MEM32:
> +	case UPIO_MEM32BE:
> +	case UPIO_MEM16:
> +	case UPIO_MEM:
> +		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!r)
> +			return -ENODEV;
> +		membase = devm_ioremap_nocache(&pdev->dev,
> +					       r->start, resource_size(r));
> +		if (!membase)
> +			return -ENOMEM;
> +		up.port.mapbase = r->start;
> +		up.port.membase = membase;
> +		break;
> +	case UPIO_HUB6:
> +	case UPIO_PORT:
> +		r = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +		if (!r)
> +			return -ENODEV;
> +		up.port.iobase = r->start;
> +		break;
> +	}
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	up.port.irq = platform_get_irq(pdev, 0);
> +	if (up.port.irq < 0)
> +		up.port.irq = 0; /* no interrupt -> use polling */
> +
> +	/* Register with 8250_core.c */
> +	up.port.irqflags = pdata->irqflags;
> +	up.port.uartclk = pdata->uartclk;
> +	up.port.regshift = pdata->regshift;
> +	up.port.iotype = pdata->iotype;
> +	up.port.flags = pdata->flags;
> +	up.port.hub6 = pdata->hub6;
> +	up.port.private_data = pdata->private_data;
> +	up.port.type = pdata->type;
> +	up.port.serial_in = pdata->serial_in;
> +	up.port.serial_out = pdata->serial_out;
> +	up.port.handle_irq = pdata->handle_irq;
> +	up.port.handle_break = pdata->handle_break;
> +	up.port.set_termios = pdata->set_termios;
> +	up.port.set_ldisc = pdata->set_ldisc;
> +	up.port.get_mctrl = pdata->get_mctrl;
> +	up.port.pm = pdata->pm;
> +	up.port.dev = &pdev->dev;
> +	data->line = __serial8250_register_8250_port(&up, 0);
> +	if (data->line < 0)
> +		return data->line;
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +}
> +
> +static int serial8250_mfd_remove(struct platform_device *pdev)
> +{
> +	struct serial8250_mfd_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +	return 0;
> +}
> +
> +static struct platform_driver serial8250_mfd_driver = {
> +	.probe = serial8250_mfd_probe,
> +	.remove = serial8250_mfd_remove,
> +	.driver = {
> +		.name = "serial8250-mfd",
> +	},
> +};
> +
> +module_platform_driver(serial8250_mfd_driver);
> +
> +MODULE_AUTHOR("Esben Haabendal <esben@geanix.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Driver for 8250/16550-type MFD sub devices");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 15c2c54..ef1572b 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -58,6 +58,18 @@ config SERIAL_8250_PNP
>  	  This builds standard PNP serial support. You may be able to
>  	  disable this feature if you only need legacy serial support.
>  
> +config SERIAL_8250_MFD
> +	bool "8250/16550 MFD function support"
> +	depends on SERIAL_8250 && MFD_CORE
> +	default n
> +	help
> +	  This builds support for using 8250/16550-type UARTs as MFD
> +	  functions.
> +
> +	  MFD drivers needing this should select it automatically.
> +
> +	  If unsure, say N.
> +
>  config SERIAL_8250_FINTEK
>  	bool "Support for Fintek F81216A LPC to 4 UART RS485 API"
>  	depends on SERIAL_8250
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 18751bc..da8e139 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
>  8250-y					:= 8250_core.o
>  8250-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
> +8250-$(CONFIG_SERIAL_8250_MFD)		+= 8250_mfd.o
>  8250_base-y				:= 8250_port.o
>  8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
