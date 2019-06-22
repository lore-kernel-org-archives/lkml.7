Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED3C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBC2206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561192639;
	bh=Qave1uiIHG7H7yaasUAl2lDHR8dGS+/aVwXhP0yLXBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QZgN+RHcqPoQePIPDI6s3vkwHEZVY9RAoyDYi7z76KBbG+ANR4o2iW1Ti84R9lsnk
	 A6tjV8MkV65RvRtckGdkKOZamv6FOeRRHHzmFWaAuWApfvM9bz0T/zAeQ3PBOUsL9m
	 a9VJwJLDSgJ5Pfon0/+d16KRrRHhJ2ETdEnTQ9co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFVIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfFVIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:37:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58B420665;
        Sat, 22 Jun 2019 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561192636;
        bh=Qave1uiIHG7H7yaasUAl2lDHR8dGS+/aVwXhP0yLXBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hEpulM4/3NqkFbAUadswm5mn913jIg4gw/9/4lFrrqBL5wYIrHZIaW3H+qxb9Im3g
         oMAVQs4HYEgcNd8232IjRrQsE6029QmapZlDtRbCIXr0do6tHYl1sGG1cx4gOiShIC
         o7igLV8/gOEn9fX+xwK+9sIVsmH7ZnDyqJ2jzJkc=
Date:   Sat, 22 Jun 2019 09:37:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V2 2/4] iio: adc: ad7124: Add buffered input support
Message-ID: <20190622093654.61e31fc5@archlinux>
In-Reply-To: <20190621121344.24917-2-mircea.caprioru@analog.com>
References: <20190621121344.24917-1-mircea.caprioru@analog.com>
        <20190621121344.24917-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 15:13:42 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch adds the option to enable the buffered mode for positive and
> negative inputs. Each option can be enabled independently.
> 
> In buffered mode, the input channel feeds into a high impedance input stage
> of the buffer amplifier. Therefore, the input can tolerate significant
> source impedances and is tailored for direct connection to external
> resistive type sensors such as strain gages or RTDs.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Hi Mircea,

This (and the other 2) looks good to me, but I won't
pick them up until the binding patch is split up.  That
way we won't end up with the driver being out of sync with
the binding docs, even for a brief time.

Thanks,

Jonathan

> ---
> 
> Changelog v2:
> - nothing changed here
> 
>  drivers/iio/adc/ad7124.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 810234db9c0d..ab52c5e9ecb1 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -61,6 +61,8 @@
>  #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
>  #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
>  #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
> +#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
> +#define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
>  
>  /* AD7124_FILTER_X */
>  #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
> @@ -108,6 +110,8 @@ struct ad7124_chip_info {
>  struct ad7124_channel_config {
>  	enum ad7124_ref_sel refsel;
>  	bool bipolar;
> +	bool buf_positive;
> +	bool buf_negative;
>  	unsigned int ain;
>  	unsigned int vref_mv;
>  	unsigned int pga_bits;
> @@ -473,6 +477,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  		else
>  			st->channel_config[channel].refsel = tmp;
>  
> +		st->channel_config[channel].buf_positive =
> +			of_property_read_bool(child, "adi,buffered-positive");
> +		st->channel_config[channel].buf_negative =
> +			of_property_read_bool(child, "adi,buffered-negative");
> +
>  		*chan = ad7124_channel_template;
>  		chan->address = channel;
>  		chan->scan_index = channel;
> @@ -492,7 +501,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  static int ad7124_setup(struct ad7124_state *st)
>  {
>  	unsigned int val, fclk, power_mode;
> -	int i, ret;
> +	int i, ret, tmp;
>  
>  	fclk = clk_get_rate(st->mclk);
>  	if (!fclk)
> @@ -525,8 +534,12 @@ static int ad7124_setup(struct ad7124_state *st)
>  		if (ret < 0)
>  			return ret;
>  
> +		tmp = (st->channel_config[i].buf_positive << 1)  +
> +			st->channel_config[i].buf_negative;
> +
>  		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
> -		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel);
> +		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
> +		      AD7124_CONFIG_IN_BUFF(tmp);
>  		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
>  		if (ret < 0)
>  			return ret;

