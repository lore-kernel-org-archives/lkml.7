Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411FEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED6D20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDCNyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:54:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:54:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A9F6628264F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, jflat@chromium.org, kernel@collabora.com,
        lee.jones@linaro.org, bleung@chromium.org, groeck@chromium.org,
        rajatja@google.com, dtor@chromium.org
Subject: [PATCH 1/2] platform/chrome: Add CrOS USB PD logging driver
Date:   Wed,  3 Apr 2019 15:54:02 +0200
Message-Id: <20190403135403.9472-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <groeck@chromium.org>

The CrOS USB PD logging feature is logically separate functionality of
the charge manager, hence has its own driver. The driver logs the event
data for the USB PD charger available in some ChromeOS Embedded
Controllers.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
[remove APPEND_STRING macro and minor cleanups]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/Kconfig             |  12 +
 drivers/platform/chrome/Makefile            |   1 +
 drivers/platform/chrome/cros_usbpd_logger.c | 260 ++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_usbpd_logger.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 9186d81a51cc..4313a8bcf0ab 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -152,6 +152,18 @@ config CROS_EC_SYSFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_sysfs.
 
+config CROS_USBPD_LOGGER
+	tristate "Logging driver for USB PD charger"
+	depends on CHARGER_CROS_USBPD
+	default y
+	select RTC_LIB
+	help
+	  This option enables support for logging event data for the USB PD charger
+	  available in the Embedded Controller on ChromeOS systems.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_usbpd_logger.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 1e2f0029b597..0bee2e44748e 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
+obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
new file mode 100644
index 000000000000..2091ad7c2afa
--- /dev/null
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Logging driver for ChromeOS EC based USBPD Charger.
+ *
+ * Copyright 2018 Google LLC.
+ */
+
+#include <linux/ktime.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define DRV_NAME "cros-usbpd-logger"
+
+#define CROS_USBPD_MAX_LOG_ENTRIES	30
+#define CROS_USBPD_LOG_UPDATE_DELAY	msecs_to_jiffies(60000)
+#define CROS_USBPD_DATA_SIZE		16
+#define CROS_USBPD_LOG_RESP_SIZE	(sizeof(struct ec_response_pd_log) + \
+					 CROS_USBPD_DATA_SIZE)
+#define CROS_USBPD_BUFFER_SIZE		(sizeof(struct cros_ec_command) + \
+					 CROS_USBPD_LOG_RESP_SIZE)
+/* Buffer for building the PDLOG string */
+#define BUF_SIZE	80
+
+struct logger_data {
+	struct device *dev;
+	struct cros_ec_dev *ec_dev;
+	u8 ec_buffer[CROS_USBPD_BUFFER_SIZE];
+	struct delayed_work log_work;
+	struct workqueue_struct *log_workqueue;
+};
+
+static const char * const chg_type_names[] = {
+	"None", "PD", "Type-C", "Proprietary", "DCP", "CDP", "SDP",
+	"Other", "VBUS"
+};
+
+static const char * const role_names[] = {
+	"Disconnected", "SRC", "SNK", "SNK (not charging)"
+};
+
+static const char * const fault_names[] = {
+	"---", "OCP", "fast OCP", "OVP", "Discharge"
+};
+
+static int append_str(char *buf, int pos, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vsnprintf(buf + pos, BUF_SIZE - pos, fmt, args);
+	va_end(args);
+
+	return i;
+}
+
+static struct ec_response_pd_log *ec_get_log_entry(struct logger_data *logger)
+{
+	struct cros_ec_dev *ec_dev = logger->ec_dev;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = (struct cros_ec_command *)logger->ec_buffer;
+
+	msg->command = ec_dev->cmd_offset + EC_CMD_PD_GET_LOG_ENTRY;
+	msg->insize = CROS_USBPD_LOG_RESP_SIZE;
+
+	ret = cros_ec_cmd_xfer_status(ec_dev->ec_dev, msg);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return (struct ec_response_pd_log *)msg->data;
+}
+
+static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
+				       ktime_t tstamp)
+{
+	const char *fault, *role, *chg_type;
+	struct usb_chg_measures *meas;
+	struct mcdp_info *minfo;
+	int role_idx, type_idx;
+	char buf[BUF_SIZE + 1];
+	struct rtc_time rt;
+	int len = 0;
+	int i;
+
+	/* The timestamp is the number of 1024th of seconds in the past */
+	tstamp = ktime_sub_us(tstamp, r->timestamp << PD_LOG_TIMESTAMP_SHIFT);
+	rt = rtc_ktime_to_tm(tstamp);
+
+	switch (r->type) {
+	case PD_EVENT_MCU_CHARGE:
+		if (r->data & CHARGE_FLAGS_OVERRIDE)
+			len += append_str(buf, len, "override ");
+
+		if (r->data & CHARGE_FLAGS_DELAYED_OVERRIDE)
+			len += append_str(buf, len, "pending_override ");
+
+		role_idx = r->data & CHARGE_FLAGS_ROLE_MASK;
+		role = role_idx < ARRAY_SIZE(role_names) ?
+			role_names[role_idx] : "Unknown";
+
+		type_idx = (r->data & CHARGE_FLAGS_TYPE_MASK)
+			 >> CHARGE_FLAGS_TYPE_SHIFT;
+
+		chg_type = type_idx < ARRAY_SIZE(chg_type_names) ?
+			chg_type_names[type_idx] : "???";
+
+		if (role_idx == USB_PD_PORT_POWER_DISCONNECTED ||
+		    role_idx == USB_PD_PORT_POWER_SOURCE) {
+			len += append_str(buf, len, "%s", role);
+			break;
+		}
+
+		meas = (struct usb_chg_measures *)r->payload;
+		len += append_str(buf, len, "%s %s %s %dmV max %dmV / %dmA",
+				  role,	r->data & CHARGE_FLAGS_DUAL_ROLE ?
+				  "DRP" : "Charger",
+				  chg_type, meas->voltage_now,
+				  meas->voltage_max, meas->current_max);
+		break;
+	case PD_EVENT_ACC_RW_FAIL:
+		len += append_str(buf, len, "RW signature check failed");
+		break;
+	case PD_EVENT_PS_FAULT:
+		fault = r->data < ARRAY_SIZE(fault_names) ? fault_names[r->data]
+							  : "???";
+		len += append_str(buf, len, "Power supply fault: %s", fault);
+		break;
+	case PD_EVENT_VIDEO_DP_MODE:
+		len += append_str(buf, len, "DP mode %sabled", r->data == 1 ?
+				  "en" : "dis");
+		break;
+	case PD_EVENT_VIDEO_CODEC:
+		minfo = (struct mcdp_info *)r->payload;
+		len += append_str(buf, len, "HDMI info: family:%04x chipid:%04x"
+				  MCDP_FAMILY(minfo->family),
+				  MCDP_CHIPID(minfo->chipid));
+		len += append_str(buf, len, " irom:%d.%d.%d fw:%d.%d.%d",
+				  minfo->irom.major, minfo->irom.minor,
+				  minfo->irom.build, minfo->fw.major,
+				  minfo->fw.minor, minfo->fw.build);
+		break;
+	default:
+		len += append_str(buf, len, "Event %02x (%04x) [", r->type,
+				  r->data);
+
+		for (i = 0; i < PD_LOG_SIZE(r->size_port); i++)
+			len += append_str(buf, len, "%02x ", r->payload[i]);
+
+		len += append_str(buf, len, "]");
+		break;
+	}
+
+	pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n",
+		rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
+		rt.tm_hour, rt.tm_min, rt.tm_sec,
+		ktime_to_ms(tstamp) % MSEC_PER_SEC,
+		PD_LOG_PORT(r->size_port), buf);
+}
+
+static void cros_usbpd_log_check(struct work_struct *work)
+{
+	struct logger_data *logger = container_of(to_delayed_work(work),
+						  struct logger_data,
+						  log_work);
+	struct device *dev = logger->dev;
+	struct ec_response_pd_log *r;
+	int entries = 0;
+	ktime_t now;
+
+	while (entries++ < CROS_USBPD_MAX_LOG_ENTRIES) {
+		r = ec_get_log_entry(logger);
+		now = ktime_get_real();
+		if (IS_ERR(r)) {
+			dev_dbg(dev, "Cannot get PD log %ld\n", PTR_ERR(r));
+			break;
+		}
+		if (r->type == PD_EVENT_NO_ENTRY)
+			break;
+
+		cros_usbpd_print_log_entry(r, now);
+	}
+
+	queue_delayed_work(logger->log_workqueue, &logger->log_work,
+			   CROS_USBPD_LOG_UPDATE_DELAY);
+}
+
+static int cros_usbpd_logger_probe(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+	struct device *dev = &pd->dev;
+	struct logger_data *logger;
+
+	logger = devm_kzalloc(dev, sizeof(*logger), GFP_KERNEL);
+	if (!logger)
+		return -ENOMEM;
+
+	logger->dev = dev;
+	logger->ec_dev = ec_dev;
+
+	platform_set_drvdata(pd, logger);
+
+	/* Retrieve PD event logs periodically */
+	INIT_DELAYED_WORK(&logger->log_work, cros_usbpd_log_check);
+	logger->log_workqueue =	create_singlethread_workqueue("cros_usbpd_log");
+	queue_delayed_work(logger->log_workqueue, &logger->log_work,
+			   CROS_USBPD_LOG_UPDATE_DELAY);
+
+	return 0;
+}
+
+static int cros_usbpd_logger_remove(struct platform_device *pd)
+{
+	struct logger_data *logger = platform_get_drvdata(pd);
+
+	cancel_delayed_work_sync(&logger->log_work);
+
+	return 0;
+}
+
+static int __maybe_unused cros_usbpd_logger_resume(struct device *dev)
+{
+	struct logger_data *logger = dev_get_drvdata(dev);
+
+	queue_delayed_work(logger->log_workqueue, &logger->log_work,
+			   CROS_USBPD_LOG_UPDATE_DELAY);
+
+	return 0;
+}
+
+static int __maybe_unused cros_usbpd_logger_suspend(struct device *dev)
+{
+	struct logger_data *logger = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&logger->log_work);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cros_usbpd_logger_pm_ops, cros_usbpd_logger_suspend,
+			 cros_usbpd_logger_resume);
+
+static struct platform_driver cros_usbpd_logger_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &cros_usbpd_logger_pm_ops,
+	},
+	.probe = cros_usbpd_logger_probe,
+	.remove = cros_usbpd_logger_remove,
+};
+
+module_platform_driver(cros_usbpd_logger_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Logging driver for ChromeOS EC USBPD Charger.");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.20.1

