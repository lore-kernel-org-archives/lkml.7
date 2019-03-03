Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB33FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9937520866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626545;
	bh=cK/Ztr+6g037EKehlRtErEgNYsRIX2/hzzmcuemWVq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hBHuiL0IWSRkQLtBb1FEu+4+sT3+++RFw7brf2tZzvgSClZsY5RRnLSMZyuVf5bHH
	 NqeELA+D/IFlkpaWOzIV4S4JnyfeiY2sRPSRya+ck0lcmq8hwojOVYYhtdQiADB7xL
	 9F8IAERAjRXFpkebcw1XLiQtsUzT+Vg+bFXXTqRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCCPWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfCCPWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:22:24 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F8CC20836;
        Sun,  3 Mar 2019 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626543;
        bh=cK/Ztr+6g037EKehlRtErEgNYsRIX2/hzzmcuemWVq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LuXSb6M1OXVF1xpECnS8eXX8w0NbZ1u0KlqXIG5lzA9REILIsV4ZgCz+EVTXAJ442
         Fn582ENt1BGNEvyBUfYtn5UTauwfoiNGtqWRwn6cnu+xJf7tDo8RgX9QF+DpCGKGcd
         axoySEtQhGAu/NNNgjDtzas9dONF+dEtA5MfH6sA=
Date:   Sun, 3 Mar 2019 15:22:15 +0000
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
Subject: Re: [PATCH v2 06/10] iio: gyro: itg3200: add mount matrix support
Message-ID: <20190303152215.52b0504c@archlinux>
In-Reply-To: <ad1f1af237439dcf2a0769280f9e7b1806d484f2.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <ad1f1af237439dcf2a0769280f9e7b1806d484f2.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:51 +0100
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
>  drivers/iio/gyro/itg3200_core.c  | 20 ++++++++++++++++++++
>  include/linux/iio/gyro/itg3200.h |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> index 7adecb562c81..203a6be33b70 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -242,6 +242,20 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static const struct iio_mount_matrix *
> +itg3200_get_mount_matrix(const struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan)
> +{
> +	struct itg3200 *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info itg3200_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, itg3200_get_mount_matrix),
> +	{ }
> +};
> +
>  #define ITG3200_ST						\
>  	{ .sign = 's', .realbits = 16, .storagebits = 16, .endianness = IIO_BE }
>  
> @@ -255,6 +269,7 @@ static int itg3200_initial_setup(struct iio_dev *indio_dev)
>  	.address = ITG3200_REG_GYRO_ ## _mod ## OUT_H, \
>  	.scan_index = ITG3200_SCAN_GYRO_ ## _mod, \
>  	.scan_type = ITG3200_ST, \
> +	.ext_info = itg3200_ext_info, \
>  }
>  
>  static const struct iio_chan_spec itg3200_channels[] = {
> @@ -297,6 +312,11 @@ static int itg3200_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
> +				&st->orientation);
> +	if (ret)
> +		return ret;
> +
>  	i2c_set_clientdata(client, indio_dev);
>  	st->i2c = client;
>  
> diff --git a/include/linux/iio/gyro/itg3200.h b/include/linux/iio/gyro/itg3200.h
> index 2a820850f284..0a30fddccfb3 100644
> --- a/include/linux/iio/gyro/itg3200.h
> +++ b/include/linux/iio/gyro/itg3200.h
> @@ -104,6 +104,7 @@
>  struct itg3200 {
>  	struct i2c_client	*i2c;
>  	struct iio_trigger	*trig;
> +	struct iio_mount_matrix orientation;
>  };
>  
>  enum ITG3200_SCAN_INDEX {

