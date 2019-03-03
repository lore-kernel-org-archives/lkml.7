Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1D6C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7035C20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626460;
	bh=MebKlPuxeSBNnTbJs9KccKLdKxCkTvLHoVe0q3eWkoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YWCM363YYha1qeioJZxt4vJvbd3nM4TUSAed9k6xwKtCbNm1zOz1vSNa8/s6vT2jc
	 cA51B9OKV3RHdP0sgA6paWbJCiMG9v7gYbdzcNV6UPfKR9jgQew1SnjNc2DeJWairN
	 a7xoJ1/8bfjnd4Zc6DMhs9bEVo57d3i4tJ4PZR3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCCPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfCCPU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:20:58 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0A920836;
        Sun,  3 Mar 2019 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626457;
        bh=MebKlPuxeSBNnTbJs9KccKLdKxCkTvLHoVe0q3eWkoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2iZC5sqX9BTxPUPMNaW2bk6dxjzQWVCBdIFEJgonNkiqCAQ1hU53bfAOOzznYoDK9
         PKju10myEqWzBEIF8wDT5L4GYkxS8abENGRQIjat/Y0GhmlJmIwFkqiIub6oZxdvqF
         /hExvsovIo/PvIc4D01K+SK4g0RkpaSg5pQfFdmo=
Date:   Sun, 3 Mar 2019 15:20:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] iio: accel: bma180: add mount matrix support
Message-ID: <20190303152050.1bd70f7d@archlinux>
In-Reply-To: <39eb050ab5ba5a10f624f95f2bf4582e4e7ccbde.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <39eb050ab5ba5a10f624f95f2bf4582e4e7ccbde.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:49 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma180.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index cb9765a3de60..f9720a1e8a7c 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -116,6 +116,7 @@ struct bma180_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *trig;
>  	const struct bma180_part_info *part_info;
> +	struct iio_mount_matrix orientation;
>  	struct mutex mutex;
>  	bool sleep_state;
>  	int scale;
> @@ -561,6 +562,15 @@ static int bma180_set_power_mode(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static const struct iio_mount_matrix *
> +bma180_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan)
> +{
> +	struct bma180_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
>  static const struct iio_enum bma180_power_mode_enum = {
>  	.items = bma180_power_modes,
>  	.num_items = ARRAY_SIZE(bma180_power_modes),
> @@ -571,7 +581,8 @@ static const struct iio_enum bma180_power_mode_enum = {
>  static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
>  	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
>  	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
> -	{ },
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
> +	{ }
>  };
>  
>  #define BMA180_ACC_CHANNEL(_axis, _bits) {				\
> @@ -722,6 +733,11 @@ static int bma180_probe(struct i2c_client *client,
>  		chip = id->driver_data;
>  	data->part_info = &bma180_part_info[chip];
>  
> +	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
> +				&data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	ret = data->part_info->chip_config(data);
>  	if (ret < 0)
>  		goto err_chip_disable;

