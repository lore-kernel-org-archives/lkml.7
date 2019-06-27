Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D2BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FD208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF0P7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:59:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47114 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0P7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:59:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8A4A0285135
Subject: Re: [PATCH 1/2] iio: common: cros_ec_sensors: determine protocol
 version
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>
References: <cover.1561642224.git.fabien.lahoudere@collabora.com>
 <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f8df78b4-8ae9-f292-cf70-ef682a4a47f4@collabora.com>
Date:   Thu, 27 Jun 2019 17:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <4724b46665d919cae0ea3b60e334053b0b17d686.1561642224.git.fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cc'ing Doug, Gwendal and Enrico that might be interested to give a review.

This patch can be picked alone without 2/2, an is needed to have cros-ec-sensors
legacy support on ARM (see [1] and [2])

Jonathan, as [1] and [2] will go through the chrome-platform tree if you don't
mind I'd also like to carry with this patch once you're fine with it.

Thanks,
~ Enric

[1] https://patchwork.kernel.org/patch/11014329/
[2] https://patchwork.kernel.org/patch/11014327/

On 27/6/19 16:04, Fabien Lahoudere wrote:
> This patch adds a function to determine which version of the
> protocol is used to communicate with EC.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 130362ca421b..2e0f97448e64 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>  };
>  
> +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> +					     u16 cmd_offset, u16 cmd, u32 *mask)
> +{
> +	int ret;
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_get_cmd_versions params;
> +			struct ec_response_get_cmd_versions resp;
> +		};
> +	} __packed buf = {
> +		.msg = {
> +			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> +			.insize = sizeof(struct ec_response_get_cmd_versions),
> +			.outsize = sizeof(struct ec_params_get_cmd_versions)
> +			},
> +		.params = {.cmd = cmd}
> +	};
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +	if (ret >= 0)
> +		*mask = buf.resp.version_mask;
> +	return ret;
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	u32 ver_mask;
> +	int ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  
>  	mutex_init(&state->cmd_lock);
>  
> +	ret = cros_ec_get_host_cmd_version_mask(state->ec,
> +						ec->cmd_offset,
> +						EC_CMD_MOTION_SENSE_CMD,
> +						&ver_mask);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Set up the host command structure. */
> -	state->msg->version = 2;
> +	state->msg->version = fls(ver_mask) - 1;;
>  	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  	state->msg->outsize = sizeof(struct ec_params_motion_sense);
>  
> 
