Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A8CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B812064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571824765;
	bh=Jl63sn22HUeiTuGAULZ7jlyfp/Le8UL4Oe9rR2wjoAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IpNrxBo9vyYitkGogiJxxdADUsGU+KJqHqINOo8Y6+xkz+AuJaQ36JHJbGb7IE1CZ
	 KlAL8ZM5EATKK6ok4MRhgcAFiASHd/rNK/U1lHV2CBSlcjWYzAW6YaRCpTVp1adGMR
	 H0q3+rNUI3vzSiAzgbbuHOC5MmO8Ljvf1d4u27ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbfJWJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:59:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33180 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391116AbfJWJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:59:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so20399544ljd.0;
        Wed, 23 Oct 2019 02:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQhlf6ODdZV33blzT/hWiwM5f6nS4rOfJWZJ1GMcjyk=;
        b=KGe1sRCO/V4ejWIsgkTWibuNEJwcpsd2omI3taqrHT2P7pXYHhZYZ0BrsmU56g/4a1
         //3q+Da5JLFscwhZecW1D+puNd8OAxbWeeIq+mKaZxeFZpOEdRSFbb2WTcd7jigagVio
         S+RyAAdw8hZOV/HDm7DBhufMQLq9YSZDuY8SzzbUYKAeNuXWg59JNKEBmuHymikC5QFT
         QWhSdF4ekMrtNHa1ZZin1khiBVWoFZjo+Z78L63cEZ+phGSI4jL6X2ZIWUTjWsIBTqO1
         AByulkMUBPrzK0F8/CWX6dEOD/3ytkLWFnbeFIGd01Oa2PUq11wmBiZkMglmzdVDlOwS
         /s4g==
X-Gm-Message-State: APjAAAU7e0wBBt82KM+hynD0mg02ZqNe3zBPdaC/ekzdYFRd52sy32Ho
        kDTokIkjFLF1IVLo5XSUlSOEzyjI
X-Google-Smtp-Source: APXvYqwl19/Nz4NiGIDwB4Z//N9KPRnYcydmhLgJcR1K/v7Rqn9mWfFNNuYpy7x0VxTWdKysQU3Zig==
X-Received: by 2002:a2e:1214:: with SMTP id t20mr21335348lje.191.1571824759004;
        Wed, 23 Oct 2019 02:59:19 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id o3sm6288136lji.49.2019.10.23.02.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:59:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNDQU-0006hV-EY; Wed, 23 Oct 2019 11:59:34 +0200
Date:   Wed, 23 Oct 2019 11:59:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 4/7] USB: serial: f81232: Add F81534A support
Message-ID: <20191023095934.GT24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-5-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-5-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:46AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
> and the serial port is default disabled when plugin computer.
> 
> The IC is contains devices as following:
> 	1. HUB (all devices is connected with this hub)
> 	2. GPIO/Control device. (enable serial port and control GPIOs)
> 	3. serial port 1 to x (2/4/8/12)
> 
> It's most same with F81232, the UART device is difference as follow:
> 	1. TX/RX bulk size is 128/512bytes
> 	2. RX bulk layout change:
> 		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 		F81534A:[LEN][Data.....][LSR]
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 131 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 127 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index e4db0aec9af0..36a17aedc2ae 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Fintek F81232 USB to serial adaptor driver
> + * Fintek F81532A/534A/535/536 USB to 2/4/8/12 serial adaptor driver
>   *
>   * Copyright (C) 2012 Greg Kroah-Hartman (gregkh@linuxfoundation.org)
>   * Copyright (C) 2012 Linux Foundation
> @@ -21,11 +22,36 @@
>  #include <linux/usb/serial.h>
>  #include <linux/serial_reg.h>
>  
> +#define F81232_ID		\
> +	{ USB_DEVICE(0x1934, 0x0706) }	/* 1 port UART device */
> +
> +#define F81534A_SERIES_ID	\
> +	{ USB_DEVICE(0x2c42, 0x1602) },	/* In-Box 2 port UART device */	\
> +	{ USB_DEVICE(0x2c42, 0x1604) },	/* In-Box 4 port UART device */	\
> +	{ USB_DEVICE(0x2c42, 0x1605) },	/* In-Box 8 port UART device */	\
> +	{ USB_DEVICE(0x2c42, 0x1606) },	/* In-Box 12 port UART device */ \
> +	{ USB_DEVICE(0x2c42, 0x1608) },	/* Non-Flash type */ \
> +	{ USB_DEVICE(0x2c42, 0x1632) },	/* 2 port UART device */ \
> +	{ USB_DEVICE(0x2c42, 0x1634) },	/* 4 port UART device */ \
> +	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
> +	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
> +
>  static const struct usb_device_id id_table[] = {

Add a prefix here as well?

> -	{ USB_DEVICE(0x1934, 0x0706) },
> +	F81232_ID,
> +	{ }					/* Terminating entry */
> +};
> +
> +static const struct usb_device_id f81534a_id_table[] = {
> +	F81534A_SERIES_ID,
> +	{ }					/* Terminating entry */
> +};
> +
> +static const struct usb_device_id all_serial_id_table[] = {

combined_id_table would be a name more in line with the rest of the
drivers, if you end up using this one for the MODULE_DEVICE_TABLE.

> +	F81232_ID,
> +	F81534A_SERIES_ID,
>  	{ }					/* Terminating entry */
>  };
> -MODULE_DEVICE_TABLE(usb, id_table);
> +MODULE_DEVICE_TABLE(usb, all_serial_id_table);
>  
>  /* Maximum baudrate for F81232 */
>  #define F81232_MAX_BAUDRATE		1500000
> @@ -35,6 +61,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define F81232_REGISTER_REQUEST		0xa0
>  #define F81232_GET_REGISTER		0xc0
>  #define F81232_SET_REGISTER		0x40
> +#define F81534A_REGISTER_REQUEST	F81232_REGISTER_REQUEST
> +#define F81534A_GET_REGISTER		F81232_GET_REGISTER
> +#define F81534A_SET_REGISTER		F81232_SET_REGISTER
> +#define F81534A_ACCESS_REG_RETRY	2

