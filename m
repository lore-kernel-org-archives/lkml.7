Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002AC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DDF2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L5e/4sTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfLLNZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:25:38 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50082 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfLLNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bxnXIodnVA+EXBQ9CzKw2+L2s06f/eW1ZteOUMDWsiU=; b=L5e/4sTMJEgfoy08MJh5WXYJ6i
        vtxgJMqAJUi8fKfN/Q5KP8FQnuW4FE9UBwBZ/KRoW0xWFvLE685wFxZz9EFJekPOrDAqg783JqQJ3
        XPskH3kEU7fR0/Ph78F3bj9HvZWOr4H99XHMwhfMNb8afPT2T5Xye6Z5mz+fbKas7xlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ifOT2-0002nd-BQ; Thu, 12 Dec 2019 14:25:20 +0100
Date:   Thu, 12 Dec 2019 14:25:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com
Subject: Re: [PATCH 1/2] net-next: stmmac: mediatek: add more suuport for RMII
Message-ID: <20191212132520.GB9959@lunn.ch>
References: <20191212024145.21752-1-biao.huang@mediatek.com>
 <20191212024145.21752-2-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212024145.21752-2-biao.huang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:41:44AM +0800, Biao Huang wrote:
> MT2712 SoC can provide the rmii reference clock, and the clock
> will output from TXC pin only, which means ref_clk pin of external
> PHY should connect to TXC pin in this case.
> Add corresponding clock and timing settings.

Hi Biao

Subject line has a typo.

> @@ -278,6 +296,7 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
>  	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
>  	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
>  	plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
> +	plat->rmii_clk_from_mac = of_property_read_bool(plat->np, "mediatek,rmii-clk-from-mac");
>  
>  	return 0;
>  }
> @@ -287,6 +306,16 @@ static int mediatek_dwmac_clk_init(struct mediatek_dwmac_plat_data *plat)
>  	const struct mediatek_dwmac_variant *variant = plat->variant;
>  	int i, num = variant->num_clks;
>  
> +	plat->mac_rmii_clk = NULL;
> +	if (plat->phy_mode == PHY_INTERFACE_MODE_RMII &&
> +	    plat->rmii_clk_from_mac) {
> +		plat->mac_rmii_clk = devm_clk_get(plat->dev, "rmii_internal");
> +		if (IS_ERR(plat->mac_rmii_clk)) {
> +			dev_err(plat->dev, "Failed to get reference clk from MAC\n");
> +			return PTR_ERR(plat->mac_rmii_clk);
> +		}
> +	}

Please don't use a binary property. This is a clock, so describe it in
DT as a clock. Add it to the existing list of clocks.

   Andrew
