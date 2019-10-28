Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFD8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C719921835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ks8Q41j1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbfJ1V7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33328 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390454AbfJ1V7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so7908390pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9P5p/4dcNs8ql4OyOSsDmP/Eo0cfZOKgwuYqI45wfJg=;
        b=ks8Q41j1ZqA/QKFHT472CH12EK/nGPhBNjUH0WKFQdpFsYiFWCGlWyyocdHfUnLMFa
         ilBT83QeApQCioM8MCcBVzcBTr7L16ZzSYSrlsZ3svQz3Qbmu5mSay4FCb/9m1XsUVU2
         c1YR0FZ10+gBGjO9pUj9XMLVRV8DYgv7q+bju8Xop7n6vZQ9f1jfJDxhERBpjloaB6fy
         zHrBQ6YHV8IMq095CL+xzpfQDJxCaC6+b2Lj4lm6/v2LPLFB/3kHTtdPCO9b075ZTy59
         KdY31qCinVxER1+Qe5BFmn6E1SYTIZ5dzMigy+dADU7kWpKK4lDLBXZWyamHz7NfObM5
         BpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9P5p/4dcNs8ql4OyOSsDmP/Eo0cfZOKgwuYqI45wfJg=;
        b=lWlgnNtnWqwnsLIizkoNwFlltkF9ctm1oLq6qNmRy0tuYiXmlsE5mpy8pnZbD8QjmA
         oQoFx7YnnT/Eiia3P/xEuPFOcuXiOO87lE9Lm0v8t1PBTEjWUP5A3ikxv9v69FliSo0Z
         tL6EhOMq4TviI7zyKjDqo69Ez1kraI+6RR6gd9tDqOSBiJLhI9UiWcFjtxwGS9MnwaXF
         jDq/757JxFWJU6L+5TSEYdCJh8xAcJzYOo1f7d4c/o8HgC4wk6K4vIME+H14f3liqwSi
         MvZ3B+aElRLTXVfCWpZDRLtQq8yJkVernmCQbB8Ypjv4e0sly7Pq72vj0TNpHRao0yKR
         dr3w==
X-Gm-Message-State: APjAAAWuhfj9Iwo+wIXiHREmz1QY9PnhRj5aDR7oQrRs9boqRzZdNGYu
        mo6JP27xbcRTPgK2qLn2TxifJTIxGLU=
X-Google-Smtp-Source: APXvYqyzWZOig+RfCXgpnHo7l5IBFBeACyeBjNjdSXrji1GSa9dz+HugwTGG5QUBsQUIQSVHRSs/1A==
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr1902116pjd.59.1572299974196;
        Mon, 28 Oct 2019 14:59:34 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id f12sm10880612pfn.152.2019.10.28.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:59:33 -0700 (PDT)
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
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 9/9] usb: dwc3: Add host-mode as default support
Date:   Mon, 28 Oct 2019 21:59:19 +0000
Message-Id: <20191028215919.83697-10-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028215919.83697-1-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support configuring the default role the controller assumes as
host mode when the usb role is USB_ROLE_NONE

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
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Split this patch out from addition of usb-role-switch
    handling
---
 drivers/usb/dwc3/core.h |  3 +++
 drivers/usb/dwc3/drd.c  | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

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
index 61d4fd8aead4..0e3466fe5ac4 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -489,7 +489,10 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
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
 
@@ -515,7 +518,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
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
@@ -534,8 +540,14 @@ int dwc3_drd_init(struct dwc3 *dwc)
 		struct usb_role_switch_desc dwc3_role_switch = {NULL};
 		u32 mode;
 
-		mode = DWC3_GCTL_PRTCAP_DEVICE;
-
+		if (device_property_read_bool(dwc->dev,
+					      "role-switch-default-host")) {
+			dwc->role_switch_default_mode = USB_DR_MODE_HOST;
+			mode = DWC3_GCTL_PRTCAP_HOST;
+		} else {
+			dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
+			mode = DWC3_GCTL_PRTCAP_DEVICE;
+		}
 		dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 		dwc3_role_switch.set = dwc3_usb_role_switch_set;
 		dwc3_role_switch.get = dwc3_usb_role_switch_get;
-- 
2.17.1

