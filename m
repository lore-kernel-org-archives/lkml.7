Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7347218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260766;
	bh=xNtdWV5kvnQyQWciiYGVCBjNQpls4Yx4jsil5hyLMqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0H5YKKVp6tT4CnbF6rKtIWkE046z7FBHfVQp59XhTOMVOSb3OAlMs/qaXLvB+9ix9
	 Rp4T49WpttMDpCvGGICZCNG4K0xMW82U2K8KLJ1e1qV5ZrDqRRPkaH4W1yNfgHfLjL
	 29dK1ib19uBEzy8Ex/bmUCf0zZVfb4Q3H+TJfb4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfCVNTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfCVLWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:22:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6AA02190A;
        Fri, 22 Mar 2019 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253755;
        bh=xNtdWV5kvnQyQWciiYGVCBjNQpls4Yx4jsil5hyLMqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzaWIsUAgCaCrD85PcUhY3L/PTg/PxLjS+Sf8G+I4JaHq3YVhIBOgDGuOfu6E42Hy
         tstdiXmMAzIRdyETErq8mVCzxWt2xd2YVqjtDLsOq0gFzuCPxABDk16jKaYk4dQNeR
         oTwcMxgRzLAiDPni4fbvruRkeJEfxLyMaIS9+S6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 045/134] sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79
Date:   Fri, 22 Mar 2019 12:14:18 +0100
Message-Id: <20190322111213.156735721@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit b33b7cd6fd86478dd2890a9abeb6f036aa01fdf7 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/sky2.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -46,6 +46,7 @@
 #include <linux/mii.h>
 #include <linux/of_device.h>
 #include <linux/of_net.h>
+#include <linux/dmi.h>
 
 #include <asm/irq.h>
 
@@ -93,7 +94,7 @@ static int copybreak __read_mostly = 128
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
-static int disable_msi = 0;
+static int disable_msi = -1;
 module_param(disable_msi, int, 0);
 MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
 
@@ -4913,6 +4914,24 @@ static const char *sky2_name(u8 chipid,
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
@@ -5024,6 +5043,9 @@ static int sky2_probe(struct pci_dev *pd
 		goto err_out_free_pci;
 	}
 
+	if (disable_msi == -1)
+		disable_msi = !!dmi_check_system(msi_blacklist);
+
 	if (!disable_msi && pci_enable_msi(pdev) == 0) {
 		err = sky2_test_msi(hw);
 		if (err) {


