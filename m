Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3549CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15B92087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kzvgw3Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfCRJeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfCRJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so16181192wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hDC7MDTy7chuvT3CYRtvVKRB25oC64BHrW8HkrSRHxM=;
        b=Kzvgw3Aa4dx8WMMUuEI+TQXXTUuYcIsNoM5H0zoKvRWB1t40YzRv3+KmM2JlvNhI/8
         Rclw57CZAGvJQFS/vErYEwe+gPMYYUb+x/nI+nc3aN5g+DisHoPp04AlOku3xuAT9tQm
         mC0a52jJw2Bg/5IveR5AIqZSIwXyBnUlTm7gxbxYjf+BfEXej3zGqe9D6H5oTjykwRPP
         JelpT2cqELZfl9/May2SBOfOyBPb/Kr8BI8KeAqWwzD9dM7bRh0AZanzK5E4xKmXKLfh
         EGZqaqWf/wNNIxiPyr03lrTzWWVNGjx1HeON2l2OOBHu7SevvF34q6HThHcAt/g4xZFP
         KdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hDC7MDTy7chuvT3CYRtvVKRB25oC64BHrW8HkrSRHxM=;
        b=Yct8wI/2DVtZs4/WBJUNTOaccIW7eEDxs72JPO5iURzLAQG4kw7CO/KMqfMq+R8C1u
         +NQf34T6LNtTCpPNrnk00owSidbzrCa7JoPij3pPyCMjDnnM9zO/oQEm83IOpmwUVunu
         FYMgSKlrWZq6zm/iexDq2dU5SkEO5n3ijNN4btybSYHfyjnhwjnhKZtuRNqRvLxsxKHr
         wBzxDYt9dz6p5I8hyZbW2ud32FqgWJqKRtBNT3en0lZ5QOukRVqNx/asfwqfCVJTbB6R
         WGTocjJxruzNu+6ba+zPHBe2+w6mWtlqWnOHaUbYt5SLG4DIx7+efDK+9GjEJXGovDIX
         hgqA==
X-Gm-Message-State: APjAAAX0NoRolx95c7izJOvsX506whj1Dog859J70YbIgUX5EL7CV3lj
        zL3mODfxkIVjQZeiUYeLsA9EOg==
X-Google-Smtp-Source: APXvYqyZTwE2E1jAkDUHpd8/2uElbRuBSXyhbjfkplzTOPSqG6ZEC32/dpXi2yK4hLUgLs8QdO5aNg==
X-Received: by 2002:adf:ebce:: with SMTP id v14mr10964916wrn.69.1552901644788;
        Mon, 18 Mar 2019 02:34:04 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id o8sm2482598wmh.11.2019.03.18.02.34.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 02:34:03 -0700 (PDT)
Message-ID: <5b9b363f00acdcd83cce1a3e7bddda71edac9c06.camel@baylibre.com>
Subject: Re: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:34:02 +0100
In-Reply-To: <20190317161402.GB22226@lunn.ch>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
         <20190314140135.19184-3-jbrunet@baylibre.com>
         <20190317161402.GB22226@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-17 at 17:14 +0100, Andrew Lunn wrote:
> On Thu, Mar 14, 2019 at 03:01:34PM +0100, Jerome Brunet wrote:
> > Add support for the mdio mux and internal phy glue of the g12a SoC family
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/net/phy/Kconfig               |  10 +
> >  drivers/net/phy/Makefile              |   1 +
> >  drivers/net/phy/mdio-mux-meson-g12a.c | 371 ++++++++++++++++++++++++++
> >  3 files changed, 382 insertions(+)
> >  create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c
> > 
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index 071869db44cf..831aa350b1cb 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -74,6 +74,16 @@ config MDIO_BUS_MUX_GPIO
> >  	  several child MDIO busses to a parent bus.  Child bus
> >  	  selection is under the control of GPIO lines.
> >  
> > +config MDIO_BUS_MUX_MESON_G12A
> > +	tristate "Amlogic G12a based MDIO bus multiplexer"
> > +	depends on ARCH_MESON || COMPILE_TEST
> > +	depends on OF_MDIO && HAS_IOMEM
> > +	select MDIO_BUS_MUX
> 
> Hi Jerome
> 
> Do you need some clock depends? 

I don't think we need more. ARCH_MESON already selects the necessary clock
parts. As for the COMPILE_TEST, the clock code should be able to compile even
if the common clock framework is disabled.

> 
> > +static int g12a_mdio_switch_fn(int current_child, int desired_child,
> > +			       void *data)
> > +{
> > +	struct device *dev = data;
> > +	struct g12a_mdio_mux *priv = dev_get_drvdata(dev);
> 
> David won't like that you don't have reverse Christmas tree. You need
> to do the assignment to priv in the body of the code. Or can you pass
> data directly to dev_get_drvdata?
> 
> > +static int g12a_mdio_mux_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +	struct g12a_mdio_mux *priv;
> > +	int ret;
> 
> Reverse Christmas tree please.

I'll fix these

> 
> 
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(priv->regs))
> > +		return PTR_ERR(priv->regs);
> > +
> > +	priv->pclk = devm_clk_get(dev, "pclk");
> > +	if (IS_ERR(priv->pclk)) {
> > +		ret = PTR_ERR(priv->pclk);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(dev, "failed to get peripheral clock\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Make sure the device registers are clocked */
> > +	ret = clk_prepare_enable(priv->pclk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable peripheral clock");
> > +		return ret;
> > +	}
> > +
> > +	/* Register PLL in CCF */
> > +	ret = g12a_ephy_glue_clk_register(dev);
> 
> On error, you are not disabling the peripheral clock.

Indeed, good catch. Thx

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return mdio_mux_init(dev, dev->of_node, g12a_mdio_switch_fn,
> > +			     &priv->mux_handle, dev, NULL);
> > +}
> 
>   Andrew


