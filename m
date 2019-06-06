Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC05C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9013A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfFFPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:04:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:04:49 -0400
Received: from orion.localdomain ([77.9.2.22]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6EKU-1hSJJ61Tya-006hc6; Thu, 06 Jun 2019 17:04:36 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2] drivers: scsi: remove unnecessary #ifdef MODULE
Date:   Thu,  6 Jun 2019 17:04:31 +0200
Message-Id: <1559833471-30534-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:S05UD3svuTQRSQq5A0hsQ3kyRKPt3nPXhYfj+2dEeHyTV1PbUr5
 Nbq41ct24TRxMO8CYAr1oBuZg3I7xf6gwBoWthbAu+Y1oMnCLxpjuS6I75VXG9utqw9NGmd
 suEB8slTZtPvt12iW75IFe5hglpOHH2AmI+DjRV9LaKfTBIQxIqGdQu3/tPvrilEgsaSO9o
 mnqExZjL1l59RwRdKPsTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eIv+RsL1Bog=:vH344YMgr+N0/OansCbK4u
 9zGAL55HxDTthVLbjdZWfpKyYsga4pkHOMrYtj2q11Mqwu4UsqGR1K71oXeKhE69e/v8bIprG
 f4jUYkWbqD8jfiqgNubRXpn8YF/xBCijJxIZJ7+ldugK3j9TnWSagHsAoNOXRagRUiVOO5WyU
 fSGvWIGmNa/pZqSZ225yy/6G0SXb85ZKq6+cUNhKo13qPZJschCJ3NEumXMJU9jfBWXtZZ+Ty
 1UqV2dDdaA0NiaSr1bGIABpcj3rG/FVA/gFAQ+toyhvbUGPnuHOVT+eg7VlDZXYqW1GXuwRhb
 NUg6eJIxgqnsv8I3+p7/T+UAH9uxjhDf0RDtK9OmWGOnT7Kj5NE4GGesKPlFnCGmY3ZXGUow6
 pNT/2DMI1htcZsF/bW5qd5GPRl/RV/13iIDCIAg6PeKk3hXHJdkpGNwK7vIJaPFcGSycmMWz9
 4FwLzj/TiOR/3qhbbPNhWNzXVQzhq8wpVaxNqPQRefbJv2mm04IW7DxZzm22AZ9QYzvC5aZy9
 3gGTgdQazHcfaBJ2mHctTRIQ4MMiM58LJs9JGtimuKKQhVG7ikjKF4cCYAwGOu7HE0Y0hkvcH
 gQGgvdVT4koUihW7Moo/oTNqHJaAi8Gqy1CZ6rdvYlUnEtNsz85Jo2HgWLUX3ke3uba0uCzs1
 V3pZCadxMv2clZkJg1oNyaTUkL2kQihc4lF5RbA+7OHN3kWowqJCwMlJnWIR4qPvKaVdax179
 poRu/ygzn0HKhghMeLIbUgV5qb2c9TZlZl0gVzHA3XFoiGCe5TJ44aCkaDs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
so the extra check here is not necessary.

Changes v2:
    * make dptids const to fix warning on unused variable

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/scsi/BusLogic.c | 2 --
 drivers/scsi/dpt_i2o.c  | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index e41e51f..68cc68b 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3893,7 +3893,6 @@ static void __exit blogic_exit(void)
 
 __setup("BusLogic=", blogic_setup);
 
-#ifdef MODULE
 /*static struct pci_device_id blogic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -3909,7 +3908,6 @@ static void __exit blogic_exit(void)
 	{PCI_DEVICE(PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT)},
 	{0, },
 };
-#endif
 MODULE_DEVICE_TABLE(pci, blogic_pci_tbl);
 
 module_init(blogic_init);
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index abc74fd..162d56a 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -177,14 +177,11 @@ static u8 adpt_read_blink_led(adpt_hba* host)
  *============================================================================
  */
 
-#ifdef MODULE
-static struct pci_device_id dptids[] = {
+static const struct pci_device_id dptids[] = {
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ PCI_DPT_VENDOR_ID, PCI_DPT_RAPTOR_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ 0, }
 };
-#endif
-
 MODULE_DEVICE_TABLE(pci,dptids);
 
 static int adpt_detect(struct scsi_host_template* sht)
-- 
1.9.1

