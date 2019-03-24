Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5BC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5FF2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pb8yJINF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfCXURn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:17:43 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36482 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfCXURn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PuLZyxrtZbNCJCYM+4m8LFGsFT6cw84EgIFld2llOVM=; b=pb8yJINFvk/ZP2hYhw79Phk1vL
        hdIPwEYgwJBs+Z5Za2HLIpBKFfdciuPJzAaO+jkdvRd57VIcCwI8qBY93dbICrlB6W9Yl0c/r0+DI
        xDtsH4JXftQpXuBZ9Yrd6dSH9WlFDd0/JMszvBEdyNoWK7R9Lrv2lv4lavXwNRHpImL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h89Yk-0002TL-39; Sun, 24 Mar 2019 21:17:34 +0100
Date:   Sun, 24 Mar 2019 21:17:34 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190324201734.GC7782@lunn.ch>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
 <20190322064506.GB5348@vkoul-mobl>
 <20190322205059.GA29013@darkstar.musicnaut.iki.fi>
 <20190322212557.GF16623@lunn.ch>
 <20190322214120.GB29013@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322214120.GB29013@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:41:20PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Mar 22, 2019 at 10:25:57PM +0100, Andrew Lunn wrote:
> > > The OCTEON HW code knows only about RGMII. And looking at
> > > octeon ethernet staging driver it does phy connect always with
> > > PHY_INTERFACE_MODE_GMII. I did some experimentation, and it seems that
> > > with PHY_INTERFACE_MODE_RGMII_RXID it starts to work.. In the DT we have
> > > for ethernet for this board:
> > > 
> > > 	rx-delay = <0>;
> > > 	tx-delay = <0x10>;
> > 
> > These are not PHY properties. 
> > 
> > Looking at the code, it looks like these control delays the MAC
> > inserts. I don't see a binding document for these properties, so i've
> > no idea what 0x10 means. Before this driver moves out of staging,
> > these values should be changed to be in ns.
> 
> Documentation/devicetree/bindings/net/cavium-pip.txt

Hi Aaro

Ah, sorry, missed that.

- rx-delay: Delay value for RGMII receive clock. Optional. Disabled if 0.
  Value range is 1-31, and mapping to the actual delay varies depending on HW.

- tx-delay: Delay value for RGMII transmit clock. Optional. Disabled if 0.
  Value range is 1-31, and mapping to the actual delay varies depending on HW.

I'm surprised this made it passed review. We try to avoid having DT
poke magic values into registers. That is what this appears to be,
since it is unclear what the value actually means.

It is also good to state what happens if the property is not
present. It often means it defaults to zero. But this implementation
just leaves the value alone. So to be on the safe side, the DT blob
should probably have these properties, so the behaviour is well
defined.

	 Andrew
