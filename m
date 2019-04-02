Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50096C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156EC20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkcqT6AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDBDqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:46:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43545 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBDqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:46:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so5811659pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qqq1z9eh+IopwWGoPO815E7iXUuR7R0b2TGX5uUn1IU=;
        b=YkcqT6AER6SBCZT++NvZjBQNpWBRQc+25daIOG4TF8Thxxt9r6sYz+Kec2069aOwdI
         ipsSHVmvpnJbMb7a8Aa9tAsyKGL+aGEiNw21NSxFUub0Q3BRNi2zI/Hh2p8e7jwtU3eA
         wtfPV+KufDytjyMrgjSLCQBC8J9jMubP8tGkW20gIJ9K+uk9byIQI9bJeF8rtp91VUkS
         mLmg07qSqhbglWbr7Y1Av6/p1CFqKZIcuhv1p8z8lPIPCaZHFgLfm2YqWYlTZPYdxlb5
         RIhuJXcAonGUlIjj+ZmrmlKlzSHD6KT6y3ZSVBVVZr0mVZ8MzLOC0GORSyiVYUhAe0Wu
         ardQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qqq1z9eh+IopwWGoPO815E7iXUuR7R0b2TGX5uUn1IU=;
        b=H/9u8z3jmepASdiErCkvL60P8ZLF6bXWZnmhBqbkj+Qp6NrQoKHCNTxfS8ZMuMy51u
         DeOX4mVspwY1diPOJvAg57mISN9R4ImSNAmIjHCcCnqTvHySzF3HQYD9Lq7GZQMM+h8N
         b21Nzvu88e9RExqOWbPZOODZkl47igOXzxkraED6zzuzRp42bH+T2BDmPzxdAm7q5Mcf
         Ecamuy1UM20jr6aqUGxBi+2yo0Dmx2e60jCQILTrL9kfU1bcrbjljiPn8hcH12N9N8ar
         bAktO1B6X9Ea/QDhCoDMSCmsTRo0pa/mzepIfZlz7UPRZNECosBREUGxhkMjBryKI/5o
         Z7VQ==
X-Gm-Message-State: APjAAAWTiV3ul/+uRO+MVj+/b+dKctZxz46KDObbwJRX1OUdrjIYO8/h
        LH4foHYNHYywfY4xDDzD23n4lQ==
X-Google-Smtp-Source: APXvYqwJiR8VkM+3Kl0dqaDNOB+j3XCXGn0EjOigLCbF7esVrkkt9evzkpX9JkxBTnlWSebNOFc8JQ==
X-Received: by 2002:a62:1f92:: with SMTP id l18mr25169550pfj.180.1554176775654;
        Mon, 01 Apr 2019 20:46:15 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id 17sm16988009pfw.65.2019.04.01.20.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 20:46:14 -0700 (PDT)
Date:   Tue, 2 Apr 2019 04:46:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     andy.shevchenko@gmail.com, groeck@chromium.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice
Message-ID: <20190402034610.GG4187@dell>
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228013541.76792-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Gwendal Grignou wrote:

> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> With this patch, the cros_ec_ctl driver will register the legacy
> accelerometer driver (named cros_ec_accel_legacy) if it fails to
> register sensors through the usual path cros_ec_sensors_register().
> This legacy device is present on Chromebook devices with older EC
> firmware only supporting deprecated EC commands (Glimmer based devices).
> 
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes in v5:
> - Remove unnecessary white lines.
> 
> Changes in v4:
> - [5/8] Nit: EC -> ECs (Lee Jones)
> - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> 
> Changes in v3:
> - [5/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [5/8] Add the Reviewed-by Gwendal.
> 
>  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d275deaecb12..64567bd0a081 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static struct cros_ec_sensor_platform sensor_platforms[] = {
> +	{ .sensor_num = 0 },
> +	{ .sensor_num = 1 }
> +};

I'm still very uncomfortable with this struct.

Other than these indices, the sensors have no other distinguishing
features, thus there should be no need to identify or distinguish
between them in this way.

> +static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
> +	{
> +		.name = "cros-ec-accel-legacy",
> +		.id = 0,
> +		.platform_data = &sensor_platforms[0],
> +		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> +	},
> +	{
> +		.name = "cros-ec-accel-legacy",
> +		.id = 1,
> +		.platform_data = &sensor_platforms[1],
> +		.pdata_size = sizeof(struct cros_ec_sensor_platform),
> +	}
> +};
> +
> +static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
> +{
> +	struct cros_ec_device *ec_dev = ec->ec_dev;
> +	u8 status;
> +	int ret;
> +
> +	/*
> +	 * ECs that need legacy support are the main EC, directly connected to
> +	 * the AP.
> +	 */
> +	if (ec->cmd_offset != 0)
> +		return;
> +
> +	/*
> +	 * Check if EC supports direct memory reads and if EC has
> +	 * accelerometers.
> +	 */
> +	if (!ec_dev->cmd_readmem)
> +		return;
> +
> +	ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &status);
> +	if (ret < 0) {
> +		dev_warn(ec->dev, "EC does not support direct reads.\n");
> +		return;
> +	}
> +
> +	/* Check if EC has accelerometers. */
> +	if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> +		dev_info(ec->dev, "EC does not have accelerometers.\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Register 2 accelerometers
> +	 */
> +	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,

Using PLATFORM_DEVID_AUTO whilst providing the MFD cells with IDs
doesn't make any sense.  Please remove the IDs from the cells.

> +			      cros_ec_accel_legacy_cells,
> +			      ARRAY_SIZE(cros_ec_accel_legacy_cells),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec_dev->dev, "failed to add EC sensors\n");
> +}
> +
>  static const struct mfd_cell cros_ec_cec_cells[] = {
>  	{ .name = "cros-ec-cec" }
>  };
> @@ -437,6 +500,9 @@ static int ec_device_probe(struct platform_device *pdev)
>  	/* check whether this EC is a sensor hub. */
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
> +	else
> +		/* Workaroud for older EC firmware */
> +		cros_ec_accel_legacy_register(ec);
>  
>  	/* Check whether this EC instance has CEC host command support */
>  	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
