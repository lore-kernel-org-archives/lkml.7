Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F234C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225F7205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556866930;
	bh=IcvQC+frg6y6ZaWJXs/KGFXCTKJdaKyXhcgKDcfoX+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SHOhrKBn8m6B8yOxmm/zsw4QrZY8MFdrDbEHwP0L8cQlXLNoJcBil4lZePQlBHmqF
	 1nNDCbvBG2zIUJKrCmNzHde2/RDzDpWGC2RMmrbfp3wa1zpcFwRDMcilqHCovTTfCb
	 XikiOCksXTpe36X+xZy6IHr8FYDS0BwNrVU5QnlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfECHCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:02:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35142 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfECHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:02:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so4373960ljj.2;
        Thu, 02 May 2019 23:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iqk3xergUOsKAugJuc5t6KOxZcaZnh5miw46WUEvyZ8=;
        b=d99CEB95BnT5kT6nYuwo4XUE9+LijDslkebppPl3zeWTrN7tRjObi/3iIb2XB9/knw
         njZIDnYYS2q4uQb/rGd+x1PQpS1WdjjLgufi8wNBbBW5o3cqyslT8bQGdy7zctj/3S7n
         ASILmFXb7rBiDNgUEQa7IZnaUjJSXMibotux51Vq4MmrimBDovr7ARBGv/KMb36RiAwa
         TR1kUWlSvhqiGO+ILc9TjR5mxfbeees/F8LY/55/EBSqwRuNUTrthlZfL9rYMml5oH96
         lR1EBQRrtXYj8tcaYwZhtEQwHlsbjj8oPiF4waxO9IibriqctMlpWTezzNeDL2jKCXCV
         WE4A==
X-Gm-Message-State: APjAAAVE0SBOK4ZbGKm26mitXjbGMgYsa0FOmwuYqYxegbcTbQ+qvbQ7
        m+CkSpOpEEGlvvLDPSCg6AM=
X-Google-Smtp-Source: APXvYqwaLakM0EHUo6NfD8Mw26aclhii8edWJbqB5mPdjVZ+4De+RAEx471f5MRfpEibtEo5pHLNyA==
X-Received: by 2002:a2e:655a:: with SMTP id z87mr4194357ljb.150.1556866745836;
        Thu, 02 May 2019 23:59:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u12sm227951ljk.89.2019.05.02.23.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 23:59:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hMSA9-0004aP-7Z; Fri, 03 May 2019 08:59:17 +0200
Date:   Fri, 3 May 2019 08:59:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V9 4/4] USB: serial: f81232: implement break control
Message-ID: <20190503065917.GA26546@localhost>
References: <1556587352-19500-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1556587352-19500-4-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556587352-19500-4-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:22:32AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Implement Fintek F81232 break on/off with LCR register.
> It's the same with 16550A LCR register layout.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---

>  static void f81232_break_ctl(struct tty_struct *tty, int break_state)
>  {
> -	/* FIXME - Stubbed out for now */
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
> +	int status;
>  
> -	/*
> -	 * break_state = -1 to turn on break, and 0 to turn off break
> -	 * see drivers/char/tty_io.c to see it used.
> -	 * last_set_data_urb_value NEVER has the break bit set in it.
> -	 */
> +	mutex_lock(&priv->lock);
> +
> +	if (break_state)
> +		priv->shadow_lcr |= UART_LCR_SBC;
> +	else
> +		priv->shadow_lcr &= ~UART_LCR_SBC;
> +
> +	status = f81232_set_register(port, LINE_CONTROL_REGISTER,
> +					priv->shadow_lcr);
> +	if (status)
> +		dev_err(&port->dev, "set break failed: %d\n", status);
> +
> +	mutex_unlock(&priv->lock);
>  }

> @@ -519,6 +530,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
>  static void f81232_set_termios(struct tty_struct *tty,
>  		struct usb_serial_port *port, struct ktermios *old_termios)
>  {
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
>  	u8 new_lcr = 0;
>  	int status = 0;
>  	speed_t baudrate;
> @@ -572,11 +584,16 @@ static void f81232_set_termios(struct tty_struct *tty,
>  		break;
>  	}
>  
> +	mutex_lock(&priv->lock);
> +
> +	new_lcr |= (priv->shadow_lcr & UART_LCR_SBC);
>  	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
>  	if (status) {
>  		dev_err(&port->dev, "%s failed to set LCR: %d\n",
>  			__func__, status);
>  	}
> +
> +	mutex_unlock(&priv->lock);

You forgot to update shadow_lcr here so the line settings would be
corrupted (e.g set to 5 bit words) whenever a break is signalled.

Did you not test this version of the patch?

I added the missing update, but please test the code that's in my
usb-next branch in a minute and confirm everything works as expected.

All four patches now applied.

Thanks,
Johan
