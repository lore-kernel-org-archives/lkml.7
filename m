Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C83C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F48218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552759036;
	bh=Q91zTYYwbUuY05bfcjTEGeNsk7Tc5VfIN0iD5Epm2P0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yJBWW2ts5sl3HtfV4ZYx6JdGBA8riv+VNRVEpfqbrPQ6O24c/tF6rzGUQJc6XSHs8
	 LgSsjh6DPY/JtoUedse0PcBsOuOtjyYqzawjti4kuvhGmbiybVIuie1C3Y5rLkN4sA
	 XnYPk66vVphHBiZplzj3ZSLjDGQ3EHcV9H2fwpt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCPR5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPR5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:57:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6806B218D0;
        Sat, 16 Mar 2019 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552759033;
        bh=Q91zTYYwbUuY05bfcjTEGeNsk7Tc5VfIN0iD5Epm2P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ggK6knhAoRX33ZBPBIbCMh7tT3bP2LRyiNJ+Zpim0g9TPuamt8RpQ2pKuZw79VDk1
         +wPPfy+IrRYwRLlL9yFGcVcKdRU8z2BUZGCCTU3fW3nr8BzDM4NrxaQKHRE723oOO+
         yKMu7ZeyHF47VYhvCh5VN0GPRRxyoMYx1nkNF7YU=
Date:   Sat, 16 Mar 2019 17:57:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 05/11] staging: iio: ad7780: set pattern values and
 masks directly
Message-ID: <20190316175706.0012b9f0@archlinux>
In-Reply-To: <ecfec5163339a3ffa8958876b97c08c601e5cadc.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <ecfec5163339a3ffa8958876b97c08c601e5cadc.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:14:14 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> The AD7780 driver contains status pattern bits designed for checking
> whether serial transfers have been correctly performed. Pattern macros
> were previously generated through bit fields. This patch sets good
> pattern values directly and masks through GENMASK.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied, 

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 8ff74427d975..94cb60c327d0 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/bits.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -28,16 +29,13 @@
>  #define AD7780_ID1		BIT(4)
>  #define AD7780_ID0		BIT(3)
>  #define AD7780_GAIN		BIT(2)
> -#define AD7780_PAT1		BIT(1)
> -#define AD7780_PAT0		BIT(0)
>  
> -#define AD7780_PATTERN		(AD7780_PAT0)
> -#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
>  
> -#define AD7170_PAT2		BIT(2)
> +#define AD7780_PATTERN_GOOD	1
> +#define AD7780_PATTERN_MASK	GENMASK(1, 0)
>  
> -#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
> -#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> +#define AD7170_PATTERN_GOOD	5
> +#define AD7170_PATTERN_MASK	GENMASK(2, 0)
>  
>  #define AD7780_GAIN_MIDPOINT	64
>  #define AD7780_FILTER_MIDPOINT	13350
> @@ -209,25 +207,25 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7170] = {
>  		.channel = AD7170_CHANNEL(12, 24),
> -		.pattern = AD7170_PATTERN,
> +		.pattern = AD7170_PATTERN_GOOD,
>  		.pattern_mask = AD7170_PATTERN_MASK,
>  		.is_ad778x = false,
>  	},
>  	[ID_AD7171] = {
>  		.channel = AD7170_CHANNEL(16, 24),
> -		.pattern = AD7170_PATTERN,
> +		.pattern = AD7170_PATTERN_GOOD,
>  		.pattern_mask = AD7170_PATTERN_MASK,
>  		.is_ad778x = false,
>  	},
>  	[ID_AD7780] = {
>  		.channel = AD7780_CHANNEL(24, 32),
> -		.pattern = AD7780_PATTERN,
> +		.pattern = AD7780_PATTERN_GOOD,
>  		.pattern_mask = AD7780_PATTERN_MASK,
>  		.is_ad778x = true,
>  	},
>  	[ID_AD7781] = {
>  		.channel = AD7780_CHANNEL(20, 32),
> -		.pattern = AD7780_PATTERN,
> +		.pattern = AD7780_PATTERN_GOOD,
>  		.pattern_mask = AD7780_PATTERN_MASK,
>  		.is_ad778x = true,
>  	},

