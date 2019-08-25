Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E9DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EDC2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566755983;
	bh=oaONTBjp8tdxVmutSvqzh94T9wNHY+a039958oY8hWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d8pEBdp4tt1ulR4F1YQtMwPNKS+BMDTki8rBveiUePu0hWy+kqI/5OtP4sjIE/3nT
	 3ckwi12znFgtpswbBAUhQ0qp9U2B+iS2Gs1+ltAbfI6k6zP3YNf/UizvtwOJGtthyb
	 z7RboaXLeVgSa68W5EfQ+B5IBWfnZXfZQFon5UYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfHYR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfHYR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:59:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3E12080C;
        Sun, 25 Aug 2019 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566755981;
        bh=oaONTBjp8tdxVmutSvqzh94T9wNHY+a039958oY8hWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sr6nP9nVWQ16lq5ybMtsAsi2X7Yatr1VlMf6qm8C3K9Kw8oMshqSXIQHyaGT1kR7T
         zlPTLvPiClE4vLzggAEAGxg6hrSb9USB6PI1VOMtmoDDASRPmLjr50M4S14GbQvvho
         CsIgSrFJvh6xr+dOYNimz1ClF9E9qnlx9AMETAJ8=
Date:   Sun, 25 Aug 2019 18:59:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <denis.ciocca@st.com>, <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] iio: st_sensors: Fix build error
Message-ID: <20190825185936.0b31cde6@archlinux>
In-Reply-To: <20190823121852.75108-1-yuehaibing@huawei.com>
References: <20190823121852.75108-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 20:18:52 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> IIO_ST_SENSORS_CORE select IIO_ST_SENSORS_I2C
> unconditionally, if REGMAP_I2C is not set, build fails
> 
> drivers/iio/common/st_sensors/st_sensors_i2c.o: In function `st_sensors_i2c_configure':
> st_sensors_i2c.c:(.text+0x58): undefined reference to `__devm_regmap_init_i2c'
> 
> This patch selects REGMAP_I2C to fix it.
> IIO_ST_SENSORS_SPI is similar to SPI issue.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 062809ef7733 ("iio: make st_sensors drivers use regmap")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hi,

Thanks,  I've fixed up the inconsistent ordering below.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/common/st_sensors/Kconfig b/drivers/iio/common/st_sensors/Kconfig
> index 91b98e1..16d973f 100644
> --- a/drivers/iio/common/st_sensors/Kconfig
> +++ b/drivers/iio/common/st_sensors/Kconfig
> @@ -5,8 +5,10 @@
>  
>  config IIO_ST_SENSORS_I2C
>  	tristate
> +	select REGMAP_I2C
>  
>  config IIO_ST_SENSORS_SPI
> +	select REGMAP_SPI

Inconsistent with the previous.

>  	tristate
>  
>  config IIO_ST_SENSORS_CORE

