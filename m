Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B921915
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752580;
	bh=Zc4SqyReZQ3yC/MgkmAT5ayeKcQu7ECUFOznH+JBan4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S9tLmGMlkVvJKbj5uWiVEeLLt1h/KNw4Q9PgDpC8xEFGXPcsGoSOY2vhfu6ZseX2f
	 RY0n1MKZmtmm18uqvbKTHnJ4GcgX0webgAHCQtujK2rgYZlmSHaS5kvMPuytcB1y8X
	 b/3URrzq4kvXH/F/liccWk5HDWop3qsB7ln6DFeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCPQJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:09:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C8F21900;
        Sat, 16 Mar 2019 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752578;
        bh=Zc4SqyReZQ3yC/MgkmAT5ayeKcQu7ECUFOznH+JBan4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHLBA0D4ROfYbvxVYieYMUytVGqNAryjOUF9zc0ol0jYIIEvStXA2gdIeMUHqYIqo
         opSjqeLclxCGr1hqPqeLt1M9fOjr78JGDSaLVWTr+0tDr3x7nX39/SSzLWgWt2cKXJ
         TmuSL9pEDRqK8u64s6qqDRDsVWvW4iA2GBdmaX24=
Date:   Sat, 16 Mar 2019 16:09:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the maths for gyro scale
 calculation
Message-ID: <20190316160932.102fc659@archlinux>
In-Reply-To: <20190313114002.11236-1-enric.balletbo@collabora.com>
References: <20190313114002.11236-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 12:40:02 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> Calculation did not use IIO_DEGREE_TO_RAD and implemented a variant to
> avoid precision loss as we aim a nano value. The offset added to avoid
> rounding error, though, doesn't give us a close result to the expected
> value. E.g.
> 
> For 1000dps, the result should be:
> 
>     (1000 * pi ) / 180 >> 15 ~= 0.000532632218
> 
> But with current calculation we get
> 
>     $ cat scale
>     0.000547890
> 
> Fix the calculation by just doing the maths involved for a nano value
> 
>    val * pi * 10e12 / (180 * 2^15)
> 
> so we get a closer result.
> 
>     $ cat scale
>     0.000532632
> 
> Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> 
> Changes in v3:
> - Fix 'warning: this decimal constant is unsigned only in ISO C90' spotted by kbuild test robot.
> 
> Changes in v2:
> - Do the maths instead of play with dividers as pointed by Jonathan.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 89cb0066a6e0..8d76afb87d87 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -103,9 +103,10 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
>  			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
>  			 * loss. Round to the nearest integer.
>  			 */
> -			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
> -			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
> -			ret = IIO_VAL_FRACTIONAL;
> +			*val = 0;
> +			*val2 = div_s64(val64 * 3141592653ULL,
> +					180 << (CROS_EC_SENSOR_BITS - 1));
> +			ret = IIO_VAL_INT_PLUS_NANO;
>  			break;
>  		case MOTIONSENSE_TYPE_MAG:
>  			/*

