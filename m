Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44716C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0820B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554636857;
	bh=ZQCNhaf43DRSb7tPlyQF2l0Hl7wbew+4CV8SLRt7ncM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zE9TopobeaIznGHeb0jjmsZJF3PbHCOkPyQC9fk28OYqtat/cAFEorOtNImn6qot3
	 XQ+Rb1WW1NwfA/M82GPfgmq1oG3yy0iE50LMB+9ER0gBkuU4RpD6KfFKcxc7PKLRnu
	 1rEEnRERnxPOqV2LD0tbDlgo3/hud7H7yTFatq6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDGLeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:34:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FD320879;
        Sun,  7 Apr 2019 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554636854;
        bh=ZQCNhaf43DRSb7tPlyQF2l0Hl7wbew+4CV8SLRt7ncM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jucMbyuQKmdTxN0IixXwEWMq6OE4r5ihDHWAUue/MDhYmwsqMDs/Jy+6Hs6REiuWS
         JUpvv2UNCqvYGWzRza8tLj+SojFT/lSYFaIznryx7bSl1n5KYRTA5OfavQ0xRrId79
         RtDhF7YJYcc6NPTnVJ2FXqYHgakwPv0PxaxqrCXw=
Date:   Sun, 7 Apr 2019 12:34:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 3/4] staging: iio: ad9832: use clock framework for clock
 reference
Message-ID: <20190407123408.3e4e14bb@archlinux>
In-Reply-To: <20190401143745.ooxttvazrlqe2lcc@smtp.gmail.com>
References: <20190401143745.ooxttvazrlqe2lcc@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 11:37:45 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Previously external clock were set through platform_data struct.
> Now device uses clk struct defined in include/linux/clk.h to handle
> external clock source.
> It also removes mclk from platform_data struct.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c | 37 +++++++++++++++++---------
>  drivers/staging/iio/frequency/ad9832.h |  1 -
>  2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index d8d4a7936275..74308a2e72db 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -7,6 +7,7 @@
>  
>  #include <asm/div64.h>
>  
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> @@ -95,7 +96,7 @@ struct ad9832_state {
>  	struct spi_device		*spi;
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
> -	unsigned long			mclk;
> +	struct clk			*mclk;
>  	unsigned short			ctrl_fp;
>  	unsigned short			ctrl_ss;
>  	unsigned short			ctrl_src;
> @@ -130,10 +131,10 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  {
>  	unsigned long regval;
>  
> -	if (fout > (st->mclk / 2))
> +	if (fout > (clk_get_rate(st->mclk) / 2))
>  		return -EINVAL;
>  
> -	regval = ad9832_calc_freqreg(st->mclk, fout);
> +	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
>  
>  	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
>  					(addr << ADD_SHIFT) |
> @@ -334,7 +335,16 @@ static int ad9832_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> -	st->mclk = pdata->mclk;
> +	st->mclk = devm_clk_get(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk)) {
> +		ret = PTR_ERR(st->mclk);
> +		goto error_disable_dvdd;
> +	}
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret < 0)
> +		goto error_disable_dvdd;
> +
>  	st->spi = spi;
>  	mutex_init(&st->lock);
>  
> @@ -385,39 +395,41 @@ static int ad9832_probe(struct spi_device *spi)
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {
>  		dev_err(&spi->dev, "device init failed\n");
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  	}
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_disable_dvdd;
> +		goto error_unprepare_mclk;
>  
>  	return 0;
>  
> +error_unprepare_mclk:
> +	clk_disable_unprepare(st->mclk);
>  error_disable_dvdd:
>  	regulator_disable(st->dvdd);
>  error_disable_avdd:
> @@ -432,6 +444,7 @@ static int ad9832_remove(struct spi_device *spi)
>  	struct ad9832_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	clk_disable_unprepare(st->mclk);
>  	regulator_disable(st->dvdd);
>  	regulator_disable(st->avdd);
>  
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
> index 39d326cc1af9..032579a2d539 100644
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -24,7 +24,6 @@
>   */
>  
>  struct ad9832_platform_data {
> -	unsigned long		mclk;
>  	unsigned long		freq0;
>  	unsigned long		freq1;
>  	unsigned short		phase0;

