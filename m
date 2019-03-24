Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E757C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C52C2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553447571;
	bh=wxEVUIOVR28lMtF1wwMqBmSMZBwZ6mSS/LE474j3grU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ogTEewDJA6Q3aq69QwipJPP6AYq4e5Rx13+5VsNwrTIZSByxB1QFk91gelV/yhrBc
	 4QTbui+Husskane67CpPZMg6Nq5pSs3YBcfePD27CnVhTyMfryV76Ks3Nk7lzl1nJj
	 acdarrP1IHFLE0ngQs+X+8i4mveIWj/ozM++AZmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfCXRMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfCXRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:12:49 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A502087F;
        Sun, 24 Mar 2019 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553447568;
        bh=wxEVUIOVR28lMtF1wwMqBmSMZBwZ6mSS/LE474j3grU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ryai+PKxZG2ImA5XPZ54Y/sgGYy3WimplJ+XhO+MfZJT4yEsTSlSrKODPHU2mlj9k
         pMTOwJB14V7Sgn/7uJlAoQkaWUcRD0gbdb1YZghRtIzSPR/E1NoTAq9GKuNmo6BR5d
         V4QffoFAFEjaL9gkU+2/amojP8wOTvdDjm26F28c=
Date:   Sun, 24 Mar 2019 17:12:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 8/8] iio: adc: stm32-dfsdm: claim direct mode for raw
 read and settings
Message-ID: <20190324171242.67d7a486@archlinux>
In-Reply-To: <1553186849-6261-9-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-9-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:29 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Claim direct mode to ensure no buffer mode is in use for:
> - single conversion
> - sample rate setting (must be set when filter isn't enabled).
> - oversampling ratio (must be set when filter isn't enabled).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 51688eb..ca42946 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1039,16 +1039,23 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  		ret = stm32_dfsdm_set_osrs(fl, 0, val);
>  		if (!ret)
>  			adc->oversamp = val;
> -
> +		iio_device_release_direct_mode(indio_dev);
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (!val)
>  			return -EINVAL;
>  
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
>  		switch (ch->src) {
>  		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL:
>  			spi_freq = adc->dfsdm->spi_master_freq;
> @@ -1070,9 +1077,11 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"Not able to find parameter that match!\n");
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
>  		}
>  		adc->sample_freq = val;
> +		iio_device_release_direct_mode(indio_dev);
>  
>  		return 0;
>  	}
> @@ -1089,11 +1098,15 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  		ret = iio_hw_consumer_enable(adc->hwc);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev,
>  				"%s: IIO enable failed (channel %d)\n",
>  				__func__, chan->channel);
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
>  		}
>  		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
> @@ -1102,8 +1115,10 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  			dev_err(&indio_dev->dev,
>  				"%s: Conversion failed (channel %d)\n",
>  				__func__, chan->channel);
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
>  		}
> +		iio_device_release_direct_mode(indio_dev);
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

