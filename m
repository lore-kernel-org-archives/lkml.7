Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0CC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C7420863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfGLLVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 07:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfGLLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 07:21:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A855B28;
        Fri, 12 Jul 2019 04:21:08 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3DB73F71F;
        Fri, 12 Jul 2019 04:21:07 -0700 (PDT)
Date:   Fri, 12 Jul 2019 12:21:05 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Message-ID: <20190712112105.GH2790@e103592.cambridge.arm.com>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 02:45:32PM +0100, Phil Elwell wrote:
> pl011_tx_chars takes a "from_irq" parameter to reduce the number of
> register accesses. When from_irq is true the function assumes that the
> FIFO is half empty and writes up to half a FIFO's worth of bytes
> without polling the FIFO status register, the reasoning being that
> the function is being called as a result of the TX interrupt being
> raised. This logic would work were it not for the fact that
> pl011_rx_chars, called from pl011_int before pl011_tx_chars, releases
> the spinlock before calling tty_flip_buffer_push.
> 
> A user thread writing to the UART claims the spinlock and ultimately
> calls pl011_tx_chars with from_irq set to false. This reverts to the
> older logic that polls the FIFO status register before sending every
> byte. If this happen on an SMP system during the section of the IRQ
> handler where the spinlock has been released, then by the time the TX
> interrupt handler is called, the FIFO may already be full, and any
> further writes are likely to be lost.
> 
> The fix involves adding a per-port flag that is true iff running from
> within the interrupt handler and the spinlock has not yet been released.
> This flag is then used as the value for the from_irq parameter of
> pl011_tx_chars, causing polling to be used in the unsafe case.

Releasing the lock in pl011_int() before calling pl011_tx_chars()
wouldn't the source of this issue, though it may make it easier to hit:
there would anyway be a window between the interrupt being asserted and
the initial spin_lock_irqsave() in pl011_int(), during which the TX
FIFO could be topped up by another cpu.

So, assuming you've diagnosed the problem correctly, I'm not sure this
patch really fixes it.

What's the failure scenario exactly?  Are you using DMA?

If chars are being lost and falling back to polled TXFF per char fixes
it, then that does suggest a TX FIFO overflow somewhere.

Looking at the code, I'm slightly amazed we don't hit this more often.
It looks like if we have stuttering output that is sufficient to fill
the TX FIFO to the interrupt trigger threshold sometimes, but
uap->port.state->xmit stays empty, then we can probably get pl011_int()
and pl011_start_tx_pio() fighting with each other, as you suggest.


One option would be to track who can write the TX FIFO, either the
irq handler, or regular task context, and make them mutually exclusive.

We already have a flag for that in the form of the TXIM interrupt mask
bit.  So, fixing this might be as simple as [1].  Can you give it a
try?

If is works, I can work it up into a proper patch.

Cheers
---Dave

> 
> Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5921a33..70c1dc9 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -270,6 +270,7 @@ struct uart_amba_port {
>  	unsigned int		old_cr;		/* state during shutdown */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>  	char			type[12];
> +	bool			irq_locked;	/* in irq, unreleased lock */
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	bool			using_tx_dma;
> @@ -814,6 +815,7 @@ __acquires(&uap->port.lock)
>  		return;
>  
>  	/* Avoid deadlock with the DMA engine callback */
> +	uap->irq_locked = 0;
>  	spin_unlock(&uap->port.lock);
>  	dmaengine_terminate_all(uap->dmatx.chan);
>  	spin_lock(&uap->port.lock);
> @@ -941,6 +943,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
>  		fifotaken = pl011_fifo_to_tty(uap);
>  	}
>  
> +	uap->irq_locked = 0;
>  	spin_unlock(&uap->port.lock);
>  	dev_vdbg(uap->port.dev,
>  		 "Took %d chars from DMA buffer and %d chars from the FIFO\n",
> @@ -1349,6 +1352,7 @@ __acquires(&uap->port.lock)
>  {
>  	pl011_fifo_to_tty(uap);
>  
> +	uap->irq_locked = 0;
>  	spin_unlock(&uap->port.lock);
>  	tty_flip_buffer_push(&uap->port.state->port);
>  	/*
> @@ -1483,6 +1487,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>  	int handled = 0;
>  
>  	spin_lock_irqsave(&uap->port.lock, flags);
> +	uap->irq_locked = 1;
>  	status = pl011_read(uap, REG_RIS) & uap->im;
>  	if (status) {
>  		do {
> @@ -1502,7 +1507,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
>  				      UART011_CTSMIS|UART011_RIMIS))
>  				pl011_modem_status(uap);
>  			if (status & UART011_TXIS)
> -				pl011_tx_chars(uap, true);
> +				pl011_tx_chars(uap, uap->irq_locked);
>  
>  			if (pass_counter-- == 0)
>  				break;
> -- 
> 2.7.4
> 

[1] Untested, alternative "fix"

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade21..1902071 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
 /* Start TX with programmed I/O only (no DMA) */
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
+	/*
+	 * Avoid FIFO overfills if the TX IRQ is active:
+	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
+	 */
+	if (uap->im & UART011_TXIM)
+		return;
+
 	if (pl011_tx_chars(uap, false)) {
 		uap->im |= UART011_TXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
