Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A79C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01DE20828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563732097;
	bh=A9747IEEtjblJxW9GlvYUOKRVFleQqFB4PCyVdiiLco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SzN6fLArIGFM3FU2yXnPshpr9+LS+ockIhxVCHjRbBdkz9n1xjk0Y5g4YPKW2uk6m
	 mhiH/hdxNeuLFkeJ+xGXaJxRfO4U+H+QD1MK/FoilIfIUIVQz64UPiFvL4RkdQUGv8
	 v98k34D2afSE7BzIBqdmKgXaYswFociEIMikN7Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGUSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2683D208E4;
        Sun, 21 Jul 2019 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732095;
        bh=A9747IEEtjblJxW9GlvYUOKRVFleQqFB4PCyVdiiLco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAYq6DvE3IMW1jUdSmXXr+roQNjoDEJLWqhD3LHkJ4kb8NK8UqV7aheSn6eIIiVRh
         ErIXBt/hPn7j8TR99ycFMwHbewxDpYTkA9o8fbs1AFiFVtG4XHjdDHqddJTasbIqSm
         l9xEzLiiQPF8GdEjos6ZoGiIwfODOM5v8OfDqYC8=
Date:   Sun, 14 Jul 2019 17:32:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: cros_ec: Add sign vector in core for
 backward compatibility
Message-ID: <20190714173203.0b50d5c7@archlinux>
In-Reply-To: <20190628191711.23584-2-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
        <20190628191711.23584-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 12:17:08 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
> 
> Check the data is not rotated on recent chromebooks that use the HTML5
> standard to present sensor data.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As I mentioned in one of the other series.  I've lost track of whether
anyone wants me to apply any of these through IIO, so will just ack
them as appropriate and assume someone will shout if they do want
me to pick them up ;)

Thanks,

Jonathan

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..e8a4d78659c8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  		state->type = state->resp->info.type;
>  		state->loc = state->resp->info.location;
> +
> +		/* Set sign vector, only used for backward compatibility. */
> +		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>  	}
>  
>  	return 0;
> @@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> +		*data *= st->sign[i];
>  		data++;
>  	}
>  
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index ce16445411ac..a1c85ad4df91 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
>  	enum motionsensor_location loc;
>  
>  	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> +	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
>  
>  	u8 samples[CROS_EC_SAMPLE_SIZE];
>  

