Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF5B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W8Mbcm+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfIRMjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:39:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36248 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731213AbfIRMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:39:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id t3so2429426wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rkEDxPdEl9Iaqh2ExNLmboEh+YYMG69tOVa/FPgt874=;
        b=W8Mbcm+q/BLzyZpONFpQYn+Lvx9aEqdFtcLKiPU3LrB+cD16pcfciX7kd/0bjmQI33
         5Wnj9waO5UMe8YyHPeY3bxN1JMtH5zKx5jqBEZzVGkugyVjN24ySUuRTyQMfQ2OBlAS+
         DhYTG2Bgbp2JD423EMJCK/rsCLt5YxxyXR2mFOdSjEHnhzqtal9K1uVtPdxILjHr1vEG
         rEwnDTyQKvV64frd8xWiSGcTrBk7UN9Oo65DRhzTVP4ADWqfF7EY6NZnC0RJh0i2CYMd
         WukKgVwV41EX1LndYlaAkCBG5DuwoDyKJ069p0ukH7KPsz6F9meh1EwvuNDIeFmqf6Dt
         tUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rkEDxPdEl9Iaqh2ExNLmboEh+YYMG69tOVa/FPgt874=;
        b=CbqWKM4w49d+GjeffL4oEmsaNC1QBfDS78y9omV1+9WXdEPyuCTuoofsY+OHVDDwgv
         wDMjIVfGpbrJWC4w+qzKhj3TJ+x2VVxq0nMuEm8EyYN05LURgAxp6ajAxBOwDJA4SNxi
         sqcto80IeZ2CvddTVKce913FcuPIGNrz5HtXSKz6Y+VXy1TKA4u7IyctSU5i+CpFeJrg
         DQ8C43pvlTJh0jzU7S8iyZYv/2/0LjH0MFI5yNkn9uvyyWZlHCLnveDxN/nE0fpEBZce
         4n7tyaszHpoImXky8dqlle2IgLXQg39U/xkrvJTUG+QiH6YoBcbzzn8TbxV5gqnYdNxE
         6Ygw==
X-Gm-Message-State: APjAAAWidlftgmF9OHL5h2as6pv5vXdIodDtaevoA6zsmHqO2EQQZ+Rd
        5oz9VkB2bmB54li3XfhIJSrcZDusMsc+3w==
X-Google-Smtp-Source: APXvYqzNwqgKrZgEYWkYaBUQgGjKH6qJDUE1rezTzdXX535NLvUqmDDg21g6T9qRUVUwkXDf2nTd8g==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr2824736wmf.63.1568810379765;
        Wed, 18 Sep 2019 05:39:39 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v2sm4749902wmf.18.2019.09.18.05.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 05:39:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] reset: add support for the Meson-A1 SoC Reset
 Controller
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1568808749-1196-1-git-send-email-xingyu.chen@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ab6b5ef5-f251-3122-ad5b-558c65fe319e@baylibre.com>
Date:   Wed, 18 Sep 2019 14:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568808749-1196-1-git-send-email-xingyu.chen@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2019 14:12, Xingyu Chen wrote:
> The number of RESET registers and offset of RESET_LEVEL register for
> Meson-A1 are different from previous SoCs, In order to describe these
> differences, we introduce the struct meson_reset_param.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/reset/reset-meson.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 5242e06..d9541c1 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -64,12 +64,16 @@
>  #include <linux/types.h>
>  #include <linux/of_device.h>
>  
> -#define REG_COUNT	8
>  #define BITS_PER_REG	32
> -#define LEVEL_OFFSET	0x7c
> +
> +struct meson_reset_param {
> +	int reg_count;
> +	int level_offset;
> +};
>  
>  struct meson_reset {
>  	void __iomem *reg_base;
> +	const struct meson_reset_param *param;
>  	struct reset_controller_dev rcdev;
>  	spinlock_t lock;
>  };
> @@ -95,10 +99,12 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
>  		container_of(rcdev, struct meson_reset, rcdev);
>  	unsigned int bank = id / BITS_PER_REG;
>  	unsigned int offset = id % BITS_PER_REG;
> -	void __iomem *reg_addr = data->reg_base + LEVEL_OFFSET + (bank << 2);
> +	void __iomem *reg_addr;
>  	unsigned long flags;
>  	u32 reg;
>  
> +	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
> +
>  	spin_lock_irqsave(&data->lock, flags);
>  
>  	reg = readl(reg_addr);
> @@ -130,10 +136,21 @@ static const struct reset_control_ops meson_reset_ops = {
>  	.deassert	= meson_reset_deassert,
>  };
>  
> +static const struct meson_reset_param meson8b_param = {
> +	.reg_count	= 8,
> +	.level_offset	= 0x7c,
> +};
> +
> +static const struct meson_reset_param meson_a1_param = {
> +	.reg_count	= 3,
> +	.level_offset	= 0x40,
> +};
> +
>  static const struct of_device_id meson_reset_dt_ids[] = {
> -	 { .compatible = "amlogic,meson8b-reset" },
> -	 { .compatible = "amlogic,meson-gxbb-reset" },
> -	 { .compatible = "amlogic,meson-axg-reset" },
> +	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
> +	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
> +	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
> +	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>  	 { /* sentinel */ },
>  };
>  
> @@ -151,12 +168,16 @@ static int meson_reset_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->reg_base))
>  		return PTR_ERR(data->reg_base);
>  
> +	data->param = of_device_get_match_data(&pdev->dev);
> +	if (!data->param)
> +		return -ENODEV;
> +
>  	platform_set_drvdata(pdev, data);
>  
>  	spin_lock_init(&data->lock);
>  
>  	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = REG_COUNT * BITS_PER_REG;
> +	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
>  	data->rcdev.ops = &meson_reset_ops;
>  	data->rcdev.of_node = pdev->dev.of_node;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
