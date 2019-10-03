Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94238C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676DD21D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA5J+YJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfJCDja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:39:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43670 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfJCDj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:39:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so844663pgk.10;
        Wed, 02 Oct 2019 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E74AgWlIWK4quOmyTjQa6z3KmOpT3mcnqQYrU2yNDoM=;
        b=cA5J+YJxCc5P1Qwx8TAT0OMpJZ1QI7l916cMcwZ3bpY5tsB0TqgNvhqH6QB3v36E7q
         F7gcp/tCyEHN0yjzafN5RBmsCPebwS9Udgas1Q9R++AXTg4tae854+YreVaB3aPBtg9M
         BYxuc8h++Ee+jkOpd0LzNAH5XvjQ/vHFaStt3T/YBaFT8axOmbhp+fGgPomIH2ZWUUCV
         JffVnDhgO4GIJJdkE0ESzf7/XjLQDmIGLfVm7VSpDQ5SpRgW45lvacGbzSWHu7tEMKn8
         A70CEAJrX8JjXGoQN79SJJOr9/WiGL+VohsVRXSFTgvsWLcDoo11zw7/cTAhLKEXrwE3
         FqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E74AgWlIWK4quOmyTjQa6z3KmOpT3mcnqQYrU2yNDoM=;
        b=VyWRiyUYh/FYEz+9nwfjItw8OuXKeUYEGtYyA/dc37DVlsWmW+8ILqHxPrKFeBXVaR
         2W0YiU2F/uPjsCpq/EC9VJjUbbgqVPVsRV61ATmfZvCT+Z5Qd50xw5uyFedyMsKnF4zb
         TN+li+/7MD3WEkh3Yg43duETNzxh/WhR6EfVXmN3qytk7/dpCRz6rOTA8XXUn6ojmpWL
         bt8EdA/MYGW/FRl1Gp46Ey4s6ouanplsaqpcnc9/4A0nNQQTTlb/3xD0CDl4+qCoOuBF
         BOy2vfYUpXuA/5FcDYyeJSJbScYUapf8BHycpafFzNDlwUxUAxXks/UDNja8uFwvEzMV
         XcqQ==
X-Gm-Message-State: APjAAAVjrcD5/Ko3iXm61US5IoO1S0Z1r4YO80QIirHtopMAhcW3XK8X
        an1/fIsx29cqNZe1wVoViek=
X-Google-Smtp-Source: APXvYqx3eGIVOiVRaXeGXTDBXfPTQoXIba8mM9xJUrE+Ncp6eYYLqxwRTC3DcqMo85oRTGHOgSCEOQ==
X-Received: by 2002:a62:14c2:: with SMTP id 185mr8371105pfu.47.1570073968536;
        Wed, 02 Oct 2019 20:39:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6sm936399pfj.17.2019.10.02.20.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 20:39:27 -0700 (PDT)
Date:   Wed, 2 Oct 2019 20:39:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nicolas Boichat <nicolas@boichat.ch>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: applesmc: switch to using input device polling
 mode
Message-ID: <20191003033926.GA1301@roeck-us.net>
References: <20191002214345.GA108728@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002214345.GA108728@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:43:45PM -0700, Dmitry Torokhov wrote:
> Now that instances of input_dev support polling mode natively,
> we no longer need to create input_polled_dev instance.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to hwmon-next.

I don't know what 0-day is complaining about; the code builds
fine for me with the supposedly failing configuration. We'll
see if we get into trouble when the patch shows up in -next.

Guenter

