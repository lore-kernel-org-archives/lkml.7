Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F88C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650E12073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujociCaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLMJ5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:57:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:57:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so5910605wrj.12;
        Fri, 13 Dec 2019 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dpNbKF4B4j4oXDchU1RrJO41reoDriPtS20xCTxdXFQ=;
        b=ujociCaQeo4UzEdyNQmDF7/4gRqJCdfMiazcOKOemDS4RDAPb3Urs8ZvPzvVTZOiwY
         78nwM1Mn17kew+jLZHAv+7bT2a5l8LurKCJLi0WSnEBIil9BXqZ+e+e6Cb4Wq9bE41Sc
         lIYpC54Z6W9q6QvulK4ngX1CfdDZ0QYUTwK+UygZgaFTtMU3EcQkp2eN8nN7XuTa5fGy
         CqHMNFzD82N3bJb/nJV9aSFu54KnIUAjQ4rwpWSyZTsyzbKKLVHF5NNO/9X3OLjjZbqe
         7XTN29xCCrLkhipC1CbeG1/0q8r6XtSj9Z1ljD6ZC4OHIyEmC0M064y9dClyic4pqYoX
         nrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dpNbKF4B4j4oXDchU1RrJO41reoDriPtS20xCTxdXFQ=;
        b=m+lFJQdeLg16WuXnMXiu6F5y8PpVnWW3tcDaExHRUrS4HsPzDWNsZT5sbSIQp22cPR
         P4hyHm9xDmOG6j8LGUBp/WUefptS7ncsQ8v58kOwyKW/AiVsqg6IphGCcBmsU6TDsQsU
         qA7pyKTTUahVTdFGCwW3X33zj0JRj7edddWXw5Vvt1bFjj3wKUJwUr5W0ZnYZiHWkQSE
         xBDJYr8F7NDTOC4miLzFfIk86vFmbUoqf0PzDrYEP8CBzAG3pX9ph16ivwhOqkTjvugN
         oD8OYIZR+KroEpojf6gHHEk9MNuVfE75N7GpTuAW0Lh31CYvsRmX8xr0o2J+pTIMcqYX
         2YVg==
X-Gm-Message-State: APjAAAUCJsVXzBd8qOkWaxTtkfHa0gJuP7JxX79YWFEh+U1A0HkvIKzu
        PbldpCPTTf3LoF8oT/C637dJiUe+
X-Google-Smtp-Source: APXvYqw/KxKkRXUonEjxr+p1HfHGF9/99eOKJSI1HzPVgp4nbjtBT1GLsgKgzov5u1Dn/l6wcsGj2w==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr11322198wrr.309.1576231071861;
        Fri, 13 Dec 2019 01:57:51 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id x10sm9327133wrv.60.2019.12.13.01.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 01:57:51 -0800 (PST)
Subject: Re: [PATCH] tty/serial: atmel: fix out of range clock divider
 handling
To:     David Engraf <david.engraf@sysgo.com>, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191211162954.8393-1-david.engraf@sysgo.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <822ac68e-4dde-21e8-caf9-a219b910d49e@gmail.com>
Date:   Fri, 13 Dec 2019 10:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211162954.8393-1-david.engraf@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 11/12/2019 à 17:29, David Engraf a écrit :
> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
> register was already written thus the clock selection is ignored.
> 
> Fix by writing the mode register after calculating the baudrate.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

It seems that this bug was introduced by:
commit 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")

Could you add the "Fixes:" header ?

Ludovic, could you check if this was your intent at the time ?

> ---
>  drivers/tty/serial/atmel_serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a8dc8af83f39..9983e2fabbac 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2270,9 +2270,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		mode |= ATMEL_US_USMODE_NORMAL;
>  	}
>  
I think it's better to mo move the "Set baud rate" block here (cf bellow)

> -	/* set the mode, clock divisor, parity, stop bits and data size */
> -	atmel_uart_writel(port, ATMEL_US_MR, mode);
> -
>  	/*
>  	 * when switching the mode, set the RTS line state according to the
>  	 * new mode, otherwise keep the former state
> @@ -2315,6 +2312,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  	}
>  	quot = cd | fp << ATMEL_US_FP_OFFSET;
>  
> +	/* set the mode, clock divisor, parity, stop bits and data size */
> +	atmel_uart_writel(port, ATMEL_US_MR, mode);
> +
I think your patch is good, but I'll be happier if instead of moving
those 2 lines here, the whole "Set the baud rate" block was moved before
"atmel_uart_writel(port, ATMEL_US_MR, mode);"

That's because at line 2291 the ATMEL_US_CR register is set with
ATMEL_US_RTSDIS or ATMEL_US_RTSEN.
And those 2 values have a different effect depending on US_MR.USART_MODE

Quoting from the relase manual:
RTSEN:
1: Drives RTS pin to 1 if US_MR.USART_MODE field = 2, else drives RTS
pin to 0 if US_MR.USART_MODE field = 0.

RTSDIS:
1: Drives RTS pin to 0 if US_MR.USART_MODE field = 2, else drives RTS
pin to 1 if US_MR.USART_MODE field = 0.

So, I think it's better to set the mode register before setting the
control register.


>  	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
>  		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
>  	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
> 

Thanks !
