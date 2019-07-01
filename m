Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B93DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D839C20881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QX/AMLFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfGAQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:11:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46048 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbfGAQLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d9Af5O7l79U2DHb92mI2uPYGZXrMTu1/85MNMLeFZxQ=; b=QX/AMLFuTEXX91268xImbz99YO
        OKbYckaKRnE3WuJp/OtwseaVhvy5PbfZhKjlM38OFdChqlxHR8053UMN6RLdVoRXRDQimpB6/KHx0
        01gR/3zlNDYdBNLmsVNpkuaZ6IkuAgcfpnpLwy4Is8+dOBx/e1HSA1IZYQ73YHee1iEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hhytz-0008H2-0V; Mon, 01 Jul 2019 18:11:35 +0200
Date:   Mon, 1 Jul 2019 18:11:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linus.walleij@linaro.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] net: dsa: vsc73xx: add support for parallel mode
Message-ID: <20190701161134.GC30468@lunn.ch>
References: <20190701152723.624-1-paweldembicki@gmail.com>
 <20190701152723.624-3-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701152723.624-3-paweldembicki@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:27:22PM +0200, Pawel Dembicki wrote:
> +static int vsc73xx_platform_read(struct vsc73xx *vsc, u8 block, u8 subblock,
> +				 u8 reg, u32 *val)
> +{
> +	struct vsc73xx_platform *vsc_platform = vsc->priv;
> +	u32 offset;
> +
> +	if (!vsc73xx_is_addr_valid(block, subblock))
> +		return -EINVAL;
> +
> +	offset = vsc73xx_make_addr(block, subblock, reg);
> +
> +	mutex_lock(&vsc->lock);
> +		*val = ioread32be(vsc_platform->base_addr + offset);
> +	mutex_unlock(&vsc->lock);

Hi Pawel

What is this mutex protecting?

Plus the indentation is wrong.

Thanks
	Andrew
