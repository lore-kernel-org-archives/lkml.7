Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B96C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B74522CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567006669;
	bh=2LEyeuRGM9eKjNNeNfpGaPhSvzYf7Edasg8rUZBZORY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HjIetIGhrd+eKMKw9Erf3aaCrG3+WAIREHbLi1H8vo0qNEZweyK/50UnVkcUuPI0y
	 zdHmslHKkMcFiD+CpIQira9B/uM2Fp/6qDKD1gYmJd3am7qg9FBOO9+G0RrUCxTWFz
	 2YdkGtgRQaBs6nx/VWJAI4Qr9oS1HEo0Imz8/Vtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfH1Phs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:37:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1Phs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:37:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so3052198lje.2;
        Wed, 28 Aug 2019 08:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+rCo1gaXnN7vZoyK/GVFm6tFPWXzkouMyx0FhA7JF4=;
        b=tHlvxAKjk2BGkGlWCJynnIbHeqCO7t1t1oX7WWGQCjc4GWoHMESv7YROALW6iQD0pB
         I0rQFo5w89SUHlxXaHf8TQtSLdaFHNoWdm4XkW70+CPqFON1mwBuc16k6dV7DF4s+vLA
         eDIS9xNtj2WF/lwAyDKHc53I4Ia78qz5/NjEreiF7tmxbOatiE+YjlV/0piKMb2DiUAb
         QWE/nqGcDaCpr2ow6ERvGtD+BJ6zYb43IxGcYFCZKE0hEeSFLgkNKODOHvfHYLTZGZjK
         9+Et2XiwHSaHtsk9UH+9MCNfN21fVSODx9Nxuq4fR9DwsJuR2Ra+REd8U8Rgnyxh3RgW
         8aWQ==
X-Gm-Message-State: APjAAAWRRyweIpcvkRgoQoUwEAttpc0IYr9Kj86Y0xQetUyBEtAD1f8C
        ZjOTZi24hzlIQOTbYzXbUuY=
X-Google-Smtp-Source: APXvYqzRhf61OfxtXXbCfPi416wdDN4j6rkVeMabqV8R3InAk4ob5DiSMZnaR+6Uqh2dn7vS+vuusA==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr2487139lji.26.1567006664469;
        Wed, 28 Aug 2019 08:37:44 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id b30sm898088lfo.49.2019.08.28.08.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:37:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i300y-0008T9-8m; Wed, 28 Aug 2019 17:37:40 +0200
Date:   Wed, 28 Aug 2019 17:37:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 6/6] USB: serial: f81232: Add gpiolib to GPIO device
Message-ID: <20190828153740.GL13017@localhost>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-7-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559789656-15847-7-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:54:16AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
> is 12x3 = 36 GPIOs.

How does this relate to the GPIOs used for transceiver setup? Are these
really general purpose?

Side note: Please explain the relationship to f81534 which you already
have a driver for. Is f81534a all that different that it belongs with
f81232? Confusing...

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 210 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 210 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 708d85c7d822..a53240bc164a 100644
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
> @@ -132,6 +133,7 @@ struct f81232_private {
>  
>  struct f81534a_ctrl_private {
>  	struct usb_interface *intf;
> +	struct gpio_chip chip;
>  	struct mutex lock;
>  	int device_idx;
>  };
> @@ -1007,6 +1009,204 @@ static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
>  	return status;
>  }
>  
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

You'll get a warning about this one being unused with !GPIOLIB.

