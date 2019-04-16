Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6716C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CD120663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BnOg4jhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfDPTAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:00:53 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:20701 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfDPTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:00:50 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 15:00:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8018; q=dns/txt; s=iport;
  t=1555441249; x=1556650849;
  h=from:to:cc:subject:date:message-id;
  bh=4grllsm3hUBoGLm/ELJA5xsoFY8PfgQVtMd+h+IEqX4=;
  b=BnOg4jhlEeburJZB7V582goZ4u7sqlAKPni7gCCvws/f+Pi60dOU6pDv
   MPdkMIGIjms1sZ300+YLnky5Cvj/6BwAXzX/ABqy6ppNNKOtaesFcphaN
   K+eF1Wv21iQZjXTQx1Fm4lZl5Ir9QMXhSZ2IdndRd8Dz7CKyaWIXjlhQO
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AOAABrJLZc/4gNJK1mGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYIQgTkzKIwqi2IGinyPAoF7EIRthgkjNAkOAQMBAQo?=
 =?us-ascii?q?BAgECbSiFeFIpB4EOE4MigXUUq00zijAUgR4BhnOEVhd4gQeEYYQeG4VsA5F?=
 =?us-ascii?q?/gQuTLAmCCJINDBuUdqAugU84gVYzGggbFYMnkGwfAzCOIYJRAQE?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="544300445"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:53:31 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIrUMn020521;
        Tue, 16 Apr 2019 18:53:30 GMT
From:   Ruslan Babayev <fib@cisco.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ruslan Babayev <ruslan@babayev.com>, xe-linux-external@cisco.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon: (pmbus) add support for output voltage registers
Date:   Tue, 16 Apr 2019 11:45:43 -0700
Message-Id: <20190416184547.40128-1-fib@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>

