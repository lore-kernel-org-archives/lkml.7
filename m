Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6C206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FJE07Xb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfCDQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:11:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57202 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfCDQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YBz9BBEyPO1LAZDBwd4j3W6qsa5YVzMKOfTE6iUK1Y0=; b=FJE07Xb0SFDYP211a2nyIWh5D
        sp98X+7FDiiWH+OB7zI+ht5TcHA13iYACu82h6Z5GFx8bvPGx9UjSRtZvU7nks6ghZHXz1Kx+IT9P
        t3k1hxG708SbvBUPEjcmtQVs6vH0kgE+a9s3nAetszDv7d8Ye2GKjrkDcIhuWR1PjQnFZj+S3l0re
        PNrK/X/36/KcCj37tVnmV97DLj/bdBMtzXrlVWFN2miudUJ2N1IVSVhJHi1eH0XjTuVXf+QgPS3dO
        FMCxLN3l8NCWiPVX7C/7MDEE/B9PXWWzun9B8tGdlCel6DWsd3n8mmPavIc0qLFDHtkV5aU6vQ3np
        bPCXf0c9Q==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54926)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h0qB3-0003sb-6I; Mon, 04 Mar 2019 16:10:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h0qAx-0002Rz-EC; Mon, 04 Mar 2019 16:10:47 +0000
Date:   Mon, 4 Mar 2019 16:10:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low
 power by default
Message-ID: <20190304161047.umxg53ax45rxjuqg@shell.armlinux.org.uk>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
 <20190301110047.20257-4-antoine.tenart@bootlin.com>
 <20190301141953.GF19813@lunn.ch>
 <20190301150706.GD3554@kwain>
 <d17bdf0c-f1b8-99e3-b199-a99a7f7347d3@gmail.com>
 <20190304104700.GB3709@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304104700.GB3709@kwain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:47:00AM +0100, Antoine Tenart wrote:
> Hi Florian,
> 
> I agree having a per-driver behaviour is not something we want. As I
> understand it, there is no behaviour enforced currently regarding this
> matter. I agree both cases have their pros and cons:
> - It's weird to have an interface reporting being UP when it's not
>   really.

What about when an interface is listening for wake-on-lan packets?

Let's say board 1 is powered down and has WoL enabled.  Board 2 is
as per your configuration.  Board 2's interface reports that the
link is up.  Most of the packets that would be sent out the
interface end up disappearing into a black hole in the same way
as your original scenario.

How is this "weird" ?

There are many cases where exactly this happens - you are trying to
make one particular scenario behave "better" without considering
whether it's possible with all or even the majority of scenarios.

The only case where what you're suggesting makes sense is a point-to-
point link between two systems, which is not the norm.

More than that, when board 1 boots, initially the link will be up
from reset.  When the kernel eventually boots with your patch, the
link will then go down until board 1 configures the interface.  So,
board 2 sees that the interface comes up, and could assume that
board 1 is alive and well - but it isn't because (eg) it's in the
boot loader.

Basically, what I'm pointing out is that even in your minority
scenario, reasoning that board 2 should not see "link up" status
until board 1's interface is configured is not reasonable.

The link status is about the physical connectivity on the local
interface, it is not about the link between the interfaces on the
two machines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
