Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22ECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B50B2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbfJWLWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:63110 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404697AbfJWLWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="210009648"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2019 04:22:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DD1DE6D2; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] thunderbolt: Update Kconfig entry to USB4
Date:   Wed, 23 Oct 2019 14:21:50 +0300
Message-Id: <20191023112154.64235-22-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the driver now supports USB4 which is the standard going forward,
update the Kconfig entry to mention this and rename the entry from
CONFIG_THUNDERBOLT to CONFIG_USB4 instead to help people to find the
correct option if they want to enable USB4.

Also update Thunderbolt network driver dependency accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/Makefile             |  2 +-
 drivers/net/Kconfig          |  2 +-
 drivers/thunderbolt/Kconfig  | 11 ++++++-----
 drivers/thunderbolt/Makefile |  2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index aaef17cc6512..31cf17dee252 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -171,7 +171,7 @@ obj-$(CONFIG_POWERCAP)		+= powercap/
 obj-$(CONFIG_MCB)		+= mcb/
 obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
-obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
+obj-$(CONFIG_USB4)		+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
 obj-y				+= hwtracing/intel_th/
 obj-$(CONFIG_STM)		+= hwtracing/stm/
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index df1c7989e13d..f7e6fc6c04b9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -491,7 +491,7 @@ config FUJITSU_ES
 
 config THUNDERBOLT_NET
 	tristate "Networking over Thunderbolt cable"
-	depends on THUNDERBOLT && INET
+	depends on USB4 && INET
 	help
 	  Select this if you want to create network between two
 	  computers over a Thunderbolt cable. The driver supports Apple
diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index fd9adca898ff..f1cc94a27422 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig THUNDERBOLT
-	tristate "Thunderbolt support"
+menuconfig USB4
+	tristate "Unified support for USB4 and Thunderbolt"
 	depends on PCI
 	depends on X86 || COMPILE_TEST
 	select APPLE_PROPERTIES if EFI_STUB && X86
@@ -9,9 +9,10 @@ menuconfig THUNDERBOLT
 	select CRYPTO_HASH
 	select NVMEM
 	help
-	  Thunderbolt Controller driver. This driver is required if you
-	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
-	  with Intel Falcon Ridge or newer.
+	  USB4/Thunderbolt driver. USB4 is the public spec based on
+	  Thunderbolt 3 protocol. This driver is required if you want to
+	  hotplug Thunderbolt and USB4 compliant devices on Apple hardware
+	  or on PCs with Intel Falcon Ridge or newer.
 
 	  To compile this driver a module, choose M here. The module will be
 	  called thunderbolt.
diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index c0b2fd73dfbd..102e9529ee66 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
+obj-${CONFIG_USB4} := thunderbolt.o
 thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
 thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o usb4.o
-- 
2.23.0