> +#ifdef CONFIG_GPIOLIB
> +static int f81534a_gpio_get(struct gpio_chip *chip, unsigned int gpio_num)
> +{
> +	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
> +	struct usb_interface *intf = priv->intf;
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +	u8 tmp[2];
> +	int set;
> +	int idx;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +
> +	status = mutex_lock_interruptible(&priv->lock);

Why _interruptible?

> +	if (status)
> +		return -EINTR;
> +
> +	status = f81534a_ctrl_get_register(dev, F81534A_CTRL_GPIO_REG + set,
> +							sizeof(tmp), tmp);
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
> +	u8 mask;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = F81534A_GPIO_MODE0_DIR << idx;
> +
> +	status = mutex_lock_interruptible(&priv->lock);
> +	if (status)
> +		return -EINTR;
> +
> +	status = f81534a_ctrl_set_mask_register(dev, F81534A_CTRL_GPIO_REG +
> +				set, mask, mask);
> +	if (status) {
> +		mutex_unlock(&priv->lock);
> +		return status;

Just return status below instead.

> +	}
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
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
> +	u8 mask;
> +	u8 data;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = (F81534A_GPIO_MODE0_DIR << idx) | BIT(idx);
> +	data = val ? BIT(idx) : 0;
> +
> +	status = mutex_lock_interruptible(&priv->lock);
> +	if (status)
> +		return -EINTR;
> +
> +	status = f81534a_ctrl_set_mask_register(dev, F81534A_CTRL_GPIO_REG +
> +				set, mask, data);

Please keep set on the same line as the reg define, but why not
calculate a reg temporary above instead?

> +	if (status) {
> +		mutex_unlock(&priv->lock);
> +		return status;

As above.

> +	}
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
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
> +	u8 mask;
> +
> +	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
> +	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
> +	mask = F81534A_GPIO_MODE0_DIR << idx;
> +
> +	status = mutex_lock_interruptible(&priv->lock);
> +	if (status)
> +		return -EINTR;
> +
> +	status = f81534a_ctrl_get_register(dev, F81534A_CTRL_GPIO_REG + set,
> +							sizeof(tmp), tmp);
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
> +	/* M0(SD)/M1/M2 */
> +	priv->chip.ngpio = F81534A_CTRL_GPIO_MAX_PIN * F81534A_MAX_PORT;

It looks like you should have one gpiochip per port.

> +	priv->chip.base = -1;

You need to set the can_sleep flag.

> +
> +	priv->intf = intf;
> +	mutex_init(&priv->lock);
> +
> +	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
> +	if (status) {
> +		dev_err(&intf->dev, "%s: failed: %d\n", __func__, status);

No need for __func__. Spell what went wrong (e.g. "failed to register
gpiochip: %d\n").

> +		return status;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int f81534a_prepare_gpio(struct usb_interface *intf)
> +{
> +	dev_warn(&intf->dev, "CONFIG_GPIOLIB is not enabled\n");
> +	dev_warn(&intf->dev, "The GPIOLIB interface will not register\n");

Please remove this.

> +
> +	return 0;
> +}
> +#endif
> +
> +static int f81534a_release_gpio(struct usb_interface *intf)
> +{
> +	return 0;
> +}

Remove.

> +
>  static int f81534a_ctrl_generate_ports(struct usb_interface *intf,
>  					struct f81534a_device *device)
>  {
> @@ -1118,6 +1318,7 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
>  	struct usb_device *dev = interface_to_usbdev(intf);
>  	struct f81534a_ctrl_private *priv;
>  	struct f81534a_device *device;
> +	int status;
>  
>  	priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -1130,6 +1331,10 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
>  	mutex_init(&priv->lock);
>  	usb_set_intfdata(intf, priv);
>  
> +	status = f81534a_prepare_gpio(intf);
> +	if (status)
> +		return status;
> +
>  	INIT_LIST_HEAD(&device->list);
>  	device->intf = intf;
>  
> @@ -1158,6 +1363,11 @@ static void f81534a_ctrl_disconnect(struct usb_interface *intf)
>  
>  			priv = usb_get_intfdata(intf);
>  			dev = interface_to_usbdev(intf);
> +
> +			mutex_lock(&priv->lock);
> +			f81534a_release_gpio(intf);
> +			mutex_unlock(&priv->lock);
> +
>  			usb_put_dev(dev);
>  			break;
>  		}

Johan
