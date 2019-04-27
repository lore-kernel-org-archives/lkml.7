Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE277C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67EF2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3eXqdP76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfD0Qyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:54:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46709 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfD0Qyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Jc/W3C1gc1usstdsD3X0g0GI2F2TrJO7kcdb6baDsAY=; b=3eXqdP76iQ2WpTDUvS5itLdgxp
        fyavnj0QnIqJxqpn+TxSEi+N7+t4Np1TSm7q2lXZheAs6qjKBKuaCi2oYDbnamooZzYHAjvU4vo2J
        LpbkhABcKfV4cnfMiOgtJPIcEeysT5bFuBMvd2aSrjAL6RQVzanY/GFO1S/nBPvNVAYc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKQal-0002ql-Qm; Sat, 27 Apr 2019 18:54:23 +0200
Date:   Sat, 27 Apr 2019 18:54:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 4/4] net: davinci_emac: Drop nvmem_get_mac_address usage
Message-ID: <20190427165423.GE9816@lunn.ch>
References: <1556320002-26213-1-git-send-email-ynezz@true.cz>
 <1556320002-26213-5-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556320002-26213-5-git-send-email-ynezz@true.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 01:06:42AM +0200, Petr Štetiar wrote:
> of_get_mac_address now uses NVMEM under the hood, so it's not necessary
> to call it manually anymore.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 57450b1..c1a5526 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -1912,15 +1912,11 @@ static int davinci_emac_probe(struct platform_device *pdev)
>  		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
>  
>  	if (!is_valid_ether_addr(priv->mac_addr)) {
> -		/* Try nvmem if MAC wasn't passed over pdata or DT. */
> -		rc = nvmem_get_mac_address(&pdev->dev, priv->mac_addr);
> -		if (rc) {
> -			/* Use random MAC if still none obtained. */
> -			eth_hw_addr_random(ndev);
> -			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
> -			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
> -				 priv->mac_addr);
> -		}
> +		/* Use random MAC if still none obtained. */
> +		eth_hw_addr_random(ndev);
> +		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
> +		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
> +			 priv->mac_addr);

Hi Petr

There is the same ordering issue here as with the previous patch.

      Andrew
