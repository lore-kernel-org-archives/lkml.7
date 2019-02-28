Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC820675
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t4jCIjI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbfB1VzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:55:01 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42331 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732815AbfB1Vyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZTzwTjfZ/2+gziHkMZAPvjyNMougAY35fadBoUPt/g8=; b=t4jCIjI9ts0/ANiUOo07zV3WS7
        zawgNklOm++pDhd+Y7gJvdYLB7/1dDPgjQWnAkJEgrvlQBDYMSojiOi4GXCKNipepBU3403ng8Aco
        GR5qAQRxFCQCG+uLgn+hQPKmaKx/i3ZOAU/5SRiB+3J55FbnvlM/ILE7BylZ2D0aCvDo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gzTde-0007SP-3F; Thu, 28 Feb 2019 22:54:46 +0100
Date:   Thu, 28 Feb 2019 22:54:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: power serdes on/off for 10G
 interfaces on 6390X
Message-ID: <20190228215446.GB24085@lunn.ch>
References: <20190228211433.14211-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228211433.14211-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:14:33PM +0100, Maxime Chevallier wrote:
> Upon setting the cmode on 6390 and 6390X, the associated serdes
> interfaces must be powered off/on.
> 
> Both 6390X and 6390 share code to do so, but it currently uses the 6390
> specific helper mv88e6390_serdes_power() to disable and enable the
> serdes interface.
> 
> This call will fail silently on 6390X when trying so set a 10G interface
> such as XAUI or RXAUI, since mv88e6390_serdes_power() internally grabs
> the lane number based on modes supported by the 6390, and returns 0 when
> getting -ENODEV as a lane number.
> 
> Using mv88e6390x_serdes_power() should be safe here, since we explicitly
> rule-out all ports but the 9 and 10, and because modes supported by 6390
> ports 9 and 10 are a subset of those supported on 6390X.
> 
> This was tested on 6390X using RXAUI mode.
> 
> Fixes: 364e9d7776a3 ("net: dsa: mv88e6xxx: Power on/off SERDES on cmode change")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
