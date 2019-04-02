Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD7C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B964B2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZoDNKZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDBUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:55:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34399 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:55:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so6874391plt.1;
        Tue, 02 Apr 2019 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wa+TazzRZPCxNnfkVDZaVf56vuzv/8oX1Y5vizRTAkI=;
        b=dZoDNKZcmlqjvJdEFCYTUVqUPUZyJdcg5GJ7CwTjf+qVmqJTLItdWBg59qYXBRaT8u
         2m65bdFKnO4KfTQ11/c5iHAssfxqch1eO2SIdrHs2Sne0m/CXDHxYUZ6xfzEZQraZmEh
         3RAkm+EgMw8shwTQPOdTzkb43dILj6jRB5mxWRc84JnOTpvz1d6FkDf1e2j8u5o6oTPi
         DCn9dCHACcimgcX7SdqQk2PkCMbgXAlt9TSO/yGOvnaVkHCVjD3pa6+dyxxLj3Q3hYSe
         dbAz5sI8KZaybLCxnZmleTkCDdEbMH0xtQbex7LYriNWTSvB3+VoviB/TkLwwF40N135
         POfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wa+TazzRZPCxNnfkVDZaVf56vuzv/8oX1Y5vizRTAkI=;
        b=F0wMnPPrgroC1yqR6AFolkccwQr1i0Ndy+USEwpXSHfGQ0XxHzCY0UO0aWZbuu3tiK
         yKammWgdoBJOVpVc2W3xSnBHVldlByWJ1V+zL2MEYh+ieVPIFn6Kr1JXZwx1lG9bAyTT
         zU28jWkiXbsNjUUa266OHShM/iSOcEAf+YCenStq+tupxJPtJC/lZ3OdcUtDmgcobW+w
         XFrp+s77pNrThdSn2PBRSSxBM74baLmY5+uB2Rzfzm1+qD61MxRDifg6eu3TMMpGczI9
         SefcsSyXjoRkXbfdtaEzBhCfwprnedlFtYHCZTfr97IFh3u1w/c4rv8GhvDILhcXJlam
         IfqQ==
X-Gm-Message-State: APjAAAXXY6HkJW/dk8L0pIOG0mDiPiNdhXC5dWAILC0dF12kWIOOwr46
        fznl740UbBNqjTbddBsTV+4=
X-Google-Smtp-Source: APXvYqws83ONS3TPIB0C9R6vXUrPkkiZvOiAYad7qoVcd1DAEspiw4b5OU8lQGa9s7i5MHt/+blNhA==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr19807196pls.100.1554238541276;
        Tue, 02 Apr 2019 13:55:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h184sm33476419pfc.78.2019.04.02.13.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 13:55:40 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:55:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
Message-ID: <20190402205538.GA15543@roeck-us.net>
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
 <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:21:50PM +0200, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> output signal, which generate a defined number of pulses per revolution.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/pwm-fan.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 167221c..3245a49 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -18,6 +18,7 @@
>  
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -26,6 +27,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  #include <linux/thermal.h>
> +#include <linux/timer.h>
>  
>  #define MAX_PWM 255
>  
> @@ -33,6 +35,14 @@ struct pwm_fan_ctx {
>  	struct mutex lock;
>  	struct pwm_device *pwm;
>  	struct regulator *reg_en;
> +
> +	int irq;
> +	atomic_t pulses;
> +	unsigned int rpm;
> +	u8 pulses_per_revolution;
> +	ktime_t sample_start;
> +	struct timer_list rpm_timer;
> +
>  	unsigned int pwm_value;
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
> @@ -40,6 +50,32 @@ struct pwm_fan_ctx {
>  	struct thermal_cooling_device *cdev;
>  };
>  
> +/* This handler assumes self resetting edge triggered interrupt. */
> +static irqreturn_t pulse_handler(int irq, void *dev_id)
> +{
> +	struct pwm_fan_ctx *ctx = dev_id;
> +
> +	atomic_inc(&ctx->pulses);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sample_timer(struct timer_list *t)
> +{
> +	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
> +	int pulses;
> +	u64 tmp;
> +
> +	pulses = atomic_read(&ctx->pulses);
> +	atomic_sub(pulses, &ctx->pulses);
> +	tmp = (u64)pulses * ktime_ms_delta(ktime_get(), ctx->sample_start) * 60;
> +	do_div(tmp, ctx->pulses_per_revolution * 1000);
> +	ctx->rpm = tmp;
> +
> +	ctx->sample_start = ktime_get();
> +	mod_timer(&ctx->rpm_timer, jiffies + HZ);
> +}
> +
>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  {
>  	unsigned long period;
> @@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%u\n", ctx->pwm_value);
>  }
>  
> +static ssize_t rpm_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", ctx->rpm);
> +}
>  
>  static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> +static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
>  
>  static struct attribute *pwm_fan_attrs[] = {
>  	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
>  	NULL,
>  };
>  
> -ATTRIBUTE_GROUPS(pwm_fan);
> +static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
> +				     int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +	struct device_attribute *devattr;
> +
> +	/* Hide fan_input in case no interrupt is available  */
> +	devattr = container_of(a, struct device_attribute, attr);
> +	if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
> +		if (ctx->irq <= 0)
> +			return 0;
> +	}

