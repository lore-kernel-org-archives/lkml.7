Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08534C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD4217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfDWOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:34:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:54833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfDWOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:34:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP; 23 Apr 2019 07:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136653911"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 07:34:15 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] EDAC, altera: Add Stratix10 SDMMC support
Date:   Tue, 23 Apr 2019 09:36:36 -0500
Message-Id: <1556030197-24534-4-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
References: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Addition of SDMMC EDAC for Stratix10 which has IRQ
differences from Arria10. Update comment accordingly.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index b7bc8f020df8..c2e693e34d43 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1583,8 +1583,12 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	dci->mod_name = ecc_name;
 	dci->dev_name = ecc_name;
 
-	/* Update the IRQs for PortB */
+	/* Update the PortB IRQs - A10 has 4, S10 has 2, Index accordingly */
+#ifdef CONFIG_ARCH_STRATIX10
+	altdev->sb_irq = irq_of_parse_and_map(np, 1);
+#else
 	altdev->sb_irq = irq_of_parse_and_map(np, 2);
+#endif
 	if (!altdev->sb_irq) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB SBIRQ alloc\n");
 		rc = -ENODEV;
@@ -1599,6 +1603,15 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		goto err_release_group_1;
 	}
 
+#ifdef CONFIG_ARCH_STRATIX10
+	/* Use IRQ to determine SError origin instead of assigning IRQ */
+	rc = of_property_read_u32_index(np, "interrupts", 1, &altdev->db_irq);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Error PortB DBIRQ alloc\n");
+		goto err_release_group_1;
+	}
+#else
 	altdev->db_irq = irq_of_parse_and_map(np, 3);
 	if (!altdev->db_irq) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB DBIRQ alloc\n");
@@ -1613,6 +1626,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		edac_printk(KERN_ERR, EDAC_DEVICE, "PortB DBERR IRQ error\n");
 		goto err_release_group_1;
 	}
+#endif
 
 	rc = edac_device_add_device(dci);
 	if (rc) {
-- 
2.7.4

