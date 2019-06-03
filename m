Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B92C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CEB24E8A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HneNI4Cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfFCMzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:55:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50285 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFCMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:55:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so7076074wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2CmoCBy7i9ln8u3VDjIynmL/vFP2+HZt6bXh5Y1ubgY=;
        b=HneNI4CrWx3O7cwpxDYx43tFQOd9J93CC1U0Hlpgua0VMZXWa3tQELLt3Bayv5Yw5M
         JYUoVLvwNHKAxQYvf6KWnkg3uvALSR9JwEHBInExu73i1TByTPqQgsnAWTUoggddyY1Z
         xYPMSyoUV6tn1x+Lm/Io04UzCWsT/g/zTRu5c0AJz3CUbQQxBZu4/vLJm/GB7ME0pgKK
         Zw0ua2qe5kele0QlGr1D4QIPfpmzqTc/B/GppMlNRWcNB1eKNSKbZR/1ZXrH0e44DxNI
         sNA28CJ/RRyZQrj0zeie/uD9fUVzZPOUPEX+b4Cu6E/UPgRbRrqAW5fNt47W4H4IeD8U
         ZjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2CmoCBy7i9ln8u3VDjIynmL/vFP2+HZt6bXh5Y1ubgY=;
        b=bxrBPJZfi2AlAXPu8rwJACGnd8sXTTXGC0mgZ8nqXiugQmTx7cIbwgrsLV4put5dIh
         /I2xo0Y2QqtyaRFNyX9/hRG6nFZkFN0DFjApM7bDadBn6iSw+BOE1nv9jUTGGbzv2qzC
         R6SoZPWOqAbD9kpYhkEqb6CDcP2i1Ii630w3PKHpJnw/T1O1g1my1+XEhaV7Q8nQmNgg
         Qa6gX7xKUfSMLMEJ7xYA3poFG8w1x1fXs54KVdrIRPJi4QcVUdE41Q8x7zWtFJuWiJmB
         NOmqTG1KiWLL9tZotBCVcrhQ/rZThl5sctiKfuEG7Sneav7syuosEuDizTzt2JnBSqj2
         xDfg==
X-Gm-Message-State: APjAAAWrdpFe1l3/1vUSJB19ikcbH2bUoWINNcZOSOJKXxeYbKlXYBHl
        wIRFARgmsY15pLxbKshoFLkLgze0/T0=
X-Google-Smtp-Source: APXvYqzeymALbUYrWb6Ozdc/6+knTdJjvHpWSccfOj1UDCrUxIoYuDg7dna8XRZjfc+bhddnH3G7wQ==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr2336053wmi.15.1559566511905;
        Mon, 03 Jun 2019 05:55:11 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y9sm3981550wma.1.2019.06.03.05.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:55:11 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:55:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: cros_ec_sensors: support protocol v3
 message
Message-ID: <20190603125509.GV4797@dell>
References: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Fabien Lahoudere wrote:

> Version 3 of the EC protocol provides min and max frequencies and fifo
> size for EC sensors.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 98 ++++++++++++++++++-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++
>  include/linux/mfd/cros_ec_commands.h          | 21 ++++

Please note that we are about to add a pretty bit update for this
file.  Once it's complete you may wish to rebase in order to avoid
any possible merge conflicts.

