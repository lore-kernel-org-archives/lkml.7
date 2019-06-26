Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66879C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4CE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gK0EQWHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFZUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:19:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34648 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZUT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NFJko5iqS35FHokxh5n5xZivkEJN2RL+dU9ytPcUk6Y=; b=gK0EQWHG1rl43jfPwy76o+HJZN
        mp/M8ZnWUoTdIxykxm0EjvHRKoLprEzCtPxjT7+3QOsY57pv+dEoFrISMPUBODx0atyGhYBH/xu31
        KuJ35aNeevr73iecGSnwcm+1gDOmn06ZTrV2bUhk3U+a5imWoUF+l812nCgbGgLydXzA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hgEOX-00043U-LC; Wed, 26 Jun 2019 22:19:53 +0200
Date:   Wed, 26 Jun 2019 22:19:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH net-next 07/10] net: stmmac: Enable support for > 32 Bits
 addressing in XGMAC
Message-ID: <20190626201953.GI27733@lunn.ch>
References: <cover.1561556555.git.joabreu@synopsys.com>
 <64b73591f981b3a280ea61d21a0dc7362a25348a.1561556556.git.joabreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b73591f981b3a280ea61d21a0dc7362a25348a.1561556556.git.joabreu@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	if (priv->dma_cap.addr64) {
> +		ret = dma_set_mask_and_coherent(device,
> +				DMA_BIT_MASK(priv->dma_cap.addr64));
> +		if (!ret)
> +			dev_info(priv->device, "Using %d bits DMA width\n",
> +				 priv->dma_cap.addr64);
> +	}

Hi Jose

If dma_set_mask_and_coherent() fails, i think you are supposed to fall
back to 32 bits. So you might want to clear priv->dma_cap.addr64.

But don't trust my, i could be wrong.

    Andrew
