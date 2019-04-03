Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2342DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE36206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMYTg0Cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDCR2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:28:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45762 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:28:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so15584699ljd.12;
        Wed, 03 Apr 2019 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZwn6zCMWjyJYUZbeTFJ7qnd2UEiX4xbjELOyB0FCx8=;
        b=CMYTg0CrZ+EoQely3psfdB7Xv/t60PHnINrkt+k01fC02OahV43szJ7og1+ufaSuZ0
         EEadZ4IQNSXqW6x6ZTQ81+F4xDZy+hFy9ELdmCt+urLDcIGkrr6WfytJByulht1flSmS
         ku4xES/naIvLZTcdE/qMhNkLlRB1Mz3jGNEbckmY/DfLsDnc6x4oRajUmWKPGBA5KbGU
         7bAHq9eHIUVok+AIu+bj+2WWOxabtREnN3/4NGqwdf1ESK/11F7tRBw+44GGw1h8JfJn
         kebRf3cW8cf9KPkwqGKB+nAS5uXbr5dNSD4SEsFTlvLTPHc3i7f3rYBOYgNjaWdBtIPB
         02Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZwn6zCMWjyJYUZbeTFJ7qnd2UEiX4xbjELOyB0FCx8=;
        b=TZw9n0w7bLS/KNfRmuJBBvAIFDhJuK+kmhA0xjywhDypgP01YVkhWeF3d//TRm9SJE
         RPvY2PtoZ0AwlU4IMo9e3avGnN/XIoewW8yh2wXJKdoP1ELto56txuFZl267fnpJw10w
         3LDKS2u8xLXpqgMKJv5lFUQyxO+WfNNNwkjttQcYkOAElfgbSbXxhR6s26cy8ly/OKRx
         hO40tKyOQ0gzAU8JYpxreq6kuMaEjWCeXfUsuMUm4R2SJaDb/70KG2EGGZ6maiNr6Ub/
         DnMrlcFw4VnMVlraoy4AFaziFMCZAZmXeHtIC2o7glgw9DCdsQG3kwfwmq/P0hzO/nsQ
         smyA==
X-Gm-Message-State: APjAAAW2Cu185doOi1HDqay2TG7WQn68JAIsdLKbMCIOmwTU61IOf4mV
        MuoWoOW3kgpmjikyZ+YH+pM=
X-Google-Smtp-Source: APXvYqxqOvrBol4yRBbGMRD4ZTZkUBtNkF578bjG47xDvYYUcu2h0NLyNn/lX36fMmUTsNTnEa+4TQ==
X-Received: by 2002:a2e:6507:: with SMTP id z7mr539976ljb.147.1554312516981;
        Wed, 03 Apr 2019 10:28:36 -0700 (PDT)
Received: from [192.168.1.19] (bkr161.neoplus.adsl.tpnet.pl. [83.28.185.161])
        by smtp.gmail.com with ESMTPSA id w22sm3367917ljd.42.2019.04.03.10.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:28:36 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
To:     Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        bleung@chromium.org, linux-leds@vger.kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com
References: <20190403020519.211483-1-ncrews@chromium.org>
 <20190403020519.211483-2-ncrews@chromium.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0243c78a-e2e5-1d88-f087-208a46dcfd49@gmail.com>
Date:   Wed, 3 Apr 2019 19:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403020519.211483-2-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thank you for the patch.

I have one comment for the kbd_led_backlight.c

