Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3099CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1CF20645
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M3dZBZAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFWPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 11:09:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50410 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfFWPJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DK1nBU1K8tD9huiEBUso9OtrNSNj9E95x9HSnFZclIk=; b=M3dZBZAT7/s2rorVn4rP6NWRlC
        2TgYcr7mxF5VScrsdoRIWF30AY2Mn5f/ECLiXRFCx6mzoG4hpXZQc3sUBYkMyTL6tL/BLk48Hn7nB
        rBkZuZlnSlHlYPnl4xlmdS2DXujJhbfHncT3wvu90mSzctrzknNwiaUCiRgswJtL2zWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hf474-0007rk-5S; Sun, 23 Jun 2019 17:09:02 +0200
Date:   Sun, 23 Jun 2019 17:09:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        f.fainelli@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        aniljoy@cadence.com, piotrs@cadence.com
Subject: Re: [PATCH v4 4/5] net: macb: add support for high speed interface
Message-ID: <20190623150902.GB28942@lunn.ch>
References: <1561281419-6030-1-git-send-email-pthombar@cadence.com>
 <1561281806-13991-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561281806-13991-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +enum {
> +	HS_MAC_SPEED_100M,
> +	HS_MAC_SPEED_1000M,
> +	HS_MAC_SPEED_2500M,
> +	HS_MAC_SPEED_5000M,
> +	HS_MAC_SPEED_10000M,
> +	HS_MAC_SPEED_25000M,
> +};
> +
> +enum {
> +	MACB_SERDES_RATE_5_PT_15625Gbps = 5,
> +	MACB_SERDES_RATE_10_PT_3125Gbps = 10,
> +};

What do the units mean here? Why would you clock the SERDES at 15Tbps,
or 3Tbps? 3.125Mbps would give you 2.5Gbps when using 8b/10b encoding.

> +	if (bp->phy_interface == PHY_INTERFACE_MODE_USXGMII) {
> +		switch (bp->serdes_rate) {
> +		case MACB_SERDES_RATE_5_PT_15625Gbps:
> +			rate = 78125000;
> +			break;
> +		case MACB_SERDES_RATE_10_PT_3125Gbps:
> +			rate = 156250000;
> +			break;
> +		default:
> +			return;
> +		}

Xilinx documentation:
https://www.xilinx.com/support/documentation/ip_documentation/usxgmii/v1_1/pg251-usxgmii.pdf
seems to suggest USXGMII uses a fixed rate of 10.3125Gb/s. So why do
you need to change the rate?

    Andrew
