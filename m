Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA74C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9D2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cRPj4408"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDMQul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:50:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60353 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfDMQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wzVStOj7Mul8UjzkiBai2M0DGEv5hveyzFb4v2P4d/4=; b=cRPj44087LXnNrSI33IkKWyBAO
        0IXode3SxtsoERFh6epmTZ8J/ALiDBkoTkJfJk5ngtUHAjZgIL47tYwiQJ1hYzKFCfRwMIlzK56as
        edgkjnttf07k4yQ8ujVUQPcLqRfHXbHDMmwDcf6sg8v2CgzJJc9pd3wsF9x+ZBYH5YfM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFLqn-0005VC-9D; Sat, 13 Apr 2019 18:49:57 +0200
Date:   Sat, 13 Apr 2019 18:49:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 20/24] net: dsa: sja1105: Error out if RGMII
 delays are requested in DT
Message-ID: <20190413164957.GJ17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-21-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-21-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:18AM +0300, Vladimir Oltean wrote:
> Documentation/devicetree/bindings/net/ethernet.txt is confusing because
> it says what the MAC should not do, but not what it *should* do:
> 
>   * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
>      should not add an RX delay in this case)
> 
> The gap in semantics is threefold:
> 1. Is it illegal for the MAC to apply the Rx internal delay by itself,
>    and simplify the phy_mode (mask off "rgmii-rxid" into "rgmii") before
>    passing it to of_phy_connect? The documentation would suggest yes.
> 1. For "rgmii-rxid", while the situation with the Rx clock skew is more
>    or less clear (needs to be added by the PHY), what should the MAC
>    driver do about the Tx delays? Is it an implicit wild card for the
>    MAC to apply delays in the Tx direction if it can? What if those were
>    already added as serpentine PCB traces, how could that be made more
>    obvious through DT bindings so that the MAC doesn't attempt to add
>    them twice and again potentially break the link?
> 3. If the interface is a fixed-link and therefore the PHY object is
>    fixed (a purely software entity that obviously cannot add clock
>    skew), what is the meaning of the above property?
> 
> So an interpretation of the RGMII bindings was chosen that hopefully
> does not contradict their intention but also makes them more applied.
> The SJA1105 driver understands to act upon "rgmii-*id" phy-mode bindings
> if the port is in the PHY role (either explicitly, or if it is a
> fixed-link). Otherwise it always passes the duty of setting up delays to
> the PHY driver.

That is a good interpretation. I always recommend the PHY does the
delay, because in general the PHY can, and often the MAC cannot.

> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
