Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FFCC282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF1C20811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 05:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDVFOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 01:14:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55359 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfDVFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 01:14:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hIRH7-0007F6-09; Mon, 22 Apr 2019 07:13:53 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hIRH3-0004YP-Vg; Mon, 22 Apr 2019 07:13:49 +0200
Date:   Mon, 22 Apr 2019 07:13:49 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Miller <davem@davemloft.net>
Cc:     paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        robh+dt@kernel.org, jcliburn@gmail.com, chris.snook@gmail.com,
        mark.rutland@arm.com, kernel@pengutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org, nbd@nbd.name,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: ethernet: add ag71xx driver
Message-ID: <20190422051349.67awwpyat5sjbd7j@pengutronix.de>
References: <20190418052620.20835-1-o.rempel@pengutronix.de>
 <20190418052620.20835-4-o.rempel@pengutronix.de>
 <20190419.143519.94034508850689697.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419.143519.94034508850689697.davem@davemloft.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:12:35 up 93 days,  9:54, 71 users,  load average: 0.01, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 19, 2019 at 02:35:19PM -0700, David Miller wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Date: Thu, 18 Apr 2019 07:26:20 +0200
> 
> > +static int ag71xx_remove(struct platform_device *pdev)
> > +{
> > +	struct net_device *ndev = platform_get_drvdata(pdev);
> > +	struct ag71xx *ag;
> > +
> > +	if (!ndev)
> > +		return 0;
> > +
> > +	ag = netdev_priv(ndev);
> > +	ag71xx_phy_disconnect(ag);
> > +	ag71xx_mdio_remove(ag);
> > +	unregister_netdev(ndev);
> > +	platform_set_drvdata(pdev, NULL);
> > +
> > +	return 0;
> > +}
> 
> You should unregister the netdev before you disconnect the PHY and remove
> the MDIO.

ok.

> Also you need to call free_netdev() afterwards otherwise you will leak it.

ndev is allocated with devm_alloc_etherdev(). Are you sure free_netdev()
should be used here?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
