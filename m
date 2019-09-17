Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B6AC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4832171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w4J8Aj3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfIQSTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:19:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45066 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfIQSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eCXNNV9SLez5wvuBaHb0ao/EnouRF1ty87hE3ZUG5bk=; b=w4J8Aj3usTARijjC+Xob01o/A
        sQB0MsBEye7/3zNy8DMarwU2vYZZYcZya/F+9daAvobbUUKAgegtFMU0G320mXzII/JzuJoOXvPF9
        /2qz8G0C5shR2UPI/z3jO0TC9+tMgZVOHDYWT8g7cACioGAdBplxfbrT+vns45jPWlu4Zms7AmDOi
        i8VPET6os2b/WRK9CMvueJ0JU/waIGrnyAfgsHmOrom/yilbfRpQwbCn8DGSIPd8jjzqByH5IQEZ1
        sTq2mTJhrqv+H1yRAWfihFkFJ+4PK/YzNUAYX81X5iWKgEtIpoKpMvUxe/FFGh4NQlOh7RRKLoP2v
        Qg4TXSaDQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40730)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAI4C-0003Qr-BB; Tue, 17 Sep 2019 19:19:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAI49-0001Vw-8G; Tue, 17 Sep 2019 19:19:05 +0100
Date:   Tue, 17 Sep 2019 19:19:05 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20190917181905.GA25745@shell.armlinux.org.uk>
References: <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
 <20190917172658.GB9591@lunn.ch>
 <20190917173728.GZ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917173728.GZ25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:37:28PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Sep 17, 2019 at 07:26:58PM +0200, Andrew Lunn wrote:
> > > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > > index b3893347804d..85cf4a4a5e81 100644
> > > --- a/drivers/net/phy/at803x.c
> > > +++ b/drivers/net/phy/at803x.c
> > 
> > Hi Russell
> > 
> > This won't work. In the kernel logs, you see 
> > 
> > kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY]
> > 
> > The generic PHY driver is being used, not the at803x driver.
> 
> Well, the _correct_ driver needs to be used for the PHY specific
> features to be properly controlled.  Using the generic driver
> in this situation will not be guaranteed to work.

Well, this hasn't worked, but not for the obvious reason.  Register 0x14
is documented as read/write.  Bits 15:6 are reserved, bit 5 is the
smart speed enable, 4:2 configures the attempts, bit 1 sets the link
stable condition, bit 0 is reserved.

Writing 0x80c results in the register reading back 0x82c.  Writing
0x800 results in the same.  Writing 0 reads back 0x2c.  Writing 0xffff
seems to prevent packets being passed - and at that point I lost
control so I couldn't see what the result was.

There is nothing in the data sheet which suggests that there is any
gating of this register.  So it looks like we're stuck with smartspeed
enabled.

So, I think there's only two remaining ways forward - to revert commit
5502b218e001 to restore the old behaviour, read back the advertisement
from the PHY along with the rest of the status, as I've previously
stated.  It means that phylib will modify phydev->advertising at
random points, just as it modifies phydev->lp_advertising, so locking
may become an issue.  The revert approach is probably best until we
have something working along those lines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
