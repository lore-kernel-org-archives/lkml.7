Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E6CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134632086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571833317;
	bh=wtDUWoUxL13ZQpXwbTEg5m8VxrqsGfMt079DkWUbdSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJZmVMQVB3BFBMMqI5kiscSdMpi6aotHPjlsYoDDeU9rxl82rGHkBYzjA9X8t/4QQ
	 1N7+qCqg/6rXhJIoNssAYn53mxobsiWcOBzN3jkqaEjXFv/+7U/C1HEVqwmF2+ooVY
	 L6+GHyWdeKi1YcPPjo+u4EI8Xj9dUhc+BPUb1JhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405276AbfJWMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:21:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33959 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfJWMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:21:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so20891912lja.1;
        Wed, 23 Oct 2019 05:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGV98uzM0R66prlzR1jmF3XaIUe9frsDYAjBB3xKpZo=;
        b=pnUEjwrShF/2ko3DqkKsjek5ibg+MZXPNf93rJn+sFythYuIDH/PjFc2HOwpY03Q7O
         urjymGGCvszWXThfG5uzgvLuXGYQQNIlPxqVgpK6GcEZasPOWJdhqUO+LaXd6VLmP1dA
         WsBZ3pLhYDmuxMUQ3Zw6GfC+0Soy7xl7SA0hUvJI885gnL33LczLqoV9yODA/OzwgqBg
         Jmp/yEy4C7nWg0oSkvmNYUP0GSoxNfV/s7XYWdm6YUUcHU6H45dVVSN9h20MPT5jidcm
         DjPmSAWsTEgAxlL7VbFTIvzbHpadGG3Yvh1tFQCSJo0fq/40RBtjhAnBDc9PWHFdsgKL
         i3cw==
X-Gm-Message-State: APjAAAVHkknYLEoWw2D9nkvqtP67aZSz+XP6DKx6ftzImL5rVLSWQr0X
        jWdf9sLB1VBsvDG6mCiIw2M=
X-Google-Smtp-Source: APXvYqyU9kdYigv+/0N0CXu8vswtoXYkrFQaE8I0WDi28l/YJKGgKDwHUwg06ph8Hx6gicJi9fIwkA==
X-Received: by 2002:a2e:865a:: with SMTP id i26mr22105027ljj.107.1571833312489;
        Wed, 23 Oct 2019 05:21:52 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id y28sm3549190lfg.31.2019.10.23.05.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 05:21:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNFeS-0007Es-Ea; Wed, 23 Oct 2019 14:22:08 +0200
Date:   Wed, 23 Oct 2019 14:22:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
Message-ID: <20191023122208.GW24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:49AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
> is 12x3 = 36 GPIOs and this patch will implements GPIO device as a
> gpiochip to control all GPIO pins even transforms to transceiver pins.

Depending to your answer to my question whether these pins are truly
general purpose or not, this may not be the right interface.

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 249 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 249 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 82cc1e6cff62..dc9b28738b80 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -18,6 +18,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/uaccess.h>
> +#include <linux/gpio.h>
>  #include <linux/usb.h>
>  #include <linux/usb/serial.h>
>  #include <linux/serial_reg.h>
> @@ -104,6 +105,8 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
>  #define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
>  #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
>  
> +#define F81534A_MAX_PORT		12
> +
>  /* Serial port self GPIO control, 2bytes [control&output data][input data] */
>  #define F81534A_GPIO_REG		0x10e
>  #define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
> @@ -115,6 +118,13 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
>  
>  #define F81534A_CMD_ENABLE_PORT		0x116
>  
> +/*
> + * Control device global GPIO control,
> + * 2bytes [control&output data][input data]
> + */
> +#define F81534A_CTRL_GPIO_REG		0x1601
> +#define F81534A_CTRL_GPIO_MAX_PIN	3
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
> @@ -126,6 +136,12 @@ struct f81232_private {
>  	struct usb_serial_port *port;
>  };
>  
> +struct f81534a_ctrl_private {
> +	struct usb_interface *intf;
> +	struct gpio_chip chip;
> +	struct mutex lock;
> +};
> +
>  static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
>  static u8 const clock_table[] = { F81232_CLK_1_846_MHZ, F81232_CLK_14_77_MHZ,
>  				F81232_CLK_18_46_MHZ, F81232_CLK_24_MHZ };
> @@ -863,6 +879,50 @@ static void f81232_lsr_worker(struct work_struct *work)
>  		dev_warn(&port->dev, "read LSR failed: %d\n", status);
>  }
>  
> +static int f81534a_ctrl_get_register(struct usb_device *dev, u16 reg, u16 size,
> +					void *val)

