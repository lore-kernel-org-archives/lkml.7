Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD2C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B32077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+mTiQrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfLLBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:42:42 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:43406 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLLBmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:42:40 -0500
Received: by mail-pj1-f66.google.com with SMTP id g4so311334pjs.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=32ma7jm/USpVtHg7Ie1n8hF+znRzdCi92DyYoi4rfjo=;
        b=m+mTiQrtpDWGf8kluPe58Em+efx6c+lCdtucq14oYvmCpsKuuTM8BUXaasXe14TZYn
         H6Tnrvxy9hRKBqwKqGUVUHcktLAxzgl9bnPjC8dOQLAG3TIGOMTMTPOJlsQX82RKIZYF
         85UTwtwfUMAhZO3fAj9PeUoGJnIbRz8p0F/qD4JkkvXymwEMZpMxeoE2fIoC6Uhehbol
         gpfVQ/T/xagGQllRGVpT0qupuDtYnGHiin1ia/ZG0K7GT7qJtCqlNxw4hmwts5Cxw1uM
         o7ZzXtR961PKot2SEb2q/gyGr3a+13GlAP7UAD8VjGNexQXecbDhcglCwtYzWsp+2s2g
         RC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=32ma7jm/USpVtHg7Ie1n8hF+znRzdCi92DyYoi4rfjo=;
        b=FKEn75Pyjuk1Auy8I7KQFst0gxKHkpyjrrHqUuXP9AJ8xNDiWM+pZvpHTqeeslz3Da
         Xg76jsy+Jv0sjLgdPEo5G6SygGF++L0eOnfujCYyoz3Mk25qsRa7exd/At5t/j3b9Sgw
         oMiBWJJcnDoPUIuaeVAj1IehSaVyBr9KDfKUgP/idV5PMxFbkNCgMOnOYwv/xl6V3pSJ
         PRCOXH+TZPpi65863t45Rac86MQHMuz7n1vFidXMCUimOoqfvaNRzOd8Cp4GACFbS2E+
         RQ0K/rF6xEAle3oebSpo+JDrD+t03tLptXUnCT4GwbZ6S0qesyCFpKmjfDW3OjTgPY2h
         2+hw==
X-Gm-Message-State: APjAAAWB04BSPAUEN7IBbWAzSwx2fZ8qLrunNW6u6wWexe/nyHfFqC1u
        9yXvnpZd0UrzhX+eDaZO026spWEr444=
X-Google-Smtp-Source: APXvYqxwMBPmGhcRAfOeLiir9tLLli4TVTdqLolBlxPaPpfE7Ngtm6Agj9aoLb0yUwDUnflxYeyX5g==
X-Received: by 2002:a17:902:d204:: with SMTP id t4mr6880334ply.167.1576114959256;
        Wed, 11 Dec 2019 17:42:39 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id p16sm4217996pgi.50.2019.12.11.17.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:42:38 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 3/8] usb: dwc3: Add support for role-switch-default-mode binding
Date:   Thu, 12 Dec 2019 01:42:28 +0000
Message-Id: <20191212014233.32799-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212014233.32799-1-john.stultz@linaro.org>
References: <20191212014233.32799-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the new role-switch-default-mode binding for configuring
the default role the controller assumes as when the usb role is
USB_ROLE_NONE

This patch was split out from a larger patch originally by
Yu Chen <chenyu56@huawei.com>

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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Split this patch out from addition of usb-role-switch
    handling
v5: Reworked to use string based role-switch-default-mode
---
 drivers/usb/dwc3/core.h |  3 +++
 drivers/usb/dwc3/drd.c  | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6f19e9891767..3c879c9ab1aa 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -953,6 +953,8 @@ struct dwc3_scratchpad_array {
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
  * @role_sw: usb_role_switch handle
+ * @role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1087,6 +1089,7 @@ struct dwc3 {
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
 	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 331c6e997f0c..db68d48c2267 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -491,7 +491,10 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 		break;
 	default:
-		mode = DWC3_GCTL_PRTCAP_DEVICE;
+		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
+			mode = DWC3_GCTL_PRTCAP_HOST;
+		else
+			mode = DWC3_GCTL_PRTCAP_DEVICE;
 		break;
 	}
 
@@ -517,7 +520,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
 		role = dwc->current_otg_role;
 		break;
 	default:
-		role = USB_ROLE_DEVICE;
+		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
+			role = USB_ROLE_HOST;
+		else
+			role = USB_ROLE_DEVICE;
 		break;
 	}
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -527,6 +533,19 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
 static int dwc3_setup_role_switch(struct dwc3 *dwc)
 {
 	struct usb_role_switch_desc dwc3_role_switch = {NULL};
+	const char *str;
+	u32 mode;
+	int ret;
+
+	ret = device_property_read_string(dwc->dev, "role-switch-default-mode",
+					  &str);
+	if (ret >= 0  && !strncmp(str, "host", strlen("host"))) {
+		dwc->role_switch_default_mode = USB_DR_MODE_HOST;
+		mode = DWC3_GCTL_PRTCAP_HOST;
+	} else {
+		dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
+		mode = DWC3_GCTL_PRTCAP_DEVICE;
+	}
 
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
@@ -535,7 +554,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 	if (IS_ERR(dwc->role_sw))
 		return PTR_ERR(dwc->role_sw);
 
-	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_mode(dwc, mode);
 	return 0;
 }
 #else
-- 
2.17.1

