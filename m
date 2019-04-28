Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5233C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8DF20693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556473275;
	bh=pF+bqio+UuvZynnnmsVJ0Fp54niJWefa9PRp71am6DQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MvVEM396D3/O/UXNG63ePaH/tLg+lmHjWB/7WWQlUkPGqoDSbU4DfUqvijQ55dTRI
	 0EtUEuxVlwc+q5ijNXrMwgitmxtcZTJEFBf/3/eJRoNYev4Ls9ytHedaB2Om+tEwkV
	 iNstV/B1AZVC0XPe40zvsWgXvLoidNBiCqg7pSN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfD1RlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfD1RlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:41:13 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D495206BF;
        Sun, 28 Apr 2019 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556473272;
        bh=pF+bqio+UuvZynnnmsVJ0Fp54niJWefa9PRp71am6DQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HCvNzJyjMBB+jFr4LmVSmKystQ0XLURYblY4K3oP+pSjEmFhPioQ3L7dmIwZYSXtb
         0CLDkHM09mIXsqwpXAkLIiofGtlW6tBS0LMC90Br2tRNJaA1J6GUkSNZowbubRQFyC
         i+VJM2woUl32Lh0wmJ1g+/AtMqQNMsSZ6ReO8fAA=
Received: by mail-wm1-f50.google.com with SMTP id n25so12121324wmk.4;
        Sun, 28 Apr 2019 10:41:12 -0700 (PDT)
X-Gm-Message-State: APjAAAUw38bPPPFH9ySCTr50I52cwRcCoTbfuuSLH+dfUA5qfFkufXYS
        GFDKpAhgss0eDd3CG33JftOMwgux/POjuL85kCM=
X-Google-Smtp-Source: APXvYqxTedt23d2QO8v6AmbxwXc7H+tR8LrPbVrHcoVQvY+gq716NH0n3naaMQytuMheFRq/ZyHkZ6RVSiA/fU3VxxQ=
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr14268754wma.129.1556473270970;
 Sun, 28 Apr 2019 10:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com> <1556181691-10293-2-git-send-email-long.cheng@mediatek.com>
In-Reply-To: <1556181691-10293-2-git-send-email-long.cheng@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Sun, 28 Apr 2019 10:40:59 -0700
X-Gmail-Original-Message-ID: <CAGp9LzqdmXQx4mqjLuUqm-fQM3s=ULpk2hadFV4PRHSe9qnoCQ@mail.gmail.com>
Message-ID: <CAGp9LzqdmXQx4mqjLuUqm-fQM3s=ULpk2hadFV4PRHSe9qnoCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250-mtk: add follow control
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Peter Shih <pihsun@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Changqi Hu <changqi.hu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Long

I guess you should mean "flow control", not "follow control".
And the commit subject should be swapped between 1/2 and 2/2,
otherwise, the subject is inconsistent with its own content.

       Sean

