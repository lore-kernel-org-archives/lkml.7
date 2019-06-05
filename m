Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9E620717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFEWCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:02:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:33831 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEWCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:02:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x55M2E1m023585;
        Wed, 5 Jun 2019 17:02:15 -0500
Message-ID: <8930de04d7f40b84068e4478a12fc496d53930c9.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna
 Labs Fabric Interrupt Controller Driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Talel Shenhar <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     dwmw@amazon.co.uk, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Date:   Thu, 06 Jun 2019 08:02:13 +1000
In-Reply-To: <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
         <1559731921-14023-3-git-send-email-talel@amazon.com>
         <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 13:22 +0100, Marc Zyngier wrote:
> 
> > +	 * This is generally fixed depending on what pieces of HW it's wired up
> > +	 * to.
> > +	 *
> > +	 * We configure it based on the sensitivity of the first source
> > +	 * being setup, and reject any subsequent attempt at configuring it in a
> > +	 * different way.
> 
> Is that a reliable guess? It also strikes me that the DT binding doesn't
> allow for the trigger type to be passed, meaning the individual drivers
> have to request the trigger as part of their request_irq() call. I'd
> rather you have a complete interrupt specifier in DT, and document the
> various limitations of the HW.

Actually the DT does, but Talel forgot to update the "example" part of
the binding patch. The description does say 2 cells.

This is the best approach imho (translation: I asked Talel to do it
this way :-) The other option which I don't like is to stick to
#interrupt-cells = 1, and have a separate property in the interrupt
controller node to indicate whether it needs to be configured as level
or edge.

These FICs are used for what is generally fixed wires inside the SoC,
so it doesn't matter much either way, but I prefer having it self
configured based on source just in case a future implementation doesn't
have the limitation of all inputs having the same trigger type.

Cheers,
Ben.


