Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD89C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47120840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565686818;
	bh=hUELcvIRG+CX4Ilf5Jyj48lxOyNUtHAg2pJIgHfukcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GrYHnLOLMMI3lIQVVeBSSXhg34O2l6KzTCplcmga0iMAvL/H7WoDTvAUG2CsggCEd
	 DIKDKPpwQLjU74DsQpez0p19EDv87wj1ASBMKAEoTl6eWw0ZW3cU+VGq1P5SiuWUdb
	 CF2rPvJ2aAgWEgzSwBdBsUmoelp5yNOzOb3BgjMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfHMJAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:00:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46480 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:00:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id f9so2307715ljc.13;
        Tue, 13 Aug 2019 02:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upmBb2mGlv4gnwaZ2+hM8WM31wXuR9CSfXjTJTQ+4O4=;
        b=scvVUb1oAq5IcYEBsWX9icptKi2OO2W4UaQJBzq9A+5/DGpnEPj/9MpfCxUNs3iv41
         9XpHg+BAHwAMvC7opFT/EHL5qRjw0hHpnmxhCg8/GFuxD6q+WxBJwV9kafMx6ndwy1wu
         ZiuBiuftm0vIXdDCz0aanP9WCZcp2EnrOob8R8Thv4deIGIFX1OZRZuyoxr/RS0rCZAP
         ISNdazDQ4OrbjWvpsP+zoD/6QXasbj8oJghfGC5y/mqj9o/Y34HIMXpCDIqqxU/05KrV
         ti3kSOIirZHrqcO3x8JSpGFDY3ZacnxAJFH9chdd0+EEzqENsAJ78oyLQzBaaNMugr4+
         dMMQ==
X-Gm-Message-State: APjAAAXCAIjLQPBJ3JP/Dm1pyr0xJJ8IASeGrKFkw4K6Lfoxb9RvaEM1
        k8VTjjkM3q9WOjKdsw+PmNs=
X-Google-Smtp-Source: APXvYqyoa+Wr7O+3bDljB3NROMZqzsx3wYZ6s4Kgxq8+08PF6N9yNlVb0cdbZjkfeJgQJZIBIOtxTw==
X-Received: by 2002:a2e:99d5:: with SMTP id l21mr9162464ljj.205.1565686814334;
        Tue, 13 Aug 2019 02:00:14 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id s21sm21644943ljm.28.2019.08.13.02.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 02:00:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hxSf3-0002xn-Aa; Tue, 13 Aug 2019 11:00:09 +0200
Date:   Tue, 13 Aug 2019 11:00:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthew Michilot <mmichilot@gateworks.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Michilot <matthew.michilot@gmail.com>
Subject: Re: [PATCH] USB: serial: ftdi_sio: add support for FT232H CBUS gpios
Message-ID: <20190813090009.GB15556@localhost>
References: <20190808222348.4428-1-matthew.michilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222348.4428-1-matthew.michilot@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:23:48PM +0000, Matthew Michilot wrote:
> Enable support for cbus gpios on FT232H. The cbus configuration is
> stored in one word in the EEPROM at byte-offset 0x1a with the mux

It seems to be stored in two words.

> config for ACBUS5, ACBUS6, ACBUS8 and ACBUS9 (only pins that can be
> configured as I/O mode).
> 
> Tested using FT232H by configuring one ACBUS pin at a time.
> 
> Review-by: Tim Harvey <tharvey@gateworks.com>

typo: Reviewed-by

> Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
> ---
>  drivers/usb/serial/ftdi_sio.c | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 4b3a049561f3..c8d35faa8f61 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -2023,6 +2023,46 @@ static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
>  	return 0;
>  }
>  
> +static int ftdi_gpio_init_ft232h(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	u8 *buf;
> +	u16 cbus_config;
> +	int ret;
> +	int i;
> +
> +	buf = kmalloc(2, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = ftdi_read_eeprom(port->serial, buf, 0x1A, 4);

You allocate 2 byte above, but write 4 bytes into buf here.

Please also use lower-case hex notation consistently throughout.

> +	if (ret < 0)
> +		goto out_free;
> +
> +	/*
> +	 * FT232H CBUS Memory Map
> +	 *
> +	 * 0x1A: 8X (upper nibble -> AC5)
> +	 * 0x1B: X8 (lower nibble -> AC6)
> +	 * 0x1C: 88 (upper nibble -> AC8 | lower nibble -> AC9)
> +	 */
> +	cbus_config = (((buf[0] & 0xf0) | (buf[1] & 0xf)) << 8 | buf[2]);

Have you verified the order you use here by enabling one gpio at a time
and toggling it? The reason I ask is that the above would give a
mapping of

	gpio0 -> AC9
	gpio1 -> AC8
	gpio2 -> AC6
	gpio4 -> AC5

which looks backwards but may be correct.

Also please drop the outer parentheses in the above expression.

> +
> +	priv->gc.ngpio = 4;
> +	priv->gpio_altfunc = 0xff;
> +
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		if ((cbus_config & 0xf) == FTDI_FTX_CBUS_MUX_GPIO)
> +			priv->gpio_altfunc &= ~BIT(i);
> +		cbus_config >>= 4;
> +	}
> +
> +out_free:
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
>  static int ftdi_gpio_init_ft232r(struct usb_serial_port *port)
>  {
>  	struct ftdi_private *priv = usb_get_serial_port_data(port);
> @@ -2104,6 +2144,9 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
>  	case FTX:
>  		result = ftdi_gpio_init_ftx(port);
>  		break;
> +	case FT232H:
> +		result = ftdi_gpio_init_ft232h(port);
> +		break;

Please keep the case labels sorted alphabetically.

>  	default:
>  		return 0;
>  	}

Johan
