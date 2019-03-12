Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25804C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DF1206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xZVusKar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCLRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:41:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfCLRQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CHFP2p074836;
        Tue, 12 Mar 2019 12:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552410925;
        bh=J00UlMWvcxG3Azu7yRyik5W7B9ewbHNqKsF22gu3Ykg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xZVusKarnUFFPWwv/Ce8YQ12Gk9ahLMqpL25KBnQ69Je3XdJ4PPQ7f2uJg4IB3rGm
         QVFnxiRKNlOJhv/0v+DKclFz2IWGcVsoDgNIPRooVSnLxv2HO+7P2rzFfrtAWKg0by
         vBNsQJtj3PSsdHsF0gxKV8C5/7BDo3vFaqFlKYnY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CHFOLx077481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 12:15:24 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 12:15:24 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 12:15:24 -0500
Received: from [172.22.79.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CHFN1C030064;
        Tue, 12 Mar 2019 12:15:23 -0500
Subject: Re: [PATCH 02/25] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-3-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <79bf90e1-f1df-c015-d3ed-6294bda7f1fb@ti.com>
Date:   Tue, 12 Mar 2019 12:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190310182836.20841-3-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 1:28 PM, Jacek Anaszewski wrote:
> Add public led_compose_name() API for composing LED class device
> name basing on fwnode_handle data. The function composes device name
> according to either a new <color:function> pattern or the legacy
> <devicename:color:function> pattern. The decision on using the
> particular pattern is made basing on whether fwnode contains new
> "function" and "color" properties, or the legacy "label" proeprty.
> 
> Backwards compatibility with in-driver hard-coded LED class device
> names is assured thanks to the default_desc argument.
> 
> In case none of the aforementioned properties was found, then, for OF
> nodes, the node name is adopted for LED class device name.
> 
> Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
> The tool allows retrieving details of a LED class device's parent device,
> which proves that getting rid of a devicename section from LED name pattern
> is justified since this information is already available in sysfs.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/leds/leds-class.txt | 20 +++++++++-
>  drivers/leds/led-core.c           | 82 +++++++++++++++++++++++++++++++++++++++
>  include/linux/leds.h              | 31 +++++++++++++++
>  tools/leds/get_led_device_info.sh | 81 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100755 tools/leds/get_led_device_info.sh
> 
> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
> index 8b39cc6b03ee..866fe87063d4 100644
> --- a/Documentation/leds/leds-class.txt
> +++ b/Documentation/leds/leds-class.txt
> @@ -43,7 +43,22 @@ LED Device Naming
>  
>  Is currently of the form:
>  
> -"devicename:colour:function"
> +"colour:function"
> +
> +There might be still LED class drivers around using "devicename:colour:function"
> +naming pattern, but the "devicename" section is now deprecated since it used
> +to convey information that was already available in the sysfs, like product
> +name. There is a tool (tools/leds/get_led_device_info.sh) available for
> +retrieving that information per a LED class device.
> +
> +Associations with other devices, like network ones, should be defined
> +via LED triggr mechanism. This approach is applied by some of wireless
> +network drivers that create triggers dynamically and incorporate phy
> +name into its name. On the other hand input subsystem offers LED - input
> +bridge (drivers/input/input-leds.c) for exposing keyboard LEDs as LED class
> +devices. The get_led_device_info.sh script has support for retrieving related
> +input device node name. Should it support discovery of associations between
> +LEDs and other subsystems, please don't hesitate to submit a relevant patch.
>  
>  There have been calls for LED properties such as colour to be exported as
>  individual led class attributes. As a solution which doesn't incur as much
> @@ -51,6 +66,9 @@ overhead, I suggest these become part of the device name. The naming scheme
>  above leaves scope for further attributes should they be needed. If sections
>  of the name don't apply, just leave that section blank.
>  
> +Please also keep in mind that LED subsystem has a protection against LED name
> +conflict. It adds numerical suffix (e.g. "_1", "_2", "_3" etc.) to the requested
> +LED class device name in case it is already in use.
>  
>  Brightness setting API
>  ======================
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ede4fa0ac2cc..bad92250d1d5 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -16,6 +16,8 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/rwsem.h>
>  #include "leds.h"
>  
> @@ -327,3 +329,83 @@ void led_sysfs_enable(struct led_classdev *led_cdev)
>  	led_cdev->flags &= ~LED_SYSFS_DISABLE;
>  }
>  EXPORT_SYMBOL_GPL(led_sysfs_enable);
> +
> +static void led_parse_properties(struct fwnode_handle *fwnode,
> +				 struct led_properties *props)
> +{
> +	int ret;
> +
> +	if (!fwnode)
> +		return;
> +
> +	if (fwnode_property_present(fwnode, "label")) {
> +		ret = fwnode_property_read_string(fwnode, "label", &props->label);
> +		if (ret)
> +			pr_err("Error parsing \'label\' property (%d)\n", ret);
> +		return;
> +	}
> +
> +	if (fwnode_property_present(fwnode, "function")) {
> +		ret = fwnode_property_read_string(fwnode, "function", &props->function);
> +		if (ret)
> +			pr_err("Error parsing \'function\' property (%d)\n", ret);
> +	} else {
> +		pr_info("\'function\' property not found\n");
> +	}
> +
> +	if (fwnode_property_present(fwnode, "color")) {
> +		ret = fwnode_property_read_string(fwnode, "color", &props->color);
> +		if (ret)
> +			pr_info("Error parsing \'color\' property (%d)\n", ret);
> +	} else {
> +		pr_info("\'color\' property not found\n");
> +	}
> +}
> +
> +int led_compose_name(struct fwnode_handle *fwnode, const char *led_hw_name,
> +		     const char *default_desc, char *led_classdev_name)
> +{
> +	struct led_properties props = {};
> +
> +	if (!led_classdev_name)
> +		return -EINVAL;
> +
> +	led_parse_properties(fwnode, &props);
> +
> +	if (props.label) {
> +		/*
> +		 * Presence of 'label' DT property implies legacy LED name,
> +		 * formatted as <devicename:color:function>, with possible
> +		 * section omission if doesn't apply to given device.
> +		 *
> +		 * If no led_hw_name has been passed, then it indicates that
> +		 * DT label should be used as-is for LED class device name.
> +		 * Otherwise the label is prepended with led_hw_name to compose
> +		 * the final LED class device name.
> +		 */
> +		if (!led_hw_name) {
> +			strncpy(led_classdev_name, props.label,
> +				LED_MAX_NAME_SIZE);
> +		} else {
> +			snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +				 led_hw_name, props.label);
> +		}
> +	} else if (props.function || props.color) {
> +		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +			 props.color ?: "", props.function ?: "");
> +	} else if (default_desc) {
> +		if (!led_hw_name) {
> +			pr_err("Legacy LED naming requires devicename segment");
> +			return -EINVAL;
> +		}
> +		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
> +			 led_hw_name, default_desc);
> +	} else if (is_of_node(fwnode)) {
> +		strncpy(led_classdev_name, to_of_node(fwnode)->name,
> +			LED_MAX_NAME_SIZE);
> +	} else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(led_compose_name);
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index bffb4315fd66..c2936fc989d4 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -252,6 +252,31 @@ extern void led_sysfs_disable(struct led_classdev *led_cdev);
>  extern void led_sysfs_enable(struct led_classdev *led_cdev);
>  
>  /**
> + * led_compose_name - compose LED class device name
> + * @child: child fwnode_handle describing a LED,
> + *	   or a group of synchronized LEDs.
> + * @led_hw_name: name of the LED controller, used when falling back to legacy
> + *		 LED naming; it should be set to NULL in new LED class drivers
> + * @default_desc: default <color:function> tuple, for backwards compatibility
> + *		  with in-driver hard-coded LED names used as a fallback when
> + *		  "label" DT property is absent; it should be set to NULL
> + *		  in new LED class drivers
> + * @led_classdev_name: composed LED class device name
> + *
> + * Create LED class device name basing on the configuration provided by the
> + * board firmware. The name can have a legacy form <devicename:color:function>,
> + * or a new form <color:function>. The latter is chosen if "label" property is
> + * absent and at least one of "color" or "function" is present in the fwnode,
> + * leaving the section blank if the related property is absent. In case none
> + * of the aforementioned properties is found, then, for OF nodes, the node name
> + * is adopted for LED class device name.
> + *
> + * Returns: 0 on success or negative error value on failure
> + */
> +extern int led_compose_name(struct fwnode_handle *child, const char *led_hw_name,
> +			    const char *default_desc, char *led_classdev_name);
> +
> +/**
>   * led_sysfs_is_disabled - check if LED sysfs interface is disabled
>   * @led_cdev: the LED to query
>   *
> @@ -428,6 +453,12 @@ struct led_platform_data {
>  	struct led_info	*leds;
>  };
>  
> +struct led_properties {
> +	const char *color;
> +	const char *function;
> +	const char *label;
> +};
> +
>  struct gpio_desc;
>  typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
>  				unsigned long *delay_on,
> diff --git a/tools/leds/get_led_device_info.sh b/tools/leds/get_led_device_info.sh
> new file mode 100755
> index 000000000000..4671aa690e4a
> --- /dev/null
> +++ b/tools/leds/get_led_device_info.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +

Is there a way to give usage or help here?  It's not entirely clear what the argument to pass in is.

maybe if $1 = "?" then print usage

Dan


> +if [ $# -ne 1 ]; then
> +	echo "get_led_devicename.sh LED_CDEV_PATH"
> +	exit 1
> +fi
> +
> +led_cdev_path=`echo $1 | sed s'/\/$//'`
> +
> +ls "$led_cdev_path/brightness" > /dev/null 2>&1
> +if [ $? -ne 0 ]; then
> +	echo "Device \"$led_cdev_path\" does not exist."
> +	exit 1
> +fi
> +
> +bus=`readlink $led_cdev_path/device/subsystem | sed s'/.*\///'`
> +usb_subdev=`readlink $led_cdev_path | grep usb | sed s'/\(.*usb[0-9]*\/[0-9]*-[0-9]*\)\/.*/\1/'`
> +ls "$led_cdev_path/device/of_node/compatible" > /dev/null 2>&1
> +of_node_missing=$?
> +
> +if [ "$bus" = "input" ]; then
> +	input_node=`readlink $led_cdev_path/device | sed s'/.*\///'`
> +	if [ ! -z $usb_subdev ]; then
> +		bus="usb"
> +	fi
> +fi
> +
> +if [ "$bus" = "usb" ]; then
> +	usb_interface=`readlink $led_cdev_path | sed s'/.*\(usb[0-9]*\)/\1/' | cut -d \/ -f 3`
> +	driver=`readlink $usb_interface/driver | sed s'/.*\///'`
> +	cd $led_cdev_path/../$usb_subdev
> +	idVendor=`cat idVendor`
> +	idProduct=`cat idProduct`
> +	manufacturer=`cat manufacturer`
> +	product=`cat product`
> +elif [ "$bus" = "input" ]; then
> +	cd $led_cdev_path
> +	product=`cat device/name`
> +	driver=`cat device/device/driver/description`
> +elif [ $of_node_missing -eq 0 ]; then
> +	cd $led_cdev_path
> +	compatible=`cat device/of_node/compatible`
> +	if [ "$compatible" = "gpio-leds" ]; then
> +		driver="leds-gpio"
> +	elif [ "$compatible" = "pwm-leds" ]; then
> +		driver="leds-pwm"
> +	else
> +		manufacturer=`echo $compatible | cut -d, -f1`
> +		product=`echo $compatible | cut -d, -f2`
> +	fi
> +else
> +	echo "Unknown device type."
> +	exit 1
> +fi
> +
> +printf "bus:\t\t\t$bus\n"
> +
> +if [ ! -z "$idVendor" ]; then
> +	printf "idVendor:\t\t$idVendor\n"
> +fi
> +
> +if [ ! -z "$idProduct" ]; then
> +	printf "idProduct:\t\t$idProduct\n"
> +fi
> +
> +if [ ! -z "$manufacturer" ]; then
> +	printf "manufacturer:\t\t$manufacturer\n"
> +fi
> +
> +if [ ! -z "$product" ]; then
> +	printf "product:\t\t$product\n"
> +fi
> +
> +if [ ! -z "$driver" ]; then
> +	printf "driver:\t\t\t$driver\n"
> +fi
> +
> +if [ ! -z "$input_node" ]; then
> +	printf "associated input node:\t$input_node\n"
> +fi
> 


-- 
------------------
Dan Murphy
