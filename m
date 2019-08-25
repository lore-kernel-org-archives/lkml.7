Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE27C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82A02082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566756752;
	bh=EtD824PaAHLptZ3Mqnxx5o3/PQthaHEOLGtTclSFP5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zFrcupUDXkwleJP9jWAJqDU4yUZ4TrScK6syqWOETWZw98DKyPq0g6tlybF6BhKjY
	 Vye4VfV0HjXdcNL3yfmq+IRINvD+HM09aQlPUKk5gZSOL0Q9DNdEAxMziJS6QyReqb
	 CfxrljKQfWeSH5i2ub8No4wltFO04pkTl+ilo2Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfHYSMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHYSMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:12:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC0E206E0;
        Sun, 25 Aug 2019 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566756750;
        bh=EtD824PaAHLptZ3Mqnxx5o3/PQthaHEOLGtTclSFP5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGlH4PmvQlEDqDKwpPWIrndl/YRkA1XZYXVoQfntyFsdOG2b+AxEdL8d306w46eor
         tux/kybkHJx0MozpBEYoyCTeQLr2Ii8NMfOyoY8t2BCrxSLSYZ7eoiGIUh4CO5U1P4
         SLjHL2V6qUDoKM2iZrGe5/cNZtG715DhR/7EirTg=
Date:   Sun, 25 Aug 2019 19:12:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: set calibscale for 3d MEMS to unit vector
Message-ID: <20190825191225.3db3587c@archlinux>
In-Reply-To: <20190820051029.118905-1-gwendal@chromium.org>
References: <20190820051029.118905-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 22:10:29 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> By default, set the calibscale vector to unit vector.
> It prevents sending 0 as calibscale when not initialized.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Fix for a real case or paranoia?

If a fix, then fixes tag and preferably which hardware it applies to.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index fd833295bb173..d44ae126f4578 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -90,7 +90,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	u32 ver_mask;
> -	int ret;
> +	int ret, i;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -136,6 +136,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		/* Set sign vector, only used for backward compatibility. */
>  		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>  
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> +
>  		/* 0 is a correct value used to stop the device */
>  		state->frequencies[0] = 0;
>  		if (state->msg->version < 3) {