> ---
>  drivers/hwmon/Kconfig    |  1 -
>  drivers/hwmon/applesmc.c | 38 ++++++++++++++++++--------------------
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 650dd71f9724..c5adca9cd465 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -299,7 +299,6 @@ config SENSORS_APPLESMC
>  	depends on INPUT && X86
>  	select NEW_LEDS
>  	select LEDS_CLASS
> -	select INPUT_POLLDEV
>  	help
>  	  This driver provides support for the Apple System Management
>  	  Controller, which provides an accelerometer (Apple Sudden Motion
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 183ff3d25129..ec93b8d673f5 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -19,7 +19,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
> -#include <linux/input-polldev.h>
> +#include <linux/input.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -140,7 +140,7 @@ static s16 rest_y;
>  static u8 backlight_state[2];
>  
>  static struct device *hwmon_dev;
> -static struct input_polled_dev *applesmc_idev;
> +static struct input_dev *applesmc_idev;
>  
>  /*
>   * Last index written to key_at_index sysfs file, and value to use for all other
> @@ -681,9 +681,8 @@ static void applesmc_calibrate(void)
>  	rest_x = -rest_x;
>  }
>  
> -static void applesmc_idev_poll(struct input_polled_dev *dev)
> +static void applesmc_idev_poll(struct input_dev *idev)
>  {
> -	struct input_dev *idev = dev->input;
>  	s16 x, y;
>  
>  	if (applesmc_read_s16(MOTION_SENSOR_X_KEY, &x))
> @@ -1134,7 +1133,6 @@ static int applesmc_create_nodes(struct applesmc_node_group *groups, int num)
>  /* Create accelerometer resources */
>  static int applesmc_create_accelerometer(void)
>  {
> -	struct input_dev *idev;
>  	int ret;
>  
>  	if (!smcreg.has_accelerometer)
> @@ -1144,37 +1142,38 @@ static int applesmc_create_accelerometer(void)
>  	if (ret)
>  		goto out;
>  
> -	applesmc_idev = input_allocate_polled_device();
> +	applesmc_idev = input_allocate_device();
>  	if (!applesmc_idev) {
>  		ret = -ENOMEM;
>  		goto out_sysfs;
>  	}
>  
> -	applesmc_idev->poll = applesmc_idev_poll;
> -	applesmc_idev->poll_interval = APPLESMC_POLL_INTERVAL;
> -
>  	/* initial calibrate for the input device */
>  	applesmc_calibrate();
>  
>  	/* initialize the input device */
> -	idev = applesmc_idev->input;
> -	idev->name = "applesmc";
> -	idev->id.bustype = BUS_HOST;
> -	idev->dev.parent = &pdev->dev;
> -	idev->evbit[0] = BIT_MASK(EV_ABS);
> -	input_set_abs_params(idev, ABS_X,
> +	applesmc_idev->name = "applesmc";
> +	applesmc_idev->id.bustype = BUS_HOST;
> +	applesmc_idev->dev.parent = &pdev->dev;
> +	input_set_abs_params(applesmc_idev, ABS_X,
>  			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
> -	input_set_abs_params(idev, ABS_Y,
> +	input_set_abs_params(applesmc_idev, ABS_Y,
>  			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
>  
> -	ret = input_register_polled_device(applesmc_idev);
> +	ret = input_setup_polling(applesmc_idev, applesmc_idev_poll);
> +	if (ret)
> +		goto out_idev;
> +
> +	input_set_poll_interval(applesmc_idev, APPLESMC_POLL_INTERVAL);
> +
> +	ret = input_register_device(applesmc_idev);
>  	if (ret)
>  		goto out_idev;
>  
>  	return 0;
>  
>  out_idev:
> -	input_free_polled_device(applesmc_idev);
> +	input_free_device(applesmc_idev);
>  
>  out_sysfs:
>  	applesmc_destroy_nodes(accelerometer_group);
> @@ -1189,8 +1188,7 @@ static void applesmc_release_accelerometer(void)
>  {
>  	if (!smcreg.has_accelerometer)
>  		return;
> -	input_unregister_polled_device(applesmc_idev);
> -	input_free_polled_device(applesmc_idev);
> +	input_unregister_device(applesmc_idev);
>  	applesmc_destroy_nodes(accelerometer_group);
>  }
>  
