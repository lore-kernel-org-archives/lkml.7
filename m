Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393115AbfJXJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:54:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49402 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393096AbfJXJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:54:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 23FF528FEF6
Subject: Re: [PATCH v6] platform/chrome: wilco_ec: Add Wilco EC keyboard
 backlight LEDs support
To:     Daniel Campello <campello@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Nick Crews <ncrews@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
References: <20191018120830.1.Id856c69b1fda0a9b2248218ea0cfb6919aa1cb0d@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3c8c22a0-db91-354f-d9b9-ef0d9b80641f@collabora.com>
Date:   Thu, 24 Oct 2019 11:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018120830.1.Id856c69b1fda0a9b2248218ea0cfb6919aa1cb0d@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Some few comments, mostly nits. In general I'm fine with it.

On 18/10/19 20:09, Daniel Campello wrote:
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/platform::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c
> 
> Some Wilco devices do not support a keyboard backlight. This
> is checked via wilco_ec_keyboard_leds_exist() in the core driver,
> and a platform_device will only be registered by the core if
> a backlight is supported.
> 
> After an EC reset the backlight could be in a non-PWM mode.
> Earlier in the boot sequence the BIOS should send a command to
> the EC to set the brightness, so things **should** be set up,
> but we double check in probe() as we query the initial brightness.
> If not set up, then set the brightness to 0.
> 
> Since the EC will never change the backlight level of its own accord,
> we don't need to implement a brightness_get() method.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
> v6 changes:
>  -Rebased patch
>  -Fixed bug related to request/response buffer pointers on
>  send_kbbl_mesg()
>  -Now sends WILCO_KBBL_SUBCMD_SET_STATE instead of
>  WILCO_KBBL_SUBCMD_GET_STATE command for  keyboard_led_set_brightness()
> 
> v5 changes:
>  -Rename the LED device to "platform::kbd_backlight", to
>  denote that this is the built-in system keyboard.
> 
> v4 changes:
>  -Call keyboard_led_set_brightness() directly within
>   initialize_brightness(), instead of calling the library function.
> 
> v3 changes:
>  -Since this behaves the same as the standard Chrome OS keyboard
>   backlight, rename the led device to "chromeos::kbd_backlight"
>  -Move wilco_ec_keyboard_backlight_exists() into core module, so
>   that the core does not depend upon the keyboard backlight driver.
>  -This required moving some code into wilco-ec.h
>  -Refactor out some common code in set_brightness() and
>   initialize_brightness()
> 
> v2 changes:
>  -Remove and fix uses of led vs LED in kconfig
>  -Assume BIOS initializes brightness, but double check in probe()
>  -Remove get_brightness() callback, as EC never changes brightness
>   by itself.
>  -Use a __packed struct as message instead of opaque array
>  -Add exported wilco_ec_keyboard_leds_exist() so the core driver
>   now only creates a platform _device if relevant
>  -Fix use of keyboard_led_set_brightness() since it can sleep
> 
>  drivers/platform/chrome/wilco_ec/Kconfig      |   9 +
>  drivers/platform/chrome/wilco_ec/Makefile     |   2 +
>  drivers/platform/chrome/wilco_ec/core.c       |  60 ++++++-

A general note: It's a cosmetic change but there is a description of the
platform devices added for core in the file header that is outdated

/*
 * Core driver for Wilco Embedded Controller
 *
 * Copyright 2018 Google LLC
 *
 * This is the entry point for the drivers that control the Wilco EC.
 * This driver is responsible for several tasks:
 * - Initialize the register interface that is used by wilco_ec_mailbox()
 * - Create a platform device which is picked up by the debugfs driver
 * - Create a platform device which is picked up by the RTC driver
 */

I am wondering if we should just remove that or be more generic instead of
listing all the platform devices because is easy to forget to update the list
and doesn't really apport anything.


