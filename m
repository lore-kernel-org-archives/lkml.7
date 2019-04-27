Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9004C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7304B206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FC2bpsvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfD0QoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:44:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46685 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0QoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2Jp8tW95qDDxhJZH0c/y0J2ffQAXfnnHhEYU95aDdek=; b=FC2bpsvzJiYgRT9gX0FEdNUmVG
        RsNrb2cWGmfKHkmfRFfzCN3G2PZozTN3rjmg6stuMwjeq+7H1BVRjIEjvBPBoj/3slz6OqJn0ttiU
        bqPhH6o0XQGP17XLLNQT8k7NEfrG45S8ay0EYSW1IuPew/vM31eBUO0lMGkuyesjMt70=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKQQq-0002nR-Sr; Sat, 27 Apr 2019 18:44:08 +0200
Date:   Sat, 27 Apr 2019 18:44:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH 3/4] net: macb: Drop nvmem_get_mac_address usage
Message-ID: <20190427164408.GD9816@lunn.ch>
References: <1556320002-26213-1-git-send-email-ynezz@true.cz>
 <1556320002-26213-4-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556320002-26213-4-git-send-email-ynezz@true.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 01:06:41AM +0200, Petr Štetiar wrote:
> of_get_mac_address now uses NVMEM under the hood, so it's not necessary
> to call it manually anymore.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 3da2795..1b98bc8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4172,16 +4172,10 @@ static int macb_probe(struct platform_device *pdev)
>  		bp->rx_intr_mask |= MACB_BIT(RXUBR);
>  
>  	mac = of_get_mac_address(np);
> -	if (mac) {
> +	if (mac)
>  		ether_addr_copy(bp->dev->dev_addr, mac);
> -	} else {
> -		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
> -		if (err) {
> -			if (err == -EPROBE_DEFER)
> -				goto err_out_free_netdev;
> -			macb_get_hwaddr(bp);
> -		}
> -	}

Here we have an ordering problem. The current code looks for NVMEM
after local-mac-address and mac-address. You change will make it look
for NVMEM first.

    Andrew
