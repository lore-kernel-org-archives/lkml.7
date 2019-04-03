Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A1EC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010B2206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCQXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:23:48 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:23:47 -0400
Received: from [192.168.178.52] ([109.104.37.190]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N17cq-1gntLR3bEA-012Ubu; Wed, 03 Apr 2019 18:23:11 +0200
Subject: Re: [PATCH V4 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Robin Murphy <robin.murphy@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
 <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
 <20190402205538.GA15543@roeck-us.net>
 <31ef4637-fa95-3800-20cf-96be2a5ecae4@i2se.com>
 <40c0bee8-3a24-66f8-615f-ec36ae7721ef@arm.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7653a567-ae91-0890-f318-fd971b69274b@i2se.com>
Date:   Wed, 3 Apr 2019 18:23:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <40c0bee8-3a24-66f8-615f-ec36ae7721ef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Provags-ID: V03:K1:ZSuQEWbbm51iEMCJXaPOeI+T33sJpD48nLIZg8SNI4+ZNLD6OYF
 p//U/SrD5iyIwxYpgLG5MjPCO3Q02NtFFc1TTaQwXdSEv8K3CkSu60rW0Z2q2YJDtm5Ak7u
 83+lG1SAsLD1OhqdJ2qEn0Nauaavducfur+WRJcDpvM1bm37JACzFzOAT7ldZ6wwyNGAomR
 9HsMqys3+Avbi0IkpRQ8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BAePSVwHDxs=:MJDm507b20AueqxhcuQfhl
 38frOKu8LFO42rb5WsFD+25/FfZSbI9pqgzzUp75FOdmFV5SL+WBrF6Cp7pP2qMTPp8fbShtx
 DYrEiQeO1uMF3LrbqSIW9Fke0OTcjHUEyDmkRUQ2bMX3u2a/d2QwmfB3Ib5xDv1JKbw4Licc0
 vjsp4b1h9pLcpX/bu7J+s8q97BO5qDusc2ODrGMkTHEucqYBCB/ry9A1A8DBCUm4FG5RP0lQN
 gxYH+PfN4Y49EcquEvjZNRL3JhUJFmpHfCYOdRibgUV+NcRPhkh9Wy50dDUnu2w93Dars0uaT
 aZGkhLTkjXXSYrRCCFgfxbfIQUyyhEns//Nz85gp/B2TsvGBAByFtE+wi/a7geDwlCmeMq75p
 pzROAtOoaqEubCC9TXibXwAQR7+W/tVl32EXAIuzIjJfSXsqtMbnczEbtbc/6UCN3sS9hCP5e
 K1dEYkestXQBbaN2ofquxGh2sd++U20Djf/gcHeZPS68rpJJZ1PJa2BVkgp8dBV42iILrPGfY
 CT3zxg9orT0pO/if9G2XIFoC7OMnF9CJZ8x6KZ5MyLTraQWO22VaX2UlTnRHSaNpoZDmIcaD4
 nuoKzObKCKzBw578ef86z0gX3gNcTSTey9i6u2SOISxGQrotszt2/+n/WvoF7ih2uHOXthyBd
 TlOUmyLlm29QlMZ/fdCeZLID+qgYe0SUkxcgXZkjEO2ausbFLnVK5BoMhRo/OQhE7/K8c5PpC
 t7Rrzly2v3ibPqzdHreszb0ItLHUxcHdcWpL/xOzcLLXI86PsvUET8bfqgbjn+NZ+P9i0K4r8
 NmqoB9/1YgRIyqh6sdiYqJF6PoieP7FS/P2F5F3P4/He0yiMSJx64A3eucoA0g64y2kUkPP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.04.2019 um 17:59 schrieb Robin Murphy:
> On 03/04/2019 10:55, Stefan Wahren wrote:
>> Hi Guenter,
>>
>> Am 02.04.19 um 22:55 schrieb Guenter Roeck:
>>> On Tue, Apr 02, 2019 at 04:21:50PM +0200, Stefan Wahren wrote:
>>>> This adds RPM support to the pwm-fan driver in order to use with
>>>> fancontrol/pwmconfig. This feature is intended for fans with a 
>>>> tachometer
>>>> output signal, which generate a defined number of pulses per 
>>>> revolution.
>>>>
>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> ---
>>>>   drivers/hwmon/pwm-fan.c | 111 
>>>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>   1 file changed, 107 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>>>> index 167221c..3245a49 100644
>>>> --- a/drivers/hwmon/pwm-fan.c
>>>> +++ b/drivers/hwmon/pwm-fan.c
>>>> @@ -18,6 +18,7 @@
>>>>     #include <linux/hwmon.h>
>>>>   #include <linux/hwmon-sysfs.h>
>>>> +#include <linux/interrupt.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/mutex.h>
>>>>   #include <linux/of.h>
>>>> @@ -26,6 +27,7 @@
>>>>   #include <linux/regulator/consumer.h>
>>>>   #include <linux/sysfs.h>
>>>>   #include <linux/thermal.h>
>>>> +#include <linux/timer.h>
>>>>     #define MAX_PWM 255
>>>>   @@ -33,6 +35,14 @@ struct pwm_fan_ctx {
>>>>       struct mutex lock;
>>>>       struct pwm_device *pwm;
>>>>       struct regulator *reg_en;
>>>> +
>>>> +    int irq;
>>>> +    atomic_t pulses;
>>>> +    unsigned int rpm;
>>>> +    u8 pulses_per_revolution;
>>>> +    ktime_t sample_start;
>>>> +    struct timer_list rpm_timer;
>>>> +
>>>>       unsigned int pwm_value;
>>>>       unsigned int pwm_fan_state;
>>>>       unsigned int pwm_fan_max_state;
>>>> @@ -40,6 +50,32 @@ struct pwm_fan_ctx {
>>>>       struct thermal_cooling_device *cdev;
>>>>   };
>>>>   +/* This handler assumes self resetting edge triggered interrupt. */
>>>> +static irqreturn_t pulse_handler(int irq, void *dev_id)
>>>> +{
>>>> +    struct pwm_fan_ctx *ctx = dev_id;
>>>> +
>>>> +    atomic_inc(&ctx->pulses);
>>>> +
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +static void sample_timer(struct timer_list *t)
>>>> +{
>>>> +    struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
>>>> +    int pulses;
>>>> +    u64 tmp;
>>>> +
>>>> +    pulses = atomic_read(&ctx->pulses);
>>>> +    atomic_sub(pulses, &ctx->pulses);
>>>> +    tmp = (u64)pulses * ktime_ms_delta(ktime_get(), 
>>>> ctx->sample_start) * 60;
>>>> +    do_div(tmp, ctx->pulses_per_revolution * 1000);
>>>> +    ctx->rpm = tmp;
>>>> +
>>>> +    ctx->sample_start = ktime_get();
>>>> +    mod_timer(&ctx->rpm_timer, jiffies + HZ);
>>>> +}
>>>> +
>>>>   static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>>>>   {
>>>>       unsigned long period;
>>>> @@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, 
>>>> struct device_attribute *attr,
>>>>       return sprintf(buf, "%u\n", ctx->pwm_value);
>>>>   }
>>>>   +static ssize_t rpm_show(struct device *dev,
>>>> +            struct device_attribute *attr, char *buf)
>>>> +{
>>>> +    struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>>>> +
>>>> +    return sprintf(buf, "%u\n", ctx->rpm);
>>>> +}
>>>>     static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
>>>> +static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
>>>>     static struct attribute *pwm_fan_attrs[] = {
>>>>       &sensor_dev_attr_pwm1.dev_attr.attr,
>>>> +    &sensor_dev_attr_fan1_input.dev_attr.attr,
>>>>       NULL,
>>>>   };
>>>>   -ATTRIBUTE_GROUPS(pwm_fan);
>>>> +static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct 
>>>> attribute *a,
>>>> +                     int n)
>>>> +{
>>>> +    struct device *dev = container_of(kobj, struct device, kobj);
>>>> +    struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>>>> +    struct device_attribute *devattr;
>>>> +
>>>> +    /* Hide fan_input in case no interrupt is available  */
>>>> +    devattr = container_of(a, struct device_attribute, attr);
>>>> +    if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
>>>> +        if (ctx->irq <= 0)
>>>> +            return 0;
>>>> +    }
>>> Side note: This can be easier written as
>>>     if (n == 1 && ctx->irq <= 0)
>>>         return 0;
>>>
>>> Not that it matters much.
>>>
>>>> +
>>>> +    return a->mode;
>>>> +}
>>>> +
>>>> +static const struct attribute_group pwm_fan_group = {
>>>> +    .attrs = pwm_fan_attrs,
>>>> +    .is_visible = pwm_fan_attrs_visible,
>>>> +};
>>>> +
>>>> +static const struct attribute_group *pwm_fan_groups[] = {
>>>> +    &pwm_fan_group,
>>>> +    NULL,
>>>> +};
>>>>     /* thermal cooling device callbacks */
>>>>   static int pwm_fan_get_max_state(struct thermal_cooling_device 
>>>> *cdev,
>>>> @@ -261,17 +331,45 @@ static int pwm_fan_probe(struct 
>>>> platform_device *pdev)
>>>>           goto err_reg_disable;
>>>>       }
>>>>   +    timer_setup(&ctx->rpm_timer, sample_timer, 0);
>>>> +
>>>> +    if (of_property_read_u8(pdev->dev.of_node, 
>>>> "pulses-per-revolution",
>>> This does not work: The property is not defined as u8. You have to 
>>> either
>>> use of_property_read_u32() or declare the property as u8.
>> pulses_per_revolution is defined as u8 since this version
>
> The variable might be, but the "pulses-per-revolution" property itself 
> is not being defined with the appropriate DT type ("/bits/ 8") in the 
> binding, and thus will be stored as a regular 32-bit cell, for which 
> reading it as a u8 array may or may not work correctly depending on 
> endianness.
>
> TBH, unless there's a real need for a specific binary format in the 
> FDT, I don't think it's usually worth the bother of using irregular DT 
> types, especially when the practical impact amounts to possibly saving 
> up to 3 bytes for a property which usually won't need to be specified 
> anyway. I'd just do something like:
>
>     u32 ppr = 2;
>
>     of_property_read_u32(np, "pulses-per-revolution", &ppr);
>     ctx->pulses_per_revolution = ppr;

My intention was to avoid another overflow in case the device tree 
provides unrealistic values ( my expected range 1 - 10 ). Saving space 
would be a benefit, but i'm okay with this suggestion.

>
>>>
>>> [ Sorry, I didn't know until recently that this is necessary ]
>>>
>>>> + &ctx->pulses_per_revolution)) {
>>>> +        ctx->pulses_per_revolution = 2;
>>>> +    }
>>>> +
>>>> +    if (!ctx->pulses_per_revolution) {
>>>> +        dev_err(&pdev->dev, "pulses-per-revolution can't be 
>>>> zero.\n");
>>>> +        ret = -EINVAL;
>>>> +        goto err_pwm_disable;
>>>> +    }
>>>> +
>>>> +    ctx->irq = platform_get_irq(pdev, 0);
>>>> +    if (ctx->irq == -EPROBE_DEFER) {
>>>> +        ret = ctx->irq;
>>>> +        goto err_pwm_disable;
>>> It might be better to call platform_get_irq() and to do do this check
>>> first, before enabling the regulator (in practice before calling
>>> devm_regulator_get_optional). It doesn't make sense to enable the
>>> regulator only to disable it because the irq is not yet available.
>>>
>>>> +    } else if (ctx->irq > 0) {
>>> As written, this else is unnecessary, and static checkers will complain
>>> about it.
>>>
>>>> +        ret = devm_request_irq(&pdev->dev, ctx->irq, 
>>>> pulse_handler, 0,
>>>> +                       pdev->name, ctx);
>>>> +        if (ret) {
>>>> +            dev_err(&pdev->dev, "Can't get interrupt working.\n");
>>>> +            goto err_pwm_disable;
>
> We could still continue without RPM support at this point, couldn't 
> we? Or is this a deliberate "if that failed, then who knows how messed 
> up the system is..." kind of thing?

In case someone specified an interrupt, the user expect it to work. This 
helps to identify broken DT faster.

The gpio-fan also have optional irq support and also bail out if 
devm_request_irq fails.

Btw i will add the return code into the error message.

Stefan

