Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DAF20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHksqz5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDVSIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:08:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39312 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfDVSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:08:01 -0400
Received: by mail-it1-f195.google.com with SMTP id e13so146329itk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=348CvwjJ7okRheVswY9IzWXPZL35n/copusJuGZkgyc=;
        b=mHksqz5/tKD7I6PZyoyfYg/eC1qLvM1dr4PkMDODgMlX1CCDrSsH28ydocqeKJplbQ
         QeGqtkG2T3T8QfwqjLaXDCtK35PCv6t/mj+RHdDTgidoe+Nx6ESQ/d6n928Hpy/xJZDu
         j/cFvbvFvc+YvBmcgLU1z02C3huG5j4MPGEvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=348CvwjJ7okRheVswY9IzWXPZL35n/copusJuGZkgyc=;
        b=qn6y5C1jejn5GQuA7JCyXqoy23r6o2k6gvCKix9yNrmI9DSOEwKzKDDTsWnLV66VGc
         V9eJAiaJaX+FBCqs692iyhNRnpM/MVwCYYXyKd1MT3XuQ0RjX+LJy5fqselGPCIVNBlk
         4GN+DmtNqoEgvTWHiFQcgq7tywsYWGCR5PGJiFm7Ran3pNLS/jT2z9B/lAAulphu7qRW
         DhMwsjjovpM8FHZ8xaWfHNk+rNctv187Sct3/zNMaSllI2wFB63dQFyFHumdAGYB0BvY
         Q4bmqwii7mr4/fxR751MkOFHvFy5Pa9Q0hUucKJCosy1LAol9xxBahsFjA/HWgvi95yV
         a2+w==
X-Gm-Message-State: APjAAAWo2Me6YW27J1D+JVp1URlYxJa2UQUysg8wzq0TuhCOLE2gRupF
        Lia5Y1i2sCMxNAhDyMFO3J5Z0g==
X-Google-Smtp-Source: APXvYqxXOFklybc76PK5qqqFiIPDajTXjNxMl1gjcOFAqWDf0MHuTA7FaYrheOw33yKXubCYUHcbwQ==
X-Received: by 2002:a24:704b:: with SMTP id f72mr14245291itc.139.1555956479712;
        Mon, 22 Apr 2019 11:07:59 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id 140sm289659itv.44.2019.04.22.11.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 11:07:59 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v7 2/2] power_supply: platform/chrome: wilco_ec: Add charging config driver
Date:   Mon, 22 Apr 2019 12:07:54 -0600
Message-Id: <20190422180754.99383-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422180754.99383-1-ncrews@chromium.org>
References: <20190422180754.99383-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add control of the charging algorithm used on Wilco devices.
See Documentation/ABI/testing/sysfs-class-power-wilco for the
userspace interface and other info.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
v6 changes:
-Remove CHARGE_MODE_ILLEGAL from enum charge_mode. It's not a
 public type, and error checking could be performed in other ways.
-Split up the commit so properties are added in a first commit
-Move CONFIG_CHARGER_WILCO to the power/supply Kconfig
-Use PTR_ERR_OR_ZERO() macro in probe()
v5 changes:
-Remove OP_SYNC, it has no immediate use case.
-Merge properties.h into wilco-ec.h
-Remove enum get_set_sync_op from the public interface,
 since without OP_SYNC they are irrelevant.
-Fix Kconfigs and Makefiles so they actually work
 with the v4 changes
-Tweak some formatting, spacing, and comments
-Fix validation of charge_type so illegal values
 can't be set. Before negative error codes were
 accidentally getting casted to positive numbers
-Remove more unneeded parentheses.
v4 changes:
-Use put_unaligned_le32() to store PID in request.
-Move implementation from
 drivers/platform/chrome/wilco_ec/charge_config.c to
 drivers/power/supply/wilco_charger.c
-Move drivers/platform/chrome/wilco_ec/properties.h to
 include/linux/platform_data/wilco-ec-properties.h
-Remove parentheses in switch statement in psp_val_to_charge_mode()
-Check for any negatvie return code from psp_val_to_charge_mode()
 instead of just -EINVAL so its less brittle
-Tweak comments in wilco-ec-properties.h
v3 changes:
-Add this changelog
-Fix commit message tags
v2 changes:
-Update Documentation to say KernelVersion 5.2
-Update Documentation to explain Trickle mode better.
-rename things from using *PCC* to *CHARGE*
-Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
and Wilco EC codes
-Use devm_ flavor of power_supply_register(), which simplifies things
-Add extra error checking on property messages received from the EC
-Fix bug in memcpy() calls in properties.c
-Refactor fill_property_id()
-Add valid input checks to charge_type
-Properly convert charge_type when get()ting

 .../ABI/testing/sysfs-class-power-wilco       |  30 +++
 drivers/platform/chrome/wilco_ec/core.c       |  13 ++
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/wilco-charger.c          | 187 ++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |   2 +
 6 files changed, 242 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
 create mode 100644 drivers/power/supply/wilco-charger.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
