Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4284120856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sbySXTdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDBWLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:11:02 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49932 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDBWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=es64vU0VKMF9T1z27MbS/NsJzqUEJZmz9V23k1T819E=; b=sbySXTdY2w+R2NcmrLyD+PkyU
        JY3cZgmZtFY5El9otXcI/U8eQTtGs57nfXV4D8deIu1tOCi8uZdqqDkD5Uh/zjnpLAAO4BUVtTrhf
        wBbE7pWP3fkmxSzoh9HZFWQ+0jXieuq140/uhA0IvWAJJztGj4jdQGPAcoU68EbtRayrCfuQdeSgs
        sN7PZL+A5k0oARS4IJHaZF25hW5EwtNrmDHFkmqA/ODhSezRaAJAd3zQz2+s+a86zyS0vzcJe0/PC
        jWmMLSw5TOnZkuPOphsQNrLRVvKYHGugIaGp9uyBcYxUx/a5+1uNuZHw7DqStUiKE7Yv32F2PmxZe
        g3yHbLoAw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55286)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hBRcL-0007Th-Ja; Tue, 02 Apr 2019 23:10:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hBRcG-0004Ld-SZ; Tue, 02 Apr 2019 23:10:48 +0100
Date:   Tue, 2 Apr 2019 23:10:48 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v4 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190402221048.fpdqfeuzscthn6qd@shell.armlinux.org.uk>
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
 <20190402131029.26880-2-antoine.tenart@bootlin.com>
 <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:17:16PM +0200, Heiner Kallweit wrote:
> On 02.04.2019 15:10, Antoine Tenart wrote:
> > This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> > three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> > are powered down) when the PHY isn't used.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  drivers/net/phy/marvell10g.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> > index 80678919641d..9ee033c8a12b 100644
> > --- a/drivers/net/phy/marvell10g.c
> > +++ b/drivers/net/phy/marvell10g.c
> > @@ -51,6 +51,8 @@ enum {
> >  	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
> >  
> >  	/* Vendor2 MMD registers */
> > +	MV_V2_PORT_CTRL		= 0xf001,
> > +	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,
> 
> If this driver is touched again I think it would be good to change all
> such constants to BIT() and GENMASK(), ideally combined with the macros
> from bitfields.h. This makes it much easier to check the code against the
> datasheet. Apart from that:

Specifically, which constants are you talking about?

I think there's only MV_PCS_PAIRSWAP_MASK and MV_V2_TEMP_CTRL_MASK,
which would be confusing to change given that the following definitions
are values for the masked field.

However, MV_V2_PORT_CTRL_PWRDOWN should be defined using BIT() in any
case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
