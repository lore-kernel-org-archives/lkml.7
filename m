Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082AFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF379208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556371011;
	bh=wlcS5kMqNpaIM9lA8EAYOf8w70u6GRhmxYRG5F1T51Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u9ASInCuHTV5ocxssvKylaiJRSBzAwvCfdRQtZuthQhOzBz054+JiHs0ClT2U8eNY
	 wJEAUxAXbDVNX/Ruu/g5z8gcaOJxs2C/ENpPeUHG7VriYU0xfqYfmTj/4AAvUQB3ge
	 EQyMFCW6L4B12B6JjRBCFojdiXnafmcr5DlSCzC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfD0NQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0NQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:16:49 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0D1208C2;
        Sat, 27 Apr 2019 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556371008;
        bh=wlcS5kMqNpaIM9lA8EAYOf8w70u6GRhmxYRG5F1T51Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAGBcUm5YmS/7t/gfWp1U/3qgqnbj4heoT+v3t07heZmI5uhzwI6TGCLiXwkDT4Ka
         i2oJSZ9AtpkpE8GdbtBOdzwzRh6kbuZGbAszEF6yEon1edmP94MaY16aBLIU8tBT3t
         WD59hAGrRMEud8Yz56GcWVy3OhQgbzWwksbrjUJQ=
Date:   Sat, 27 Apr 2019 14:16:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: dac: ad5758: remove set but not used
 variable 'dc_dc_mode'
Message-ID: <20190427141642.673f33f3@archlinux>
In-Reply-To: <20190426164006.26928-1-yuehaibing@huawei.com>
References: <20190426164006.26928-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 00:40:06 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/iio/dac/ad5758.c: In function ad5758_write_powerdown:
> drivers/iio/dac/ad5758.c:585:15: warning: variable dc_dc_mode set but not used [-Wunused-but-set-variable]
> 
> It is not used any more since
> commit edde945257e2 ("iio: dac: ad5758: Modifications for new revision")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5758.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index a513c70..570f69e 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -582,7 +582,7 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5758_state *st = iio_priv(indio_dev);
>  	bool pwr_down;
> -	unsigned int dc_dc_mode, dac_config_mode, val;
> +	unsigned int dac_config_mode, val;
>  	unsigned long int dac_config_msk;
>  	int ret;
>  
> @@ -591,13 +591,10 @@ static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	mutex_lock(&st->lock);
> -	if (pwr_down) {
> -		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
> +	if (pwr_down)
>  		val = 0;
> -	} else {
> -		dc_dc_mode = st->dc_dc_mode;
> +	else
>  		val = 1;
> -	}
>  
>  	dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
>  			  AD5758_DAC_CONFIG_INT_EN_MODE(val);

