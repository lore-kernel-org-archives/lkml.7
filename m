Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7912BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496492173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfC2Ogl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:36:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39781 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:36:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=a3f-osx.local)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1h9scY-0001B5-FQ; Fri, 29 Mar 2019 15:36:38 +0100
Subject: Re: [PATCH v2 4/9] serial: 8250: add support for rs485 RTS delays in
 microseconds
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jslaby@suse.com, corbet@lwn.net,
        richard.genoud@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20190221171758.10322-1-martin.kepplinger@ginzinger.com>
 <20190221171758.10322-4-martin.kepplinger@ginzinger.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <fbafc165-e637-8041-e88d-f4aabe690422@pengutronix.de>
Date:   Fri, 29 Mar 2019 15:36:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190221171758.10322-4-martin.kepplinger@ginzinger.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/2/19 18:17, Martin Kepplinger wrote:
> Read struct serial_rs485's flag SER_RS485_DELAY_IN_USEC and apply the delay
> accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 13 +++++++++++--
>  drivers/tty/serial/8250/8250_port.c | 25 +++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 0a8316632d75..cbce43ac60b1 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -720,8 +720,17 @@ static int omap_8250_rs485_config(struct uart_port *port,
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
>  	/* Clamp the delays to [0, 100ms] */
> -	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
> -	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
> +	if (rs485->flags & SER_RS485_DELAY_IN_USEC) {
> +		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
> +						   100000U);
> +		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
> +						   100000U);
> +	} else {
> +		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
> +						   100U);
> +		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
> +						   100U);
> +	}
>  
>  	port->rs485 = *rs485;
>  
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index d2f3310abe54..0cee4aa8323d 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1483,6 +1483,15 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>  	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>  }
>  
> +static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
> +{
> +	long sec = usec / 1000000;
> +	long nsec = (usec % 1000000) * 1000000000;

This 1e9 should be 1000 ("NSEC_PER_USEC").
While at it you might want to use USEC_PER_SEC (and MSEC_PER_SEC
above) to make the code more readable.

Cheers
Ahmad

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
