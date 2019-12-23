Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3442A206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfLWHZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:25:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56688 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:25:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 45ED1283E6C
Subject: Re: [PATCH v4 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20191220193843.47182-1-pmalani@chromium.org>
 <20191220193843.47182-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7eecafb2-4686-b448-2837-4181188365b1@collabora.com>
Date:   Mon, 23 Dec 2019 08:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220193843.47182-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 20/12/19 20:38, Prashant Malani wrote:
> Add the cros-usbpd-notify driver as a subdevice on non-ACPI platforms
> that support the EC_FEATURE_USB_PD EC feature flag.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
> 
>  drivers/mfd/cros_ec_dev.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index c4b977a5dd966..da198abe2b0a6 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
>  
> +#include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
> @@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-logger", },
>  };
>  
> +static const struct mfd_cell cros_usbpd_notify_cells[] = {
> +	{ .name = "cros-usbpd-notify", },
> +};
> +
>  static const struct cros_feature_to_cells cros_subdevices[] = {
>  	{
>  		.id		= EC_FEATURE_CEC,
> @@ -202,6 +207,22 @@ static int ec_device_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * The PD notifier driver cell is separate since it only needs to be
> +	 * explicitly added on non-ACPI platforms.


Sorry to not catch this before, but a worry arose. Is non-ACPI platforms or
non-X86 platforms or on OF platforms?

ARM64 for example has the CONFIG_ACPI symbol set to yes, with the below
condition condition will not work on Kevin for example and IIUC this is not what
we want, I think we want IS_ENABLED(CONFIG_OF)?

Thanks,
 Enric

> +	 */
> +	if (!IS_ENABLED(CONFIG_ACPI)) {
> +		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> +			retval = mfd_add_hotplug_devices(ec->dev,
> +					cros_usbpd_notify_cells,
> +					ARRAY_SIZE(cros_usbpd_notify_cells));
> +			if (retval)
> +				dev_err(ec->dev,
> +					"failed to add PD notify devices: %d\n",
> +					retval);
> +		}
> +	}
> +
>  	/*
>  	 * The following subdevices cannot be detected by sending the
>  	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
> 
