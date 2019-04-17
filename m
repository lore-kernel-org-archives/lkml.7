Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774EEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232BE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLtP7+Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfDQUzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33661 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbfDQUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so19948983lfm.0;
        Wed, 17 Apr 2019 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWs5Fhuiq2Ovqv0Zb96kj87bHb0Eb/iem3Z6rdwb6+I=;
        b=nLtP7+Iz2CPdbjEv7/bZbjcYaaYPlrs6ZMjMSUeBwoUgnTOQqU/rx09wDZ0bSvsp/T
         IUDC39XqN4qqfRiHNr5WaYAUIQbmpEL+SRWkE0IRhDqastNCeocohXIdL6URDMAEDKbH
         fe2MWJ0JIKxF5uJVQ9TWxK7aq99l3Gk+Dw1vwPY/AZNhXFHje8r4+y2o7Apgi2GW9sdl
         qOaIaipygQtDocxdJotIRpSdEq7XtmKVPRsvvHBdENXsmpWqSPVfmRmkknmKaXyWWrat
         DnVBmH4Rpvf1sHVUqhnU26gVh66Tln2uWGe70fFzvnt0ic6/i4k6vKnzKPX2yqoc2t5m
         QM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EWs5Fhuiq2Ovqv0Zb96kj87bHb0Eb/iem3Z6rdwb6+I=;
        b=FJLMQqRz0KqY2jEhhATiZOG8aGiF97WnLpN4B0GvOLabVx7Xv4/h8GP/V2fJPRRmwW
         dt07X7wb8woqeTwNuGDEl9wA4jMc6RhIT3KoZaFI+HnQED4P0mT3T95PpMq8oDBKUm9Q
         cXoqXwsl1rWBrchJjFb65kSZv/MoB7i6nnkIGT19VdCS4RKO9hjsqh3kH70V2pf1GRp6
         OQgWvanlXiO+3rgyrikluKmhVGlsmDuh7DkZPe6XPaMMa2U4TKT1/+xRr08PSc8uAc0t
         QjUnl9nbDJpLPr/co2TNM9WrMO0fFltr7i8yMhmg3IUtqDYwzkQRuw3Fawxw4SvpUZor
         dbqg==
X-Gm-Message-State: APjAAAXe072F1e4X9KGUifDfHtW29R5ltkiG5bFX3TBelvPMIu1RU+Ei
        xGytTWMBA8sbjmIWwVocZRCxEkKQyKo=
X-Google-Smtp-Source: APXvYqxjOo/ibbH2nFXPWo23ZZ0NKJOJqufCr714kl4MstdPG+lLm/ieT3CYi1+63YMZeFvB1kGoFA==
X-Received: by 2002:ac2:5085:: with SMTP id f5mr20508825lfm.71.1555534505019;
        Wed, 17 Apr 2019 13:55:05 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:04 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 06/26] leds: core: Add support for composing LED class device names
Date:   Wed, 17 Apr 2019 22:54:19 +0200
Message-Id: <20190417205439.17685-7-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic support for composing LED class device name. The newly
introduced led_compose_name() function composes device name according
to either <color:function> or <devicename:color:function> pattern,
depending on the configuration of initialization data.
Generally it is expected that only LED class devices created by drivers
of hot-pluggable devices should use the triple-section form.

Backward compatibility with in-driver hard-coded LED class device
names is assured thanks to the default_label and devicename properties
of newly introduced struct led_init_data.

In case none of the aforementioned properties was found, then, for OF
nodes, the node name is adopted for LED class device name.

At the occassion of amending the Documentation/leds/leds-class.txt
unify spelling: colour -> color.

Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
The tool allows retrieving details of a LED class device's parent device,
which proves that using vendor or product name for filling devicename
section deosn't convey any added value since that information is already
available in sysfs.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 Documentation/leds/leds-class.txt |  56 ++++++++++++++++-
 drivers/leds/led-class.c          |  16 ++++-
 drivers/leds/led-core.c           | 127 ++++++++++++++++++++++++++++++++++++++
 drivers/leds/leds.h               |   1 +
 include/linux/leds.h              |  47 ++++++++++++++
 tools/leds/get_led_device_info.sh |  81 ++++++++++++++++++++++++
 6 files changed, 322 insertions(+), 6 deletions(-)
 create mode 100755 tools/leds/get_led_device_info.sh

diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
index 8b39cc6b03ee..b23a81fcad17 100644
--- a/Documentation/leds/leds-class.txt
+++ b/Documentation/leds/leds-class.txt
@@ -43,9 +43,59 @@ LED Device Naming
 
 Is currently of the form:
 
-"devicename:colour:function"
-
-There have been calls for LED properties such as colour to be exported as
+"devicename:color:function"
+
+devicename: It should be provided only for LED class devices created by
+            hot-pluggable devices like USB ones. This name should refer to
+            a unique identifier created by the kernel, like e.g. phyN for
+            network devices or inputN for input devices, rather than to
+            the hardware. The information related to the product and
+            the bus to which given device is hooked is available in the sysfs
+            and can be retrieved using the tool: tools/leds/get_led_device_info.sh.
+
+color: one of the color strings from led_colors array defined
+       in drivers/leds/led-core.c.
+
+function: one of the LED_FUNCTION* definitions from the header
+          include/dt-bindings/leds/common.h.
+
+If required color or function is missing, please submit a patch
+to linux-leds@vger.kernel.org, adding required entries.
+
+It is possible that more than one LED with the same color and function will
+be required for given platform, differing only with an ordinal number.
+In this case it is preferable to just concatenate the predefined LED_FUNCTION*
+name with required "-N" suffix in the driver. fwnode based drivers can use
+function-enumerator property for that and then the concatenation will be handled
+automatically by the LED core on LED class device registration.
+
+There might be still LED class drivers around using vendor or product name
+for devicename, but this approach is now deprecated as it doesn't convey
+any added value. Product information can be found in other places in sysfs
+(see tools/leds/get_led_device_info.sh). The only valid use case when presence
+of devicename section can be useful is when other LED class device with the same
+color and function appears in the system. This can happen unpredicatably only
+in case of hot-pluggable devices like USB ones or added via Device Tree overlays.
+
+In this case filling devicename section will allow to avoid a potential clash
+with LEDs already present in the system, which would force LED core to using
+its mechanism for LED name conflict resolution. The mechanism adds numerical
+suffix (e.g. "_1", "_2", "_3" etc.) to the requested LED class device name
+in case it is already in use.
+
+Examples of proper LED names:
+
+"red:disk"
+"white:flash"
+"red:indicator"
+":mmc"
+"blue:"
+"phy1:green:wlan"
+"phy3::wlan"
+"input2::kbd_backlight"
+"input5:blue:kbd_backlight"
+
+There have been calls for LED properties such as color to be exported as
 individual led class attributes. As a solution which doesn't incur as much
 overhead, I suggest these become part of the device name. The naming scheme
 above leaves scope for further attributes should they be needed. If sections
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 2f09156b0c63..8cd3dc2cd39b 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -256,17 +256,27 @@ int led_classdev_register_ext(struct device *parent,
 			      struct led_classdev *led_cdev,
 			      struct led_init_data *init_data)
 {
-	char name[LED_MAX_NAME_SIZE];
+	char composed_name[LED_MAX_NAME_SIZE];
+	char final_name[LED_MAX_NAME_SIZE];
 	int ret;
 
-	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
+	if (init_data) {
+		if (init_data->devname_mandatory && !init_data->devicename)
+			dev_err(parent, "Mandatory device name is missing");
+		ret = led_compose_name(parent, init_data, composed_name);
+		if (ret < 0)
+			return ret;
+		led_cdev->name = composed_name;
+	}
+
+	ret = led_classdev_next_name(led_cdev->name, final_name, sizeof(final_name));
 	if (ret < 0)
 		return ret;
 
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
 	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
-				led_cdev, led_cdev->groups, "%s", name);
+				led_cdev, led_cdev->groups, "%s", final_name);
 	if (IS_ERR(led_cdev->dev)) {
 		mutex_unlock(&led_cdev->led_access);
 		return PTR_ERR(led_cdev->dev);
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index e3da7c03da1b..0ce1f4aeca92 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -17,8 +17,10 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <uapi/linux/uleds.h>
 #include "leds.h"
 
 DECLARE_RWSEM(leds_list_lock);
@@ -27,6 +29,18 @@ EXPORT_SYMBOL_GPL(leds_list_lock);
 LIST_HEAD(leds_list);
 EXPORT_SYMBOL_GPL(leds_list);
 
+const char *led_colors[LED_COLOR_ID_COUNT] = {
+	[LED_COLOR_ID_WHITE] = "white",
+	[LED_COLOR_ID_RED] = "red",
+	[LED_COLOR_ID_GREEN] = "green",
+	[LED_COLOR_ID_BLUE] = "blue",
+	[LED_COLOR_ID_AMBER] = "amber",
+	[LED_COLOR_ID_VIOLET] = "violet",
+	[LED_COLOR_ID_YELLOW] = "yellow",
+	[LED_COLOR_ID_IR] = "ir",
+};
+EXPORT_SYMBOL_GPL(led_colors);
+
 static int __led_set_brightness(struct led_classdev *led_cdev,
 				enum led_brightness value)
 {
@@ -357,3 +371,116 @@ void led_sysfs_enable(struct led_classdev *led_cdev)
 	led_cdev->flags &= ~LED_SYSFS_DISABLE;
 }
 EXPORT_SYMBOL_GPL(led_sysfs_enable);
+
+static void led_parse_fwnode_props(struct device *dev,
+				   struct fwnode_handle *fwnode,
+				   struct led_properties *props)
+{
+	int ret;
+
+	if (!fwnode)
+		return;
+
+	if (fwnode_property_present(fwnode, "label")) {
+		ret = fwnode_property_read_string(fwnode, "label", &props->label);
+		if (ret)
+			dev_err(dev, "Error parsing \'label\' property (%d)\n", ret);
+		return;
+	}
+
+	if (fwnode_property_present(fwnode, "color")) {
+		ret = fwnode_property_read_u32(fwnode, "color", &props->color);
+		if (ret)
+			dev_err(dev, "Error parsing \'color\' property (%d)\n", ret);
+		else if (props->color >= LED_COLOR_ID_COUNT)
+			dev_err(dev, "LED color identifier out of range\n");
+		else
+			props->color_present = true;
+	}
+
+
+	if (fwnode_property_present(fwnode, "function")) {
+		ret = fwnode_property_read_string(fwnode, "function", &props->function);
+		if (ret) {
+			dev_err(dev,
+				"Error parsing \'function\' property (%d)\n",
+				ret);
+		}
+	} else {
+		return;
+	}
+
+	if (fwnode_property_present(fwnode, "function-enumerator")) {
+		ret = fwnode_property_read_u32(fwnode, "function-enumerator",
+					       &props->func_enum);
+		if (ret) {
+			dev_err(dev,
+				"Error parsing \'function-enumerator\' property (%d)\n",
+				ret);
+		} else {
+			props->func_enum_present = true;
+		}
+	}
+}
+
+int led_compose_name(struct device *dev, struct led_init_data *init_data,
+		     char *led_classdev_name)
+{
+	struct led_properties props = {};
+	struct fwnode_handle *fwnode = init_data->fwnode;
+	const char *devicename = init_data->devicename;
+
+	if (!led_classdev_name)
+		return -EINVAL;
+
+	led_parse_fwnode_props(dev, fwnode, &props);
+
+	if (props.label) {
+		/*
+		 * If init_data.devicename is NULL, then it indicates that
+		 * DT label should be used as-is for LED class device name.
+		 * Otherwise the label is prepended with devicename to compose
+		 * the final LED class device name.
+		 */
+		if (!devicename) {
+			strncpy(led_classdev_name, props.label,
+				LED_MAX_NAME_SIZE);
+		} else {
+			snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+				 devicename, props.label);
+		}
+	} else if (props.function || props.color_present) {
+		char tmp_buf[LED_MAX_NAME_SIZE];
+
+		if (props.func_enum_present) {
+			snprintf(tmp_buf, LED_MAX_NAME_SIZE, "%s:%s-%d",
+				 props.color_present ? led_colors[props.color] : "",
+				 props.function ?: "", props.func_enum);
+		} else {
+			snprintf(tmp_buf, LED_MAX_NAME_SIZE, "%s:%s",
+				 props.color_present ? led_colors[props.color] : "",
+				 props.function ?: "");
+		}
+		if (init_data->devname_mandatory) {
+			snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+				 devicename, tmp_buf);
+		} else {
+			strncpy(led_classdev_name, tmp_buf, LED_MAX_NAME_SIZE);
+
+		}
+	} else if (init_data->default_label) {
+		if (!devicename) {
+			dev_err(dev, "Legacy LED naming requires devicename segment");
+			return -EINVAL;
+		}
+		snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
+			 devicename, init_data->default_label);
+	} else if (is_of_node(fwnode)) {
+		strncpy(led_classdev_name, to_of_node(fwnode)->name,
+			LED_MAX_NAME_SIZE);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(led_compose_name);
diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
index 7d38e6b9a740..ad912c35cf34 100644
--- a/drivers/leds/leds.h
+++ b/drivers/leds/leds.h
@@ -31,5 +31,6 @@ void led_set_brightness_nosleep(struct led_classdev *led_cdev,
 extern struct rw_semaphore leds_list_lock;
 extern struct list_head leds_list;
 extern struct list_head trigger_list;
+extern const char *led_colors[LED_COLOR_ID_COUNT];
 
 #endif	/* __LEDS_H_INCLUDED */
diff --git a/include/linux/leds.h b/include/linux/leds.h
index fab83a2d7bff..94fa84ca1629 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_LEDS_H_INCLUDED
 #define __LINUX_LEDS_H_INCLUDED
 
+#include <dt-bindings/leds/common.h>
 #include <linux/device.h>
 #include <linux/kernfs.h>
 #include <linux/list.h>
@@ -37,6 +38,25 @@ enum led_brightness {
 struct led_init_data {
 	/* device fwnode handle */
 	struct fwnode_handle *fwnode;
+	/*
+	 * default <color:function> tuple, for backward compatibility
+	 * with in-driver hard-coded LED names used as a fallback when
+	 * DT "label" property is absent; it should be set to NULL
+	 * in new LED class drivers.
+	 */
+	const char *default_label;
+	/*
+	 * string to be used for devicename section of LED class device
+	 * either for label based LED name composition path or for fwnode
+	 * based when devname_mandatory is true
+	 */
+	const char *devicename;
+	/*
+	 * indicates if LED name should always comprise devicename section;
+	 * only LEDs exposed by drivers of hot-pluggable devices should
+	 * set it to true
+	 */
+	bool devname_mandatory;
 };
 
 struct led_classdev {
@@ -262,6 +282,24 @@ extern void led_sysfs_disable(struct led_classdev *led_cdev);
 extern void led_sysfs_enable(struct led_classdev *led_cdev);
 
 /**
+ * led_compose_name - compose LED class device name
+ * @dev: LED controller device object
+ * @child: child fwnode_handle describing a LED or a group of synchronized LEDs;
+ *	   it must be provided only for fwnode based LEDs
+ * @led_classdev_name: composed LED class device name
+ *
+ * Create LED class device name basing on the provided init_data argument.
+ * The name can have <devicename:color:function> or <color:function>.
+ * form, depending on the configuration of the init_data properties.
+ * Generally it is expected that only LEDs expsed by drivers of hot-pluggable
+ * devices should use the triple section form.
+ *
+ * Returns: 0 on success or negative error value on failure
+ */
+extern int led_compose_name(struct device *dev, struct led_init_data *init_data,
+			    char *led_classdev_name);
+
+/**
  * led_sysfs_is_disabled - check if LED sysfs interface is disabled
  * @led_cdev: the LED to query
  *
@@ -438,6 +476,15 @@ struct led_platform_data {
 	struct led_info	*leds;
 };
 
+struct led_properties {
+	u32		color;
+	bool		color_present;
+	const char	*function;
+	u32		func_enum;
+	bool		func_enum_present;
+	const char	*label;
+};
+
 struct gpio_desc;
 typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
 				unsigned long *delay_on,
diff --git a/tools/leds/get_led_device_info.sh b/tools/leds/get_led_device_info.sh
new file mode 100755
index 000000000000..fcff38451a2e
--- /dev/null
+++ b/tools/leds/get_led_device_info.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+if [ $# -ne 1 ]; then
+	echo "Usage: get_led_device_info.sh LED_CDEV_PATH"
+	exit 1
+fi
+
+led_cdev_path=`echo $1 | sed s'/\/$//'`
+
+ls "$led_cdev_path/brightness" > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	echo "Device \"$led_cdev_path\" does not exist."
+	exit 1
+fi
+
+bus=`readlink $led_cdev_path/device/subsystem | sed s'/.*\///'`
+usb_subdev=`readlink $led_cdev_path | grep usb | sed s'/\(.*usb[0-9]*\/[0-9]*-[0-9]*\)\/.*/\1/'`
+ls "$led_cdev_path/device/of_node/compatible" > /dev/null 2>&1
+of_node_missing=$?
+
+if [ "$bus" = "input" ]; then
+	input_node=`readlink $led_cdev_path/device | sed s'/.*\///'`
+	if [ ! -z $usb_subdev ]; then
+		bus="usb"
+	fi
+fi
+
+if [ "$bus" = "usb" ]; then
+	usb_interface=`readlink $led_cdev_path | sed s'/.*\(usb[0-9]*\)/\1/' | cut -d \/ -f 3`
+	driver=`readlink $usb_interface/driver | sed s'/.*\///'`
+	cd $led_cdev_path/../$usb_subdev
+	idVendor=`cat idVendor`
+	idProduct=`cat idProduct`
+	manufacturer=`cat manufacturer`
+	product=`cat product`
+elif [ "$bus" = "input" ]; then
+	cd $led_cdev_path
+	product=`cat device/name`
+	driver=`cat device/device/driver/description`
+elif [ $of_node_missing -eq 0 ]; then
+	cd $led_cdev_path
+	compatible=`cat device/of_node/compatible`
+	if [ "$compatible" = "gpio-leds" ]; then
+		driver="leds-gpio"
+	elif [ "$compatible" = "pwm-leds" ]; then
+		driver="leds-pwm"
+	else
+		manufacturer=`echo $compatible | cut -d, -f1`
+		product=`echo $compatible | cut -d, -f2`
+	fi
+else
+	echo "Unknown device type."
+	exit 1
+fi
+
+printf "bus:\t\t\t$bus\n"
+
+if [ ! -z "$idVendor" ]; then
+	printf "idVendor:\t\t$idVendor\n"
+fi
+
+if [ ! -z "$idProduct" ]; then
+	printf "idProduct:\t\t$idProduct\n"
+fi
+
+if [ ! -z "$manufacturer" ]; then
+	printf "manufacturer:\t\t$manufacturer\n"
+fi
+
+if [ ! -z "$product" ]; then
+	printf "product:\t\t$product\n"
+fi
+
+if [ ! -z "$driver" ]; then
+	printf "driver:\t\t\t$driver\n"
+fi
+
+if [ ! -z "$input_node" ]; then
+	printf "associated input node:\t$input_node\n"
+fi
-- 
2.11.0

