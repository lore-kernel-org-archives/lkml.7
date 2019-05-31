Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE84C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930625D30
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfEaIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:54:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38170 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:54:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B24FC261179
Subject: Re: [PATCH v9 6/7] mfd: cros_ec: differentiate SCP from EC by feature
 bit.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20190531073848.155444-1-pihsun@chromium.org>
 <20190531073848.155444-7-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6a6819ab-f6f6-616c-7d07-a94dddbe1262@collabora.com>
Date:   Fri, 31 May 2019 10:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531073848.155444-7-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/5/19 9:38, Pi-Hsun Shih wrote:
> System Companion Processor (SCP) is Cortex M4 co-processor on some
> MediaTek platform that can run EC-style firmware. Since a SCP and EC
> would both exist on a system, and use the cros_ec_dev driver, we need to
> differentiate between them for the userspace, or they would both be
> registered at /dev/cros_ec, causing a conflict.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

I think I already did, but anyway,

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> 
> ---
> Changes from v8:
>  - No change.
> 
> Changes from v7:
>  - Address comments in v7.
>  - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196/.
> 
> Changes from v6, v5, v4, v3, v2:
>  - No change.
> 
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index a5391f96eafd..66107de3dbce 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -440,6 +440,16 @@ static int ec_device_probe(struct platform_device *pdev)
>  		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
>  	}
>  
> +	/* Check whether this is actually a SCP rather than an EC. */
> +	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
> +		dev_info(dev, "CrOS SCP MCU detected.\n");
> +		/*
> +		 * Help userspace differentiating ECs from SCP,
> +		 * regardless of the probing order.
> +		 */
> +		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
> +	}
> +
>  	/*
>  	 * Add the class device
>  	 * Link to the character device for creating the /dev entry
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index cfa78bb4990f..751cb3756d49 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -27,6 +27,7 @@
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
>  #define CROS_EC_DEV_TP_NAME "cros_tp"
>  #define CROS_EC_DEV_ISH_NAME "cros_ish"
> +#define CROS_EC_DEV_SCP_NAME "cros_scp"
>  
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index dcec96f01879..8b578b4c1ec7 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -884,7 +884,7 @@ enum ec_feature_code {
>  	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
>  	/* EC supports audio codec. */
>  	EC_FEATURE_AUDIO_CODEC = 38,
> -	/* EC Supports SCP. */
> +	/* The MCU is a System Companion Processor (SCP). */

This change is already done on the Gwendal's efforts to sync the commands file,
to avoid more mess here, please remove that change and resend the patchset
without touching the cros_ec_commands.h file.

[1] https://lore.kernel.org/lkml/20190518063949.GY4319@dell/T/

Thanks,
 Enric

>  	EC_FEATURE_SCP = 39,
>  	/* The MCU is an Integrated Sensor Hub */
>  	EC_FEATURE_ISH = 40,
> 
