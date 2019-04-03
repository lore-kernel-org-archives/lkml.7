Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B4C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABdvd0tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:11:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38505 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:11:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so8266667plb.5;
        Wed, 03 Apr 2019 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fn6CiKu6+WnC1OAQsH4mKGZ5r6iP2w6l1VtLEUbUWdo=;
        b=ABdvd0tzZj9nI6SkWkKInSQoM+/N21TzqlB7K6a5eWG8DuHKzsYUD0pg9EBPsDQ8lc
         wlSJEHHMcCGpVGjBlARWyYTRGUO2FB+RSXjZC9mgbhqoIzdSQRhlbjqGPG9MfCj0YfyO
         4+Ta6pTHuSwKCuwL/ZzbHmytgKhUgdK5PQfKPcROsh3HCJsPTe2ktD2xfrlO/FPFN8oZ
         eIznrmSloJ1TahJCJ4Y+PPB4XpsKOTqQB4YHNMxfWCPGmsdy4zI3uCVVY4ZynzLA4iTX
         wCpjNEhksOQSB4hKSfPZg5fb/FhB9mdBd66fRBXzivh8OvKeRLHqn3Ms8YaVyFbii0uW
         rXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fn6CiKu6+WnC1OAQsH4mKGZ5r6iP2w6l1VtLEUbUWdo=;
        b=k3XuMzLSdrQRHGyCxsGnf94Pv8XraODODboo1kHC8JU0gNMM5U3sEZsLgncbSE20in
         /sS6v1/A3dzY14hx7f1BUXzAvmJch8pkt+sNcgPWut4FAK41ii6lcogLlQBK+m7xjZbB
         9Pg6UbBfeZX2v4nFDZSGmnCx5xeONOTob1ABHze7gG4Pp5Kw7YKlR+wnuleY0hQ019Ee
         QtjhY075bRO/K/Qj3rMJj+Uve3LxZoB5NsT1MJbmcnSCw2Tz1hLpudh9bCyzTTjfx3VE
         qEdU5vs9JRziI5uzgy05RTqBj3M3BKRpIdjXpeHZEnG0BLIdd93ygp+1KzrcXpPz41W+
         mSig==
X-Gm-Message-State: APjAAAWLT0IIKNq+hNrsO7sJcQWSXfviiRbCTwylFjwoBBxbTuJ3wFF8
        3d5HvdeOJM/LkHd4ecX1fCw=
X-Google-Smtp-Source: APXvYqzzaZXXt87mTrHB0eTk/FM9yL0u2GanzhOwdFvkbQNe7j19wmp35kEKxzJq61ZuXPX9P7PYhg==
X-Received: by 2002:a17:902:2a2a:: with SMTP id i39mr722100plb.211.1554307906169;
        Wed, 03 Apr 2019 09:11:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5sm32675457pfi.97.2019.04.03.09.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 09:11:44 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:11:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
Message-ID: <20190403161142.GA10544@roeck-us.net>
References: <1554214910-29925-1-git-send-email-stefan.wahren@i2se.com>
 <1554214910-29925-4-git-send-email-stefan.wahren@i2se.com>
 <20190402205538.GA15543@roeck-us.net>
 <31ef4637-fa95-3800-20cf-96be2a5ecae4@i2se.com>
 <40c0bee8-3a24-66f8-615f-ec36ae7721ef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c0bee8-3a24-66f8-615f-ec36ae7721ef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:59:35PM +0100, Robin Murphy wrote:
