Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349F8206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OnW6AArj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDZVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:40:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46150 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfDZVk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ctBnShPXB4hKxN05oor4oFzbFVg8HQgJxkMSAxlvkGg=; b=OnW6AArjukNoQzEdrVdTMbiOmb
        ESqDZ81URGCBxspJdW/JcAho9docC51wGiE+YjQvV/QbREH277KFnW1OXSTz3ys8r1k458k9yA2iO
        J1cKAfwRjtXoFO8X9ITQIRCYaoqRrudNk2Lr2Tf7Wv16SSWPrXj8k8GEwbuwwyuPwKrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK8aQ-0005ht-UO; Fri, 26 Apr 2019 23:40:50 +0200
Date:   Fri, 26 Apr 2019 23:40:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays
 config
Message-ID: <20190426214050.GU4041@lunn.ch>
References: <20190426093010.9609-1-fancer.lancer@gmail.com>
 <20190426212112.5624-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426212112.5624-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:21:11AM +0300, Serge Semin wrote:
> There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
> delays to TXC and RXC for TXD/RXD latching. Alas this is the only
> documented info regarding the RGMII timing control configurations the PHY
> provides. It turns out the same settings can be setup via MDIO registers
> hidden in the extension pages layout. Particularly the extension page 0xa4
> provides a register 0x1c, which bits 1 and 2 control the described delays.
> They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.
> 
> The hidden RGMII configs register utilization was found in the rtl8211e
> U-boot driver:
> https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99
> 
> There is also a freebsd-folks discussion regarding this register:
> https://reviews.freebsd.org/D13591
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
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>


Hi Serge

Next time please include a patch 0 containing a cover note explaining
the who series.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
