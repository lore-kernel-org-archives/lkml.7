Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EDC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD29A21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfDTGlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 02:41:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727975AbfDTGkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 02:40:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6057E6DC528D6C601AE0;
        Sat, 20 Apr 2019 14:40:39 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Sat, 20 Apr 2019 14:40:32 +0800
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
        Yu Chen <chenyu56@huawei.com>, Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v6 10/13] usb: dwc3: Registering a role switch in the DRD code.
Date:   Sat, 20 Apr 2019 14:40:16 +0800
Message-ID: <20190420064019.57522-11-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190420064019.57522-1-chenyu56@huawei.com>
References: <20190420064019.57522-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Type-C drivers use USB role switch API to inform the
system about the negotiated data role, so registering a role
switch in the DRD code in order to support platforms with
USB Type-C connectors.

Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
v2:
* Assign fwnode in dwc3_role_switch.
v3:
* Add default mode property for usb role switch.
* Add select USB_ROLE_SWITCH for USB_DWC3_DUAL_ROLE in Kconfig.
* Do usb_role_switch_register only if property "usb-role-switch"
* present.
v4:
* Add description for 'role_sw' and 'role_switch_default_mode'.
v5:
* Init dwc3 mode for usb_role_switch branch.
v6:
* Fold a fix of dwc3_usb_role_switch_get in from John Stultz
  <john.stultz@linaro.org>
---
---
 drivers/usb/dwc3/Kconfig |  1 +
 drivers/usb/dwc3/core.h  |  6 ++++
 drivers/usb/dwc3/drd.c   | 78 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2b1494460d0c..661b1d2efc8b 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -44,6 +44,7 @@ config USB_DWC3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
 	depends on (EXTCON=y || EXTCON=USB_DWC3)
+	select USB_ROLE_SWITCH
 	help
 	  This is the default mode of working of DWC3 controller where
 	  both host and gadget features are enabled.
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6a050d663ec7..e6d40f79faa7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -958,6 +959,9 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * role_sw: usb_role_switch handle
+ * role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1091,6 +1095,8 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 726100d1ac0d..4ef3dd9aae66 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -479,6 +479,58 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 mode;
+
+	switch (role) {
+	case USB_ROLE_HOST:
+		mode = DWC3_GCTL_PRTCAP_HOST;
+		break;
+	case USB_ROLE_DEVICE:
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	default:
+		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
+			mode = DWC3_GCTL_PRTCAP_HOST;
+		else
+			mode = DWC3_GCTL_PRTCAP_DEVICE;
+		break;
+	}
+
+	dwc3_set_mode(dwc, mode);
+	return 0;
+}
+
+static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	unsigned long flags;
+	enum usb_role role;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	switch (dwc->current_dr_role) {
+	case DWC3_GCTL_PRTCAP_HOST:
+		role = USB_ROLE_HOST;
+		break;
+	case DWC3_GCTL_PRTCAP_DEVICE:
+		role = USB_ROLE_DEVICE;
+		break;
+	case DWC3_GCTL_PRTCAP_OTG:
+		role = dwc->current_otg_role;
+		break;
+	default:
+		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
+			role = USB_ROLE_HOST;
+		else
+			role = USB_ROLE_DEVICE;
+		break;
+	}
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return role;
+}
+
 int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
@@ -487,7 +539,28 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (dwc->edev) {
+	if (device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		struct usb_role_switch_desc dwc3_role_switch = {0};
+		u32 mode;
+
+		if (device_property_read_bool(dwc->dev,
+				"role-switch-default-host")) {
+			dwc->role_switch_default_mode = USB_DR_MODE_HOST;
+			mode = DWC3_GCTL_PRTCAP_HOST;
+		} else {
+			dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
+			mode = DWC3_GCTL_PRTCAP_DEVICE;
+		}
+		dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
+		dwc3_role_switch.set = dwc3_usb_role_switch_set;
+		dwc3_role_switch.get = dwc3_usb_role_switch_get;
+		dwc->role_sw = usb_role_switch_register(dwc->dev,
+							&dwc3_role_switch);
+		if (IS_ERR(dwc->role_sw))
+			return PTR_ERR(dwc->role_sw);
+
+		dwc3_set_mode(dwc, mode);
+	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -534,6 +607,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
+	if (dwc->role_sw)
+		usb_role_switch_unregister(dwc->role_sw);
+
 	if (dwc->edev)
 		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
 					   &dwc->edev_nb);
-- 
2.15.0-rc2

