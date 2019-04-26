Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069EAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB633206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xqq4tnxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfDZVqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:46:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46158 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfDZVqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=N0v7UCwzGilP3a+Ssp+G4e+5dBfaKg7dKccQbJtQ7RU=; b=Xqq4tnxTeBJR3LdBL70hskeAcR
        L8JVJiluI3cqdSaFQdEl+UZU56jmZ9UotRWUcR/u+AVN/z6RryQzXGY+mpVAw5p5Xv/vGgEV4Q8U1
        6mAnX1Cxc+wIICvOlQKnafHlTkqrlcGacO7HPgwilvxeKTs9+Wx2Y7bfSuYkNR8ehb1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK8fv-0005kH-MM; Fri, 26 Apr 2019 23:46:31 +0200
Date:   Fri, 26 Apr 2019 23:46:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: phy: realtek: Change TX-delay setting for
 RGMII modes only
Message-ID: <20190426214631.GV4041@lunn.ch>
References: <20190426212112.5624-1-fancer.lancer@gmail.com>
 <20190426212112.5624-2-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426212112.5624-2-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:21:12AM +0300, Serge Semin wrote:
> It's prone to problems if delay is cleared out for other than RGMII
> modes. So lets set/clear the TX-delay in the config register only
> if actually RGMII-like interface mode is requested.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  drivers/net/phy/realtek.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index ab567a1923ad..a18cb01158f9 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -163,16 +163,24 @@ static int rtl8211c_config_init(struct phy_device *phydev)
>  static int rtl8211f_config_init(struct phy_device *phydev)
>  {
>  	int ret;
> -	u16 val = 0;
> +	u16 val;
>  
>  	ret = genphy_config_init(phydev);
>  	if (ret < 0)
>  		return ret;
>  
> -	/* enable TX-delay for rgmii-id and rgmii-txid, otherwise disable it */
> -	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
> -	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
> +	/* enable TX-delay for rgmii-id/rgmii-txid, and disable it for rgmii */
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		val = 0;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		val = RTL8211F_TX_DELAY;
> +		break;
> +	default: /* the rest of the modes imply leaving delay as is. */
> +		return 0;
> +	}

So there is no control of the RX delay?

That means PHY_INTERFACE_MODE_RGMII_ID and
PHY_INTERFACE_MODE_RGMII_RXID are not supported, and you should return
-EINVAL.

This is where we get into interesting backwards compatibility
issues. Are there any broken DT blobs with rgmii-id or rgmii-rxid,
which will break with such a change?

	Andrew
