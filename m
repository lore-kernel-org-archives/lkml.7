Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60812C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F440208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502189AbfFLQhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:37:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47040 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389150AbfFLQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:37:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C612F285350
Subject: Re: [PATCH] platform/chrome: Expose resume result via sysfs
To:     Evan Green <evgreen@chromium.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
References: <20190607210528.248042-1-evgreen@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <797d3c44-cf30-678d-2622-6bd4a2e89b70@collabora.com>
Date:   Wed, 12 Jun 2019 18:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607210528.248042-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 7/6/19 23:05, Evan Green wrote:
> For ECs that support it, the EC returns the number of slp_s0
> transitions and whether or not there was a timeout in the resume
> response. Expose the last resume result to usermode via sysfs so
> that usermode can detect and report S0ix timeouts.

Looks more for a debugfs attribute instead of sysfs?

I'd prefer have it in debugfs unless you have a good reason. As you probably
know I'm not a big fan of having private interfaces and I'd like to maintain the
minimum needed in sysfs.

> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Enric, I'm not sure if this conflicts with your giant refactoring.
> I can rebase this on your series, but patchwork doesn't have patch
> 2 of your series, so you'd have to point me to a tree.
> 

Probably, but it's fine for now, so don't worry about it. The refactoring still
needs more reviews from other people.

> ---
>  drivers/mfd/cros_ec.c                   |  6 +++++-
>  drivers/platform/chrome/cros_ec_sysfs.c | 17 +++++++++++++++++
>  include/linux/mfd/cros_ec.h             |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index bd2bcdd4718b..64a2d3adc729 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -110,12 +110,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  
>  	/* For now, report failure to transition to S0ix with a warning. */
>  	if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> +	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +		ec_dev->last_resume_result =
> +			buf.u.resp1.resume_response.sleep_transitions;
> +
>  		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
>  			  EC_HOST_RESUME_SLEEP_TIMEOUT,
>  			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
>  			  buf.u.resp1.resume_response.sleep_transitions &
>  			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index 3edb237bf8ed..2deca98c7a7a 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -308,18 +308,35 @@ static ssize_t kb_wake_angle_store(struct device *dev,
>  	return count;
>  }
>  
> +/* Last resume result */
> +static ssize_t last_resume_result_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> +	int ret;
> +
> +	ret = scnprintf(buf,
> +			PAGE_SIZE,
> +			"0x%x\n",
> +			ec->ec_dev->last_resume_result);
> +
> +	return ret;
> +}
> +
>  /* Module initialization */
>  
>  static DEVICE_ATTR_RW(reboot);
>  static DEVICE_ATTR_RO(version);
>  static DEVICE_ATTR_RO(flashinfo);
>  static DEVICE_ATTR_RW(kb_wake_angle);
> +static DEVICE_ATTR_RO(last_resume_result);
>  

The attribute should be documented in

Documentation/ABI/testing/sysfs-class-chromeos

or

Documentation/ABI/testing/debugfs-cros-ec ; yes I know this file does not exist,
but we should add it :-)


>  static struct attribute *__ec_attrs[] = {
>  	&dev_attr_kb_wake_angle.attr,
>  	&dev_attr_reboot.attr,
>  	&dev_attr_version.attr,
>  	&dev_attr_flashinfo.attr,
> +	&dev_attr_last_resume_result.attr,
>  	NULL,
>  };
>  
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index cfa78bb4990f..d50ade418a83 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -163,6 +163,7 @@ struct cros_ec_device {
>  	struct ec_response_get_next_event_v1 event_data;
>  	int event_size;
>  	u32 host_event_wake_mask;
> +	u32 last_resume_result;
>  };
>  
>  /**
> 
