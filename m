Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87099C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537E020C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556370866;
	bh=vV+980+kvm2sz+Ua30f5pPfe5BH81qRAUM33WJ54q68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=q83RZhtlSocHBpXklrvi/8LfifgNEfRILnIC4BuCqKc4kORUWEOGehRqQufFGpxny
	 tAaSQOIzrMWEciZuhRda7fi0okji7iIG72R+p2STR7tfzpPytAJrnAh1x3MVganV6b
	 DhDynroiSwsaxQM/cK7n9nWsBMcboPyOOoKHx5hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfD0NOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0NOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:14:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26973208C2;
        Sat, 27 Apr 2019 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556370863;
        bh=vV+980+kvm2sz+Ua30f5pPfe5BH81qRAUM33WJ54q68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0tcA2UTEizBEhYtjXgDRxzBgGh2sG2FXaLVtHtH+pcJX+pJXKyPGiwq+8Huy9rM4x
         a4ngdn4akCGN0nzUCzLxby3Z1MMwo+eKv2Nzej22ALMsaFUqosnwfTm4P/nPFz5qKR
         hKSOkJcWqRWs+cQfXyVbun4e7g2Fh226OoXjV93M=
Date:   Sat, 27 Apr 2019 14:14:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: cros_ec: add 'id' sysfs entry
Message-ID: <20190427141351.633ede62@archlinux>
In-Reply-To: <20190426113917.10282-1-fabien.lahoudere@collabora.com>
References: <20190426113917.10282-1-fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 13:39:16 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> This new sysfs entry is used to interpret ring buffer information,
> mainly by Android sensor HAL.
> It expand to all sensors, the documentation about 'id' we can found
> in Documentation/ABI/testing/sysfs-bus-iio-cros-ec.
> 
> Also fix typo in docs, I replace 'Septembre' by 'September'.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Hmm. I'm not 100% keen on non standard ABI like this, but given
we already have it for one type of cros_ec, I guess the other one can
have it as well.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Note this has probably just missed the coming merge window unless that
is delayed for some reason.

Thanks,


Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-cros-ec    | 10 +++++-----
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> index 0e95c2ca105c..6158f831c761 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> @@ -18,11 +18,11 @@ Description:
>  		values are 'base' and 'lid'.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/id
> -Date:		Septembre 2017
> +Date:		September 2017
>  KernelVersion:	4.14
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		This attribute is exposed by the CrOS EC legacy accelerometer
> -		driver and represents the sensor ID as exposed by the EC. This
> -		ID is used by the Android sensor service hardware abstraction
> -		layer (sensor HAL) through the Android container on ChromeOS.
> +		This attribute is exposed by the CrOS EC sensors driver and
> +		represents the sensor ID as exposed by the EC. This ID is used
> +		by the Android sensor service hardware abstraction layer (sensor
> +		HAL) through the Android container on ChromeOS.
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..130362ca421b 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -125,6 +125,15 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
>  	return ret ? ret : len;
>  }
>  
> +static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
> +				  uintptr_t private,
> +				  const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
> +}
> +
>  static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
>  		uintptr_t private, const struct iio_chan_spec *chan,
>  		char *buf)
> @@ -140,6 +149,11 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
>  		.shared = IIO_SHARED_BY_ALL,
>  		.write = cros_ec_sensors_calibrate
>  	},
> +	{
> +		.name = "id",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = cros_ec_sensors_id
> +	},
>  	{
>  		.name = "location",
>  		.shared = IIO_SHARED_BY_ALL,