Registers VOUT_COMMAND, VOUT_MARGIN_HIGH and VOUT_MARGIN_LOW are
described in PMBUS Spec Part II Rev 1.2. Exposing them in the PMBUS
core allows the drivers to turn them on with a corresponding
PMBUS_HAVE_VOUT_... flags.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
---
 drivers/hwmon/pmbus/pmbus.h      |   7 ++
 drivers/hwmon/pmbus/pmbus_core.c | 183 +++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 1d24397d36ec..723648b3da36 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -223,6 +223,9 @@ enum pmbus_regs {
  * OPERATION
  */
 #define PB_OPERATION_CONTROL_ON		BIT(7)
+#define PB_OPERATION_MARGIN_HIGH	BIT(5)
+#define PB_OPERATION_MARGIN_LOW		BIT(4)
+#define PB_OPERATION_ACT_ON_FAULT	BIT(3)
 
 /*
  * CAPABILITY
@@ -291,6 +294,7 @@ enum pmbus_fan_mode { percent = 0, rpm };
 /*
  * STATUS_VOUT, STATUS_INPUT
  */
+#define PB_VOLTAGE_MAX_WARNING		BIT(3)
 #define PB_VOLTAGE_UV_FAULT		BIT(4)
 #define PB_VOLTAGE_UV_WARNING		BIT(5)
 #define PB_VOLTAGE_OV_WARNING		BIT(6)
@@ -371,6 +375,9 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_STATUS_VMON	BIT(19)
 #define PMBUS_HAVE_PWM12	BIT(20)
 #define PMBUS_HAVE_PWM34	BIT(21)
+#define PMBUS_HAVE_VOUT_COMMAND		BIT(22)
+#define PMBUS_HAVE_VOUT_MARGIN_HIGH	BIT(23)
+#define PMBUS_HAVE_VOUT_MARGIN_LOW	BIT(24)
 
 #define PMBUS_PAGE_VIRTUAL	BIT(31)
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 2e2b5851139c..f35b239961e3 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -89,6 +89,14 @@ struct pmbus_label {
 #define to_pmbus_label(_attr) \
 	container_of(_attr, struct pmbus_label, attribute)
 
+struct pmbus_operation {
+	char name[PMBUS_NAME_SIZE];	/* sysfs label name */
+	struct sensor_device_attribute attribute;
+	u8 page;
+};
+#define to_pmbus_operation(_attr) \
+	container_of(_attr, struct pmbus_operation, attribute)
+
 struct pmbus_data {
 	struct device *dev;
 	struct device *hwmon_dev;
@@ -1004,6 +1012,65 @@ static ssize_t pmbus_show_label(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", label->label);
 }
 
+static ssize_t pmbus_show_operation(struct device *dev,
+				    struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pmbus_operation *operation = to_pmbus_operation(attr);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	int ret;
+
+	ret = pmbus_read_byte_data(client, operation->page, PMBUS_OPERATION);
+	if (ret < 0)
+		return ret;
+
+	if (ret & PB_OPERATION_CONTROL_ON) {
+		if (ret & PB_OPERATION_MARGIN_HIGH)
+			return snprintf(buf, PAGE_SIZE, "high\n");
+		else if (ret & PB_OPERATION_MARGIN_LOW)
+			return snprintf(buf, PAGE_SIZE, "low\n");
+		else
+			return snprintf(buf, PAGE_SIZE, "on\n");
+	} else {
+			return snprintf(buf, PAGE_SIZE, "off\n");
+	}
+}
+
+static ssize_t pmbus_set_operation(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pmbus_operation *operation = to_pmbus_operation(attr);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	int ret;
+	u8 val;
+
+	/*
+	 * sysfs_streq() doesn't need the \n's, but we add them so the strings
+	 * will be shared with pmbus_show_operation() above.
+	 */
+	if (sysfs_streq(buf, "on\n"))
+		val = PB_OPERATION_CONTROL_ON;
+	else if (sysfs_streq(buf, "off\n"))
+		val = 0;
+	else if (sysfs_streq(buf, "high\n"))
+		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
+		      PB_OPERATION_MARGIN_HIGH;
+	else if (sysfs_streq(buf, "low\n"))
+		val = PB_OPERATION_CONTROL_ON | PB_OPERATION_ACT_ON_FAULT |
+		      PB_OPERATION_MARGIN_LOW;
+	else
+		return -EINVAL;
+
+	ret = pmbus_write_byte_data(client, operation->page,
+				    PMBUS_OPERATION, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
 {
 	if (data->num_attributes >= data->max_attributes - 1) {
@@ -1143,6 +1210,29 @@ static int pmbus_add_label(struct pmbus_data *data,
 	return pmbus_add_attribute(data, &a->attr);
 }
 
+static int pmbus_add_operation(struct pmbus_data *data, const char *name,
+			       int seq, int page)
+{
+	struct pmbus_operation *operation;
+	struct sensor_device_attribute *a;
+
+	operation = devm_kzalloc(data->dev, sizeof(*operation), GFP_KERNEL);
+	if (!operation)
+		return -ENOMEM;
+
+	a = &operation->attribute;
+
+	snprintf(operation->name, sizeof(operation->name), "%s%d_operation",
+		 name, seq);
+
+	operation->page = page;
+
+	pmbus_attr_init(a, operation->name, S_IRUGO | S_IWUSR,
+			pmbus_show_operation, pmbus_set_operation, seq);
+
+	return pmbus_add_attribute(data, &a->dev_attr.attr);
+}
+
 /*
  * Search for attributes. Allocate sensors, booleans, and labels as needed.
  */
@@ -1901,6 +1991,93 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 	return 0;
 }
 
+static const struct pmbus_limit_attr vout_cmd_limit_attrs[] = {
+	{
+		.reg = PMBUS_VOUT_MAX,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_MAX_WARNING,
+	}
+};
+
+static const struct pmbus_sensor_attr vout_attributes[] = {
+	{
+		.reg = PMBUS_VOUT_COMMAND,
+		.class = PSC_VOLTAGE_OUT,
+		.label = "command",
+		.paged = true,
+		.func = PMBUS_HAVE_VOUT_COMMAND,
+		.sfunc = PMBUS_HAVE_STATUS_VOUT,
+		.sbase = PB_STATUS_VOUT_BASE,
+		.gbit = PB_STATUS_VOUT_OV,
+		.limit = vout_cmd_limit_attrs,
+		.nlimit = ARRAY_SIZE(vout_cmd_limit_attrs),
+	}, {
+		.reg = PMBUS_VOUT_MARGIN_HIGH,
+		.class = PSC_VOLTAGE_OUT,
+		.label = "margin_high",
+		.paged = true,
+		.func = PMBUS_HAVE_VOUT_MARGIN_HIGH,
+	}, {
+		.reg = PMBUS_VOUT_MARGIN_LOW,
+		.class = PSC_VOLTAGE_OUT,
+		.label = "margin_low",
+		.paged = true,
+		.func = PMBUS_HAVE_VOUT_MARGIN_LOW,
+	}
+};
+
+static int pmbus_add_vout_attrs(struct i2c_client *client,
+				struct pmbus_data *data,
+				const char *name,
+				const struct pmbus_sensor_attr *attr,
+				int nattrs)
+{
+	const struct pmbus_driver_info *info = data->info;
+	struct pmbus_sensor *base;
+	int i, ret, index, page, pages;
+
+	index = 1;
+	for (page = 0; page < info->pages; page++) {
+		if (!pmbus_check_byte_register(client, page, PMBUS_OPERATION))
+			continue;
+		ret = pmbus_add_operation(data, name, index, page);
+		if (ret)
+			return ret;
+		index++;
+	}
+
+	for (i = 0; i < nattrs; i++) {
+		index = 1;
+		pages = attr->paged ? info->pages : 1;
+		for (page = 0; page < pages; page++) {
+			if (!(info->func[page] & attr->func))
+				continue;
+
+			if (!pmbus_check_word_register(client, page, attr->reg))
+				continue;
+
+			base = pmbus_add_sensor(data, name, attr->label, index,
+						page, attr->reg, attr->class,
+						true, false, true);
+			if (!base)
+				return -ENOMEM;
+
+			if (attr->sfunc) {
+				ret = pmbus_add_limit_attrs(client, data, info,
+							    name, index, page,
+							    base, attr);
+				if (ret < 0)
+					return ret;
+			}
+
+			index++;
+		}
+		attr++;
+	}
+	return 0;
+}
+
 static int pmbus_find_attributes(struct i2c_client *client,
 				 struct pmbus_data *data)
 {
@@ -1912,6 +2089,12 @@ static int pmbus_find_attributes(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	/* Output Voltage sensors */
+	ret = pmbus_add_vout_attrs(client, data, "out", vout_attributes,
+				   ARRAY_SIZE(vout_attributes));
+	if (ret)
+		return ret;
+
 	/* Current sensors */
 	ret = pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
 				     ARRAY_SIZE(current_attributes));
-- 
2.17.1

