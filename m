Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77615C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C0A2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="16J1OHQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbfHHUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:39:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45658 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHUji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o1ab5hvyDud1JwiSt72xPEY0As9rAHAnTbN6/WPbCF0=; b=16J1OHQK3pgK71LBbbFncpXW+r
        1iPSFx62hYqOGNpZuoGUTPUu/dIyJ19KaUiKM9OFQLuKPIuDmowXjqz9a/FocsB/9KoB0IQ32EI+E
        L5EPDyjIZdcLLa+Q3tflkeJR0shp1fhl6Y4h+yRxwisvlQNk1Kumkzn46eVcngqjoAC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hvpC8-0005w6-4c; Thu, 08 Aug 2019 22:39:32 +0200
Date:   Thu, 8 Aug 2019 22:39:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com
Subject: Re: [PATCH v2 13/15] net: phy: adin: configure downshift on
 config_init
Message-ID: <20190808203932.GP27917@lunn.ch>
References: <20190808123026.17382-1-alexandru.ardelean@analog.com>
 <20190808123026.17382-14-alexandru.ardelean@analog.com>
 <420c8e15-3361-a722-4ad1-3c448b1d3bc1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420c8e15-3361-a722-4ad1-3c448b1d3bc1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:38:40PM +0200, Heiner Kallweit wrote:
> On 08.08.2019 14:30, Alexandru Ardelean wrote:
> > Down-speed auto-negotiation may not always be enabled, in which case the
> > PHY won't down-shift to 100 or 10 during auto-negotiation.
> > 
> > This change enables downshift and configures the number of retries to
> > default 8 (maximum supported value).
> > 
> > The change has been adapted from the Marvell PHY driver.
> > 
> Instead of a fixed downshift setting (like in the Marvell driver) you
> may consider to implement the ethtool phy-tunable ETHTOOL_PHY_DOWNSHIFT.

Hi Alexandru

Upps, sorry, my bad.

I looked at marvell_set_downshift(), and assumed it was connected to
the phy-tunable. I have patches somewhere which does that. But they
have not made it into mainline yet.

> See the Aquantia PHY driver for an example.

Yes, that does have all the tunable stuff.

     Andrew