Looks like this one needs to go under CONFIG_GPIOLIB as well.

> +{
> +	int retry = F81534A_ACCESS_REG_RETRY;
> +	int status;
> +	u8 *tmp;
> +
> +	tmp = kmalloc(size, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	while (retry--) {
> +		status = usb_control_msg(dev,
> +					usb_rcvctrlpipe(dev, 0),
> +					F81534A_REGISTER_REQUEST,
> +					F81534A_GET_REGISTER,
> +					reg,
> +					0,
> +					tmp,
> +					size,
> +					USB_CTRL_GET_TIMEOUT);
> +		if (status != size) {
> +			status = usb_translate_errors(status);
> +			if (status == -EIO)
> +				continue;
> +
> +			status = -EIO;
> +		} else {
> +			status = 0;
> +			memcpy(val, tmp, size);
> +		}
> +
> +		break;
> +	}
> +
> +	if (status) {
> +		dev_err(&dev->dev, "get reg: %x, failed status: %d\n", reg,
> +				status);
> +	}
> +
> +	kfree(tmp);
> +	return status;
> +}
> +
>  static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
>  					void *val)
>  {
> @@ -908,6 +968,182 @@ static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
>  	return status;
>  }
>  
> +#ifdef CONFIG_GPIOLIB
> +static int f81534a_ctrl_set_mask_register(struct usb_device *dev, u16 reg,
> +		u8 mask, u8 val)
> +{
> +	int status;
> +	u8 tmp;
> +
> +	status = f81534a_ctrl_get_register(dev, reg, 1, &tmp);
> +	if (status)
> +		return status;
> +
> +
> +	tmp = (tmp & ~mask) | (val & mask);
> +
> +	status = f81534a_ctrl_set_register(dev, reg, 1, &tmp);
> +	if (status)
> +		return status;
> +
> +	return 0;
> +}
> +
> +static int f81534a_gpio_get(struct gpio_chip *chip, unsigned int gpio_num)
> +{
> +	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
> +	struct usb_interface *intf = priv->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +	u8 tmp[2];
> +	int set;
> +	int idx;
> +	int reg;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	reg = F81534A_CTRL_GPIO_REG + set;
> +
> +	mutex_lock(&priv->lock);
> +
> +	status = f81534a_ctrl_get_register(dev, reg, sizeof(tmp), tmp);
> +	if (status) {
> +		mutex_unlock(&priv->lock);
> +		return status;
> +	}
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return !!(tmp[1] & BIT(idx));
> +}
> +
> +static int f81534a_gpio_direction_in(struct gpio_chip *chip,
> +					unsigned int gpio_num)
> +{
> +	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
> +	struct usb_interface *intf = priv->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +	int set;
> +	int idx;
> +	int reg;
> +	u8 mask;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = F81534A_GPIO_MODE0_DIR << idx;
> +	reg = F81534A_CTRL_GPIO_REG + set;
> +
> +	mutex_lock(&priv->lock);
> +	status = f81534a_ctrl_set_mask_register(dev, reg, mask, mask);
> +	mutex_unlock(&priv->lock);
> +
> +	return status;
> +}
> +
> +static int f81534a_gpio_direction_out(struct gpio_chip *chip,
> +				     unsigned int gpio_num, int val)
> +{
> +	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
> +	struct usb_interface *intf = priv->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +	int set;
> +	int idx;
> +	int reg;
> +	u8 mask;
> +	u8 data;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = (F81534A_GPIO_MODE0_DIR << idx) | BIT(idx);
> +	reg = F81534A_CTRL_GPIO_REG + set;
> +	data = val ? BIT(idx) : 0;
> +
> +	mutex_lock(&priv->lock);
> +	status = f81534a_ctrl_set_mask_register(dev, reg, mask, data);
> +	mutex_unlock(&priv->lock);
> +
> +	return status;
> +}
> +
> +static void f81534a_gpio_set(struct gpio_chip *chip, unsigned int gpio_num,
> +				int val)
> +{
> +	f81534a_gpio_direction_out(chip, gpio_num, val);
> +}
> +
> +static int f81534a_gpio_get_direction(struct gpio_chip *chip,
> +				unsigned int gpio_num)
> +{
> +	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
> +	struct usb_interface *intf = priv->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +	u8 tmp[2];
> +	int set;
> +	int idx;
> +	int reg;
> +	u8 mask;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = F81534A_GPIO_MODE0_DIR << idx;
> +	reg = F81534A_CTRL_GPIO_REG + set;
> +
> +	mutex_lock(&priv->lock);
> +
> +	status = f81534a_ctrl_get_register(dev, reg, sizeof(tmp), tmp);
> +	if (status) {
> +		mutex_unlock(&priv->lock);
> +		return status;
> +	}
> +
> +	mutex_unlock(&priv->lock);
> +
> +	if (tmp[0] & mask)
> +		return GPIOF_DIR_IN;
> +
> +	return GPIOF_DIR_OUT;
> +}
> +
> +static int f81534a_prepare_gpio(struct usb_interface *intf)

