Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDBC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58492084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgSpUmat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfDYKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:40:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39627 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfDYKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:40:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so18720230edb.6;
        Thu, 25 Apr 2019 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gNB4e83qYSu3jEfl2FW40Y0PG+ASh9V6LGPyf9ymr3w=;
        b=tgSpUmatI+ryG1BJzbCfxZgUT6Jg222gPCn43wwzMfvCFyawFh+p2Hnvwa+7q3ErOb
         EYgTdtI+q4+KdNPYY6N4XTI642bM6N7Fki2byLDlmosxo3MmQkXN3NmmxAjWbvj2O74c
         /ETMz+HNZ8y7TXOc/KlsArUiWBuV/NIb3QiWlmbNenHjzdmWZ1LyADQHB6IugmvBNyde
         k+EdhmXguu/Dwhasz0Y8ABo+nXx9W+eWO8gmrrV3NEOLUv4k/uckReCgo9kS7WzBM6pH
         rmeQYv0yw1/cUXzv/v9HIvp1GsxsqnU9HcGuEHfZe3TibpHNr/vVzC7Hz42KmHQLwwmB
         BhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gNB4e83qYSu3jEfl2FW40Y0PG+ASh9V6LGPyf9ymr3w=;
        b=qIxQyYaOs9EDsj+ON8TLlg5NeepIKGTzRdGT4wf0zJADqz7WVLltZV3uAVu6cUy5+c
         e/Qv2+4ejTGwydZdxr2ZP1HkKlxpSNzAbzUP7ZiU91214FbSyyweWPkM/JajP5sdSKS4
         zvkMrOC+5taU//k/a8+BogX+vjI5bBl4fW/9p7fIPfKbb21DGHragk45eCiLI9pKB/Lp
         lUGh5S463XBDdv5yKD78MDCwokrYIsCQP0i11ZVaibJhth0ZVTlvc097KNjRSdHpmtCR
         f/k03xzfYqnTucm4L8EGrVII6vM2ZFbPWOYeGp7a+XuPyXiem30Xqc4zqFjn7a75LVPq
         5E9A==
X-Gm-Message-State: APjAAAXQ3LQ4FMY7Mb1GNSZwkt4y9BMnJn9ZlihUeD0A2O9Yu55dyjsk
        5k0CnaY45zcoVIoU9sLgy3g=
X-Google-Smtp-Source: APXvYqw0iZmOPEQI4pHB8RPSxP/s2HFpeaeb8V/uBJSU/oKq/IZ00kHHS5L+doipiOQL/4stY/16Yg==
X-Received: by 2002:a17:906:7c12:: with SMTP id t18mr16190051ejo.59.1556188849794;
        Thu, 25 Apr 2019 03:40:49 -0700 (PDT)
Received: from ziggy.stardust ([37.223.141.112])
        by smtp.gmail.com with ESMTPSA id g6sm6274572edd.48.2019.04.25.03.40.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 03:40:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] serial: 8250-mtk: add follow control
To:     Long Cheng <long.cheng@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Shih <pihsun@chromium.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Changqi Hu <changqi.hu@mediatek.com>
References: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
 <1556181691-10293-2-git-send-email-long.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <a43c54c4-e0bc-f9c7-9228-58938058c3b7@gmail.com>
Date:   Thu, 25 Apr 2019 12:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556181691-10293-2-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2019 10:41, Long Cheng wrote:
> Add SW and HW follow control function.

Can you please explain a bit more what you are doing in this patch.
You change the setting of the registers for different baud rates. Please
elaborate what is happening there.

> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c |   60 ++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index c1fdbc0..959fd85 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -21,12 +21,14 @@
>  
>  #include "8250.h"
>  
> -#define UART_MTK_HIGHS		0x09	/* Highspeed register */
> -#define UART_MTK_SAMPLE_COUNT	0x0a	/* Sample count register */
> -#define UART_MTK_SAMPLE_POINT	0x0b	/* Sample point register */
> +#define MTK_UART_HIGHS		0x09	/* Highspeed register */
> +#define MTK_UART_SAMPLE_COUNT	0x0a	/* Sample count register */
> +#define MTK_UART_SAMPLE_POINT	0x0b	/* Sample point register */

Rename looks good to me. But I'd prefer to have it in a separate patch.

