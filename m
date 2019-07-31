Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6FC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4EB206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKiCIlvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfGaBgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:36:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49258 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfGaBgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MbVNcIqleGWDajEIzwbSrkr9UJ2vlKBIQWs7BCgs3Qk=; b=uKiCIlvCjadlgle851de+bSidr
        L+ClxfKg5jnk5yCPW2X8DH+7FvSUHNPBsCxjts2ILx7hHkhovl3GiFk58BHdK1l1oJ5cuFmLEZfQg
        JX3N8fTjHfLsWIp1rnCUuB5PKECKrVr+zPJMigo2OjJ40dP2TVA+g7EHsXk5BY80CT24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hsdXg-0003Cz-DV; Wed, 31 Jul 2019 03:36:36 +0200
Date:   Wed, 31 Jul 2019 03:36:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net-next 2/2] net: phy: broadcom: add 1000Base-X support
 for BCM54616S
Message-ID: <20190731013636.GC25700@lunn.ch>
References: <20190730002549.86824-1-taoren@fb.com>
 <CA+h21hq1+E6-ScFx425hXwTPTZHTVZbBuAm7RROFZTBOFvD8vQ@mail.gmail.com>
 <3987251b-9679-dfbe-6e15-f991c2893bac@fb.com>
 <CA+h21ho1KOGS3WsNBHzfHkpSyE4k5HTE1tV9wUtnkZhjUZGeUw@mail.gmail.com>
 <e8f85ef3-1216-8efb-a54d-84426234fe82@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f85ef3-1216-8efb-a54d-84426234fe82@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The INTF_SEL pins report correct mode (RGMII-Fiber) on my machine,
> but there are 2 "sub-modes" (1000Base-X and 100Base-FX) and I
> couldn't find a proper/safe way to auto-detect which "sub-mode" is
> active. The datasheet just describes instructions to enable a
> specific mode, but it doesn't say 1000Base-X/100Base-FX mode will be
> auto-selected. And that's why I came up with the patch to specify
> 1000Base-X mode.

Fibre does not perform any sort of auto-negotiation. I assume you have
an SFP connected? When using PHYLINK, the sfp driver will get the
supported baud rate from SFP EEPROM to determine what speed could be
used. However, there is currently no mainline support for having a
chain MAC-PHY-SFP. For that you need Russells out of tree patches.

      Andrew
