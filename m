Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF42206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfCEMyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:54:14 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:59213 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:54:14 -0500
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7DCD910000F;
        Tue,  5 Mar 2019 12:54:07 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:54:07 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190305125407.GC3709@kwain>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
 <20190301141953.GF19813@lunn.ch>
 <20190301150706.GD3554@kwain>
 <d17bdf0c-f1b8-99e3-b199-a99a7f7347d3@gmail.com>
 <20190304104700.GB3709@kwain>
 <20190304161047.umxg53ax45rxjuqg@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190304161047.umxg53ax45rxjuqg@shell.armlinux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, Mar 04, 2019 at 04:10:47PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Mar 04, 2019 at 11:47:00AM +0100, Antoine Tenart wrote:
> > 
> > I agree having a per-driver behaviour is not something we want. As I
> > understand it, there is no behaviour enforced currently regarding this
> > matter. I agree both cases have their pros and cons:
> > - It's weird to have an interface reporting being UP when it's not
> >   really.
> 
> What about when an interface is listening for wake-on-lan packets?
> 
> Let's say board 1 is powered down and has WoL enabled.  Board 2 is
> as per your configuration.  Board 2's interface reports that the
> link is up.  Most of the packets that would be sent out the
> interface end up disappearing into a black hole in the same way
> as your original scenario.

I see your point, in the WoL case the link would be reported as being up
as the PHY on board 1 would be functional (at least to process WoL
packets) so the link between the two PHYs would be established and
reporting a link being UP, but not entirely functional.

That's kind of a fair point, but not exactly the same. In such case some
packets might have an effect, whereas in the case I described earlier
not a single packet would make sense. But also I might not be aware of
other valid cases.

> The only case where what you're suggesting makes sense is a point-to-
> point link between two systems, which is not the norm.
> 
> More than that, when board 1 boots, initially the link will be up
> from reset.  When the kernel eventually boots with your patch, the
> link will then go down until board 1 configures the interface.  So,
> board 2 sees that the interface comes up, and could assume that
> board 1 is alive and well - but it isn't because (eg) it's in the
> boot loader.

This depends on the bootloader, but OK, that is what's happening in this
very case. I'm not fully convinced this relates to the scenario I
described. The link would be up and you're right could be not functional
because the way the bootloader works. And this is temporary.

> Basically, what I'm pointing out is that even in your minority
> scenario, reasoning that board 2 should not see "link up" status
> until board 1's interface is configured is not reasonable.
> 
> The link status is about the physical connectivity on the local
> interface, it is not about the link between the interfaces on the
> two machines.

Right. The thing I find odd here is there is no physical connectivity
between the MACs (one is in reset), only between one MAC and the LP's
PHY. Given your definition of a link being up "between the interfaces",
OK, that makes sense if we talk about the PHYs. It also means we do not
have the same behaviour at boot time between an interface using a PHY,
and one directly connected to serdes lanes.

So, I don't have a strong opinion about this, and it's not a big issue
either way. I think the discussion moved into what should be the default
state of a PHY a probe time, as it seems there are no policy being
enforced right now.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
