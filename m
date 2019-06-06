Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C8C28EB2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1920657
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="So2uET4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFFKZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:25:02 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42916 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfFFKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jtwS5y67sxjJ7FswCN5DS518lv6BqNXiW7fvOm1+w9w=; b=So2uET4v7eo+5mtA2Qq7E0jML
        Vu8/X9inBbty+STCaE0RfGNoAVKwrwOvV6lpoqP5B57iOL3M8s/Omf+jDwfS/r5rmHuHlegAyJRco
        wPC0fEhAVEDlpRcqZ+m3fcBPN8RBmKLVjJBnRCggQv5W0sJyM7WalovMHpE8wQT8koG8ieV7E+kTW
        erbNiSxElc5quAkL2BSYxmvbeG9m7Nf5xfoJJCnpguz5haofyDOBgAIb3VqwiQc9CPvSLqysQQlbV
        /QCAUz1iwH0xTCPEnE5rTp0WB/K2uAhkl9pIY5t/dlTENkU+cusuzRv93OiFSuf3PeSqxJRcNoa+A
        BnzosOU1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52880)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hYpZo-0005L8-Ot; Thu, 06 Jun 2019 11:24:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hYpZn-0003Ax-Kk; Thu, 06 Jun 2019 11:24:55 +0100
Date:   Thu, 6 Jun 2019 11:24:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Race between MMIO writes and level IRQs
Message-ID: <20190606102455.jpp3c6knba3nhiwh@shell.armlinux.org.uk>
References: <459c9bd7-becd-e704-cc13-213770f17018@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459c9bd7-becd-e704-cc13-213770f17018@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
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
> 
> Basically, there's a race between the MMIO write and the IRQ unmasking.
> We'd like to be able to guarantee that the MMIO write is complete before
> unmasking interrupts, right?
> 
> Some people use memory barriers, but my understanding is that this is
> not sufficient. The memory barrier may guarantee that the MMIO write
> has left the CPU "domain", but not that it has reached the device.
> 
> Am I mistaken?

You are not mistaken, and this issue has been known for a long time for
busses such as PCI, where writes are "posted" - they can be delayed by
any PCI bridge.  The PCI ordering rules state that a MMIO write must
complete before a MMIO read is allowed, so the way drivers work around
this problem is to use a write-readback sequence where its important
that the write must hit the device in a timely manner.

> So it looks like the only surefire way to guarantee that the MMIO write
> has reached the device is to read the value back from the device?
> 
> Tangential: is this one of the issues solved by MSI?
> https://en.wikipedia.org/wiki/Message_Signaled_Interrupts#Advantages

If anything, MSI is even worse - for example, if you disable the
interrupt at a device by writing and then reading back, an interrupt
could be "in flight" via the MSI mechanism just before the write hits,
but the CPU receives the interrupt after the read-back.

Note that the race condition the wikipedia article talks about is
between the device DMAing _to_ memory and the device sending a MSI.
It is not about the CPU writing to the device and the device sending
a MSI.

However, there is another aspect to consider - in a SMP system, the
interrupt could be processed by another CPU, so merely relying on
writing a peripheral register to stop an interrupt may mean that the
interrupt handler is already executing on some other CPU.
synchronize_irq() helps to avoid that.  Note that it doesn't help with
the MSI issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
