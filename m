Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD1C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BEC212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404201AbfFKIpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:45:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391351AbfFKIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:45:33 -0400
X-UUID: d418398492fb4a569817426d467d8810-20190611
X-UUID: d418398492fb4a569817426d467d8810-20190611
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1682786078; Tue, 11 Jun 2019 16:45:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Jun 2019 16:45:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Jun 2019 16:45:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH v7 09/10] usb: roles: add USB Type-B GPIO connector driver
Date:   Tue, 11 Jun 2019 16:44:39 +0800
Message-ID: <1560242680-23844-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1560242680-23844-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1560242680-23844-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the requirement of usb-connector.txt binding, the old way
using extcon to support USB Dual-Role switch is now deprecated
when use Type-B connector.
This patch introduces a driver of Type-B connector which typically
uses an input GPIO to detect USB ID pin, and try to replace the
function provided by extcon-usb-gpio driver

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
v7 changes:
  1. remove macro DEV_PMS_OPS suggested by Andy
  2. add tested-by Nagarjuna

v6 changes:
  1. get usb-role-swtich by usb_role_switch_get()

v5 changes:
  1. put usb_role_switch when error happens suggested by Biju
  2. don't treat bype-B connector as a virtual device suggested by Rob

v4 changes:
  1. remove linux/gpio.h suggested by Linus
  2. put node when error happens

v3 changes:
  1. treat bype-B connector as a virtual device;
  2. change file name again

v2 changes:
  1. file name is changed
  2. use new compatible
---
 drivers/usb/roles/Kconfig           |  11 ++
 drivers/usb/roles/Makefile          |   1 +
 drivers/usb/roles/typeb-conn-gpio.c | 284 ++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 drivers/usb/roles/typeb-conn-gpio.c

diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
index f8b31aa67526..d1156e18a81a 100644
--- a/drivers/usb/roles/Kconfig
+++ b/drivers/usb/roles/Kconfig
@@ -26,4 +26,15 @@ config USB_ROLES_INTEL_XHCI
 	  To compile the driver as a module, choose M here: the module will
 	  be called intel-xhci-usb-role-switch.
 
+config TYPEB_CONN_GPIO
+	tristate "USB Type-B GPIO Connector"
+	depends on GPIOLIB
+	help
+	  The driver supports USB role switch between host and device via GPIO
+	  based USB cable detection, used typically if an input GPIO is used
+	  to detect USB ID pin.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called typeb-conn-gpio.ko
+
 endif # USB_ROLE_SWITCH
diff --git a/drivers/usb/roles/Makefile b/drivers/usb/roles/Makefile
index 757a7d2797eb..5d5620d9d113 100644
--- a/drivers/usb/roles/Makefile
+++ b/drivers/usb/roles/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_USB_ROLE_SWITCH)		+= roles.o
 roles-y					:= class.o
 obj-$(CONFIG_USB_ROLES_INTEL_XHCI)	+= intel-xhci-usb-role-switch.o
