Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77844C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446B32087E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445967;
	bh=w0K+OU/VTk8rR7mwNdorB+rujpwHZl+J6xPdr2gqcRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tRYlz2VAfelETkXjY3DgvY09y94KYYWeniP7douMCOhv44iqnDVarF0c2Pb2zIuKu
	 hq9nObpmh5PcqmYhJNG/k6IEDjpX4r8ToyfkjoTt7TmduEc3PLAYM9lXpNy0/S7ACu
	 BzpCexSRIHeopyP2B9cbBfFoLiOWaDPAnPCNXK1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfCXQqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXQqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:46:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4194420823;
        Sun, 24 Mar 2019 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445965;
        bh=w0K+OU/VTk8rR7mwNdorB+rujpwHZl+J6xPdr2gqcRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=igZShqUo/0w/Zj7ubj7gM7oRCrFPEuPjCdnJiYfWZXhLJUfflPQaUiiK5LwJiZ4C0
         Krh2jcTAL8dF2UVu61apfcFwS0x0Y6fztFQIDKovVt/+qSYEB2dUrOCXLx9YdzCYTk
         npmxeQ81jcvsHEhDl6YCYYmUmHHBK64r8lY+sIIE=
Date:   Sun, 24 Mar 2019 16:45:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 5/8] iio: adc: stm32-dfsdm: enable hw consumer
Message-ID: <20190324164559.430c12f9@archlinux>
In-Reply-To: <1553186849-6261-6-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-6-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:26 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Optionally enable IIO hw consumer, when provided (e.g. for DFSDM_IIO type).
> This is precursor patch to introduce buffer modes.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied, 
Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 66e2ea0..b491424 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -630,9 +630,15 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
> +	if (adc->hwc) {
> +		ret = iio_hw_consumer_enable(adc->hwc);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
>  	if (ret < 0)
> -		return ret;
> +		goto err_stop_hwc;
>  
>  	ret = stm32_dfsdm_adc_dma_start(indio_dev);
>  	if (ret) {
> @@ -652,6 +658,9 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  	stm32_dfsdm_adc_dma_stop(indio_dev);
>  stop_dfsdm:
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
> +err_stop_hwc:
> +	if (adc->hwc)
> +		iio_hw_consumer_disable(adc->hwc);
>  
>  	return ret;
>  }
> @@ -667,6 +676,9 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>  
> +	if (adc->hwc)
> +		iio_hw_consumer_disable(adc->hwc);
> +
>  	return 0;
>  }
>  

