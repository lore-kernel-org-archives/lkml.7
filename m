Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762CE2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvZH5YZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDKQ5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:57:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:57:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so3776323pgv.13;
        Thu, 11 Apr 2019 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLbpvr4pCQVgOBW6t/kzx0y8nm7WJU2CoD1sex4Tzok=;
        b=tvZH5YZ2H1KwW923VEeyvzVLLy05LFJBGvH4MmtEOQuYwGtsnyy0nd3dMKGSQJoaqr
         Ex6aY9TLfgUcXOnlansHwIRCPFiAonhPYSX1JX8nc9FBraRLSK/6QvP+bF4DBwliA1rh
         KWnQTRVC/BnXAhoDBKZGnbOftJgMJxhfRJpVN4rNwoQgUbvhYywJcbyk/1hlwfvT+kQT
         YWiR9sg9J8YCQFUtKvwzQuBJ7VTDh5ZS2AJ1jdqksEus6VdnIBgnBidt+Xu+ZcnPyNxm
         MuMnaxAD5ca2ifmppFAZCtYd6ZPfF9Zh/b92EhfCzADabLgcLYgp/aQxwGDx/GI/+WER
         ESaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLbpvr4pCQVgOBW6t/kzx0y8nm7WJU2CoD1sex4Tzok=;
        b=BbylQktQifbq5fI8yOBA1R0fgAWEFTafl09qZfQnnsfzmZbTBb2ww7P2XX0NnqK5uq
         7TmpfU5WbnueQkXs7d0bhQEar9Dhe4+uYCW4BE5haoubcOPuy/hE5Q1HI/9Jc0PvLOy8
         adIFztjLWJ6hNeG7N9H1/ttmHMP2TTVNWfWt9FQpesJPnWY2d0yCzJnH7FDeh5oT5UCw
         wGuUsxyXlnyZXClPUMotOJLlZLQvkxQEI4HH0B9Kj+NzV3pmZAfOMpNBtAC7Hb9FlMre
         YSczGwwo0iZZEynVGaYeEInEY3igKABvwEzeMExeyLh0RhokPMlKyOsG81TsQK6Cfovw
         RdEA==
X-Gm-Message-State: APjAAAW7JF9qnjI3r1A9jimUSod6Mq14tVGMsE+WaxQVJ19HzlVdWSZx
        OsbP5Cz0VyiiyfFa8gWlp7o=
X-Google-Smtp-Source: APXvYqzWDoCRdsCUXn7bWovki47potJFZuJKV+psvZ4VcFUGS8WlpSIvMsYoqWRmWBmSpmPO4Pk8+Q==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr41312048pgs.258.1555001864342;
        Thu, 11 Apr 2019 09:57:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l74sm63151339pfi.174.2019.04.11.09.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:57:43 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:57:42 -0700
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
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
Message-ID: <20190411165742.GA29395@roeck-us.net>
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 03:30:11PM +0200, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> output signal, which generate a defined number of pulses per revolution.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/hwmon/pwm-fan.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index e4c5197..8c4c5ee 100644
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
> @@ -100,15 +136,47 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
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

Field day for static analyzers - devattr is no longer used.
No need to resend. I'll let the series rest for a couple of days
and then apply to hwmon-next (after removing devattr) unless there are
additional comments.

> +	if (n == 1 && ctx->irq <= 0)
> +		return 0;
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
> @@ -214,6 +282,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	struct device *hwmon;
>  	int ret;
>  	struct pwm_state state = { };
> +	u32 ppr = 2;
>  
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -233,6 +302,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, ctx);
>  
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq == -EPROBE_DEFER)
> +		return ctx->irq;
> +
>  	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
>  	if (IS_ERR(ctx->reg_en)) {
>  		if (PTR_ERR(ctx->reg_en) != -ENODEV)
> @@ -261,17 +334,38 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		goto err_reg_disable;
>  	}
>  
> +	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> +
> +	of_property_read_u32(pdev->dev.of_node, "pulses-per-revolution", &ppr);
> +	ctx->pulses_per_revolution = ppr;
> +	if (!ctx->pulses_per_revolution) {
> +		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
> +		ret = -EINVAL;
> +		goto err_pwm_disable;
> +	}
> +
> +	if (ctx->irq > 0) {
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
> -		goto err_pwm_disable;
> +		goto err_del_timer;
>  
>  	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>  	if (IS_ENABLED(CONFIG_THERMAL)) {
> @@ -282,7 +376,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"Failed to register pwm-fan as cooling device");
>  			ret = PTR_ERR(cdev);
> -			goto err_pwm_disable;
> +			goto err_del_timer;
>  		}
>  		ctx->cdev = cdev;
>  		thermal_cdev_update(cdev);
> @@ -290,6 +384,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_del_timer:
> +	del_timer_sync(&ctx->rpm_timer);
> +
>  err_pwm_disable:
>  	state.enabled = false;
>  	pwm_apply_state(ctx->pwm, &state);
> @@ -306,6 +403,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
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
