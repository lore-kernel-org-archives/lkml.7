Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB5C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC420830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDCP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:28:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48758 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:28:56 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549954800"; 
   d="scan'208";a="30743667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 08:28:55 -0700
Received: from soft-dev3.microsemi.net (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Wed, 3 Apr 2019 08:28:54 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
        <ralf@linux-mips.org>, <paul.burton@mips.com>, <jhogan@kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next] MIPS: generic: Add switchdev, pinctrl and fit to ocelot_defconfig
Date:   Wed, 3 Apr 2019 17:27:36 +0200
Message-ID: <1554305256-32702-1-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the configuration were not selected by default anymore, therefore
enable them again. Also remove some configs which are used for MSCC Ocelot.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/mips/configs/generic/board-ocelot.config | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index f607888..3215741 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -1,6 +1,10 @@
 # require CONFIG_CPU_MIPS32_R2=y
 
 CONFIG_LEGACY_BOARD_OCELOT=y
+CONFIG_FIT_IMAGE_FDT_OCELOT=y
+
+CONFIG_BRIDGE=y
+CONFIG_GENERIC_PHY=y
 
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -19,6 +23,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 
 CONFIG_NETDEVICES=y
+CONFIG_NET_SWITCHDEV=y
+CONFIG_NET_DSA=y
 CONFIG_MSCC_OCELOT_SWITCH=y
 CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
 CONFIG_MDIO_MSCC_MIIM=y
@@ -35,9 +41,22 @@ CONFIG_SPI_DESIGNWARE=y
 CONFIG_SPI_DW_MMIO=y
 CONFIG_SPI_SPIDEV=y
 
+CONFIG_PINCTRL_OCELOT=y
+
 CONFIG_GPIO_SYSFS=y
 
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_OCELOT_RESET=y
 
 CONFIG_MAGIC_SYSRQ=y
+
+CONFIG_MISC_FILESYSTEMS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=16000
+
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_SCSI is not set
-- 
2.7.4

