Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478CC4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8820866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626422;
	bh=P8PZLEAqkFI/Xl0BkJeC9ZtGZH6NeAmgav7w4SeqSLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0sDN9AQ05yOb9JE2ZSEcizIWdGUAl6/wAKFpbxtP65n1Z2BhJfzZt5bUpvqnmoLbS
	 h8+WyuXmXdHfU6i03qwVd+Co6tibmXg6eaLqqZe0TAOvCqHy3KW0XLFEvm3N+nkBXK
	 rcYExV2G8ve2SI1iYqn/4mWfjvjrrAGxThZcDRm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCCPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfCCPUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:20:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB0120836;
        Sun,  3 Mar 2019 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626419;
        bh=P8PZLEAqkFI/Xl0BkJeC9ZtGZH6NeAmgav7w4SeqSLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a85FqTR7/VDGZ7rLi8CCDVyPznsM1NtWbf+aBh7LnaKzzEgvPag6luZKGQGtlXIfX
         ZgSiuX+cFDiz26MXT2iuB68eK5JB3BVQguMlR3aSlsc5pdMmqw84tEXPgSQo4V+Qc9
         z+beVentRk9Nhk5JTbRIpisrXcvY5FODhas3iPIg=
Date:   Sun, 3 Mar 2019 15:20:10 +0000
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
Subject: Re: [PATCH v2 03/10] iio: accel: bmc150: add mount matrix support
Message-ID: <20190303152010.6d223cba@archlinux>
In-Reply-To: <5d256b403997704072ea5f5889a63adfe67b3a86.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <5d256b403997704072ea5f5889a63adfe67b3a86.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:48 +0100
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
>  drivers/iio/accel/bmc150-accel-core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 383c802eb5b8..b4e2d9b04e1d 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -204,6 +204,7 @@ struct bmc150_accel_data {
>  	int ev_enable_state;
>  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	const struct bmc150_accel_chip_info *chip_info;
> +	struct iio_mount_matrix orientation;
>  };
>  
>  static const struct {
> @@ -796,6 +797,20 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
>  	return sprintf(buf, "%d\n", state);
>  }
>  
> +static const struct iio_mount_matrix *
> +bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan)
> +{
> +	struct bmc150_accel_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_accel_get_mount_matrix),
> +	{ }
> +};
> +
>  static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
>  static IIO_CONST_ATTR(hwfifo_watermark_max,
>  		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
> @@ -978,6 +993,7 @@ static const struct iio_event_spec bmc150_accel_event = {
>  		.shift = 16 - (bits),					\
>  		.endianness = IIO_LE,					\
>  	},								\
> +	.ext_info = bmc150_accel_ext_info,				\
>  	.event_spec = &bmc150_accel_event,				\
>  	.num_event_specs = 1						\
>  }
> @@ -1555,6 +1571,11 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  
>  	data->regmap = regmap;
>  
> +	ret = iio_read_mount_matrix(dev, "mount-matrix",
> +				     &data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	ret = bmc150_accel_chip_init(data);
>  	if (ret < 0)
>  		return ret;

