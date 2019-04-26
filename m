Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278E0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05D5206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f7Do0bd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDZN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:28:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45449 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YymALKcNe5RWstAgOCkQ3CUtTqwEQ22gorsemwCLaKc=; b=f7Do0bd8Oh1aJCUUxqBCJeaDV7
        5cRHz5xrJO053kX1HsS2rfgmBWOO0p9BI59cd8yvm8Mtd/I1o5E1a69KqSmcCh60YWv4Z4fy6f5mz
        kT7fDMCWEw9glk+Kyp1x3NFytU71JbTmcpzsBvR3QrfYjPzDkoiDKcWpvffn9aQN037s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK0tp-0000ax-B4; Fri, 26 Apr 2019 15:28:21 +0200
Date:   Fri, 26 Apr 2019 15:28:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Message-ID: <20190426132821.GB14432@lunn.ch>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426093010.9609-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 12:30:10PM +0300, Serge Semin wrote:
> The hidden RGMII configs register utilization was found in the
> rtl8211e U-boot driver:
> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> 
> It confirms that the register bits field must control the so called
> configuration pins described in the table 12-13 of the official PHY
> datasheet:
> 8:6 = PHY Address
> 5:4 = Auto-Negotiation
> 3 = Interface Mode Select
> 2 = RX Delay
> 1 = TX Delay
> 0 = SELRGV

> +static int rtl8211e_config_init(struct phy_device *phydev)
> +{
> +	int ret, oldpage;
> +	u16 val = 0;
> +
> +	ret = genphy_config_init(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* enable TX/RX delay for rgmii-* modes, otherwise disable it */
> +	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
> +		val = RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
> +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
> +		val = RTL8211E_TX_DELAY;
> +	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
> +		val = RTL8211E_RX_DELAY;

Hi Serge

You need to look for PHY_INTERFACE_MODE_RGMII and disable the bits.
For any other value, and in particular PHY_INTERFACE_MODE_NA, you
should leave the bits alone.

As you found out, u-boot knows how to program these bits. There are
probably boards out there which rely on u-boot doing this, and the PHY
driver then not messing with the bits. The way to indicate it should
not mess with the bits is to not have a phy-mode property in DT, which
results in PHY_INTERFACE_MODE_NA.

	Andrew