On Thu, Apr 25, 2019 at 1:41 AM Long Cheng <long.cheng@mediatek.com> wrote:
>
> Add SW and HW follow control function.
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
> -#define UART_MTK_HIGHS         0x09    /* Highspeed register */
> -#define UART_MTK_SAMPLE_COUNT  0x0a    /* Sample count register */
> -#define UART_MTK_SAMPLE_POINT  0x0b    /* Sample point register */
> +#define MTK_UART_HIGHS         0x09    /* Highspeed register */
> +#define MTK_UART_SAMPLE_COUNT  0x0a    /* Sample count register */
> +#define MTK_UART_SAMPLE_POINT  0x0b    /* Sample point register */
>  #define MTK_UART_RATE_FIX      0x0d    /* UART Rate Fix Register */
> -
>  #define MTK_UART_DMA_EN                0x13    /* DMA Enable register */
> +#define MTK_UART_RXTRI_AD      0x14    /* RX Trigger address */
> +#define MTK_UART_FRACDIV_L     0x15    /* Fractional divider LSB address */
> +#define MTK_UART_FRACDIV_M     0x16    /* Fractional divider MSB address */
>  #define MTK_UART_DMA_EN_TX     0x2
>  #define MTK_UART_DMA_EN_RX     0x5
>
> @@ -46,6 +48,7 @@ enum dma_rx_status {
>  struct mtk8250_data {
>         int                     line;
>         unsigned int            rx_pos;
> +       unsigned int            clk_count;
>         struct clk              *uart_clk;
>         struct clk              *bus_clk;
>         struct uart_8250_dma    *dma;
> @@ -196,9 +199,15 @@ static void mtk8250_shutdown(struct uart_port *port)
>  mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>                         struct ktermios *old)
>  {
> +       unsigned short fraction_L_mapping[] = {
> +               0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
> +       };
> +       unsigned short fraction_M_mapping[] = {
> +               0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
> +       };
>         struct uart_8250_port *up = up_to_u8250p(port);
> +       unsigned int baud, quot, fraction;
>         unsigned long flags;
> -       unsigned int baud, quot;
>
>  #ifdef CONFIG_SERIAL_8250_DMA
>         if (up->dma) {
> @@ -214,7 +223,7 @@ static void mtk8250_shutdown(struct uart_port *port)
>         serial8250_do_set_termios(port, termios, old);
>
>         /*
> -        * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
> +        * Mediatek UARTs use an extra highspeed register (MTK_UART_HIGHS)
>          *
>          * We need to recalcualte the quot register, as the claculation depends
>          * on the vaule in the highspeed register.
> @@ -230,18 +239,11 @@ static void mtk8250_shutdown(struct uart_port *port)
>                                   port->uartclk / 16 / UART_DIV_MAX,
>                                   port->uartclk);
>
> -       if (baud <= 115200) {
> -               serial_port_out(port, UART_MTK_HIGHS, 0x0);
> +       if (baud < 115200) {
> +               serial_port_out(port, MTK_UART_HIGHS, 0x0);
>                 quot = uart_get_divisor(port, baud);
> -       } else if (baud <= 576000) {
> -               serial_port_out(port, UART_MTK_HIGHS, 0x2);
> -
> -               /* Set to next lower baudrate supported */
> -               if ((baud == 500000) || (baud == 576000))
> -                       baud = 460800;
> -               quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
>         } else {
> -               serial_port_out(port, UART_MTK_HIGHS, 0x3);
> +               serial_port_out(port, MTK_UART_HIGHS, 0x3);
>                 quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
>         }
>
> @@ -258,17 +260,29 @@ static void mtk8250_shutdown(struct uart_port *port)
>         /* reset DLAB */
>         serial_port_out(port, UART_LCR, up->lcr);
>
> -       if (baud > 460800) {
> +       if (baud >= 115200) {
>                 unsigned int tmp;
>
> -               tmp = DIV_ROUND_CLOSEST(port->uartclk, quot * baud);
> -               serial_port_out(port, UART_MTK_SAMPLE_COUNT, tmp - 1);
> -               serial_port_out(port, UART_MTK_SAMPLE_POINT,
> -                                       (tmp - 2) >> 1);
> +               tmp = (port->uartclk / (baud *  quot)) - 1;
> +               serial_port_out(port, MTK_UART_SAMPLE_COUNT, tmp);
> +               serial_port_out(port, MTK_UART_SAMPLE_POINT,
> +                                       (tmp >> 1) - 1);
> +
> +               /*count fraction to set fractoin register */
> +               fraction = ((port->uartclk  * 100) / baud / quot) % 100;
> +               fraction = DIV_ROUND_CLOSEST(fraction, 10);
> +               serial_port_out(port, MTK_UART_FRACDIV_L,
> +                                               fraction_L_mapping[fraction]);
> +               serial_port_out(port, MTK_UART_FRACDIV_M,
> +                                               fraction_M_mapping[fraction]);
>         } else {
> -               serial_port_out(port, UART_MTK_SAMPLE_COUNT, 0x00);
> -               serial_port_out(port, UART_MTK_SAMPLE_POINT, 0xff);
> +               serial_port_out(port, MTK_UART_SAMPLE_COUNT, 0x00);
> +               serial_port_out(port, MTK_UART_SAMPLE_POINT, 0xff);
> +               serial_port_out(port, MTK_UART_FRACDIV_L, 0x00);
> +               serial_port_out(port, MTK_UART_FRACDIV_M, 0x00);
>         }
> +       if (uart_console(port))
> +               up->port.cons->cflag = termios->c_cflag;
>
>         spin_unlock_irqrestore(&port->lock, flags);
>         /* Don't rewrite B0 */
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
