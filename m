Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0585C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51CD20838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGLQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:35:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:35:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7FC72B;
        Fri, 12 Jul 2019 09:35:09 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B800B3F246;
        Fri, 12 Jul 2019 09:35:08 -0700 (PDT)
Date:   Fri, 12 Jul 2019 17:35:06 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Phil Elwell <phil@raspberrypi.org>
Cc:     Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
Message-ID: <20190712163506.GI2790@e103592.cambridge.arm.com>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
 <20190712121000.GK11350@BitWizard.nl>
 <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:20:42PM +0100, Phil Elwell wrote:
> Hi Rogier,
> 
> On 12/07/2019 13:10, Rogier Wolff wrote:
> > On Fri, Jul 12, 2019 at 12:21:05PM +0100, Dave Martin wrote:
> >> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> >> index 89ade21..1902071 100644
> >> --- a/drivers/tty/serial/amba-pl011.c
> >> +++ b/drivers/tty/serial/amba-pl011.c
> >> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
> >>  /* Start TX with programmed I/O only (no DMA) */
> >>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
> >>  {
> >> +	/*
> >> +	 * Avoid FIFO overfills if the TX IRQ is active:
> >> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
> >> +	 */
> >> +	if (uap->im & UART011_TXIM)
> >> +		return;
> >> +
> > 
> > I'm no expert on PL011, have no knowledge of the current bug, but have
> > programmed serial drivers in the past.
> > 
> > This looks "dangerous" to me.
> > 
> > The normal situation is that you push the first few characters into
> > the FIFO with PIO and then the interrupt will trigger once the FIFO
> > empties and then you can refil the FIFO until the buffer empties.
> > 
> > The danger in THIS fix is that you might have a race that causes those
> > first few PIO-ed characters not to be put in the hardware resulting in
> > the interrupt never triggering.... If you can software-trigger the
> > interrupt just before the "return" here that'd be a way to fix things.

This is the thing that can't really be done with PL011.  The only way to
trigger a TX FIFO interrupt is to fill the TX FIFO and wait for it to
drain back to the threshold.

SBSA UART is particularly dumb in this regard: you can't disable the
FIFOs, change the irq trigger thresholds or do anything else that might
help here.

Historically, the PL011 was configured for maximum speed and put in
loopback mode to send some initial dummy chars and bootstrap the
interrupt state machine, but this has problems with some newer variants,
and doesn't work at all with SBSA uart.

> I'm also not a serial driver expert, but I think this simplified patch is safe.
> The reason is that the UART011_TXIM flag is only set after the pio thread has failed
> to write some data into the FIFO because it is full, which would guarantee that
> an interrupt is generated once the fill level drops below the half-way mark.

I think it's the spin_lock_irq(&uap->port.lock) done by serial_core
around pl011_start_tx() that we're relying on here.

This protects us against most potential races.

The trickiest path is when we are in pl011_int() having temporarily
released the lock, and pl011_start_tx() gets called on another cpu.

One thing that makes me uneasy is that there is one thing other than
pl011_int() than can clear uap->im &= ~UART011_TXIM: pl011_stop_tx() is
also called from uart_stop(), which the TTY layer may call at random
times for flow control reasons.

pl011_int() can miss this change and and write the FIFO a final time,
but pl011_start_tx_pio() can now race even with my patch (because TXIM
is now clear) and overfill the FIFO.

This problem arises from the cached interrupt status bits becoming
stale while the lock is released.

We might be able to solve this just be reordering pl011_int() so that
the un-locky rx handing code is done after the TX handling.

Does this make sense?


> > I'm ok with a reaction like "I've thought about this, it's not a
> > problem, now shut up".
> 
> I don't think that reaction would be justified - these things are difficult, and having
> many minds on the problem helps to avoid bugs like this.

Ack!  These things are properly fiddly to get right.  Please do try to
shoot holes in the code :)

I am still trying to resurrect my understanding of how this code
works...

Cheers
---Dave
