Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD3BC2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551F922B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMpTmiIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfLLBmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:42:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36732 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLLBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:42:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so239491pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ml1LjDh4MXlYnFnFE/FtxHnraLrSz8z9onh0HzsL760=;
        b=hMpTmiInIBymA2Q22Jm1fo58ppcLh0yU84O6ZMaompS+uew7ESCc6RQ/Z+KExCCCeq
         1OIAAeu41gf7hcC+ncpsq/RBaqmO4vNJYxNNWcXIx6X0TmrcqevlJsSnOSjAKus/7P1K
         rovkRah8SrYcnnymkRABNxuseu+5fOqmI3Hhp7Gk8gJ25SCA4MANpT7auNqELLLs9ytW
         LdBssxJwlThBIAhGQ8iHaRonxhWYpSOTZbGBXZ7k8istps/jXfocrwu3lJD5Bzi1bCPo
         4LGqtBYHvB1IBEVKpYB8OEplt6O/hkn1Mtgzi4FPhIi2MpNnazl/XsV6vjD6zUds3zSl
         AngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ml1LjDh4MXlYnFnFE/FtxHnraLrSz8z9onh0HzsL760=;
        b=k3QeRmi20f8EyechaM1+3X4MI2AeMJ0Px2P60CFKzaMZoLDgy8chBg3KDmDTwy1G92
         T+vS4HvnrYQScNc0w8M4j19nUCo1mMMtLI0RV51yrUYAKqUmSZ9NrLlg20CqpUFF9qDz
         M9+t9BtmKtMZtrmS0M32Qp2OamVu0LruK720dzSiUmV6/Ws18cTuLufVqHtqIniUxJoy
         jzlhkwdHhz1OxTKsRbMpbS73tEEaOdzFQVv99QkB9dZW6WeSGi8FmktVb2vcRVHu9BbO
         onFLXakKOKmaNztMReQ0fbVkbC/K7YMl+o4s0LIB4v0hO2ZLNN7UY4wlIm2GLNRqQ4dW
         goow==
X-Gm-Message-State: APjAAAVQ4tBSTgSfdVFP5d+uYc2BX3hCe/mqj+Rj971MDGVVbggJVQ6K
        6erA9KrhnLQ8Y+4hmt7mDg0TT7oFUbM=
X-Google-Smtp-Source: APXvYqxHjCHCFrFsgxnWqrYumB5psG22m+Be/hnjF4m6nET2BX6Fx5pTV4teAFcB6L2y+7CzAlmjZg==
X-Received: by 2002:a63:d62:: with SMTP id 34mr7941909pgn.268.1576114956964;
        Wed, 11 Dec 2019 17:42:36 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id p16sm4217996pgi.50.2019.12.11.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:42:36 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH v7 1/8] usb: dwc3: Registering a role switch in the DRD code.
Date:   Thu, 12 Dec 2019 01:42:26 +0000
Message-Id: <20191212014233.32799-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212014233.32799-1-john.stultz@linaro.org>
References: <20191212014233.32799-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

The Type-C drivers use USB role switch API to inform the
system about the negotiated data role, so registering a role
switch in the DRD code in order to support platforms with
USB Type-C connectors.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix role_sw and role_switch_default_mode descriptions as
    reported by kbuild test robot <lkp@intel.com>

v3: Split out the role-switch-default-host logic into its own
    patch

v5: Drop selecting CONFIG_USB_ROLE_SWITCH & ifdef dependent code

v6: Fix build issue Reported-by: kbuild test robot <lkp@intel.com>

v7: Minor fix for CONFIG_USB_ROLE_SWITCH=m case not building
    the role switch handling code, reported by
    Guillaume Gardet <Guillaume.Gardet@arm.com>
---
 drivers/usb/dwc3/core.h |  3 ++
 drivers/usb/dwc3/drd.c  | 77 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b349379af..6f19e9891767 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -951,6 +952,7 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @role_sw: usb_role_switch handle
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1084,6 +1086,7 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index c946d64142ad..331c6e997f0c 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -476,6 +476,73 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
+#define ROLE_SWITCH 1
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
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
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
+		role = USB_ROLE_DEVICE;
+		break;
+	}
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return role;
+}
+
+static int dwc3_setup_role_switch(struct dwc3 *dwc)
+{
+	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+
+	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
+	dwc3_role_switch.set = dwc3_usb_role_switch_set;
+	dwc3_role_switch.get = dwc3_usb_role_switch_get;
+	dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
+	if (IS_ERR(dwc->role_sw))
+		return PTR_ERR(dwc->role_sw);
+
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	return 0;
+}
+#else
+#define ROLE_SWITCH 0
+#define dwc3_setup_role_switch(x) 0
+#endif
+
 int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, irq;
@@ -484,7 +551,12 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);
 
-	if (dwc->edev) {
+	if (ROLE_SWITCH &&
+	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		ret = dwc3_setup_role_switch(dwc);
+		if (ret < 0)
+			return ret;
+	} else if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -531,6 +603,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
 {
 	unsigned long flags;
 
+	if (dwc->role_sw)
+		usb_role_switch_unregister(dwc->role_sw);
+
 	if (dwc->edev)
 		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
 					   &dwc->edev_nb);
-- 
2.17.1

