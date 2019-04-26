Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1686C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94971208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDZSPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:15:40 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:43472 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfDZSPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:15:40 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x3QIFFQe017912;
        Fri, 26 Apr 2019 19:15:16 +0100
Date:   Fri, 26 Apr 2019 19:15:15 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
Message-ID: <20190426191515.757e6015@alans-desktop>
In-Reply-To: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O
> +static void mlb_usio_set_termios(struct uart_port *port,
> +			struct ktermios *termios, struct ktermios *old)
> +{
> +	unsigned int escr, smr = MLB_USIO_SMR_SOE;
> +	unsigned long flags, baud, quot;
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		escr = MLB_USIO_ESCR_L_5BIT;
> +		break;
> +	case CS6:
> +		escr = MLB_USIO_ESCR_L_6BIT;
> +		break;
> +	case CS7:
> +		escr = MLB_USIO_ESCR_L_7BIT;
> +		break;
> +	case CS8:
> +	default:
> +		escr = MLB_USIO_ESCR_L_8BIT;
> +		break;
> +	}
> +
> +	if (termios->c_cflag & CSTOPB)
> +		smr |= MLB_USIO_SMR_SBL;
> +
> +	if (termios->c_cflag & PARENB) {
> +		escr |= MLB_USIO_ESCR_PEN;
> +		if (termios->c_cflag & PARODD)
> +			escr |= MLB_USIO_ESCR_P;
> +	}

If you don't suport CMSPAR then clear that bit in termios as well

> +	/* Set hard flow control */
> +	if (of_property_read_bool(port->dev->of_node, "auto-flow-control") ||
> +			(termios->c_cflag & CRTSCTS))
> +		escr |= MLB_USIO_ESCR_FLWEN;

That's just broken. The termios bits are the definitive things for the
port, and in addition even if they are forced you need to correct the
termios data.

You might want to control flow control *at boot* with an OF property but
doing it post boot is just busted.

Alan
