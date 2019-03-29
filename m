Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C55FC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DD62070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfC2QCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:02:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35000 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfC2QCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:02:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AEA780D;
        Fri, 29 Mar 2019 09:02:16 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9DF3F614;
        Fri, 29 Mar 2019 09:02:14 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1553243043-19486-1-git-send-email-stefan.wahren@i2se.com>
 <1553243043-19486-4-git-send-email-stefan.wahren@i2se.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9d78a496-6d4d-38e9-b57f-c44a0c919f4f@arm.com>
Date:   Fri, 29 Mar 2019 16:02:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553243043-19486-4-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 08:24, Stefan Wahren wrote:
> This adds RPM support to the pwm-fan driver in order to use with
> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> output signal, which generate a defined number of pulses per revolution.

Thanks for the CC - this is something I was planning to play with now 
that I have my fan set up, so it's nice to find it already done :)

My board has a 3-wire fan connector driven by an unfiltered PWM output, 
so unfortunately what I end up measuring is actually the PWM frequency 
modulated by the rotation pulse frequency. I hacked up some crude 
low-pass filtering which subsequently got lost in a git reset incident, 
but I could recreate it if you think it's an idea worth considering 
(from a bit of research it does seem that 2 or 3-wire fans aren't really 
meant to be PWMed that way).

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

I agree with Guenter that this seems a bit misplaced - since the raw 
count itself is unlikely to overflow in practice, it certainly feels 
more sensible to handle calculation overflow in the calculation itself...

> +		atomic_inc(&ctx->pulses);
> +
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

...for which maybe mult_frac() could help here, although it might be 
easier just to do the intermediate calculations in u64 and arrange them 
to rule out non-constant division.

Robin.

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
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq >= 0) {
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
