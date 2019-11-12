Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC821872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfVyYcPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKLAlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:41:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33153 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKLAlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:41:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so8606435plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xm0oEa6ohv0s8ocGEmhFk7hVOJ6zProJv5uL2Qxk76k=;
        b=dfVyYcPQvxhTCuUDi9uqsHpozU+XWgYqtf63Gu7RLbCacf7uHO/zOvbbNWrHJ8gV/G
         eTHlWuUlJGWLM64ayzpdspK5OwuJkxuOYOsdlm9X/rCPo3t7MCnw8dpbyRLIQFYeQbO3
         sEuFHiLWTi+Kz54vZbhIeiRniDRufId009QEGYmMTKitR604tx/JXCzii0JlHXqvB9Fg
         9Ha89fSr8NOiD4ylF7mvwLL81DYrA3ZNgnk1jz/xtV0wCL2LuBJvaFWaImjRpqSYEPbr
         r1pOwnr8XbkYY6T+ej0kUUHgZsipjahPNOnxlolF0KNSNcx7//+Hgkw9m8JfZdiezyFx
         iZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xm0oEa6ohv0s8ocGEmhFk7hVOJ6zProJv5uL2Qxk76k=;
        b=ntHVqMfOLEJHVMxm73uvgfTPhGOEVcGuI98wQcqcczEr4ZEcP9qGqja4g/jOgA6vg8
         943igHDetxZKxWnsdUoXSOFvjIKoyt1EwnlrOmULvIx/Qfki+UqADoqcnjpqhvj/Lg6l
         RqbqaCKtBhX6FW5TOgHgJk1zvYHVIj9UqlRlZ+PVV7cy1wJ/E+rtVFbBTR20M2WXYbIu
         LleEI/g22fxiJnT3yaHX57817ni28eNJnsC0u9TJx7xaMgpvOod19ygJ6wT4l7Zy579U
         h6PG4aqtEVIxpURfsm2tUSY5FKRgWUPbPfkSiGr7wAzge194Dnww8Ey3vA1YyjJg8JxS
         M2Dg==
X-Gm-Message-State: APjAAAXJPuvy9lRVe4jolOha5OdYVpozsWRU5d9CYQhTy+XzbMN2fCST
        OG0ufs75SWnIJeFUJqLXX64=
X-Google-Smtp-Source: APXvYqwpiqUy+/0T8dSfETDMS1SVm8RLUGI8vCvLiPf8IFTTYf996luPqlcQKqdV0I8qJ68iHom3nw==
X-Received: by 2002:a17:902:aa86:: with SMTP id d6mr29485793plr.268.1573519306911;
        Mon, 11 Nov 2019 16:41:46 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c9sm25669367pfb.114.2019.11.11.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:41:46 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:41:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jean Delvare <jdelvare@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/ams-input: switch to using input device
 polling mode
Message-ID: <20191112004144.GC192119@dtor-ws>
References: <20191002214854.GA114387@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002214854.GA114387@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:48:54PM -0700, Dmitry Torokhov wrote:
> Now that instances of input_dev support polling mode natively,
> we no longer need to create input_polled_dev instance.

Michael, could you please take this? Or I could push through my tree...

Thanks!

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/macintosh/Kconfig         |  1 -
>  drivers/macintosh/ams/ams-input.c | 37 +++++++++++++++----------------
>  drivers/macintosh/ams/ams.h       |  4 ++--
>  3 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 574e122ae105..da6a943ad746 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -247,7 +247,6 @@ config PMAC_RACKMETER
>  config SENSORS_AMS
>  	tristate "Apple Motion Sensor driver"
>  	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C)
> -	select INPUT_POLLDEV
>  	help
>  	  Support for the motion sensor included in PowerBooks. Includes
>  	  implementations for PMU and I2C.
> diff --git a/drivers/macintosh/ams/ams-input.c b/drivers/macintosh/ams/ams-input.c
> index 06a96b3f11de..0da493d449b2 100644
> --- a/drivers/macintosh/ams/ams-input.c
> +++ b/drivers/macintosh/ams/ams-input.c
> @@ -25,9 +25,8 @@ MODULE_PARM_DESC(invert, "Invert input data on X and Y axis");
>  
>  static DEFINE_MUTEX(ams_input_mutex);
>  
> -static void ams_idev_poll(struct input_polled_dev *dev)
> +static void ams_idev_poll(struct input_dev *idev)
>  {
> -	struct input_dev *idev = dev->input;
>  	s8 x, y, z;
>  
>  	mutex_lock(&ams_info.lock);
> @@ -59,14 +58,10 @@ static int ams_input_enable(void)
>  	ams_info.ycalib = y;
>  	ams_info.zcalib = z;
>  
> -	ams_info.idev = input_allocate_polled_device();
> -	if (!ams_info.idev)
> +	input = input_allocate_device();
> +	if (!input)
>  		return -ENOMEM;
>  
> -	ams_info.idev->poll = ams_idev_poll;
> -	ams_info.idev->poll_interval = 25;
> -
> -	input = ams_info.idev->input;
>  	input->name = "Apple Motion Sensor";
>  	input->id.bustype = ams_info.bustype;
>  	input->id.vendor = 0;
> @@ -75,28 +70,32 @@ static int ams_input_enable(void)
>  	input_set_abs_params(input, ABS_X, -50, 50, 3, 0);
>  	input_set_abs_params(input, ABS_Y, -50, 50, 3, 0);
>  	input_set_abs_params(input, ABS_Z, -50, 50, 3, 0);
> +	input_set_capability(input, EV_KEY, BTN_TOUCH);
>  
> -	set_bit(EV_ABS, input->evbit);
> -	set_bit(EV_KEY, input->evbit);
> -	set_bit(BTN_TOUCH, input->keybit);
> +	error = input_setup_polling(input, ams_idev_poll);
> +	if (error)
> +		goto err_free_input;
>  
> -	error = input_register_polled_device(ams_info.idev);
> -	if (error) {
> -		input_free_polled_device(ams_info.idev);
> -		ams_info.idev = NULL;
> -		return error;
> -	}
> +	input_set_poll_interval(input, 25);
>  
> +	error = input_register_device(input);
> +	if (error)
> +		goto err_free_input;
> +
> +	ams_info.idev = input;
>  	joystick = true;
>  
>  	return 0;
> +
> +err_free_input:
> +	input_free_device(input);
> +	return error;
>  }
>  
>  static void ams_input_disable(void)
>  {
>  	if (ams_info.idev) {
> -		input_unregister_polled_device(ams_info.idev);
> -		input_free_polled_device(ams_info.idev);
> +		input_unregister_device(ams_info.idev);
>  		ams_info.idev = NULL;
>  	}
>  
> diff --git a/drivers/macintosh/ams/ams.h b/drivers/macintosh/ams/ams.h
> index fe8d596f9845..935bdd9cd9a6 100644
> --- a/drivers/macintosh/ams/ams.h
> +++ b/drivers/macintosh/ams/ams.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/i2c.h>
> -#include <linux/input-polldev.h>
> +#include <linux/input.h>
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> @@ -51,7 +51,7 @@ struct ams {
>  #endif
>  
>  	/* Joystick emulation */
> -	struct input_polled_dev *idev;
> +	struct input_dev *idev;
>  	__u16 bustype;
>  
>  	/* calibrated null values */
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
