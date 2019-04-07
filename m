Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0827FC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397E20883
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIPM1EwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDGWTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:19:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39658 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDGWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:19:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so6146838pga.6;
        Sun, 07 Apr 2019 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eTfoa47M0XFMMTM0hekTM7+fRzwWzY3I79+EKDtD8zw=;
        b=YIPM1EwEaYjBZ6Y95lU4QBGhP9q/0FA21D5Pabth3qLO3Fxgkppa9svJ4hvmdGICJ3
         tyXRGu+rLTiPldl9sPtwK0FoqQjzIVoSvjS1N3xW6CHbMPdWt2Ti43AekBFCFkLCh+Ab
         d1Gb+XS+hHuhG4AkHAapL40RDA6vMkGKh1JNrx+BM/0P0NDz9avWaDTFpDi1KdSI9ISx
         eXNpEKgmx0QWChKh0gvHkAbLG1ghrEaGsmFl5AJ5dcpDB45oFvB4Foc4Zwe09WVHbC1K
         IZYAuS0/bDCLRuGZ8Y+vlFYwOxpcSTHBzpQjohxRXHcWZ6BLSmPIiUouAc9K+feRioH4
         zozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTfoa47M0XFMMTM0hekTM7+fRzwWzY3I79+EKDtD8zw=;
        b=gJBMbQyXu9YKKUkmy45n+ycBMDAliUrfa6kJVEmXxQ3XuV71r+WbBXxlwTd3yNuJoa
         XXsReZcfcDjJEA7bikvKo2u0mRTLVWNOzniH+u/0rhNr2uxfNu2xcsW5xjHATSIcjkT1
         KUAr4Xzf1sLAvTavR9hzcngXJdmsdEvlf5Rl+ieDUgFEBMAYmTv+McmOwJDHYr39/bOh
         H/R2+oYbSQq9sERTMZrlwEpXDg+Xtv1d8b7/oIfs9Cu+oQ0KhDjciPELURWMtVXQqldl
         cClJog9PbQDyKqFxfrpodb5vQvEkgHy4zSpvnDU5j3vJ3BRoUKYpCWdsBWNN4tDnNXFp
         RjVg==
X-Gm-Message-State: APjAAAUzN1uozS9bHP5UdEPf+n4LQNbXzGyZ8DFWa7fpzEg6hyFiZw9I
        KEZgjScCXdcr/kJ4OuaYiVI=
X-Google-Smtp-Source: APXvYqwfEEFuzlZQ4ndZNBN4mNSpRhvos9nCtd8JMHNj2cGUaj62zPvFTbH02Ep7EIZy6VNDBACxVA==
X-Received: by 2002:a63:115c:: with SMTP id 28mr25009279pgr.270.1554675540326;
        Sun, 07 Apr 2019 15:19:00 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b6sm34090479pgl.49.2019.04.07.15.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 15:18:59 -0700 (PDT)
Date:   Sun, 7 Apr 2019 15:18:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] Input: add a driver for GPIO controllable
 vibrators
Message-ID: <20190407221857.GB162359@dtor-ws>
References: <20190407155841.27354-1-luca@z3ntu.xyz>
 <20190407155841.27354-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407155841.27354-2-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Sun, Apr 07, 2019 at 05:58:41PM +0200, Luca Weiss wrote:
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/input/misc/Kconfig      |  12 ++
>  drivers/input/misc/Makefile     |   1 +
>  drivers/input/misc/gpio-vibra.c | 214 ++++++++++++++++++++++++++++++++
>  3 files changed, 227 insertions(+)
>  create mode 100644 drivers/input/misc/gpio-vibra.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index e15ed1bb8558..6dfe9e2fe5b1 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -290,6 +290,18 @@ config INPUT_GPIO_DECODER
>  	 To compile this driver as a module, choose M here: the module
>  	 will be called gpio_decoder.
>  
> +config INPUT_GPIO_VIBRA
> +	tristate "GPIO vibrator support"
> +	depends on GPIOLIB || COMPILE_TEST
> +	select INPUT_FF_MEMLESS
> +	help
> +	  Say Y here to get support for GPIO based vibrator devices.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called gpio-vibra.
> +
>  config INPUT_IXP4XX_BEEPER
>  	tristate "IXP4XX Beeper support"
>  	depends on ARCH_IXP4XX
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index b936c5b1d4ac..f38ebbdb05e2 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
>  obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
>  obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
>  obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
> +obj-$(CONFIG_INPUT_GPIO_VIBRA)		+= gpio-vibra.o
>  obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
> diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
> new file mode 100644
> index 000000000000..14f9534668c8
> --- /dev/null
> +++ b/drivers/input/misc/gpio-vibra.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  GPIO vibrator driver
> + *
> + *  Copyright (C) 2019 Luca Weiss <luca@z3ntu.xyz>
> + *
> + *  Based on PWM vibrator driver:
> + *  Copyright (C) 2017 Collabora Ltd.
> + *
> + *  Based on previous work from:
> + *  Copyright (C) 2012 Dmitry Torokhov <dmitry.torokhov@gmail.com>
> + *
> + *  Based on PWM beeper driver:
> + *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +enum vibrator_state {
> +	VIBRATOR_OFF,
> +	VIBRATOR_ON
> +};

I'd probably go with simple "bool running".

