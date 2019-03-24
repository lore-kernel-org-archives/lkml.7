Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC3DC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08F22087E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445863;
	bh=DIPove7fmCZCT/Kd2tN6L8r79GQfswXoABLnBzyOU2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Tu6ohHULZT470Zd3l2sFuCao7knVnP9w39rXGI3jHBavPW8zVFlcjjgfhEQZg8lcY
	 +Q6eHO8RrNtdZOtI8fte1uz5rdtjmdqx8fQ1xsajtyAuRfCckeBkSrUjKWKEN4Wm9t
	 dIggNsq+NkvyeU4RDsj2WBYxuc8jOlJvoa2QL0ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfCXQoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfCXQoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:44:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D68720823;
        Sun, 24 Mar 2019 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445860;
        bh=DIPove7fmCZCT/Kd2tN6L8r79GQfswXoABLnBzyOU2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vvtaW472WkVrOclGfD4iF7YQJoL8ZGPgQ4qDdYBWccGpHt+rV171S2nRtTfbZCtwp
         VHYAiZ472ZcR6ee0OUA/Zg2Bi5GJiZDfiEs88L129PCj9/SE/VAoTvgwcuuemBdnJ9
         DmcfmZPGx9f18InGzethSfpcPuG7iO1t97Hwt08o=
Date:   Sun, 24 Mar 2019 16:44:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 3/8] iio: adc: stm32-dfsdm: move dma enable from
 start_conv() to start_dma()
Message-ID: <20190324164414.03f4bb01@archlinux>
In-Reply-To: <1553186849-6261-4-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:24 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Move DMA enable (e.g. set RDMAEN bit) away from start_conv() that is used
> for both buffer and single conversions. Thus, single conv rely on
> interrupt, not dma.
> Note: take care to prepare all DMA stuff and set RDMAEN before starting
> filter (can be set only when DFEN=0).
> 
> This is precursor patch to ease support of triggered buffer mode.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 77 +++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 8690672..818627f 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -429,12 +429,10 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>  }
>  
>  static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
> -				  const struct iio_chan_spec *chan,
> -				  bool dma)
> +				  const struct iio_chan_spec *chan)
>  {
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	int ret;
> -	unsigned int dma_en = 0;
>  
>  	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
>  	if (ret < 0)
> @@ -444,25 +442,12 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
>  	if (ret < 0)
>  		goto stop_channels;
>  
> -	if (dma) {
> -		/* Enable DMA transfer*/
> -		dma_en =  DFSDM_CR1_RDMAEN(1);
> -	}
> -	/* Enable DMA transfer*/
> -	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -				 DFSDM_CR1_RDMAEN_MASK, dma_en);
> -	if (ret < 0)
> -		goto filter_unconfigure;
> -
>  	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
>  	if (ret < 0)
> -		goto stop_dma;
> +		goto filter_unconfigure;
>  
>  	return 0;
>  
> -stop_dma:
> -	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -			   DFSDM_CR1_RDMAEN_MASK, 0);
>  filter_unconfigure:
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
>  			   DFSDM_CR1_CFG_MASK, 0);
> @@ -479,10 +464,6 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
>  
>  	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
>  
> -	/* Clean conversion options */
> -	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
> -			   DFSDM_CR1_RDMAEN_MASK, 0);
> -
>  	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
>  			   DFSDM_CR1_CFG_MASK, 0);
>  
> @@ -599,15 +580,36 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
> -	if (ret) {
> -		dmaengine_terminate_all(adc->dma_chan);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_stop_dma;
>  
>  	/* Issue pending DMA requests */
>  	dma_async_issue_pending(adc->dma_chan);
>  
> +	/* Enable DMA transfer*/
> +	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
> +				 DFSDM_CR1_RDMAEN_MASK, DFSDM_CR1_RDMAEN_MASK);
> +	if (ret < 0)
> +		goto err_stop_dma;
> +
>  	return 0;
> +
> +err_stop_dma:
> +	dmaengine_terminate_all(adc->dma_chan);
> +
> +	return ret;
> +}
> +
> +static void stm32_dfsdm_adc_dma_stop(struct iio_dev *indio_dev)
> +{
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +
> +	if (!adc->dma_chan)
> +		return;
> +
> +	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
> +			   DFSDM_CR1_RDMAEN_MASK, 0);
> +	dmaengine_terminate_all(adc->dma_chan);
>  }
>  
>  static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
> @@ -623,24 +625,22 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = stm32_dfsdm_start_conv(adc, chan, true);
> +	ret = stm32_dfsdm_adc_dma_start(indio_dev);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "Can't start conversion\n");
> +		dev_err(&indio_dev->dev, "Can't start DMA\n");
>  		goto stop_dfsdm;
>  	}
>  
> -	if (adc->dma_chan) {
> -		ret = stm32_dfsdm_adc_dma_start(indio_dev);
> -		if (ret) {
> -			dev_err(&indio_dev->dev, "Can't start DMA\n");
> -			goto err_stop_conv;
> -		}
> +	ret = stm32_dfsdm_start_conv(adc, chan);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't start conversion\n");
> +		goto err_stop_dma;
>  	}
>  
>  	return 0;
>  
> -err_stop_conv:
> -	stm32_dfsdm_stop_conv(adc, chan);
> +err_stop_dma:
> +	stm32_dfsdm_adc_dma_stop(indio_dev);
>  stop_dfsdm:
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>  
> @@ -652,11 +652,10 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	const struct iio_chan_spec *chan = &indio_dev->channels[0];
>  
> -	if (adc->dma_chan)
> -		dmaengine_terminate_all(adc->dma_chan);
> -
>  	stm32_dfsdm_stop_conv(adc, chan);
>  
> +	stm32_dfsdm_adc_dma_stop(indio_dev);
> +
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>  
>  	return 0;
> @@ -736,7 +735,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		goto stop_dfsdm;
>  
> -	ret = stm32_dfsdm_start_conv(adc, chan, false);
> +	ret = stm32_dfsdm_start_conv(adc, chan);
>  	if (ret < 0) {
>  		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>  				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));