> On 03/04/2019 10:55, Stefan Wahren wrote:
> >Hi Guenter,
> >
> >Am 02.04.19 um 22:55 schrieb Guenter Roeck:
> >>On Tue, Apr 02, 2019 at 04:21:50PM +0200, Stefan Wahren wrote:
> >>>This adds RPM support to the pwm-fan driver in order to use with
> >>>fancontrol/pwmconfig. This feature is intended for fans with a tachometer
> >>>output signal, which generate a defined number of pulses per revolution.
> >>>
> >>>Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>>---
> >>>  drivers/hwmon/pwm-fan.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  1 file changed, 107 insertions(+), 4 deletions(-)
> >>>
> >>>diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> >>>index 167221c..3245a49 100644
> >>>--- a/drivers/hwmon/pwm-fan.c
> >>>+++ b/drivers/hwmon/pwm-fan.c
> >>>@@ -18,6 +18,7 @@
> >>>  #include <linux/hwmon.h>
> >>>  #include <linux/hwmon-sysfs.h>
> >>>+#include <linux/interrupt.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/mutex.h>
> >>>  #include <linux/of.h>
> >>>@@ -26,6 +27,7 @@
> >>>  #include <linux/regulator/consumer.h>
> >>>  #include <linux/sysfs.h>
> >>>  #include <linux/thermal.h>
> >>>+#include <linux/timer.h>
> >>>  #define MAX_PWM 255
> >>>@@ -33,6 +35,14 @@ struct pwm_fan_ctx {
> >>>  	struct mutex lock;
> >>>  	struct pwm_device *pwm;
> >>>  	struct regulator *reg_en;
> >>>+
> >>>+	int irq;
> >>>+	atomic_t pulses;
> >>>+	unsigned int rpm;
> >>>+	u8 pulses_per_revolution;
> >>>+	ktime_t sample_start;
> >>>+	struct timer_list rpm_timer;
> >>>+
> >>>  	unsigned int pwm_value;
> >>>  	unsigned int pwm_fan_state;
> >>>  	unsigned int pwm_fan_max_state;
> >>>@@ -40,6 +50,32 @@ struct pwm_fan_ctx {
> >>>  	struct thermal_cooling_device *cdev;
> >>>  };
> >>>+/* This handler assumes self resetting edge triggered interrupt. */
> >>>+static irqreturn_t pulse_handler(int irq, void *dev_id)
> >>>+{
> >>>+	struct pwm_fan_ctx *ctx = dev_id;
> >>>+
> >>>+	atomic_inc(&ctx->pulses);
> >>>+
> >>>+	return IRQ_HANDLED;
> >>>+}
> >>>+
> >>>+static void sample_timer(struct timer_list *t)
> >>>+{
> >>>+	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
> >>>+	int pulses;
> >>>+	u64 tmp;
> >>>+
> >>>+	pulses = atomic_read(&ctx->pulses);
> >>>+	atomic_sub(pulses, &ctx->pulses);
> >>>+	tmp = (u64)pulses * ktime_ms_delta(ktime_get(), ctx->sample_start) * 60;
> >>>+	do_div(tmp, ctx->pulses_per_revolution * 1000);
> >>>+	ctx->rpm = tmp;
> >>>+
> >>>+	ctx->sample_start = ktime_get();
> >>>+	mod_timer(&ctx->rpm_timer, jiffies + HZ);
> >>>+}
> >>>+
> >>>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> >>>  {
> >>>  	unsigned long period;
> >>>@@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
> >>>  	return sprintf(buf, "%u\n", ctx->pwm_value);
> >>>  }
> >>>+static ssize_t rpm_show(struct device *dev,
> >>>+			struct device_attribute *attr, char *buf)
> >>>+{
> >>>+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> >>>+
> >>>+	return sprintf(buf, "%u\n", ctx->rpm);
> >>>+}
> >>>  static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> >>>+static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
> >>>  static struct attribute *pwm_fan_attrs[] = {
> >>>  	&sensor_dev_attr_pwm1.dev_attr.attr,
> >>>+	&sensor_dev_attr_fan1_input.dev_attr.attr,
> >>>  	NULL,
> >>>  };
> >>>-ATTRIBUTE_GROUPS(pwm_fan);
> >>>+static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
> >>>+				     int n)
> >>>+{
> >>>+	struct device *dev = container_of(kobj, struct device, kobj);
> >>>+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> >>>+	struct device_attribute *devattr;
> >>>+
> >>>+	/* Hide fan_input in case no interrupt is available  */
> >>>+	devattr = container_of(a, struct device_attribute, attr);
> >>>+	if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
> >>>+		if (ctx->irq <= 0)
> >>>+			return 0;
> >>>+	}
> >>Side note: This can be easier written as
> >>	if (n == 1 && ctx->irq <= 0)
> >>		return 0;
> >>
> >>Not that it matters much.
> >>
> >>>+
> >>>+	return a->mode;
> >>>+}
> >>>+
> >>>+static const struct attribute_group pwm_fan_group = {
> >>>+	.attrs = pwm_fan_attrs,
> >>>+	.is_visible = pwm_fan_attrs_visible,
> >>>+};
> >>>+
> >>>+static const struct attribute_group *pwm_fan_groups[] = {
> >>>+	&pwm_fan_group,
> >>>+	NULL,
> >>>+};
> >>>  /* thermal cooling device callbacks */
> >>>  static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
> >>>@@ -261,17 +331,45 @@ static int pwm_fan_probe(struct platform_device *pdev)
> >>>  		goto err_reg_disable;
> >>>  	}
> >>>+	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> >>>+
> >>>+	if (of_property_read_u8(pdev->dev.of_node, "pulses-per-revolution",
> >>This does not work: The property is not defined as u8. You have to either
> >>use of_property_read_u32() or declare the property as u8.
> >pulses_per_revolution is defined as u8 since this version
> 
> The variable might be, but the "pulses-per-revolution" property itself is
> not being defined with the appropriate DT type ("/bits/ 8") in the binding,
> and thus will be stored as a regular 32-bit cell, for which reading it as a
> u8 array may or may not work correctly depending on endianness.
> 
> TBH, unless there's a real need for a specific binary format in the FDT, I
> don't think it's usually worth the bother of using irregular DT types,
> especially when the practical impact amounts to possibly saving up to 3
> bytes for a property which usually won't need to be specified anyway. I'd
> just do something like:
> 
> 	u32 ppr = 2;
> 
> 	of_property_read_u32(np, "pulses-per-revolution", &ppr);
> 	ctx->pulses_per_revolution = ppr;
> 

+1

Thanks,
Guenter

> >>
> >>[ Sorry, I didn't know until recently that this is necessary ]
> >>
> >>>+				&ctx->pulses_per_revolution)) {
> >>>+		ctx->pulses_per_revolution = 2;
> >>>+	}
> >>>+
> >>>+	if (!ctx->pulses_per_revolution) {
> >>>+		dev_err(&pdev->dev, "pulses-per-revolution can't be zero.\n");
> >>>+		ret = -EINVAL;
> >>>+		goto err_pwm_disable;
> >>>+	}
> >>>+
> >>>+	ctx->irq = platform_get_irq(pdev, 0);
> >>>+	if (ctx->irq == -EPROBE_DEFER) {
> >>>+		ret = ctx->irq;
> >>>+		goto err_pwm_disable;
> >>It might be better to call platform_get_irq() and to do do this check
> >>first, before enabling the regulator (in practice before calling
> >>devm_regulator_get_optional). It doesn't make sense to enable the
> >>regulator only to disable it because the irq is not yet available.
> >>
> >>>+	} else if (ctx->irq > 0) {
> >>As written, this else is unnecessary, and static checkers will complain
> >>about it.
> >>
> >>>+		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
> >>>+				       pdev->name, ctx);
> >>>+		if (ret) {
> >>>+			dev_err(&pdev->dev, "Can't get interrupt working.\n");
> >>>+			goto err_pwm_disable;
> 
> We could still continue without RPM support at this point, couldn't we? Or
> is this a deliberate "if that failed, then who knows how messed up the
> system is..." kind of thing?
> 
> Robin.
> 
> >>>+		}
> >>>+		ctx->sample_start = ktime_get();
> >>>+		mod_timer(&ctx->rpm_timer, jiffies + HZ);
> >>>+	}
> >>>+
> >>>  	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
> >>>  						       ctx, pwm_fan_groups);
> >>>  	if (IS_ERR(hwmon)) {
> >>>  		dev_err(&pdev->dev, "Failed to register hwmon device\n");
> >>>  		ret = PTR_ERR(hwmon);
> >>>-		goto err_pwm_disable;
> >>>+		goto err_del_timer;
> >>>  	}
> >>>  	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
> >>>  	if (ret)
> >>>-		return ret;
> >>>+		goto err_del_timer;
> >>Outch. This is buggy and should have been "goto err_pwm_disable;".
> >>It needs to be fixed with a separate patch, and first, so we can
> >>backport it. Can you do that ?
> >
> >Sure
> >
> >Stefan
> >
