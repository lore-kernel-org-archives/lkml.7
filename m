Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73079206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEjz8zoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfDZKpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:45:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39041 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:45:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id d12so2120048lfk.6;
        Fri, 26 Apr 2019 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHHg9WKzE4/3ao/PkGDDdWURn9I7KD1QpZmFh0Il3kY=;
        b=LEjz8zoLozi0dz/j1NRrB9XtcAsOFwxgiwmsrtR1kime6RS1OPg/w/xXkU7P918xlG
         261nErWD2BmUiATxHOPBL3cjSSIoRg8e7IEFy20oooocEqnBngKn1vFkxk4TQmsCu5m2
         HzYjBaRxL6Jf+Ok+SeDQ2QweAY6XdEEmHTyszqFDO+s9s0aQ0erHWP3wkXIZojIhJaTt
         7pT0hvIvhbzlec8wIUROaFmXcGZEIwWGCO7Nn4f70f1Xo70KnNB/sCy1YEaEMK3Q/Ej9
         yjSXJQvg1gtDjyOL9HH+vYf1DX6nZXii7UCvQZCsbIOGIuKFWCdN+sRRQ8GMiwUw6OHQ
         5o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHHg9WKzE4/3ao/PkGDDdWURn9I7KD1QpZmFh0Il3kY=;
        b=osO8U613AaAS/yAVbRCfHRoBNk6upbru00zqsErRq6++ch4F89dL5mkJ7FHk5SU0y3
         WxDvABqSduDduiUuahShtMDBsG8+TJP3DJF/XpBXMLmV+xa+sKw+9DxguOINZue9YiQG
         f0xBHuWQPEL5bmo/23KA+FV1yOakgf8lyVhA/XBWaonobJDFO+qwpLxRFwRJZvBL49i+
         uI3SHUbzekwgHcRk/u+SZTk5V4+OVqR5L7+2aYlGGaS1WdF1IgZh8ddf3n8j9/+PRDJ0
         IlHYw4ia53tu+ucY0s3x1oSlvgUU+emhJ4FlkJoKeu/hUqoTtc1pK2uiY2mORVFQ+VGq
         exgw==
X-Gm-Message-State: APjAAAWL5VHNH8Hp6f6c+jvLtW3XhwjGI/QB68Pw7UKZ7agMl46XQY8/
        eCdylhRVLjArKz/6oY1fiwyf54jWmKU=
X-Google-Smtp-Source: APXvYqwvXKd4llDnZ0f2gaNhWIPAmdG3ilMclyHeY0KSy745PWzMiddGQKIeMot6RmYmOfg7MM7Mtg==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr11869712lfm.91.1556275502879;
        Fri, 26 Apr 2019 03:45:02 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id c17sm3336069lff.84.2019.04.26.03.45.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Apr 2019 03:45:02 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:45:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190426104458.gx4qqtdl7kumphzt@mobilestation>
References: <20190425223256.20270-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425223256.20270-1-fancer.lancer@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 01:32:56AM +0300, Serge Semin wrote:

Ahh, sorry. Forget about this email. I'll resend it with the valid In-Reply-To
message-id.

-Sergey

> SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> state. This is the mode the hub is supposed to be to let this driver
> work correctly. But a race condition might happen right after reset
> is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> function. In case if the reset pin is handled by a i2c GPIO expander,
> which is also placed at the same i2c-bus segment as the usb251x
> SMB-interface connected to, then the hub reset clearance might
> cause the CFG_SEL[0] being latched in unpredictable state. So
> sometimes the hub configuration mode might be 0x1 (as expected),
> but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> interface activated and consequently causes this driver failure.
> 
> In order to fix the problem we must make sure the GPIO-reset chip doesn't
> reside the same i2c-bus segment as the SMBus-interface of the hub. If
> it doesn't, we can safely block the segment for the time the reset is
> cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> just return an error. If we locked the i2c-bus segment and tried to
> communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> Changelog v2
> - Execute the check code only if GPIOLIB is enabled (reported by
>   a build robot).
> 
> ---
>  drivers/usb/misc/usb251xb.c | 62 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 04684849d683..cdc80e8c2d8a 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/nls.h>
> @@ -222,11 +223,51 @@ static const struct usb251xb_data usb2517i_data = {
>  	.product_str = "USB2517i",
>  };
>  
> +#ifdef CONFIG_GPIOLIB
> +static int usb251xb_check_dev_children(struct device *dev, void *child)
> +{
> +	if (dev->type == &i2c_adapter_type) {
> +		return device_for_each_child(dev, child,
> +					     usb251xb_check_dev_children);
> +	}
> +
> +	return (dev == child);
> +}
> +
> +static int usb251x_check_gpio_chip(struct usb251xb *hub)
> +{
> +	struct gpio_chip *gc = gpiod_to_chip(hub->gpio_reset);
> +	struct i2c_adapter *adap = hub->i2c->adapter;
> +	int ret;
> +
> +	if (!hub->gpio_reset)
> +		return 0;
> +
> +	if (!gc)
> +		return -EINVAL;
> +
> +	ret = usb251xb_check_dev_children(&adap->dev, gc->parent);
> +	if (ret) {
> +		dev_err(hub->dev, "Reset GPIO chip is at the same i2c-bus\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int usb251x_check_gpio_chip(struct usb251xb *hub)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static void usb251xb_reset(struct usb251xb *hub, int state)
>  {
>  	if (!hub->gpio_reset)
>  		return;
>  
> +	i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
> +
>  	gpiod_set_value_cansleep(hub->gpio_reset, state);
>  
>  	/* wait for hub recovery/stabilization */
> @@ -234,6 +275,8 @@ static void usb251xb_reset(struct usb251xb *hub, int state)
>  		usleep_range(500, 750);	/* >=500us at power on */
>  	else
>  		usleep_range(1, 10);	/* >=1us at power down */
> +
> +	i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
>  }
>  
>  static int usb251xb_connect(struct usb251xb *hub)
> @@ -621,6 +664,25 @@ static int usb251xb_probe(struct usb251xb *hub)
>  		}
>  	}
>  
> +	/*
> +	 * usb251x SMBus-slave SCL lane is muxed with CFG_SEL0 pin. So if anyone
> +	 * tries to work with the bus at the moment the hub reset is released,
> +	 * it may cause an invalid config being latched by usb251x. Particularly
> +	 * one of the config modes makes the hub loading a default registers
> +	 * value without SMBus-slave interface activation. If the hub
> +	 * accidentally gets this mode, this will cause the driver SMBus-
> +	 * functions failure. Normally we could just lock the SMBus-segment the
> +	 * hub i2c-interface resides for the device-specific reset timing. But
> +	 * the GPIO controller, which is used to handle the hub reset, might be
> +	 * placed at the same i2c-bus segment. In this case an error should be
> +	 * returned since we can't safely use the GPIO controller to clear the
> +	 * reset state (it may affect the hub configuration) and we can't lock
> +	 * the i2c-bus segment (it will cause a deadlock).
> +	 */
> +	err = usb251x_check_gpio_chip(hub);
> +	if (err)
> +		return err;
> +
>  	err = usb251xb_connect(hub);
>  	if (err) {
>  		dev_err(dev, "Failed to connect hub (%d)\n", err);
> -- 
> 2.21.0
> 
