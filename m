Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B8217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCDKrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:47:08 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35065 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:47:05 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A920220000D;
        Mon,  4 Mar 2019 10:47:00 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:47:00 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        linux@armlinux.org.uk, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190304104700.GB3709@kwain>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
 <20190301141953.GF19813@lunn.ch>
 <20190301150706.GD3554@kwain>
 <d17bdf0c-f1b8-99e3-b199-a99a7f7347d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d17bdf0c-f1b8-99e3-b199-a99a7f7347d3@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, Mar 01, 2019 at 07:08:56PM -0800, Florian Fainelli wrote:
> On 3/1/2019 7:07 AM, Antoine Tenart wrote:
> > On Fri, Mar 01, 2019 at 03:19:53PM +0100, Andrew Lunn wrote:
> >> On Fri, Mar 01, 2019 at 12:00:47PM +0100, Antoine Tenart wrote:
> >>> When the Marvell 10G PHYs are set out of reset, the LPOWER bit is set
> >>> depending on an hardware configuration choice. We also do not know what
> >>> is the PHY state at boot time. Hence, set the PHY in low power by
> >>> default when this driver probes.
> >>
> >> Florian did some work for c22 PHYs so that the existing link state
> >> could be used at boot. So for example, the bootloader configured the
> >> PHY up and it got link, there is no need to down/up the PHY when linux
> >> takes control. The networking comes up faster that way.
> >>
> >> Can this work for this PHY?
> > 
> > This use case (the bootloader configures the PHY, Linux boots and sets
> > an interface using this PHY up) would work, and is what's happening in
> > some situations right now (the 3310 reset is never asserted prior to
> > this series).
> > 
> > But consider this case (let's say we use a 10G link):
> > 
> >   ----------------               ----------------
> >   |    Board 1   |               |    Board 2   |
> >   | MAC — 3310 — | — SFP cable — | — 3310 — MAC |
> >   ----------------               ----------------
> > 
> > Board 1: The userspace do not set the interface up. The MAC is in reset
> >          (default state during the MAC driver probe), the PHY was
> > 	 configured by the bootloader.
> > Board 2: The userspace set the interface up. The MAC is configured, the
> >          PHY is configured as well.
> > 
> > The two PHY's PCS will establish a link and report it as being up. In
> > this case, phylink's AN mode is MLO_AN_PHY and thus will report the
> > overall link as being the PHY's link status: up.
> > 
> > My understanding is that the issue arises because the PHYs were never
> > set in reset, or low power, and thus act as if the user wanted the port
> > to be up. As the default behaviour for networking ports is to be down at
> > boot, I thought to set the PHY as well in a default low power state.
> 
> The policy you are creating here for the marvell10g driver is entirely
> applicable to any PHY <=> PHY configuration where either of the two
> software agents on Board 1 or Board 2 has not had a chance to bring-up
> its bootloader/OS/applications to control the PHY.

Right.

> A number of PHYs come up fully on (or in isolate or super isolate mode)
> and will AN with their link partner if connected. For some people it's a
> feature, for some it is a waste of power. I don't necessarily have an
> issue with your patch per-se, but it does create an one off behavior
> that other PHY drivers may not follow.

I agree having a per-driver behaviour is not something we want. As I
understand it, there is no behaviour enforced currently regarding this
matter. I agree both cases have their pros and cons:
- It's weird to have an interface reporting being UP when it's not
  really.
- Having the link come up faster can be a feature.

I have some questions then:
- Do you think calling suspend() in the core when probing a PHY driver
  would work for all PHYs?
- Would a new Kconfig option selecting the default behaviour at boot
  time be a solution?
- Or this is a WONTFIX kind of (small) issues? :)

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
