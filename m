Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69276C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B323218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562143348;
	bh=RkUibetf62ACzLFBPxDyavpMjq5OFxUImT7HOXl92Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKy0IYMm2tZON0E+K70lSFdM8QduuiIwlPWCu4ZOs0ktMFNu67APQSXtiwkNB6ed3
	 YA0B8fyyWIIBGLXKEuywOfKwO9iJ1SWvdesmI4j0Nie1AN9wcA7kemSmUEolDAFieK
	 PIgrcrpsRqU/r9c7RphnX22NaOcoGaR0pYyGX6+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGCIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfGCIm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:42:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAA7218A0;
        Wed,  3 Jul 2019 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562143343;
        bh=RkUibetf62ACzLFBPxDyavpMjq5OFxUImT7HOXl92Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUVmWqwzGJEt+nkoh3V1lPWgiTwA+3qwJhUTaw5j6W5GkBhHVfleO5lSQvBnBd2Mk
         4LuMP2s5b6GHyC43ztRAxTyGeL4CYixIFu+2T0HxAyQebTdxF9qtw1lDEovsxlxSTZ
         IkzFZONaDXjPjPJcygLyG7wmttQUe/+90fGMQnRI=
Date:   Wed, 3 Jul 2019 10:42:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190703084220.GD8996@kroah.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703072435.34152-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>

I need a "full" name here please.

Also, this patch breaks the build, which is not allowed, and makes me
wonder how you tested it :(

Please fix up properly and resend.

Also, some comments below:

> ---
>  drivers/tty/serial/8250/8250_pci.c | 293 ++++++++++++++++++++++++++++-
>  1 file changed, 289 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index df41397de478..ac8138adea9c 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
>  }
>  
>  /* UART Port Control Register */
> -#define NI8430_PORTCON	0x0f
> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)

Why are you renaming these #defines?

> +#define NI16550_PCR_OFFSET	0x0f
> +#define NI16550_PCR_RS422	0x00
> +#define NI16550_PCR_ECHO_RS485	0x01
> +#define NI16550_PCR_DTR_RS485	0x02
> +#define NI16550_PCR_AUTO_RS485	0x03
> +#define NI16550_PCR_WIRE_MODE_MASK	0x03
> +#define NI16550_PCR_TXVR_ENABLE_BIT	(1 << 3)

BIT(3)?

> +#define NI16550_PCR_RS485_TERMINATION_BIT	(1 << 6)

BIT(6)?

> +#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
> +#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
>  
>  static int
>  pci_ni8430_setup(struct serial_private *priv,
> @@ -753,14 +761,127 @@ pci_ni8430_setup(struct serial_private *priv,
>  		return -ENOMEM;
>  
>  	/* enable the transceiver */
> -	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
> -	       p + offset + NI8430_PORTCON);
> +	writeb(readb(p + offset + NI16550_PCR_OFFSET) |
> +			NI16550_PCR_TXVR_ENABLE_BIT,
> +			p + offset + NI16550_PCR_OFFSET);

Why indent like this?  Please follow the indentation that used to be
there.

>  
>  	iounmap(p);
>  
>  	return setup_port(priv, port, bar, offset, board->reg_shift);
>  }
>  
> +static int pci_ni8431_config_rs485(struct uart_port *port,
> +	struct serial_rs485 *rs485)
> +{
> +	u8 pcr, acr;
> +
> +	struct uart_8250_port *up;
> +
> +	up = container_of(port, struct uart_8250_port, port);
> +
> +	acr = up->acr;
> +
> +	dev_dbg(port->dev, "ni16550_config_rs485\n");

No need for debugging lines like this, use ftrace please.

> +
> +	/* "rs485" should be given to us non-NULL. */
> +	WARN_ON(rs485 == NULL);

Don't crash people's machines, if this can never happen, then no need
for this line.  If it can happen, test and properly return an error.

> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */
> +		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
> +			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> +			dev_dbg(port->dev, "Invalid 2-wire mode\n");
> +			return -EINVAL;
> +		}
> +
> +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> +			/* Echo */
> +			dev_vdbg(port->dev, "2-wire DTR with echo\n");
> +			pcr |= NI16550_PCR_ECHO_RS485;
> +			acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +		} else {
> +			/* Auto or DTR */
> +			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> +				/* Auto */
> +				dev_vdbg(port->dev, "2-wire Auto\n");
> +				pcr |= NI16550_PCR_AUTO_RS485;
> +				acr |= NI16550_ACR_DTR_AUTO_DTR;
> +			} else {
> +				/* DTR-controlled */
> +				/* No Echo */
> +				dev_vdbg(port->dev, "2-wire DTR no echo\n");
> +				pcr |= NI16550_PCR_DTR_RS485;
> +				acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +			}
> +		}
> +	} else {
> +		/* RS-422 */
> +		dev_vdbg(port->dev, "4-wire\n");
> +		pcr |= NI16550_PCR_RS422;
> +		acr |= NI16550_ACR_DTR_MANUAL_DTR;
> +	}
> +
> +	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	up->acr = acr;
> +	port->serial_out(port, UART_SCR, UART_ACR);
> +	port->serial_out(port, UART_ICR, up->acr);
> +
> +	/* Update the cache. */
> +	port->rs485 = *rs485;
> +
> +	dev_dbg(port->dev, "ni16550_config_rs485\n");

Again, use ftrace, not dev_dbg() for stuff like this.

thanks,

greg k-h
