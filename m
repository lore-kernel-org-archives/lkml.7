Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ACDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D4A218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfB1PGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:06:06 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55103 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfB1PGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:06:04 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ED591E0016;
        Thu, 28 Feb 2019 15:06:00 +0000 (UTC)
Date:   Thu, 28 Feb 2019 16:06:00 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Yan Markman <ymarkman@marvell.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [EXT] [PATCH net-next 15/15] net: mvpp2: set the GMAC, XLG MAC,
 XPCS and MPCS in reset when a port is down
Message-ID: <20190228150600.GG4359@kwain>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-16-antoine.tenart@bootlin.com>
 <DM5PR18MB2134A10888F49613CC9ECCB7D6750@DM5PR18MB2134.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR18MB2134A10888F49613CC9ECCB7D6750@DM5PR18MB2134.namprd18.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yan,

On Thu, Feb 28, 2019 at 03:00:34PM +0000, Yan Markman wrote:
> 
> The eth-down/stop may concurrent with pre-scheduled stats_work.
> So it seems better to cancel stats_work first and then make resetS.

I'm not sure this would actually result in an issue, but to keep it
logical I'll change that.

Thanks,
Antoine

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 29d32cb3d52b..c10fd894c86f 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3257,6 +3257,7 @@ static void mvpp2_stop_dev(struct mvpp2_port *port)
>  
>  	if (port->phylink)
>  		phylink_stop(port->phylink);
> +
>  	phy_power_off(port->comphy);
>  }
>  
> @@ -3520,6 +3521,9 @@ static int mvpp2_stop(struct net_device *dev)
>  	mvpp2_cleanup_rxqs(port);
>  	mvpp2_cleanup_txqs(port);
>  
> +	mvpp2_mac_reset(port);
> +	mvpp22_pcs_reset(port);
> +
>  	cancel_delayed_work_sync(&port->stats_work);
>  
>  	return 0;

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
