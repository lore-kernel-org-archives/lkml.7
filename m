Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FD220835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Qv7YOz80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfCGIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:09:06 -0500
Received: from forward106p.mail.yandex.net ([77.88.28.109]:40058 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfCGIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:09:05 -0500
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id CA2761C82D32;
        Thu,  7 Mar 2019 11:08:54 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RhRNaqKEsM-8rvChqfX;
        Thu, 07 Mar 2019 11:08:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1551946134;
        bh=3eB4oJg3poxMwSiUe17lYzQQHXESev0uSRV502TCnCw=;
        h=Subject:To:From:Message-Id:Cc:Date;
        b=Qv7YOz80C0E9BanAPQzcg+Rtj1e/7hai2JIqY/OGvL72wwnlfOExojq4EvHjjbLKq
         esQMUDshuks6N1uhMvbLci7KXpusfq/LyseWhFweRM3Gvts4rr5gRou5/R4DWFNVXy
         u8+4cZfOegRj1lh13XOb9J5U0A3bKe/5xZpYQ6Rw=
Authentication-Results: mxback12g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hUPJSHy4bA-8YemflwU;
        Thu, 07 Mar 2019 11:08:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     ibm-acpi@hmh.eng.br
Cc:     dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some machines
Date:   Thu,  7 Mar 2019 16:08:20 +0800
Message-Id: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 726341f2b638..29e835f9368a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -79,6 +79,7 @@
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/power_supply.h>
 #include <sound/core.h>
@@ -4501,11 +4502,80 @@ static void bluetooth_exit(void)
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
+static int __init have_bt_fwbug(void)
+{
+	/* Some AMD based ThinkPads have a firmware bug that calling
+	 * "GBDC" will cause bluetooth on Intel wireless cards blocked
+	 */
+	if (dmi_check_system(bt_fwbug_list)) {
+		if (pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) || \
+		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) || \
+		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL))
+			return 1;
+		else
+			return 0;
+	} else {
+			return 0;
+	}
+}
+
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	int res;
 	int status = 0;
 
+	if (have_bt_fwbug()) {
+		vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
+			FW_BUG "disable bluetooth subdriver for Intel cards\n");
+		return 1;
+	}
+
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 			"initializing bluetooth subdriver\n");
 
-- 
2.20.1

