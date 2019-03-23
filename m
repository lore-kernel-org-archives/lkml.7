Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B78218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaZz3GwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCWPDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:03:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40105 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:03:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so3471115pgo.7;
        Sat, 23 Mar 2019 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y74O7cJJSSWu4auGgupzwHkycq7o8Xx2T8QJ9kIH7QI=;
        b=aaZz3GwAWSHKHlYYWf/Eieb5ejXTd92NoKMXu1o/mWEYMyVN60+f1nXPdVXMk4+kYg
         34iQXy3CvyVeDpOYRFPIG8AEC6ZoAPLUHGj55F1EKZWCqe0F/vaKNb4+jkP0tVD7vhy3
         Do9DdjZaXga4FMREphYmESydkoVUKOsS6Lo5sWV2QK5W4MciaBqHi26V3TgUOPFsUOCN
         Pnj+aBuC8+MhLsXiwfSAA+5G18+fmh8ThtJtms9sBc8Dx2KJMQfAuw8dwRQqxRW2EJGf
         Tp0jYB/emvqNXz/OgX97NJy9eN8BHMPvBAGWT39R2ru4az0Y0zVMVPuoX5rQk0gz/kMW
         GTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y74O7cJJSSWu4auGgupzwHkycq7o8Xx2T8QJ9kIH7QI=;
        b=gpsK/FfZkdU9HI6Q/gVlNYxbcE3UMEX+5W+5bldvi8SqhP0TK1pa43ayrciO6RS5MD
         OQ9adyyRTQWW5CGGsU7rhXqZ51LHgPl3ITxFpzh+D/wEuM+vkPp8nasoaECNzUdUyG5y
         tw7BcVq7gk1NRvIFPsT1mb2inHbwO579kmdOL1rI5PjdxpwWiG0UHvDaRXh92t+B8Nn8
         J1GjQK1hBmpjRnmqOsnge5bpgwpmSxbUF6Ie3i+O0/FvaiU+thR69HOK+Hp4KV8QKCFA
         r9RVgInl4SQCLcVRkVLQOP1Ae/W321sEopXyiPup1ntP81igEjs0RJ7Q+fO/ZqubY74j
         vDBg==
X-Gm-Message-State: APjAAAWjVjxZ8nq8HsYnsQuUzrujyctN0JUfRf6w8vILhBF2DBkX8SOy
        hT6dARhFFmeaI8qG5ar1rhKdAcE8
X-Google-Smtp-Source: APXvYqwqqm9TvYC8AsBFQgw23ioOPpygOj8m2i9rj/O6uiDKjzIIOFImQX57iUzyhy+tRMIKu6n4sA==
X-Received: by 2002:a65:6546:: with SMTP id a6mr14422644pgw.296.1553353418873;
        Sat, 23 Mar 2019 08:03:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f125sm19788056pfc.91.2019.03.23.08.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 08:03:37 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
 <1553243043-19486-4-git-send-email-stefan.wahren@i2se.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <53485197-01e3-1f84-df93-a01164e5cded@roeck-us.net>
Date:   Sat, 23 Mar 2019 08:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553243043-19486-4-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 1:24 AM, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> output signal, which generate a defined number of pulses per revolution.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   drivers/hwmon/pwm-fan.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 167221c..c8fb6a3 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -18,6 +18,7 @@
>   
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
> +#include <linux/interrupt.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/of.h>
> @@ -26,6 +27,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/sysfs.h>
>   #include <linux/thermal.h>
> +#include <linux/timer.h>
>   
>   #define MAX_PWM 255
>   
> @@ -33,6 +35,14 @@ struct pwm_fan_ctx {
>   	struct mutex lock;
>   	struct pwm_device *pwm;
>   	struct regulator *reg_en;
> +
> +	int irq;
> +	atomic_t pulses;
> +	unsigned int rpm;
> +	u32 pulses_per_revolution;
> +	ktime_t sample_start;
> +	struct timer_list rpm_timer;
> +
>   	unsigned int pwm_value;
>   	unsigned int pwm_fan_state;
>   	unsigned int pwm_fan_max_state;
> @@ -40,6 +50,32 @@ struct pwm_fan_ctx {
>   	struct thermal_cooling_device *cdev;
>   };
>   
> +/* This handler assumes self resetting edge triggered interrupt. */
> +static irqreturn_t pulse_handler(int irq, void *dev_id)
> +{
> +	struct pwm_fan_ctx *ctx = dev_id;
> +
> +	/* Avoid possible overflow */
> +	if (atomic_read(&ctx->pulses) < 100000)
> +		atomic_inc(&ctx->pulses);
> +

100000 * 60 * 1000 = 6,000,000,000, which is already above 32 bit,
so you still get the overflow.

Any limit would have to be below (0xffffffff / (60 * sample_ms))
for the maximum expected value of sample_ms.

You could select a working limit, such as 32768 (that is just as arbitrary
as 100,000, but at least it works up to sample_ms above 2,000), or check
for overflow when calculating rpm.

> +	return IRQ_HANDLED;
> +}
> +
> +static void sample_timer(struct timer_list *t)
> +{
> +	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
> +	int pulses, sample_ms;
> +
> +	pulses = atomic_read(&ctx->pulses);
> +	atomic_sub(pulses, &ctx->pulses);
> +	sample_ms = ktime_ms_delta(ktime_get(), ctx->sample_start);
> +	ctx->rpm = pulses * 60 * sample_ms / 1000 / ctx->pulses_per_revolution;
> +
> +	ctx->sample_start = ktime_get();
> +	mod_timer(&ctx->rpm_timer, jiffies + HZ);
> +}
> +
>   static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>   {
>   	unsigned long period;
> @@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>   	return sprintf(buf, "%u\n", ctx->pwm_value);
>   }
>   
> +static ssize_t rpm_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", ctx->rpm);
> +}
>   
>   static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> +static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
>   
>   static struct attribute *pwm_fan_attrs[] = {
>   	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
>   	NULL,
>   };
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
> +		if (ctx->irq < 0)
> +			return 0;
> +	}
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
>   /* thermal cooling device callbacks */
>   static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
> @@ -261,6 +331,32 @@ static int pwm_fan_probe(struct platform_device *pdev)
>   		goto err_reg_disable;
>   	}
>   
> +	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "pulses-per-revolution",
> +				 &ctx->pulses_per_revolution)) {
> +		ctx->pulses_per_revolution = 2;
> +	}
> +
> +	if (!ctx->pulses_per_revolution) {
> +		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
> +		ret = -EINVAL;
> +		goto err_pwm_disable;
> +	}
> +
> +	atomic_set(&ctx->pulses, 0);

Already initialized with 0.

> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq >= 0) {

I have seen other patches recently, changing this check to > 0.
I never know what a valid irq is, but it may be prudent to change this to > 0
(and the check in is_visible to <= 0).

Either case, the function can return -EPROBE_DEFER, which should be handled
and not be ignored.

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
>   	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>   						       ctx, pwm_fan_groups);
>   	if (IS_ERR(hwmon)) {

del_timer_sync() here ?

> @@ -306,6 +402,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
>   	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
>   
>   	thermal_cooling_device_unregister(ctx->cdev);
> +	del_timer_sync(&ctx->rpm_timer);
> +
>   	if (ctx->pwm_value)
>   		pwm_disable(ctx->pwm);
>   
> 

