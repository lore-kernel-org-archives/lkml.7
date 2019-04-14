Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AEAC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA11820870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfDNSra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:47:30 -0400
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:42088 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDNSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:47:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id D855B127;
        Sun, 14 Apr 2019 20:38:29 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TYynDNjD6clr; Sun, 14 Apr 2019 20:38:23 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:2158:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 63E5312A;
        Sun, 14 Apr 2019 20:38:21 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rahul Tank <rahult@marvell.com>,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH 1/1] Bluetooth: btmrvl: add support for SD8987 chipset
Date:   Sun, 14 Apr 2019 20:38:14 +0200
Message-Id: <20190414183814.7620-2-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414183814.7620-1-tszucs@protonmail.ch>
References: <20190414183814.7620-1-tszucs@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Marvell 88W8987 chipset with SDIO interface.
Register offsets and supported feature flags are updated. The corresponding
firmware image file shall be "mrvl/sd8987_uapsta.bin".

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 drivers/bluetooth/Kconfig       |  4 ++--
 drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index b0f9a20401d6..b9c34ff9a0d3 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -336,7 +336,7 @@ config BT_MRVL
 	  The core driver to support Marvell Bluetooth devices.
 
 	  This driver is required if you want to support
-	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897/8977/8997.
+	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897/8977/8987/8997.
 
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
@@ -350,7 +350,7 @@ config BT_MRVL_SDIO
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
 
 	  This driver is required if you want to use Marvell Bluetooth
-	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD8897/SD8977/SD8997
+	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD8897/SD8977/SD8987/SD8997
 	  chipsets are supported.
 
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 047b75ce1deb..0f3a020703ab 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -235,6 +235,29 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8977 = {
 	.fw_dump_end = 0xf8,
 };
 
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8987 = {
+	.cfg = 0x00,
+	.host_int_mask = 0x08,
+	.host_intstatus = 0x0c,
+	.card_status = 0x5c,
+	.sq_read_base_addr_a0 = 0xf8,
+	.sq_read_base_addr_a1 = 0xf9,
+	.card_revision = 0xc8,
+	.card_fw_status0 = 0xe8,
+	.card_fw_status1 = 0xe9,
+	.card_rx_len = 0xea,
+	.card_rx_unit = 0xeb,
+	.io_port_0 = 0xe4,
+	.io_port_1 = 0xe5,
+	.io_port_2 = 0xe6,
+	.int_read_to_clear = true,
+	.host_int_rsr = 0x04,
+	.card_misc_cfg = 0xd8,
+	.fw_dump_ctrl = 0xf0,
+	.fw_dump_start = 0xf1,
+	.fw_dump_end = 0xf8,
+};
+
 static const struct btmrvl_sdio_card_reg btmrvl_reg_8997 = {
 	.cfg = 0x00,
 	.host_int_mask = 0x08,
@@ -312,6 +335,15 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 = {
 	.supports_fw_dump = true,
 };
 
+static const struct btmrvl_sdio_device btmrvl_sdio_sd8987 = {
+	.helper		= NULL,
+	.firmware	= "mrvl/sd8987_uapsta.bin",
+	.reg		= &btmrvl_reg_8987,
+	.support_pscan_win_report = true,
+	.sd_blksz_fw_dl	= 256,
+	.supports_fw_dump = true,
+};
+
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
 	.helper         = NULL,
 	.firmware       = "mrvl/sd8997_uapsta.bin",
@@ -343,6 +375,9 @@ static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8977 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9146),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8977 },
+	/* Marvell SD8987 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x914A),
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8987 },
 	/* Marvell SD8997 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9142),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8997 },
@@ -1797,4 +1832,5 @@ MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8977_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sd8987_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8997_uapsta.bin");
-- 
2.11.0