+obj-$(CONFIG_TYPEB_CONN_GPIO)		+= typeb-conn-gpio.o
diff --git a/drivers/usb/roles/typeb-conn-gpio.c b/drivers/usb/roles/typeb-conn-gpio.c
new file mode 100644
index 000000000000..e3fba1656069
--- /dev/null
+++ b/drivers/usb/roles/typeb-conn-gpio.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Type-B GPIO Connector Driver
+ *
+ * Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ * Some code borrowed from drivers/extcon/extcon-usb-gpio.c
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/role.h>
+
+#define USB_GPIO_DEB_MS		20	/* ms */
+#define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
+
+#define USB_CONN_IRQF	\
+	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
+
+struct usb_conn_info {
+	struct device *dev;
+	struct usb_role_switch *role_sw;
+	enum usb_role last_role;
+	struct regulator *vbus;
+	struct delayed_work dw_det;
+	unsigned long debounce_jiffies;
+
+	struct gpio_desc *id_gpiod;
+	struct gpio_desc *vbus_gpiod;
+	int id_irq;
+	int vbus_irq;
+};
+
+/**
+ * "DEVICE" = VBUS and "HOST" = !ID, so we have:
+ * Both "DEVICE" and "HOST" can't be set as active at the same time
+ * so if "HOST" is active (i.e. ID is 0)  we keep "DEVICE" inactive
+ * even if VBUS is on.
+ *
+ *  Role          |   ID  |  VBUS
+ * ------------------------------------
+ *  [1] DEVICE    |   H   |   H
+ *  [2] NONE      |   H   |   L
+ *  [3] HOST      |   L   |   H
+ *  [4] HOST      |   L   |   L
+ *
+ * In case we have only one of these signals:
+ * - VBUS only - we want to distinguish between [1] and [2], so ID is always 1
+ * - ID only - we want to distinguish between [1] and [4], so VBUS = ID
+ */
+static void usb_conn_detect_cable(struct work_struct *work)
+{
+	struct usb_conn_info *info;
+	enum usb_role role;
+	int id, vbus, ret;
+
+	info = container_of(to_delayed_work(work),
+			    struct usb_conn_info, dw_det);
+
+	/* check ID and VBUS */
+	id = info->id_gpiod ?
+		gpiod_get_value_cansleep(info->id_gpiod) : 1;
+	vbus = info->vbus_gpiod ?
+		gpiod_get_value_cansleep(info->vbus_gpiod) : id;
+
+	if (!id)
+		role = USB_ROLE_HOST;
+	else if (vbus)
+		role = USB_ROLE_DEVICE;
+	else
+		role = USB_ROLE_NONE;
+
+	dev_dbg(info->dev, "role %d/%d, gpios: id %d, vbus %d\n",
+		info->last_role, role, id, vbus);
+
+	if (info->last_role == role) {
+		dev_warn(info->dev, "repeated role: %d\n", role);
+		return;
+	}
+
+	if (info->last_role == USB_ROLE_HOST)
+		regulator_disable(info->vbus);
+
+	ret = usb_role_switch_set_role(info->role_sw, role);
+	if (ret)
+		dev_err(info->dev, "failed to set role: %d\n", ret);
+
+	if (role == USB_ROLE_HOST) {
+		ret = regulator_enable(info->vbus);
+		if (ret)
+			dev_err(info->dev, "enable vbus regulator failed\n");
+	}
+
+	info->last_role = role;
+
+	dev_dbg(info->dev, "vbus regulator is %s\n",
+		regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
+}
+
+static void usb_conn_queue_dwork(struct usb_conn_info *info,
+				 unsigned long delay)
+{
+	queue_delayed_work(system_power_efficient_wq, &info->dw_det, delay);
+}
+
+static irqreturn_t usb_conn_isr(int irq, void *dev_id)
+{
+	struct usb_conn_info *info = dev_id;
+
+	usb_conn_queue_dwork(info, info->debounce_jiffies);
+
+	return IRQ_HANDLED;
+}
+
+static int usb_conn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct usb_conn_info *info;
+	int ret = 0;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = dev;
+	info->id_gpiod = devm_gpiod_get_optional(dev, "id", GPIOD_IN);
+	if (IS_ERR(info->id_gpiod))
+		return PTR_ERR(info->id_gpiod);
+
+	info->vbus_gpiod = devm_gpiod_get_optional(dev, "vbus", GPIOD_IN);
+	if (IS_ERR(info->vbus_gpiod))
+		return PTR_ERR(info->vbus_gpiod);
+
+	if (!info->id_gpiod && !info->vbus_gpiod) {
+		dev_err(dev, "failed to get gpios\n");
+		return -ENODEV;
+	}
+
+	if (info->id_gpiod)
+		ret = gpiod_set_debounce(info->id_gpiod, USB_GPIO_DEB_US);
+	if (!ret && info->vbus_gpiod)
+		ret = gpiod_set_debounce(info->vbus_gpiod, USB_GPIO_DEB_US);
+	if (ret < 0)
+		info->debounce_jiffies = msecs_to_jiffies(USB_GPIO_DEB_MS);
+
+	INIT_DELAYED_WORK(&info->dw_det, usb_conn_detect_cable);
+
+	info->vbus = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(info->vbus)) {
+		dev_err(dev, "failed to get vbus\n");
+		return PTR_ERR(info->vbus);
+	}
+
+	info->role_sw = usb_role_switch_get(dev);
+	if (IS_ERR(info->role_sw)) {
+		if (PTR_ERR(info->role_sw) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get role switch\n");
+
+		return PTR_ERR(info->role_sw);
+	}
+
+	if (info->id_gpiod) {
+		info->id_irq = gpiod_to_irq(info->id_gpiod);
+		if (info->id_irq < 0) {
+			dev_err(dev, "failed to get ID IRQ\n");
+			ret = info->id_irq;
+			goto put_role_sw;
+		}
+
+		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
+						usb_conn_isr, USB_CONN_IRQF,
+						pdev->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request ID IRQ\n");
+			goto put_role_sw;
+		}
+	}
+
+	if (info->vbus_gpiod) {
+		info->vbus_irq = gpiod_to_irq(info->vbus_gpiod);
+		if (info->vbus_irq < 0) {
+			dev_err(dev, "failed to get VBUS IRQ\n");
+			ret = info->vbus_irq;
+			goto put_role_sw;
+		}
+
+		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
+						usb_conn_isr, USB_CONN_IRQF,
+						pdev->name, info);
+		if (ret < 0) {
+			dev_err(dev, "failed to request VBUS IRQ\n");
+			goto put_role_sw;
+		}
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	/* Perform initial detection */
+	usb_conn_queue_dwork(info, 0);
+
+	return 0;
+
+put_role_sw:
+	usb_role_switch_put(info->role_sw);
+	return ret;
+}
+
+static int usb_conn_remove(struct platform_device *pdev)
+{
+	struct usb_conn_info *info = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&info->dw_det);
+
+	if (info->last_role == USB_ROLE_HOST)
+		regulator_disable(info->vbus);
+
+	usb_role_switch_put(info->role_sw);
+
+	return 0;
+}
+
+static int __maybe_unused usb_conn_suspend(struct device *dev)
+{
+	struct usb_conn_info *info = dev_get_drvdata(dev);
+
+	if (info->id_gpiod)
+		disable_irq(info->id_irq);
+	if (info->vbus_gpiod)
+		disable_irq(info->vbus_irq);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int __maybe_unused usb_conn_resume(struct device *dev)
+{
+	struct usb_conn_info *info = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_default_state(dev);
+
+	if (info->id_gpiod)
+		enable_irq(info->id_irq);
+	if (info->vbus_gpiod)
+		enable_irq(info->vbus_irq);
+
+	usb_conn_queue_dwork(info, 0);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
+			 usb_conn_suspend, usb_conn_resume);
+
+static const struct of_device_id usb_conn_dt_match[] = {
+	{ .compatible = "linux,typeb-conn-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, usb_conn_dt_match);
+
+static struct platform_driver usb_conn_driver = {
+	.probe		= usb_conn_probe,
+	.remove		= usb_conn_remove,
+	.driver		= {
+		.name	= "typeb-conn-gpio",
+		.pm	= &usb_conn_pm_ops,
+		.of_match_table = usb_conn_dt_match,
+	},
+};
+
+module_platform_driver(usb_conn_driver);
+
+MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
+MODULE_DESCRIPTION("USB Type-B GPIO connector driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

