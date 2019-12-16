Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC98EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85600206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLPIqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:46:46 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:32889 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfLPIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:46:46 -0500
Received: from localhost (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6E64610000A;
        Mon, 16 Dec 2019 08:46:42 +0000 (UTC)
Date:   Mon, 16 Dec 2019 09:46:41 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     antoine.tenart@bootlin.com, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v3 06/15] net: macsec: add nla support for
 changing the offloading selection
Message-ID: <20191216084641.GA288774@kwain>
References: <20191213154844.635389-1-antoine.tenart@bootlin.com>
 <20191213154844.635389-7-antoine.tenart@bootlin.com>
 <20191215.134452.1354053731963113491.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191215.134452.1354053731963113491.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Sun, Dec 15, 2019 at 01:44:52PM -0800, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Fri, 13 Dec 2019 16:48:35 +0100
> 
> > +static int macsec_upd_offload(struct sk_buff *skb, struct genl_info *info)
> > +{
> 
> This function is over the top and in fact confusing.
> 
> Really, if you want to make semantics sane, you have to require that no
> rules are installed when enabling offloading.  The required sequence of
> events if "enable offloading, add initial rules".
> 
> > +	/* Check the physical interface isn't offloading another interface
> > +	 * first.
> > +	 */
> > +	for_each_net(loop_net) {
> > +		for_each_netdev(loop_net, loop_dev) {
> > +			struct macsec_dev *priv;
> > +
> > +			if (!netif_is_macsec(loop_dev))
> > +				continue;
> > +
> > +			priv = macsec_priv(loop_dev);
> > +
> > +			if (!macsec_check_offload(MACSEC_OFFLOAD_PHY, priv))
> > +				continue;
> > +
> > +			if (priv->offload != MACSEC_OFFLOAD_OFF)
> > +				return -EBUSY;
> > +		}
> > +	}
> 
> You are rejecting the enabling of offloading on one interface if any
> interface in the entire system is doing macsec offload?  That doesn't
> make any sense at all.

You're right, it doesn't make sense to check all the interfaces in the
entire system.

> Really, just require that a macsec interface is "clean" (no rules installed
> yet) in order to enable offloading.

This would allow two different virtual MACsec interfaces with the same
underlying hardware device to be offloaded. This is problematic as we
would have no way to distinguish ingress packets between the two: once
an ingress packet has been processed by the MACsec hardware block we
have no way to retrieve the MACsec parameters specific to this packet,
and we can't know to which MACsec flow the packet is related.

The above check was in fact reworked in between v2 and v3 and an
important part disappeared: the idea was to check the underlying
interface was not already offloading another virtual MACsec interface.
The last check (was and) should be:

  if (priv->real_dev == real_dev && priv->offload != MACSEC_OFFLOAD_OFF)
	return -EBUSY;

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
