Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCROav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:30:51 -0400
Received: from mout01.posteo.de ([185.67.36.141]:59085 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfCROau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:30:50 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EFDE4160060
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:30:47 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44NJWT3PTtz6tmQ;
        Mon, 18 Mar 2019 15:30:45 +0100 (CET)
Subject: Re: [PATCH 2/2] tty/serial: atmel: RS485 HD w/DMA: enable RX after TX
 is stopped
To:     Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Gil Weber <webergil@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190315092334.13246-1-razvan.stefanescu@microchip.com>
 <20190315092334.13246-3-razvan.stefanescu@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <cb09f654-1c42-4f0c-25d3-5cb1708d6080@sorico.fr>
Date:   Mon, 18 Mar 2019 15:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315092334.13246-3-razvan.stefanescu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Gil Weber in Cc: ]
Le 15/03/2019 à 10:23, Razvan Stefanescu a écrit :
> In half-duplex operation, RX should be started after TX completes.
> 
> If DMA is used, there is a case when the DMA transfer completes but the
> TX FIFO is not emptied, so the RX cannot be restarted just yet.
> 
> Use a boolean variable to store this state and rearm TX interrupt mask
> to be signaled again that the transfer finished. In interrupt transmit
> handler this variable is used to start RX.

I was sure I've already seen something like that.
Gil, could you give it a test ?

you can add :
Cc: stable@vger.kernel.org
Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable RX after TX is done")

Since patch 1/2 is needed for this one, I think you should add also
Cc:stable / Fixes: to the previous patch.

> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a6577b1c4461..b0141dcbbb61 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -166,6 +166,8 @@ struct atmel_uart_port {
>  	unsigned int		pending_status;
>  	spinlock_t		lock_suspended;
>  
> +	bool			hd_start_rx;	/* can start RX during half-duplex operation */
> +
>  	/* ISO7816 */
>  	unsigned int		fidi_min;
>  	unsigned int		fidi_max;
> @@ -934,8 +936,13 @@ static void atmel_complete_tx_dma(void *arg)
>  	if (!uart_circ_empty(xmit))
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
>  	else if (atmel_uart_is_half_duplex(port)) {
> -		/* DMA done, stop TX, start RX for RS485 */
> -		atmel_start_rx(port);
> +		/*
> +		 * DMA done, re-enable TXEMPTY and signal that we can stop
> +		 * TX and start RX for RS485
> +		 */
> +		atmel_port->hd_start_rx = true;
> +		atmel_uart_writel(port, ATMEL_US_IER,
> +				  atmel_port->tx_done_mask);
>  	}
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
> @@ -1379,9 +1386,21 @@ atmel_handle_transmit(struct uart_port *port, unsigned int pending)
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
>  	if (pending & atmel_port->tx_done_mask) {
> -		/* Either PDC or interrupt transmission */
>  		atmel_uart_writel(port, ATMEL_US_IDR,
>  				  atmel_port->tx_done_mask);
> +
> +		/* Start RX if flag was set and FIFO is empty */
> +		if (atmel_port->hd_start_rx) {
> +			if (atmel_uart_readl(port, ATMEL_US_CSR)
> +					& ATMEL_US_TXEMPTY) {
> +				atmel_port->hd_start_rx = false;
> +				atmel_start_rx(port);
> +			} else {
> +				dev_warn(port->dev, "Should start RX, but TX fifo is not empty\n");
What will happen in this case ?

> +			}
> +			return;
> +		}
> +
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
>  	}
>  }
> 

Thanks !