> +
> +struct gpio_vibrator {
> +	struct input_dev *input;
> +	struct gpio_desc *gpio;
> +	struct regulator *vcc;
> +
> +	struct work_struct play_work;
> +	enum vibrator_state state;
> +	bool vcc_on;
> +};
> +
> +static int gpio_vibrator_start(struct gpio_vibrator *vibrator)
> +{
> +	struct device *pdev = vibrator->input->dev.parent;
> +	int err;
> +
> +	if (!vibrator->vcc_on) {
> +		err = regulator_enable(vibrator->vcc);
> +		if (err) {
> +			dev_err(pdev, "failed to enable regulator: %d", err);
> +			return err;
> +		}
> +		vibrator->vcc_on = true;
> +	}
> +
> +	gpiod_set_value(vibrator->gpio, 1);

Since this is called by work item and thus from context that can sleep,
we can use gpiod_set_value_cansleep() so that "slow" GPIOs can be used
with the driver.

> +
> +	return 0;
> +}
> +
> +static void gpio_vibrator_stop(struct gpio_vibrator *vibrator)
> +{
> +	gpiod_set_value(vibrator->gpio, 0);
> +
> +	if (vibrator->vcc_on) {
> +		regulator_disable(vibrator->vcc);
> +		vibrator->vcc_on = false;
> +	}
> +}
> +
> +static void gpio_vibrator_play_work(struct work_struct *work)
> +{
> +	struct gpio_vibrator *vibrator = container_of(work,
> +					struct gpio_vibrator, play_work);
> +
> +	if (vibrator->state == VIBRATOR_ON)
> +		gpio_vibrator_start(vibrator);
> +	else
> +		gpio_vibrator_stop(vibrator);
> +}
> +
> +static int gpio_vibrator_play_effect(struct input_dev *dev, void *data,
> +				    struct ff_effect *effect)
> +{
> +	struct gpio_vibrator *vibrator = input_get_drvdata(dev);
> +
> +	int level = effect->u.rumble.strong_magnitude;
> +
> +	if (!level)
> +		level = effect->u.rumble.weak_magnitude;
> +
> +	if (level)
> +		vibrator->state = VIBRATOR_ON;
> +	else
> +		vibrator->state = VIBRATOR_OFF;
> +
> +	schedule_work(&vibrator->play_work);
> +
> +	return 0;
> +}
> +
> +static void gpio_vibrator_close(struct input_dev *input)
> +{
> +	struct gpio_vibrator *vibrator = input_get_drvdata(input);
> +
> +	cancel_work_sync(&vibrator->play_work);
> +	gpio_vibrator_stop(vibrator);

Do you want to update vibrator->state here?

> +}
> +
> +static int gpio_vibrator_probe(struct platform_device *pdev)
> +{
> +	struct gpio_vibrator *vibrator;
> +	int err;
> +
> +	vibrator = devm_kzalloc(&pdev->dev, sizeof(*vibrator), GFP_KERNEL);
> +	if (!vibrator)
> +		return -ENOMEM;
> +
> +	vibrator->input = devm_input_allocate_device(&pdev->dev);
> +	if (!vibrator->input)
> +		return -ENOMEM;
> +
> +	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	err = PTR_ERR_OR_ZERO(vibrator->vcc);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request regulator: %d",
> +				err);
> +		return err;
> +	}
> +
> +	vibrator->gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
> +	err = PTR_ERR_OR_ZERO(vibrator->gpio);
> +	if (err) {
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request main gpio: %d",
> +				err);
> +		return err;
> +	}
> +
> +	INIT_WORK(&vibrator->play_work, gpio_vibrator_play_work);
> +
> +	vibrator->input->name = "gpio-vibrator";
> +	vibrator->input->id.bustype = BUS_HOST;
> +	vibrator->input->dev.parent = &pdev->dev;

No need to set as you used devm_input_device_alloc().

> +	vibrator->input->close = gpio_vibrator_close;
> +
> +	input_set_drvdata(vibrator->input, vibrator);
> +	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +	err = input_ff_create_memless(vibrator->input, NULL,
> +				      gpio_vibrator_play_effect);
> +	if (err) {
> +		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +		return err;
> +	}
> +
> +	err = input_register_device(vibrator->input);
> +	if (err) {
> +		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused gpio_vibrator_suspend(struct device *dev)
> +{
> +	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&vibrator->play_work);
> +	if (vibrator->state == VIBRATOR_ON)
> +		gpio_vibrator_stop(vibrator);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused gpio_vibrator_resume(struct device *dev)
> +{
> +	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
> +
> +	if (vibrator->state == VIBRATOR_ON)
> +		gpio_vibrator_start(vibrator);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(gpio_vibrator_pm_ops,
> +			 gpio_vibrator_suspend, gpio_vibrator_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpio_vibra_dt_match_table[] = {
> +	{ .compatible = "gpio-vibrator" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
> +#endif
> +
> +static struct platform_driver gpio_vibrator_driver = {
> +	.probe	= gpio_vibrator_probe,
> +	.driver	= {
> +		.name	= "gpio-vibrator",
> +		.pm	= &gpio_vibrator_pm_ops,
> +		.of_match_table = of_match_ptr(gpio_vibra_dt_match_table),
> +	},
> +};
> +module_platform_driver(gpio_vibrator_driver);
> +
> +MODULE_AUTHOR("Luca Weiss <luca@z3ntu.xy>");
> +MODULE_DESCRIPTION("GPIO vibrator driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:gpio-vibrator");
> -- 
> 2.21.0
> 

Thanks.

-- 
Dmitry
