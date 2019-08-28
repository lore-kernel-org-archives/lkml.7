Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A882FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77322CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567004215;
	bh=ocUoAce5ZZaFNR62sOcRYzKz9K9Hwbn+5znsPQxfoYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cNqHU4aZa8RpoAXRRESt0kIksEYiUshw1avdHFEja4ltzllYH2xW2j2MXSlnA2z45
	 5W50HUIEvHjmGXtfEuZtfhp6w42J06Os2EX+O08iraQ4BVFy4gc80pbFMwzJ4RAPVd
	 RSt1QrfLtYK1PiAQ9XDxzGNju3CPKF6+Y0JU4TKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1O4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:56:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40327 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfH1O4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:56:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id u29so2430806lfk.7;
        Wed, 28 Aug 2019 07:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4msxB+UbIJYyNA6xXQj3YNqPZ79E+SHoUJgVUP/Phn8=;
        b=lrT7z3MApfHeSTbHHw+0gB4fDP7Cxwh5FhIL93/zL3G0CugKuLlBUWPS/IPxzHRLcE
         50CM44GyZ1MGwCprEVVCNjQG6ZrUbUruPJElvlGrHQaOSGQUkbPMjcvyZxWNUFLi91a5
         u6TOjvhohdOdWTCvo3LP6tzY1+f5I1RpvicvOvHAF7z8eCfrFa0vz5oA4TmV6ddbtxWV
         FlFgvTRIYNk08pzmE1wcyrRR6xraLQwBpFcjSOPdM+LSmpO4GbBV6EBc8AxqMt/6mkKS
         0BSbFX5k67J895PbSC92s/a2roBM14b7jA0dEL8S8qVofiwk/IMzhazBSWg97KMRXYK3
         bshQ==
X-Gm-Message-State: APjAAAXop0lfWDRuVhoGmEcvIg24avgOu6KZIFaXKjw0O/97DEtVvWhr
        +5eMgxshF5UsnOpJcqcJtjY=
X-Google-Smtp-Source: APXvYqx1Cz42VxOrRDnB4OzraidNFWBdo0cx+wctwMb9as7qxgylxMURf588p50shHRdE4zkEd5D2Q==
X-Received: by 2002:a19:c20b:: with SMTP id l11mr2896160lfc.106.1567004211516;
        Wed, 28 Aug 2019 07:56:51 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id z128sm888495lfa.1.2019.08.28.07.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:56:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i2zNP-0008DY-Fk; Wed, 28 Aug 2019 16:56:47 +0200
