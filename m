Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7205D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m+EZ0FOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfB1OWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:22:50 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41646 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbfB1OWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=34TfQEmh9ymVa49UJE54QMwYYsUJDmFbf2KgpxV2xhM=; b=m+EZ0FOpJlOXKJGXsJYiDd5MUT
        5H/iM4JDJ5GeZ+VS0JoaHKYBusXHjSkzOiunodS+8U/doO9qZ5HkDPTxFwkRFbWZcfmgAx4t/E1og
        r6e8fRiNGbx5ZilWJZimXzfsn2nhULYGFIik8oJX8qpXCsF7Jz1nMg85OSGVt3+zjef4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzMaB-0002K2-Oo; Thu, 28 Feb 2019 15:22:43 +0100
Date:   Thu, 28 Feb 2019 15:22:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, linux@armlinux.org.uk, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190228142243.GA8189@lunn.ch>
References: <20190228134837.32740-1-antoine.tenart@bootlin.com>
 <20190228134837.32740-4-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228134837.32740-4-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/phy/marvell10g.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index e5d098bd33a6..765edd34a7dd 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -245,17 +245,8 @@ static int mv3310_probe(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> -	return 0;
> -}
> -
> -static int mv3310_suspend(struct phy_device *phydev)
> -{
> -	return 0;
> -}
> -
> -static int mv3310_resume(struct phy_device *phydev)
> -{
> -	return mv3310_hwmon_config(phydev, true);

Hi Antoine

I'm confused.

Didn't patch 1 just add suspend and resume callback? And here you are
removing some other suspend and resume callbacks? Did we have two sets
for a short while?

    Andrew