On 4/3/19 4:05 AM, Nick Crews wrote:
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/chromeos::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c
[...]
> +++ b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
[,,,]
> +static int initialize_brightness(struct wilco_keyboard_led_data *data)
> +{
> +	struct wilco_ec_kbbl_msg request;
> +	struct wilco_ec_kbbl_msg response;
> +	int ret;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.command = WILCO_EC_COMMAND_KBBL;
> +	request.subcmd = WILCO_KBBL_SUBCMD_GET_STATE;
> +
> +	ret = send_kbbl_msg(data->ec, &request, &response);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (response.mode & WILCO_KBBL_MODE_FLAG_PWM)
> +		return response.percent;
> +
> +	dev_warn(data->ec->dev, "Keyboard brightness not initialized by BIOS");
> +	ret = led_set_brightness_sync(&data->keyboard, KBBL_DEFAULT_BRIGHTNESS);

This is a bit weird. led_set_brightness_sync() has been introduced
specifically for use cases when torch setting should have guaranteed
immediate effect like in case of
drivers/media/v4l2-core/v4l2-flash-led-class.c (this is actually its
sole user). It bypasses internal LED core workqueue. While its use
here is not incorrect per se, it is of no avail to use public LED
subsystem API just for calling brightness_set_blocking op initialized
also in this driver.

Just call keyboard_led_set_brightness() directly.

With that:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

> +	if (ret < 0)
> +		return ret;
> +
> +	return KBBL_DEFAULT_BRIGHTNESS;
> +}
> +
> +static int keyboard_led_probe(struct platform_device *pdev)
> +{
> +	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +	struct wilco_keyboard_led_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ec = ec;
> +	/* This acts the same as the CrOS backlight, so use the same name */
> +	data->keyboard.name = "chromeos::kbd_backlight";
> +	data->keyboard.max_brightness = 100;
> +	data->keyboard.flags = LED_CORE_SUSPENDRESUME;
> +	data->keyboard.brightness_set_blocking = keyboard_led_set_brightness;
> +	ret = initialize_brightness(data);
> +	if (ret < 0)
> +		return ret;
> +	data->keyboard.brightness = ret;
> +
> +	ret = devm_led_classdev_register(&pdev->dev, &data->keyboard);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver keyboard_led_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = keyboard_led_probe,
> +};
> +module_platform_driver(keyboard_led_driver);
> +
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_DESCRIPTION("Wilco keyboard backlight LED driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 1ff224793c99..c3965b7f397d 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -32,6 +32,7 @@
>    * @data_size: Size of the data buffer used for EC communication.
>    * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
>    * @rtc_pdev: The child platform_device used by the RTC sub-driver.
> + * @kbbl_pdev: The child pdev used by the keyboard backlight sub-driver.
>    */
>   struct wilco_ec_device {
>   	struct device *dev;
> @@ -43,6 +44,7 @@ struct wilco_ec_device {
>   	size_t data_size;
>   	struct platform_device *debugfs_pdev;
>   	struct platform_device *rtc_pdev;
> +	struct platform_device *kbbl_pdev;
>   };
>   
>   /**
> @@ -114,6 +116,42 @@ struct wilco_ec_message {
>   	void *response_data;
>   };
>   
> +/* Constants and structs useful for keyboard backlight (KBBL) control */
> +
> +#define WILCO_EC_COMMAND_KBBL		0x75
> +#define WILCO_KBBL_MODE_FLAG_PWM	BIT(1)	/* Set brightness by percent. */
> +
> +/**
> + * enum kbbl_subcommand - What action does the EC perform?
> + * @WILCO_KBBL_SUBCMD_GET_FEATURES: Request available functionality from EC.
> + * @WILCO_KBBL_SUBCMD_GET_STATE: Request current mode and brightness from EC.
> + * @WILCO_KBBL_SUBCMD_SET_STATE: Write mode and brightness to EC.
> + */
> +enum kbbl_subcommand {
> +	WILCO_KBBL_SUBCMD_GET_FEATURES = 0x00,
> +	WILCO_KBBL_SUBCMD_GET_STATE = 0x01,
> +	WILCO_KBBL_SUBCMD_SET_STATE = 0x02,
> +};
> +
> +/**
> + * struct wilco_ec_kbbl_msg - Message to/from EC for keyboard backlight control.
> + * @command: Always WILCO_EC_COMMAND_KBBL.
> + * @status: Set by EC to 0 on success, 0xFF on failure.
> + * @subcmd: One of enum kbbl_subcommand.
> + * @mode: Bit flags for used mode, we want to use WILCO_KBBL_MODE_FLAG_PWM.
> + * @percent: Brightness in 0-100. Only meaningful in PWM mode.
> + */
> +struct wilco_ec_kbbl_msg {
> +	u8 command;
> +	u8 status;
> +	u8 subcmd;
> +	u8 reserved3;
> +	u8 mode;
> +	u8 reserved5to8[4];
> +	u8 percent;
> +	u8 reserved10to15[6];
> +} __packed;
> +
>   /**
>    * wilco_ec_mailbox() - Send request to the EC and receive the response.
>    * @ec: Wilco EC device.
> 

-- 
Best regards,
Jacek Anaszewski