This patch doesn't use any of these, and looks like you can just use the
F81232 defines directly anyway.

>  #define SERIAL_BASE_ADDRESS		0x0120
>  #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
> @@ -61,6 +91,11 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
>  #define F81232_CLK_MASK			GENMASK(1, 0)
>  
> +#define F81534A_MODE_CONF_REG		0x107
> +#define F81534A_TRIGGER_MASK		GENMASK(3, 2)
> +#define F81534A_TRIGGER_MULTPILE_4X	BIT(3)

MULTPILE typo?

> +#define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
> @@ -383,6 +418,46 @@ static void f81232_process_read_urb(struct urb *urb)
>  	tty_flip_buffer_push(&port->port);
>  }
>  
> +static void f81534a_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	unsigned char *data = urb->transfer_buffer;
> +	char tty_flag;
> +	unsigned int i;
> +	u8 lsr;
> +	u8 len;
> +
> +	if (urb->actual_length < 3) {
> +		dev_err(&port->dev, "error actual_length: %d\n",

Rephrase as "short message received" or similar.

> +				urb->actual_length);
> +		return;
> +	}
> +
> +	len = data[0];
> +	if (len != urb->actual_length) {
> +		dev_err(&port->dev, "len(%d) != urb->actual_length(%d)\n", len,
> +				urb->actual_length);

Avoid c-expressions in error messages, rephrase this in English (e.g.
unexpected length or similar).

> +		return;
> +	}
> +
> +	/* bulk-in data: [LEN][Data.....][LSR] */
> +	lsr = data[len - 1];
> +	tty_flag = f81232_handle_lsr(port, lsr);
> +
> +	if (port->port.console && port->sysrq) {
> +		for (i = 1; i < urb->actual_length - 1; ++i)

Use len here?

And please add brackets here since the body is a multi-line statement.

> +			if (!usb_serial_handle_sysrq_char(port, data[i]))

Maybe also here.

> +				tty_insert_flip_char(&port->port, data[i],
> +						tty_flag);
> +	} else {
> +		tty_insert_flip_string_fixed_flag(&port->port, &data[1],
> +							tty_flag,
> +							urb->actual_length - 2);

len

> +	}
> +
> +	tty_flip_buffer_push(&port->port);
> +}
> +
>  static void f81232_break_ctl(struct tty_struct *tty, int break_state)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
> @@ -666,6 +741,23 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
>  	return 0;
>  }
>  
> +static int f81534a_open(struct tty_struct *tty, struct usb_serial_port *port)
> +{
> +	int status;
> +	u8 val;
> +
> +	val = F81534A_TRIGGER_MULTPILE_4X | F81534A_FIFO_128BYTE;
> +	status = f81232_set_mask_register(port, F81534A_MODE_CONF_REG,
> +			F81534A_TRIGGER_MASK | F81534A_FIFO_128BYTE, val);

Add also a mask temporary if that can avoid the line break?

> +	if (status) {
> +		dev_err(&port->dev, "failed to set MODE_CONF_REG: %d\n",
> +				status);
> +		return status;
> +	}
> +
> +	return f81232_open(tty, port);
> +}
> +
>  static void f81232_close(struct usb_serial_port *port)
>  {
>  	struct f81232_private *port_priv = usb_get_serial_port_data(port);
> @@ -772,6 +864,11 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  	return 0;
>  }
>  
> +static int f81534a_port_probe(struct usb_serial_port *port)
> +{
> +	return f81232_port_probe(port);
> +}

Maybe wait with adding this one until you need it and use
f18232_port_probe below instead.

> +
>  static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
>  {
>  	struct usb_serial_port *port = serial->port[0];
> @@ -835,14 +932,40 @@ static struct usb_serial_driver f81232_device = {
>  	.resume =		f81232_resume,
>  };
>  
> +static struct usb_serial_driver f81534a_device = {
> +	.driver = {
> +		.owner =	THIS_MODULE,
> +		.name =		"f81534a",
> +	},
> +	.id_table =		f81534a_id_table,
> +	.num_ports =		1,
> +	.open =			f81534a_open,
> +	.close =		f81232_close,
> +	.dtr_rts =		f81232_dtr_rts,
> +	.carrier_raised =	f81232_carrier_raised,
> +	.get_serial =		f81232_get_serial_info,
> +	.break_ctl =		f81232_break_ctl,
> +	.set_termios =		f81232_set_termios,
> +	.tiocmget =		f81232_tiocmget,
> +	.tiocmset =		f81232_tiocmset,
> +	.tiocmiwait =		usb_serial_generic_tiocmiwait,
> +	.tx_empty =		f81232_tx_empty,
> +	.process_read_urb =	f81534a_process_read_urb,
> +	.read_int_callback =	f81232_read_int_callback,
> +	.port_probe =		f81534a_port_probe,
> +	.suspend =		f81232_suspend,
> +	.resume =		f81232_resume,
> +};
> +
>  static struct usb_serial_driver * const serial_drivers[] = {
>  	&f81232_device,
> +	&f81534a_device,
>  	NULL,
>  };
>  
> -module_usb_serial_driver(serial_drivers, id_table);
> +module_usb_serial_driver(serial_drivers, all_serial_id_table);
>  
> -MODULE_DESCRIPTION("Fintek F81232 USB to serial adaptor driver");
> +MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
>  MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
>  MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
>  MODULE_LICENSE("GPL v2");

Johan
