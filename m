Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15A6C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B792E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555928283;
	bh=pjw75+H+COm62wi8khOzhM4I5+Ke/+t/SG0ak/OWhPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mfa8RSGzZh4NlMu3o98FeSPtTGsXUuXpF+Hov4B4JbAFOAV0Uhzpewza1eTHkNCRC
	 sS3JSEReQnYwyjGghz70+hbmhiwImnhD8fKrx2LFxqdG3RtLtIfwp/RKz6wog/I7at
	 SPWmWRH2naMHZ/fdpez/MkFjoo8q15KjnLCE+jqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDVKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:18:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F90A206A3;
        Mon, 22 Apr 2019 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555928281;
        bh=pjw75+H+COm62wi8khOzhM4I5+Ke/+t/SG0ak/OWhPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l/klFapXSlriq+czY8EzY4YD2Jc0/zKUl0q+z2OA+JesT69YVxOqL14whnsdnakEa
         mHVFLlP1+cTtPDJ8fDjgHzmyaYotFUg4A4YhWz/+dClCofFeQ7FfO5OlwQzTHONNeo
         FYFNzSivdJZSIHCXQVo03u6XascvE302eQDgAJE8=
Date:   Mon, 22 Apr 2019 11:17:54 +0100
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
Subject: Re: [PATCH 2/2] iio: adc: stm32-dfsdm: fix triggered buffer build
 dependency
Message-ID: <20190422111754.018878c0@archlinux>
In-Reply-To: <1555333251-4422-3-git-send-email-fabrice.gasnier@st.com>
References: <1555333251-4422-1-git-send-email-fabrice.gasnier@st.com>
        <1555333251-4422-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 15:00:51 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> This fixes build errors seen when CONFIG_STM32_DFSDM_ADC is set, as
> stm32-dfsdm-adc driver now also relies on triggered buffer API:
> 
> Fixes: 11646e81d775 ("iio: adc: stm32-dfsdm: add support for buffer modes")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b1b2bde..f3bd32e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -823,6 +823,7 @@ config STM32_DFSDM_ADC
>  	select REGMAP_MMIO
>  	select IIO_BUFFER
>  	select IIO_BUFFER_HW_CONSUMER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Select this option to support ADCSigma delta modulator for
>  	  STMicroelectronics STM32 digital filter for sigma delta converter.

