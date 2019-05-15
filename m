Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB22C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0343F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD7F8NkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEOVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:37:01 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36802 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:37:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id m10so426620ybk.3;
        Wed, 15 May 2019 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TGlHdNbaUavizVPad8uvTIa0TMfO/6wQGg/29yOsRfQ=;
        b=PD7F8NkEI2l9XRGhBQTSQDnFxH9dbRa2tBb8lga3ieCsm3h5Tx8lU7gw5I4fphWvJr
         4Z+g/KEssQvQrIlowrSWkPywUITEFTRbaBP1nRMsL9k/FblUUXbkezyXxcK66BKpHMc5
         G5lx7m89ujhEq3lLgklWnv1ILxwlbjH+0swQT1NIxuUMe5GydYnHgEdQbjQec8zxRqwm
         oFNyzg1zpG6JxosGWk33at8mrrJVObeSanEQdKLEIikDBYTrsJn7toql4qB7Kj7IRtsg
         IExKSgnFgbTdzdjGubsqgW8Fit4mul6j2lTj26Rz6gTmjA+ZwM0tdJ5CyVU/PSvi0VIm
         Phbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TGlHdNbaUavizVPad8uvTIa0TMfO/6wQGg/29yOsRfQ=;
        b=XcLeUjUjQgESCtz3G060U5vX32H1ucvK4kIDW/GnB4U7K+cjPz98VbeE0+NDUEn6Mx
         MHP6u3B+yWlLiQKgUhg6csY9Zf1NFVmifknixq726Nu4dN3ktsqZxT4DaNacrBQ2ptVV
         cYYJ6j41/q75lATymuVVH9/Zz2kH5cKhekOjVM/vSa8qBwr9gqjSt9jyp9RAvK34r5IB
         Igejwd35Pt0cdhA0fI40GDfrsVzdb9cgl+e5j3XBOjEF189KhKwjL6qgJmv0s4+hNkV7
         5SkXZGLjwa1NnSyCAvwGk98ixipI3f1KAJ1urE4Uf7DUFPH6ZucdXYhMRVehvUCDdttT
         P5AQ==
X-Gm-Message-State: APjAAAUUU0wAaWn4A/0C/JTBfye1vwRoEa4NZPM/JqN5EM6mTsU6QeZh
        Il7xNQrpd0yVdhLdVE1fGA==
X-Google-Smtp-Source: APXvYqwiT8+qdSHYQ2JSOCdXDRdnDfpBps8gMTVxi4Nnm8KLiWDomyzQWBYhuzCVKKJ2NaBFMxkjRg==
X-Received: by 2002:a25:2556:: with SMTP id l83mr21645359ybl.107.1557956218798;
        Wed, 15 May 2019 14:36:58 -0700 (PDT)
Received: from 960 ([69.41.96.247])
        by smtp.gmail.com with ESMTPSA id c85sm1880009ywa.90.2019.05.15.14.36.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:36:58 -0700 (PDT)
Message-ID: <0e515145338f078ac87525aad2f599f3614088ba.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] platform/x86: Huawei WMI laptop extras driver
 update
From:   ayman.bagabas@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Wed, 15 May 2019 17:36:56 -0400
In-Reply-To: <s5hlfz7j21s.wl-tiwai@suse.de>
References: <20190513203009.28686-1-ayman.bagabas@gmail.com>
         <20190513203009.28686-2-ayman.bagabas@gmail.com>
         <s5hlfz7j21s.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 15:10 +0200, Takashi Iwai wrote:
> On Mon, 13 May 2019 22:30:05 +0200,
> Ayman Bagabas wrote:
> > This update brings on the use of WMI BIOS management interface
> > found on
> > Huawei laptops. This interface can control the micmute LED found on
> > most
> > of these laptops, control charging thresholds values, and control
> > fn-lock feature.
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> You need to put the actual change (e.g. moving to the platform
> driver)
> here as well, not only in the cover letter.

I will put a detailed explanation in the second version.

