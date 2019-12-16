Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485BDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4420725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLPK1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:27:14 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57866 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:27:13 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 5jsqDektV5BBk2+xf3w/QcqvniodKkPePiSDQucL2mBcAfnV0iyjeDQf/r2QK9nJNIrLHoHtFM
 aiELBZFR1pVJPWH2ErEzW3Ff5y0gL1/yZ1Sylm+pmkwWlgnm/ctrtFlqbc75tn/o+zyg9y7Zn7
 xjZ8RI68Ik5eX63k9atSyhnV4b7ivLHPdpW7JbP4YXrX3H9PXnP2cr3xvon0Y0eQR8zQqtAv/r
 o7vs0mcBwP6GY9pwoSklBZnMaHnLwP7ooKy2Ve2Z9dcHF8yUExUHWnpzQJsgKsMxx6TiqF6WY+
 zmc=
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="57878905"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2019 03:27:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Dec 2019 03:27:11 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 16 Dec 2019 03:27:11 -0700
Date:   Mon, 16 Dec 2019 11:26:56 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     David Engraf <david.engraf@sysgo.com>
CC:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tty/serial: atmel: fix out of range clock divider
 handling
Message-ID: <20191216102656.lkazcvuy5oai63lb@M43218.corp.atmel.com>
Mail-Followup-To: David Engraf <david.engraf@sysgo.com>,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <39e4d1c7-20b0-a024-3a46-e4d4369eed8e@sysgo.com>
 <20191216085403.17050-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191216085403.17050-1-david.engraf@sysgo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 09:54:03AM +0100, David Engraf wrote:
> Use MCK_DIV8 when the clock divider is > 65535. Unfortunately the mode
> register was already written thus the clock selection is ignored.
> 
> Fix by doing the baud rate calulation before setting the mode.
> 
> Fixes: 5bf5635ac170 ("tty/serial: atmel: add fractional baud rate support")
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks for the fix

Regards

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
>                 mode |= ATMEL_US_USMODE_NORMAL;
>         }
> 
> -       /* set the mode, clock divisor, parity, stop bits and data size */
> -       atmel_uart_writel(port, ATMEL_US_MR, mode);
> -
> -       /*
> -        * when switching the mode, set the RTS line state according to the
> -        * new mode, otherwise keep the former state
> -        */
> -       if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
> -               unsigned int rts_state;
> -
> -               if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
> -                       /* let the hardware control the RTS line */
> -                       rts_state = ATMEL_US_RTSDIS;
> -               } else {
> -                       /* force RTS line to low level */
> -                       rts_state = ATMEL_US_RTSEN;
> -               }
> -
> -               atmel_uart_writel(port, ATMEL_US_CR, rts_state);
> -       }
> -
>         /*
>          * Set the baud rate:
>          * Fractional baudrate allows to setup output frequency more
> @@ -2317,6 +2296,28 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
> 
>         if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
>                 atmel_uart_writel(port, ATMEL_US_BRGR, quot);
> +
> +       /* set the mode, clock divisor, parity, stop bits and data size */
> +       atmel_uart_writel(port, ATMEL_US_MR, mode);
> +
> +       /*
> +        * when switching the mode, set the RTS line state according to the
> +        * new mode, otherwise keep the former state
> +        */
> +       if ((old_mode & ATMEL_US_USMODE) != (mode & ATMEL_US_USMODE)) {
> +               unsigned int rts_state;
> +
> +               if ((mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_HWHS) {
> +                       /* let the hardware control the RTS line */
> +                       rts_state = ATMEL_US_RTSDIS;
> +               } else {
> +                       /* force RTS line to low level */
> +                       rts_state = ATMEL_US_RTSEN;
> +               }
> +
> +               atmel_uart_writel(port, ATMEL_US_CR, rts_state);
> +       }
> +
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
>         atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
>         atmel_port->tx_stopped = false;
> --
> 2.17.1
> 
