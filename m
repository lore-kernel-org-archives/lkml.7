Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3E920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kuPpIG4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCGJiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:38:08 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:40988 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfCGJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:38:07 -0500
Received: from mxback19j.mail.yandex.net (mxback19j.mail.yandex.net [IPv6:2a02:6b8:0:1619::95])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 1444A50E2A5B;
        Thu,  7 Mar 2019 12:38:03 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback19j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ODLEO4rUbm-c2i8SCPi;
        Thu, 07 Mar 2019 12:38:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1551951483;
        bh=J2aIWsYAPfKj8ipD9I2ZxtXmgv7R5iwmQEBtwJ5dzjc=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=kuPpIG4wV7cNivemZsA/u64ERlelQP69T+yE4px1kVUIsCmEqBp0irh22E5Oxt8ff
         EI86KQCctCeE6STG1wUbx1qGKWNtY5EcmNr1LCnQBaSdSJpdF+NCJZ9LFFger3XVyC
         nrwPVM4ylNJXdssaguynY0cv7NPWw7he/8C5DWZU=
Authentication-Results: mxback19j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id wfxfNBI23y-boemGoRT;
        Thu, 07 Mar 2019 12:37:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     ibm-acpi@hmh.eng.br
Cc:     dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: disable bluetooth for some machines
Date:   Thu,  7 Mar 2019 17:37:16 +0800
Message-Id: <20190307093716.3439-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some AMD based ThinkPads have a firmware bug that calling
"GBDC" will cause bluetooth on Intel wireless cards blocked.

Probe these models by DMI match and disable bluetooth subdriver
if specified Intel wireless card exist.

Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 73 +++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 726341f2b638..2e24ee42a3c6 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -79,7 +79,7 @@
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 #include <linux/acpi.h>
-#include <linux/pci_ids.h>
+#include <linux/pci.h>
 #include <linux/power_supply.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -4501,11 +4501,80 @@ static void bluetooth_exit(void)
 	bluetooth_shutdown();
 }
 
+static const struct dmi_system_id bt_fwbug_list[] __initconst = {
+	{
+		.ident = "ThinkPad E485",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20KU"),
+		},
+	},
+	{
+		.ident = "ThinkPad E585",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20KV"),
+		},
+	},
+	{
+		.ident = "ThinkPad A285 - 20MW",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20MW"),
+		},
+	},
+	{
+		.ident = "ThinkPad A285 - 20MX",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20MX"),
+		},
+	},
+	{
+		.ident = "ThinkPad A485 - 20MU",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20MU"),
+		},
+	},
+	{
+		.ident = "ThinkPad A485 - 20MV",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "20MV"),
+		},
+	},
+	{}
+};
+
+static const struct pci_device_id fwbug_cards_ids[] __initconst = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24FD) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2526) },
+	{}
+};
+
+
+static int __init have_bt_fwbug(void)
+{
+	/*
+	 * Some AMD based ThinkPads have a firmware bug that calling
+	 * "GBDC" will cause bluetooth on Intel wireless cards blocked
+	 */
+	if (dmi_check_system(bt_fwbug_list) && pci_dev_present(fwbug_cards_ids)) {
+		vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+			FW_BUG "disable bluetooth subdriver for Intel cards\n");
+		return 1;
+	} else
+		return 0;
+}
+
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	int res;
 	int status = 0;
 
+
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 			"initializing bluetooth subdriver\n");
 
@@ -4513,7 +4582,7 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
-	tp_features.bluetooth = hkey_handle &&
+	tp_features.bluetooth = !have_bt_fwbug() && hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GBDC", "qd");
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
-- 
2.20.1