Date:   Wed, 28 Aug 2019 16:56:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 1/6] USB: serial: f81232: Add F81534A support
Message-ID: <20190828145647.GH13017@localhost>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-2-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559789656-15847-2-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:54:11AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device.
> It's most same with F81232, the UART device is difference as follow:
> 	1. TX/RX bulk size is 128/512bytes
> 	2. RX bulk layout change:
> 		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 		F81534A:[LEN][Data.....][LSR]
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 153 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 144 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 43fa1f0716b7..84efcc66aa56 100644
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
> @@ -22,7 +23,20 @@
>  #include <linux/serial_reg.h>
>  
>  static const struct usb_device_id id_table[] = {
> +	/* F81232 */
>  	{ USB_DEVICE(0x1934, 0x0706) },
> +
> +	/* F81532A/534A/535/536 */
> +	{ USB_DEVICE(0x2c42, 0x1602) },		/* In-Box 2 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1604) },		/* In-Box 4 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1605) },		/* In-Box 8 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1606) },		/* In-Box 12 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1608) },		/* Non-Flash type */
> +
> +	{ USB_DEVICE(0x2c42, 0x1632) },		/* 2 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1634) },		/* 4 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1635) },		/* 8 port UART device */
> +	{ USB_DEVICE(0x2c42, 0x1636) },		/* 12 port UART device */
>  	{ }					/* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);
> @@ -61,15 +75,25 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
>  #define F81232_CLK_MASK			GENMASK(1, 0)
>  
> +#define F81534A_MODE_CONF_REG		0x107
> +#define F81534A_TRIGGER_MASK		GENMASK(3, 2)
> +#define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
> +#define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
> +
> +#define F81232_F81232_TYPE		1
> +#define F81232_F81534A_TYPE		2
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
>  	u8 modem_status;
>  	u8 shadow_lcr;
> +	u8 device_type;
>  	speed_t baud_base;
>  	struct work_struct lsr_work;
>  	struct work_struct interrupt_work;
>  	struct usb_serial_port *port;
> +	void (*process_read_urb)(struct urb *urb);
>  };
>  
>  static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
> @@ -376,6 +400,78 @@ static void f81232_process_read_urb(struct urb *urb)
>  	tty_flip_buffer_push(&port->port);
>  }
>  
> +static void f81534a_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
> +	unsigned char *data = urb->transfer_buffer;
> +	char tty_flag;
> +	unsigned int i;
> +	u8 lsr;
> +	u8 len;
> +
> +	if (urb->status) {
> +		dev_err(&port->dev, "urb->status: %d\n", urb->status);

Please use proper error messages in English (not C) here and throughout.

But this one isn't needed since it should have been checked by the
completion handler.

> +		return;
> +	}
> +
> +	if (!urb->actual_length) {
> +		dev_err(&port->dev, "urb->actual_length == 0\n");
> +		return;
> +	}
> +
> +	len = data[0];
> +	if (len != urb->actual_length) {
> +		dev_err(&port->dev, "len(%d) != urb->actual_length(%d)\n", len,
> +				urb->actual_length);
> +		return;
> +	}
> +
> +	/* bulk-in data: [LEN][Data.....][LSR] */
> +	tty_flag = TTY_NORMAL;
> +
> +	lsr = data[len - 1];

What if len == 1?

> +	if (lsr & UART_LSR_BRK_ERROR_BITS) {
> +		if (lsr & UART_LSR_BI) {
> +			tty_flag = TTY_BREAK;
> +			port->icount.brk++;
> +			usb_serial_handle_break(port);
> +		} else if (lsr & UART_LSR_PE) {
> +			tty_flag = TTY_PARITY;
> +			port->icount.parity++;
> +		} else if (lsr & UART_LSR_FE) {
> +			tty_flag = TTY_FRAME;
> +			port->icount.frame++;
> +		}
> +
> +		if (lsr & UART_LSR_OE) {
> +			port->icount.overrun++;
> +			schedule_work(&priv->lsr_work);
> +			tty_insert_flip_char(&port->port, 0, TTY_OVERRUN);
> +		}
> +	}

Isn't this something mostly shared with f81232r? Refactor?

> +
> +	for (i = 1; i < urb->actual_length - 1; i++) {
> +		if (port->port.console && port->sysrq) {
> +			if (usb_serial_handle_sysrq_char(port, data[i]))
> +				continue;
> +		}
> +
> +		tty_insert_flip_char(&port->port, data[i], tty_flag);

Use tty_insert_flip_string_fixed_char() when not a console.

> +	}
> +
> +	tty_flip_buffer_push(&port->port);
> +}
> +
> +static void f81232_read_urb_proxy(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
> +
> +	if (priv->process_read_urb)
> +		priv->process_read_urb(urb);
> +}

No, please add a proper usb-serial subdriver (to this file) rather
than reimplement this type abstraction yourself.

