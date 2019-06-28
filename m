Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1623FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE7205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF1JlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:41:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34792 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1JlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:41:07 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgnNN-0008IE-FH; Fri, 28 Jun 2019 11:41:01 +0200
Date:   Fri, 28 Jun 2019 11:41:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [patch 2/5] genirq: Add optional hardware synchronization for
 shutdown
In-Reply-To: <dbcd11d3-c967-a0a0-02a6-86d162f93a56@arm.com>
Message-ID: <alpine.DEB.2.21.1906281128310.1802@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.666964552@linutronix.de> <dbcd11d3-c967-a0a0-02a6-86d162f93a56@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Fri, 28 Jun 2019, Marc Zyngier wrote:
> On 25/06/2019 12:13, Thomas Gleixner wrote:
> >  
> >  	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
> >  	int		(*irq_retrigger)(struct irq_data *data);
> > +	int		(*irq_inflight)(struct irq_data *data);
> 
> I wonder how different this irq_inflight() is from the irq_get_irqchip_state()
> that can already report a number of states from the HW.
> 
> It is also unclear to me how "in flight" maps to the internal state of
> the interrupt controller: Is it pending? Acked? If the interrupt has been
> masked already, pending should be harmless (the interrupt won't fire anymore).
> But seeing it in the acked would probably mean that it is on its way to being
> handled, with a potential splat.

in flight means that the interrupt chip (in the offending case the IO-APIC)
has that interrupt raised internally _AND_ already propagated to the
destination CPU (in this case the local APIC of the destination). The CPU
has accepted the interrupt and now the chip is in a state where it waits
for it to be acknowledged. If we proceed in that state then the destination
CPU will eventually handle it _after_ all the resources are freed. But that
means that the in flight/wait for acknowledge state becomes stale because
the handling CPU does not find the connection to that chip anymore.

> > +		/*
> > +		 * If requested and supported, check at the chip whether it
> > +		 * is in flight at the hardware level:
> > +		 */
> > +		if (!inprogress && sync_chip && chip && chip->irq_inflight)
> > +			inprogress = chip->irq_inflight(irqd);
> 
> To expand on what I was trying to exptree above, I wonder if that would 
> be similar to in effect to:
> 
> 		if (!inprogress && sync_chip && chip && chip->irq_get_irqchip_state)
> 			chip->irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE, &inprogress);

Ah, indeed that could be mapped to it.

I'm happy to get rid of the extra callback. Now the question is whether
this would would give an headache for any of the chips which already
implement that callback and whether it needs to become conditional on the
trigger type at the core level. For the IO-APIC this state is only defined
for level type which makes sense as edge is fire and forget.

Thanks,

	tglx
