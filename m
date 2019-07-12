Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB704C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B631206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfGLMSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:18:03 -0400
Received: from gaia.bitwizard.nl ([149.210.166.240]:40760 "EHLO
        gaia.bitwizard.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:18:03 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 08:18:01 EDT
Received: from abra2.bitwizard.nl (unknown [10.8.0.6])
        by gaia.bitwizard.nl (Postfix) with ESMTP id 87FAA5A0065;
        Fri, 12 Jul 2019 14:10:00 +0200 (CEST)
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 6CD7E13F753; Fri, 12 Jul 2019 14:10:00 +0200 (CEST)
Date:   Fri, 12 Jul 2019 14:10:00 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Message-ID: <20190712121000.GK11350@BitWizard.nl>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712112105.GH2790@e103592.cambridge.arm.com>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:21:05PM +0100, Dave Martin wrote:
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 89ade21..1902071 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>  /* Start TX with programmed I/O only (no DMA) */
>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>  {
> +	/*
> +	 * Avoid FIFO overfills if the TX IRQ is active:
> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
> +	 */
> +	if (uap->im & UART011_TXIM)
> +		return;
> +

I'm no expert on PL011, have no knowledge of the current bug, but have
programmed serial drivers in the past.

This looks "dangerous" to me.

The normal situation is that you push the first few characters into
the FIFO with PIO and then the interrupt will trigger once the FIFO
empties and then you can refil the FIFO until the buffer empties.

The danger in THIS fix is that you might have a race that causes those
first few PIO-ed characters not to be put in the hardware resulting in
the interrupt never triggering.... If you can software-trigger the
interrupt just before the "return" here that'd be a way to fix things.

I'm ok with a reaction like "I've thought about this, it's not a
problem, now shut up".

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** https://www.BitWizard.nl/ ** +31-15-2049110 **
**    Delftechpark 11 2628 XJ  Delft, The Netherlands.  KVK: 27239233    **
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
