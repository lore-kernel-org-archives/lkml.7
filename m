Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8442C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A7C208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561711749;
	bh=j5/WtkOLfUJei0oLyyPJknu5Fs84sbXt+rnoZ0JDCi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oAmFxxfNQjhwyX0pMBE+qtMvsKPx8NebW4p/E5+EzZe852xoKDTP3ghM9DEUpAABl
	 fnmYJ8IkwcgmgLMU7wAsAtlLGxqqTlvI7Amr1hR7T2Lgs5rBVyCvJPuFE+jB30TX5T
	 aneDwbxyhAgiyQpOz50dclQGbt0Bd1mBlsmCX17A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF1ItI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:49:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfF1ItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:49:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so5185030ljg.5;
        Fri, 28 Jun 2019 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ueeendIGLf70OCoX1OMoqwF0t/dgqXWVYtWS5BaXCTA=;
        b=h1NkDvlMJHNuMhYBrkX4ZxK5pmyvq3dsfE76oYy7jcCatdxtC7ijmtBhvfe1stwtRl
         AvbatzuBvgGXIZ2P8aG8RNX9OzYVUQK8NG0w48aohGHL5IkR1WO9MzKD5T3spiMTO/Nq
         E87Cv9dBeNkRmVgDlYnw0zvujLrmHo4x5xHEpo6JB9fuA3hYCn11y7P1ZVq1cYlgEdVm
         908FklA1njzWsfXr9BAXE/WWbUpsWGCU5p6MyxvGh5jbh3K1rVTOqZvTaTQeUf+9uNaR
         Jrfm2p56aDpl+HGptjWUkJGSrECZri3ET6MSVj6u4EhOr9dBMKsxlrnD58t7kWPWH7RO
         mlUg==
X-Gm-Message-State: APjAAAWgWUoU1X0hVIphsuWQi+D8gb/prLhk1mUXrL1gVWOh3xQ6Rbfs
        cvwzsAwyeSpnFGzFjp1ubwM=
X-Google-Smtp-Source: APXvYqxhVXLl2eRdARMV6sa2FccYruDNAQSY1SJUDpzjXdHCsQeZtm7dt6hyBiPhJ/Mth6QNKMzKhw==
X-Received: by 2002:a2e:9198:: with SMTP id f24mr5540531ljg.221.1561711743672;
        Fri, 28 Jun 2019 01:49:03 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u21sm526310lju.2.2019.06.28.01.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 01:49:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hgmZ3-0004XX-9A; Fri, 28 Jun 2019 10:49:01 +0200
Date:   Fri, 28 Jun 2019 10:49:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cp210x: Add cp2108 GPIOs support
Message-ID: <20190628084901.GK508@localhost>
References: <20190514105358.18818-1-fancer.lancer@gmail.com>
 <20190615230214.30061-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615230214.30061-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 02:02:15AM +0300, Serge Semin wrote:
> Each chip from the cp210x series got GPIOs on board. This commit
> provides the support for sixteen ones placed on the cp2108 four-ports
> serial console controller. Since all GPIOs are accessible via any
> cp2108 USB interface we manually and equally distributed them between
> all interfaces in accordance with GPIOs alternative functions attachment.
> So the driver provides four GPIOs per each cp2108 USB interface.
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
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> 
> Changelog v2:
> - Rebase onto kernel 5.2.0-rc4.
> - Move USB_SERIAL_CP210X config descriptor modification to a separate patch.
> - Add more descriptive info of cp2108 state and config structures.
> - Replace _NUM suffix with _CNT.
> - Add _IDX suffix to CP2108_GPIO_PB macro.
> - Add _MODE suffix to CP2108_DYNAMIC_SUSPEND macro.
> - Discard __packed attribute from struct cp2108_gpio_write.
> - Discard CP2108_GPIO_CNT macro and use literal 4 instead.
> - Simplify cp210x_gpio_get() method by replacing the union with a u16 buffer.
> - Replace ternary operations of cp210x_gpio_set() with a conditional statement.
> - Add more descriptive comments regarding the gpio_altfunc bits collection.
> - Fix a bug in the GPIOs setter/getter methods of invalid bit being utilized
> to set/get GPIO values.
> ---
>  drivers/usb/serial/cp210x.c | 178 +++++++++++++++++++++++++++++++++---
>  1 file changed, 164 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 979bef9bfb6b..32f0a4273abb 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -505,6 +505,60 @@ struct cp210x_gpio_write {
>  	u8	state;
>  } __packed;
>  
> +/*
> + * Number of CP2108 USB interfaces, port-blocks and GPIO port-block index,
> + * where port-blocks are the internal pins containers of the chip.
> + */
> +#define CP2108_IFACE_CNT		4
> +#define CP2108_PB_CNT			5
> +#define CP2108_GPIO_PB_IDX		1

