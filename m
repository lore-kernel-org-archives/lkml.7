Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADECFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841FB20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfCAPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:07:12 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58629 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbfCAPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:07:11 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6B79CE0008;
        Fri,  1 Mar 2019 15:07:07 +0000 (UTC)
Date:   Fri, 1 Mar 2019 16:07:06 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190301150706.GD3554@kwain>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
 <20190301141953.GF19813@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301141953.GF19813@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Mar 01, 2019 at 03:19:53PM +0100, Andrew Lunn wrote:
> On Fri, Mar 01, 2019 at 12:00:47PM +0100, Antoine Tenart wrote:
> > When the Marvell 10G PHYs are set out of reset, the LPOWER bit is set
> > depending on an hardware configuration choice. We also do not know what
> > is the PHY state at boot time. Hence, set the PHY in low power by
> > default when this driver probes.
> 
> Florian did some work for c22 PHYs so that the existing link state
> could be used at boot. So for example, the bootloader configured the
> PHY up and it got link, there is no need to down/up the PHY when linux
> takes control. The networking comes up faster that way.
> 
> Can this work for this PHY?

This use case (the bootloader configures the PHY, Linux boots and sets
an interface using this PHY up) would work, and is what's happening in
some situations right now (the 3310 reset is never asserted prior to
this series).

But consider this case (let's say we use a 10G link):

  ----------------               ----------------
  |    Board 1   |               |    Board 2   |
  | MAC — 3310 — | — SFP cable — | — 3310 — MAC |
  ----------------               ----------------

Board 1: The userspace do not set the interface up. The MAC is in reset
         (default state during the MAC driver probe), the PHY was
	 configured by the bootloader.
Board 2: The userspace set the interface up. The MAC is configured, the
         PHY is configured as well.

The two PHY's PCS will establish a link and report it as being up. In
this case, phylink's AN mode is MLO_AN_PHY and thus will report the
overall link as being the PHY's link status: up.

My understanding is that the issue arises because the PHYs were never
set in reset, or low power, and thus act as if the user wanted the port
to be up. As the default behaviour for networking ports is to be down at
boot, I thought to set the PHY as well in a default low power state.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
