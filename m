Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F19C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02D620866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626505;
	bh=8UGTN9ThtQgrMoeGidYXDxur64lP+LGMC52lPFNpxEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HTihpsVi5pV4G1pn3wwuoOsgHvsrYk95eUMJ3WN0HdznjAEZ0gDZioZZLGPbNrvP6
	 IyfgA7fgaPlNkwjvbz7Xz23phhkN7jXeXNI+Sra5KBoz76GW0I0cLFN2mhUNO3xi2Y
	 tHlnoTQGAbHO0OEVXV1WhPIKHUKYnSqDAuqANHGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCCPVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfCCPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:21:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DF320836;
        Sun,  3 Mar 2019 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626502;
        bh=8UGTN9ThtQgrMoeGidYXDxur64lP+LGMC52lPFNpxEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q116V3X2PLnEuEVM71OLMtvzBCfGvvTXZgeTLL+G2p0CfI763d7SwRWLkuaxaq+KV
         RiqY98+9HLSVT5yKdQ0xqir9op3NiQp+kH+m++vp5j6/P/a4XAN5tP59E3UPCzB2tT
         0gJRCBWD5MlT1V2lk9PRZk7nT+zUDow0DgFiP5P8=
Date:   Sun, 3 Mar 2019 15:21:34 +0000
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
Subject: Re: [PATCH v2 05/10] iio: gyro: bmg160: add mount matrix support
Message-ID: <20190303152134.23629e29@archlinux>
In-Reply-To: <49a4b6c13b1d293050ad11bcdeb35f2694428574.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <49a4b6c13b1d293050ad11bcdeb35f2694428574.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:50 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Applied.

Thanks,
> ---
>  drivers/iio/gyro/bmg160_core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 63ca31628a93..e7b38adee39a 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -102,6 +102,7 @@ struct bmg160_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *dready_trig;
>  	struct iio_trigger *motion_trig;
> +	struct iio_mount_matrix orientation;
>  	struct mutex mutex;
>  	s16 buffer[8];
>  	u32 dps_range;
> @@ -794,6 +795,20 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static const struct iio_mount_matrix *
> +bmg160_get_mount_matrix(const struct iio_dev *indio_dev,
> +			 const struct iio_chan_spec *chan)
> +{
> +	struct bmg160_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info bmg160_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmg160_get_mount_matrix),
> +	{ }
> +};
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
>  
>  static IIO_CONST_ATTR(in_anglvel_scale_available,
> @@ -831,6 +846,7 @@ static const struct iio_event_spec bmg160_event = {
>  		.storagebits = 16,					\
>  		.endianness = IIO_LE,					\
>  	},								\
> +	.ext_info = bmg160_ext_info,					\
>  	.event_spec = &bmg160_event,					\
>  	.num_event_specs = 1						\
>  }
> @@ -1075,6 +1091,11 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	data->irq = irq;
>  	data->regmap = regmap;
>  
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> +				&data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	ret = bmg160_chip_init(data);
>  	if (ret < 0)
>  		return ret;