> 
> But I wonder what the actual motivation to move to the platform
> driver...
> 

This patch adds another platform driver with the same name,
"huawei-wmi", along with the existing wmi input driver. So the driver
registers two drivers platform and wmi. The reason behind this is
that they both use ACPI WMI and two drivers with the same type/bus
cannot have the same name.

The way this works is, input driver hooks to wmi event guids
while the other uses wmi method guid. Most existing x86 drivers with
similar structure use only one platform driver. At first, my
approach was combining all these together in one wmi driver.
However, I couldn't find a way to differentiate which wmi device
belong to which guid in wmi driver probe method. I could've moved
everything to the platform driver but the wmi driver handles input
very neatly.

So with this "new" platform driver, micmute led is now controlled
through wmi interface instead of ACPI EC which should work with
all huawei laptops. In addition, two features were added, setting
charging thresholds and fn-lock.

I know having two drivers in one file might not be a good idea,
should
it be one platform driver instead?

Thank you,
Ayman

> 
> thanks,
> 
> Takashi
> 
> > ---
> >  drivers/platform/x86/Kconfig      |   8 +-
> >  drivers/platform/x86/huawei-wmi.c | 578 +++++++++++++++++++++++++-
> > ----
> >  2 files changed, 500 insertions(+), 86 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index a1ed13183559..e46261b6def5 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1287,7 +1287,7 @@ config INTEL_ATOMISP2_PM
> >  	  will be called intel_atomisp2_pm.
> >  
> >  config HUAWEI_WMI
> > -	tristate "Huawei WMI hotkeys driver"
> > +	tristate "Huawei WMI laptop extras driver"
> >  	depends on ACPI_WMI
> >  	depends on INPUT
> >  	select INPUT_SPARSEKMAP
> > @@ -1296,9 +1296,9 @@ config HUAWEI_WMI
> >  	select LEDS_TRIGGER_AUDIO
> >  	select NEW_LEDS
> >  	help
> > -	  This driver provides support for Huawei WMI hotkeys.
> > -	  It enables the missing keys and adds support to the micmute
> > -	  LED found on some of these laptops.
> > +	  This driver provides support for some extra features found on
> > Huawei
> > +	  laptops that are controlled through WMI. These features are
> > keyboard
> > +	  hotkeys, micmute LED, charging thresholds, and fn-lock state.
> >  
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called huawei-wmi.
> > diff --git a/drivers/platform/x86/huawei-wmi.c
> > b/drivers/platform/x86/huawei-wmi.c
> > index 52fcac5b393a..4ec04196f386 100644
> > --- a/drivers/platform/x86/huawei-wmi.c
> > +++ b/drivers/platform/x86/huawei-wmi.c
> > @@ -1,32 +1,63 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - *  Huawei WMI hotkeys
> > + *  Huawei WMI laptop extras driver
> >   *
> >   *  Copyright (C) 2018	      Ayman Bagabas <
> > ayman.bagabas@gmail.com>
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/dmi.h>
> >  #include <linux/input.h>
> >  #include <linux/input/sparse-keymap.h>
> >  #include <linux/leds.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sysfs.h>
> >  #include <linux/wmi.h>
> >  
> >  /*
> >   * Huawei WMI GUIDs
> >   */
> > -#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
> > +#define AMW0_METHOD_GUID "ABBC0F5B-8EA1-11D1-A000-C90629100000"
> >  #define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
> >  
> > +/* Legacy GUIDs */
> >  #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
> > +#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
> >  
> > -struct huawei_wmi_priv {
> > -	struct input_dev *idev;
> > +/* AMW0_commands */
> > +
> > +enum wmaa_cmd {
> > +	BATTERY_GET, /* \GBTT 0x00001103 */
> > +	BATTERY_SET, /* \SBTT 0xXXYY1003 */
> > +	FN_LOCK_GET, /* \GFRS 0x00000604 */
> > +	FN_LOCK_SET, /* \SFRS 0x000X0704 */
> > +	MICMUTE_LED, /* \SMLS 0x000X0b04 */
> > +};
> > +
> > +enum fn_state {
> > +	FN_LOCK_OFF = 0x01,
> > +	FN_LOCK_ON = 0x02,
> > +};
> > +
> > +struct quirk_entry {
> > +	bool battery_reset;
> > +	bool ec_micmute;
> > +};
> > +
> > +static struct quirk_entry *quirks;
> > +
> > +struct huawei_wmi {
> >  	struct led_classdev cdev;
> > -	acpi_handle handle;
> > -	char *acpi_method;
> > +	struct mutex wmi_lock;
> > +	struct mutex battery_lock;
> > +	struct platform_device *pdev;
> >  };
> >  
> > +struct platform_device *huawei_wmi_pdev;
> > +
> >  static const struct key_entry huawei_wmi_keymap[] = {
> >  	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
> >  	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
> > @@ -37,73 +68,169 @@ static const struct key_entry
> > huawei_wmi_keymap[] = {
> >  	{ KE_KEY,    0x289, { KEY_WLAN } },
> >  	// Huawei |M| key
> >  	{ KE_KEY,    0x28a, { KEY_CONFIG } },
> > -	// Keyboard backlight
> > +	// Keyboard backlit
> >  	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
> >  	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
> >  	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
> >  	{ KE_END,	 0 }
> >  };
> >  
> > -static int huawei_wmi_micmute_led_set(struct led_classdev
> > *led_cdev,
> > -		enum led_brightness brightness)
> > +/* Quirks */
> > +
> > +static int __init dmi_matched(const struct dmi_system_id *dmi)
> >  {
> > -	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev-
> > >parent);
> > +	quirks = dmi->driver_data;
> > +	return 1;
> > +}
> > +
> > +static struct quirk_entry quirk_battery_reset = {
> > +	.battery_reset = true,
> > +};
> > +
> > +static struct quirk_entry quirk_ec_micmute = {
> > +	.ec_micmute = true,
> > +};
> > +
> > +static const struct dmi_system_id huawei_quirks[] = {
> > +	{
> > +		.callback = dmi_matched,
> > +		.ident = "Huawei MACH-WX9",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "MACH-WX9"),
> > +		},
> > +		.driver_data = &quirk_battery_reset
> > +	},
> > +	{
> > +		.callback = dmi_matched,
> > +		.ident = "Huawei MateBook X",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HUAWEI MateBook
> > X")
> > +		},
> > +		.driver_data = &quirk_ec_micmute
> > +	}
> > +};
> > +
> > +/* Utils */
> > +
> > +static int huawei_wmi_eval(struct device *dev, char *arg,
> > +		char *buf, size_t buflen)
> > +{
> > +	struct huawei_wmi *huawei = dev_get_drvdata(dev);
> > +	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	struct acpi_buffer in;
> > +	union acpi_object *obj;
> >  	acpi_status status;
> > -	union acpi_object args[3];
> > -	struct acpi_object_list arg_list = {
> > -		.pointer = args,
> > -		.count = ARRAY_SIZE(args),
> > -	};
> > -
> > -	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> > -	args[1].integer.value = 0x04;
> > -
> > -	if (strcmp(priv->acpi_method, "SPIN") == 0) {
> > -		args[0].integer.value = 0;
> > -		args[2].integer.value = brightness ? 1 : 0;
> > -	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
> > -		args[0].integer.value = 1;
> > -		args[2].integer.value = brightness ? 0 : 1;
> > -	} else {
> > -		return -EINVAL;
> > +	size_t len;
> > +	int err = -ENODEV;
> > +
> > +	in.length = sizeof(char) * 4;
> > +	in.pointer = (u32 *)arg;
> > +	mutex_lock(&huawei->wmi_lock);
> > +	status = wmi_evaluate_method(AMW0_METHOD_GUID, 0, 1, &in,
> > &out);
> > +	if (ACPI_FAILURE(status)) {
> > +		dev_err(dev, "Failed to evaluate wmi method\n");
> > +		goto wmi_eval_fail;
> >  	}
> >  
> > -	status = acpi_evaluate_object(priv->handle, priv->acpi_method,
> > &arg_list, NULL);
> > -	if (ACPI_FAILURE(status))
> > -		return -ENXIO;
> > +	/* WMAA takes a 4 bytes buffer as an input. It returns a
> > package
> > +	 * with two buffer elements. The first buffer is 4 bytes long
> > and
> > +	 * the second is 0x100 (256) bytes long. The first buffer is
> > always
> > +	 * zeros. The second stores the output from every call. The
> > first
> > +	 * byte of the second buffer always have the return status of
> > the
> > +	 * called command.
> > +	 */
> > +	obj = out.pointer;
> > +	if (!obj)
> > +		goto wmi_eval_fail;
> > +	if (obj->type != ACPI_TYPE_PACKAGE ||
> > +			obj->package.count != 2) {
> > +		dev_err(dev, "Unknown response type %d\n", obj->type);
> > +		goto wmi_eval_fail;
> > +	}
> >  
> > -	return 0;
> > +	obj = &(obj->package.elements[1]);
> > +	if (!obj || obj->type != ACPI_TYPE_BUFFER)
> > +		goto wmi_eval_fail;
> > +
> > +	if (buf) {
> > +		len = min(buflen, obj->buffer.length);
> > +		memcpy(buf, obj->buffer.pointer, len);
> > +	}
> > +	err = 0;
> > +
> > +wmi_eval_fail:
> > +	mutex_unlock(&huawei->wmi_lock);
> > +	kfree(out.pointer);
> > +	return err;
> >  }
> >  
> > -static int huawei_wmi_leds_setup(struct wmi_device *wdev)
> > +static int huawei_wmi_cmd(struct device *dev, enum wmaa_cmd cmd,
> > char *arg,
> > +		char *out, size_t outlen)
> >  {
> > -	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > -
> > -	priv->handle = ec_get_handle();
> > -	if (!priv->handle)
> > -		return 0;
> > +	char parm[4] = { 0 };
> > +	char buf[0x100] = { 0xff };
> > +	int err;
> >  
> > -	if (acpi_has_method(priv->handle, "SPIN"))
> > -		priv->acpi_method = "SPIN";
> > -	else if (acpi_has_method(priv->handle, "WPIN"))
> > -		priv->acpi_method = "WPIN";
> > -	else
> > -		return 0;
> > +	if (!arg)
> > +		arg = parm;
> > +
> > +	switch (cmd) {
> > +	case BATTERY_SET:
> > +		arg[0] = 0x03;
> > +		arg[1] = 0x10;
> > +		break;
> > +	case BATTERY_GET:
> > +		arg[0] = 0x03;
> > +		arg[1] = 0x11;
> > +		break;
> > +	case FN_LOCK_GET:
> > +		arg[0] = 0x04;
> > +		arg[1] = 0x06;
> > +		break;
> > +	case FN_LOCK_SET:
> > +		arg[0] = 0x04;
> > +		arg[1] = 0x07;
> > +		break;
> > +	case MICMUTE_LED:
> > +		arg[0] = 0x04;
> > +		arg[1] = 0x0b;
> > +		break;
> > +	default:
> > +		dev_err(dev, "Command not supported\n");
> > +		return -EINVAL;
> > +	}
> >  
> > -	priv->cdev.name = "platform::micmute";
> > -	priv->cdev.max_brightness = 1;
> > -	priv->cdev.brightness_set_blocking =
> > huawei_wmi_micmute_led_set;
> > -	priv->cdev.default_trigger = "audio-micmute";
> > -	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > -	priv->cdev.dev = &wdev->dev;
> > -	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
> > +	/* Some models require calling WMAA twice to execute
> > +	 * a command. We call WMAA and if we get a non-zero return
> > +	 * status we evaluate WMAA again. If we get another non-zero
> > +	 * return, we return -ENXIO. This way we don't need to
> > +	 * check for return status anywhere we call huawei_wmi_cmd.
> > +	 */
> > +	err = huawei_wmi_eval(dev, arg, buf, 0x100);
> > +	if (err)
> > +		return err;
> > +	if (buf[0]) {
> > +		err = huawei_wmi_eval(dev, arg, buf, 0x100);
> > +		if (err)
> > +			return err;
> > +		if (buf[0]) {
> > +			dev_err(dev, "Invalid command, got: %d\n",
> > buf[0]);
> > +			return -ENXIO;
> > +		}
> > +	}
> > +	if (out)
> > +		memcpy(out, buf, outlen);
> >  
> > -	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
> > +	return 0;
> >  }
> >  
> > +/* Input */
> > +
> >  static void huawei_wmi_process_key(struct wmi_device *wdev, int
> > code)
> >  {
> > -	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +	struct input_dev *idev = dev_get_drvdata(&wdev->dev);
> >  	const struct key_entry *key;
> >  
> >  	/*
> > @@ -127,16 +254,16 @@ static void huawei_wmi_process_key(struct
> > wmi_device *wdev, int code)
> >  		kfree(response.pointer);
> >  	}
> >  
> > -	key = sparse_keymap_entry_from_scancode(priv->idev, code);
> > +	key = sparse_keymap_entry_from_scancode(idev, code);
> >  	if (!key) {
> >  		dev_info(&wdev->dev, "Unknown key pressed, code:
> > 0x%04x\n", code);
> >  		return;
> >  	}
> >  
> > -	sparse_keymap_report_entry(priv->idev, key, 1, true);
> > +	sparse_keymap_report_entry(idev, key, 1, true);
> >  }
> >  
> > -static void huawei_wmi_notify(struct wmi_device *wdev,
> > +static void huawei_wmi_input_notify(struct wmi_device *wdev,
> >  		union acpi_object *obj)
> >  {
> >  	if (obj->type == ACPI_TYPE_INTEGER)
> > @@ -147,61 +274,348 @@ static void huawei_wmi_notify(struct
> > wmi_device *wdev,
> >  
> >  static int huawei_wmi_input_setup(struct wmi_device *wdev)
> >  {
> > -	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> > +	struct input_dev *idev;
> >  	int err;
> >  
> > -	priv->idev = devm_input_allocate_device(&wdev->dev);
> > -	if (!priv->idev)
> > +	idev = devm_input_allocate_device(&wdev->dev);
> > +	if (!idev)
> >  		return -ENOMEM;
> >  
> > -	priv->idev->name = "Huawei WMI hotkeys";
> > -	priv->idev->phys = "wmi/input0";
> > -	priv->idev->id.bustype = BUS_HOST;
> > -	priv->idev->dev.parent = &wdev->dev;
> > +	dev_set_drvdata(&wdev->dev, idev);
> >  
> > -	err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
> > +	idev->name = "Huawei WMI hotkeys";
> > +	idev->phys = "wmi/input0";
> > +	idev->id.bustype = BUS_HOST;
> > +	idev->dev.parent = &wdev->dev;
> > +
> > +	err = sparse_keymap_setup(idev, huawei_wmi_keymap, NULL);
> >  	if (err)
> >  		return err;
> >  
> > -	return input_register_device(priv->idev);
> > +	return input_register_device(idev);
> >  }
> >  
> > -static int huawei_wmi_probe(struct wmi_device *wdev)
> > +static int huawei_wmi_input_destroy(struct wmi_device *wdev)
> > +{
> > +	struct input_dev *idev = dev_get_drvdata(&wdev->dev);
> > +
> > +	input_unregister_device(idev);
> > +	return 0;
> > +}
> > +
> > +static const struct wmi_device_id huawei_wmi_input_id_table[] = {
> > +	{ .guid_string = WMI0_EVENT_GUID },
> > +	{ .guid_string = AMW0_EVENT_GUID },
> > +	{  }
> > +};
> > +
> > +static struct wmi_driver huawei_wmi_input_driver = {
> > +	.driver = {
> > +		.name = "huawei-wmi",
> > +	},
> > +	.id_table = huawei_wmi_input_id_table,
> > +	.probe = huawei_wmi_input_setup,
> > +	.remove = huawei_wmi_input_destroy,
> > +	.notify = huawei_wmi_input_notify,
> > +};
> > +
> > +/* LEDs */
> > +
> > +static void huawei_wmi_micmute_led_set(struct led_classdev
> > *led_cdev,
> > +		enum led_brightness brightness)
> >  {
> > -	struct huawei_wmi_priv *priv;
> > +	if (quirks && quirks->ec_micmute) {
> > +		char *acpi_method;
> > +		acpi_handle handle;
> > +		union acpi_object args[3];
> > +		struct acpi_object_list arg_list = {
> > +			.pointer = args,
> > +			.count = ARRAY_SIZE(args),
> > +		};
> > +
> > +		handle = ec_get_handle();
> > +		if (!handle) {
> > +			dev_err(led_cdev->dev->parent, "Failed to get
> > EC handle\n");
> > +			return;
> > +		}
> > +
> > +		args[0].type = args[1].type = args[2].type =
> > ACPI_TYPE_INTEGER;
> > +		args[1].integer.value = 0x04;
> > +
> > +		if (acpi_has_method(handle, "SPIN")) {
> > +			acpi_method = "SPIN";
> > +			args[0].integer.value = 0;
> > +			args[2].integer.value = brightness ? 1 : 0;
> > +		} else if (acpi_has_method(handle, "WPIN")) {
> > +			acpi_method = "WPIN";
> > +			args[0].integer.value = 1;
> > +			args[2].integer.value = brightness ? 0 : 1;
> > +		} else {
> > +			return;
> > +		}
> > +
> > +		acpi_evaluate_object(handle, acpi_method, &arg_list,
> > NULL);
> > +	} else {
> > +		char arg[] = { 0, 0, brightness, 0 };
> > +
> > +		huawei_wmi_cmd(led_cdev->dev->parent, MICMUTE_LED, arg,
> > NULL, NULL);
> > +	}
> > +}
> > +
> > +static int huawei_wmi_leds_setup(struct device *dev)
> > +{
> > +	struct huawei_wmi *huawei = dev_get_drvdata(dev);
> > +
> > +	huawei->cdev.name = "platform::micmute";
> > +	huawei->cdev.max_brightness = 1;
> > +	huawei->cdev.brightness_set = huawei_wmi_micmute_led_set;
> > +	huawei->cdev.default_trigger = "audio-micmute";
> > +	huawei->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > +	huawei->cdev.dev = dev->parent;
> > +	huawei->cdev.flags = LED_CORE_SUSPENDRESUME;
> > +
> > +	return devm_led_classdev_register(dev, &huawei->cdev);
> > +}
> > +
> > +/* Battery protection */
> > +
> > +static int huawei_wmi_battery_get(struct device *dev, int *low,
> > int *high)
> > +{
> > +	struct huawei_wmi *huawei = dev_get_drvdata(dev);
> > +	char ret[0x100] = { 0 };
> > +	int err, i;
> > +
> > +	mutex_lock(&huawei->battery_lock);
> > +	err = huawei_wmi_cmd(dev, BATTERY_GET, NULL, ret, 0x100);
> > +	mutex_unlock(&huawei->battery_lock);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	/* Returned buffer positions battery thresholds either in index
> > +	 * 3 and 2 or in 2 and 1. 0 reserved for return status.
> > +	 */
> > +	for (i = 0x100 - 1; i > 0; i--) {
> > +		if (ret[i]) {
> > +			*high = ret[i];
> > +			*low = ret[i-1];
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int huawei_wmi_battery_set(struct device *dev, int low, int
> > high)
> > +{
> > +	struct huawei_wmi *huawei = dev_get_drvdata(dev);
> > +	char arg[] = { 0, 0, low, high };
> >  	int err;
> >  
> > -	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv),
> > GFP_KERNEL);
> > -	if (!priv)
> > +	/* This is an edge case were some models turn battery
> > protection
> > +	 * off without changing their thresholds values. We clear the
> > +	 * values before turning off protection. We need wait blocking
> > to
> > +	 * make sure these values make its way to EC.
> > +	 */
> > +	if (low == 0 && high == 100)
> > +		huawei_wmi_battery_set(dev, 0, 0);
> > +
> > +	mutex_lock(&huawei->battery_lock);
> > +	err = huawei_wmi_cmd(dev, BATTERY_SET, arg, NULL, NULL);
> > +	if (quirks && quirks->battery_reset)
> > +		msleep(jiffies_to_msecs(0.5 * HZ));
> > +	mutex_unlock(&huawei->battery_lock);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Fn lock */
> > +
> > +static int huawei_wmi_fn_lock_get(struct device *dev, int *on)
> > +{
> > +	char ret[0x100] = { 0 };
> > +	int err, i;
> > +
> > +	err = huawei_wmi_cmd(dev, FN_LOCK_GET, NULL, ret, 0x100);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	for (i = 0x100 - 1; i > 0; i--) {
> > +		if (ret[i]) {
> > +			*on = (ret[i] == FN_LOCK_OFF) ? 0 : 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int huawei_wmi_fn_lock_set(struct device *dev, int on)
> > +{
> > +	char arg[] = { 0, 0, (on) ? FN_LOCK_ON : FN_LOCK_OFF, 0 };
> > +
> > +	return huawei_wmi_cmd(dev, FN_LOCK_SET, arg, NULL, NULL);
> > +}
> > +
> > +/* sysfs */
> > +
> > +static ssize_t charge_thresholds_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t size)
> > +{
> > +	int low, high;
> > +
> > +	if (sscanf(buf, "%d %d", &low, &high) != 2 ||
> > +			low < 0 || high > 100 ||
> > +			low > high ||
> > +			huawei_wmi_battery_set(dev, low, high))
> > +		return -EINVAL;
> > +
> > +	return size;
> > +}
> > +
> > +static ssize_t fn_lock_state_store(struct device *dev,
> > +		struct device_attribute *attr,
> > +		const char *buf, size_t size)
> > +{
> > +	int on;
> > +
> > +	if (kstrtoint(buf, 10, &on) ||
> > +			on < 0 || on > 1 ||
> > +			huawei_wmi_fn_lock_set(dev, on))
> > +		return -EINVAL;
> > +
> > +	return size;
> > +}
> > +
> > +static ssize_t charge_thresholds_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	int err, low, high;
> > +
> > +	low = high = 0;
> > +	err = huawei_wmi_battery_get(dev, &low, &high);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	return sprintf(buf, "%d %d\n", low, high);
> > +}
> > +
> > +static ssize_t fn_lock_state_show(struct device *dev,
> > +		struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	int err, on;
> > +
> > +	on = 0;
> > +	err = huawei_wmi_fn_lock_get(dev, &on);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	return sprintf(buf, "%d\n", on);
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_thresholds);
> > +static DEVICE_ATTR_RW(fn_lock_state);
> > +
> > +static struct attribute *huawei_wmi_attrs[] = {
> > +	&dev_attr_charge_thresholds.attr,
> > +	&dev_attr_fn_lock_state.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group huawei_wmi_group = {
> > +	.attrs = huawei_wmi_attrs
> > +};
> > +
> > +static int huawei_wmi_probe(struct platform_device *pdev)
> > +{
> > +	struct huawei_wmi *huawei;
> > +	int err;
> > +
> > +	huawei = devm_kzalloc(&pdev->dev, sizeof(struct huawei_wmi),
> > GFP_KERNEL);
> > +	if (!huawei)
> >  		return -ENOMEM;
> >  
> > -	dev_set_drvdata(&wdev->dev, priv);
> > +	huawei->pdev = pdev;
> > +	dev_set_drvdata(&pdev->dev, huawei);
> > +	mutex_init(&huawei->wmi_lock);
> > +	mutex_init(&huawei->battery_lock);
> >  
> > -	err = huawei_wmi_input_setup(wdev);
> > +	err = sysfs_create_group(&pdev->dev.kobj, &huawei_wmi_group);
> >  	if (err)
> >  		return err;
> >  
> > -	return huawei_wmi_leds_setup(wdev);
> > +	return huawei_wmi_leds_setup(&pdev->dev);
> >  }
> >  
> > -static const struct wmi_device_id huawei_wmi_id_table[] = {
> > -	{ .guid_string = WMI0_EVENT_GUID },
> > -	{ .guid_string = AMW0_EVENT_GUID },
> > -	{  }
> > -};
> > +static int huawei_wmi_remove(struct platform_device *pdev)
> > +{
> > +	sysfs_remove_group(&pdev->dev.kobj, &huawei_wmi_group);
> > +	return 0;
> > +}
> > +
> > +/* Huawei driver */
> >  
> > -static struct wmi_driver huawei_wmi_driver = {
> > +static struct platform_driver huawei_wmi_driver = {
> >  	.driver = {
> >  		.name = "huawei-wmi",
> >  	},
> > -	.id_table = huawei_wmi_id_table,
> >  	.probe = huawei_wmi_probe,
> > -	.notify = huawei_wmi_notify,
> > +	.remove = huawei_wmi_remove,
> >  };
> >  
> > -module_wmi_driver(huawei_wmi_driver);
> > +static __init int huawei_wmi_init(void)
> > +{
> > +	int event_capable = wmi_has_guid(WMI0_EVENT_GUID) ||
> > +		wmi_has_guid(AMW0_EVENT_GUID);
> > +	int bios_capable = wmi_has_guid(AMW0_METHOD_GUID);
> > +	int err;
> > +
> > +	if (!event_capable && !bios_capable)
> > +		return -ENODEV;
> > +
> > +	dmi_check_system(huawei_quirks);
> > +
> > +	if (event_capable &&
> > wmi_driver_register(&huawei_wmi_input_driver))
> > +		pr_err("Failed to register wmi input driver\n");
> > +
> > +	if (bios_capable) {
> > +		huawei_wmi_pdev =
> > +			platform_device_register_simple("huawei-wmi",
> > -1, NULL, 0);
> > +		if (IS_ERR(huawei_wmi_pdev)) {
> > +			pr_err("Failed to register platform device\n");
> > +			return PTR_ERR(huawei_wmi_pdev);
> > +		}
> > +
> > +		err = platform_driver_register(&huawei_wmi_driver);
> > +		if (err) {
> > +			pr_err("Failed to register platform driver\n");
> > +			platform_device_unregister(huawei_wmi_pdev);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static __exit void huawei_wmi_exit(void)
> > +{
> > +	wmi_driver_unregister(&huawei_wmi_input_driver);
> > +	if (wmi_has_guid(AMW0_METHOD_GUID)) {
> > +		platform_device_unregister(huawei_wmi_pdev);
> > +		platform_driver_unregister(&huawei_wmi_driver);
> > +	}
> > +}
> > +
> > +module_init(huawei_wmi_init);
> > +module_exit(huawei_wmi_exit);
> >  
> > -MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
> > +MODULE_ALIAS("wmi:"AMW0_METHOD_GUID);
> > +MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> > +MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> >  MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
> > -MODULE_DESCRIPTION("Huawei WMI hotkeys");
> > +MODULE_DESCRIPTION("Huawei WMI laptop driver");
> >  MODULE_LICENSE("GPL v2");
> > -- 
> > 2.20.1
> > 
> > 