s/CNT/COUNT/

> +/*
> + * CP2108 default pins state. There are five port-blocks (PB). Each one is with

pin state?

> + * it' specific pins-set: Port 0 - UART 0 and 1, Port 1 - GPIOs, Port 2 - chip

typos: it's, pin-set

> + * suspend and a part of UART 2 pins, Port 3 and 4 - UART 2 and 3 pins

Probably more readable as a table (one line per port block).

> + * (for details see USB Express SDK sources or SDK-based smt application
> + * accessible here https://github.com/fancer/smt-cp210x).
> + */
> +struct cp2108_state {
> +	__le16	mode[CP2108_PB_CNT];	/* 0 - Open-Drain, 1 - Push-Pull */
> +	__le16	low_power[CP2108_PB_CNT];
> +	__le16	latch[CP2108_PB_CNT];	/* 0 - Logic Low, 1 - Logic High */
> +} __packed;

Still not clear to me how these affect one of the UARTs pins, or what
the "chip suspend" port-block is.

Do you think you can add something short about that?

> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 73 bytes.
> + * Reset/Suspend latches describe default states after reset/suspend of the
> + * pins.

Don't we need to consider also the suspend state when declaring as
input?

By leaving the pin as an output if it will be driven high during
suspend, users would at least get an indication that things may not be
configured as expected.

>           The rest are responsible for alternate functions settings of the
> + * chip pins (see USB Express SDK sources or SDK-based smt application
> + * https://github.com/fancer/smt-cp210x for details).
> + */
> +struct cp2108_config {
> +	struct cp2108_state reset_latch;
> +	struct cp2108_state suspend_latch;
> +	u8	ip_delay[CP2108_IFACE_CNT];
> +	u8	enhanced_fxn[CP2108_IFACE_CNT];
> +	u8	enhanced_fxn_dev;
> +	u8	ext_clock_freq[CP2108_IFACE_CNT];
> +} __packed;
> +
> +/* CP2108 port alternate functions fields. */
> +#define CP2108_GPIO_TXLED_MODE		BIT(0)
> +#define CP2108_GPIO_RXLED_MODE		BIT(1)
> +#define CP2108_GPIO_RS485_MODE		BIT(2)
> +#define CP2108_GPIO_RS485_LOGIC		BIT(3)
> +#define CP2108_GPIO_CLOCK_MODE		BIT(4)
> +#define CP2108_DYNAMIC_SUSPEND_MODE	BIT(5)
> +
> +/*
> + * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes
> + * to CP2108 controller.
> + */
> +struct cp2108_gpio_write {
> +	__le16	mask;
> +	__le16	state;
> +};
> +
>  /*
>   * Helper to get interface number when we only have struct usb_serial.
>   */
> @@ -1366,10 +1420,13 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  	struct usb_serial *serial = gpiochip_get_data(gc);
>  	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
>  	u8 req_type = REQTYPE_DEVICE_TO_HOST;
> +	int bufsize = 1;
>  	int result;
> -	u8 buf;
> +	u16 buf;
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105)
> +	if (priv->partnum == CP210X_PARTNUM_CP2108)
> +		bufsize = 2;
> +	else if (priv->partnum == CP210X_PARTNUM_CP2105)
>  		req_type = REQTYPE_INTERFACE_TO_HOST;
>  
>  	result = usb_autopm_get_interface(serial->interface);
> @@ -1377,39 +1434,62 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
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
> +	if (priv->partnum == CP210X_PARTNUM_CP2108) {
> +		u8 intf_num = cp210x_interface_num(serial);
> +
> +		gpio += intf_num * 4;
> +	}

So with the gpio-index bug fixed we still get a conditional here...

Did you try adding a dedicated cp2108x_gpio_get callback (I'm aware that
the generic init code needs to be updated for this)?

> +
> +	return !!(le16_to_cpu(buf) & BIT(gpio));
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
> +		u8 intf_num = cp210x_interface_num(serial);
> +		struct cp2108_gpio_write buf;
> +
> +		buf.mask = cpu_to_le16(BIT(intf_num * 4 + gpio));
> +		if (value == 1)
> +			buf.state = buf.mask;
> +		else
> +			buf.state = 0;
> +
> +		result = cp210x_write_vendor_block(serial,
> +						   REQTYPE_HOST_TO_DEVICE,
> +						   CP210X_WRITE_LATCH, &buf,
> +						   sizeof(buf));

