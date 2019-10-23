Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2470CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794FC2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571832324;
	bh=WRptdMhhS0j0uimShop7ughkmSui50r3jaqRcWlNMO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1ffybv0sJ5Rh9QNRMp7ijEX7fKT2oNgRlml5GE4FDzCdVg4cCQ3WyE2X1vo+O0Xr
	 1wtHcuedDDO8PRF8fiyDYTUbP08SMAVlbe5ME7EhR9caY7r1JET08YQ1gDDpXh9PY7
	 5SRPbznQwsupPiQLq0r88fL78GNdQGjGIva2ZRss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405219AbfJWMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:05:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46307 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbfJWMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:05:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so15837940lfc.13;
        Wed, 23 Oct 2019 05:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FflFEPeHnXlhmV3gvAD87PsvImRbVXArSfc/aAArtdE=;
        b=KoZkiSdsQtJ01eR+0x/WdkgsSOMN28kE9irB+TLFB6umuM8DoZh5OLYNPu129uzyPk
         CoNz8SIS9AzL8ZMmW7tsrJf2fZJN5VmhVPHiu2UBr89r65Eq9W3+vuQhgivOAcQ/mJxB
         HjHAMDe4gQRQlItf/GUg3ZAwnUXcdeIL4W+wHM80O4mY4/IgJM8MkT997UcfOQGdtknh
         uYtvvlOvRac+TwhskzQGdDZSdKs7E4O7uv8LDw6vKSd7YJdzw9C4M0zblPmGSZ5kaqEp
         TfqokcMAVfJBg3zhN+9Sbk9TTccM9rkFIEG3trdQh0Aas6l1YNPJStEOhL8CnEDN2jhN
         05bQ==
X-Gm-Message-State: APjAAAW7KOpdQt3UHjd4VYovdX+jWYyTUWYgwNrzTgL/BOWK09NIutRN
        k/Rh6XmlHovJrVJ0KqD4c4k=
X-Google-Smtp-Source: APXvYqwdJcGfab9FVaptvMJMMOV4McUvguU06cuyiOWtJZns59apBKG9XWpfsn1dyuYk4FFAD8u7sg==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr13155348lfi.157.1571832320679;
        Wed, 23 Oct 2019 05:05:20 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id q16sm9321119lfb.74.2019.10.23.05.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 05:05:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNFOS-0007AO-Mz; Wed, 23 Oct 2019 14:05:36 +0200
Date:   Wed, 23 Oct 2019 14:05:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 6/7] USB: serial: f81232: Add generator for F81534A
Message-ID: <20191023120536.GV24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-7-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-7-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:48AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
> 
> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
> need write 0x8fff to GPIO device register F81534A_CMD_ENABLE_PORT(116h)
> to enable all available serial ports.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 135 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 01cb5a5ea1d2..82cc1e6cff62 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -36,6 +36,9 @@
>  	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
>  	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
>  
> +#define F81534A_CTRL_ID		\
> +	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
> +
>  static const struct usb_device_id id_table[] = {
>  	F81232_ID,
>  	{ }					/* Terminating entry */
> @@ -46,6 +49,11 @@ static const struct usb_device_id f81534a_id_table[] = {
>  	{ }					/* Terminating entry */
>  };
>  
> +static const struct usb_device_id f81534a_ctrl_id_table[] = {
> +	F81534A_CTRL_ID,
> +	{ }					/* Terminating entry */
> +};
> +
>  static const struct usb_device_id all_serial_id_table[] = {
>  	F81232_ID,
>  	F81534A_SERIES_ID,
> @@ -105,6 +113,8 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
>  #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
>  #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
>  
> +#define F81534A_CMD_ENABLE_PORT		0x116

Maybe use a distinct prefix for requests to the control device (e.g.
F81534A_CTRL_).

> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
> @@ -853,6 +863,95 @@ static void f81232_lsr_worker(struct work_struct *work)
>  		dev_warn(&port->dev, "read LSR failed: %d\n", status);
>  }
>  
> +static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
> +					void *val)
> +{
> +	int retry = F81534A_ACCESS_REG_RETRY;
> +	int status;
> +	u8 *tmp;
> +
> +	tmp = kmalloc(size, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	memcpy(tmp, val, size);

Use kmemdup().

> +
> +	while (retry--) {
> +		status = usb_control_msg(dev,
> +					usb_sndctrlpipe(dev, 0),
> +					F81534A_REGISTER_REQUEST,
> +					F81534A_SET_REGISTER,
> +					reg,
> +					0,
> +					tmp,
> +					size,
> +					USB_CTRL_SET_TIMEOUT);
> +		if (status != size) {
> +			status = usb_translate_errors(status);
> +			if (status == -EIO)
> +				continue;

This will retry on short transfers, is that what you intended?

> +
> +			status = -EIO;
> +		} else {
> +			status = 0;
> +		}
> +
> +		break;
> +	}
> +
> +	if (status) {
> +		dev_err(&dev->dev, "set ctrl reg: %x, failed status: %d\n", reg,
> +				status);
> +	}
> +
> +	kfree(tmp);
> +	return status;
> +}
> +
> +static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	unsigned char enable[2];
> +	int status;
> +
> +	/* enable all available serial ports */
> +	enable[0] = 0xff;
> +	enable[1] = 0x8f;

What are these magic constants?

> +
> +	status = f81534a_ctrl_set_register(dev, F81534A_CMD_ENABLE_PORT,
> +			sizeof(enable), enable);
> +	if (status)
> +		dev_warn(&dev->dev, "set CMD_ENABLE_PORT failed: %d\n", status);
> +
> +	return status;
> +}
> +
> +static int f81534a_ctrl_probe(struct usb_interface *intf,
> +				const struct usb_device_id *id)
> +{
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	int status;
> +
> +	status = f81534a_ctrl_enable_all_ports(intf);
> +	if (status)
> +		return status;
> +
> +	dev = usb_get_dev(dev);

This isn't strictly needed.

> +	return 0;
> +}

Johan
