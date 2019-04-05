Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88710C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386D620700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDUtpsbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDEWkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:40:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33913 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDEWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:40:04 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so6403530ioh.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWzQMW/JuOvzsCD1yDuEpHqJJfYn1eSibDjA0KCS6zs=;
        b=WDUtpsbMRnnkAaFyDpLZLCdwrp+O5X9q1qL9wOxDP0Xe41ZedwNYtEw892UrD2Wv0k
         sjbtLrpoa/buwWNu+zegSxOY6f9Rl2lgEQHBW9a99IT3uINhMHCmGFDCR+iHJzqqwmMK
         SNXAzk4TykU5HFkP2hkIuxx/oDMFt8HYREz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWzQMW/JuOvzsCD1yDuEpHqJJfYn1eSibDjA0KCS6zs=;
        b=AcM4VXeWZIR3i3TPxaQvQhHbeFH31Bt//g5Ct6+zK1NIyHc35iK2n435VjXwKj/D5g
         vvrM39oS3SncbjgF5fmwsFRUqEpFqvXnsYc0jZMG8Chj2MElG4sjwukdEMifpQEKxO++
         kC9F2ZLK9rqI+0NbtF57IdNDGfLrskPlcqLrtHuxg82lbS4VIuOh54CvctF7WtdTwLTJ
         bKy9KjBbr+folyOMw1m+WQNeYO4TDf5E42C9X2rAAimJU3mzul8ddWyhoY0HU6BCjbmR
         lYlaN20xjGPmAL/k1MHfNFNnF5UMI11tsNo5WRG1SNO26Fh5Jkj8oNKfZT3kTWHk7sJA
         EzyQ==
X-Gm-Message-State: APjAAAVn4IXJfL35xii4W7LwD3Kls0a6xdpFL/WaAVAw7xpy/P0WMOBo
        1os04G8+m5aHsmiK5vNXflzq8Q==
X-Google-Smtp-Source: APXvYqyNvtf2TKOBq81G+2THamVYkzOn5G/GZtvk9BhX4/uttCVI3rizcx25EUZ1pqKJA/JdPwjLNg==
X-Received: by 2002:a5e:8202:: with SMTP id l2mr10193938iom.144.1554504002957;
        Fri, 05 Apr 2019 15:40:02 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id f132sm9588011ioa.76.2019.04.05.15.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 15:40:02 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com, sjg@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 2/2] power_supply: wilco_ec: Add charging config driver for Wilco EC
Date:   Fri,  5 Apr 2019 16:35:54 -0600
Message-Id: <20190405223554.228813-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405223554.228813-1-ncrews@chromium.org>
References: <20190405223554.228813-1-ncrews@chromium.org>
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
 .../ABI/testing/sysfs-class-power-wilco       |  30 +++
 drivers/platform/chrome/wilco_ec/Kconfig      |   9 +
 drivers/platform/chrome/wilco_ec/Makefile     |   2 +
 .../platform/chrome/wilco_ec/charge_config.c  | 182 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/core.c       |  14 ++
 drivers/platform/chrome/wilco_ec/properties.c | 129 +++++++++++++
 drivers/platform/chrome/wilco_ec/properties.h |  68 +++++++
 include/linux/platform_data/wilco-ec.h        |   2 +
 8 files changed, 436 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
 create mode 100644 drivers/platform/chrome/wilco_ec/charge_config.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.h

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
new file mode 100644
index 000000000000..ef78e3d4a4bd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/wilco_charger/charge_type
+Date:		April 2019
+KernelVersion:	5.1
+Description:
+		What charging algorithm to use:
+
+		Standard: Fully charges battery at a standard rate.
+		Adaptive: Battery settings adaptively optimized based on
+			typical battery usage pattern.
+		Fast: Battery charges over a shorter period.
+		Trickle: Extends battery lifespan for users who use
+			their Chromebooks connected to AC.
+		Custom: A low and high threshold percentage is specified.
+			Charging begins when level drops below
+			charge_control_start_threshold, and ceases when
+			level is above charge_control_end_threshold.
+
+What:		/sys/class/power_supply/wilco_charger/charge_control_start_threshold
+Date:		April 2019
+KernelVersion:	5.1
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [50, 95].
+
+What:		/sys/class/power_supply/wilco_charger/charge_control_end_threshold
+Date:		April 2019
+KernelVersion:	5.1
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [55, 100].
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index e09e4cebe9b4..1c427830bd57 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -18,3 +18,12 @@ config WILCO_EC_DEBUGFS
 	  manipulation and allow for testing arbitrary commands.  This
 	  interface is intended for debug only and will not be present
 	  on production devices.
