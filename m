Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56972218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cG+fQY9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfDXQ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:57:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51697 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbfDXQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:57:12 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so7600241itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTSeJIYVVKEnXcJnV7bjOxDH8UqsAQJMm7uj/RoHc/s=;
        b=cG+fQY9VQXX5sGXPfVxe/CmxKqlVpwzZbm2KOxI0C7YX9gt5ryJlBtiqWtztRyupnO
         /0O/0lpK04q0BD3elcn+ZgROQXcexUPJFV/OnfWqCFM5nEn0UtzwbMoCDPUehpenh/cY
         HN/K4EBJseNau9iFmp7FKHBmnGOz63P1gUUfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTSeJIYVVKEnXcJnV7bjOxDH8UqsAQJMm7uj/RoHc/s=;
        b=fNfWQfXSOKhYEhyiY9UN+nNZ8wlJ+xt5Sn1OT28uR1RD62eG7KFURdCPYzlvN83+5f
         /hSm/Onkjg1eXbLdptMi9JcNkP1yVEG6on1EXXQ+kRtWWf6w2rRVHQYOM27kNHg7XGp+
         7z04XtCKdLF2xUj2NW/pMMgftQ3G33dp3ioOq4ye9yqtg9azz9vCtE1w0KuJyR0luJG3
         6rwgepjK2AsYl7wzJLE35VX5Nvt/Ky0hxCN0oH1MKV8ofi8z7cI4i04oRxGDKiFZ9EzF
         gSq9YhwWzS9YTUv3aUHtRnhtjvR3ZGb3XHpbnkhKktoGvianEYr9jBrF0epz1S6n6LFh
         7J/Q==
X-Gm-Message-State: APjAAAUkqufMNtDCCs/4rkST8QH2xJpDyhD1IC6scxf6/LVfqFob0aoR
        CYqbmr84fIZG/7fQIg5DuMHz6A==
X-Google-Smtp-Source: APXvYqzlCVwt3IcLnBdfqx8MsFI6HCttJpxsusitm4jsmQ7lSGjrjjyI+PJO0cXCvPsT/UI7HAt3Tw==
X-Received: by 2002:a24:9197:: with SMTP id i145mr11851ite.117.1556125031674;
        Wed, 24 Apr 2019 09:57:11 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id t67sm9371420ita.35.2019.04.24.09.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 09:57:10 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        tbroch@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v8 2/2] power_supply: platform/chrome: wilco_ec: Add charging config driver
Date:   Wed, 24 Apr 2019 10:56:51 -0600
Message-Id: <20190424165651.236391-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424165651.236391-1-ncrews@chromium.org>
References: <20190424165651.236391-1-ncrews@chromium.org>
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
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v8 changes:
-Several documentation and comment fixups.
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
index 000000000000..da1d6ffe5e3c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/wilco-charger/charge_type
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
+What:		/sys/class/power_supply/wilco-charger/charge_control_start_threshold
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [50, 95].
+
+What:		/sys/class/power_supply/wilco-charger/charge_control_end_threshold
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
index e901b9879e7e..0c67eff871c8 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.
 
+config CHARGER_WILCO
+	tristate "Wilco EC based charger for ChromeOS"
+	depends on WILCO_EC
+	help
+	  Say Y here to enable control of the charging routines performed
+	  by the Embedded Controller on the Chromebook named Wilco. Further
+	  information can be found in
+	  Documentation/ABI/testing/sysfs-class-power-wilco
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
index 000000000000..b3c6d7cdd731
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
+	.name			= DRV_NAME,
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

