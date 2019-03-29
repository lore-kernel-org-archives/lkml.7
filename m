Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3A2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfC2EPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:15:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728652AbfC2EOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:14:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D3EC3C459B921E721BE;
        Fri, 29 Mar 2019 12:14:35 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 12:14:26 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 11/13] hikey960: Support usb functionality of Hikey960
Date:   Fri, 29 Mar 2019 12:14:07 +0800
Message-ID: <20190329041409.70138-12-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190329041409.70138-1-chenyu56@huawei.com>
References: <20190329041409.70138-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver handles usb hub power on and typeC port event of HiKey960 board:
1)DP&DM switching between usb hub and typeC port base on typeC port
state
2)Control power of usb hub on Hikey960
3)Control vbus of typeC port

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
v1:
* Using gpiod API with the gpios.
* Removing registering usb role switch.
* Registering usb role switch notifier.
v2:
* Fix license declaration.
* Add configuration of  gpio direction.
* Remove some log print.
v3:
* Remove property of "typec_vbus_enable_val".
* Remove gpiod_direction_output and set initial value of gpio by
* devm_gpiod_get.
v4:
* Remove 'linux/of.h' and add 'linux/mod_devicetable.h'.
* Remove unused 'root' of_node.
* Remove unuseful NULL check return by 'devm_gpiod_get'.
* Use 'devm_gpiod_get_optional' to get optional gpio.
---
---
 drivers/misc/Kconfig          |   6 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/hisi_hikey_usb.c | 162 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/misc/hisi_hikey_usb.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..3b3f610b80c2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -532,6 +532,12 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config HISI_HIKEY_USB
+	tristate "USB functionality of HiSilicon Hikey Platform"
+	depends on OF && GPIOLIB
+	help
+	  If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d3404dc7..1c6c108d3a0c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
new file mode 100644
index 000000000000..a3bb46266f04
--- /dev/null
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for usb functionality of Hikey series boards
+ * based on Hisilicon Kirin Soc.
+ *
+ * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ *		http://www.huawei.com
+ *
+ * Authors: Yu Chen <chenyu56@huawei.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/usb/role.h>
+
+#define DEVICE_DRIVER_NAME "hisi_hikey_usb"
+
+#define HUB_VBUS_POWER_ON 1
+#define HUB_VBUS_POWER_OFF 0
+#define USB_SWITCH_TO_HUB 1
+#define USB_SWITCH_TO_TYPEC 0
+#define TYPEC_VBUS_POWER_ON 1
+#define TYPEC_VBUS_POWER_OFF 0
+
+struct hisi_hikey_usb {
+	struct gpio_desc *otg_switch;
+	struct gpio_desc *typec_vbus;
+	struct gpio_desc *hub_vbus;
+
+	struct usb_role_switch *role_sw;
+	struct notifier_block nb;
+};
+
+static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
+}
+
+static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
+		int switch_to)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->otg_switch, switch_to);
+}
+
+static void usb_typec_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
+		int value)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->typec_vbus, value);
+}
+
+static int hisi_hikey_role_switch(struct notifier_block *nb,
+			unsigned long state, void *data)
+{
+	struct hisi_hikey_usb *hisi_hikey_usb;
+
+	hisi_hikey_usb = container_of(nb, struct hisi_hikey_usb, nb);
+
+	switch (state) {
+	case USB_ROLE_NONE:
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_HUB);
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_ON);
+		break;
+	case USB_ROLE_HOST:
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_ON);
+		break;
+	case USB_ROLE_DEVICE:
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int hisi_hikey_usb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_hikey_usb *hisi_hikey_usb;
+	int ret;
+
+	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
+	if (!hisi_hikey_usb)
+		return -ENOMEM;
+
+	hisi_hikey_usb->nb.notifier_call = hisi_hikey_role_switch;
+
+	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
+			GPIOD_OUT_LOW);
+	if (IS_ERR(hisi_hikey_usb->typec_vbus))
+		return PTR_ERR(hisi_hikey_usb->typec_vbus);
+
+	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch",
+			GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->otg_switch))
+		return PTR_ERR(hisi_hikey_usb->otg_switch);
+
+	/* hub-vdd33-en is optional */
+	hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
+			GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->hub_vbus))
+		return PTR_ERR(hisi_hikey_usb->hub_vbus);
+
+	hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
+	if (!hisi_hikey_usb->role_sw)
+		return -EPROBE_DEFER;
+	if (IS_ERR(hisi_hikey_usb->role_sw))
+		return PTR_ERR(hisi_hikey_usb->role_sw);
+
+	ret = usb_role_switch_register_notifier(hisi_hikey_usb->role_sw,
+			&hisi_hikey_usb->nb);
+	if (ret) {
+		usb_role_switch_put(hisi_hikey_usb->role_sw);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, hisi_hikey_usb);
+
+	return 0;
+}
+
+static int  hisi_hikey_usb_remove(struct platform_device *pdev)
+{
+	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
+
+	usb_role_switch_unregister_notifier(hisi_hikey_usb->role_sw,
+			&hisi_hikey_usb->nb);
+
+	usb_role_switch_put(hisi_hikey_usb->role_sw);
+
+	return 0;
+}
+
+static const struct of_device_id id_table_hisi_hikey_usb[] = {
+	{.compatible = "hisilicon,gpio_hubv1"},
+	{.compatible = "hisilicon,hikey960_usb"},
+	{}
+};
+
+static struct platform_driver hisi_hikey_usb_driver = {
+	.probe = hisi_hikey_usb_probe,
+	.remove = hisi_hikey_usb_remove,
+	.driver = {
+		.name = DEVICE_DRIVER_NAME,
+		.of_match_table = id_table_hisi_hikey_usb,
+	},
+};
+
+module_platform_driver(hisi_hikey_usb_driver);
+
+MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
+MODULE_DESCRIPTION("Driver Support for USB functionality of Hikey");
+MODULE_LICENSE("GPL v2");
-- 
2.15.0-rc2