>  3 files changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..d5c8b4714ad6 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -19,12 +19,84 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  
> +/*
> + * Hard coded to the first device to support sensor fifo.  The EC has a 2048
> + * byte fifo and will trigger an interrupt when fifo is 2/3 full.
> + */
> +#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
> +
>  static char *cros_ec_loc[] = {
>  	[MOTIONSENSE_LOC_BASE] = "base",
>  	[MOTIONSENSE_LOC_LID] = "lid",
>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>  };
>  
> +static void get_default_min_max_freq_and_fifo_size(enum motionsensor_type type,
> +						   u32 *min_freq,
> +						   u32 *max_freq,
> +						   u32 *max_fifo_events)
> +{
> +	/* we don't know fifo size, set to size previously used by sensor HAL */
> +	*max_fifo_events = CROS_EC_FIFO_SIZE;
> +
> +	switch (type) {
> +	case MOTIONSENSE_TYPE_ACCEL:
> +	case MOTIONSENSE_TYPE_GYRO:
> +		*min_freq = 12500;
> +		*max_freq = 100000;
> +		break;
> +	case MOTIONSENSE_TYPE_MAG:
> +		*min_freq = 5000;
> +		*max_freq = 25000;
> +		break;
> +	case MOTIONSENSE_TYPE_PROX:
> +	case MOTIONSENSE_TYPE_LIGHT:
> +		*min_freq = 100;
> +		*max_freq = 50000;
> +		break;
> +	case MOTIONSENSE_TYPE_BARO:
> +		*min_freq = 250;
> +		*max_freq = 20000;
> +		break;
> +	case MOTIONSENSE_TYPE_ACTIVITY:
> +	default:
> +		*max_fifo_events = 0;
> +		*min_freq = 0;
> +		*max_freq = 0;
> +		break;
> +	}
> +}
> +
> +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> +					     u16 cmd_offset, u16 cmd, u32 *mask)
> +{
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_get_cmd_versions params;
> +			struct ec_response_get_cmd_versions resp;
> +		};
> +	} __packed buf;
> +	struct ec_params_get_cmd_versions *params = &buf.params;
> +	struct ec_response_get_cmd_versions *resp = &buf.resp;
> +	struct cros_ec_command *msg = &buf.msg;
> +	int ret;
> +
> +	memset(&buf, 0, sizeof(buf));
> +	msg->command = EC_CMD_GET_CMD_VERSIONS + cmd_offset;
> +	msg->insize = sizeof(*resp);
> +	msg->outsize = sizeof(*params);
> +	params->cmd = cmd;
> +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +	if (ret >= 0) {
> +		if (msg->result == EC_RES_SUCCESS)
> +			*mask = resp->version_mask;
> +		else
> +			*mask = 0;
> +	}
> +	return ret;
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -33,6 +105,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	u32 ver_mask;
> +	int ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -47,8 +121,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  
>  	mutex_init(&state->cmd_lock);
>  
> +	/* determine what version of MOTIONSENSE CMD EC has */
> +	ret = cros_ec_get_host_cmd_version_mask(state->ec,
> +						ec->cmd_offset,
> +						EC_CMD_MOTION_SENSE_CMD,
> +						&ver_mask);
> +	if (ret < 0 || ver_mask == 0)
> +		return -ENODEV;
> +
>  	/* Set up the host command structure. */
> -	state->msg->version = 2;
> +	state->msg->version = fls(ver_mask) - 1;
>  	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  	state->msg->outsize = sizeof(struct ec_params_motion_sense);
>  
> @@ -66,6 +148,20 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  		state->type = state->resp->info.type;
>  		state->loc = state->resp->info.location;
> +		if (state->msg->version < 3) {
> +			get_default_min_max_freq_and_fifo_size(
> +					state->resp->info.type,
> +					&state->min_freq,
> +					&state->max_freq,
> +					&state->fifo_max_event_count);
> +		} else {
> +			state->min_freq =
> +				state->resp->info_3.min_frequency;
> +			state->max_freq =
> +				state->resp->info_3.max_frequency;
> +			state->fifo_max_event_count =
> +				state->resp->info_3.fifo_max_event_count;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index ce16445411ac..4742a9637a85 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -78,6 +78,13 @@ struct cros_ec_sensors_core_state {
>  				    unsigned long scan_mask, s16 *data);
>  
>  	int curr_sampl_freq;
> +
> +	/* Min and Max Sampling Frequency in mHz */
> +	u32 min_freq;
> +	u32 max_freq;
> +
> +	/* event fifo size represented in number of events */
> +	u32 fifo_max_event_count;
>  };
>  
>  /**
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index dcec96f01879..27d71cbf22f1 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1744,6 +1744,27 @@ struct ec_response_motion_sense {
>  			uint8_t chip;
>  		} info;
>  
> +		/* Used for MOTIONSENSE_CMD_INFO version 3 */
> +		struct __ec_todo_unpacked {
> +			/* Should be element of enum motionsensor_type. */
> +			uint8_t type;
> +
> +			/* Should be element of enum motionsensor_location. */
> +			uint8_t location;
> +
> +			/* Should be element of enum motionsensor_chip. */
> +			uint8_t chip;
> +
> +			/* Minimum sensor sampling frequency */
> +			uint32_t min_frequency;
> +
> +			/* Maximum sensor sampling frequency */
> +			uint32_t max_frequency;
> +
> +			/* Max number of sensor events that could be in fifo */
> +			uint32_t fifo_max_event_count;
> +		} info_3;
> +
>  		/* Used for MOTIONSENSE_CMD_DATA */
>  		struct ec_response_motion_sensor_data data;
>  

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
