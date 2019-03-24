Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F9C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777A2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445915;
	bh=9ha9iBJSrGdfQRy3Kni8G5gidcJyEqeEedHg+5Xl4YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ltcg5N8Th+AORG24mDYnGXsMB3j2CRvWcsFCRglCTorHvm/hFOsyYGvaSf8CevzYc
	 VaU+bCoF3K6BF8qbhg5+il92QptHKQFEQEt3nwDoGPFH/Jj+3YRm1Es3vDTnPZOUtG
	 33Nla2H31S/mqFxyqdxt8qQC/N3GlKURuEWPM6N0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfCXQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:45:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E541B20823;
        Sun, 24 Mar 2019 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445912;
        bh=9ha9iBJSrGdfQRy3Kni8G5gidcJyEqeEedHg+5Xl4YA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xry1T2bbvtbtYni9DHlD7dRIRNvGhX4gV/WG7eKmfKRdfEFpC6UDk615FlLm1+NrI
         ONipWs8ywh6J6/1xz0lSo0YgWqP+EhxjLAZioacKiBzUroIyqf6VMrRkvvuW45NbeA
         rWlxB6G13ETSD+yty33km+WLlRJKA3v0eyy3PDjE=
Date:   Sun, 24 Mar 2019 16:45:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 4/8] iio: adc: stm32-dfsdm: move dma slave config to
 start routine
Message-ID: <20190324164506.595f35e3@archlinux>
In-Reply-To: <1553186849-6261-5-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:25 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Move DMA slave configuration to start routine: depending on regular or
> injected mode is in use, DMA needs to read resp. RDATAR or JDATAR.
> This is precursor patch to introduce injected mode (used for scan).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied, thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 818627f..66e2ea0 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -556,6 +556,11 @@ static void stm32_dfsdm_audio_dma_buffer_done(void *data)
>  static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	struct dma_slave_config config = {
> +		.src_addr = (dma_addr_t)adc->dfsdm->phys_base +
> +			DFSDM_RDATAR(adc->fl_id),
> +		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> +	};
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cookie_t cookie;
>  	int ret;
> @@ -566,6 +571,10 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
>  		adc->buf_sz, adc->buf_sz / 2);
>  
> +	ret = dmaengine_slave_config(adc->dma_chan, &config);
> +	if (ret)
> +		return ret;
> +
>  	/* Prepare a DMA cyclic transaction */
>  	desc = dmaengine_prep_dma_cyclic(adc->dma_chan,
>  					 adc->dma_buf,
> @@ -925,12 +934,6 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
>  static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	struct dma_slave_config config = {
> -		.src_addr = (dma_addr_t)adc->dfsdm->phys_base +
> -			DFSDM_RDATAR(adc->fl_id),
> -		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> -	};
> -	int ret;
>  
>  	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>  	if (!adc->dma_chan)
> @@ -940,23 +943,11 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>  					 DFSDM_DMA_BUFFER_SIZE,
>  					 &adc->dma_buf, GFP_KERNEL);
>  	if (!adc->rx_buf) {
> -		ret = -ENOMEM;
> -		goto err_release;
> +		dma_release_channel(adc->dma_chan);
> +		return -ENOMEM;
>  	}
>  
> -	ret = dmaengine_slave_config(adc->dma_chan, &config);
> -	if (ret)
> -		goto err_free;
> -
>  	return 0;
> -
> -err_free:
> -	dma_free_coherent(adc->dma_chan->device->dev, DFSDM_DMA_BUFFER_SIZE,
> -			  adc->rx_buf, adc->dma_buf);
> -err_release:
> -	dma_release_channel(adc->dma_chan);
> -
> -	return ret;
>  }
>  
>  static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,

