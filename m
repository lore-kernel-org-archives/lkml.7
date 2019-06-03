Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D16C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2BA27F9A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559566337;
	bh=zyv0y4s+sWydaJNrDCxdSRUebGQM6D5ELmyN+Ps7OFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LJXdrskO5FET/R2cdT2UcelhgK2cqIgsrLT2QWSJbZmgzaGbH9xj21k3V/VIxQxRc
	 SpCQP6/ejlPR+wRQI9d52IoqhRo9jZ6rkhwvXwpa/1EJCGMAz8Zz8+UnlZliPLqMlF
	 HpKW5nZGXRBL5B++1AShmy3HJGyhAqO1pOT8+/tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfFCMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:52:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39105 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfFCMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:52:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so12829283ljf.6;
        Mon, 03 Jun 2019 05:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGkFenkwMGaaLD16+YxeC+kJmYfoP9EoELjesZivVB0=;
        b=P2WpIJOSUKvCkBPQX7l37xnowPpH7AMXxpooE6pt/z+6QncoBlZlJFBCCn1JSoSKE1
         ZM4IW41pEY8GmZ83Oki3KrIXNLdFakGr3Gc3psJVV3r1nyR1ugs15j/NFWxPiqHNN+iX
         CZ6hcgj9lpT0v7pboN3mXtzLsRx13PDRSdVDuzAU53YT10au5q1Jd101FFVxXfBNg624
         EeCManENPqCE2rsdwEWzCsXQeBQB3t9yQGoc0CEkkY0AuIyj4S/6WZJNTG+22fxyh/+s
         MUYplmJKgzMLmlRBDJXNSQgu+yeLqWA0uFIu/ULXf+IqnixPGf7E6yplvm0cryZuOOPX
         Bcfw==
X-Gm-Message-State: APjAAAWv0Gkqltr/tA8UMDMyFJtjzXc138lNAmVG3zzRRcyDs1AeZOQG
        A/SpjCSAnKafuzBvISNL8ZM=
X-Google-Smtp-Source: APXvYqy7lILWKagoVHkjhrQYingcEd8xliPj9Nt0QfL90XSKKRft5dTG8auEEA2tcQCh/qa7t/p8+g==
X-Received: by 2002:a2e:2998:: with SMTP id p24mr4190390ljp.188.1559566329208;
        Mon, 03 Jun 2019 05:52:09 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l15sm3160311lji.5.2019.06.03.05.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 05:52:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hXmRZ-0003ZZ-Hc; Mon, 03 Jun 2019 14:52:05 +0200
Date:   Mon, 3 Jun 2019 14:52:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cp210x: Add cp2108 GPIOs support
Message-ID: <20190603125205.GC3668@localhost>
References: <20190514105358.18818-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514105358.18818-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 01:53:57PM +0300, Serge Semin wrote:
> Each chip from the cp210x series got GPIOs on board. This commit
> provides the support for sixteen ones placed on the cp2108 four-ports
> serial console controller. All of the GPIOs are equally distributed
> to four USB interfaces in accordance with GPIOs alternative functions
> attachment.
> 
> cp2108 GPIOs can be either in open-drain or push-pull modes setup once
> after reset was cleared. In this matter it doesn't differ from the rest
> of cp210x devices supported by the driver. So with minor alterations the
> standard output/intput GPIO interface is implemented for cp2108.
> 
> Aside from traditional GPIO functions like setting/getting pins value,
> each GPIO is also multiplexed with alternative functions: TX/RX LEDs, RS485
> TX-enable and Clocks source. These functions can't be activated on-fly.
> Instead the chips firmware should be properly setup, so they would be
> enabled in the ports-config structure at the controller logic startup.
> Needless to say, that when the alternative functions are activated,
> the GPIOs can't be used. Thus we need to check the GPIO pin config in the
> request callback and deny the request if GPIO standard function is
> disabled.

Thanks for the patch.

I'm a bit worried about the logic getting too convoluted when dealing
with the cp2108 and cp2105 differences. Please see if you can do
something about that.

Other than that, just some minor comments and request for
clarifications.

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/usb/serial/Kconfig  |   2 +-
>  drivers/usb/serial/cp210x.c | 158 ++++++++++++++++++++++++++++++++----
>  2 files changed, 143 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index 7d031911d04e..20bd4c0632c7 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -138,7 +138,7 @@ config USB_SERIAL_DIGI_ACCELEPORT
>  config USB_SERIAL_CP210X
>  	tristate "USB CP210x family of UART Bridge Controllers"
>  	help
> -	  Say Y here if you want to use a CP2101/CP2102/CP2103 based USB
> +	  Say Y here if you want to use a CP2101/2/3/4/5/8 based USB

Please drop this since it's a separate change. If anything we should
probably just change this to "CP210X" not have to worry about it getting
outdated again.