+
+config WILCO_EC_CHARGE_CNTL
+	tristate "Enable charging control"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support to control the charging
+	  routines performed by the Wilco Embedded Controller.
+	  Further information can be found in
+	  Documentation/ABI/testing/sysfs-class-power-wilco)
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..7e980f56f793 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_ec_charging-objs			:= charge_config.o properties.o
+obj-$(CONFIG_WILCO_EC_CHARGE_CNTL)	+= wilco_ec_charging.o
diff --git a/drivers/platform/chrome/wilco_ec/charge_config.c b/drivers/platform/chrome/wilco_ec/charge_config.c
new file mode 100644
index 000000000000..907526829444
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/charge_config.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Charging control driver for the Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * See Documentation/ABI/testing/sysfs-class-power-wilco for
+ * userspace interface and other info.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/power_supply.h>
+
+#include "properties.h"
+
+#define DRV_NAME "wilco-ec-charging"
+
+/* Property IDs and related EC constants */
+#define PID_PCC_MODE		0x0710
+#define PID_PCC_LOWER_LIMIT	0x0711
+#define PID_PCC_UPPER_LIMIT	0x0712
+
+enum charge_mode {
+	CHARGE_MODE_STD = 1,	/* Used for Standard */
+	CHARGE_MODE_EXP = 2,	/* Express Charge, used for Fast */
+	CHARGE_MODE_AC = 3,	/* Mostly AC use, used for Trickle */
+	CHARGE_MODE_AUTO = 4,	/* Used for Adaptive */
+	CHARGE_MODE_CUSTOM = 5,	/* Used for Custom */
+};
+
+#define PCC_LOWER_LIMIT_MIN	50
+#define PCC_LOWER_LIMIT_MAX	95
+#define PCC_UPPER_LIMIT_MIN	55
+#define PCC_UPPER_LIMIT_MAX	100
+
+static int set_charge_type(struct wilco_ec_device *ec, int psp_val)
+{
+	enum charge_mode mode;
+
+	switch (psp_val) {
+	case (POWER_SUPPLY_CHARGE_TYPE_TRICKLE):
+		mode = CHARGE_MODE_AC;
+		break;
+	case (POWER_SUPPLY_CHARGE_TYPE_FAST):
+		mode = CHARGE_MODE_EXP;
+		break;
+	case (POWER_SUPPLY_CHARGE_TYPE_STANDARD):
+		mode = CHARGE_MODE_STD;
+		break;
+	case (POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE):
+		mode = CHARGE_MODE_AUTO;
+		break;
+	case (POWER_SUPPLY_CHARGE_TYPE_CUSTOM):
+		mode = CHARGE_MODE_CUSTOM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return wilco_ec_set_byte_property(ec, PID_PCC_MODE, mode);
+}
+
+static enum power_supply_property wilco_pcc_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+struct wilco_pcc_data {
+	struct wilco_ec_device *ec;
+	struct power_supply *psy;
+};
+
+static int wilco_pcc_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct wilco_pcc_data *data = power_supply_get_drvdata(psy);
+	struct wilco_ec_device *ec = data->ec;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return wilco_ec_get_byte_property(ec, PID_PCC_MODE,
+						  (u8 *)&val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		return wilco_ec_get_byte_property(ec, PID_PCC_LOWER_LIMIT,
+						  (u8 *)&val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return wilco_ec_get_byte_property(ec, PID_PCC_UPPER_LIMIT,
+						  (u8 *)&val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int wilco_pcc_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct wilco_pcc_data *data = power_supply_get_drvdata(psy);
+	struct wilco_ec_device *ec = data->ec;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return set_charge_type(ec, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		if (val->intval < PCC_LOWER_LIMIT_MIN ||
+		    val->intval > PCC_LOWER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_PCC_LOWER_LIMIT,
+						  val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval < PCC_UPPER_LIMIT_MIN ||
+		    val->intval > PCC_UPPER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_PCC_UPPER_LIMIT,
+						  val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int wilco_pcc_property_is_writeable(struct power_supply *psy,
+					   enum power_supply_property psp)
+{
+	return 1;
+}
+
+static const struct power_supply_desc wilco_ps_desc = {
+	.properties	= wilco_pcc_props,
+	.num_properties	= ARRAY_SIZE(wilco_pcc_props),
+	.get_property	= wilco_pcc_get_property,
+	.set_property	= wilco_pcc_set_property,
+	.property_is_writeable = wilco_pcc_property_is_writeable,
+	.name		= "wilco-charger",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+};
+
+static int wilco_pcc_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	struct wilco_pcc_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ec = ec;
+	psy_cfg.drv_data = data;
+	platform_set_drvdata(pdev, data);
+
+	data->psy = power_supply_register(&pdev->dev, &wilco_ps_desc, &psy_cfg);
+	if (IS_ERR(data->psy))
+		return PTR_ERR(data->psy);
+
+	return 0;
+}
+
+static int wilco_pcc_remove(struct platform_device *pdev)
+{
+	struct wilco_pcc_data *data = platform_get_drvdata(pdev);
+
+	power_supply_unregister(data->psy);
+	return 0;
+}
+
+static struct platform_driver wilco_pcc_driver = {
+	.probe	= wilco_pcc_probe,
+	.remove	= wilco_pcc_remove,
+	.driver = {
+		.name = DRV_NAME,
+	}
+};
+module_platform_driver(wilco_pcc_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC charge control driver");
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..b6f3b061f37b 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,21 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child device to be found by charging config driver. */
+	ec->charging_pdev = platform_device_register_data(dev,
+							  "wilco-ec-charging",
+							  PLATFORM_DEVID_AUTO,
+							  NULL, 0);
+	if (IS_ERR(ec->charging_pdev)) {
+		dev_err(dev, "Failed to create charging platform device\n");
+		ret = PTR_ERR(ec->charging_pdev);
+		goto unregister_rtc;
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +115,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->charging_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
new file mode 100644
index 000000000000..67fdf6208a9c
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include "properties.h"
+
+struct ec_property_request {
+	u8 op;
+	u8 property_id[4];
+	u8 length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+} __packed;
+
+struct ec_property_response {
+	u8 reserved[2];
+	u8 op;
+	u8 property_id[4];
+	u8 length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+} __packed;
+
+/* Store a 32 bit property ID into a byte array, LSB first */
+static inline void fill_property_id(u32 property_id, u8 field[])
+{
+	field[0] =  property_id        & 0xff;
+	field[1] = (property_id >> 8)  & 0xff;
+	field[2] = (property_id >> 16) & 0xff;
+	field[3] = (property_id >> 24) & 0xff;
+}
+
+static int send_property_msg(struct wilco_ec_device *ec,
+			     struct ec_property_request *rq,
+			     struct ec_property_response *rs)
+{
+	struct wilco_ec_message ec_msg;
+	int ret;
+
+	memset(&ec_msg, 0, sizeof(ec_msg));
+	ec_msg.type = WILCO_EC_MSG_PROPERTY;
+	ec_msg.request_data = rq;
+	ec_msg.request_size = sizeof(*rq);
+	ec_msg.response_data = rs;
+	ec_msg.response_size = sizeof(*rs);
+	ret = wilco_ec_mailbox(ec, &ec_msg);
+	if (ret < 0)
+		return ret;
+
+	if (rs->op != rq->op)
+		return -EBADMSG;
+
+	return 0;
+}
+
+int wilco_ec_get_property(struct wilco_ec_device *ec,
+			  struct ec_property_get_msg *prop_msg)
+{
+	struct ec_property_request rq;
+	struct ec_property_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.op = OP_GET;
+	fill_property_id(prop_msg->property_id, (u8 *)&rq.property_id);
+
+	ret = send_property_msg(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	prop_msg->length = rs.length;
+	memcpy(prop_msg->data, &rs.data, rs.length);
+
+	return 0;
+}
+
+int wilco_ec_set_property(struct wilco_ec_device *ec,
+			  struct ec_property_set_msg *prop_msg)
+{
+	struct ec_property_request rq;
+	struct ec_property_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.op = prop_msg->op;
+	fill_property_id(prop_msg->property_id, (u8 *)&rq.property_id);
+	rq.length = prop_msg->length;
+	memcpy(&rq.data, prop_msg->data, prop_msg->length);
+
+	ret = send_property_msg(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	if (rs.length != prop_msg->length)
+		return -EBADMSG;
+
+	return 0;
+}
+
+int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 *val)
+{
+	struct ec_property_get_msg msg;
+	int ret;
+
+	msg.property_id = property_id;
+	ret = wilco_ec_get_property(ec, &msg);
+	if (ret)
+		return ret;
+
+	if (msg.length != 1)
+		return -EBADMSG;
+
+	*val = msg.data[0];
+
+	return 0;
+}
+
+int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 val)
+{
+	struct ec_property_set_msg msg;
+
+	msg.property_id = property_id;
+	msg.op = OP_SET;
+	msg.data[0] = val;
+	msg.length = 1;
+
+	return wilco_ec_set_property(ec, &msg);
+}
diff --git a/drivers/platform/chrome/wilco_ec/properties.h b/drivers/platform/chrome/wilco_ec/properties.h
new file mode 100644
index 000000000000..da0bb3b869af
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/properties.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helper library for property access on the Wilco EC.
+ *
+ * Copyright 2019 Google LLC
+ *
+ * A Property is typically a data item that is stored to NVRAM
+ * by the EC. Each of these data items has an index associated
+ * with it known as the Property ID (PID). Properties may have
+ * variable lengths, up to a max of WILCO_EC_PROPERTY_MAX_SIZE
+ * bytes. Properties can be simple integers, or they may be more
+ * complex binary data.
+ */
+
+#include <linux/platform_data/wilco-ec.h>
+
+#define WILCO_EC_PROPERTY_MAX_SIZE	4
+
+/*
+ * Properties are accessed with an subcommand, or "op". OP_GET
+ * requests the property from the EC. OP_SET and OP_SYNC do the
+ * exact same thing from our perspective: save a property. Only
+ * one of them works for a given property, so each property uses
+ * either OP_GET and OP_SET, or OP_GET and OP_SYNC.
+ */
+enum get_set_sync_op {
+	OP_GET = 0,
+	OP_SET = 1,
+	OP_SYNC = 4
+};
+
+/**
+ * struct ec_property_get_msg - Message to retrieve a property.
+ * @property_id: PID of property to retrieve.
+ * @length: number of bytes received, set by wilco_ec_get_property().
+ * @data: actual property data, set by wilco_ec_get_property().
+ */
+struct ec_property_get_msg {
+	u32 property_id;
+	int length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+};
+
+/**
+ * struct ec_property_set_msg - Message to save a property.
+ * @op: Which subcommand to use, either OP_SET or OP_SYNC
+ * @property_id: PID of property to save.
+ * @length: number of bytes to save, must not exceed WILCO_EC_PROPERTY_MAX_SIZE.
+ * @data: actual property data.
+ */
+struct ec_property_set_msg {
+	enum get_set_sync_op op;
+	u32 property_id;
+	int length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+};
+
+/* Both of these will return 0 on success, negative error code on failure */
+int wilco_ec_get_property(struct wilco_ec_device *ec,
+			  struct ec_property_get_msg *prop_msg);
+int wilco_ec_set_property(struct wilco_ec_device *ec,
+			  struct ec_property_set_msg *prop_msg);
+
+/* Both of these will return 0 on success, negative error code on failure */
+int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 *val);
+int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 val);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..4e7dce897500 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @charging_pdev: Child platform_device used by the charging config sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *charging_pdev;
 };
 
 /**
-- 
2.20.1