>  #define MTK_UART_RATE_FIX	0x0d	/* UART Rate Fix Register */
> -
>  #define MTK_UART_DMA_EN		0x13	/* DMA Enable register */
> +#define MTK_UART_RXTRI_AD	0x14	/* RX Trigger address */
> +#define MTK_UART_FRACDIV_L	0x15	/* Fractional divider LSB address */
> +#define MTK_UART_FRACDIV_M	0x16	/* Fractional divider MSB address */
>  #define MTK_UART_DMA_EN_TX	0x2
>  #define MTK_UART_DMA_EN_RX	0x5
>  
> @@ -46,6 +48,7 @@ enum dma_rx_status {
>  struct mtk8250_data {
>  	int			line;
>  	unsigned int		rx_pos;
> +	unsigned int		clk_count;

What is that for, not used in this patch.

>  	struct clk		*uart_clk;
>  	struct clk		*bus_clk;
>  	struct uart_8250_dma	*dma;
> @@ -196,9 +199,15 @@ static void mtk8250_shutdown(struct uart_port *port)
>  mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>  			struct ktermios *old)
>  {
> +	unsigned short fraction_L_mapping[] = {
> +		0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
> +	};
> +	unsigned short fraction_M_mapping[] = {
> +		0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
> +	};
>  	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned int baud, quot, fraction;
>  	unsigned long flags;
> -	unsigned int baud, quot;
>  
>  #ifdef CONFIG_SERIAL_8250_DMA
>  	if (up->dma) {
> @@ -214,7 +223,7 @@ static void mtk8250_shutdown(struct uart_port *port)
>  	serial8250_do_set_termios(port, termios, old);
>  
>  	/*
> -	 * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
> +	 * Mediatek UARTs use an extra highspeed register (MTK_UART_HIGHS)
>  	 *
>  	 * We need to recalcualte the quot register, as the claculation depends
>  	 * on the vaule in the highspeed register.
> @@ -230,18 +239,11 @@ static void mtk8250_shutdown(struct uart_port *port)
>  				  port->uartclk / 16 / UART_DIV_MAX,
>  				  port->uartclk);
>  
> -	if (baud <= 115200) {
> -		serial_port_out(port, UART_MTK_HIGHS, 0x0);
> +	if (baud < 115200) {
> +		serial_port_out(port, MTK_UART_HIGHS, 0x0);
>  		quot = uart_get_divisor(port, baud);
> -	} else if (baud <= 576000) {
> -		serial_port_out(port, UART_MTK_HIGHS, 0x2);
> -
> -		/* Set to next lower baudrate supported */
> -		if ((baud == 500000) || (baud == 576000))
> -			baud = 460800;
> -		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);

So we allow now also these baud rates? Then you have to update the comment as well.

Regards,
Matthias

>  	} else {
> -		serial_port_out(port, UART_MTK_HIGHS, 0x3);
> +		serial_port_out(port, MTK_UART_HIGHS, 0x3);
>  		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
>  	}
>  
> @@ -258,17 +260,29 @@ static void mtk8250_shutdown(struct uart_port *port)
>  	/* reset DLAB */
>  	serial_port_out(port, UART_LCR, up->lcr);
>  
> -	if (baud > 460800) {
> +	if (baud >= 115200) {
>  		unsigned int tmp;
>  
> -		tmp = DIV_ROUND_CLOSEST(port->uartclk, quot * baud);
> -		serial_port_out(port, UART_MTK_SAMPLE_COUNT, tmp - 1);
> -		serial_port_out(port, UART_MTK_SAMPLE_POINT,
> -					(tmp - 2) >> 1);
> +		tmp = (port->uartclk / (baud *  quot)) - 1;
> +		serial_port_out(port, MTK_UART_SAMPLE_COUNT, tmp);
> +		serial_port_out(port, MTK_UART_SAMPLE_POINT,
> +					(tmp >> 1) - 1);
> +
> +		/*count fraction to set fractoin register */
> +		fraction = ((port->uartclk  * 100) / baud / quot) % 100;
> +		fraction = DIV_ROUND_CLOSEST(fraction, 10);
> +		serial_port_out(port, MTK_UART_FRACDIV_L,
> +						fraction_L_mapping[fraction]);
> +		serial_port_out(port, MTK_UART_FRACDIV_M,
> +						fraction_M_mapping[fraction]);
>  	} else {
> -		serial_port_out(port, UART_MTK_SAMPLE_COUNT, 0x00);
> -		serial_port_out(port, UART_MTK_SAMPLE_POINT, 0xff);
> +		serial_port_out(port, MTK_UART_SAMPLE_COUNT, 0x00);
> +		serial_port_out(port, MTK_UART_SAMPLE_POINT, 0xff);
> +		serial_port_out(port, MTK_UART_FRACDIV_L, 0x00);
> +		serial_port_out(port, MTK_UART_FRACDIV_M, 0x00);
>  	}
> +	if (uart_console(port))
> +		up->port.cons->cflag = termios->c_cflag;
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	/* Don't rewrite B0 */
> 
