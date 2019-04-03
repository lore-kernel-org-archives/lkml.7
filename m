Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2472C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfDCIqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:46:21 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39637 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCIqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:46:20 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EA58D240002;
        Wed,  3 Apr 2019 08:46:14 +0000 (UTC)
Date:   Wed, 3 Apr 2019 10:46:14 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v4 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190403084614.GC3354@kwain>
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
 <20190402131029.26880-2-antoine.tenart@bootlin.com>
 <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
 <20190402221048.fpdqfeuzscthn6qd@shell.armlinux.org.uk>
 <af550dd9-1374-621d-a37a-8e32314be01c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af550dd9-1374-621d-a37a-8e32314be01c@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 03, 2019 at 07:09:55AM +0200, Heiner Kallweit wrote:
> On 03.04.2019 00:10, Russell King - ARM Linux admin wrote:
> > On Tue, Apr 02, 2019 at 08:17:16PM +0200, Heiner Kallweit wrote:
> >> On 02.04.2019 15:10, Antoine Tenart wrote:
> >>> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> >>> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> >>> are powered down) when the PHY isn't used.
> >>>
> >>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> >>> ---
> >>>  drivers/net/phy/marvell10g.c | 12 +++++++++++-
> >>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> >>> index 80678919641d..9ee033c8a12b 100644
> >>> --- a/drivers/net/phy/marvell10g.c
> >>> +++ b/drivers/net/phy/marvell10g.c
> >>> @@ -51,6 +51,8 @@ enum {
> >>>  	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
> >>>  
> >>>  	/* Vendor2 MMD registers */
> >>> +	MV_V2_PORT_CTRL		= 0xf001,
> >>> +	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,
> >>
> >> If this driver is touched again I think it would be good to change all
> >> such constants to BIT() and GENMASK(), ideally combined with the macros
> >> from bitfields.h. This makes it much easier to check the code against the
> >> datasheet. Apart from that:
> > 
> > Specifically, which constants are you talking about?
> > 
> > I think there's only MV_PCS_PAIRSWAP_MASK and MV_V2_TEMP_CTRL_MASK,
> > which would be confusing to change given that the following definitions
> > are values for the masked field.
> > 
> Exactly, MV_V2_TEMP_CTRL_MASK is a good example. My personal preference is
> to define the mask as GENMASK(15, 14) and the field values as 0 and 3.
> Then it's aligned with the datasheet that says:
> 15:14 Temperature Sense Enable, 11 = Disable
> Macros FIELD_GET and FIELD_PREP are perfect to deal with such fields.

I agree, I didn't used that to be consistent with what was already done
in the driver.

> > However, MV_V2_PORT_CTRL_PWRDOWN should be defined using BIT() in any
> > case.

Shouldn't MV_PCS_PAIRSWAP_AB also be defined using BIT()?

More generally, we could have all the register definitions using the 0x
values, the masks using GENMASK() and the values using a combination of
BIT() and (0x... << y). That would match what's usually done in other
drivers and improve the readability. (But I also recall being told not
to use GENMASK in net/, so it's up to you to decide).

I can send a following up patch if needed and if we agree on this.

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
