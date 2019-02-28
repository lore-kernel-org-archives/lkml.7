Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452D220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfB1VXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:23:17 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54101 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfB1VXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:23:16 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1B7DCE0003;
        Thu, 28 Feb 2019 21:23:12 +0000 (UTC)
Date:   Thu, 28 Feb 2019 22:23:12 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     antoine.tenart@bootlin.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 14/15] net: mvpp2: set the XPCS and MPCS in
 reset when not used
Message-ID: <20190228212312.GI4359@kwain>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-15-antoine.tenart@bootlin.com>
 <20190228.104051.1946425715498350215.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228.104051.1946425715498350215.davem@davemloft.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Feb 28, 2019 at 10:40:51AM -0800, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Thu, 28 Feb 2019 14:21:27 +0100
> 
> > +static void mvpp22_pcs_reset(struct mvpp2_port *port)
> > +{
> > +	struct mvpp2 *priv = port->priv;
> > +	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
> > +	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
> > +	u32 val;
> 
> Reverse christmas tree please.
> 
>  ...
> > +static void mvpp22_pcs_unreset(struct mvpp2_port *port)
> > +{
> > +	struct mvpp2 *priv = port->priv;
> > +	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
> > +	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
> > +	u32 val;
> 
> Likewise.

Right. But here we do need priv to be assigned first in order to assign
mpcs and xpcs. Do you want the pointer definition and assignment to be
in two steps to respect the christmas tree rule or is it acceptable in
such situations?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
