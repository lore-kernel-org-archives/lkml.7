Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84712C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA092133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfB1Oo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:44:56 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41547 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfB1Ooz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:44:55 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D415A10000C;
        Thu, 28 Feb 2019 14:44:50 +0000 (UTC)
Date:   Thu, 28 Feb 2019 15:44:50 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190228144450.GF4359@kwain>
References: <20190228134837.32740-1-antoine.tenart@bootlin.com>
 <20190228134837.32740-4-antoine.tenart@bootlin.com>
 <20190228142243.GA8189@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228142243.GA8189@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Feb 28, 2019 at 03:22:43PM +0100, Andrew Lunn wrote:
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  drivers/net/phy/marvell10g.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> > index e5d098bd33a6..765edd34a7dd 100644
> > --- a/drivers/net/phy/marvell10g.c
> > +++ b/drivers/net/phy/marvell10g.c
> > @@ -245,17 +245,8 @@ static int mv3310_probe(struct phy_device *phydev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	return 0;
> > -}
> > -
> > -static int mv3310_suspend(struct phy_device *phydev)
> > -{
> > -	return 0;
> > -}
> > -
> > -static int mv3310_resume(struct phy_device *phydev)
> > -{
> > -	return mv3310_hwmon_config(phydev, true);
> 
> 
> I'm confused.
> 
> Didn't patch 1 just add suspend and resume callback? And here you are
> removing some other suspend and resume callbacks? Did we have two sets
> for a short while?

Indeed. I just check and what happened is I initially had the
suspend/resume callbacks implementation and this patch into the same
patch. And then I made a mistake when splitting them, leaving two
suspend/resume functions, and I did not see that when reviewing the
series...

Sorry about that, I'll fix it!

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