new file mode 100644
index 000000000000..7f3b01310476
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/wilco_charger/charge_type
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		What charging algorithm to use:
+
+		Standard: Fully charges battery at a standard rate.
+		Adaptive: Battery settings adaptively optimized based on
+			typical battery usage pattern.
+		Fast: Battery charges over a shorter period.
+		Trickle: Extends battery lifespan, intended for users who
+			primarily use their Chromebook while connected to AC.
+		Custom: A low and high threshold percentage is specified.
+			Charging begins when level drops below
+			charge_control_start_threshold, and ceases when
+			level is above charge_control_end_threshold.
+
+What:		/sys/class/power_supply/wilco_charger/charge_control_start_threshold
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [50, 95].
+
+What:		/sys/class/power_supply/wilco_charger/charge_control_end_threshold
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [55, 100].
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..a8e3ef59f4ea 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device to be found by charger config driver. */
+	ec->charger_pdev = platform_device_register_data(dev, "wilco-charger",
+							 PLATFORM_DEVID_AUTO,
+							 NULL, 0);
+	if (IS_ERR(ec->charger_pdev)) {
+		dev_err(dev, "Failed to create charger platform device\n");
+		ret = PTR_ERR(ec->charger_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +114,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->charger_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..a958b17b9c9d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.
 
+config CHARGER_WILCO
+	tristate "Wilco EC based charger for ChromeOS"
+	depends on WILCO_EC
+	help
+	  say Y here to enable control of the charging routines performed
+	  by the Embedded Controller on the Chromebook named Wilco. Further
+	  information can be found in
+	  Documentation/ABI/testing/sysfs-class-power-wilco)
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a9b695..2b603a142701 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/wilco-charger.c
new file mode 100644
index 000000000000..7ed78c9fd828
--- /dev/null
+++ b/drivers/power/supply/wilco-charger.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Charging control driver for the Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * See Documentation/ABI/testing/sysfs-class-power and
+ * Documentation/ABI/testing/sysfs-class-power-wilco for userspace interface
+ * and other info.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/power_supply.h>
+
+#define DRV_NAME "wilco-charger"
+
+/* Property IDs and related EC constants */
+#define PID_CHARGE_MODE		0x0710
+#define PID_CHARGE_LOWER_LIMIT	0x0711
+#define PID_CHARGE_UPPER_LIMIT	0x0712
+
+enum charge_mode {
+	CHARGE_MODE_STD = 1,	/* Used for Standard */
+	CHARGE_MODE_EXP = 2,	/* Express Charge, used for Fast */
+	CHARGE_MODE_AC = 3,	/* Mostly AC use, used for Trickle */
+	CHARGE_MODE_AUTO = 4,	/* Used for Adaptive */
+	CHARGE_MODE_CUSTOM = 5,	/* Used for Custom */
+};
+
+#define CHARGE_LOWER_LIMIT_MIN	50
+#define CHARGE_LOWER_LIMIT_MAX	95
+#define CHARGE_UPPER_LIMIT_MIN	55
+#define CHARGE_UPPER_LIMIT_MAX	100
+
+/* Convert from POWER_SUPPLY_PROP_CHARGE_TYPE value to the EC's charge mode */
+static int psp_val_to_charge_mode(int psp_val)
+{
+	switch (psp_val) {
+	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+		return CHARGE_MODE_AC;
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		return CHARGE_MODE_EXP;
+	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
+		return CHARGE_MODE_STD;
+	case POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE:
+		return CHARGE_MODE_AUTO;
+	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
+		return CHARGE_MODE_CUSTOM;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Convert from EC's charge mode to POWER_SUPPLY_PROP_CHARGE_TYPE value */
+static int charge_mode_to_psp_val(enum charge_mode mode)
+{
+	switch (mode) {
+	case CHARGE_MODE_AC:
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	case CHARGE_MODE_EXP:
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+	case CHARGE_MODE_STD:
+		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+	case CHARGE_MODE_AUTO:
+		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
+	case CHARGE_MODE_CUSTOM:
+		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property wilco_charge_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+static int wilco_charge_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct wilco_ec_device *ec = power_supply_get_drvdata(psy);
+	u32 property_id;
+	int ret;
+	u8 raw;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		property_id = PID_CHARGE_MODE;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		property_id = PID_CHARGE_LOWER_LIMIT;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		property_id = PID_CHARGE_UPPER_LIMIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = wilco_ec_get_byte_property(ec, property_id, &raw);
+	if (ret < 0)
+		return ret;
+	if (property_id == PID_CHARGE_MODE) {
+		ret = charge_mode_to_psp_val(raw);
+		if (ret < 0)
+			return -EBADMSG;
+		raw = ret;
+	}
+	val->intval = raw;
+
+	return 0;
+}
+
+static int wilco_charge_set_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     const union power_supply_propval *val)
+{
+	struct wilco_ec_device *ec = power_supply_get_drvdata(psy);
+	int mode;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		mode = psp_val_to_charge_mode(val->intval);
+		if (mode < 0)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		if (val->intval < CHARGE_LOWER_LIMIT_MIN ||
+		    val->intval > CHARGE_LOWER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_LOWER_LIMIT,
+						  val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval < CHARGE_UPPER_LIMIT_MIN ||
+		    val->intval > CHARGE_UPPER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_UPPER_LIMIT,
+						  val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int wilco_charge_property_is_writeable(struct power_supply *psy,
+					      enum power_supply_property psp)
+{
+	return 1;
+}
+
+static const struct power_supply_desc wilco_ps_desc = {
+	.properties		= wilco_charge_props,
+	.num_properties		= ARRAY_SIZE(wilco_charge_props),
+	.get_property		= wilco_charge_get_property,
+	.set_property		= wilco_charge_set_property,
+	.property_is_writeable	= wilco_charge_property_is_writeable,
+	.name			= "wilco-charger",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+};
+
+static int wilco_charge_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	struct power_supply *psy;
+
+	psy_cfg.drv_data = ec;
+	psy = devm_power_supply_register(&pdev->dev, &wilco_ps_desc, &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(psy);
+}
+
+static struct platform_driver wilco_charge_driver = {
+	.probe	= wilco_charge_probe,
+	.driver = {
+		.name = DRV_NAME,
+	}
+};
+module_platform_driver(wilco_charge_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC charge control driver");
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 50a21bd5fd44..66d9f177bec2 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @charger_pdev: Child platform_device used by the charger config sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *charger_pdev;
 };
 
 /**
-- 
2.20.1

