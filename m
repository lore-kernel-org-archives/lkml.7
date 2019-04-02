Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D656207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfDBJup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:50:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45657 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfDBJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:50:44 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A4C1BE000D;
        Tue,  2 Apr 2019 09:50:40 +0000 (UTC)
Date:   Tue, 2 Apr 2019 11:50:40 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v3 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190402095040.GB3354@kwain>
References: <20190326145302.9563-1-antoine.tenart@bootlin.com>
 <20190326145302.9563-2-antoine.tenart@bootlin.com>
 <dcd7bdaa-5587-0099-3a2e-ce55b32ab7f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd7bdaa-5587-0099-3a2e-ce55b32ab7f9@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Fri, Mar 29, 2019 at 10:32:02PM +0100, Heiner Kallweit wrote:
> On 26.03.2019 15:53, Antoine Tenart wrote:
> > This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> > three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> > are powered down) when the PHY isn't used.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/phy/marvell10g.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> > index 100b401b1f4a..b56cd35182d5 100644
> > --- a/drivers/net/phy/marvell10g.c
> > +++ b/drivers/net/phy/marvell10g.c
> > @@ -226,11 +226,25 @@ static int mv3310_probe(struct phy_device *phydev)
> >  
> >  static int mv3310_suspend(struct phy_device *phydev)
> >  {
> > +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
> > +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> > +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_R + MDIO_CTRL1,
> > +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> > +	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_1000BASEX + MDIO_CTRL1,
> > +		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
> > +
> When you re-submit this series, in addition to my previous comment:
> Instead of phy_modify_mmd() it would be clearer to use
> phy_set/clear_bits_mmd(). And checking the return value wouldn't hurt.

OK, will do.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
