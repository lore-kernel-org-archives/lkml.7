Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA1C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0C20848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578394187;
	bh=hj5Ofem7QaFRGtGYasAZLFhJrthKQ3jmVb1gGcmhWog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KjxOXDJQQOitt0/vMOBR9q2sJLuMPQvMqknnAuVXOyaMcNrzc8C+7iVz7lZHoX8rB
	 7wAacYXXqnxUtdzcUYwWexfD9UzzWYCl1MT1we2lpb7y8SztWbWT1t/bQ764YEqjcw
	 kjLy6yeBWID2bFCEZlKIju1nquPRMlQHcMWGpjJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgAGKtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:49:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43190 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgAGKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:49:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so54202160ljm.10;
        Tue, 07 Jan 2020 02:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igqXhyBK3Tw7qA7fPi39REnLMkJjJzXKeEqTbYMsdYc=;
        b=l0jHNItq2YYyLLI71+2CMZbLiSREa/SoFLNKA8bzoB5kmQTT4AZExaG9MAYUFi1Po7
         G6ojapTgMtFvQ6+siaUyi+408Bh3dj3w6eY9Q/IQ1+1IkltZ9edHl6u/5XfXFjOQFyOf
         R4CtJFR+AhtvrFPOO2+o+JPJCV8AitRFi35ViK0yFexuCyiX6RYpnykK7iFVeYxU8TPd
         Rlq7pS9nUSlwPZXdmSmxBEz3nUJixt5bLz4fAkUNNMCb5e0umTjXbkNkgshi+6xSyxF6
         0bKn7EF+gTbBCjab6/1lRV/Jj7Ob5oX5LGQD+tTZgzP0tXVkPx8lUHvem3kQi7cFOnFy
         8MLA==
X-Gm-Message-State: APjAAAUrsf6YQOJOgeHuI3DlizmWBCyq2Wy74vpkEG7X3OQM3DDla77Y
        mjVDxSQUuk87UqDds9gRZUCTIlLC
X-Google-Smtp-Source: APXvYqyk7taw7aH61gPaO4/Bcm/IwyyD5N215qxAFhujxVFAEo3QZ8nXKpzfCjkOxDNawX2QfScHWg==
X-Received: by 2002:a2e:a168:: with SMTP id u8mr54938973ljl.5.1578394183491;
        Tue, 07 Jan 2020 02:49:43 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id i4sm30438434ljg.102.2020.01.07.02.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:49:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iomQo-0005N9-Nw; Tue, 07 Jan 2020 11:49:50 +0100
Date:   Tue, 7 Jan 2020 11:49:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brant Merryman <Brant.Merryman@silabs.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Re: [PATCH] Proper RTS control when buffers fill
Message-ID: <20200107104950.GD30908@localhost>
References: <4C7B31CD-2DD2-4824-AE67-9280199703BE@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C7B31CD-2DD2-4824-AE67-9280199703BE@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:40:48PM +0000, Brant Merryman wrote:

You forgot to add the Subject prefix.

> CP210x hardware disables auto-RTS but leaves auto-CTS when
> in hardware flow control mode and UART on cp210x hardware
> is disabled. This allows data to flow out, but new data
> will not come into the port. When re-opening the port, if
> auto-CTS is enabled on the cp210x, then auto-RTS must be
> re-enabled in the driver.
> 
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
> ---
>  drivers/usb/serial/cp210x.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index bcceb4ad8be0..74c9f3822bd2 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -917,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	u32 baud;
>  	u16 bits;
>  	u32 ctl_hs;
> +	u32 flow_repl;
>  
>  	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
>  
> @@ -1015,8 +1016,24 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
>  			sizeof(flow_ctl));
>  	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);

Move inside the if block (after the comment).

>  	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
>  		dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
> +		/*
> +		 * CP210x hardware disables auto-RTS but leaves auto-CTS when
> +		 * in hardware flow control mode and UART on cp210x hardware
> +		 * is disabled. This allows data to flow out, but new data
> +		 * will not come into the port. When re-opening the port, if
> +		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
> +		 * re-enabled in the driver.
> +		 */

Maybe drop the "allows data to flow out" bit, the uart has been disabled
after all, right? And RTS is asserted on open by the TTY layer anyway so
data should flow in once opened.

As I asked you before, could you be more specific about what state
RTS-line end up in when disabling the UART (e.g. 0x00: statically
inactive)?

> +		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
> +		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
> +
> +		flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);

Again, this line is not needed.

> +		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
> +		cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl, sizeof(flow_ctl));

You still need to break this line. 

> +
>  		cflag |= CRTSCTS;
>  	} else {
>  		dev_dbg(dev, "%s - flow control = NONE\n", __func__);

Johan
