Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BEC4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCD520857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551627042;
	bh=IsqtGwrYku6pC1vL41Ziwj9ch2d4QaqpQ+uaEM0NEew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kSNlafkvtxH/4tz8nhqp3Wr1EnG8r98JwrGt/6ba3NJHi4H4t/c+TTZPo66spEUIi
	 6bkAzV85jFIzK3AW4CclwOT9VbBAby+ok73YFKcA8O0fBJX5GP4MbdrVOmfbBAH/+A
	 0pP8/8W9qE9QcCJnMtLI+h5PN34RjkyYMgBduP9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfCCPal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:30:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46DB720835;
        Sun,  3 Mar 2019 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551627040;
        bh=IsqtGwrYku6pC1vL41Ziwj9ch2d4QaqpQ+uaEM0NEew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BweXhYQEPqbuxsST1CTSJSiuajIcfjcxZW0LJJdvmprWtTHELlLaNUWy/CRoxSAep
         H67puDT6xfTVGbAkUGtBQj4o1OGyhooX/NWE6hjOFNmVY9f6q9PmEFK2VhitpXVwx1
         B8zSPp8WTqbXuij8GA0TDItVjFgYe8UKRSpi4Hps=
Date:   Sun, 3 Mar 2019 15:30:32 +0000
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
Subject: Re: [PATCH v2 10/10] iio: ak8975: improve code readability
Message-ID: <20190303153032.580537fe@archlinux>
In-Reply-To: <8a4498a761bf63e38c16f17d437715be0399a957.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <8a4498a761bf63e38c16f17d437715be0399a957.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:55 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> - use temporary variable in get_mount_matrix()
> - remove , after { }
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index db7214ac514c..43d08c089792 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -746,12 +746,14 @@ static const struct iio_mount_matrix *
>  ak8975_get_mount_matrix(const struct iio_dev *indio_dev,
>  			const struct iio_chan_spec *chan)
>  {
> -	return &((struct ak8975_data *)iio_priv(indio_dev))->orientation;
> +	struct ak8975_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
>  }
>  
>  static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, ak8975_get_mount_matrix),
> -	{ },
> +	{ }
>  };
>  
>  #define AK8975_CHANNEL(axis, index)					\
> @@ -792,7 +794,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
>  	{"AK09911", AK09911},
>  	{"AKM9911", AK09911},
>  	{"AK09912", AK09912},
> -	{ },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
>  #endif

