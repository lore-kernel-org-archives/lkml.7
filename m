Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE3C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98520843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/8QS2C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfHNI2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:28:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfHNI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:28:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so110246026wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rV0Mz1LNQzvwfE9rFCVwbU0EStrdYW7TBpsWP1IW94k=;
        b=R/8QS2C6ntQ7Vw97hDgxsv6vJAns05MqnUI4UFuGPSRmCoJ05TqEABqcMIfkWG1exU
         cp9plLXm78nimHu8lF0h3doDNzdGaPT60sfj5GtdtvHFBq539TXYdQUPj/pL4FsaPMIQ
         Jdlg8ctiByw/dcXuxZYE0eaiBVWPn4SdzlKczGPUmgANztrd9Ny+LuBnPeWZDVNbEHJj
         P2vw65H576GGAGZFgjJT1UyCudVW9XyINkzdviJy1ORXt0ZfRBG/86HVLYd5pvtEj+Us
         jmwZ69XopX27pRjlCz6c4BBw1P4V5pHQsJ0crfa+LLUKn1x7+jLuYZjlMwO3I7kB2HiE
         5CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rV0Mz1LNQzvwfE9rFCVwbU0EStrdYW7TBpsWP1IW94k=;
        b=Gjsid65bsgdnaDR0giUptWgmzzurGcFGEUJqq/h3g3kuvLLh3OXi44Rjz3nWmbP0u8
         Ybs9NLeXil3O0cLDN2ATQB4nmlKSQr99w2HzjXa/fMXAmAlxr6otYPKbt77CpP54ZAKS
         YBnWpSjhgKh+hVa7pTdg3RPfsCqCrueKmw5pa1GMukqIiRXp2XTsjFTTU0EMGXVtXcxG
         BCJimu1G9ARnSnR/LzUtGXtJimU3YHByRn9bHaIGXNdkszrHORgI7VK6q7ZKIrgTvFsb
         ORhDs/LVu8lvfmpJoFk22fAxkr+BRaIzHdcDv6PAcAmRZ4UalP4gbQvf81lmQN04AE7U
         V7hg==
X-Gm-Message-State: APjAAAWt/XRBaJ6PlmB1b9plukvllOCQqnNUqI8FyMa/aTS2FLYbOow9
        lX2y2ZZma5DMaIcNFycwaFM=
X-Google-Smtp-Source: APXvYqzGZTVcpusGFYgd50gndARlz4pVBXWu3ACZK/HgjK/hWUAFe/i91auTmLJNsZQhT/YeqHrPGQ==
X-Received: by 2002:a05:6000:1041:: with SMTP id c1mr18582439wrx.99.1565771321208;
        Wed, 14 Aug 2019 01:28:41 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id b26sm4034990wmj.14.2019.08.14.01.28.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 01:28:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [linux-sunxi] [PATCH v5 14/15] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Date:   Wed, 14 Aug 2019 10:28:39 +0200
Message-ID: <4297791.2mJM636zur@jernej-laptop>
In-Reply-To: <20190814060854.26345-15-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-15-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 14. avgust 2019 ob 08:08:53 CEST je codekipper@gmail.com 
napisal(a):
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample for the earlier SoCs.
> 
> Newer SoCs can also handle 32bit samples.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a71969167053..d3c8789f70bb 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -690,6 +690,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream
> *substream, case 16:
>  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>  		break;
> +	case 20:
> +	case 24:
> +	case 32:

params_physical_width() returns 32 also for 20 and 24-bit formats, so drop 20 
and 24.

Best regards,
Jernej

> +		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;
>  	default:
>  		dev_err(dai->dev, "Unsupported physical sample width: 
%d\n",
>  			params_physical_width(params));
> @@ -1015,6 +1020,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai
> *dai) return 0;
>  }
> 
> +#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
> +			 SNDRV_PCM_FMTBIT_S20_LE | \
> +			 SNDRV_PCM_FMTBIT_S24_LE)
> +
> +#define SUN8I_FORMATS	(SUN4I_FORMATS | \
> +			 SNDRV_PCM_FMTBIT_S32_LE)
> +
>  static struct snd_soc_dai_driver sun4i_i2s_dai = {
>  	.probe = sun4i_i2s_dai_probe,
>  	.capture = {
> @@ -1022,14 +1034,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
>  		.channels_min = 2,
>  		.channels_max = 2,
>  		.rates = SNDRV_PCM_RATE_8000_192000,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +		.formats = SUN4I_FORMATS,
>  	},
>  	.playback = {
>  		.stream_name = "Playback",
>  		.channels_min = 2,
>  		.channels_max = 2,
>  		.rates = SNDRV_PCM_RATE_8000_192000,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +		.formats = SUN4I_FORMATS,
>  	},
>  	.ops = &sun4i_i2s_dai_ops,
>  	.symmetric_rates = 1,
> @@ -1505,6 +1517,11 @@ static int sun4i_i2s_probe(struct platform_device
> *pdev) goto err_pm_disable;
>  	}
> 
> +	if (i2s->variant->has_fmt_set_lrck_period) {
> +		soc_dai->playback.formats = SUN8I_FORMATS;
> +		soc_dai->capture.formats = SUN8I_FORMATS;
> +	}
> +
>  	if (!of_property_read_u32(pdev->dev.of_node,
>  				  "allwinner,playback-channels", 
&val)) {
>  		if (val >= 2 && val <= 8)




