Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A1C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B121655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgABLXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:23:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53489 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgABLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:23:06 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1imyZF-0007nt-2o; Thu, 02 Jan 2020 12:23:05 +0100
Message-ID: <f0af767b9dd18247a011856b66f3a6cc716d9e6a.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB RESCAL reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 02 Jan 2020 12:23:04 +0100
In-Reply-To: <22a0e4a9-96b3-8ecd-b699-4e4aad017b5d@gmail.com>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
         <20191210195903.24127-3-f.fainelli@gmail.com>
         <89d2d00058e34e7571fc0f50ce487cf54414cd49.camel@pengutronix.de>
         <469c7b73-b028-1691-d5f0-0ceb3007da1c@gmail.com>
         <9fd20d18a8773cd8886d9cb0424791b2f79b3e25.camel@pengutronix.de>
         <22a0e4a9-96b3-8ecd-b699-4e4aad017b5d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, 2019-12-30 at 11:05 -0800, Florian Fainelli wrote:
> On 12/12/19 2:01 AM, Philipp Zabel wrote:
[...]
> > > > > +	reg = readl(base + BRCM_RESCAL_START);
> > > > > +	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> > > > > +	reg = readl(base + BRCM_RESCAL_START);
> > > > > +	if (!(reg & BRCM_RESCAL_START_BIT)) {
> > > > > +		dev_err(data->dev, "failed to start sata/pcie rescal\n");
> > 
> > Is this something that can actually happen?
> 
> Have not seen it happen but if we have bogus hardware, we would rather
> get an informative log from the reset controller than a not so
> informative one from the consumer drivers about e.g.: SATA or PCIe link
> down (which could be for various other reasons). If you want this
> demoted to a debug print, let me know.

Ok, that is not necessary. I was just surprised that you don't trust
register writes to work.

> > [...]
> > > > > +	reg = readl(base + BRCM_RESCAL_START);
> > > > > +	writel(reg ^ BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> > > > 
> > > > Please use &= ~BRCM_RESCAL_START_BIT instead.
> > > 
> > > I think the idea was to avoid unconditionally clearing it, but based on
> > > the documentation, I don't see this being harmful, Jim?
> > 
> > Unless the bit is self-clearing, I can't see how this XOR could ever set
> > the bit instead of clearing it.
> > And even if it would, I don't understand how that can be indented.
> > Wouldn't that restart the reset/calibration sequence?
> The bit is not self clearing, but it can be cleared when the
> reset/calibration procedure is successfully finished, so this seems to
> do what it is intended for, in that, if you read the bit as 1, XOR would
> let you clear it.

I'm with you so far ...

> If you read it as 0, XOR would leave it cleared.

... but I don't understand this part. If BRCM_RESCAL_START is read as 0
at this point, we end up writing (0 ^ 1) == 1.

> Would you want a comment above to explain that?

Yes, please.

> > > > > +	reg = readl(base + BRCM_RESCAL_START);
> > > > > +	dev_dbg(data->dev, "sata/pcie rescal success\n");
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > This whole function looks a lot like it doesn't just deassert a reset
> > > > line, but actually issues a complete reset procedure of some kind. Do
> > > > you have some insight on what actually happens in the hardware when the
> > > > start bit is triggered? I suspect this should be implemented with the
> > > > .reset operation.
> > > 
> > > This hardware block is controlling the reset and calibration process of
> > > the SATA/PCIe combo PHY analog front end, but is not technically part of
> > > the PCIe or SATA PHY proper, it stands on its own, both functionally and
> > > from a register space perspective. The motivation for modelling this as
> > > a reset controller is that it does a reset (and a calibration) and this
> > > is a shared reset line among 2/3 instances of another block. If you
> > > think we should model this differently, please let us know.
> > 
> > Thank you for the explanation. I agree the "reset and calibration
> > sequence" property is close enough to a pure reset sequence to warrant
> > describing this as as reset controller.
> > The correct way would be to use the .reset callback though, if you can
> > have the drivers use reset_control_reset().
> 
> This should be doable, let me try to update the drivers accordingly. It
> sounds a bit silly to have to have kind of knowledge pushed down to the
> consumer drivers though...

There are cases where the abstraction doesn't fit perfectly, but usually
it is the consumer driver that knows best whether the hardware just
needs to be made responsive by deasserting the reset line, or whether
triggering a reset procedure is required to initialize some internal
state.

regards
Philipp

