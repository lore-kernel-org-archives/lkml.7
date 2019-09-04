Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2784522CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567582227;
	bh=JyfwPKkvksA1iTXJGg4VaG5FauqcSlO3QEzZSpnKaI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zV9FGADptMMOz4Ap8f2Kh0tYq7unaZkHkBPif2P5lpmF+oWvSQdbQxR3mxd/ld9ev
	 KCVccdrgIOuW07Y/CA3AF9NBLmHvTus+Qv0gg+uf4D6tb6r+KWz39RaPvuXwS2GBFy
	 sTvvs5N+2b7UtyTASZw2ZrT6/DTypiG07T7RlGos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfIDHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:30:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF9C22CEA;
        Wed,  4 Sep 2019 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567582225;
        bh=JyfwPKkvksA1iTXJGg4VaG5FauqcSlO3QEzZSpnKaI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE9zjzzy9CBYD0FFEBn+Lac1kycAeXD+/qMb2SDT7nXmAM0erKk5XD850gdsDKFg+
         ss3YV9TUt0jPn35QrOtgZGzjGPpwIVsCmwtdkCuoZCAGj9u0+RngHvZOlyx2HUAsip
         ybguRJRTA2Rvp2nfwwbcsZ1CaE1MWwT/wMWPqVlk=
Date:   Wed, 4 Sep 2019 09:30:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph =?iso-8859-1?Q?Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: turn off transmitter before activating
 AutoCTS or auto transmitter flow control
Message-ID: <20190904073022.GB9729@kroah.com>
References: <bd9fb8e75d0e45218eb110c25bb539ef@SSSDEEX.i.sigma-surface-science.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd9fb8e75d0e45218eb110c25bb539ef@SSSDEEX.i.sigma-surface-science.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 09:58:41AM +0000, Christoph Vogtländer wrote:
> As documented in the data-sheet, the transmitter must be disabled before
> activating AutoCTS or auto transmitter flow control. Accordingly, the
> transmitter must be enabled after AutoCTS or auto transmitter flow
> control gets deactivated.
> 
> Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
> ---
>  drivers/tty/serial/max310x.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index fb5a7e0e58e9..adfef6dae4a7 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -860,6 +860,15 @@ static void max310x_set_termios(struct uart_port *port,
>  max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
>  max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
> 
> +/* Disable transmitter before enabling AutoCTS or auto transmitter
> + * flow control
> + */
> +if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
> +max310x_port_update(port, MAX310X_MODE1_REG,
> +    MAX310X_MODE1_TXDIS_BIT,
> +    MAX310X_MODE1_TXDIS_BIT);
> +}
> +
>  port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
> 
>  if (termios->c_cflag & CRTSCTS) {
> @@ -878,6 +887,15 @@ static void max310x_set_termios(struct uart_port *port,
>  }
>  max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
> 
> +/* Enable transmitter after disabling AutoCTS and auto transmitter
> + * flow control
> + */
> +if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
> +max310x_port_update(port, MAX310X_MODE1_REG,
> +    MAX310X_MODE1_TXDIS_BIT,
> +    0);
> +}
> +
>  /* Get baud rate generator configuration */
>  baud = uart_get_baud_rate(port, termios, old,
>    port->uartclk / 16 / 0xffff,
> --
> 2.22.1
> 

Same problem here, this is impossible to apply.

greg k-h
