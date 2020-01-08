Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52599C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E96206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmuPlTPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgAHNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:45:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41800 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAHNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:45:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so3409634wrw.8;
        Wed, 08 Jan 2020 05:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D3julrEGzeRkkk1/rWpHeUHdil17WhFSKQb41qCTkXU=;
        b=CmuPlTPtnDvtw5DZ0Qf+AY+3PDSptqSxspoms4tKXIS/QIm9A/auA6Wxgw6pNAFKoj
         td3GiUU5IqaNXopILg9AOXGMdZJBjW+mxw5FH/7rBL7o1vJUI3CaYhwZc54Nabakzoxm
         PuwKFLdRoJbfMZgcP1nbKTTBGDVNKS+EpEvsjC++htmhdwlVOzgv14/W8HD1c+avG5zs
         Bz+97NWA68uVKIO42UHin7omXsXG58hs9b5R3d0hEKuOtHul2VZfK9KXMAC5+y1VVWU7
         DYLtTaL0yRzdEA6h133vRPEktQdes5CG2TgYgryZ4DnLXJ9Zdd9v00DQDOT4RZ6fNy4x
         ox6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3julrEGzeRkkk1/rWpHeUHdil17WhFSKQb41qCTkXU=;
        b=dHK6jUjKKITCsPZyfAuYD8MXs21SqpA5QsbbOl9PJl1O9nMSGcQ6CqO3hWvyuIFSUh
         hSoxAosHqonMm5MCDvT1ogqzOr17eEgIC01/2KGrXEXzTWQDrG2Cj8XYVbc20gy0yZxp
         OWNTaYlZFOA122/CapRmyLCx+O4TXHUE3+/adrRL1mtbfM/VMpy9JaqMwfc72RlGsCTy
         XoTGeXZCyPpBMwFPAASYDnCoGJwnXDFipuW5JX1jeASwi4BPSjHdAQkzNj1XqA3JZ8L7
         DFMuh3MryvBfBNHaUXcCpwT/jb/8ONAXKk0kSf4EMI4/DfLuu3upo1uo7CfXevX1P7yN
         4IVw==
X-Gm-Message-State: APjAAAXXolDQpQRcxTZj1cbCEabt2PG9iy5+mZXRWLZMSvXbV2CBQPwF
        DmLEF5U+QCm5g9GghIuknD8=
X-Google-Smtp-Source: APXvYqydIJGVwu3LvXKaQvn9RIqZzW5YK/ku5ofvBCC4NqIuj7GDOYB1gSeRTb1/toIU8zIihyDBJg==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr4726450wrs.365.1578491111308;
        Wed, 08 Jan 2020 05:45:11 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id f127sm3821358wma.4.2020.01.08.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 05:45:10 -0800 (PST)
Subject: Re: [PATCH] tty/serial: atmel: RS485 & ISO7816: wait for TXRDY before
 sending data
To:     Codrin.Ciubotariu@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
References: <20200107111656.26308-1-codrin.ciubotariu@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <b11e47c3-8b94-7915-ae5a-d9e8f5b02047@gmail.com>
Date:   Wed, 8 Jan 2020 14:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107111656.26308-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/01/2020 à 12:17, Codrin.Ciubotariu@microchip.com a écrit :
> At this moment, TXEMPTY is checked before sending data on RS485 and ISO7816
> modes. However, TXEMPTY is risen when FIFO (if used) or the Transmit Shift
> Register are empty, even though TXRDY might be up and controller is able to
> receive data. Since the controller sends data only when TXEMPTY is ready,
> on RS485, when DMA is not used, the RTS pin is driven low after each byte.
> With this patch, the characters will be transmitted when TXRDY is up and
> so, RTS pin will remain high between bytes.
> The performance improvement on RS485 is about 8% with a baudrate of 300.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
seems ok to me
Acked-by: Richard Genoud <richard.genoud@gmail.com>

NB: MS exchange has added some =3D and =20 here and there, but git am
doesn't seems to be bothered by them.
> ---
>  drivers/tty/serial/atmel_serial.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a8dc8af83f39..19c8fb9faa36 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -313,7 +313,11 @@ static int atmel_config_rs485(struct uart_port *port,
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>  		dev_dbg(port->dev, "Setting UART to RS485\n");
> -		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
> +		if (port->rs485.flags & SER_RS485_RX_DURING_TX)
> +			atmel_port->tx_done_mask = ATMEL_US_TXRDY;
> +		else
> +			atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
> +
>  		atmel_uart_writel(port, ATMEL_US_TTGR,
>  				  rs485conf->delay_rts_after_send);
>  		mode |= ATMEL_US_USMODE_RS485;
> @@ -831,7 +835,7 @@ static void atmel_tx_chars(struct uart_port *port)
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
>  	if (port->x_char &&
> -	    (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_mask)) {
> +	    (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY)) {
>  		atmel_uart_write_char(port, port->x_char);
>  		port->icount.tx++;
>  		port->x_char = 0;
> @@ -839,8 +843,7 @@ static void atmel_tx_chars(struct uart_port *port)
>  	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
>  		return;
>  
> -	while (atmel_uart_readl(port, ATMEL_US_CSR) &
> -	       atmel_port->tx_done_mask) {
> +	while (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY) {
>  		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
>  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>  		port->icount.tx++;
> @@ -851,10 +854,20 @@ static void atmel_tx_chars(struct uart_port *port)
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  
> -	if (!uart_circ_empty(xmit))
> +	if (!uart_circ_empty(xmit)) {
> +		/* we still have characters to transmit, so we should continue
> +		 * transmitting them when TX is ready, regardless of
> +		 * mode or duplexity
> +		 */
> +		atmel_port->tx_done_mask |= ATMEL_US_TXRDY;
> +
>  		/* Enable interrupts */
>  		atmel_uart_writel(port, ATMEL_US_IER,
>  				  atmel_port->tx_done_mask);
> +	} else {
> +		if (atmel_uart_is_half_duplex(port))
> +			atmel_port->tx_done_mask &= ~ATMEL_US_TXRDY;
> +	}
>  }
>  
>  static void atmel_complete_tx_dma(void *arg)
> @@ -2525,8 +2538,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>  	 * Use TXEMPTY for interrupt when rs485 or ISO7816 else TXRDY or
>  	 * ENDTX|TXBUFE
>  	 */
> -	if (port->rs485.flags & SER_RS485_ENABLED ||
> -	    port->iso7816.flags & SER_ISO7816_ENABLED)
> +	if (atmel_uart_is_half_duplex(port))
>  		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
>  	else if (atmel_use_pdc_tx(port)) {
>  		port->fifosize = PDC_BUFFER_SIZE;
> 