>  .../chrome/wilco_ec/kbd_led_backlight.c       | 166 ++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h        |  38 ++++
>  5 files changed, 274 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
> 
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index 89007b0bc743..d4305bdc1890 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -29,6 +29,15 @@ config WILCO_EC_EVENTS
>  	  over ACPI, and a driver queues up the events to be read by a
>  	  userspace daemon from /dev/wilco_event using read() and poll().
> 
> +config WILCO_EC_KBD_BACKLIGHT
> +	tristate "Enable keyboard backlight control"
> +	depends on WILCO_EC
> +	help
> +	  If you say Y here, you get support to set the keyboard backlight
> +	  brightness. This happens via a standard LED driver that uses the
> +	  Wilco EC mailbox interface. A standard LED class device will
> +	  appear under /sys/class/leds/platform::kbd_backlight
> +
>  config WILCO_EC_TELEMETRY
>  	tristate "Enable querying telemetry data from EC"
>  	depends on WILCO_EC
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index bc817164596e..8f06bb3aa949 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -6,5 +6,7 @@ wilco_ec_debugfs-objs			:= debugfs.o
>  obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
>  wilco_ec_events-objs			:= event.o
>  obj-$(CONFIG_WILCO_EC_EVENTS)		+= wilco_ec_events.o
> +wilco_kbd_backlight-objs		:= kbd_led_backlight.o
> +obj-$(CONFIG_WILCO_EC_KBD_BACKLIGHT)	+= wilco_kbd_backlight.o
>  wilco_ec_telem-objs			:= telemetry.o
>  obj-$(CONFIG_WILCO_EC_TELEMETRY)	+= wilco_ec_telem.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 3724bf4b77c6..484c79b2d645 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -38,11 +38,47 @@ static struct resource *wilco_get_resource(struct platform_device *pdev,
>  				   dev_name(dev));
>  }
> 
> +/**
> + * wilco_ec_keyboard_backlight_exists() - Is the keyboad backlight supported?

typo: s/keyboad/keyboard

> + * @ec: EC device to query.
> + * @exists: Return value to fill in.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int wilco_ec_keyboard_backlight_exists(struct wilco_ec_device *ec,
> +					      bool *exists)
> +{
> +	struct wilco_ec_kbbl_msg request;
> +	struct wilco_ec_kbbl_msg response;
> +	struct wilco_ec_message msg;
> +	int ret;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.command = WILCO_EC_COMMAND_KBBL;
> +	request.subcmd = WILCO_KBBL_SUBCMD_GET_FEATURES;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.type = WILCO_EC_MSG_LEGACY;
> +	msg.request_data = &request;
> +	msg.request_size = sizeof(request);
> +	msg.response_data = &response;
> +	msg.response_size = sizeof(response);
> +
> +	ret = wilco_ec_mailbox(ec, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*exists = response.status != 0xFF;
> +
> +	return 0;
> +}
> +
>  static int wilco_ec_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct wilco_ec_device *ec;
>  	int ret;
> +	bool kbbl_exists;

nit: put this before 'int ret' to follow the reverse x-mas tree rule

> 
>  	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
>  	if (!ec)
> @@ -87,10 +123,29 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  		goto unregister_debugfs;
>  	}
> 
> +	/* Register child dev to be found by the keyboard backlight driver. */
> +	ret = wilco_ec_keyboard_backlight_exists(ec, &kbbl_exists);
> +	if (ret) {
> +		dev_err(ec->dev,
> +			"Failed checking keyboard backlight support: %d", ret);
> +		goto unregister_rtc;
> +	}
> +	if (kbbl_exists) {
> +		ec->kbbl_pdev = platform_device_register_data(dev,
> +						"wilco-kbd-backlight",
> +						PLATFORM_DEVID_AUTO, NULL, 0);
> +		if (IS_ERR(ec->kbbl_pdev)) {
> +			dev_err(dev,
> +				"Failed to create keyboard backlight pdev\n");

nit: s/pdev/platform device/ like the others just to be more coherent.

> +			ret = PTR_ERR(ec->kbbl_pdev);
> +			goto unregister_rtc;
> +		}
> +	}
> +
>  	ret = wilco_ec_add_sysfs(ec);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to create sysfs entries: %d", ret);
> -		goto unregister_rtc;
> +		goto unregister_kbbl;
>  	}
> 
>  	/* Register child device that will be found by the telemetry driver. */
> @@ -107,6 +162,8 @@ static int wilco_ec_probe(struct platform_device *pdev)
> 
>  remove_sysfs:
>  	wilco_ec_remove_sysfs(ec);
> +unregister_kbbl:
> +	platform_device_unregister(ec->kbbl_pdev);
>  unregister_rtc:
>  	platform_device_unregister(ec->rtc_pdev);
>  unregister_debugfs:
> @@ -121,6 +178,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
>  	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> 
>  	wilco_ec_remove_sysfs(ec);
> +	platform_device_unregister(ec->kbbl_pdev);
>  	platform_device_unregister(ec->telem_pdev);
>  	platform_device_unregister(ec->rtc_pdev);
>  	if (ec->debugfs_pdev)
> diff --git a/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
> new file mode 100644
> index 000000000000..bfd261cf3eb4
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Keyboard backlight LED driver for the Wilco Embedded Controller
> + *
> + * Copyright 2019 Google LLC
> + *
> + * The EC is in charge of controlling the keyboard backlight on
> + * the Wilco platform. We expose a standard LED class device at
> + * /sys/class/leds/platform::kbd_backlight. Power Manager normally
> + * controls the backlight by writing a percentage in range [0, 100]
> + * to the brightness property. This driver is modeled after the
> + * standard Chrome OS keyboard backlight driver at
> + * drivers/platform/chrome/cros_kbd_led_backlight.c
> + *
> + * Some Wilco devices do not support a keyboard backlight. This
> + * is checked via wilco_ec_keyboard_backlight_exists() in the core driver,
> + * and a platform_device will only be registered by the core if
> + * a backlight is supported.
> + *
> + * After an EC reset the backlight could be in a non-PWM mode.
> + * Earlier in the boot sequence the BIOS should send a command to
> + * the EC to set the brightness, so things **should** be set up,
> + * but we double check in probe() as we query the initial brightness.
> + * If not set up, then we set the brightness to KBBL_DEFAULT_BRIGHTNESS.
> + *
> + * Since the EC will never change the backlight level of its own accord,
> + * we don't need to implement a brightness_get() method.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME		"wilco-kbd-backlight"
> +
> +#define KBBL_DEFAULT_BRIGHTNESS	0
> +
> +struct wilco_keyboard_led_data {
> +	struct wilco_ec_device *ec;
> +	struct led_classdev keyboard;
> +};
> +
> +/* Send a request, get a response, and check that the response is good. */
> +static int send_kbbl_msg(struct wilco_ec_device *ec,
> +			 struct wilco_ec_kbbl_msg *request,
> +			 struct wilco_ec_kbbl_msg *response)
> +{
> +	struct wilco_ec_message msg;
> +	int ret;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.type = WILCO_EC_MSG_LEGACY;
> +	msg.request_data = request;
> +	msg.request_size = sizeof(*request);
> +	msg.response_data = response;
> +	msg.response_size = sizeof(*response);
> +
> +	ret = wilco_ec_mailbox(ec, &msg);
> +	if (ret < 0) {
> +		dev_err(ec->dev, "Failed sending brightness command: %d", ret);
> +		return ret;
> +	}
> +
> +	if (response->status) {
> +		dev_err(ec->dev,
> +			"EC reported failure sending brightness command: %d",
> +			response->status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* This may sleep because it uses wilco_ec_mailbox() */
> +static int keyboard_led_set_brightness(struct led_classdev *cdev,
> +				       enum led_brightness brightness)
> +{
> +	struct wilco_ec_kbbl_msg request;
> +	struct wilco_ec_kbbl_msg response;
> +	struct wilco_keyboard_led_data *data;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.command = WILCO_EC_COMMAND_KBBL;
> +	request.subcmd = WILCO_KBBL_SUBCMD_SET_STATE;
> +	request.mode = WILCO_KBBL_MODE_FLAG_PWM;
> +	request.percent = brightness;
> +
> +	data = container_of(cdev, struct wilco_keyboard_led_data, keyboard);
> +	return send_kbbl_msg(data->ec, &request, &response);
> +}
> +
> +/*
> + * Get the current brightness, ensuring that we are in PWM mode. If not
> + * in PWM mode, then the current brightness is meaningless, so set the
> + * brightness to KBBL_DEFAULT_BRIGHTNESS.
> + *
> + * Return: Final brightness of the keyboard, or negative error code on failure.
> + */
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

I am unsure about this warning. Why is useful this message?

> +	ret = keyboard_led_set_brightness(&data->keyboard,
> +					  KBBL_DEFAULT_BRIGHTNESS);
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
> +	data->keyboard.name = "platform::kbd_backlight";
> +	data->keyboard.max_brightness = 100;
> +	data->keyboard.flags = LED_CORE_SUSPENDRESUME;
> +	data->keyboard.brightness_set_blocking = keyboard_led_set_brightness;
> +	ret = initialize_brightness(data);
> +	if (ret < 0)
> +		return ret;
> +	data->keyboard.brightness = ret;
> +
> +	return devm_led_classdev_register(&pdev->dev, &data->keyboard);
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
> index ad03b586a095..54665afb1efd 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -29,6 +29,7 @@
>   * @data_size: Size of the data buffer used for EC communication.
>   * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
>   * @rtc_pdev: The child platform_device used by the RTC sub-driver.
> + * @kbbl_pdev: The child pdev used by the keyboard backlight sub-driver.

s/pdev/platform device/ like the others, please.

>   * @telem_pdev: The child platform_device used by the telemetry sub-driver.
>   */
>  struct wilco_ec_device {
> @@ -41,6 +42,7 @@ struct wilco_ec_device {
>  	size_t data_size;
>  	struct platform_device *debugfs_pdev;
>  	struct platform_device *rtc_pdev;
> +	struct platform_device *kbbl_pdev;
>  	struct platform_device *telem_pdev;
>  };
> 
> @@ -111,6 +113,42 @@ struct wilco_ec_message {
>  	void *response_data;
>  };
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

You should document all fields and the reserved ones are not documented. Run
kernel-doc to catch the errors.

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
>  /**
>   * wilco_ec_mailbox() - Send request to the EC and receive the response.
>   * @ec: Wilco EC device.
> --
> 2.23.0.866.gb869b98d4c-goog
> 

Thanks,
 Enric