And if adding a cp2108 get callback, you may as well break this out as
well.

> +	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +		struct cp210x_gpio_write buf;
> +
> +		buf.mask = BIT(gpio);
> +		if (value == 1)
> +			buf.state = buf.mask;
> +		else
> +			buf.state = 0;
> +
>  		result = cp210x_write_vendor_block(serial,
>  						   REQTYPE_HOST_TO_INTERFACE,
>  						   CP210X_WRITE_LATCH, &buf,
>  						   sizeof(buf));
>  	} else {
> -		u16 wIndex = buf.state << 8 | buf.mask;
> +		u16 wIndex = BIT(gpio);
> +
> +		if (value == 1)
> +			wIndex |= (BIT(gpio) << 8);
>  
>  		result = usb_control_msg(serial->dev,
>  					 usb_sndctrlpipe(serial->dev, 0),
> @@ -1489,6 +1569,73 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
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
> +	 * There are four interfaces with four GPIOs manually distributed for
> +	 * each of them. Here we parse the device config data to comply with
> +	 * the driver interface. Note that the mode (push-pull, open-drain,
> +	 * etc) can be changed only after reset, which causes the driver
> +	 * reloading anyway. So we can safely read the config just once at the
> +	 * device attachment procedure.
> +	 */
> +	intf_num = cp210x_interface_num(serial);
> +	if (intf_num >= CP2108_IFACE_CNT)
> +		return -ENODEV;
> +	mode = le16_to_cpu(config.reset_latch.mode[CP2108_GPIO_PB_IDX]);
> +	latch = le16_to_cpu(config.reset_latch.latch[CP2108_GPIO_PB_IDX]);
> +
> +	priv->gpio_altfunc = config.enhanced_fxn[intf_num];

gpio_altfunc isn't the same as as enhanced_fxn; use a temporary or move
where you finally set gpio_altfunc (which is a per-pin bitmask).

> +	priv->gpio_pushpull = (mode >> (intf_num * 4)) & 0x0f;
> +	priv->gpio_input = (latch >> (intf_num * 4)) & 0x0f;

Add a temporary or reuse latch here; this isn't gpio_input which is set
below.

> +	priv->gc.ngpio = 4;
> +
> +	/*
> +	 * Each GPIO[i*4 + x] can have an alternative function enabled
> +	 * (x = 0 - UART i TX toggle, x = 1 - UART i RX toggle, x = 2 - UART i
> +	 * RS485 mode and x = 3  - clock output i), in which case the GPIO

A table would be more readable (i.e. one value per line).

> +	 * functionality isn't available. If it is switched on we deny the GPIO
> +	 * requests. GPIO alternative functions state resides the
> +	 * enhanced_fxn[i] bitfield, where each bit linearly corresponds to
> +	 * the specific GPIO, except GPIO[3] - clock output function, which
> +	 * alas is placed at fourth bit, while the third bit is busy with RS485
> +	 * logic mode flag. In order to make the generic cp210x GPIO request
> +	 * method being suitable for cp2108, lets copy the GPIO[4] clock
> +	 * alternative function state bit to the GPIO[3] RS485 logic mode bit.
> +	 */

So instead of this wall of text, why not use the pattern from the other
init functions, which is mostly self-explantory? That is, four
conditionals like:

	if (enhanced_fxn & CP2108_GPIO_CLOCK_MODE)
		priv->gpio_altfunc |= BIT(3);

> +	priv->gpio_altfunc &= ~CP2108_GPIO_RS485_LOGIC;
> +	if (priv->gpio_altfunc & CP2108_GPIO_CLOCK_MODE)
> +		priv->gpio_altfunc |= CP2108_GPIO_RS485_LOGIC;

This really doesn't make any sense without the comment and knowing the
values of the macros, which kind of defeats their purpose.

> +
> +	/*
> +	 * Open-drain mode in combination with a high latch value is used
> +	 * to emulate the GPIO input pin.
> +	 */

This only hints at how we implement input mode. Also add something about
the initial direction which is what the following code is setting, along
the lines of:

	Set direction to "input" iff pin is open-drain and reset
	value is 1.

> +	priv->gpio_input &= ~priv->gpio_pushpull;

	priv->gpio_input = latch & ~priv->gpio_pushpull

where latch has been shifted as required (here or above).

Johan
