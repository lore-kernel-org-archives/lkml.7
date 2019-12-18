Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A873FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848F0227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLROBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:01:35 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42865 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfLROBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:01:35 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D6355FF811;
        Wed, 18 Dec 2019 14:01:31 +0000 (UTC)
Date:   Wed, 18 Dec 2019 15:01:31 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>,
        "camelia.groza@nxp.com" <camelia.groza@nxp.com>,
        "Simon.Edelhaus@aquantia.com" <Simon.Edelhaus@aquantia.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Igor Russkikh <Igor.Russkikh@aquantia.com>
Subject: Re: [EXT] [PATCH net-next v3 05/15] net: macsec: hardware offloading
 infrastructure
Message-ID: <20191218140131.GA3325@kwain>
References: <20191213154844.635389-1-antoine.tenart@bootlin.com>
 <20191213154844.635389-6-antoine.tenart@bootlin.com>
 <BYAPR18MB2630684FD194F179E718E198B7530@BYAPR18MB2630.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR18MB2630684FD194F179E718E198B7530@BYAPR18MB2630.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Igor,

On Wed, Dec 18, 2019 at 01:40:39PM +0000, Igor Russkikh wrote:
> > @@ -2922,7 +3300,27 @@ static int macsec_changelink(struct net_device
> > *dev, struct nlattr *tb[],
> >  	    data[IFLA_MACSEC_PORT])
> >  		return -EINVAL;
> >  
> > -	return macsec_changelink_common(dev, data);
> > +	/* If h/w offloading is available, propagate to the device */
> > +	if (macsec_is_offloaded(macsec)) {
> > +		const struct macsec_ops *ops;
> > +		struct macsec_context ctx;
> > +		int ret;
> > +
> > +		ops = macsec_get_ops(netdev_priv(dev), &ctx);
> > +		if (!ops)
> > +			return -EOPNOTSUPP;
> > +
> > +		ctx.secy = &macsec->secy;
> > +		ret = macsec_offload(ops->mdo_upd_secy, &ctx);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = macsec_changelink_common(dev, data);
> 
> In our mac driver verification we see that propagating upd_secy to
> device before doing macsec_changelink_common is actually useless,
> since in this case underlying device can't fetch any of the updated
> parameters from the macsec structures.
> 
> Isn't it logical first doing `macsec_changelink_common` and then
> propagate the event?

Doing the macsec_changelink_common after propagating the event to the
device driver was done to ease the fail case scenario (it's quite hard
to revert macsec_changelink_common). But then you're right that many
parameters are set by macsec_changelink_common, which means it must be
performed before the propagation of the upd_secy event.

I think the solution is to keep a copy of unmodified secy and tx_sc, and
in case of failure to revert the operation by copying the whole
structures back. That would allow to move macsec_changelink_common up.
Would that work for you?

Thanks for spotting this!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
