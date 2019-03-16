Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F280C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96B4218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552758873;
	bh=Gj9AY78cWuTyXg26uwiZXxzoOidrBYGmJghFNFXL9DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ONoKIfY90q31QzQ2fjzwDg8hWtSPnCTA/mCIRxCQpMABFz5YGPjwQdyAsYdYz+Zsc
	 pZEdQGPXLcaFUX2zSoql+L2+0NP3q5qWqwAabdkP6NIJvqaRMoRiibr9hmTPvYVXy3
	 GUjjOVH0arl13SOmJhGiXbPMLPir2PUWD7D4sOTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCPRyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPRya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:54:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767F9218D0;
        Sat, 16 Mar 2019 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552758869;
        bh=Gj9AY78cWuTyXg26uwiZXxzoOidrBYGmJghFNFXL9DM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qmbRlvzsZAdz50kkDc5x+vb6sVwSg2AKd9HssV4bc7PPF/x9AumErlKB1Si+XNEio
         tzC9Zies6b2jV/k7WNB0+rtGLQeeC1uadTNOVpF1s0qjEveOfuD134JDqHIlSvDhqv
         8x73Hv6DwymZuCcS//5ZdXuLZr4iIskV8x8eCQVQ=
Date:   Sat, 16 Mar 2019 17:54:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 03/11] staging: iio: ad7780: add gain reading to
 ad778x
Message-ID: <20190316175423.26481b43@archlinux>
In-Reply-To: <aed4d900061c5733decc429d0d0816122dba0991.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <aed4d900061c5733decc429d0d0816122dba0991.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:13:13 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds a new functionality of reading gain values from the
> ad778x chips. This value is stored in the chip's state struct and is
> updated whenever a read or write call is performed on the driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>

Applied, thanks

> ---
>  drivers/staging/iio/adc/ad7780.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index f4cd7bc3e02f..fbcc0d3345ca 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -42,6 +42,8 @@
>  #define AD7780_GAIN_MIDPOINT	64
>  #define AD7780_FILTER_MIDPOINT	13350
>  
> +static const unsigned int ad778x_gain[2] = { 1, 128 };
> +
>  struct ad7780_chip_info {
>  	struct iio_chan_spec	channel;
>  	unsigned int		pattern_mask;
> @@ -179,6 +181,9 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
>  		return -EIO;
>  
> +	if (chip_info->is_ad778x)
> +		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
> +
>  	return 0;
>  }
>  

