Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C330C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8E204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCRJwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:52:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:7960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfCRJw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 02:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126341707"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 02:52:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7392717F; Mon, 18 Mar 2019 11:52:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] extcon: intel: Split out some definitions to a common header
Date:   Mon, 18 Mar 2019 12:52:24 +0300
Message-Id: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to use some definitions in the other Intel extcon drivers,
thus, split out them to a common header file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 21 +++++++--------------
 drivers/extcon/extcon-intel.h        | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 drivers/extcon/extcon-intel.h

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 5ef215297101..110bd38a4d24 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -17,6 +17,8 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#include "extcon-intel.h"
+
 #define CHT_WC_PHYCTRL			0x5e07
 
 #define CHT_WC_CHGRCTRL0		0x5e16
@@ -65,15 +67,6 @@
 #define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
 #define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
 
-enum cht_wc_usb_id {
-	USB_ID_OTG,
-	USB_ID_GND,
-	USB_ID_FLOAT,
-	USB_RID_A,
-	USB_RID_B,
-	USB_RID_C,
-};
-
 enum cht_wc_mux_select {
 	MUX_SEL_PMIC = 0,
 	MUX_SEL_SOC,
@@ -101,9 +94,9 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
 {
 	switch ((pwrsrc_sts & CHT_WC_PWRSRC_USBID_MASK) >> CHT_WC_PWRSRC_USBID_SHIFT) {
 	case CHT_WC_PWRSRC_RID_GND:
-		return USB_ID_GND;
+		return INTEL_USB_ID_GND;
 	case CHT_WC_PWRSRC_RID_FLOAT:
-		return USB_ID_FLOAT;
+		return INTEL_USB_ID_FLOAT;
 	case CHT_WC_PWRSRC_RID_ACA:
 	default:
 		/*
@@ -111,7 +104,7 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
 		 * the USBID GPADC channel here and determine ACA role
 		 * based on that.
 		 */
-		return USB_ID_FLOAT;
+		return INTEL_USB_ID_FLOAT;
 	}
 }
 
@@ -221,7 +214,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	}
 
 	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
-	if (id == USB_ID_GND) {
+	if (id == INTEL_USB_ID_GND) {
 		/* The 5v boost causes a false VBUS / SDP detect, skip */
 		goto charger_det_done;
 	}
@@ -248,7 +241,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 		ext->previous_cable = cable;
 	}
 
-	ext->usb_host = ((id == USB_ID_GND) || (id == USB_RID_A));
+	ext->usb_host = ((id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A));
 	extcon_set_state_sync(ext->edev, EXTCON_USB_HOST, ext->usb_host);
 }
 
diff --git a/drivers/extcon/extcon-intel.h b/drivers/extcon/extcon-intel.h
new file mode 100644
index 000000000000..455986b2b004
--- /dev/null
+++ b/drivers/extcon/extcon-intel.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for Intel extcon hardware
+ *
+ * Copyright (C) 2018 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __EXTCON_INTEL_H__
+#define __EXTCON_INTEL_H__
+
+enum extcon_intel_usb_id {
+	INTEL_USB_ID_OTG,
+	INTEL_USB_ID_GND,
+	INTEL_USB_ID_FLOAT,
+	INTEL_USB_RID_A,
+	INTEL_USB_RID_B,
+	INTEL_USB_RID_C,
+};
+
+#endif	/* __EXTCON_INTEL_H__ */
-- 
2.20.1

