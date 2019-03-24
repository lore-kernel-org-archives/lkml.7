Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A363C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B0C2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445808;
	bh=Cb/0edEa0zDiHNSpD4LXCfUVokL9vtAUR86ZqD3RCqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eJCi21tQ1kzRTXYNEIuSdtkrzx3hETmAJZyrerWJugg07jx18iaBDRdUrpCxwEgJL
	 zMzRD7M57ltvE9K1ZtcHvIx2cJRuLO5hRj4+lBLSJ0Wcjy0POQeUD48x9RIfz2vnZd
	 V9dfxAVK6Mnrc5EjCzqUPu1THwPn4XJohIavJcks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfCXQn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfCXQn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:43:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B3E20823;
        Sun, 24 Mar 2019 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445805;
        bh=Cb/0edEa0zDiHNSpD4LXCfUVokL9vtAUR86ZqD3RCqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xQqF7ccOYV8CjzQYaokXu9LhrCPzhr1ONPukktecV/7mb3SHMtGSJCy42/iSF/2+j
         3n4o0vG7E3vl4FhRCg6bsBvMD+2C+ZDDO1MsGvK8gHGkM6znkIlU+DkDtNxBesbL1j
         Q9Aj4BJqF7/6PvrVbjaB4tqE1f1oPTf9tGfJLgAs=
Date:   Sun, 24 Mar 2019 16:43:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 2/8] iio: adc: stm32-dfsdm: continuous mode depends
 on current mode
Message-ID: <20190324164319.28cf5f57@archlinux>
In-Reply-To: <1553186849-6261-3-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:23 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> DFSDM regular continuous mode usage depends on current mode (not DMA):
> - for single conversion, RCONT doesn't need to be set.
> - for buffer mode, RCONT has to be set (e.g. INDIO_BUFFER_SOFTWARE
>   used by audio currently).
> This is related to filter configuration, move it to relevant routine.
> 
> This is precursor patch to ease support of triggered buffer mode.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied,

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 54 +++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index fcd4a1c..8690672 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -38,6 +38,10 @@
>  #define DFSDM_MAX_RES BIT(31)
>  #define DFSDM_DATA_RES BIT(23)
>  
> +/* Filter configuration */
> +#define DFSDM_CR1_CFG_MASK (DFSDM_CR1_RCH_MASK | DFSDM_CR1_RCONT_MASK | \
> +			    DFSDM_CR1_RSYNC_MASK)
> +
>  enum sd_converter_type {
>  	DFSDM_AUDIO,
>  	DFSDM_IIO,
> @@ -262,11 +266,13 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
>  			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
>  }
>  
> -static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
> +static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>  					unsigned int fl_id, unsigned int ch_id)
>  {
> -	struct regmap *regmap = dfsdm->regmap;
> -	struct stm32_dfsdm_filter *fl = &dfsdm->fl_list[fl_id];
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct regmap *regmap = adc->dfsdm->regmap;
> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
> +	u32 cr1;
>  	int ret;
>  
>  	/* Average integrator oversampling */
> @@ -287,14 +293,16 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
>  		return ret;
>  
>  	/* No scan mode supported for the moment */
> -	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RCH_MASK,
> -				 DFSDM_CR1_RCH(ch_id));
> -	if (ret)
> -		return ret;
> +	cr1 = DFSDM_CR1_RCH(ch_id);
> +
> +	/* Continuous conversions triggered by SPI clock in buffer mode */
> +	if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> +		cr1 |= DFSDM_CR1_RCONT(1);
>  
> -	return regmap_update_bits(regmap, DFSDM_CR1(fl_id),
> -				  DFSDM_CR1_RSYNC_MASK,
> -				  DFSDM_CR1_RSYNC(fl->sync_mode));
> +	cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
> +
> +	return regmap_update_bits(regmap, DFSDM_CR1(fl_id), DFSDM_CR1_CFG_MASK,
> +				  cr1);
>  }
>  
>  static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
> @@ -426,47 +434,39 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
>  {
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	int ret;
> -	unsigned int dma_en = 0, cont_en = 0;
> +	unsigned int dma_en = 0;
>  
>  	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = stm32_dfsdm_filter_configure(adc->dfsdm, adc->fl_id,
> -					   chan->channel);
> +	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, chan->channel);
>  	if (ret < 0)
>  		goto stop_channels;
>  
>  	if (dma) {
>  		/* Enable DMA transfer*/
>  		dma_en =  DFSDM_CR1_RDMAEN(1);
> -		/* Enable conversion triggered by SPI clock*/
> -		cont_en = DFSDM_CR1_RCONT(1);
>  	}
>  	/* Enable DMA transfer*/
>  	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
>  				 DFSDM_CR1_RDMAEN_MASK, dma_en);
>  	if (ret < 0)
> -		goto stop_channels;
> -
> -	/* Enable conversion triggered by SPI clock*/
> -	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -				 DFSDM_CR1_RCONT_MASK, cont_en);
> -	if (ret < 0)
> -		goto stop_channels;
> +		goto filter_unconfigure;
>  
>  	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
>  	if (ret < 0)
> -		goto stop_channels;
> +		goto stop_dma;
>  
>  	return 0;
>  
> -stop_channels:
> +stop_dma:
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
>  			   DFSDM_CR1_RDMAEN_MASK, 0);
> -
> +filter_unconfigure:
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -			   DFSDM_CR1_RCONT_MASK, 0);
> +			   DFSDM_CR1_CFG_MASK, 0);
> +stop_channels:
>  	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
>  
>  	return ret;
> @@ -484,7 +484,7 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
>  			   DFSDM_CR1_RDMAEN_MASK, 0);
>  
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -			   DFSDM_CR1_RCONT_MASK, 0);
> +			   DFSDM_CR1_CFG_MASK, 0);
>  
>  	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
>  }

