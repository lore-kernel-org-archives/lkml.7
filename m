Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCCF20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920193;
	bh=EwnuNN/iKp732s9E1fnCIgPnDf11zkRNldXEtvvaLrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dj53FD0g2SDX0ajjVthxci3o+SxuOc4oH7jLMqDcY4tJLn2cNgr75z6L8uRE6f00Q
	 raUzaigtFZhyS0L777tJKwoEduzfXgxIdqTpIPgIUfIgPWNK9XmnPaTG2JTef4fIxL
	 P+LnyKruxP/0w/QEK0f5BgZYrST0b0lbQKV/SPCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfEOLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbfEOLcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:32:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0516206BF;
        Wed, 15 May 2019 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919955;
        bh=EwnuNN/iKp732s9E1fnCIgPnDf11zkRNldXEtvvaLrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTlX1Ctbm9rGQqgRfEyb9hW5SBMKggwnrY9IiFN+TSYTNRsiCpzSV9VesyBjcrtVh
         AIyO5IWzs0RtkFQiUhNpexSACX3pfH448RFCc+z/gW2x8wopqkgbvGaY9+APIvkP+R
         ztBhUD2yHJpWcI1AUzzuawrwVwol0egQiFAMFXz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.1 02/46] platform/x86: thinkpad_acpi: Disable Bluetooth for some machines
Date:   Wed, 15 May 2019 12:56:26 +0200
Message-Id: <20190515090618.166336036@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit f7db839fccf087664e5587966220821289b6a9cb upstream.

Some AMD based ThinkPads have a firmware bug that calling
"GBDC" will cause Bluetooth on Intel wireless cards blocked.

Probe these models by DMI match and disable Bluetooth subdriver
if specified Intel wireless card exist.

Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/thinkpad_acpi.c |   72 ++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

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
@@ -4501,6 +4501,74 @@ static void bluetooth_exit(void)
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
@@ -4513,7 +4581,7 @@ static int __init bluetooth_init(struct
 
 	/* bluetooth not supported on 570, 600e/x, 770e, 770x, A21e, A2xm/p,
 	   G4x, R30, R31, R40e, R50e, T20-22, X20-21 */
-	tp_features.bluetooth = hkey_handle &&
+	tp_features.bluetooth = !have_bt_fwbug() && hkey_handle &&
 	    acpi_evalf(hkey_handle, &status, "GBDC", "qd");
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,


