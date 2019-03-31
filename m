Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE0C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F25A21773
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554025572;
	bh=mvatAZ8EMowd44cb0Yyla/0+OwnoQ3rNaVBn3xAnz4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fBJJja0ui8jjToo9gVzBpSf5envAHjDUNnQ3C99NKSr18aJPFPtAsKk+tyxThKM3t
	 F5bGWm6eXIyww0ywY6JaRksCufeum6HnsMRCEkdxJ2Y3qLsKoja7++wMmNSDzSAX+l
	 sstTqpP+z7vMKrceC8uFyQMxvE4eA1qxvS8s2URU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfCaJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfCaJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:46:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6AE20850;
        Sun, 31 Mar 2019 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554025569;
        bh=mvatAZ8EMowd44cb0Yyla/0+OwnoQ3rNaVBn3xAnz4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wbu3ASz6Loab3F9fmV43p9D6pUTLuvgNJ/qs4QrwEiAS1luQCMlC4O46HG7gxLVSa
         ElGtUTUSQu9DAtfrTii8e2MU5pvtrjB7Drbptmoc48ke2U6TiD6htUQAd6O4y9J0rK
         CzCmEig2wHjUKH6tgQm4fLEKsL3JrTj4bX+cRvFA=
Date:   Sun, 31 Mar 2019 10:46:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: improve sampling frequency
 accuracy
Message-ID: <20190331104602.209cb9a0@archlinux>
In-Reply-To: <1553523841-16315-1-git-send-email-fabrice.gasnier@st.com>
References: <1553523841-16315-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 15:24:01 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> The sample frequency is driven using the oversampling ratio depending
> on the SPI bus frequency.
> Currently, oversampling ratio is computed by an entire division:
> - spi_freq / sample_freq. This may result in inaccurate value.
> Using DIV_ROUND_CLOSEST improves resulting sample frequency, which is
> useful for audio that requests fixed rates (such as: 8, 16 or 32 kHz).
> BTW, introduce new routine to re-factor sample frequency setting, and
> move frequency accuracy message from warning to debug level.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Would have preferred this as two patches as it would have made review easier
by making it clear what the functional change is.

Still that is mostly me just wanting an easy life ;)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 56 +++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 531ca7e..051561c 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -558,13 +558,38 @@ static ssize_t dfsdm_adc_audio_get_spiclk(struct iio_dev *indio_dev,
>  	return snprintf(buf, PAGE_SIZE, "%d\n", adc->spi_freq);
>  }
>  
> +static int dfsdm_adc_set_samp_freq(struct iio_dev *indio_dev,
> +				   unsigned int sample_freq,
> +				   unsigned int spi_freq)
> +{
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> +	unsigned int oversamp;
> +	int ret;
> +
> +	oversamp = DIV_ROUND_CLOSEST(spi_freq, sample_freq);
> +	if (spi_freq % sample_freq)
> +		dev_dbg(&indio_dev->dev,
> +			"Rate not accurate. requested (%u), actual (%u)\n",
> +			sample_freq, spi_freq / oversamp);
> +
> +	ret = stm32_dfsdm_set_osrs(fl, 0, oversamp);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "No filter parameters that match!\n");
> +		return ret;
> +	}
> +	adc->sample_freq = spi_freq / oversamp;
> +	adc->oversamp = oversamp;
> +
> +	return 0;
> +}
> +
>  static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>  					  uintptr_t priv,
>  					  const struct iio_chan_spec *chan,
>  					  const char *buf, size_t len)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
>  	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
>  	unsigned int sample_freq = adc->sample_freq;
>  	unsigned int spi_freq;
> @@ -583,17 +608,9 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	if (sample_freq) {
> -		if (spi_freq % sample_freq)
> -			dev_warn(&indio_dev->dev,
> -				 "Sampling rate not accurate (%d)\n",
> -				 spi_freq / (spi_freq / sample_freq));
> -
> -		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / sample_freq));
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev,
> -				"No filter parameters that match!\n");
> +		ret = dfsdm_adc_set_samp_freq(indio_dev, sample_freq, spi_freq);
> +		if (ret < 0)
>  			return ret;
> -		}
>  	}
>  	adc->spi_freq = spi_freq;
>  
> @@ -1068,22 +1085,9 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>  			spi_freq = adc->spi_freq;
>  		}
>  
> -		if (spi_freq % val)
> -			dev_warn(&indio_dev->dev,
> -				 "Sampling rate not accurate (%d)\n",
> -				 spi_freq / (spi_freq / val));
> -
> -		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / val));
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev,
> -				"Not able to find parameter that match!\n");
> -			iio_device_release_direct_mode(indio_dev);
> -			return ret;
> -		}
> -		adc->sample_freq = val;
> +		ret = dfsdm_adc_set_samp_freq(indio_dev, val, spi_freq);
>  		iio_device_release_direct_mode(indio_dev);
> -
> -		return 0;
> +		return ret;
>  	}
>  
>  	return -EINVAL;

