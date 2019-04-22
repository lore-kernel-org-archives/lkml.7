Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2B9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307A2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555928212;
	bh=3TRFGMvJmSa/ZGijQzF5Eyf501z0S9bymkbnBQrSqUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fbPRQVWp26ZbMvQv1o3xHhsZEqLSVlFXK5oxcgdsBsQuo/KbwJAQDJNxIwMcbsV5D
	 vxxraGVyzTktF6K5haMn9jBBIWOhyEDgTVZ0mCNComfqwC/isJhwMpz/r6L3kfDaJa
	 EEDDgc+8rLq5nCzbhtBCIV7e/Dj1YZ1iB8ycuTDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDVKQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:16:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF23206A3;
        Mon, 22 Apr 2019 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555928210;
        bh=3TRFGMvJmSa/ZGijQzF5Eyf501z0S9bymkbnBQrSqUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DEMfSg12iVfykAD87dISJs+7YRgeHmOJPGgAQVxefp5CvJ8BfTGvCipmus7DuOaZl
         w/dgiz3RSsUxWeo21LSqFHFZmG8glTSS5pAISRZMB2Or9GSqQZ+dgR3sdIAaUY5bff
         TCfbenXSbTkbPW7L6jTbfJrXytBVoGyOYqMF1Fso=
Date:   Mon, 22 Apr 2019 11:16:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <benjamin.gaignard@linaro.org>, <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] iio: adc: stm32-dfsdm: fix unmet direct
 dependencies detected
Message-ID: <20190422111643.0270fba6@archlinux>
In-Reply-To: <1555333251-4422-2-git-send-email-fabrice.gasnier@st.com>
References: <1555333251-4422-1-git-send-email-fabrice.gasnier@st.com>
        <1555333251-4422-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 15:00:50 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> This fixes unmet direct dependencies seen when CONFIG_STM32_DFSDM_ADC
> is selected:
> 
> WARNING: unmet direct dependencies detected for IIO_BUFFER_HW_CONSUMER
>   Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
>   Selected by [y]:
>   - STM32_DFSDM_ADC [=y] && IIO [=y] && (ARCH_STM32 [=y] && OF [=y] ||
>     COMPILE_TEST [=n])
> 
> Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hmm. I wonder how we never got this one from a rand config.
Anyhow, give we are near the end of this cycle, I'll take this for
the next merge window rather than rushing it through.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 846c7ac..b1b2bde 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -821,6 +821,7 @@ config STM32_DFSDM_ADC
>  	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>  	select STM32_DFSDM_CORE
>  	select REGMAP_MMIO
> +	select IIO_BUFFER
>  	select IIO_BUFFER_HW_CONSUMER
>  	help
>  	  Select this option to support ADCSigma delta modulator for

