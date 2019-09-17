Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AB8C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD802171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hv2zeqGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfIQMyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:54:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50458 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfIQMyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=53HEgi+72KwpP9sgsXsDmzVZkyS10sCz71cZFT+AAfk=; b=Hv2zeqGHZl58IobfJJXo7ZMRQ4
        32JsM7SK/VJ2h1fe0KuOAIZdw2fZ4U8nin5av2mdlNwqSITfVtkzlY5EQJ/4dM4c0hCNrbIGh19J8
        HclRUpAbE1miLccGX+a0F6uJ996GQ7Yt01oaFVLT61v7hBgxoGDbAfEY6jfkLHxJSiA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1iAD06-0000w9-Vu; Tue, 17 Sep 2019 14:54:34 +0200
Date:   Tue, 17 Sep 2019 14:54:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     tinywrkb <tinywrkb@gmail.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917125434.GH20778@lunn.ch>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
 <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917124101.GA1200564@arch-dsk-01>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:41:01PM +0300, tinywrkb wrote:
> On Sun, Sep 15, 2019 at 03:56:52PM +0200, Andrew Lunn wrote:
> > > Tinywrkb confirmed to me in private communication that revert of
> > > 5502b218e001 fixes Ethernet for him on effected system.
> > > 
> > > He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> > > only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> > > there was a plan to use a different 10/100 PHY for Solo/DualLite
> > > SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> > > AR8035 PHY that supports 1Gb.
> > > 
> > > Commit 5502b218e001 might be triggering a hardware issue on the affected
> > > Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> > > SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> > > the moment.
> > 
> > Could somebody with an affected device show us the output of ethtool
> > with and without 5502b218e001. Does one show 1G has been negotiated,
> > and the other 100Mbps? If this is true, how does it get 100Mbps
> > without that patch? We are missing a piece of the puzzle.
> > 
> > 	Andrew
> 
> linux-test-5.1rc1-a2703de70942-without_bad_commit
> 
> Settings for eth0:
> 	Supported ports: [ TP MII ]
> 	Supported link modes:   10baseT/Half 10baseT/Full
> 	                        100baseT/Half 100baseT/Full
> 	                        1000baseT/Full

So this means the local device says it can do 1000Mbps.


> 	Supported pause frame use: Symmetric
> 	Supports auto-negotiation: Yes
> 	Supported FEC modes: Not reported
> 	Advertised link modes:  10baseT/Half 10baseT/Full
> 	                        100baseT/Half 100baseT/Full
> 	                        1000baseT/Full

The link peer can also do 1000Mbps.


> 	Advertised pause frame use: Symmetric
> 	Advertised auto-negotiation: Yes
> 	Advertised FEC modes: Not reported
> 	Link partner advertised link modes:  10baseT/Half 10baseT/Full
> 	                                     100baseT/Half 100baseT/Full
> 	                                     1000baseT/Full
> 	Link partner advertised pause frame use: Symmetric
> 	Link partner advertised auto-negotiation: Yes
> 	Link partner advertised FEC modes: Not reported
> 	Speed: 100Mb/s

Yet they have decided to do 100Mbps. 

We need to understand Why? The generic PHY driver would not do this on
its own. So i'm thinking something has poked a PHY register with some
value, and this patch is causing it to be over written.

Please can you use mii-tool -v -v to dump the PHY registers in each
case.

Thanks
	Andrew
