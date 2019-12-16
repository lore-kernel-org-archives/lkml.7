Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6185EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4422067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576506490;
	bh=FThV7CQkARc2SJLGD//X4PIT+sy2UhpZ23SU41MSpi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KAajMGiQiD6ng1LE9Vm/gDthwNKJyolTkClhZknA4L3TjULrgITGSIjQu0cq3hrl+
	 mu45viib+PLw/Ebb0Tv2DDWrTN0LLc6kKt7kTyO4gW/MTr+bCOcCZMQCPIVgZKYkz+
	 CwioxGhA6LdVtyjZx6+Vf2ZwdMVRMyfPXBeo10KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfLPO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:28:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42990 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfLPO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:28:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so4365984lfl.9;
        Mon, 16 Dec 2019 06:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJOIxwAEgnSLXlaUUspSrq6fBSD7PUNiSiO3LHKGtnM=;
        b=MS/WRumo5Kvdy8oj3sZ5/8y1PVYaU4Nxo/tGhjXuPZND6fMzZ6rfFVU897hT2irA2X
         7jQO/2DSfG1Zr75nO2tw84aFXIMZiaPzgAG0nPNz7MBTcYUGu8wTWFl+t9sPdXpM0SpA
         8e4OZONaehswU1pY1C2gUHt/CA0Hr6zNq/TmkG38fF29tXyFL56Etd8KAlHnlBCpbyyr
         YSqYpqZf7r31KsiFYH55VbQCfeR+qgdlmFVMxxs8bpu91SrfhdDhugClTTfUD7loqeBG
         bW6h55/p7sz0Y7rMYgq2tRE0MUflgtUeG3La1nYdJ8eNUwPWQ+0u+IUOU6OiPewi2O1q
         096g==
X-Gm-Message-State: APjAAAUusSL4UA3kIS6FIXsFvZ/9jZ0J0UKFu6Qmo5xs0JsI9gc3Y/tQ
        nVU3wR+Kyjy9mzJL08bJTPB9z5qp
X-Google-Smtp-Source: APXvYqz73aVhhcZZM8O6aBQ30eNTzAltzTPWkKENEtP/XGXwIMdgwgsyCbfHqad60okZX+Btibbwhg==
X-Received: by 2002:ac2:430d:: with SMTP id l13mr17638281lfh.112.1576506486503;
        Mon, 16 Dec 2019 06:28:06 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id w19sm8891725lfl.55.2019.12.16.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 06:28:05 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1igrLv-0004Fn-FQ; Mon, 16 Dec 2019 15:28:03 +0100
Date:   Mon, 16 Dec 2019 15:28:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brant Merryman <Brant.Merryman@silabs.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proper RTS control when buffers fill
Message-ID: <20191216142803.GE22665@localhost>
References: <E0F3E0D5-4652-4DF0-B576-3FDB0274A5CD@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0F3E0D5-4652-4DF0-B576-3FDB0274A5CD@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, please use the common "USB: serial: cp210x: " prefix for
your changes.

On Mon, Dec 09, 2019 at 07:17:26PM +0000, Brant Merryman wrote:
> Enables usb generic functions for throttle/unthrottle to prevent USB data
> loss. CP210x hardware disables RTS but leaves CTS when in hardware flow
> control mode and port is closed. When re-opening the serial port, if CTS
> is enabled, then RTS must be re-enabled inside the driver.

This took a while to parse, but makes a little more sense after looking
at the code and remembering that cp210x unlike other drivers is fetching
the termios settings from the device on every open rather than simply
reinitialising the device. Perhaps we should change that at some point.  

Please rephrase the above to say "auto-RTS" ("auto-CTS") so it doesn't
sound like we're controlling the state of the CTS input line (which
obviously makes no sense). Same for the comment in the code below.

I also think you should split this in two patches since these are
strictly two distinct issues; the first one fixing the auto-RTS settings
after reopening the port, and the second adding the throttle callbacks
so that the device can tell when the application can't keep up.

> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
> ---
>  drivers/usb/serial/cp210x.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index f5143eedbc48..fd54181e741b 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -272,6 +272,8 @@ static struct usb_serial_driver cp210x_device = {
>  	.break_ctl		= cp210x_break_ctl,
>  	.set_termios		= cp210x_set_termios,
>  	.tx_empty		= cp210x_tx_empty,
> +	.throttle		= usb_serial_generic_throttle,
> +	.unthrottle		= usb_serial_generic_unthrottle,
>  	.tiocmget		= cp210x_tiocmget,
>  	.tiocmset		= cp210x_tiocmset,
>  	.attach			= cp210x_attach,
> @@ -915,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	u32 baud;
>  	u16 bits;
>  	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
>  
> @@ -1013,8 +1016,24 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>  			sizeof(flow_ctl));
>  	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +	/* CP210x hardware disables RTS but leaves CTS when in hardware
> +	 * flow control mode and port is closed.
> +	 * This allows data to flow out, but new data will not come into
> +	 * the port. When re-opening the port, if CTS is enabled, then RTS
> +	 * must be re-enabled. in the driver
> +	 */

This isn't strictly true since we assert RTS in cp210x_dtr_rts() after
open() (but auto-RTS would incorrectly be disabled).

Also can you be a bit more specific here; is it the interface-disable
call in close() that unconditionally sets the RTS mode to "statically
inactive"?

Nits: Please fix the full-stop in the last sentence and use the right
format for multi-line comments, which is:

	/*
	 * blah, blah
	 */

Perhaps move the comment inside the if block (after dev_dbg()) as well.

>  	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
>  		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
> +		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
> +		flow_repl |= CP210X_SERIAL_RTS_SHIFT(
> +			CP210X_SERIAL_RTS_FLOW_CTL);

Indent continuation lines at least two tabs further, but here I'd
probably just break the 80-column rule if that's even an issue.

> +
> +		flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);

Not needed, you're only changing flow_repl.

> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		cp210x_write_reg_block(port, CP210X_SET_FLOW,
> +			&flow_ctl, sizeof(flow_ctl));

At least two tabs here too.

> +
>  		cflag |= CRTSCTS;
>  	} else {
>  		dev_dbg(dev, "%s - flow control = NONE\n", __func__);

Johan
