Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B989C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB15F21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCDHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:00:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34279 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:00:16 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h0ha6-0006LC-PX; Mon, 04 Mar 2019 07:00:11 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mlindner@marvell.com, stephen@networkplumber.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79
Date:   Mon,  4 Mar 2019 15:00:03 +0800
Message-Id: <20190304070003.30140-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sky2 chips fire IRQ after S3, before the driver is fully resumed:
[ 686.804877] do_IRQ: 1.37 No irq handler for vector

This is likely a platform bug that device isn't fully quiesced during
S3. Use MSI-X, maskable MSI or INTx can prevent this issue from
happening.

Since MSI-X and maskable MSI are not supported by this device, fallback
to use INTx on affected platforms.

BugLink: https://bugs.launchpad.net/bugs/1807259
BugLink: https://bugs.launchpad.net/bugs/1809843
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/marvell/sky2.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 57727fe1501e..8b3495ee2b6e 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -46,6 +46,7 @@
 #include <linux/mii.h>
 #include <linux/of_device.h>
 #include <linux/of_net.h>
+#include <linux/dmi.h>
 
 #include <asm/irq.h>
 
@@ -93,7 +94,7 @@ static int copybreak __read_mostly = 128;
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
-static int disable_msi = 0;
+static int disable_msi = -1;
 module_param(disable_msi, int, 0);
 MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
 
@@ -4917,6 +4918,24 @@ static const char *sky2_name(u8 chipid, char *buf, int sz)
 	return buf;
 }
 
+static const struct dmi_system_id msi_blacklist[] = {
+	{
+		.ident = "Dell Inspiron 1545",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1545"),
+		},
+	},
+	{
+		.ident = "Gateway P-79",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gateway"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P-79"),
+		},
+	},
+	{}
+};
+
 static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *dev, *dev1;
@@ -5028,6 +5047,9 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_pci;
 	}
 
+	if (disable_msi == -1)
+		disable_msi = !!dmi_check_system(msi_blacklist);
+
 	if (!disable_msi && pci_enable_msi(pdev) == 0) {
 		err = sky2_test_msi(hw);
 		if (err) {
-- 
2.17.1

