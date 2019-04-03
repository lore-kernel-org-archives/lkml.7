Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB58C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD805206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDCJzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:55:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:55:40 -0400
Received: from [192.168.178.52] ([109.104.37.190]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNtjq-1hZukp2Kfg-00ODNA; Wed, 03 Apr 2019 11:55:03 +0200
Subject: Re: [PATCH V4 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
 <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
 <20190402205538.GA15543@roeck-us.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <31ef4637-fa95-3800-20cf-96be2a5ecae4@i2se.com>
Date:   Wed, 3 Apr 2019 11:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402205538.GA15543@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:G33h3RTUHUMLWl9pWm7mwDg0GSLVMh1RcmZjIEfy8UDoqV0x0L2
 NmYRcekT9OAlwRzQiGL4L5nqiW3Z9+rLM9UiPjXrzEBlRXvAYa3kV5DiYBl0s5Utl3t5tZn
 VUn0VhKqiGbL6wsWtRie6ESnyemry2RBhSmEZWdIy9zqP0SlVK3x3D/lGiLlFWvQzxnGVW6
 ANdenM455vInnJ+G2chqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fDYR13Yxpw0=:ATY394AeRsI5MNjD2aMZC9
 SVvZuBtxeMdkHJq8efqh6oNIHBbaUFGsGDsudFzp4jaIX0c2WSMPbIXDYI4z+yTyDNbPxQAV6
 DCS2IYn8cFAnq8sUKFwTqzOVjhG0tL0/hG54+HIfuwM4mmittdpawKXpwiMtAEoPrgWvlyG8j
 K1cja6kLwnPANd2OvW8E0D861K8e9dd5dS2rZf/WoVqJSGB8jad8ogma/MmA62htw9ooFR2Mo
 xMDivxOX/7HuZe7uVcPWZd0OyRB106fFGOceFZxgV7sTT8kNu5uESI10/3c8EokxZWDbocXY/
 JuhYUHzfcKjUkwu4zZmwUrbR3SKzbQwIMYxmgP1w1aRVaxZLJ8t4afhRy9dq+xaofJViGhjCM
 +4m8CueQrqvpF17DR/x1D19x7FZ3WHTxSU09BsEX/37JivfrYACAsFg/3DeLpfCUuncOPKRqy
 PEiwaSAIaVgqmxUIRwN0run2XwzqU3Wqn9ruyedgT/6oshu4/ubHC7Z5oaJSsdj5WwsVmOPrR
 hNMrcbYsbPPuVsYqCHKDrgn1bMUWgsg+EZ1AnNR4J01sZqMQB2uqRToMax6edXIrdxcJUXs/9
 Hey4H/FWrzuAROKGwTuXRZ41a5ceUFVpUTAEHoGmFFuVMMsaK6PQuTZePNrLvrJlfMDcQ3Lca
 IF7a787MV4LCJBxSQopT3sCrtWG0OLO076w3w412SkKDnrO0lC0HEaypZrpn9YG3MGTa5fh+g
 4rjuomfavZ5UOJYFi7A4dXE0eh4tNXBiGiXCIOVBnX5qmM5YFuIaeQwDI/s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am 02.04.19 um 22:55 schrieb Guenter Roeck:
> On Tue, Apr 02, 2019 at 04:21:50PM +0200, Stefan Wahren wrote:
>> This adds RPM support to the pwm-fan driver in order to use with
>> fancontrol/pwmconfig. This feature is intended for fans with a tachometer
>> output signal, which generate a defined number of pulses per revolution.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/hwmon/pwm-fan.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 107 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>> index 167221c..3245a49 100644
>> --- a/drivers/hwmon/pwm-fan.c
>> +++ b/drivers/hwmon/pwm-fan.c
>> @@ -18,6 +18,7 @@
>>  
>>  #include <linux/hwmon.h>
>>  #include <linux/hwmon-sysfs.h>
>> +#include <linux/interrupt.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <linux/of.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/sysfs.h>
>>  #include <linux/thermal.h>
>> +#include <linux/timer.h>
>>  
>>  #define MAX_PWM 255
>>  
>> @@ -33,6 +35,14 @@ struct pwm_fan_ctx {
>>  	struct mutex lock;
>>  	struct pwm_device *pwm;
>>  	struct regulator *reg_en;
>> +
>> +	int irq;
>> +	atomic_t pulses;
>> +	unsigned int rpm;
>> +	u8 pulses_per_revolution;
>> +	ktime_t sample_start;
>> +	struct timer_list rpm_timer;
>> +
>>  	unsigned int pwm_value;
>>  	unsigned int pwm_fan_state;
>>  	unsigned int pwm_fan_max_state;
>> @@ -40,6 +50,32 @@ struct pwm_fan_ctx {
>>  	struct thermal_cooling_device *cdev;
>>  };
>>  
>> +/* This handler assumes self resetting edge triggered interrupt. */
>> +static irqreturn_t pulse_handler(int irq, void *dev_id)
>> +{
>> +	struct pwm_fan_ctx *ctx = dev_id;
>> +
>> +	atomic_inc(&ctx->pulses);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void sample_timer(struct timer_list *t)
>> +{
>> +	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
>> +	int pulses;
>> +	u64 tmp;
>> +
>> +	pulses = atomic_read(&ctx->pulses);
>> +	atomic_sub(pulses, &ctx->pulses);
>> +	tmp = (u64)pulses * ktime_ms_delta(ktime_get(), ctx->sample_start) * 60;
>> +	do_div(tmp, ctx->pulses_per_revolution * 1000);
>> +	ctx->rpm = tmp;
>> +
>> +	ctx->sample_start = ktime_get();
>> +	mod_timer(&ctx->rpm_timer, jiffies + HZ);
>> +}
>> +
>>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>>  {
>>  	unsigned long period;
>> @@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>>  	return sprintf(buf, "%u\n", ctx->pwm_value);
>>  }
>>  
>> +static ssize_t rpm_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>> +
>> +	return sprintf(buf, "%u\n", ctx->rpm);
>> +}
>>  
>>  static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
>> +static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
>>  
>>  static struct attribute *pwm_fan_attrs[] = {
>>  	&sensor_dev_attr_pwm1.dev_attr.attr,
>> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
>>  	NULL,
>>  };
>>  
>> -ATTRIBUTE_GROUPS(pwm_fan);
>> +static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
>> +				     int n)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>> +	struct device_attribute *devattr;
>> +
>> +	/* Hide fan_input in case no interrupt is available  */
>> +	devattr = container_of(a, struct device_attribute, attr);
>> +	if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
>> +		if (ctx->irq <= 0)
>> +			return 0;
>> +	}
> Side note: This can be easier written as 
> 	if (n == 1 && ctx->irq <= 0)
> 		return 0;
>
> Not that it matters much.
>
>> +
>> +	return a->mode;
>> +}
>> +
>> +static const struct attribute_group pwm_fan_group = {
>> +	.attrs = pwm_fan_attrs,
>> +	.is_visible = pwm_fan_attrs_visible,
>> +};
>> +
>> +static const struct attribute_group *pwm_fan_groups[] = {
>> +	&pwm_fan_group,
>> +	NULL,
>> +};
>>  
>>  /* thermal cooling device callbacks */
>>  static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
>> @@ -261,17 +331,45 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>  		goto err_reg_disable;
>>  	}
>>  
>> +	timer_setup(&ctx->rpm_timer, sample_timer, 0);
>> +
>> +	if (of_property_read_u8(pdev->dev.of_node, "pulses-per-revolution",
> This does not work: The property is not defined as u8. You have to either
> use of_property_read_u32() or declare the property as u8.
pulses_per_revolution is defined as u8 since this version
>
> [ Sorry, I didn't know until recently that this is necessary ]
>
>> +				&ctx->pulses_per_revolution)) {
>> +		ctx->pulses_per_revolution = 2;
>> +	}
>> +
>> +	if (!ctx->pulses_per_revolution) {
>> +		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
>> +		ret = -EINVAL;
>> +		goto err_pwm_disable;
>> +	}
>> +
>> +	ctx->irq = platform_get_irq(pdev, 0);
>> +	if (ctx->irq == -EPROBE_DEFER) {
>> +		ret = ctx->irq;
>> +		goto err_pwm_disable;
> It might be better to call platform_get_irq() and to do do this check
> first, before enabling the regulator (in practice before calling
> devm_regulator_get_optional). It doesn't make sense to enable the
> regulator only to disable it because the irq is not yet available.
>
>> +	} else if (ctx->irq > 0) {
> As written, this else is unnecessary, and static checkers will complain
> about it.
>
>> +		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
>> +				       pdev->name, ctx);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Can't get interrupt working.\n");
>> +			goto err_pwm_disable;
>> +		}
>> +		ctx->sample_start = ktime_get();
>> +		mod_timer(&ctx->rpm_timer, jiffies + HZ);
>> +	}
>> +
>>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>>  						       ctx, pwm_fan_groups);
>>  	if (IS_ERR(hwmon)) {
>>  		dev_err(&pdev->dev, "Failed to register hwmon device\n");
>>  		ret = PTR_ERR(hwmon);
>> -		goto err_pwm_disable;
>> +		goto err_del_timer;
>>  	}
>>  
>>  	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
>>  	if (ret)
>> -		return ret;
>> +		goto err_del_timer;
> Outch. This is buggy and should have been "goto err_pwm_disable;".
> It needs to be fixed with a separate patch, and first, so we can
> backport it. Can you do that ?

Sure

Stefan

