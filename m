Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7271CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5024D208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfE0QhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:37:08 -0400
Received: from proxy04.fsdata.se ([89.221.252.227]:50417 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726432AbfE0QhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:37:05 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 12:37:03 EDT
Received: from localhost (94.234.40.49) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 May 2019 18:21:50
 +0200
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] platform/x86: wmi: add Xiaomi WMI key driver
Date:   Mon, 27 May 2019 18:21:31 +0200
Message-ID: <eb57957045495464539c8b4896a8d83b5d87377b.1558968964.git.2pi@mok.nu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558968964.git.2pi@mok.nu>
References: <cover.1558968964.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.40.49]
X-ClientProxiedBy: PROXY02.HMC.local (192.168.46.52) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function keys on the built in keyboard on Xiaomi's notebooks does
not produce any key events when pressed in combination with the function
key. Some of these keys do report that they are being pressed via WMI
events.

This driver reports key events for Fn+F7 and double tap on Fn.

Other WMI events that are reported by the hardware but not utilized by
this driver are Caps Lock(which already work) and Fn lock/unlock.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/Kconfig      | 10 ++++
 drivers/platform/x86/Makefile     |  1 +
 drivers/platform/x86/xiaomi-wmi.c | 94 +++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/platform/x86/xiaomi-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5d5cc6111081..257a99134b64 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -781,6 +781,16 @@ config INTEL_WMI_THUNDERBOLT
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel-wmi-thunderbolt.
 
+config XIAOMI_WMI
+	  tristate "Xiaomi WMI key driver"
+	  depends on ACPI_WMI
+	  depends on INPUT
+	  help
+	  Say Y here if you want to support WMI-based keys on Xiaomi notebooks.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called xiaomi-wmi.
+
 config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 87b0069bd781..f64445d69f99 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_SURFACE3_WMI)	+= surface3-wmi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
 obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
+obj-$(CONFIG_XIAOMI_WMI)	+= xiaomi-wmi.o
 
 # toshiba_acpi must link after wmi to ensure that wmi devices are found
 # before toshiba_acpi initializes
diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
new file mode 100644
index 000000000000..4ff9df5eb88f
--- /dev/null
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WMI driver for Xiaomi Laptops
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+#include <uapi/linux/input-event-codes.h>
+
+#define XIAOMI_KEY_FN_ESC_0	"A2095CCE-0491-44E7-BA27-F8ED8F88AA86"
+#define XIAOMI_KEY_FN_ESC_1	"7BBE8E39-B486-473D-BA13-66F75C5805CD"
+#define XIAOMI_KEY_FN_FN	"409B028D-F06B-4C7C-8BBB-EE133A6BD87E"
+#define XIAOMI_KEY_CAPSLOCK	"83FE7607-053A-4644-822A-21532C621FC7"
+#define XIAOMI_KEY_FN_F7	"76E9027C-95D0-4180-8692-DA6747DD1C2D"
+
+#define XIAOMI_DEVICE(guid, key)		\
+	.guid_string = (guid),			\
+	.context = &(const unsigned int){key}
+
+struct xiaomi_wmi {
+	struct input_dev *input_dev;
+	unsigned int key_code;
+};
+
+int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct xiaomi_wmi *data;
+
+	if (wdev == NULL || context == NULL)
+		return -EINVAL;
+
+	data = devm_kzalloc(&wdev->dev, sizeof(struct xiaomi_wmi), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+	dev_set_drvdata(&wdev->dev, data);
+
+	data->input_dev = devm_input_allocate_device(&wdev->dev);
+	if (data->input_dev == NULL)
+		return -ENOMEM;
+	data->input_dev->name = "Xiaomi WMI keys";
+	data->input_dev->phys = "wmi/input0";
+
+	data->key_code = *((const unsigned int *)context);
+	set_bit(EV_KEY, data->input_dev->evbit);
+	set_bit(data->key_code, data->input_dev->keybit);
+
+	return input_register_device(data->input_dev);
+}
+
+void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *_)
+{
+	struct xiaomi_wmi *data;
+
+	if (wdev == NULL)
+		return;
+
+	data = dev_get_drvdata(&wdev->dev);
+	if (data == NULL)
+		return;
+
+	input_report_key(data->input_dev, data->key_code, 1);
+	input_sync(data->input_dev);
+	input_report_key(data->input_dev, data->key_code, 0);
+	input_sync(data->input_dev);
+}
+
+static const struct wmi_device_id xiaomi_wmi_id_table[] = {
+	// { XIAOMI_DEVICE(XIAOMI_KEY_FN_ESC_0, KEY_FN_ESC) },
+	// { XIAOMI_DEVICE(XIAOMI_KEY_FN_ESC_1, KEY_FN_ESC) },
+	{ XIAOMI_DEVICE(XIAOMI_KEY_FN_FN, KEY_PROG1) },
+	// { XIAOMI_DEVICE(XIAOMI_KEY_CAPSLOCK, KEY_CAPSLOCK) },
+	{ XIAOMI_DEVICE(XIAOMI_KEY_FN_F7, KEY_CUT) },
+
+	/* Terminating entry */
+	{ }
+};
+
+static struct wmi_driver xiaomi_wmi_driver = {
+	.driver = {
+		.name = "xiaomi-wmi",
+	},
+	.id_table = xiaomi_wmi_id_table,
+	.probe = xiaomi_wmi_probe,
+	.notify = xiaomi_wmi_notify,
+};
+module_wmi_driver(xiaomi_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, xiaomi_wmi_id_table);
+MODULE_AUTHOR("Mattias Jacobsson");
+MODULE_DESCRIPTION("Xiaomi WMI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

