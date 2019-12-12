Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923C1206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfLLKBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:01:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:01:07 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ifLHN-0006Jy-UX; Thu, 12 Dec 2019 11:01:05 +0100
Message-ID: <9fd20d18a8773cd8886d9cb0424791b2f79b3e25.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB RESCAL reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <im2101024@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Dec 2019 11:01:04 +0100
In-Reply-To: <469c7b73-b028-1691-d5f0-0ceb3007da1c@gmail.com>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
         <20191210195903.24127-3-f.fainelli@gmail.com>
         <89d2d00058e34e7571fc0f50ce487cf54414cd49.camel@pengutronix.de>
         <469c7b73-b028-1691-d5f0-0ceb3007da1c@gmail.com>
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

On Wed, 2019-12-11 at 10:12 -0800, Florian Fainelli wrote:
> 
> On 12/11/2019 1:48 AM, Philipp Zabel wrote:
> > > +#define BRCM_RESCAL_START	0
> > > +#define	BRCM_RESCAL_START_BIT	BIT(0)
> > > +#define BRCM_RESCAL_CTRL	4
> > > +#define BRCM_RESCAL_STATUS	8
> > > +#define BRCM_RESCAL_STATUS_BIT	BIT(0)
> > 
> > Is there any reason the start bit is indented but the status bit is not?
> 
> This is a convention we have tried to adopt to denote the definition
> from a register word address/offset versus the definition for bits
> within that register word.

That's fine, consider indenting BRCM_RESCAL_STATUS_BIT as well, then.

[...]
> > > +	reg = readl(base + BRCM_RESCAL_START);
> > > +	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> > > +	reg = readl(base + BRCM_RESCAL_START);
> > > +	if (!(reg & BRCM_RESCAL_START_BIT)) {
> > > +		dev_err(data->dev, "failed to start sata/pcie rescal\n");

Is this something that can actually happen?

[...]
> > > +	reg = readl(base + BRCM_RESCAL_START);
> > > +	writel(reg ^ BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> > 
> > Please use &= ~BRCM_RESCAL_START_BIT instead.
> 
> I think the idea was to avoid unconditionally clearing it, but based on
> the documentation, I don't see this being harmful, Jim?

Unless the bit is self-clearing, I can't see how this XOR could ever set
the bit instead of clearing it.
And even if it would, I don't understand how that can be indented.
Wouldn't that restart the reset/calibration sequence?

> > > +	reg = readl(base + BRCM_RESCAL_START);
> > > +	dev_dbg(data->dev, "sata/pcie rescal success\n");
> > > +
> > > +	return 0;
> > > +}
> > 
> > This whole function looks a lot like it doesn't just deassert a reset
> > line, but actually issues a complete reset procedure of some kind. Do
> > you have some insight on what actually happens in the hardware when the
> > start bit is triggered? I suspect this should be implemented with the
> > .reset operation.
> 
> This hardware block is controlling the reset and calibration process of
> the SATA/PCIe combo PHY analog front end, but is not technically part of
> the PCIe or SATA PHY proper, it stands on its own, both functionally and
> from a register space perspective. The motivation for modelling this as
> a reset controller is that it does a reset (and a calibration) and this
> is a shared reset line among 2/3 instances of another block. If you
> think we should model this differently, please let us know.

Thank you for the explanation. I agree the "reset and calibration
sequence" property is close enough to a pure reset sequence to warrant
describing this as as reset controller.
The correct way would be to use the .reset callback though, if you can
have the drivers use reset_control_reset().

regards
Philipp

