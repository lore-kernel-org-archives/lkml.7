Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2757BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98582082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MSgjxUPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDCJkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:40:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58086 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C3jCv1BCI/s8EdZ3pwEsAhvgQDQo0ioBHGBJcEAl7po=; b=MSgjxUPB2wUu/Wm3HVCj/Kp36
        8APc/3UV+VFV+OrVyfap3q6HDFm4IcBlDup6/Dm8yRobpLeUCjI2NG1n6A2AtKYARgQMAGaNWb37B
        k3nufowz44M4yOT+tL4OwDdGC12oclmql4HZOosw7vUNphaw+w3k9PE9BYzmPHtG2c9GsBDC+sfkB
        HRzbO1ZE3T8H6p0bDd0nRLEOh/ndnDx+3Uj8XrK7KZzpYMTORyM+iHS+q/J/LS3II6+yflQzehfGT
        +a6gDXzGsmxwixc7P7qQStnUdoNFpxX/CaazbxasYOUQ7JINfrZ6aFlIM5jQ1mZbqNj95kiyEFc9s
        ZizpG9oUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51938)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hBcNl-0002FQ-K0; Wed, 03 Apr 2019 10:40:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hBcNg-0004lb-DD; Wed, 03 Apr 2019 10:40:28 +0100
Date:   Wed, 3 Apr 2019 10:40:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v4 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190403094028.vvyuqe6ojza2ezhv@shell.armlinux.org.uk>
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
 <20190402131029.26880-2-antoine.tenart@bootlin.com>
 <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
 <20190402221048.fpdqfeuzscthn6qd@shell.armlinux.org.uk>
 <af550dd9-1374-621d-a37a-8e32314be01c@gmail.com>
 <20190403084614.GC3354@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403084614.GC3354@kwain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:46:14AM +0200, Antoine Tenart wrote:
> Hi,
> 
> On Wed, Apr 03, 2019 at 07:09:55AM +0200, Heiner Kallweit wrote:
> > On 03.04.2019 00:10, Russell King - ARM Linux admin wrote:
> > > On Tue, Apr 02, 2019 at 08:17:16PM +0200, Heiner Kallweit wrote:
> > >> On 02.04.2019 15:10, Antoine Tenart wrote:
> > >>> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> > >>> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> > >>> are powered down) when the PHY isn't used.
> > >>>
> > >>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > >>> ---
> > >>>  drivers/net/phy/marvell10g.c | 12 +++++++++++-
> > >>>  1 file changed, 11 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> > >>> index 80678919641d..9ee033c8a12b 100644
> > >>> --- a/drivers/net/phy/marvell10g.c
> > >>> +++ b/drivers/net/phy/marvell10g.c
> > >>> @@ -51,6 +51,8 @@ enum {
> > >>>  	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
> > >>>  
> > >>>  	/* Vendor2 MMD registers */
> > >>> +	MV_V2_PORT_CTRL		= 0xf001,
> > >>> +	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,
> > >>
> > >> If this driver is touched again I think it would be good to change all
> > >> such constants to BIT() and GENMASK(), ideally combined with the macros
> > >> from bitfields.h. This makes it much easier to check the code against the
> > >> datasheet. Apart from that:
> > > 
> > > Specifically, which constants are you talking about?
> > > 
> > > I think there's only MV_PCS_PAIRSWAP_MASK and MV_V2_TEMP_CTRL_MASK,
> > > which would be confusing to change given that the following definitions
> > > are values for the masked field.
> > > 
> > Exactly, MV_V2_TEMP_CTRL_MASK is a good example. My personal preference is
> > to define the mask as GENMASK(15, 14) and the field values as 0 and 3.
> > Then it's aligned with the datasheet that says:
> > 15:14 Temperature Sense Enable, 11 = Disable

Sorry, I don't see that.  You still have to convert between what the
data sheet says (binary) and the values used in C code (hex or decimal).
To me, it would be natural to state the above as 0xc000 rather than
stating it as '3' in the code with a GENMASK defining a mask for the
appropriate fields, and then have to check all over the place that
the right FIELD_* macros are used.  This seems _way_ more complex than
it needs to be.

> > Macros FIELD_GET and FIELD_PREP are perfect to deal with such fields.
> 
> I agree, I didn't used that to be consistent with what was already done
> in the driver.
> 
> > > However, MV_V2_PORT_CTRL_PWRDOWN should be defined using BIT() in any
> > > case.
> 
> Shouldn't MV_PCS_PAIRSWAP_AB also be defined using BIT()?

It is this that makes me utterly detest BIT().  It seems folk just
look at the value and think "it defines a single bit, it must use
BIT()" without thinking that it might be a field.  So we end up
with people inappropriately proposing to change stuff to BIT().

So no.

> More generally, we could have all the register definitions using the 0x
> values, the masks using GENMASK() and the values using a combination of
> BIT() and (0x... << y). That would match what's usually done in other
> drivers and improve the readability. (But I also recall being told not
> to use GENMASK in net/, so it's up to you to decide).

That difference is why I don't like GENMASK().  We end up with masks
defined using GENMASK() and their bitfields defined a completely
different way - there is no consistency, and it is not obvious that
the masks and the field values are related.

In my opinion, BIT() is only marginally useful, the rest just makes
things _less_ obviously correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
