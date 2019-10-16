Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAC2FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312921835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="0Bj1ax5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbfJPUWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:22:21 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37672 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbfJPUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:22:20 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 99BEE5C052F;
        Wed, 16 Oct 2019 22:22:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571257338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rhWHMWzbaH3FPArIdQN0BDFHgNFLgh3atbU/r2yG+s=;
        b=0Bj1ax5yusDcatXxJSGoRb9OtpibtRTNMek6gG0csB7zJcfMEt8jgeBpXW/x5UHdr5myta
        e5YLIOmYA2aSx8D2pLNlor65F2dWptinusWx8UtMv32oUz9BclVx58nWSQ43yqqlfbnFTh
        SbE7174QO/m37NPzyLxFS7mehb0BDGU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Oct 2019 22:22:18 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>, linux-imx@nxp.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v1 2/3] tty: serial: lpuart: Use defines that correspond
 to correct register
In-Reply-To: <20191016151845.15859-2-philippe.schenker@toradex.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
 <20191016151845.15859-2-philippe.schenker@toradex.com>
Message-ID: <8512c4712d0500c1c46186c2b52a7350@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 17:18, Philippe Schenker wrote:
> Use UARTMODIR defines instead of UARTMODEM as it is a 32-bit function

This reads a bit strange at first. Also it is helpful for later to state
that this does not make a difference in practise, so how about:

Use define from the 32-bit register description UARTMODIR_* instead of
UARTMODEM_*. The value is the same, so there is no functional change.

Otherwise looks good to me:

Reviewed-by: Stefan Agner <stefan.agner@toradex.com>

--
Stefan

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
>  drivers/tty/serial/fsl_lpuart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index f3271857621c..346b4a070ce9 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1879,10 +1879,10 @@ lpuart32_set_termios(struct uart_port *port,
> struct ktermios *termios,
>  	}
>  
>  	if (termios->c_cflag & CRTSCTS) {
> -		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
> +		modem |= (UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
>  	} else {
>  		termios->c_cflag &= ~CRTSCTS;
> -		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
> +		modem &= ~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
>  	}
>  
>  	if (termios->c_cflag & CSTOPB)
