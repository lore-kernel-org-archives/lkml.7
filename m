Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B636C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683AE2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 03:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FyqvWdS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGDDao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 23:30:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52848 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfGDDao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 23:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XuDtY8Dlqs5FD5x3L9E+zII7BIIPv0YBpCA9v+AVhAs=; b=FyqvWdS2bMXo1IsxWUUxMu1D5J
        wZ8mT2zNe8VO4Q+fYSHJgg1pkAU4DG9rD7DyFR5TKeSVYYmULnyHr49xI3tSrhc4GZ8WIA6ESGFt+
        cf98l6+JWr5zxSTzj+5IZHMLI5ywUbCBe58UTpGIVVOo8aerYK40ZGhps/iVvYAlfezU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hisSE-0001eb-4K; Thu, 04 Jul 2019 05:30:38 +0200
Date:   Thu, 4 Jul 2019 05:30:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Voon, Weifeng" <weifeng.voon@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        biao huang <biao.huang@mediatek.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Subject: Re: [PATCH v1 net-next] net: stmmac: enable clause 45 mdio support
Message-ID: <20190704033038.GA6276@lunn.ch>
References: <1562147404-4371-1-git-send-email-weifeng.voon@intel.com>
 <20190703140520.GA18473@lunn.ch>
 <D6759987A7968C4889FDA6FA91D5CBC8147384B6@PGSMSX103.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6759987A7968C4889FDA6FA91D5CBC8147384B6@PGSMSX103.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 01:33:16AM +0000, Voon, Weifeng wrote:
> > > @@ -155,22 +171,26 @@ static int stmmac_mdio_read(struct mii_bus *bus,
> > int phyaddr, int phyreg)
> > >  	struct stmmac_priv *priv = netdev_priv(ndev);
> > >  	unsigned int mii_address = priv->hw->mii.addr;
> > >  	unsigned int mii_data = priv->hw->mii.data;
> > > -	u32 v;
> > > -	int data;
> > >  	u32 value = MII_BUSY;
> > > +	int data = 0;
> > > +	u32 v;
> > >
> > >  	value |= (phyaddr << priv->hw->mii.addr_shift)
> > >  		& priv->hw->mii.addr_mask;
> > >  	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw-
> > >mii.reg_mask;
> > >  	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
> > >  		& priv->hw->mii.clk_csr_mask;
> > > -	if (priv->plat->has_gmac4)
> > > +	if (priv->plat->has_gmac4) {
> > >  		value |= MII_GMAC4_READ;
> > > +		if (phyreg & MII_ADDR_C45)
> > > +			stmmac_mdio_c45_setup(priv, phyreg, &value, &data);
> > > +	}
> > >
> > >  	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v &
> > MII_BUSY),
> > >  			       100, 10000))
> > >  		return -EBUSY;
> > >
> > > +	writel(data, priv->ioaddr + mii_data);
> > 
> > That looks odd. Could you explain why it is needed.
> > 
> > Thanks
> > 	Andrew
> 
> Hi Andrew,
> This mdio c45 support needed to access DWC xPCS which is a Clause-45

I mean it looks odd doing a write to the data register in the middle
of stmmac_mdio_read().

   Andrew
