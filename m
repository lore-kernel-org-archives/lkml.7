Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B36208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564502172;
	bh=4B/vzkA4mYOXvGcwF94yPQE77oH6h/5zeNReZSYHGsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uazWBz9Stg5nnbSgiGIck9Ru9QK8tQpTykaJIpok4RQ7y2CWICp0sp2WowaaZxVXA
	 dnAtEeyTziFInBvqhx1D/wrd3x/sRGkhGCU+m0Q0QfQII36NhaQX6pQpEec5ymy0QW
	 I2Ub9dGj4+LHWYo4F2Drfxtq2WynWGRiDDxA9S5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfG3P4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfG3P4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:56:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D309B20693;
        Tue, 30 Jul 2019 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564502170;
        bh=4B/vzkA4mYOXvGcwF94yPQE77oH6h/5zeNReZSYHGsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHtHJ5dLCuS6Q29r36KRFuq2Bfwo4m6pfBSq2Mzth8bQfIe+hLb7UqLDK4agnnEel
         +USPTAjnBBPfP2S17ql4yEnDBG1xh591mrff53qiU0rOLZaWW2oftoch3nX5Vdp1l9
         9KIjkSayo2SiULZvSbjWnIAwjgGSccxsJRv7bhxY=
Date:   Tue, 30 Jul 2019 17:56:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/24] tty: serial: fsl_lpuart: Introduce
 lpuart_tx_dma_startup()
Message-ID: <20190730155608.GA3990@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-20-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729195226.8862-20-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:52:21PM -0700, Andrey Smirnov wrote:
> Code configure DMA TX path in lpuart_startup(), lpuart32_startup() and
> lpuart_resume() is doing exactly the same thing, so move it into a
> standalone subroutine.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-imx@nxp.com
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/tty/serial/fsl_lpuart.c | 53 ++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 2ad5750fe511..558acf29cbed 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1434,6 +1434,26 @@ static void rx_dma_timer_init(struct lpuart_port *sport)
>  	add_timer(&sport->lpuart_timer);
>  }
>  
> +static void lpuart_tx_dma_startup(struct lpuart_port *sport)
> +{
> +	u32 uartbaud;
> +
> +	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> +		init_waitqueue_head(&sport->dma_wait);
> +		sport->lpuart_dma_tx_use = true;
> +		if (lpuart_is_32(sport)) {
> +			uartbaud = lpuart32_read(&sport->port, UARTBAUD);
> +			lpuart32_write(&sport->port,
> +				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
> +		} else {
> +			writeb(readb(sport->port.membase + UARTCR5) |
> +				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> +		}
> +	} else {
> +		sport->lpuart_dma_tx_use = false;
> +	}
> +}
> +
>  static int lpuart_startup(struct uart_port *port)
>  {
>  	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
> @@ -1471,14 +1491,7 @@ static int lpuart_startup(struct uart_port *port)
>  		sport->lpuart_dma_rx_use = false;
>  	}
>  
> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> -		init_waitqueue_head(&sport->dma_wait);
> -		sport->lpuart_dma_tx_use = true;
> -		temp = readb(port->membase + UARTCR5);
> -		writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);
> -	} else {
> -		sport->lpuart_dma_tx_use = false;
> -	}
> +	lpuart_tx_dma_startup(port);
>  
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  
> @@ -1522,14 +1535,7 @@ static int lpuart32_startup(struct uart_port *port)
>  		sport->lpuart_dma_rx_use = false;
>  	}
>  
> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(port)) {
> -		init_waitqueue_head(&sport->dma_wait);
> -		sport->lpuart_dma_tx_use = true;
> -		temp = lpuart32_read(&sport->port, UARTBAUD);
> -		lpuart32_write(&sport->port, temp | UARTBAUD_TDMAE, UARTBAUD);
> -	} else {
> -		sport->lpuart_dma_tx_use = false;
> -	}
> +	lpuart_tx_dma_startup(port);
>  
>  	if (sport->lpuart_dma_rx_use) {
>  		/* RXWATER must be 0 */
> @@ -2581,20 +2587,7 @@ static int lpuart_resume(struct device *dev)
>  		}
>  	}
>  
> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
> -		init_waitqueue_head(&sport->dma_wait);
> -		sport->lpuart_dma_tx_use = true;
> -		if (lpuart_is_32(sport)) {
> -			temp = lpuart32_read(&sport->port, UARTBAUD);
> -			lpuart32_write(&sport->port,
> -				       temp | UARTBAUD_TDMAE, UARTBAUD);
> -		} else {
> -			writeb(readb(sport->port.membase + UARTCR5) |
> -				UARTCR5_TDMAS, sport->port.membase + UARTCR5);
> -		}
> -	} else {
> -		sport->lpuart_dma_tx_use = false;
> -	}
> +	lpuart_tx_dma_startup(sport);
>  
>  	if (lpuart_is_32(sport)) {
>  		if (sport->lpuart_dma_rx_use) {
> -- 
> 2.21.0
> 

This patch breaks the build:

drivers/tty/serial/fsl_lpuart.c: In function lpuart_startup:
drivers/tty/serial/fsl_lpuart.c:1494:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
 1494 |  lpuart_tx_dma_startup(port);
      |                        ^~~~
      |                        |
      |                        struct uart_port *
drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
 1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
      |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
drivers/tty/serial/fsl_lpuart.c: In function lpuart32_startup:
drivers/tty/serial/fsl_lpuart.c:1537:24: error: passing argument 1 of lpuart_tx_dma_startup from incompatible pointer type [-Werror=incompatible-pointer-types]
 1537 |  lpuart_tx_dma_startup(port);
      |                        ^~~~
      |                        |
      |                        struct uart_port *
drivers/tty/serial/fsl_lpuart.c:1438:55: note: expected struct lpuart_port * but argument is of type struct uart_port *
 1438 | static void lpuart_tx_dma_startup(struct lpuart_port *sport)
      |                                   ~~~~~~~~~~~~~~~~~~~~^~~~~
cc1: some warnings being treated as errors


So I've stopped applying the series here.

Please fix up and resend the remaining ones.

thanks,

greg k-h
