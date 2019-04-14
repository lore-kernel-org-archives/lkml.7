Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E0C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E5218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555246951;
	bh=TQMnA7G/x9FxXq7LsffPJ7zRNUpi74at4jvOJQq2yNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P7mpByQ2BJAseQpDwPhQUXPrkfOQXeoZQDVvb35DzkkdZbIyN/w+f9FjmQfOwf1x9
	 1ZSdoPUtp8QrPrVtAq7XHVwlw/1eUkC+IwKxUEXTm1vPTWs0oRWHtvgaAqhiObPfNx
	 owbH/LXdtu7/cHxmVD2TTN4n4W/m28Q9IDnC+ug8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDNNC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNNC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:02:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6739820896;
        Sun, 14 Apr 2019 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555246945;
        bh=TQMnA7G/x9FxXq7LsffPJ7zRNUpi74at4jvOJQq2yNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XH0K0PgtY0sPSzaB6vV0WqsQl/2FRrZSAFW3yuGmT+FXie3h2cNU/iHLape6Ifr/C
         ckqp8sE4r7tmvBajKOl1JxpYIuRn1YECmbaZSRXsIRYkE8JG6UC010iXjKdLRBVjfC
         sjTl/kEjYU1fGo9mtTOBGR1gDDSR5j2rVRTX5fVM=
Date:   Sun, 14 Apr 2019 14:02:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5758: Modifications for new revision
Message-ID: <20190414140220.75133382@archlinux>
In-Reply-To: <20190409133521.24828-1-mircea.caprioru@analog.com>
References: <20190409133521.24828-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 16:35:21 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch will ensure compatibility with the new revision of the AD5758
> dac converter. The modifications consist of removing the fault_prot_switch
> function since this option is no longer available, and enabling the
> ENABLE_PPC_BUFFERS bit in ADC_CONFIG register before setting the PPC
> current mode.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Hi Mircea,

Talk me through the implications of this change.

1. Any changes to functionality that might break users of the older revisions?
2. Any userspace visible changes?
3. Do we want to think about back porting to older kernels?
4. Should we support this explicitly by detecting or describing the
   hardware revision in some fashion?

Thanks,

Jonathan



> ---
>  drivers/iio/dac/ad5758.c | 55 +++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index 2bdf1b0aee06..a513c70faefa 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -72,8 +72,6 @@
>  #define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)	(((x) & 0x1F) << 0)
>  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK	GENMASK(6, 5)
>  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)	(((x) & 0x3) << 5)
> -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK	BIT(7)
> -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
>  
>  /* AD5758_DCDC_CONFIG2 */
>  #define AD5758_DCDC_CONFIG2_ILIMIT_MSK		GENMASK(3, 1)
> @@ -84,6 +82,10 @@
>  /* AD5758_DIGITAL_DIAG_RESULTS */
>  #define AD5758_CAL_MEM_UNREFRESHED_MSK		BIT(15)
>  
> +/* AD5758_ADC_CONFIG */
> +#define AD5758_ADC_CONFIG_PPC_BUF_EN(x)		(((x) & 0x1) << 11)
> +#define AD5758_ADC_CONFIG_PPC_BUF_MSK		BIT(11)
> +
>  #define AD5758_WR_FLAG_MSK(x)		(0x80 | ((x) & 0x1F))
>  
>  #define AD5758_FULL_SCALE_MICRO	65535000000ULL
> @@ -315,6 +317,18 @@ static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
>  {
>  	int ret;
>  
> +	/*
> +	 * The ENABLE_PPC_BUFFERS bit must be set prior to enabling PPC current
> +	 * mode.
> +	 */
> +	if (mode == AD5758_DCDC_MODE_PPC_CURRENT) {
> +		ret  = ad5758_spi_write_mask(st, AD5758_ADC_CONFIG,
> +				    AD5758_ADC_CONFIG_PPC_BUF_MSK,
> +				    AD5758_ADC_CONFIG_PPC_BUF_EN(1));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
>  				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
>  				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
> @@ -444,23 +458,6 @@ static int ad5758_set_out_range(struct ad5758_state *st, int range)
>  					     AD5758_CAL_MEM_UNREFRESHED_MSK);
>  }
>  
> -static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
> -{
> -	int ret;
> -
> -	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> -			AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
> -			AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
> -	if (ret < 0)
> -		return ret;
> -	/*
> -	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> -	 * This allows the 3-wire interface communication to complete.
> -	 */
> -	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> -					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> -}
> -
>  static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
>  {
>  	int ret;
> @@ -585,8 +582,8 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5758_state *st = iio_priv(indio_dev);
>  	bool pwr_down;
> -	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> -	unsigned long int dcdc_config1_msk, dac_config_msk;
> +	unsigned int dc_dc_mode, dac_config_mode, val;
> +	unsigned long int dac_config_msk;
>  	int ret;
>  
>  	ret = kstrtobool(buf, &pwr_down);
> @@ -602,17 +599,6 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
>  		val = 1;
>  	}
>  
> -	dcdc_config1_mode = AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
> -			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
> -	dcdc_config1_msk = AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> -			   AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
> -
> -	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> -				    dcdc_config1_msk,
> -				    dcdc_config1_mode);
> -	if (ret < 0)
> -		goto err_unlock;
> -
>  	dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
>  			  AD5758_DAC_CONFIG_INT_EN_MODE(val);
>  	dac_config_msk = AD5758_DAC_CONFIG_OUT_EN_MSK |
> @@ -841,11 +827,6 @@ static int ad5758_init(struct ad5758_state *st)
>  			return ret;
>  	}
>  
> -	/* Enable the VIOUT fault protection switch (FPS is closed) */
> -	ret = ad5758_fault_prot_switch_en(st, 1);
> -	if (ret < 0)
> -		return ret;
> -
>  	/* Power up the DAC and internal (INT) amplifiers */
>  	ret = ad5758_internal_buffers_en(st, 1);
>  	if (ret < 0)

