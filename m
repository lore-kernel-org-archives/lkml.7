Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7CC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7B620843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFpfp1W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHNI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:27:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39091 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:27:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so3654366wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gE5kEXYFGYp1NL5CVXFOoRMz6qJmDaHUxtSZp9tvPo=;
        b=XFpfp1W3puWa/3htoMflxHKUuAj7OYdt2KBmq8Qvkhz1yRx5mUcc9kKoRC7hcl+kw2
         Swg5Ybcs6f153Zr3/5NCmVnCmeMvhgvJBZj9+M6S0jK95Ci5q6VSCqHBe8hwkKvHTwOk
         ZEWIOWEN/+ENTAwjEPMmLLYvJv5tcpaVFqzMunbAImN5LndqSbQfw82Q91TqeOsYqPMo
         GaSraPnht5Tk6e8yoWUPi1sOVbSw6DeNqgnQMe/sPZlqY60bbE8qf37lciaeNuPZM7ju
         3AmLP+MxhPVpsrhnLA7eqrrNanxkqQeEMYJn6e/8Fh/QujCfmNy8deCvfNV/JzRR1AHv
         8SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gE5kEXYFGYp1NL5CVXFOoRMz6qJmDaHUxtSZp9tvPo=;
        b=d6OBhNKlHOHgybKDrnBvcaVTlr0o8+5oGC33evr32aoIZhkcNCkYKfaa3lXRbG4WK5
         THfSJcCDtfnRqYP0BAibYaU5hZmBrZaQ7W2cuzw6eI2xnGjeh5kKn9nNf8XXX5nNo3gN
         viuW0Lfzd9UDm6G18w4g4g5Orbqv2miQDrfa2WqUmcOxyQxAEPAPmL8pQyAKItuGIggw
         oS+hIo3gy6sFvms122e6uYxQpuASSUgfX/9fCfwSVkZZ6ZkixvOL64lObUhcR3jbJ070
         oDKMHFBphyh9wqLJgsGFQUqZ9vDIB5SMSxjTHbvhoWe11Kp7yaQMp17H6Rpn+ZLQmdNx
         W6qQ==
X-Gm-Message-State: APjAAAV5qeRolMcIcOUuiijf+y7Gvf+q6YV4Ki71Aoe39b6pjYPQlofl
        jjDUjpQOEyQzW6RsxkLqEcs=
X-Google-Smtp-Source: APXvYqzo4/ZRcpl9c0AcPvftjkr/MqHRgV4IMgbx+0AnvyTG/HDGl5/VL+ijBc9MbaW5tr8xILbI0A==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr7274205wmh.58.1565771249331;
        Wed, 14 Aug 2019 01:27:29 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id c15sm65833981wrb.80.2019.08.14.01.27.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 01:27:27 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [linux-sunxi] [PATCH v5 12/15] ASoC: sun4i-i2s: Add multi-lane functionality
Date:   Wed, 14 Aug 2019 10:27:26 +0200
Message-ID: <3526410.lk6A0UfGIS@jernej-laptop>
In-Reply-To: <20190814060854.26345-13-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-13-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 14. avgust 2019 ob 08:08:51 CEST je codekipper@gmail.com 
napisal(a):
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The i2s block supports multi-lane i2s output however this functionality
> is only possible in earlier SoCs where the pins are exposed and for
> the i2s block used for HDMI audio on the later SoCs.
> 
> To enable this functionality, an optional property has been added to
> the bindings.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a8d98696fe7c..a020c3b372a8 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -23,7 +23,7 @@
> 
>  #define SUN4I_I2S_CTRL_REG		0x00
>  #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
> -#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + 
(sdo))
> +#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) 
<< 8)
>  #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
>  #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
>  #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
> @@ -614,6 +614,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream
> *substream, struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>  	int sr, wss, channels;
>  	u32 width;
> +	int lines;
> 
>  	channels = params_channels(params);
>  	if (channels != 2) {
> @@ -622,6 +623,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream
> *substream, return -EINVAL;
>  	}
> 
> +	lines = (channels + 1) / 2;
> +
> +	/* Enable the required output lines */
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> +			   SUN4I_I2S_CTRL_SDO_EN(lines));

As Maxime said before, this doesn't work for TDM. Maybe we can skip this for 
now, until we agree on method how to describe channel allocation?

> +
>  	if (i2s->variant->has_chcfg) {
>  		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
>  				   
SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> @@ -1389,9 +1397,10 @@ static int sun4i_i2s_init_regmap_fields(struct device
> *dev, static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_i2s *i2s;
> +	struct snd_soc_dai_driver *soc_dai;
>  	struct resource *res;
>  	void __iomem *regs;
> -	int irq, ret;
> +	int irq, ret, val;
> 
>  	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
>  	if (!i2s)
> @@ -1456,6 +1465,19 @@ static int sun4i_i2s_probe(struct platform_device
> *pdev) i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> i2s->capture_dma_data.maxburst = 8;
> 
> +	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> +			       sizeof(*soc_dai), GFP_KERNEL);
> +	if (!soc_dai) {
> +		ret = -ENOMEM;
> +		goto err_pm_disable;
> +	}
> +
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "allwinner,playback-channels", 
&val)) {
> +		if (val >= 2 && val <= 8)
> +			soc_dai->playback.channels_max = val;
> +	}
> +

Rather than inventing new DT properties, I would rather have multiple 
snd_soc_dai_driver structures, depending on capabilities of that particular 
I2S block. That way we avoid some boilerplate code as can be seen here and 
it's IMO more transparent.

In this case, I would make another snd_soc_dai_driver struct for H3, which has 
channel_max property set to 8 and from patch 14, additional supported formats.

Best regards,
Jernej

>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev)) {
>  		ret = sun4i_i2s_runtime_resume(&pdev->dev);
> @@ -1465,7 +1487,7 @@ static int sun4i_i2s_probe(struct platform_device
> *pdev)
> 
>  	ret = devm_snd_soc_register_component(&pdev->dev,
>  					      
&sun4i_i2s_component,
> -					      &sun4i_i2s_dai, 
1);
> +					      soc_dai, 1);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not register DAI\n");
>  		goto err_suspend;




