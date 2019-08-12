Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43602085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXx+Xx03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfHLKi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:38:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38842 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfHLKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:38:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so104111263wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7b3n5NKIs0QO9tGBF6PQ+renF/Om9ojGaBkhFRxGbp8=;
        b=jXx+Xx03meTbr4eyHv+1urOuHrqsRH8Ttb2Gam7K/oWIPgI0k4WTcOX4plmR4pjeZe
         Zvo5LxdvA1fVOV/hxNP1sFgTyVTszT/eGLj8mzWU9REP+aXB7jU8h7vZT6frlBYjx5Kg
         C+dj2i+1qa65PYYh1dge3Zr8CR83oDUKZLLNiZW6b3zICAc3naqsRpDoHoaV9zW2Ru4n
         TFzoV9fvqDEg94aUVtp6A5Gb0TmqYLRYvA1PT+zm50enDW2WWDO3rB+pgDEkRd4ZVg9m
         HifZBhwvOYblYQL/HkCaC1FJh9KD9vdFHMX2LcieETYnFe9U6PCjff+h31bY2ICOlMgu
         k+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7b3n5NKIs0QO9tGBF6PQ+renF/Om9ojGaBkhFRxGbp8=;
        b=dbUVDR7x2uZaAC570AGCboBbAq1dyNcC4DCE1FE/vOWddxuv4W8GnKHEhWWhyR+yt8
         wCHDvR6I8IOw8As7dCKB+NqbTNOaqsGEQIlBjSJZtm4caNhxposK43LvLrdV8F3AC2Dz
         AASQMgBd3VKU2qniDfHXI2FFl1Jwy20+HR1/T/+ebQJr7c52s2i3T7AVEXtoM+iHZuBN
         TaXA3gks2KSNDmo2/k/GL6cdQHurs+vMMFijBs1AYg1AbldKUyDD0BJTBAcN30QN2TQj
         kSyaf7XzCW6Ymjrj+RNrpFEkP0pEs8zyWaQLmFq9HKNjqTMO1Sgeb20fZGNn6owNLcx6
         l3Gg==
X-Gm-Message-State: APjAAAULqtQ2+m69EUHJSDQmwS4cDiyO2tGB9Z+/J+uL8Dij12XH1uTv
        cKUw728jhztbYlyyy9vY2dsxvQ==
X-Google-Smtp-Source: APXvYqz8Yya7OU/9cDk/irjRRQ9TX/KGTlrvG5IiZILpY7qG1UeqpwhH8dz5KgFj/+JLHxl+S6+DVw==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr12305515wrm.297.1565606335239;
        Mon, 12 Aug 2019 03:38:55 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id 91sm204353708wrp.3.2019.08.12.03.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:38:54 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:38:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Add support for requesting the supply
 clocks
Message-ID: <20190812103853.GM26727@dell>
References: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
 <20190806151321.31137-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806151321.31137-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2019, Charles Keepax wrote:

> Add the ability to get the clock for each clock input pin of the chip
> and enable MCLK2 since that is expected to be a permanently enabled
> 32kHz clock.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c       | 24 +++++++++++++++++++++++-
>  include/linux/mfd/madera/core.h | 11 +++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index 29540cbf75934..8d7ab1c7bf9f7 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -428,6 +428,7 @@ static void madera_set_micbias_info(struct madera *madera)
>  
>  int madera_dev_init(struct madera *madera)
>  {
> +	static const char * const mclk_name[] = { "mclk1", "mclk2", "mclk3" };
>  	struct device *dev = madera->dev;
>  	unsigned int hwid;
>  	int (*patch_fn)(struct madera *) = NULL;
> @@ -450,6 +451,17 @@ int madera_dev_init(struct madera *madera)
>  		       sizeof(madera->pdata));
>  	}
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(madera->mclk) != ARRAY_SIZE(mclk_name));

Not sure how this could happen.  Surely we don't need it.

> +	for (i = 0; i < ARRAY_SIZE(madera->mclk); i++) {
> +		madera->mclk[i] = devm_clk_get_optional(madera->dev,
> +							mclk_name[i]);
> +		if (IS_ERR(madera->mclk[i])) {
> +			dev_warn(madera->dev, "Failed to get %s: %ld\n",
> +				 mclk_name[i], PTR_ERR(madera->mclk[i]));

Do we even want to warn on the non-acquisition of an optional clock?

Especially with a message that looks like something actually failed.

> +			madera->mclk[i] = NULL;
> +		}
> +	}
> +
>  	ret = madera_get_reset_gpio(madera);
>  	if (ret)
>  		return ret;
> @@ -660,13 +672,19 @@ int madera_dev_init(struct madera *madera)
>  	}
>  
>  	/* Init 32k clock sourced from MCLK2 */
> +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2]);
> +	if (ret != 0) {
> +		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
> +		goto err_reset;
> +	}

What happened to this being optional?

>  	ret = regmap_update_bits(madera->regmap,
>  			MADERA_CLOCK_32K_1,
>  			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
>  			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
>  	if (ret) {
>  		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
> -		goto err_reset;
> +		goto err_clock;
>  	}
>  
>  	pm_runtime_set_active(madera->dev);
> @@ -687,6 +705,8 @@ int madera_dev_init(struct madera *madera)
>  
>  err_pm_runtime:
>  	pm_runtime_disable(madera->dev);
> +err_clock:
> +	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);

Where are the other clocks consumed?

>  err_reset:
>  	madera_enable_hard_reset(madera);
>  	regulator_disable(madera->dcvdd);
> @@ -713,6 +733,8 @@ int madera_dev_exit(struct madera *madera)
>  	 */
>  	pm_runtime_disable(madera->dev);
>  
> +	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);
> +
>  	regulator_disable(madera->dcvdd);
>  	regulator_put(madera->dcvdd);
>  
> diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
> index 7ffa696cce7ca..2b6c83fe221dc 100644
> --- a/include/linux/mfd/madera/core.h
> +++ b/include/linux/mfd/madera/core.h
> @@ -8,6 +8,7 @@
>  #ifndef MADERA_CORE_H
>  #define MADERA_CORE_H
>  
> +#include <linux/clk.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/madera/pdata.h>
> @@ -29,6 +30,13 @@ enum madera_type {
>  	CS42L92 = 9,
>  };
>  
> +enum {
> +	MADERA_MCLK1,
> +	MADERA_MCLK2,
> +	MADERA_MCLK3,
> +	MADERA_NUM_MCLK
> +};
> +
>  #define MADERA_MAX_CORE_SUPPLIES	2
>  #define MADERA_MAX_GPIOS		40
>  
> @@ -155,6 +163,7 @@ struct snd_soc_dapm_context;
>   * @irq_dev:		the irqchip child driver device
>   * @irq_data:		pointer to irqchip data for the child irqchip driver
>   * @irq:		host irq number from SPI or I2C configuration
> + * @mclk:		pointers to clock supplies
>   * @out_clamp:		indicates output clamp state for each analogue output
>   * @out_shorted:	indicates short circuit state for each analogue output
>   * @hp_ena:		bitflags of enable state for the headphone outputs
> @@ -184,6 +193,8 @@ struct madera {
>  	struct regmap_irq_chip_data *irq_data;
>  	int irq;
>  
> +	struct clk *mclk[MADERA_NUM_MCLK];
> +
>  	unsigned int num_micbias;
>  	unsigned int num_childbias[MADERA_MAX_MICBIAS];
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
