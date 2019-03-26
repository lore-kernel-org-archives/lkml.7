Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9092C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD2020823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfCZPKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:10:22 -0400
Received: from mout02.posteo.de ([185.67.36.142]:45453 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZPKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:10:22 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8974D2400FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:10:19 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44TF1P5wS9z9rxR;
        Tue, 26 Mar 2019 16:10:17 +0100 (CET)
Subject: Re: [PATCH v2 1/2] tty/serial: atmel: Add is_half_duplex helper
To:     Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Gil Weber <webergil@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190319132035.18481-1-razvan.stefanescu@microchip.com>
 <20190319132035.18481-2-razvan.stefanescu@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <fc6d0053-0b87-539b-8733-443494613858@sorico.fr>
Date:   Tue, 26 Mar 2019 16:10:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319132035.18481-2-razvan.stefanescu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/03/2019 à 14:20, Razvan Stefanescu a écrit :
> Use a helper function to check that a port needs to use half duplex
> communication, replacing several occurrences of multi-line bit checking.
> 
> Fixes: b389f173aaa1 ("tty/serial: atmel: RS485 half duplex w/DMA: enable
> RX after TX is done")
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

NB: backport on kernel older than 4.20 will fail because of the
SER_ISO7816_ENABLED flag.
> ---
> Changelog:
> v2: 
>   - remove extra check
>   - add fix info
> 
>  drivers/tty/serial/atmel_serial.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 05147fe24343..b4b89a16a41b 100644
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
> @@ -608,10 +615,9 @@ static void atmel_stop_tx(struct uart_port *port)
>  	/* Disable interrupts */
>  	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
>  
> -	if (((port->rs485.flags & SER_RS485_ENABLED) &&
> -	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
> -	    port->iso7816.flags & SER_ISO7816_ENABLED)
> +	if (atmel_uart_is_half_duplex(port))
>  		atmel_start_rx(port);
> +
>  }
>  
>  /*
> @@ -628,9 +634,7 @@ static void atmel_start_tx(struct uart_port *port)
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
> @@ -928,9 +932,7 @@ static void atmel_complete_tx_dma(void *arg)
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
> @@ -1508,9 +1510,7 @@ static void atmel_tx_pdc(struct uart_port *port)
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

