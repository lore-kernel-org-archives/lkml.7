Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABDC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31176218AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QibepfwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfIQSjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:39:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51318 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfIQSjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=taIBPGYkIVMe8MiFytbX0T9rZMz92fCysG30eRO4viY=; b=QibepfwKOsVPkP14yx0txbt1gn
        KhjMQJVLOUuv3pI9UGICUFKsyVRL3QmuUYKQcP+UEkpfd4wmtl/XFU5fajEskaTBC+ix8Wvi3QCOn
        iKnteiC8KLNymp63/zWS6q1eIwyWQabPp8lFFoDw3NC53fAA3i71/ykme+IW8LTsyl6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1iAINy-0002yN-5X; Tue, 17 Sep 2019 20:39:34 +0200
Date:   Tue, 17 Sep 2019 20:39:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        tinywrkb <tinywrkb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917183934.GJ20778@lunn.ch>
References: <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
 <20190917172658.GB9591@lunn.ch>
 <20190917173728.GZ25745@shell.armlinux.org.uk>
 <20190917181905.GA25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917181905.GA25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, the _correct_ driver needs to be used for the PHY specific
> > features to be properly controlled.  Using the generic driver
> > in this situation will not be guaranteed to work.

I fully agree about the PHY driver. I'm expect this device is
violating c22 when it modifies the advertisement register itself. So
all bets are off for the genphy.

> Well, this hasn't worked, but not for the obvious reason.  Register 0x14
> is documented as read/write.  Bits 15:6 are reserved, bit 5 is the
> smart speed enable, 4:2 configures the attempts, bit 1 sets the link
> stable condition, bit 0 is reserved.
> 
> Writing 0x80c results in the register reading back 0x82c.  Writing
> 0x800 results in the same.  Writing 0 reads back 0x2c.  Writing 0xffff
> seems to prevent packets being passed - and at that point I lost
> control so I couldn't see what the result was.
> 
> There is nothing in the data sheet which suggests that there is any
> gating of this register.  So it looks like we're stuck with smartspeed
> enabled.
> 
> So, I think there's only two remaining ways forward - to revert commit
> 5502b218e001 to restore the old behaviour, read back the advertisement
> from the PHY along with the rest of the status, as I've previously
> stated.  It means that phylib will modify phydev->advertising at
> random points, just as it modifies phydev->lp_advertising, so locking
> may become an issue.  The revert approach is probably best until we
> have something working along those lines.

We have a couple of other PHYs which support downshift. We should see
if we can follow what they do. What is i think important is that
read_status return the correct speed. So we probably cannot use
genphy_read_status() as is. Maybe we should split genphy_read_status()
into two, so the register reading bit can be done unconditionally by
phy drivers for hardware which don't report link down when they
should?

    Andrew
