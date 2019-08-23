Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F2CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA3F22CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392934AbfHWH5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:57:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:2378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392239AbfHWH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:57:52 -0400
X-UUID: dc7c541aa71843a2a4a586e61045836f-20190823
X-UUID: dc7c541aa71843a2a4a586e61045836f-20190823
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2064025835; Fri, 23 Aug 2019 15:57:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 23 Aug 2019 15:57:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Aug 2019 15:57:33 +0800
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
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH next v10 09/11] usb: common: create Kconfig file
Date:   Fri, 23 Aug 2019 15:57:19 +0800
Message-ID: <1566547041-20804-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1566547041-20804-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A11A0C8B56F7293B72F5DE2933BD9567EC86025288023371D9F1698DF7036BBE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create Kconfig file for USB common core, and move USB_LED_TRIG
and USB_ULPI_BUS configs into the new file from the parent Kconfig,
it will help to add new configs later.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v9~v10: no changes

v8:
  new patch
---
 drivers/usb/Kconfig        | 35 +----------------------------------
 drivers/usb/common/Kconfig | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 34 deletions(-)
 create mode 100644 drivers/usb/common/Kconfig

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 6e59d370ef81..7bf94e65ed2f 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -36,8 +36,7 @@ menuconfig USB_SUPPORT
 
 if USB_SUPPORT
 
-config USB_COMMON
-	tristate
+source "drivers/usb/common/Kconfig"
 
 config USB_ARCH_HAS_HCD
 	def_bool y
@@ -175,36 +174,4 @@ source "drivers/usb/typec/Kconfig"
 
 source "drivers/usb/roles/Kconfig"
 
-config USB_LED_TRIG
-	bool "USB LED Triggers"
-	depends on LEDS_CLASS && LEDS_TRIGGERS
-	select USB_COMMON
-	help
-	  This option adds LED triggers for USB host and/or gadget activity.
-
-	  Say Y here if you are working on a system with led-class supported
-	  LEDs and you want to use them as activity indicators for USB host or
-	  gadget.
-
-config USB_ULPI_BUS
-	tristate "USB ULPI PHY interface support"
-	select USB_COMMON
-	help
-	  UTMI+ Low Pin Interface (ULPI) is specification for a commonly used
-	  USB 2.0 PHY interface. The ULPI specification defines a standard set
-	  of registers that can be used to detect the vendor and product which
-	  allows ULPI to be handled as a bus. This module is the driver for that
-	  bus.
-
-	  The ULPI interfaces (the buses) are registered by the drivers for USB
-	  controllers which support ULPI register access and have ULPI PHY
-	  attached to them. The ULPI PHY drivers themselves are normal PHY
-	  drivers.
-
-	  ULPI PHYs provide often functions such as ADP sensing/probing (OTG
-	  protocol) and USB charger detection.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called ulpi.
-
 endif # USB_SUPPORT
diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
new file mode 100644
index 000000000000..848545b099cf
--- /dev/null
+++ b/drivers/usb/common/Kconfig
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config USB_COMMON
+	tristate
+
+
+config USB_LED_TRIG
+	bool "USB LED Triggers"
+	depends on LEDS_CLASS && LEDS_TRIGGERS
+	select USB_COMMON
+	help
+	  This option adds LED triggers for USB host and/or gadget activity.
+
+	  Say Y here if you are working on a system with led-class supported
+	  LEDs and you want to use them as activity indicators for USB host or
+	  gadget.
+
+config USB_ULPI_BUS
+	tristate "USB ULPI PHY interface support"
+	select USB_COMMON
+	help
+	  UTMI+ Low Pin Interface (ULPI) is specification for a commonly used
+	  USB 2.0 PHY interface. The ULPI specification defines a standard set
+	  of registers that can be used to detect the vendor and product which
+	  allows ULPI to be handled as a bus. This module is the driver for that
+	  bus.
+
+	  The ULPI interfaces (the buses) are registered by the drivers for USB
+	  controllers which support ULPI register access and have ULPI PHY
+	  attached to them. The ULPI PHY drivers themselves are normal PHY
+	  drivers.
+
+	  ULPI PHYs provide often functions such as ADP sensing/probing (OTG
+	  protocol) and USB charger detection.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called ulpi.
+
-- 
2.23.0

