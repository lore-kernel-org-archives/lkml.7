Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E080C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4692083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfFFKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:05:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfFFKFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:05:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4982341;
        Thu,  6 Jun 2019 03:05:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D11E3F690;
        Thu,  6 Jun 2019 03:05:23 -0700 (PDT)
Date:   Thu, 6 Jun 2019 11:05:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Race between MMIO writes and level IRQs
Message-ID: <20190606100520.GC37430@lakrids.cambridge.arm.com>
References: <459c9bd7-becd-e704-cc13-213770f17018@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459c9bd7-becd-e704-cc13-213770f17018@free.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:53:05AM +0200, Marc Gonzalez wrote:
> Hello everyone,
> 
> There's something about interrupts I have never quite understood,
> which I'd like to clear up once and for all. What I'm about to write
> will probably sound trivial to anyone's who's already figured it out,
> but I need to walk through it.
> 
> Consider a device, living on some peripheral bus, with an interrupt
> line flowing from the device into some kind of interrupt controller.
> 
> I.e. there are two "communication channels"
> 1) the peripheral bus, and 2) the "out-of-band" interrupt line.
> 
> At some point, the device requires the CPU to do $SOMETHING. It sends
> a signal over the interrupt line (either a pulse for edge interrupts,
> or keeping the line high for level interrupts). After some time, the
> CPU will "take the interrupt", mask all(?) interrupts, and jump to the
> proper interrupt service routine (ISR).
> 
> The CPU does whatever it's supposed to do, and then needs to inform
> the device that "yes, the work is done, stop pestering me". Typically,
> this is done by writing some value to one of the device's registers.
> 
> AFAICT, this is the part where things can go wrong:
> 
> The CPU issues the magic MMIO write, which will take some time to reach
> the device over the peripheral bus. Meanwhile, the device maintains the
> IRQ signal (assuming a level interrupt). Once the CPU leaves the ISR, the
> framework will unmask IRQs. If the write has not yet reached the device,
> the CPU will be needlessly interrupted again.

Even if the write *has* reached the device, there can be a delay before
the device de-sassert the interrupt line, and there can be a subsequent
delay for each irqchip between the device and the CPU re-sampling the
line and propagating this to its output.

Thus it's always possible to take a spurious IRQ after an IRQ handler
returns, even if the device de-asserted its interrupt line immediately.

Linux drivers are expected to be resilient to spurious IRQs.

> Basically, there's a race between the MMIO write and the IRQ unmasking.
> We'd like to be able to guarantee that the MMIO write is complete before
> unmasking interrupts, right?

This really depends on what you're doing. In many cases it's fine for
the write to complete later, given cases like the above.

> Some people use memory barriers, but my understanding is that this is
> not sufficient. The memory barrier may guarantee that the MMIO write
> has left the CPU "domain", but not that it has reached the device.

IIUC, memory barriers cannot necessarily ensure that a write has reached
a device.

> So it looks like the only surefire way to guarantee that the MMIO write
> has reached the device is to read the value back from the device?

A read ensures that the device has accepted the prior write, but does
not necessarily guarantee that it has changed internal state or
triggered any externally visible effects.

What exactly you need to do will depend on what you're trying to achieve
and the behaviour of the specific device.

Thanks,
Mark.
