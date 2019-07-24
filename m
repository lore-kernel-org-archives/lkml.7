Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF110C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B817822ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfGXIvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:51:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:32541 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbfGXIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:51:46 -0400
X-UUID: 11849681974741a780759811db1006f8-20190724
X-UUID: 11849681974741a780759811db1006f8-20190724
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1430505281; Wed, 24 Jul 2019 16:51:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:51:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:51:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v8 11/11] usb: mtu3: register a USB Role Switch for dual role mode
Date:   Wed, 24 Jul 2019 16:50:45 +0800
Message-ID: <1563958245-6321-12-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1563958245-6321-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1F53A5A23995726FFBC3CE4329B0E5656694D76469A37BB177A9CB51B3996A2D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because extcon is not allowed for new bindings, and the
dual role switch is supported by USB Role Switch,
especially for Type-C drivers, so register a USB Role
Switch to support the new way

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v8 no changes
v7 no changes
v6 no changes
v5 no changes

v4 changes:
  1. assign fwnode member of usb_role_switch struct suggested by Heikki

v3 changes:
  1. select USB_ROLE_SWITCH in Kconfig suggested by Heikki
  2. rename ssusb_mode_manual_switch() to ssusb_mode_switch()

v2 no changes
---
 drivers/usb/mtu3/Kconfig        |  1 +
 drivers/usb/mtu3/mtu3.h         |  5 ++++
 drivers/usb/mtu3/mtu3_debugfs.c |  4 +--
 drivers/usb/mtu3/mtu3_dr.c      | 48 ++++++++++++++++++++++++++++++++-
 drivers/usb/mtu3/mtu3_dr.h      |  6 ++---
 drivers/usb/mtu3/mtu3_plat.c    |  3 ++-
 6 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 928c2cd6fc00..bf98fd36341d 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -44,6 +44,7 @@ config USB_MTU3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
 	depends on (EXTCON=y || EXTCON=USB_MTU3)
+	select USB_ROLE_SWITCH
 	help
 	  This is the default mode of working of MTU3 controller where
 	  both host and gadget features are enabled.
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 76ecf12fdf62..6087be236a35 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -199,6 +199,9 @@ struct mtu3_gpd_ring {
 * @id_nb : notifier for iddig(idpin) detection
 * @id_work : work of iddig detection notifier
 * @id_event : event of iddig detecion notifier
+* @role_sw : use USB Role Switch to support dual-role switch, can't use
+*		extcon at the same time, and extcon is deprecated.
+* @role_sw_used : true when the USB Role Switch is used.
 * @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
 * @manual_drd_enabled: it's true when supports dual-role device by debugfs
 *		to switch host/device modes depending on user input.
@@ -212,6 +215,8 @@ struct otg_switch_mtk {
 	struct notifier_block id_nb;
 	struct work_struct id_work;
 	unsigned long id_event;
+	struct usb_role_switch *role_sw;
+	bool role_sw_used;
 	bool is_u3_drd;
 	bool manual_drd_enabled;
 };
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index 62c57ddc554e..c96e5dab0a48 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -453,9 +453,9 @@ static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 
 	if (!strncmp(buf, "host", 4) && !ssusb->is_host) {
-		ssusb_mode_manual_switch(ssusb, 1);
+		ssusb_mode_switch(ssusb, 1);
 	} else if (!strncmp(buf, "device", 6) && ssusb->is_host) {
-		ssusb_mode_manual_switch(ssusb, 0);
+		ssusb_mode_switch(ssusb, 0);
 	} else {
 		dev_err(ssusb->dev, "wrong or duplicated setting\n");
 		return -EINVAL;
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 5fcb71af875a..08e18448e8b8 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -7,6 +7,8 @@
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  */
 
+#include <linux/usb/role.h>
+
 #include "mtu3.h"
 #include "mtu3_dr.h"
 #include "mtu3_debug.h"
@@ -280,7 +282,7 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
  * This is useful in special cases, such as uses TYPE-A receptacle but also
  * wants to support dual-role mode.
  */
-void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host)
+void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
@@ -318,6 +320,47 @@ void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 	mtu3_writel(ssusb->ippc_base, SSUSB_U2_CTRL(0), value);
 }
 
+static int ssusb_role_sw_set(struct device *dev, enum usb_role role)
+{
+	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
+	bool to_host = false;
+
+	if (role == USB_ROLE_HOST)
+		to_host = true;
+
+	if (to_host ^ ssusb->is_host)
+		ssusb_mode_switch(ssusb, to_host);
+
+	return 0;
+}
+
+static enum usb_role ssusb_role_sw_get(struct device *dev)
+{
+	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
+	enum usb_role role;
+
+	role = ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
+
+	return role;
+}
+
+static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
+{
+	struct usb_role_switch_desc role_sx_desc = { 0 };
+	struct ssusb_mtk *ssusb =
+		container_of(otg_sx, struct ssusb_mtk, otg_switch);
+
+	if (!otg_sx->role_sw_used)
+		return 0;
+
+	role_sx_desc.set = ssusb_role_sw_set;
+	role_sx_desc.get = ssusb_role_sw_get;
+	role_sx_desc.fwnode = dev_fwnode(ssusb->dev);
+	otg_sx->role_sw = usb_role_switch_register(ssusb->dev, &role_sx_desc);
+
+	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
+}
+
 int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
@@ -328,6 +371,8 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_dr_debugfs_init(ssusb);
+	else if (otg_sx->role_sw_used)
+		ret = ssusb_role_sw_register(otg_sx);
 	else
 		ret = ssusb_extcon_register(otg_sx);
 
@@ -340,4 +385,5 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 
 	cancel_work_sync(&otg_sx->id_work);
 	cancel_work_sync(&otg_sx->vbus_work);
+	usb_role_switch_unregister(otg_sx->role_sw);
 }
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index ba6fe357ce29..5e58c4dbd54a 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -71,7 +71,7 @@ static inline void ssusb_gadget_exit(struct ssusb_mtk *ssusb)
 #if IS_ENABLED(CONFIG_USB_MTU3_DUAL_ROLE)
 int ssusb_otg_switch_init(struct ssusb_mtk *ssusb);
 void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb);
-void ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host);
+void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host);
 int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on);
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 			  enum mtu3_dr_force_mode mode);
@@ -86,8 +86,8 @@ static inline int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 static inline void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 {}
 
-static inline void
-ssusb_mode_manual_switch(struct ssusb_mtk *ssusb, int to_host) {}
+static inline void ssusb_mode_switch(struct ssusb_mtk *ssusb, int to_host)
+{}
 
 static inline int ssusb_set_vbus(struct otg_switch_mtk *otg_sx, int is_on)
 {
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index fd0f6c5dfbc1..9c256ea3cdf5 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -299,8 +299,9 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	otg_sx->is_u3_drd = of_property_read_bool(node, "mediatek,usb3-drd");
 	otg_sx->manual_drd_enabled =
 		of_property_read_bool(node, "enable-manual-drd");
+	otg_sx->role_sw_used = of_property_read_bool(node, "usb-role-switch");
 
-	if (of_property_read_bool(node, "extcon")) {
+	if (!otg_sx->role_sw_used && of_property_read_bool(node, "extcon")) {
 		otg_sx->edev = extcon_get_edev_by_phandle(ssusb->dev, 0);
 		if (IS_ERR(otg_sx->edev)) {
 			dev_err(ssusb->dev, "couldn't get extcon device\n");
-- 
2.21.0

