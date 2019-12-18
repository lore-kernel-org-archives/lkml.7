Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB34224650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YuAaaGNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLRJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:17:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8049 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:17:32 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9eea20000>; Wed, 18 Dec 2019 01:17:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:17:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 01:17:31 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:31 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:30 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9eea70000>; Wed, 18 Dec 2019 01:17:30 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 10/18] usb: gadget: tegra-xudc: Add usb-phy support
Date:   Wed, 18 Dec 2019 14:46:23 +0530
Message-ID: <1576660591-10383-11-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660642; bh=sAjy8kATr5C3ogrlFEUEa5aW9btVjRCI+dTUVDzabUs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YuAaaGNpRWgpvOmbP0T5uBJyMknwSoyV8xgIVwKcw3yvujNuCb29PJ0puOqAlhjel
         VHjA9x0cnyqVojN7j5BqzSF6nnmUoaKmPbZGlpLyKPN+zT07bXKJ1N2LoXxj1cxf4L
         cw9AdTvrnK7rIJ4Pnc1RvOQLP55CcjVCW8/cfYgGrrw9Jf37WYczro/5BsYNGKnnYQ
         HMWNZ19nZmQaT5TIHlhdE/TSN3oK+B07A0NsZ9Q3Sakt2SW4njnGINfKULAlwcvoD2
         6WnC5YuKjFwPRTCDLM8dDKucFBACY3bBZHxT0FqNGaxrfvayPyDazyS+DWMs7iTdUB
         MMWvYsNvMUAag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-phy is used to get notified on the USB role changes. Get usb-phy from
the utmi phy.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - No changes in this version
---
 drivers/usb/gadget/udc/tegra-xudc.c | 39 +++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 6ddb974..0f27d57 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -26,7 +26,9 @@
 #include <linux/reset.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include <linux/usb/role.h>
+#include <linux/usb/phy.h>
 #include <linux/workqueue.h>
 
 /* XUSB_DEV registers */
@@ -488,6 +490,9 @@ struct tegra_xudc {
 	bool suspended;
 	bool powergated;
 
+	struct usb_phy *usbphy;
+	struct notifier_block vbus_nb;
+
 	struct completion disconnect_complete;
 
 	bool selfpowered;
@@ -678,7 +683,22 @@ static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
 		tegra_xudc_device_mode_on(xudc);
 	else
 		tegra_xudc_device_mode_off(xudc);
+}
+
+static int tegra_xudc_vbus_notifier(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct tegra_xudc *xudc = container_of(nb, struct tegra_xudc,
+					       vbus_nb);
+
+	dev_dbg(xudc->dev, "%s action is %ld\n", __func__, action);
+
+	xudc->role = (enum usb_role)action;
 
+	if (!xudc->suspended)
+		schedule_work(&xudc->usb_role_sw_work);
+
+	return NOTIFY_OK;
 }
 
 static void tegra_xudc_plc_reset_work(struct work_struct *work)
@@ -1949,6 +1969,9 @@ static int tegra_xudc_gadget_start(struct usb_gadget *gadget,
 		xudc_writel(xudc, val, CTRL);
 	}
 
+	if (xudc->usbphy)
+		otg_set_peripheral(xudc->usbphy->otg, gadget);
+
 	xudc->driver = driver;
 unlock:
 	dev_dbg(xudc->dev, "%s: ret value is %d", __func__, ret);
@@ -1969,6 +1992,9 @@ static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
 
 	spin_lock_irqsave(&xudc->lock, flags);
 
+	if (xudc->usbphy)
+		otg_set_peripheral(xudc->usbphy->otg, NULL);
+
 	val = xudc_readl(xudc, CTRL);
 	val &= ~(CTRL_IE | CTRL_ENABLE);
 	xudc_writel(xudc, val, CTRL);
@@ -3573,10 +3599,15 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
 				tegra_xudc_port_reset_war_work);
 
-	/* Set the mode as device mode and this keeps phy always ON */
-	dev_info(xudc->dev, "Set usb role to device mode always");
-	xudc->role = USB_ROLE_DEVICE;
-	schedule_work(&xudc->usb_role_sw_work);
+	xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notifier;
+	xudc->usbphy = devm_usb_get_phy_by_node(xudc->dev,
+						xudc->utmi_phy->dev.of_node,
+						&xudc->vbus_nb);
+	if (IS_ERR(xudc->usbphy)) {
+		err = PTR_ERR(xudc->usbphy);
+		dev_err(xudc->dev, "failed to get usbphy phy: %d\n", err);
+		goto free_eps;
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.7.4