> +
>  static void f81232_break_ctl(struct tty_struct *tty, int break_state)
>  {
>  	struct usb_serial_port *port = tty->driver_data;
> @@ -487,13 +583,28 @@ static void f81232_set_baudrate(struct tty_struct *tty,
>  
>  static int f81232_port_enable(struct usb_serial_port *port)
>  {
> +	struct f81232_private *port_priv = usb_get_serial_port_data(port);
>  	u8 val;
>  	int status;
>  
> -	/* fifo on, trigger8, clear TX/RX*/
> -	val = UART_FCR_TRIGGER_8 | UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
> -			UART_FCR_CLEAR_XMIT;
> +	if (port_priv->device_type != F81232_F81232_TYPE) {
> +		val = F81534A_TRIGGER_MULTPILE_4X | F81534A_FIFO_128BYTE;
> +		status = f81232_set_mask_register(port, F81534A_MODE_CONF_REG,
> +				F81534A_TRIGGER_MASK | F81534A_FIFO_128BYTE,
> +				val);
> +		if (status) {
> +			dev_err(&port->dev, "failed to set MODE_CONF_REG: %d\n",
> +					status);
> +			return status;
> +		}
> +
> +		val = UART_FCR_TRIGGER_14;
> +	} else {
> +		val = UART_FCR_TRIGGER_8;
> +	}
>  
> +	/* fifo on, clear TX/RX */
> +	val |= UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
>  	status = f81232_set_register(port, FIFO_CONTROL_REGISTER, val);
>  	if (status) {
>  		dev_err(&port->dev, "%s failed to set FCR: %d\n",
> @@ -631,6 +742,16 @@ static int f81232_tiocmset(struct tty_struct *tty,
>  	return f81232_set_mctrl(port, set, clear);
>  }
>  
> +static void f81232_detect_device_type(struct usb_serial_port *port)
> +{
> +	struct f81232_private *port_priv = usb_get_serial_port_data(port);
> +
> +	if (port->serial->dev->descriptor.idProduct == 0x0706)

Missing le16_to_cpu()

Customers cannot set their own device ids?

Not needed with subdriver anyway.

> +		port_priv->device_type = F81232_F81232_TYPE;
> +	else
> +		port_priv->device_type = F81232_F81534A_TYPE;
> +}
> +
>  static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
>  {
>  	int result;
> @@ -731,6 +852,7 @@ static void f81232_lsr_worker(struct work_struct *work)
>  static int f81232_port_probe(struct usb_serial_port *port)
>  {
>  	struct f81232_private *priv;
> +	int status = 0;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -741,11 +863,26 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
>  
>  	usb_set_serial_port_data(port, priv);
> +	f81232_detect_device_type(port);
>  
>  	port->port.drain_delay = 256;
>  	priv->port = port;
>  
> -	return 0;
> +	switch (priv->device_type) {
> +	case F81232_F81534A_TYPE:
> +		priv->process_read_urb = f81534a_process_read_urb;
> +		break;
> +
> +	case F81232_F81232_TYPE:
> +		priv->process_read_urb = f81232_process_read_urb;
> +		break;
> +
> +	default:
> +		status = -ENODEV;
> +		break;
> +	}
> +
> +	return status;
>  }
>  
>  static int f81232_port_remove(struct usb_serial_port *port)
> @@ -797,12 +934,10 @@ static int f81232_resume(struct usb_serial *serial)
>  static struct usb_serial_driver f81232_device = {
>  	.driver = {
>  		.owner =	THIS_MODULE,
> -		.name =		"f81232",
> +		.name =		"f81232/f81534a",
>  	},
>  	.id_table =		id_table,
>  	.num_ports =		1,
> -	.bulk_in_size =		256,
> -	.bulk_out_size =	256,

Why change this?

>  	.open =			f81232_open,
>  	.close =		f81232_close,
>  	.dtr_rts =		f81232_dtr_rts,
> @@ -813,7 +948,7 @@ static struct usb_serial_driver f81232_device = {
>  	.tiocmget =		f81232_tiocmget,
>  	.tiocmset =		f81232_tiocmset,
>  	.tiocmiwait =		usb_serial_generic_tiocmiwait,
> -	.process_read_urb =	f81232_process_read_urb,
> +	.process_read_urb =	f81232_read_urb_proxy,
>  	.read_int_callback =	f81232_read_int_callback,
>  	.port_probe =		f81232_port_probe,
>  	.port_remove =		f81232_port_remove,
> @@ -828,7 +963,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  
>  module_usb_serial_driver(serial_drivers, id_table);
>  
> -MODULE_DESCRIPTION("Fintek F81232 USB to serial adaptor driver");
> +MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
>  MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
>  MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
>  MODULE_LICENSE("GPL v2");

Johan
