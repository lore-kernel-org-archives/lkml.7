Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D43C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA88206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FP3HHRzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfD1QhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:37:14 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47355 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfD1QhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uoSXhyD3TOK7i4eaxOafe7KFL4hfzJB0aeciU8oRpF8=; b=FP3HHRzzpWRywBh93FGqVkg6WT
        VQ741RPEI3K435alYDJFEzFaFh//UpVWpB0PhdXWmLbW5JqY/9XW4Lyc8aNvIWrci3qXgoVwdXGgE
        js4/0at4IXwEHMGAbwXjNUrbbm/glQmhXL5LUrUBsSg9qfgaiiAIFB6lVLpxONw76LGo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hKmnZ-0000m8-Rk; Sun, 28 Apr 2019 18:37:05 +0200
Date:   Sun, 28 Apr 2019 18:37:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     Jose Abreu <joabreu@synopsys.com>, davem@davemloft.net,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com,
        jianguo.zhang@mediatek.com
Subject: Re: [PATCH 5/6] net: stmmac: add mdio clause 45 access from mac
 device for dwmac4
Message-ID: <20190428163705.GH23059@lunn.ch>
References: <1556433009-25759-1-git-send-email-biao.huang@mediatek.com>
 <1556433009-25759-6-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556433009-25759-6-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 02:30:08PM +0800, Biao Huang wrote:
> +static int stmmac_c45_read(struct mii_bus *bus, int phyaddr,
> +			   int devad, int prtad)
> +{
> +	struct net_device *ndev = bus->priv;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	unsigned int mii_address = priv->hw->mii.addr;
> +	unsigned int mii_data = priv->hw->mii.data;
> +	u32 v, value;
> +	int data;
> +
> +	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
> +			       100, 10000))
> +		return -EBUSY;

Hi Biao

readl_poll_timeout() returns an error code. It is better to return
that, than make up some other error code. Yes, i know the C22 read
returns EBUSY, but we don't need to copy that behaviour into C45.

> +
> +	value = 0;
> +	value |= (prtad << priv->hw->mii.cl45_reg_shift)
> +			& priv->hw->mii.cl45_reg_mask;
> +	writel(value, priv->ioaddr + mii_data);
> +
> +	/* delay 2ms to avoid error value of get_phy_c45_devs_in_pkg */
> +	mdelay(2);

Please could you explain this a bit more?

       Andrew
