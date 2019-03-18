Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09520863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jDPYNyak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfCROTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:19:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57486 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfCROTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+L3QjrqFC6cIDJwwlnq/wbic5OOexHViJmER9wU/Dsk=; b=jDPYNyakZqIhZlt8q5IL9bz3gV
        I6zfgKbmLsAoNDH/TIr0yOU/QcmfJoXtA8GOsRNl9qiOH1ZR9S9nFyDSLbWwTYKKltmGC8BlMVZFr
        Fo+8j1RjilwmhZYKs1lJCElsubuL72VAALsmn9T5tk4bRF4SalH9/KBtMzH4jZrDT2bA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h5t6f-0005Sw-7k; Mon, 18 Mar 2019 15:19:13 +0100
Date:   Mon, 18 Mar 2019 15:19:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [PATCH net] net: phy: Don't assume loopback is supported
Message-ID: <20190318141913.GJ30224@lunn.ch>
References: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
 <19c8d2b3-bffe-b3b2-6e91-e878f89e5247@gmail.com>
 <20190317183843.GE22226@lunn.ch>
 <07dd8427-4779-1706-3c0a-17ae58939c41@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dd8427-4779-1706-3c0a-17ae58939c41@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We provide PHYs to our customers and in the documentation I have
> this can be an optional feature that HW team can choose to have
> or not, making the bit read-only or r/w.
> 
> Heiner, can you please confirm there is no Clause 22 "pitfalls" /
> "hidden comments" that allow this bitfield to be read-only ?

Hi Jose

I have the 802.3 standard from 2015. It should be free to download
from the IEEE. So you can go get it yourself.

Section 22.2.4.1.2 defines loopback. I don't see anything which makes
it optional. The only wiggle room you have is where in the PHY the
loopback actually takes place. That is implementation specific, but it
recommends you make it as late as possible in the path so as to test
as much as possible.

If your PHY does not implement loopback, i would say it breaks the
standard. We try to keep workarounds for brokenness in the specific
PHY driver, not the generic code.

    Andrew