Could you rename this f81534a_gpiochip_register or similar?

> +{
> +	struct f81534a_ctrl_private *priv = usb_get_intfdata(intf);
> +	int status;
> +
> +	priv->chip.parent = &intf->dev;
> +	priv->chip.owner = THIS_MODULE;
> +	priv->chip.get_direction = f81534a_gpio_get_direction,
> +	priv->chip.get = f81534a_gpio_get;
> +	priv->chip.direction_input = f81534a_gpio_direction_in;
> +	priv->chip.set = f81534a_gpio_set;
> +	priv->chip.direction_output = f81534a_gpio_direction_out;
> +	priv->chip.label = "f81534a";
> +	priv->chip.can_sleep = true;
> +	/* M0(SD)/M1/M2 */
> +	priv->chip.ngpio = F81534A_CTRL_GPIO_MAX_PIN * F81534A_MAX_PORT;
> +	priv->chip.base = -1;
> +
> +	priv->intf = intf;

Maybe store the parent struct usb_device instead since that's what you
end up using?

> +	mutex_init(&priv->lock);

Already initialised in probe() below. Same with priv->intf by the way.

> +
> +	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
> +	if (status) {
> +		dev_err(&intf->dev, "failed to register gpiochip: %d\n",
> +				status);
> +		return status;
> +	}

Have you tried disconnecting the device with gpios requested? This used
to break gpiolib, but was fixed. Just want to make sure it hasn't
regressed.

> +
> +	return 0;
> +}
> +#else
> +static int f81534a_prepare_gpio(struct usb_interface *intf)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
>  {
>  	struct usb_device *dev = interface_to_usbdev(intf);
> @@ -930,8 +1166,21 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
>  				const struct usb_device_id *id)
>  {
>  	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct f81534a_ctrl_private *priv;
>  	int status;
>  
> +	priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->lock);
> +	usb_set_intfdata(intf, priv);
> +	priv->intf = intf;
> +
> +	status = f81534a_prepare_gpio(intf);
> +	if (status)
> +		return status;
> +
>  	status = f81534a_ctrl_enable_all_ports(intf);
>  	if (status)
>  		return status;

Overall this all look much better now.

Thanks,
Johan
