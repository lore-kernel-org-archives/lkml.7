Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC408C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA68A206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ch+J675q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfLLKUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:20:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37006 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfLLKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:20:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so2108680wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=FWshdGOlPI7yjVJAElFvMo0mlzQ6xIrNID/VuBYtMSo=;
        b=Ch+J675qtJbBX8NFcLS7CYqYDrNctC1O0yw6s4DcnHprhA91RaEmIlTNuyNTsQwWrC
         hvbgwH5ipBMwZN/Ar5J6GQJPFZwa49XYAT5QK12dmuqXkFJ0ZMPa8A24SpxxohwxxDIj
         S5KM2WaPLDMe6iu+lTejbUH7fGBZnQGwsexvq9rgMDEX9KjE9q5UJDGKhGFrNhSVAq+D
         xJWnK6ThYoeS8N9wQg0AWif5xusWzRBrA5KLqeo8coRGQUVOFs8e6o34T/CfPalY1nPl
         7K7IlI+Tg35SVoDo2AnDk4E0bjXPrZ+iNJn28zUBHamlbQDZxtlLAeg+ce0MtasPGheL
         RmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=FWshdGOlPI7yjVJAElFvMo0mlzQ6xIrNID/VuBYtMSo=;
        b=b+/gdRJjN1avl9n9CKw9ylUCJvlUUmrcqVPuXaN7aq0QJDB1Ne1PDlN+DRduAGvuzP
         +uRuusXGi0o2yu0mqxNahbmeqFFRi3sfW3Zyxx7WHrLlmuszNvlVcW3SZzHKmqwLqRjY
         LnfjrR+cvUzNG+fOIVJaVnGEwpv8sDlLXsO9Y+4+mH8QCZfffHymnKpzy5s0yV/bsr0G
         nAsDrtfnDW9M1nA1kyMRIBaTmMvtxfYmKWPn2+eMpZdX2fo+OQyD5n5dRcDEyu8ocfg8
         ek7iWfkHLPgBqkyMHMS7HbypKGyuiwQxram2nyoBVrzIzKelz3RghaYF1qq0HUlnvSv9
         jYnA==
X-Gm-Message-State: APjAAAUBOmA+VCapqmw0RpOnzt1CQxIUssQE4mHrvaGngODa0tWIXrfR
        k8wKykD7iUzuhBRbVvM34mPeMw==
X-Google-Smtp-Source: APXvYqw+sp+j42VZGq85rGThgx/ogUAVCFmxSUrPZRugAeSCRN9cShhFUB1lK7uDgM7f0ZfqlYo+zg==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr5320534wrs.159.1576146000146;
        Thu, 12 Dec 2019 02:20:00 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e6sm5485646wru.44.2019.12.12.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:19:59 -0800 (PST)
References: <20191206074052.15557-1-jian.hu@amlogic.com> <20191206074052.15557-4-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] clk: meson: eeclk: refactor eeclk common driver to support A1
In-reply-to: <20191206074052.15557-4-jian.hu@amlogic.com>
Date:   Thu, 12 Dec 2019 11:19:59 +0100
Message-ID: <1j7e31lub4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:

> Introduce a common probe function for A1 series, the way to get
> regmap is different between A1 series and the previous series.
> The register region is only for one clock driver, the function of
> meson_eeclkc_probe is not fit for A1, So it is necessary to
> introduce a new function.

Please drop this patch

#1 you are patching the EE driver for something that is no longer an EE
 driver
#2 Let's get the basics right, you can move (re)factoring afterward

Your probe function is simple enough. Just properly write it in each
driver for now.

>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  drivers/clk/meson/meson-eeclk.c | 59 +++++++++++++++++++++++++++------
>  drivers/clk/meson/meson-eeclk.h |  1 +
>  2 files changed, 50 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
> index a7cb1e7aedc4..12ceb1caabd8 100644
> --- a/drivers/clk/meson/meson-eeclk.c
> +++ b/drivers/clk/meson/meson-eeclk.c
> @@ -13,25 +13,37 @@
>  #include "clk-regmap.h"
>  #include "meson-eeclk.h"
>  
> -int meson_eeclkc_probe(struct platform_device *pdev)
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static struct regmap *meson_regmap_resource(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +	struct device *dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return ERR_CAST(base);
> +
> +	return devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +}
> +
> +static int meson_common_probe(struct platform_device *pdev, struct regmap *map)
>  {
>  	const struct meson_eeclkc_data *data;
>  	struct device *dev = &pdev->dev;
> -	struct regmap *map;
>  	int ret, i;
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
>  		return -EINVAL;
>  
> -	/* Get the hhi system controller node */
> -	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
> -	if (IS_ERR(map)) {
> -		dev_err(dev,
> -			"failed to get HHI regmap\n");
> -		return PTR_ERR(map);
> -	}
> -
>  	if (data->init_count)
>  		regmap_multi_reg_write(map, data->init_regs, data->init_count);
>  
> @@ -54,3 +66,30 @@ int meson_eeclkc_probe(struct platform_device *pdev)
>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>  					   data->hw_onecell_data);
>  }
> +
> +int meson_eeclkc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *map;
> +
> +	/* Get the hhi system controller node */
> +	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(map)) {
> +		dev_err(dev,
> +			"failed to get HHI regmap\n");
> +		return PTR_ERR(map);
> +	}
> +
> +	return meson_common_probe(pdev, map);
> +}
> +
> +int meson_clkc_probe(struct platform_device *pdev)
> +{
> +	struct regmap *map;
> +
> +	map = meson_regmap_resource(pdev);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	return meson_common_probe(pdev, map);
> +}
> diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
> index 77316207bde1..a2e9ab3a4f6b 100644
> --- a/drivers/clk/meson/meson-eeclk.h
> +++ b/drivers/clk/meson/meson-eeclk.h
> @@ -21,5 +21,6 @@ struct meson_eeclkc_data {
>  };
>  
>  int meson_eeclkc_probe(struct platform_device *pdev);
> +int meson_clkc_probe(struct platform_device *pdev);
>  
>  #endif /* __MESON_CLKC_H */