Side note: This can be easier written as 
	if (n == 1 && ctx->irq <= 0)
		return 0;

Not that it matters much.

> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group pwm_fan_group = {
> +	.attrs = pwm_fan_attrs,
> +	.is_visible = pwm_fan_attrs_visible,
> +};
> +
> +static const struct attribute_group *pwm_fan_groups[] = {
> +	&pwm_fan_group,
> +	NULL,
> +};
>  
>  /* thermal cooling device callbacks */
>  static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
> @@ -261,17 +331,45 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		goto err_reg_disable;
>  	}
>  
> +	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> +
> +	if (of_property_read_u8(pdev->dev.of_node, "pulses-per-revolution",

This does not work: The property is not defined as u8. You have to either
use of_property_read_u32() or declare the property as u8.

[ Sorry, I didn't know until recently that this is necessary ]

> +				&ctx->pulses_per_revolution)) {
> +		ctx->pulses_per_revolution = 2;
> +	}
> +
> +	if (!ctx->pulses_per_revolution) {
> +		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
> +		ret = -EINVAL;
> +		goto err_pwm_disable;
> +	}
> +
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq == -EPROBE_DEFER) {
> +		ret = ctx->irq;
> +		goto err_pwm_disable;

It might be better to call platform_get_irq() and to do do this check
first, before enabling the regulator (in practice before calling
devm_regulator_get_optional). It doesn't make sense to enable the
regulator only to disable it because the irq is not yet available.

> +	} else if (ctx->irq > 0) {

As written, this else is unnecessary, and static checkers will complain
about it.

> +		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
> +				       pdev->name, ctx);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't get interrupt working.\n");
> +			goto err_pwm_disable;
> +		}
> +		ctx->sample_start = ktime_get();
> +		mod_timer(&ctx->rpm_timer, jiffies + HZ);
> +	}
> +
>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>  						       ctx, pwm_fan_groups);
>  	if (IS_ERR(hwmon)) {
>  		dev_err(&pdev->dev, "Failed to register hwmon device\n");
>  		ret = PTR_ERR(hwmon);
> -		goto err_pwm_disable;
> +		goto err_del_timer;
>  	}
>  
>  	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
>  	if (ret)
> -		return ret;
> +		goto err_del_timer;

Outch. This is buggy and should have been "goto err_pwm_disable;".
It needs to be fixed with a separate patch, and first, so we can
backport it. Can you do that ?

>  
>  	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>  	if (IS_ENABLED(CONFIG_THERMAL)) {
> @@ -282,7 +380,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"Failed to register pwm-fan as cooling device");
>  			ret = PTR_ERR(cdev);
> -			goto err_pwm_disable;
> +			goto err_del_timer;
>  		}
>  		ctx->cdev = cdev;
>  		thermal_cdev_update(cdev);
> @@ -290,6 +388,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_del_timer:
> +	del_timer_sync(&ctx->rpm_timer);
> +
>  err_pwm_disable:
>  	state.enabled = false;
>  	pwm_apply_state(ctx->pwm, &state);
> @@ -306,6 +407,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
>  	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
>  
>  	thermal_cooling_device_unregister(ctx->cdev);
> +	del_timer_sync(&ctx->rpm_timer);
> +
>  	if (ctx->pwm_value)
>  		pwm_disable(ctx->pwm);
>  
> -- 
> 2.7.4
> 