>  	  to RS232 converters.
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 979bef9bfb6b..a97f04d9e99f 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -505,6 +505,56 @@ struct cp210x_gpio_write {
>  	u8	state;
>  } __packed;
>  
> +/* CP2108 interfaces, gpio (per interface), port-blocks number, GPIO block. */
> +#define CP2108_IFACE_NUM		4
> +#define CP2108_GPIO_NUM			4
> +#define CP2108_PB_NUM			5
> +#define CP2108_GPIO_PB			1

Please try to give these more descriptive names; I'd prefer COUNT over
NUM when used as a suffix.

Perhaps slap an INDEX suffix on CP2108_GPIO_PB etc.

> +/*
> + * CP2108 default pins state. There are five PBs. Each one is with its specific
> + * pins-set (see USB Express SDK sources or SDK-based smt application
> + * https://github.com/fancer/smt-cp210x for details).
> + */
> +struct cp2108_state {
> +	__le16	mode[CP2108_PB_NUM];	/* 0 - Open-Drain, 1 - Push-Pull */
> +	__le16	low_power[CP2108_PB_NUM];
> +	__le16	latch[CP2108_PB_NUM];	/* 0 - Logic Low, 1 - Logic High */
> +} __packed;

Ok, so you use mode[CP2108_GPIO_PB] to get the pin modes below;
what are the other "PB"s used for? Why is it a "port" block, if all 16
pins allocated to four different ports are accessible through one block?

Please try to make the comment self-contained (even if you leave some
details out). And perhaps we shouldn't refer to proprietary code in
here, and in any case the link may go away.

> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 73 bytes.
> + * Reset/Suspend latches describe default states after reset/suspend of the
> + * pins. The rest are responsible for alternate functions settings of the
> + * chip pins (see USB Express SDK sources or SDK-based smt application
> + * https://github.com/fancer/smt-cp210x for details).
> + */
> +struct cp2108_config {
> +	struct cp2108_state reset_latch;
> +	struct cp2108_state suspend_latch;
> +	u8	ip_delay[CP2108_IFACE_NUM];
> +	u8	enhanced_fxn[CP2108_IFACE_NUM];
> +	u8	enhanced_fxn_dev;
> +	u8	ext_clock_freq[CP2108_IFACE_NUM];
> +} __packed;
> +
> +/* CP2108 port alternate functions fields */
> +#define CP2108_GPIO_TXLED_MODE		BIT(0)
> +#define CP2108_GPIO_RXLED_MODE		BIT(1)
> +#define CP2108_GPIO_RS485_MODE		BIT(2)
> +#define CP2108_GPIO_RS485_LOGIC		BIT(3)
> +#define CP2108_GPIO_CLOCK_MODE		BIT(4)
> +#define CP2108_DYNAMIC_SUSPEND		BIT(5)

No GPIO infix?

> +
> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes
> + * to CP2108 controller.
> + */
> +struct cp2108_gpio_write {
> +	__le16	mask;
> +	__le16	state;
> +} __packed;

No need for __packed (yes, I know there are other unnecessary __packed
in this file).

>  /*
>   * Helper to get interface number when we only have struct usb_serial.
>   */
> @@ -1366,10 +1416,15 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	u8 req_type = REQTYPE_DEVICE_TO_HOST;
> -	int result;
> -	u8 buf;
> -
> -	if (priv->partnum == CP210X_PARTNUM_CP2105)
> +	union {
> +		u8 single;
> +		__le16 dual;
> +	} buf;

I wonder if this would become more readable if you just use u16,
initialise to zero, read one byte unless cp2108, and then
unconditionally do le16_to_cpus() before applying the mask.

I want to keep the number of conditionals down, but if the logic is
getting to hard to follow because cp2105 and cp2108 doing things
differently we may need to add dedicated cp2108 (and maybe cp2105)
get/set callbacks instead.

> +	int result, bufsize = sizeof(buf.single);

One declaration per line please, especially when initialising.

> +
> +	if (priv->partnum == CP210X_PARTNUM_CP2108)
> +		bufsize = sizeof(buf.dual);
> +	else if (priv->partnum == CP210X_PARTNUM_CP2105)
>  		req_type = REQTYPE_INTERFACE_TO_HOST;
>  
>  	result = usb_autopm_get_interface(serial->interface);
> @@ -1377,39 +1432,51 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  		return result;
>  
>  	result = cp210x_read_vendor_block(serial, req_type,
> -					  CP210X_READ_LATCH, &buf, sizeof(buf));
> +					  CP210X_READ_LATCH, &buf, bufsize);
>  	usb_autopm_put_interface(serial->interface);
>  	if (result < 0)
>  		return result;
>  
> -	return !!(buf & BIT(gpio));
> +	if (priv->partnum == CP210X_PARTNUM_CP2108)
> +		result = !!(le16_to_cpu(buf.dual) & BIT(gpio));
> +	else
> +		result = !!(buf.single & BIT(gpio));
> +
> +	return result;
>  }
>  
>  static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  {
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> -	struct cp210x_gpio_write buf;
>  	int result;
>  
> -	if (value == 1)
> -		buf.state = BIT(gpio);
> -	else
> -		buf.state = 0;
> -
> -	buf.mask = BIT(gpio);
> -
>  	result = usb_autopm_get_interface(serial->interface);
>  	if (result)
>  		goto out;
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +	if (priv->partnum == CP210X_PARTNUM_CP2108) {
> +		struct cp2108_gpio_write buf;
> +
> +		buf.state = ((value == 1) ? cpu_to_le16(BIT(gpio)) : 0);
> +		buf.mask = cpu_to_le16(BIT(gpio));
> +
> +		result = cp210x_write_vendor_block(serial,
> +						   REQTYPE_HOST_TO_DEVICE,
> +						   CP210X_WRITE_LATCH, &buf,
> +						   sizeof(buf));
> +	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		struct cp210x_gpio_write buf;
> +
> +		buf.state = ((value == 1) ? BIT(gpio) : 0);
> +		buf.mask = BIT(gpio);
> +
>  		result = cp210x_write_vendor_block(serial,
>  						   REQTYPE_HOST_TO_INTERFACE,
>  						   CP210X_WRITE_LATCH, &buf,
>  						   sizeof(buf));
>  	} else {
> -		u16 wIndex = buf.state << 8 | buf.mask;
> +		u16 wIndex = ((value == 1) ? BIT(gpio) : 0) << 8 | BIT(gpio);

This is way I try to avoid the ternary operator; too easy to write
overly compact code. Please untangle again.

>  		result = usb_control_msg(serial->dev,
>  					 usb_sndctrlpipe(serial->dev, 0),
> @@ -1489,6 +1556,62 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
>  	return -ENOTSUPP;
>  }
>  
> +/*
> + * CP2108 got 16 GPIOs, each of which can be configured either as input, or
> + * as open-drain with weak pulling up to VIO or as push-pull with strong
> + * pulling up to VIO. Similar to the rest of devices the open-drain mode
> + * with latch set high is treated as input mode. All GPIOs are equally
> + * distributed between four interfaces. Thanks to the mask-state based
> + * write-latch control message we don't need to worry about possible races.
> + */
> +static int cp2108_gpioconf_init(struct usb_serial *serial)
> +{
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +	struct cp2108_config config;
> +	u16 mode, latch;
> +	u8 intf_num;
> +	int result;
> +
> +	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_GET_PORTCONFIG, &config,
> +					  sizeof(config));
> +	if (result < 0)
> +		return result;
> +
> +	/*
> +	 * There are four interfaces with four GPIOs for each port. Here we
> +	 * parse the device config data to comply with the driver interface.
> +	 * Note that the mode can be changed only after reset, which cause
> +	 * the driver reloading anyway. So we can safely read the config just
> +	 * once at attach procedure.
> +	 */
> +	intf_num = cp210x_interface_num(serial);
> +	mode = le16_to_cpu(config.reset_latch.mode[CP2108_GPIO_PB]);
> +	latch = le16_to_cpu(config.reset_latch.latch[CP2108_GPIO_PB]);
> +
> +	priv->gpio_altfunc = config.enhanced_fxn[intf_num];

Missing sanity check on intf_num.

> +	priv->gpio_pushpull = (mode >> (intf_num*CP2108_GPIO_NUM)) & 0x0f;
> +	priv->gpio_input = (latch >> (intf_num*CP2108_GPIO_NUM)) & 0x0f;

Missing spaces around multiplication operators.

> +
> +	/*
> +	 * Move the GPIO clock alternative function bit value to the fourth bit
> +	 * as the corresponding GPIO pin reside. It shall make the generic
> +	 * cp210x GPIO request method being suitable for cp2108 as well.
> +	 */

This isn't entirely clear, please try to rephrase.

Which functions are available on which pins? Do the function defines
need to be renamed to reflect the pin numbers as for CP2104?

> +	priv->gpio_altfunc &= ~BIT(3);
> +	if (priv->gpio_altfunc & CP2108_GPIO_CLOCK_MODE)
> +		priv->gpio_altfunc |= BIT(3);
> +
> +	/*
> +	 * Open-drain mode in combination with a high latch value is used
> +	 * to emulate the GPIO input pin.
> +	 */
> +	priv->gpio_input &= ~priv->gpio_pushpull;

Input mode should only be set when the reset latch value is 1 (see
cp2104).

> +	priv->gc.ngpio = CP2108_GPIO_NUM;

Probably better to just use 4 directly instead of this define in this
function (e.g. your mask above implicitly depends on it anyway).

> +	return 0;
> +}

Johan
