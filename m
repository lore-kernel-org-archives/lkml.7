Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B62087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="un6l3eJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCQQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:14:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56494 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfCQQOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ga/d6DAfonYT+aevDO+ynI5XmAxDR8reYVrq9kRGXeU=; b=un6l3eJTOWHqfEoAodPnhb1QTO
        2UAS6okdoMWGsw3GKOuFwNkhe9WV4mOjDBdev5BLLDVsCEdtn/A8OMXo+uuHcAugzwriQknwZjEdW
        IAuCh5mSK6moTSLbZro6PW4tdt+Qc+hZv0mXp50oMDZRRyiE7WO4mwEZKjiPnj51np4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h5YQE-00067B-Tr; Sun, 17 Mar 2019 17:14:02 +0100
Date:   Sun, 17 Mar 2019 17:14:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
Message-ID: <20190317161402.GB22226@lunn.ch>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
 <20190314140135.19184-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314140135.19184-3-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:01:34PM +0100, Jerome Brunet wrote:
> Add support for the mdio mux and internal phy glue of the g12a SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/net/phy/Kconfig               |  10 +
>  drivers/net/phy/Makefile              |   1 +
>  drivers/net/phy/mdio-mux-meson-g12a.c | 371 ++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+)
>  create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 071869db44cf..831aa350b1cb 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -74,6 +74,16 @@ config MDIO_BUS_MUX_GPIO
>  	  several child MDIO busses to a parent bus.  Child bus
>  	  selection is under the control of GPIO lines.
>  
> +config MDIO_BUS_MUX_MESON_G12A
> +	tristate "Amlogic G12a based MDIO bus multiplexer"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	select MDIO_BUS_MUX

Hi Jerome

Do you need some clock depends? 

> +static int g12a_mdio_switch_fn(int current_child, int desired_child,
> +			       void *data)
> +{
> +	struct device *dev = data;
> +	struct g12a_mdio_mux *priv = dev_get_drvdata(dev);

David won't like that you don't have reverse Christmas tree. You need
to do the assignment to priv in the body of the code. Or can you pass
data directly to dev_get_drvdata?

> +static int g12a_mdio_mux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct g12a_mdio_mux *priv;
> +	int ret;

Reverse Christmas tree please.


> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	priv->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(priv->pclk)) {
> +		ret = PTR_ERR(priv->pclk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get peripheral clock\n");
> +		return ret;
> +	}
> +
> +	/* Make sure the device registers are clocked */
> +	ret = clk_prepare_enable(priv->pclk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable peripheral clock");
> +		return ret;
> +	}
> +
> +	/* Register PLL in CCF */
> +	ret = g12a_ephy_glue_clk_register(dev);

On error, you are not disabling the peripheral clock.

> +	if (ret)
> +		return ret;
> +
> +	return mdio_mux_init(dev, dev->of_node, g12a_mdio_switch_fn,
> +			     &priv->mux_handle, dev, NULL);
> +}

  Andrew
