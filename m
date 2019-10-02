Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD563C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9B3222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEs5WOuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfJBXQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:16:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45227 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfJBXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:16:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so508616pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxUelUZoTzRMyxNxjTZuYP1rs0YqSW4KUYVQurWum4s=;
        b=SEs5WOuMQ9i46KZODDHA2eT1753KTFIhfQtIBC0vgfTge55jTvENz2ehdd4XniMNpV
         FpJtfOyUH9JpzGyCOHvO1r+3/4sI8HYLS3DFBp3LIw7XcbjreXvWPVUDbhBEbirCSzEt
         wCsSGakoroSPK+wb+rVZnLReSg/0yKh333p+YgxAXAeLZ3NtWIG3VPJjTPRBe1rwYhWp
         qyWb4CTc6qpxj7lv4JpBBjdfFJtbV2Mf93hhOTNY5A/rA/yu+xv5sG0AIv2yzsWMkakG
         EcVoZFuOtv5RpH1aJLeWXuYiVHwxSUpcaIRXZ6I/TTaJfCj0uDQfK3AzpaJkExFZIExc
         JmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxUelUZoTzRMyxNxjTZuYP1rs0YqSW4KUYVQurWum4s=;
        b=kcNgO/upuAM2ttAq2FKO+G2BttlfOnFzWNKLnr8VHUiONFuLhjDVRsm8EOcz6c8bGS
         jE37cBBFE2bkLSnA0W9UX/PK5NXDyczRFI1Qst282hpxsP+ucmX0jcNzKDyW4V9XhM9n
         en9Kc3Ssl3Oebx6GrK2MtaHXzOEUcc7gTkrWwOhSKYsNChGiLYOVjPklVmLn5sdHYqCg
         byujiUKsaTMit6s3jQy/AjbcaRYK75hyvwM3Nsc+fPuJ/x3qkl1gJVUGunwZ5k7vw0no
         b9RPUosp91dS39PLrwZ4Oc4rhZTBESn3WKsj88likAxBfvf+1I2+6k0+bjmtdmu9yFty
         IF+Q==
X-Gm-Message-State: APjAAAWGjWH33vXMBYIUanrsFp07HIrLGIEuVivt75kw1iTgcupolrrc
        zPlbovd34bAtWL6//u1nEL3Hsaj/hvk=
X-Google-Smtp-Source: APXvYqziu9jZ7DI+pIb89nbIQdGRbeE9ytAfHCKWE3r1VSYxVgY8EoqtYas3YrMcVkRMQo60mB2rDA==
X-Received: by 2002:a17:90a:8087:: with SMTP id c7mr7238620pjn.56.1570058187290;
        Wed, 02 Oct 2019 16:16:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l7sm288791pjy.12.2019.10.02.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:16:26 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 3/3] usb: dwc3: Registering a role switch in the DRD code.
Date:   Wed,  2 Oct 2019 23:16:17 +0000
Message-Id: <20191002231617.3670-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002231617.3670-1-john.stultz@linaro.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
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
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/Kconfig |  1 +
 drivers/usb/dwc3/core.h  |  6 ++++
 drivers/usb/dwc3/drd.c   | 78 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 89abc6078703..1104745c41a9 100644
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
index b3cb6eec3f8f..83728157b3e9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -951,6 +952,9 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * role_sw: usb_role_switch handle
+ * role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1085,6 +1089,8 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 726100d1ac0d..95b466a7faa0 100644
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
+					      "role-switch-default-host")) {
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
2.17.1

