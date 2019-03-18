Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD589C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A883C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCRNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:41:44 -0400
Received: from mout02.posteo.de ([185.67.36.142]:36951 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCRNlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:41:44 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 88ED82400E5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:41:41 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44NHQq2zpLz9rxR;
        Mon, 18 Mar 2019 14:41:38 +0100 (CET)
Subject: Re: [PATCH 1/2] tty/serial: atmel: Add is_half_duplex helper
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
 <20190315092334.13246-2-razvan.stefanescu@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <c8ee3b11-e674-4992-c24f-b0434887a21e@sorico.fr>
Date:   Mon, 18 Mar 2019 14:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315092334.13246-2-razvan.stefanescu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Gil Weber in Cc: ]

Le 15/03/2019 à 10:23, Razvan Stefanescu a écrit :
> Use a helper function to check that a port needs to use half duplex
> communication, replacing several occurrences of multi-line bit checking.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..a6577b1c4461 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -231,6 +231,13 @@ static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
>  	__raw_writeb(value, port->membase + ATMEL_US_THR);
>  }
>  
> +static inline int atmel_uart_is_half_duplex(struct uart_port *port)
> +{
> +	return ((port->rs485.flags & SER_RS485_ENABLED) &&
> +		!(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> +		(port->iso7816.flags & SER_ISO7816_ENABLED);
> +}
> +
>  #ifdef CONFIG_SERIAL_ATMEL_PDC
>  static bool atmel_use_pdc_rx(struct uart_port *port)
>  {
> @@ -608,10 +615,10 @@ static void atmel_stop_tx(struct uart_port *port)
>  	/* Disable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
> -	if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -	    port->iso7816.flags & SER_ISO7816_ENABLED)
> -		atmel_start_rx(port);
> +	if (atmel_uart_is_half_duplex(port))
> +		if (!atomic_read(&atmel_port->tasklet_shutdown))
This check wasn't there before.
If it's really needed, please insert it in another patch and explain why
it's needed.

> +			atmel_start_rx(port);
> +
>  }
>  
>  /*
> @@ -628,9 +635,7 @@ static void atmel_start_tx(struct uart_port *port)
>  		return;
>  
>  	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
> -		if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		    port->iso7816.flags & SER_ISO7816_ENABLED)
> +		if (atmel_uart_is_half_duplex(port))
>  			atmel_stop_rx(port);
>  
>  	if (atmel_use_pdc_tx(port))
> @@ -928,9 +933,7 @@ static void atmel_complete_tx_dma(void *arg)
>  	 */
>  	if (!uart_circ_empty(xmit))
>  		atmel_tasklet_schedule(atmel_port, &atmel_port->tasklet_tx);
> -	else if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		  !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		 port->iso7816.flags & SER_ISO7816_ENABLED) {
> +	else if (atmel_uart_is_half_duplex(port)) {
>  		/* DMA done, stop TX, start RX for RS485 */
>  		atmel_start_rx(port);
>  	}
> @@ -1508,9 +1511,7 @@ static void atmel_tx_pdc(struct uart_port *port)
>  		atmel_uart_writel(port, ATMEL_US_IER,
>  				  atmel_port->tx_done_mask);
>  	} else {
> -		if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -		     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -		    port->iso7816.flags & SER_ISO7816_ENABLED) {
> +		if (atmel_uart_is_half_duplex(port)) {
>  			/* DMA done, stop TX, start RX for RS485 */
>  			atmel_start_rx(port);
>  		}
> 

