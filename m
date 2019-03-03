Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8510CC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513CD20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626681;
	bh=CI6sYNh/jkg3Ci8ON7wF4N0hp1UHq0DfzScMyCDqqKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cgA9kbgpKXYmOAxbboeizZVXyHNjt8AD4qty3llnG8JCgO0EsPdDcSWodCfRfm0Tp
	 Z6S+IsVhU0gNv8ZpaOjb+rh/T4umjU4DH8ufXc1/Aawab/MaN6w+yHROP1etB0T8MG
	 lTix34WqeCbhJnnVBp25Sjgx+6cvsYRj//yaqZEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCCPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:24:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB48B204FD;
        Sun,  3 Mar 2019 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626677;
        bh=CI6sYNh/jkg3Ci8ON7wF4N0hp1UHq0DfzScMyCDqqKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5tVC7QyG4019+LziWkheQNwvSbe2Uj1PyCNIk5Ri6LatN8tOkw+/3/0XTmhGhHde
         7s87l7MNzKuEMjGkv9mwVDhG7FFNjhXrIyAinhKAUhhHHu+C6QXNH0swnKqLh8V4NR
         t9GwocPMIzsdtGESC1uWbAzZxNadYj4aqetowDzI=
Date:   Sun, 3 Mar 2019 15:24:27 +0000
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
Subject: Re: [PATCH v2 08/10] iio: magnetometer: hmc5843: add mount matrix
 support
Message-ID: <20190303152427.7fd8706b@archlinux>
In-Reply-To: <fc3228d92f0c428e96e9925cd28378983596738d.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <fc3228d92f0c428e96e9925cd28378983596738d.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:53 +0100
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
>  drivers/iio/magnetometer/hmc5843.h      |  1 +
>  drivers/iio/magnetometer/hmc5843_core.c | 20 ++++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
> index a75224cf99df..e3e22d2508d3 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -43,6 +43,7 @@ struct hmc5843_data {
>  	struct mutex lock;
>  	struct regmap *regmap;
>  	const struct hmc5843_chip_info *variant;
> +	struct iio_mount_matrix orientation;
>  	__be16 buffer[8];
>  };
>  
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index ada142fb7aa3..05629ec56d80 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -237,6 +237,15 @@ int hmc5843_set_measurement_configuration(struct iio_dev *indio_dev,
>  	return hmc5843_set_meas_conf(data, meas_conf);
>  }
>  
> +static const struct iio_mount_matrix *
> +hmc5843_get_mount_matrix(const struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan)
> +{
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
>  static const struct iio_enum hmc5843_meas_conf_enum = {
>  	.items = hmc5843_meas_conf_modes,
>  	.num_items = ARRAY_SIZE(hmc5843_meas_conf_modes),
> @@ -247,7 +256,8 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
>  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
>  	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
>  	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> -	{ },
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> +	{ }
>  };
>  
>  static const struct iio_enum hmc5983_meas_conf_enum = {
> @@ -260,7 +270,8 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
>  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
>  	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
>  	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> -	{ },
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> +	{ }
>  };
>  
>  static
> @@ -635,6 +646,11 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
>  	data->variant = &hmc5843_chip_info_tbl[id];
>  	mutex_init(&data->lock);
>  
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> +				&data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->dev.parent = dev;
>  	indio_dev->name = name;
>  	indio_dev->info = &hmc5843_info;

