Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B493C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324FA20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfJP01Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLPKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:03:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfLPKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:03:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so6044930wmb.0;
        Mon, 16 Dec 2019 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9P8jBTs9zw6Ol4dKdAPb/e2sHj445qXLj5Iw9i7C4Ps=;
        b=kfJP01GuFEZfr3N8JkWq0PmRACeIh6NhoqIAjnMoLtFOIlgzLjYt2RY2dfyY/LxBhV
         zzYy1qinUM3g/R+F1GCgcWcU0RDzR+9l9g7Sfvy2jxG45J4BsbJqPKyHoCwQE6+35ls4
         vbfRxvyMbZO2jSQPpSZtiVaBJajgqcveIMz8IGVn+Y6yKHhBCN+h4GcucUOHt+tQgLjc
         dcdAGf6GnkqJ1qZ0WMQwbUG4NyATltTiUarhQtHvLKmH/BmthkT1JssFzQojt3ImC3vn
         2C1fYUyywVcj6F54LhfBBZaFLJxFBt8d1nu5St8thR2zQE6s6ehmKb7kvE7U/hYq+c15
         ZhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9P8jBTs9zw6Ol4dKdAPb/e2sHj445qXLj5Iw9i7C4Ps=;
        b=W9rHe1pv9J5tra2jzZNDInvX+7a3syY11UW/ce+UaYTKOeG1LPexp/d0JrFnXwYuZU
         XXZkPKGEDazmyiotTo+pJ4JUdf/xAff85qtddW4u7ixw2MKC1wAd2DOh9voSknyUDGsi
         9YCir029if6hIlUYV4ubtZX3XQR313WtR77Vj0xXWZoR95wmPNkuaOhm1lPaOqpMsFPB
         e46f7myivIwAt/mFzU3JHGFYzcC/eQ3wtNose5R3/yEGKDLECQgqVgIxwzFOEVClZGyi
         h8YqCS4RUbKv523VAUJUVwXqldjmf2el3GryIQuK0Kk15ldfoPbI/iMv66AashsSqfoL
         ldGw==
X-Gm-Message-State: APjAAAXyJI7fauBF5NMku5yhxCQV3n0UIvggWqzQuLGKy5nexTCIdjUo
        77xtOuDCQcTl9wpWSTXy9rik1kKK
X-Google-Smtp-Source: APXvYqwyyDlQJPuXpWd8PbXbRW62iyLDQsoAuPqc+9/ik9zLPdkwowIE1iaVHJr+B7Pq3O0ku0ZENA==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr30059955wmm.143.1576490613116;
        Mon, 16 Dec 2019 02:03:33 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id x132sm22257813wmg.0.2019.12.16.02.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 02:03:32 -0800 (PST)
Subject: Re: [PATCH v3] tty/serial: atmel: fix out of range clock divider
 handling
To:     David Engraf <david.engraf@sysgo.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <39e4d1c7-20b0-a024-3a46-e4d4369eed8e@sysgo.com>
 <20191216085403.17050-1-david.engraf@sysgo.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <035748de-1265-b2ba-9832-898782bcccf3@gmail.com>
Date:   Mon, 16 Dec 2019 11:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216085403.17050-1-david.engraf@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/12/2019 à 09:54, David Engraf a écrit :
> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
> register was already written thus the clock selection is ignored.
> 
> Fix by doing the baud rate calulation before setting the mode.
> 
> Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Acked-by: Richard Genoud <richard.genoud@gmail.com>


> ---
> Changes since v1: 
>  - moves set baud rate block before setting the mode register because
>    ATMEL_US_RTSDIS and ATMEL_US_RTSEN depend on ATMEL_US_MR.mode
> 
> ---
>  drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a8dc8af83f39..1ba9bc667e13 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2270,27 +2270,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		mode |= ATMEL_US_USMODE_NORMAL;
>  	}
>  
> -	/* set the mode, clock divisor, parity, stop bits and data size */
> -	atmel_uart_writel(port, ATMEL_US_MR, mode);
> -
> -	/*
> -	 * when switching the mode, set the RTS line state according to the
> -	 * new mode, otherwise keep the former state
> -	 */
> -	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
> -		unsigned int rts_state;
> -
> -		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
> -			/* let the hardware control the RTS line */
> -			rts_state = ATMEL_US_RTSDIS;
> -		} else {
> -			/* force RTS line to low level */
> -			rts_state = ATMEL_US_RTSEN;
> -		}
> -
> -		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
> -	}
> -
>  	/*
>  	 * Set the baud rate:
>  	 * Fractional baudrate allows to setup output frequency more
> @@ -2317,6 +2296,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
>  		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
> +
> +	/* set the mode, clock divisor, parity, stop bits and data size */
> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
> +
> +	/*
> +	 * when switching the mode, set the RTS line state according to the
> +	 * new mode, otherwise keep the former state
> +	 */
> +	if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
> +		unsigned int rts_state;
> +
> +		if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
> +			/* let the hardware control the RTS line */
> +			rts_state = ATMEL_US_RTSDIS;
> +		} else {
> +			/* force RTS line to low level */
> +			rts_state = ATMEL_US_RTSEN;
> +		}
> +
> +		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
> +	}
> +
>  	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>  	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
>  	atmel_port->tx_stopped = false;
> 

Thanks !
